Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E13C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542B060E54
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhJ0N3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:29:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbhJ0N3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 09:29:43 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTAJl-1mETag3anP-00Ua0z; Wed, 27 Oct 2021 15:27:05 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id CD2E51E01E7;
        Wed, 27 Oct 2021 13:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MKKWHz3m1be2; Wed, 27 Oct 2021 15:27:04 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (19-usr-pf-main.vpn.it.cetitec.com [10.8.5.19])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 48D2C1E01E6;
        Wed, 27 Oct 2021 15:27:04 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Wed, 27 Oct 2021 15:27:03 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Remove negation from the merge option "--no-verify"
Message-ID: <YXlTpzrY7KFqRlno@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
X-Provags-ID: V03:K1:nYagFg//Bc47WcmTEDei6G8fm+ShMvKntnqfZJknYFRkSPAbP82
 fiUpSjjIZC4TNzF30vwWKgSKGjhfYG7HjwZnRQK0LR50rhF79aWnXiQ3l7QR/VmqXS/A7yJ
 6Bhklg2TLllyDum5DbCpQ/Ws9IniJKzdV/nv5wSu9ZCRrizt9AnDwBm+dBK4nQhS6QF4zzV
 VEvJUFQQfF1RwJDQL+V3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a2vdNFgsAaU=:oQD1S3sTiNhh3x7Rvs5/X6
 WTOBujPI5UfGtCN9BuEyQs9LA6PxaOK6qAyckyxyK+ePjm8xJTX6YUjJgTWdvX3ApbpWkjjLJ
 hBdtcumOgNCUtOxvuiWgr0GNV4ES3ona4HvATuZOF9NuCQNf1gpRdQ2VtWY5kWse7hSE8SD01
 npSIi/GNvayR0gHg7pVaiOeIzoxWieEX/MN0E6y3FUtscJT3H/ZfldDw36NaGvCXLyboQwltH
 JnV+YDspw44Bd62enmhfatuWKAVNnEhOQS+X2WJqotuxRneJtBX42dtIBm0GEJWO81dkvCVgZ
 ImTaLUxUIY+U0EJukmFMM+kGp5fWrz5RF6nY4aI6rBSW4klOxlFX94jKcFsY1zRN2jkKKuBNV
 e1gJPvf8lkOmntpeUkVmmq7jpEsyUDjrQ1kQXJh/Ss/isFRFeQWj3wVoQ+od2OrUvgkx7LZgh
 dWQrXcUY8U4sg0NnhQOu+vWjCYeHBHsjd3o7QpKqvDSZXVDxuuwYdaTS6ndktrcdMGcNs7QYH
 4uwGT0rw/A3ezPEQcLhDoUeqXHql2BueWqm6tpAdKBzk/F80q/CNjStap/aM9ZGfpYmbRs6rt
 PjlLtJbgM/BXHEVuS/DGybZUyVU6+dakd8opr+xYF0YdRVvPjIVKNPE0+T6ol+rJEJg1u56OV
 7jE8pURFoeFfVMShAC1you4aMPK0E1wPCSvSpLRZJMW3OKDmcob3qbTxtWSllh8xx+uTTV3CH
 pfmQqO8z8eFPcG6V
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

This allows re-enabling hooks disabled by an earlier "--no-verify"
in command-line and makes the interface more consistent.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

This one is on top of "[PATCH] Fix "commit-msg" hook unexpectedly called for
"git pull --no-verify" (http://public-inbox.org/git/YXfwanz3MynCLDmn@pflmari/).
Which is a bit awkward. Should I resend as series?

Jeff King, Wed, Oct 27, 2021 14:19:49 +0200:
> On Wed, Oct 27, 2021 at 02:09:42PM +0200, Alex Riesen wrote:
> > Jeff King, Tue, Oct 26, 2021 23:16:09 +0200:
> > > On Tue, Oct 26, 2021 at 02:11:22PM +0200, Alex Riesen wrote:
> > > I was going to ask whether this should be passing through "verify", and
> > > allowing its "no-" variant, but there is no "--verify" in git-merge.
> > > Arguably there should be (for consistency and to countermand an earlier
> > > --no-verify), but that is outside the scope of your fix (sadly if
> > > somebody does change that, they'll have to remember to touch this spot,
> > > too, but I don't think it can be helped).
> > 
> > This seems simple enough, though. Like this?
> > 
> > [PATCH] Remove negation from the merge option "--no-verify"
> > 
> > This allows re-enabling hooks disabled by an earlier "--no-verify"
> > in command-line and makes the interface more consistent.
> 
> Yeah, I don't see any problems in the patch below, and I agree it makes
> things overall nicer (both the user-facing parts, and not having to see
> the double-negative "!no_verify" in the code).

Ok, resending it formally.

> > diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> > index 80d4831662..54cd3b04df 100644
> > --- a/Documentation/merge-options.txt
> > +++ b/Documentation/merge-options.txt
> > @@ -112,8 +112,9 @@ option can be used to override --squash.
> >  +
> >  With --squash, --commit is not allowed, and will fail.
> >  
> > ---no-verify::
> > -	This option bypasses the pre-merge and commit-msg hooks.
> > +--[no-]verify::
> > +	With `--no-verify`, bypass the pre-merge and commit-msg hooks,
> > +	which will be run by default.
> 
> This "which will be run by default" is a little awkward. Maybe:
> 
>   By default, pre-merge and commit-msg hooks are run. When `--no-verify`
>   is given, these are bypassed.
> 
> ?

Of course. It certainly reads better like this.

 Documentation/git-merge.txt     |  2 +-
 Documentation/merge-options.txt |  5 +++--
 builtin/merge.c                 | 12 ++++++------
 builtin/pull.c                  | 12 ++++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

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
index 428baea95b..e783da10b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,7 +84,7 @@ static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
-static char *opt_no_verify;
+static char *opt_verify;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
@@ -161,9 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-	OPT_PASSTHRU(0, "no-verify", &opt_no_verify, NULL,
-		N_("bypass pre-merge-commit and commit-msg hooks"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
+		N_("control use of pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -692,8 +692,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
-	if (opt_no_verify)
-		strvec_push(&args, opt_no_verify);
+	if (opt_verify)
+		strvec_push(&args, opt_verify);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
 	strvec_pushv(&args, opt_strategies.v);
-- 
2.33.0.22.g8cd9218530

