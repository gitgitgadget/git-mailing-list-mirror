Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E954C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E80260E78
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJ1IGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:06:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1IGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 04:06:45 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MWjUc-1m8wlb43tw-00X1mx; Thu, 28 Oct 2021 10:04:07 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id D87C61E01E7;
        Thu, 28 Oct 2021 08:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Eu3TjGmHWEl8; Thu, 28 Oct 2021 10:04:06 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (24-usr-pf-main.vpn.it.cetitec.com [10.8.5.24])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 4497F1E01E6;
        Thu, 28 Oct 2021 10:04:06 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 28 Oct 2021 10:04:05 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: [PATCH] Remove negation from the commit and merge option
 "--no-verify"
Message-ID: <YXpZddOixrJDd//s@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXpFTJTo0pKhM7xG@pflmari>
X-Provags-ID: V03:K1:zEflgaRWgtgLx4CTJy7EEKHgaZjHyzJE1rdvPBV026kEgtAWeS3
 HmDC2YeIHAjjx72b1UvrOBLVI7oQFHI7zopshmB7D+KxECrtAKbw1l3UA/ZOQo1WUgrFm1x
 ZG6ICADdUKvItOySI3LTNhmo+T+eaoi5pZbeqBvXNci8p2alAojH1jWWSWnqfP7hlJUVF3J
 qvYPDtgI8IGCEd84XHbUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C6i+sUFCV5k=:QQIQCx0C73dcTg2yq0/KWy
 dr5m6wuBHOHYQAf494uKZh4gbt2AQ3gD0AQBHxxieKeRqx/ah4PVLPLWjxfDr3THN/S1HiAEi
 Qbo2MU57bNOkdvGPFfy0vrO/1D6k/YcoboVV+iBChW07gKOkLxteEJVgnhSlsRincICL9hgVB
 zF/I8zNqR+AxZfiOJOpaX9D4zB/RG1hor7CpDP8Anf5TFVDK5M4cr6F3C+E9BQdUP0IMUSccj
 VdTjaw2NEzFt2lxRiP9KmkjA5wYk6JS9cq/ITktiF2Ivy2xC1j5C4HF2ufdpE1JBEfz1mjItg
 lh6I3d+FWDbJb3VEsyxEkauekqne3SdaVNuh+LRLYeQFB97mBeLtALkNnx5dLud4ls5P8VWxw
 qtdNWnm4wo8J2j5Roqlg+wLuE9LC+jSrzoIRix5m38aQ3IFdSknfsFFXCeCBAjbGUHKPBeGIi
 M/8o3kzHq63BWJFohhRSThqMvuicclYgVwhvQCyJx+oZNJKowPaHAwcnX5MlHjrHRL8jsVJv0
 qos3xJHZWvaizZX/iE6JI+09Vv92tyPhnXUdcoIBfwQ8+NzhPAVvWitrBkHysbeIsDfQzjoc+
 LkOhhaCSPOFE8QCt0WuufQkIoMYvWG/eYViL5hPK1Gmss4lvU70/3bXlGvTtp78Ava412U/L5
 euFkSL4HRAQEZD0LHxGi+G6OGdanwuKU13SLJej4UYdq0zZ1DNfNFqoye4XQCyW00y7PD9w2p
 gPtqfCv4x+la/PMn
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

This allows re-enabling of the hooks disabled by an earlier "--no-verify"
in command-line and makes the interface more consistent.

Incidentally, this also fixes unexpected calling of the hooks by "git
pull" when "--no-verify" was specified, where it was incorrectly
translated to "--no-verify-signatures". This caused the unexpected
effect of the hooks being called. And an even more unexpected effect of
disabling verification of signatures.

Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Thu, Oct 28, 2021 08:38:04 +0200:
> Junio C Hamano, Wed, Oct 27, 2021 22:16:35 +0200:
> > And yes, I agree that we shouldn't introduce an awkwardness in one
> > step of the series and fix it in another step of the same series.
> 
> I think I better resend everything as a single patch then.
> 

Something like this: dengate no-verify in all commit-creating code.

