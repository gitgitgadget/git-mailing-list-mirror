Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70694C69
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644810; cv=none; b=Zm/bx6gFeR4NYwwvjay2S4vKd7YqkUgkSneWsis9bpZGC+M7QO1lFYMiHnN5O0RP7kVw+bHg6yPYJbJFOOcEuwPDBnaBe5Th/cskXioNDcnAQgyyLplLHNCV+ytsZ39w2HlU7Ru1WOpcQ8v3scnO0VtdjuFlG3h2spCv8NHBwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644810; c=relaxed/simple;
	bh=3C0GPDbnq5dE++Em+IJmuD5rMhsHwpcb2YEIoV/YQ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvttnD5Kmgn5EfkPk2HeDbmRkSnG8zfgPjG9bveneye1o9MlOb2Ydic/k3kvf9YabDxM9rKofD1MeLEpd+ZOXlctYNYNva+F42maWFj9+H7vHjW1VP5LE30LU7giqHVI1/iOx6cbq3/Hbl8Gf5ULIFLCo4movMkhT8mh0eVxYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERCvlBbb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERCvlBbb"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680b1335af6so13327576d6.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705644806; x=1706249606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rllxRFLRLTnRyyZHP8c1v23BDfjgsiBNyhtdair+Ffg=;
        b=ERCvlBbbm/jOxbvsTxMupWoUvn5Q+s+/FmJjKCjCA4JykmTJCNW5mX/XRtLHrxZCz8
         FN3vp68+RfjDsxhkaLR6naPX9uHB625P7ODrmZgq+nIHc3m9QMfeNvjmrOOEoUj6loWF
         U57yBbBrP1XRXDXB+lf86dqXCPM0KimHmLB9voK0WJdVqjigBumZyteIUjUG3XpBkrBJ
         b6oQTuLfceVk6/uORVpqi7vmNu1mOnkEPKKVw9VjhMO4oMjPaNmmne6KV42bXKHJGUHg
         vjlssZvceCDWB5W27oJyovQnJ9czmuk3BZwEx/f2Hkm9lBWtH3V0FPFe69YbvxxeWPzP
         3B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705644806; x=1706249606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rllxRFLRLTnRyyZHP8c1v23BDfjgsiBNyhtdair+Ffg=;
        b=AJWjrSrA0Z0J3P6LUloVaB2+rtaCwz7HURTb7JcWyXwkDf2qyOrCmqJ+zRo5q3r6T8
         PRCPLcNkMJm5sAXVyJWOB54A24VDCOKpkkeUWA8dWEzR3AQ0DL9PH8Ui7IxcZYMeDK9W
         wnOrWueLUbFQ0D2+sxpHVSZziEuhVlpjM/Me/4BSIi5hZjQ3CEC6cakbHixPLM7mt7cx
         KS59mfnRV2rfEMhznZQiES0HG7U4MNm2R24NftZyF2kcG2tvIZgYYeAOAXfSvSxrIqnW
         AcAr6R8eK1I+zMdOSygdmydNVlY1GGjf7aMBJOsQD0YGh25B1Pxt0VhpafZYKvNdAw/n
         JVIg==
X-Gm-Message-State: AOJu0YysWFLVRyhWKEaMDO9o+UjJO4dvAEU72lQ9/t2rrhFICD/ceFFg
	asWavz//YRSxu0ljE1c5+LIG97fdN/arPir47YWO03mk/6uVTObi/e2+F7mV
X-Google-Smtp-Source: AGHT+IG+Vt6GnLiFC77MKIOttX+AEbhOOiCOhV6pQpIE70R7WVEJgVIvb0FpqJJdGpbZVMQXe3OaAw==
X-Received: by 2002:a05:6214:2246:b0:681:6991:34f0 with SMTP id c6-20020a056214224600b00681699134f0mr832031qvc.7.1705644806469;
        Thu, 18 Jan 2024 22:13:26 -0800 (PST)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id op23-20020a056214459700b0068189a17598sm1365062qvb.72.2024.01.18.22.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:13:26 -0800 (PST)
