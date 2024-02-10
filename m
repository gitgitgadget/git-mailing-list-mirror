Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF86364AC
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551383; cv=none; b=XPNEapKHco3gO9jhxWedymILH7cqplSB7FhzyOBW7L8vxKlHYGYlOPScRjZLXputU4/fTUftlflUSnQ3fPpliAHW91DgdwyuX/p8WNZrLBGmkqodxfU4JxItUzGk/3i6f3fLZIqdqz0G4rF3GwHjRBG3Iu6cBaZD42pKH780O/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551383; c=relaxed/simple;
	bh=+So2jC1Z+xiZ+YxLuFIZyvIwXgVj+AgRbugqNPmFSDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMObXGcmSrff81L39Uw4eWHxcYNFVEhUXWxwvz3FgJrU5THtInktArDG2uLCKk6M1sJFrlfvENcdRHw2AXMXWfWTxkKImyps2wJnOY6xtjDW9IgI1HsmCLG9K+pF7+JYEmQrbZCl/3EXumsEUgUMu+Vw9CSeLO5UXeWCis7hwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di05Qup2; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di05Qup2"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e2d8a21b79so80010a34.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551380; x=1708156180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg+xHvTghARxoCXFW8x3NA/zpr3camheUwRptD8k98E=;
        b=di05Qup2wuyygMh6WY+kwsMKD2QcDv9S0KVRVZgTexcm5eMGQcDTTpMxKnrxYx8XMK
         lpLRnJRSnaTG0yKrRWfG3x8jy+q1VnHf9DM8tkWIgWiz9kYE9QiUcaPKOc8UXMq6S49p
         Wd1obxS3NVd908ap/AgvhMH3qEAMKk8O4NyDhMWByulxsN91be//bV9gfMSQpt3u0QSW
         T+/3fc3KnvumFK5+lLff0Spiza59ehXZF0JqOYDd8D3rGVHal9FNZp9wbaAB5kSn0D7q
         R3zkH6NJWI42sb4hpOMIDwsNDysX3iFZ5c3lpqr++jYnA5YmqLS5RBOyvfa59eo9XRea
         KNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551380; x=1708156180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lg+xHvTghARxoCXFW8x3NA/zpr3camheUwRptD8k98E=;
        b=rSBCA6pOg5NBRn/dTP8AJDdPzbaJPao0VGhr0AGK09Zl+5qrjJCJW/62OWs+ntxvh1
         2LFtgN+9pQAoG/O4F/XIaUAN4gxF4DNe+zgguap6W2eZWa9vPA2DBhfzJDylD+rlfJej
         KdeiJdG2j0D5n4728kTsldEg8cjeHx72pnKXkyYBHVZlnazaOoULwlzmQmlJPwq2lM7+
         0ATlSR2WJupJ9exdopXpl5CYnvrICxWDt+fUmg1x9duZBu6RdnuH8ID5iNx4qk/vAelu
         lSKuW6DjngUjlzbQ7VEnORikElwl+Dx+9+7hcWl3YRNu1KCCJKI7+/khipjN/CFSNSlJ
         Yibw==
X-Gm-Message-State: AOJu0Yw1Rp7Ny5u+8tq9P4S9BTFvXCvX3vt0mYnh26snjKFWzqwDZnuL
	KQUb2P2eOC2BliPWQBa/EGToEWXDh8mex0purqzY4WqDyC3JKMXF9KSdwo66m9U=