I looked at "no-verify" in push and rebase, but they feel different:
they create no new commits, and are involved in other workflows.
Perhaps another time.

 Documentation/git-commit.txt    | 10 ++++++++--
 Documentation/git-merge.txt     |  2 +-
 Documentation/merge-options.txt |  5 +++--
 builtin/commit.c                | 22 +++++++++++++++++-----
 builtin/merge.c                 | 12 ++++++------
 builtin/pull.c                  |  6 ++++++
 t/t5521-pull-options.sh         | 12 ++++++++++++
 t/t7504-commit-msg-hook.sh      |  8 ++++++++
 8 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..ba66209274 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
 	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
-	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
+	   [--allow-empty-message] [--[no-]verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [-S[<keyid>]] [--] [<pathspec>...]
@@ -174,7 +174,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 -n::
 --no-verify::
-	This option bypasses the pre-commit and commit-msg hooks.
+	By default, pre-merge and commit-msg hooks are run. When one of these
+	options is given, these are bypassed.
+	See also linkgit:githooks[5].
+
+--verify::
+	This option re-enables running of the pre-commit and commit-msg hooks
+	after an earlier `-n` or `--no-verify`.
 	See also linkgit:githooks[5].
 
 --allow-empty::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3819fadac1..324ae879d2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[--[no-]verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
 'git merge' (--continue | --abort | --quit)
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..f8016b0f7b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,9 @@ option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
 
---no-verify::
-	This option bypasses the pre-merge and commit-msg hooks.
+--[no-]verify::
+	By default, pre-merge and commit-msg hooks are run. When `--no-verify`
+	is given, these are bypassed.
 	See also linkgit:githooks[5].
 
 -s <strategy>::
diff --git a/builtin/commit.c b/builtin/commit.c
index 1dfd799ec5..714722b0cd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -108,7 +108,7 @@ static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
-static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int quiet, verbose, verify = 1, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
@@ -164,6 +164,16 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int opt_parse_n(const struct option *opt, const char *arg, int unset)
+{
+	int *value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	*value = 0;
+	return 0;
+}
+
 static int opt_parse_rename_score(const struct option *opt, const char *arg, int unset)
 {
 	const char **value = opt->value;
@@ -699,7 +709,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -983,7 +993,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (verify && find_hook("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
@@ -1014,7 +1024,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strvec_clear(&env);
 	}
 
-	if (!no_verify &&
+	if (verify &&
 	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
@@ -1522,7 +1532,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
-		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
+		OPT_CALLBACK_F('n', NULL, &verify, "", N_("bypass pre-commit and commit-msg hooks"),
+			       PARSE_OPT_NOARG|PARSE_OPT_NONEG, opt_parse_n),
+		OPT_BOOL(0, "verify", &verify, N_("control use of pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..ab5c221234 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -83,7 +83,7 @@ static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
 static int autostash;
-static int no_verify;
+static int verify = 1;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -290,7 +290,7 @@ static struct option builtin_merge_options[] = {
 	OPT_AUTOSTASH(&autostash),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
+	OPT_BOOL(0, "verify", &verify, N_("control use of pre-merge-commit and commit-msg hooks")),
 	OPT_END()
 };
 
@@ -822,7 +822,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
@@ -858,9 +858,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
-					  git_path_merge_msg(the_repository), NULL))
+	if (verify && run_commit_hook(0 < option_edit, get_index_file(),
+				      "commit-msg",
+				      git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
diff --git a/builtin/pull.c b/builtin/pull.c
index 425950f469..e783da10b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,6 +84,7 @@ static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static char *opt_verify;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
@@ -160,6 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
+		N_("control use of pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -688,6 +692,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
+	if (opt_verify)
+		strvec_push(&args, opt_verify);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
 	strvec_pushv(&args, opt_strategies.v);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..7d3a8ae0d3 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -225,4 +225,16 @@ test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'git pull --no-verify flag passed to merge' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	false
+	EOF
+	test_commit -C src two &&
+	git -C dst pull --no-ff --no-verify
+'
+
 test_done
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..166ff5fb26 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_success '-n with failing hook' '
+
+	echo "more" >> file &&
+	git add file &&
+	git commit -n -m "more"
+
+'
+
 test_expect_success '--no-verify with failing hook (editor)' '
 
 	echo "more stuff" >> file &&
-- 
2.33.0.22.g8cd9218530

