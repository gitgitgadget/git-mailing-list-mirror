Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581757;
	b=Eu0wfE+bv8kfV3Bq64qfwhNZlxiWWG0nhNQbnj5UHvKTpibr/V6ynqSRHpX7NfI1Fpo7
	 oOPXkAxfaZgYjircYc25hGTvYJokgUEChH8mSq2L5Y8mmHsbGHIy7S8nqy9mhpkYpKBeT
	 1y4iHHFN4llHjBeRjEoKTNAWM4Zrcw3JWmcb+QRkCQD7U99ernVFloVeUaIOU1fwT/eQs
	 uQzfX177aUTd8yRxCMxvkFc9uDKfq1BRwym1oaKNyuS3NlZKJIjIlsljctlPBQzPJ3RM9
	 KUGnR4a31aLSa2FgeSWFgMP8D2gM0sjInGOhE+TTxQmj7hCUhhR1hzmamqNbm9mef0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=3MuvFsk45E1rOlboRGFlon7hOJLiMZzdwJ6Sl7nr5kk=;
	b=Yt2dJb4w/QYHd5YtYnTAHH3Bw9+gGuGbGxdy/YJiuIu1k32rCGNF/7Sod/af/7UHc4qE
	 fzd9OhRoBE46xwC+FiE5biaz06oZwSDlVyQi6YpcZezKLZ23kV5miYPvG0L4jphUpeHhK
	 UTEnBtIimUSol/mGvPuZj1tnYX/awpvb5yxie5C9rjW4hLj0gJ3H7zmOLeNw3i7CvEuB6
	 IQRNn+pkviJwzTMIhaYICuUo+p75ZWRreQXwvqJdKx5MRhwZLxxnnYbAfMRKUlIhn3u5s
	 zzKWPKcGUYnJ3ip06k+W988gtLXeNWi71RrVJXnf+PcpuclN9v6nU4jEv4dgkcLs6XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hpUOhF8h;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F26606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F26606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hpUOhF8h
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e5fb79ce82so3114305ad.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581755; x=1793186555; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3MuvFsk45E1rOlboRGFlon7hOJLiMZzdwJ6Sl7nr5kk=;
        b=hpUOhF8hrhvE70M/yuOJLVgdupDW69fpRnbrIBqJ/kIn0waEjCJ/Cv2du8NZ7FMqIN
         PbFM7IQE6xb5FtGd3irDPHmHcGxmv2LHX7cz/qGNHyuQOBFOz6Gl3iL9fKnen/lh5B1b
         Il8e+Okf+pib/wRvcV6RELujcc3ISxl2WdT9k8PaDpzyhc0yGrzBikT+X515faccitJl
         aNBJDS3YUpUEenLX2jyRRFMFj9ggVEzxJfKqtAOONE/DMPHoJMgj7gSi2XKAnz0oE6pS
         H9qmUrvWTPvRrrxtL+SRp03Rt/OGsn6WJHdU3GjNtCyrkzLFXXp+mY/o5SPCaJORz/FJ
         gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581755; x=1793186555;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MuvFsk45E1rOlboRGFlon7hOJLiMZzdwJ6Sl7nr5kk=;
        b=IGCrMNVyrHR14Y0KbDj2NCV76zTgn6n50CPt1P2Vdvs57erAg5tLS320SiVvgiytg4
         wCg73Y0P/HEX3GLj6vNcnl8UpCMFOonyUIix6HL3xcTvHFAnRdZyngle8sQbKDVKHGvd
         NLVKCRmSip6ooObO67zzq3w5xOuNhEFCueOdJYqizQfp3y1NLqYSnjDRJZjuQ2qOrv/2
         htKPPygVJw9wMcv/OUM3a9p8DZ4RRMDv8xNPSjhMf8oJsRxW0clOOTHXdvuxTb60YqHL
         /PUycWLX7dH5aq4DpFJrXcjPul87r+VDE1m0tAdDGO/59AE4CHGUvol3FnpC7UqthYlB
         4+yA==