X-Google-Smtp-Source: AGHT+IGoY70aHB2WviSrW47tpKvoyBqAS9sWDPwHY5p4b5xqp65a4nMdHoLlQvIBKENHgHMWfIsMSw==
X-Received: by 2002:a05:6870:200c:b0:219:3dae:4605 with SMTP id o12-20020a056870200c00b002193dae4605mr1493095oab.32.1707551380416;
        Fri, 09 Feb 2024 23:49:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWR4AWnnVhSUAmpfwoGXZkiTpeNU1M0dD+TAWCTuqMdNkzm5eFSnnqQlab+DevVRu4SC6jgHj1c/BldQGDEwyLwGVvJVoG6LpXZ2qme4F4+Kc00L096AuaRBe4DiWfe3MwBEDy9+gmmXBxDEV/7APo6m+ISvEwLwzKA+hu/mLaW
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:39 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 6/8] cherry-pick: decouple `--allow-empty` and `--keep-redundant-commits`
Date: Sat, 10 Feb 2024 01:43:54 -0600
Message-ID: <20240210074859.552497-7-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noted in the git-cherry-pick(1) docs, `--keep-redundant-commits`
implies `--allow-empty`, despite the two having distinct,
non-overlapping meanings:

- `allow_empty` refers specifically to commits which start empty, as
  indicated by the documentation for `--allow-empty` within
  git-cherry-pick(1):

  "Note also, that use of this option only keeps commits that were
  initially empty (i.e. the commit recorded the same tree as its
  parent). Commits which are made empty due to a previous commit are
  dropped. To force the inclusion of those commits use
  --keep-redundant-commits."

- `keep_redundant_commits` refers specifically to commits that do not
  start empty, but become empty due to the content already existing in
  the target history. This is indicated by the documentation for
  `--keep-redundant-commits` within git-cherry-pick(1):

  "If a commit being cherry picked duplicates a commit already in the
  current history, it will become empty. By default these redundant
  commits cause cherry-pick to stop so the user can examine the commit.
  This option overrides that behavior and creates an empty commit
  object. Implies --allow-empty."

This implication of `--allow-empty` therefore seems incorrect: One
should be able to keep a commit that becomes empty without also being
forced to pick commits that start as empty. However, the following
series of commands results in both the commit that became empty and the
commit that started empty being picked, despite only
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

Do not imply `--allow-empty` when using `--keep-redundant-commits` with
git-cherry-pick(1).

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

This is the second half of the first commit[1] in v1, which has now been
split up.

This commit proposes a breaking change, albeit one that seems correct
and relatively minor to me. If this change is deemed too controversial,
I am prepared to drop it from the series. See Junio's[2] and
Phillip's[3] comments on v1 for additional context.

[1]: https://lore.kernel.org/git/20240119060721.3734775-2-brianmlyles@gmail.com/
[2]: https://lore.kernel.org/git/xmqqy1cfnca7.fsf@gitster.g/
[3]: https://lore.kernel.org/git/8ff4650c-f84f-41bd-a46c-3b845ff29b70@gmail.com/

 Documentation/git-cherry-pick.txt | 10 +++++++---
 builtin/revert.c                  |  4 ----
 t/t3505-cherry-pick-empty.sh      |  6 ++++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fdcad3d200..c88bb88822 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -131,8 +131,8 @@ effect to your index in a row.
 	even without this option.  Note also, that use of this option only
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
-	previous commit are dropped.  To force the inclusion of those commits
-	use `--keep-redundant-commits`.
+	previous commit will cause the cherry-pick to fail.  To force the
+	inclusion of those commits, use `--keep-redundant-commits`.

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
index 89821bab95..d83977e36e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -134,10 +134,6 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;

-	/* implies allow_empty */
-	if (opts->keep_redundant_commits)
-		opts->allow_empty = 1;
-
 	if (cleanup_arg) {
 		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
 		opts->explicit_cleanup = 1;
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index eba3c38d5a..2709cfc677 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -59,6 +59,12 @@ test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
 	test_must_fail git cherry-pick empty-change-branch
 '

+test_expect_success 'cherry pick an empty non-ff commit with --keep-redundant-commits' '
+	git checkout main &&
+	test_must_fail git cherry-pick --keep-redundant-commits empty-change-branch 2>output &&
+	test_grep "The previous cherry-pick is now empty" output
+'
+
 test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
 	git checkout main &&
 	git cherry-pick --allow-empty empty-change-branch
-- 
2.43.0