From: brianmlyles@gmail.com
To: git@vger.kernel.org
Cc: me@ttaylorr.com,
	newren@gmail.com,
	Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant commit options
Date: Thu, 18 Jan 2024 23:59:17 -0600
Message-ID: <20240119060721.3734775-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Lyles <brianmlyles@gmail.com>

Previously, a consumer of the sequencer that wishes to take advantage of
either the `keep_redundant_commits` or `drop_redundant_commits` feature
must also specify `allow_empty`.

The only consumer of `drop_redundant_commits` is `git-rebase`, which
already allows empty commits by default and simply always enables
`allow_empty`. `keep_redundant_commits` was also consumed by
`git-cherry-pick`, which had to specify `allow-empty` when
`keep_redundant_commits` was specified in order for the sequencer's
`allow_empty()` to actually respect `keep_redundant_commits`.

The latter is an interesting case: As noted in the docs, this means that
`--keep-redundant-commits` implies `--allow-empty`, despite the two
having distinct, non-overlapping meanings:

- `allow_empty` refers specifically to commits which start empty, as
  indicated by the documentation for `--allow-empty` within
  `git-cherry-pick`:

  "Note also, that use of this option only keeps commits that were
  initially empty (i.e. the commit recorded the same tree as its
  parent). Commits which are made empty due to a previous commit are
  dropped. To force the inclusion of those commits use
  --keep-redundant-commits."

- `keep_redundant_commits` refers specifically to commits that do not
  start empty, but become empty due to the content already existing in
  the target history. This is indicated by the documentation for
  `--keep-redundant-commits` within `git-cherry-pick`:

  "If a commit being cherry picked duplicates a commit already in the
  current history, it will become empty. By default these redundant
  commits cause cherry-pick to stop so the user can examine the commit.
  This option overrides that behavior and creates an empty commit
  object. Implies --allow-empty."

This implication of `--allow-empty` therefore seems incorrect: One
should be able to keep a commit that becomes empty without also being
forced to pick commits that start as empty. However, today, the
following series of commands would result in both the commit that became
empty and the commit that started empty being picked despite only
`--keep-redundant-commits` being specified:

    git init
    echo "a" >test
    git add test
    git commit -m "Initial commit"
    echo "b" >test
    git commit -am "a -> b"
    git commit --allow-empty -m "empty"
    git cherry-pick --keep-redundant-commits HEAD^ HEAD

The same cherry-pick with `--allow-empty` would fail on the redundant
commit, and with neither option would fail on the empty commit.

In a future commit, an `--empty` option will be added to
`git-cherry-pick`, meaning that `drop_redundant_commits` will be
available in that command. For that to be possible with the current
implementation of the sequencer's `allow_empty()`, `git-cherry-pick`
would need to specify `allow_empty` with `drop_redundant_commits` as
well, which is an even less intuitive implication of `--allow-empty`: in
order to prevent redundant commits automatically, initially-empty
commits would need to be kept automatically.

Instead, this commit rewrites the `allow_empty()` logic to remove the
over-arching requirement that `allow_empty` be specified in order to
reach any of the keep/drop behaviors. Only if the commit was originally
empty will `allow_empty` have an effect.

For some amount of backwards compatibility with the existing code and
tests, I have opted to preserve the behavior of returning 0 when:

- `allow_empty` is specified, and
- either `is_index_unchanged` or `is_original_commit_empty` indicates an
  error

This is primarily out of caution -- I am not positive what downstream
impacts this might have.

Note that this commit is a breaking change: `--keep-redundant-commits`
will no longer imply `--allow-empty`. It would be possible to maintain
the current behavior of `--keep-redundant-commits` implying
`--allow-empty` if it were needed to avoid a breaking change, but I
believe that decoupling them entirely is the correct behavior.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Disclaimer: This is my first contribution to the git project, and thus
my first attempt at submitting a patch via `git-send-email`. It is also
the first time I've touched worked in C in over a decade, and I really
didn't work with it much before that either. I welcome any and all
feedback on what I may have gotten wrong regarding the patch submission
process, the code changes, or my commit messages.