X-Gm-Message-State: AFq9FYJKVQ1YEyeF72Oft2vfGSatmVjaSDMbq0zhCDReezZf7LxBNtCO
	9e3oqw6lcbb/miYuvAvz3+U9i6TsW8fAMpsvNyX7JOV3sTOnVtn0s+AwSfUyew==
X-Gm-Gg: AYBFou1FDTy2YEjcLH4gs+lM523XcHo9Sf5gyyNhz/j/z3OB7I/UzjrAAFl3lrS++ci
	V5I7MYYubi1DZrGE83+/UmD5XdaoCp5ysraUjs0DyfhwHXXVtx9Fv5S/dIIp6bGmP2eMuSid5ri
	n0znZzffqZD9HPjc3+SAsUK230ZIpGwwqVA/p5S6hZLNv9ec7jufGjdu9QAyyOGSYUelMe+zdRN
	L4Tl1+O5IpmCZFPz+uSJFth3LjMuXcibwJIUh6bv9NE5MWV7dz0jGJu1xbaMbEyrP+rFVpVpoGt
	p5rnIJVx9RcXiELwqImud811SsunydXJ4tx/USAcEVvPP8OvGAp7EJjJC097w7NZuDnFk0ZMwT1
	wY9ihbLkrUFExVoWwKInhAlpJ4/rwoe563SblHvTcLNzKbGrXj7ncKlMrfRHrAGu8tUG/2JnA0N
	EhMyoLRW73VHBjPCeAHv+Txx0ouf7ovBDbuL6+UfIonZ9bzPe4iiijQpQK9fjLxWVP5Xz+5F48U
	LTXQTR6J8AtBSv23bRungpOyzZaYSNmNdJCjMUoQZPSemOrsipFvlzI
X-Received: by 2002:a17:903:26c4:b0:2e8:2d05:9780 with SMTP id d9443c01a7336-2ea437a6be4mr14475905ad.8.1792581755425;
        Wed, 21 Oct 2026 04:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b486965sm9845885ad.63.2026.10.21.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:22:34 -0700 (PDT)
Message-Id: <f6031967e6995060ebdf3ccc8cc280b69c0aa3fe.1792581744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:22:24 +0000
Subject: [PATCH v4 6/6] connected: add "auto" connectivity check mode
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The incremental connectivity check pays a per-commit cost.  For
every incoming commit it reads the new trees along the changed
paths, and the trees at the same paths in its parents to compare
against.  A parent tree is often read again even though an earlier
commit already read it: on git.git, about a third of the tree reads
for 2000 incoming commits are such re-reads.  The full check
instead pays a mostly fixed cost for walking the boundary trees,
so with many incoming commits the incremental check becomes the
slower one (see the previous commit).  Users who mostly
receive small pushes but occasionally a large one should not have
to choose between the two.

Add an "auto" value for transfer.connectivityCheck that picks the
mode based on the incoming history.  When the revision walk is
limited, which is the case whenever the receiving repository has
references, the incoming commit list is already computed by
limit_list(), so counting it is cheap.  "auto" then uses the
incremental check for up to 1000 incoming commits, and the full
check above that.

The cutoff is a fixed constant based on the p5413 fixture in the
previous commit, where breakeven is between 500 and 3000 commits.
It is conservative for repositories with large trees, where the
fixed cost of the full check is higher.  Measured on real
repositories (rev-list against a single boundary commit, mean
of at least 10 runs):

    repository   files  commits    full  incr.  full/incr
    internal A    556K     1000   1.71s  0.61s    2.8x
    internal A    556K     4000   2.78s  2.83s    1.0x
    internal B    288K     1000   1.78s  0.88s    2.0x
    linux          95K      598   0.33s  0.12s    2.7x
    linux          95K     1728   0.56s  0.35s    1.6x
    git           4.9K      984   0.22s  0.27s    0.8x

