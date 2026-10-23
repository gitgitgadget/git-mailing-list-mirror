Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761132;
	b=U0H6qNUg/SjL3rN/UoQAUmtT6tOKLfCqRdR5pBgrH3rEv5l9joAAWJHklP0jcHlhDFXf
	 KeNWUTjXH0WmiIIvn1G+G45jA+0sRly3OTEqTAyIlMRhEKGexa0qpTFL3N/kIzZyvtden
	 Q2KshjePDvi1ByxnLvIp90f7cI1eLzvgoQFvlRxH0inznkidiioqLRlQ3O1bGL6gx3U0+
	 tpzCOLksseUt2TPNCzJQ4b5htPJ1rJebb9R2yLhySwFe9XP5FJttayMcdFrf6ieQwBg9B
	 XonXOgvt2NFom1GyDriF4R27Z8bqhNOyTCdy23XgPPIvOgIl/prajABX3gEW1pwIfLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=coPWA0cNh7+XWk0i2tSI2f88qqlS4t4jn7vIQm5Hrdc=;
	b=wKSzGDmX/J5xUENW3kstRdzMW531Gdku6AD3/LJ8WexFF27dv/IRmcVkhqg7tGdojXyf
	 +QIqdxNXAD77419Co6Nv6wA9XgBdOy3CTSzhygX9PoxoXMitJd0XLpZOnDO2HshKqkrgj
	 XJ2cIvEyq1QnEHprh64RMV8yMK/NTYOcT7fK+3x1ptNTV6g59Lfs3ysBJG1sKbFvCikwb
	 2BDGamR0FtXc7cPXgdD3pgGyjNyFSm4i9Ls/i0J+BVFiooGh3/w1XpHY8V9+k5YxSAIX6
	 UwjjF8Br6REvorp8LFSYxkA9sIaRpTg/9tIHDDsJy+n86my8ct7BlFPmNSCV5VNkh5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fp+eaRU4;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF66606A326
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CF66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fp+eaRU4
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b125371596so15397877b3.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761131; x=1793365931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=coPWA0cNh7+XWk0i2tSI2f88qqlS4t4jn7vIQm5Hrdc=;
        b=Fp+eaRU4IFzueYaLnyI0bK5jYSjGPluemTZqTg4xx0X4XVJWbjSf62je8JfjjTHezr
         8v8AHay8dQ5yG6A3YDsSWEOf9vw1gg8WZHZjdTzf/pgnSjQm4G4ijMHucKIzVpyQw2HL
         HrTMQlDVImDsF22ejU10pvWJiFfx8R0AAHi6v/KVE3UQYp+lE99j1jSKbI4/qBK2S27J
         lJ8YuC5XkZ5qYuc4amuIxl+lAM/ukvwYixUlxKO3Doed9FrV/WkbO0k3AEoGW4tS7DNH
         BZ3Mf1WBif+EZpg5YBRUnjxxySfrWxTHNeN6pl09FA4vA/YIgwXAZnkisJ1MFrxxlD9s
         Wwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761131; x=1793365931;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=coPWA0cNh7+XWk0i2tSI2f88qqlS4t4jn7vIQm5Hrdc=;
        b=eFGjxb4Auo9i5jhN+//t5CFCpb4wqF3AbKzkMiIf2jaXBBuVVz0Tk8kierhZBxogOp
         8TyEfFKv6x3aiCA3FZ5thlbR0tp0h0MN7yORIq0lm9QuzYebpSs/1qOS+h67xANvXm8s
         9xgFV8RrYMXM+52sSRBupOdIdQ+GzMUzuoPl7x12YkQzZTVLhHYK13lOjbT1Q55ZbAm1
         kT76uiVbMIje3o4Wc6O+QKzQuuJ8SAuvnMBy41rIYP39r2rMYEnCFIK71IlxK/0YaAM/
         xMO4W0PZaCGLofqHixrtEoRcuZjeQWfOXqavpz3DYZvwBEEydR7hFBjD8Le7XJ/XxKbw
         k5rw==
X-Gm-Message-State: AFq9FYLpNANDqs9nPr/hZc0pLyWbnJKtt0djt+6WL5k0GMzftB5YHLuE
	v+dnodIo8km+Eajlc0IFFET7mrWOdClAtVLKFdIjDRFyfpzBbtzwCdEzttg0iCyD
X-Gm-Gg: AYBFou1HdYnluvZyLioXxP9H42Lk0yTay2L1lTvJ5QS6aWABppVHhdNI9Dix6n0yfIJ
	Az1nrre2QdAiy/mExVm3hxlqXgGZPsvFSzkZwmgkbFaSAy1WMpyzVGVgXQT6p6jl5EEZHYZFxye
	Yla+z2G/UP35tAMmnOwGw10b4YS96i22rkG8g7/vt+1DnuqodmQkEQ0+FIuphXlNStdxSvexUJ6
	XiGwpc37kbT362DV1Njm1QQ0jh67cNnxIlIrgBmzLdByKK98q+T82fi+HnWVnQq7VR4w32TXNTl
	U4ZsINpiqQAFyhalu/Ww9CaXyyyi2YteVtmZgu2k7JvOOQzhdW1vpl42FGURC9qLBvxguXkj3L4
	aDaBcHQ4htKdmd0JLbZqHViufsDlTw5f1fXyEpG2+nZVdpSVXq/yE20ffAmtrN5HiO186KIR/Tp
	8yl2LheQa11hvtz642oAOjMzE6RdrjDVWOllTx6NLKGujPotaLLxF2f4uNUFFvWIMWDiq/fRhb+
	PQld+k4vtGRJSx5QbakHMiX9uaKxp+Y64x5ttHk1aCMB/tUJYWDUn2K/qtT
X-Received: by 2002:a05:690c:399:b0:8b0:d206:16c1 with SMTP id 00721157ae682-8b157eb3782mr16720897b3.24.1792761131470;
        Fri, 23 Oct 2026 06:12:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1560cc3b8sm12806217b3.15.2026.10.23.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:10 -0700 (PDT)
Message-Id: <98f67caa04bfe5b389846e99b069aeb8de221ecd.1792761119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:59 +0000
Subject: [PATCH v5 6/6] connected: add "auto" connectivity check mode
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
index c07ad6e30c..071a0e3cb5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -29,23 +29,35 @@
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
 
 static void parse_connectivity_check(const char *arg,
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
 }
@@ -748,7 +760,9 @@ int cmd_rev_list(int argc,
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
-	struct connectivity_check connectivity_check = { 0 };
+	struct connectivity_check connectivity_check = {
+		.max_commits = INCREMENTAL_MAX_COMMITS,
+	};
 	const char *show_progress = NULL;
 	int ret = 0;
 
@@ -1001,9 +1015,19 @@ int cmd_rev_list(int argc,
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