This is the first in a series of commits that aims to introduce an
`--empty` option to `git-cherry-pick` that provides the same flexibility
as the `--empty` options for `git-rebase` and `git-am`, as well as
improve the consistency in the values and documentation for this option
across the three commands.

The main thing that may be controversial with this particular commit is
that I am proposing a breaking change. As described in the above
message, I do not think that it makes sense to tie `--allow-empty` and
`--keep-redundant-commits` together since they appear to be intended to
work with different types of empty commits. That being said, if it is
deemed unacceptable to make this breaking change, we can consider an
alternative approach where we maintain the behavior of
`--keep-redundant-commits` implying `--allow-empty`, while preventing
the need for the future `--empty=drop` to have that same implication.

 Documentation/git-cherry-pick.txt | 10 +++++++---
 builtin/revert.c                  |  4 ----
 sequencer.c                       | 18 ++++++++++--------
 t/t3505-cherry-pick-empty.sh      |  5 +++++
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fdcad3d200..806295a730 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -131,8 +131,8 @@ effect to your index in a row.
 	even without this option.  Note also, that use of this option only
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
-	previous commit are dropped.  To force the inclusion of those commits
-	use `--keep-redundant-commits`.
+	previous commit will cause the cherry-pick to fail.  To force the
+	inclusion of those commits use `--keep-redundant-commits`.
 
 --allow-empty-message::
 	By default, cherry-picking a commit with an empty message will fail.
@@ -144,7 +144,11 @@ effect to your index in a row.
 	current history, it will become empty.  By default these
 	redundant commits cause `cherry-pick` to stop so the user can
 	examine the commit. This option overrides that behavior and
-	creates an empty commit object.  Implies `--allow-empty`.
+	creates an empty commit object. Note that use of this option only
+	results in an empty commit when the commit was not initially empty,
+	but rather became empty due to a previous commit. Commits that were
+	initially empty will cause the cherry-pick to fail. To force the
+	inclusion of those commits use `--allow-empty`.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index e6f9a1ad26..b2cfde7a87 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -136,10 +136,6 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	/* implies allow_empty */
-	if (opts->keep_redundant_commits)
-		opts->allow_empty = 1;
-
 	if (cleanup_arg) {
 		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
 		opts->explicit_cleanup = 1;
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..582bde8d46 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1739,22 +1739,24 @@ static int allow_empty(struct repository *r,
 	 *
 	 * (4) we allow both.
 	 */
-	if (!opts->allow_empty)
-		return 0; /* let "git commit" barf as necessary */
-
 	index_unchanged = is_index_unchanged(r);
-	if (index_unchanged < 0)
+	if (index_unchanged < 0) {
+		if (!opts->allow_empty)
+			return 0;
 		return index_unchanged;
+	}
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */
 
-	if (opts->keep_redundant_commits)
-		return 1;
-
 	originally_empty = is_original_commit_empty(commit);
-	if (originally_empty < 0)
+	if (originally_empty < 0) {
+		if (!opts->allow_empty)
+			return 0;
 		return originally_empty;
+	}
 	if (originally_empty)
+		return opts->allow_empty;
+	else if (opts->keep_redundant_commits)
 		return 1;
 	else if (opts->drop_redundant_commits)
 		return 2;
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index eba3c38d5a..6adfd25351 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -59,6 +59,11 @@ test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
 	test_must_fail git cherry-pick empty-change-branch
 '
 
+test_expect_success 'cherry pick an empty non-ff commit with --keep-redundant-commits' '
+	git checkout main &&
+	test_must_fail git cherry-pick --keep-redundant-commits empty-change-branch
+'
+
 test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
 	git checkout main &&
 	git cherry-pick --allow-empty empty-change-branch
-- 
2.41.0