With small trees incremental can be slower within the cutoff,
but both modes are fast enough there (0.22s vs 0.27s for git
above) that the difference does not matter in practice.

No single cutoff is optimal for every repository, so it can be set
with "auto=<cutoff>"; plain "auto" uses 1000.  A malformed cutoff
is treated like any other unknown value: it falls back to "full"
with a warning.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/config/transfer.adoc  |  6 ++++++
 Documentation/rev-list-options.adoc |  2 +-
 builtin/rev-list.c                  | 28 ++++++++++++++++++++++++++--
 connected.c                         |  9 ++++++++-
 t/t5413-connectivity-check.sh       | 25 +++++++++++++++++++++++--
 5 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/transfer.adoc b/Documentation/config/transfer.adoc
index cba7597a58..f77b25ff8b 100644
--- a/Documentation/config/transfer.adoc
+++ b/Documentation/config/transfer.adoc
@@ -18,6 +18,12 @@ transfer.connectivityCheck::
 	than `full` when there are many incoming commits.
 	Falls back to `full` for clones, pushes into an empty
 	repository and deepening fetches.
+`auto`;;
+`auto=<cutoff>`;;
+	Choose between `full` and `incremental` with a heuristic.
+	Currently `incremental` is used when there are at most
+	_<cutoff>_ incoming commits (1000 by default), and `full`
+	otherwise.  The heuristic may change in future versions.
 --
 +
 Unknown values are treated as `full`, with a warning.
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2023ad5f75..285fb3809f 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1103,7 +1103,7 @@ It is an error to use `--missing-only` without `--missing=print` or
 	traversal, rather than just silencing errors about missing
 	objects.
 
-`--connectivity-check=(full|incremental)`::
+`--connectivity-check=(full|incremental|auto[=<cutoff>])`::
 	(For internal use only.)  Used by `check_connected()` to
 	select the connectivity check algorithm; see
 	`transfer.connectivityCheck` in linkgit:git-config[1].
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 2b428c0c84..85efc0fac8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -29,24 +29,36 @@
 #include "quote.h"
 #include "strbuf.h"
 #include "tree-verify.h"
+#include "parse.h"
+
+#define INCREMENTAL_MAX_COMMITS 1000
 
 enum connectivity_check_mode {
 	CONNECTIVITY_CHECK_FULL,
 	CONNECTIVITY_CHECK_INCREMENTAL,
+	CONNECTIVITY_CHECK_AUTO,
 };
 
 struct connectivity_check {
 	enum connectivity_check_mode mode;
+	unsigned long max_commits;
 };
 
 static void parse_connectivity_check(struct repository *repo,
 				     const char *arg,
 				     struct connectivity_check *check)
 {
+	const char *cutoff;
+
 	if (!strcmp(arg, "full"))
 		check->mode = CONNECTIVITY_CHECK_FULL;
 	else if (!strcmp(arg, "incremental"))
 		check->mode = CONNECTIVITY_CHECK_INCREMENTAL;
+	else if (!strcmp(arg, "auto"))
+		check->mode = CONNECTIVITY_CHECK_AUTO;
+	else if (skip_prefix(arg, "auto=", &cutoff) &&
+		 git_parse_ulong(cutoff, &check->max_commits))
+		check->mode = CONNECTIVITY_CHECK_AUTO;
 	else
 		die(_("unknown --connectivity-check mode '%s'"), arg);
 
@@ -752,7 +764,9 @@ int cmd_rev_list(int argc,
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
-	struct connectivity_check connectivity_check = { 0 };
+	struct connectivity_check connectivity_check = {
+		.max_commits = INCREMENTAL_MAX_COMMITS,
+	};
 	const char *show_progress = NULL;
 	int ret = 0;
 
@@ -1005,9 +1019,19 @@ int cmd_rev_list(int argc,
 	 * The incremental check would still work, but it would verify
 	 * the whole object graph like the full check, with extra
 	 * per-commit overhead on top, so use the full check.
+	 *
+	 * Otherwise the walk is limited, and revs.commits already holds
+	 * all incoming commits, so counting them for "auto" is cheap.
 	 */
-	if (!revs.limited)
+	if (!revs.limited) {
 		connectivity_check.mode = CONNECTIVITY_CHECK_FULL;
+	} else if (connectivity_check.mode == CONNECTIVITY_CHECK_AUTO) {
+		if (commit_list_count(revs.commits) <=
+		    connectivity_check.max_commits)
+			connectivity_check.mode = CONNECTIVITY_CHECK_INCREMENTAL;
+		else
+			connectivity_check.mode = CONNECTIVITY_CHECK_FULL;
+	}
 
 	if (connectivity_check.mode == CONNECTIVITY_CHECK_INCREMENTAL) {
 		struct commit *commit;
diff --git a/connected.c b/connected.c
index c032987410..8ceaa45644 100644
--- a/connected.c
+++ b/connected.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb.h"
+#include "parse.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
@@ -74,7 +75,8 @@ static void connectivity_check_mode(struct repository *repo,
 				    struct check_connected_options *opt,
 				    struct strbuf *mode)
 {
-	const char *algorithm = NULL;
+	const char *algorithm = NULL, *cutoff;
+	unsigned long max_commits;
 
 	/*
 	 * Deepening fetches do not have the usual boundary of
@@ -93,6 +95,11 @@ static void connectivity_check_mode(struct repository *repo,
 		strbuf_addstr(mode, "full");
 	else if (!strcasecmp(algorithm, "incremental"))
 		strbuf_addstr(mode, "incremental");
+	else if (!strcasecmp(algorithm, "auto"))
+		strbuf_addstr(mode, "auto");
+	else if (skip_iprefix(algorithm, "auto=", &cutoff) &&
+		 git_parse_ulong(cutoff, &max_commits))
+		strbuf_addf(mode, "auto=%lu", max_commits);
 	else {
 		warning(_("unknown transfer.connectivityCheck algorithm '%s', "
 			  "using 'full'"), algorithm);
diff --git a/t/t5413-connectivity-check.sh b/t/t5413-connectivity-check.sh
index 109ad17cff..60edf99b63 100755
--- a/t/t5413-connectivity-check.sh
+++ b/t/t5413-connectivity-check.sh
@@ -725,7 +725,7 @@ test_expect_success 'unknown transfer.connectivityCheck falls back to full' '
 	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	git -C dst fetch ../src base:refs/heads/main &&
-	for value in bogus
+	for value in bogus auto= auto=x
 	do
 		set_connectivity_check dst "$value" &&
 		run_traced git -C dst fetch ../src main &&
@@ -753,7 +753,7 @@ test_expect_success 'fetch uses incremental when configured' '
 	expect_mode incremental
 '
 
-for mode in incremental
+for mode in incremental auto
 do
 	test_expect_success "push with $mode into an empty repository uses full" '
 		test_when_finished "rm -rf dst" &&
@@ -771,4 +771,25 @@ do
 	'
 done
 
+for value in auto auto=1
+do
+	test_expect_success "push with $value uses incremental up to the cutoff" '
+		test_when_finished "rm -rf dst" &&
+		git init --bare dst &&
+		git -C src push ../dst base:refs/heads/main &&
+		set_connectivity_check dst $value &&
+		run_traced git -C src push ../dst main &&
+		expect_mode incremental
+	'
+done
+
+test_expect_success 'push with auto uses full above the cutoff' '
+	test_when_finished "rm -rf dst" &&
+	git init --bare dst &&
+	git -C src push ../dst base:refs/heads/main &&
+	set_connectivity_check dst auto=0 &&
+	run_traced git -C src push ../dst main &&
+	expect_mode full
+'
+
 test_done
-- 
gitgitgadget
