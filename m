Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F08C43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B96223B0
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="APte84Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgJSVaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:30:35 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:51790 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733044AbgJSVae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:30:34 -0400
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 91ED6E374;
        Mon, 19 Oct 2020 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603143032;
        bh=mlrEyvp/zFPrEkz3xSL+kfXqaQusEk6jQso3WnE/CoU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=APte84Qb+1mXz83zyaonnYWvwCaPBLEQ+yXqycW0SxOVGhZIshek0ZiCuXZ7Owoh9
         IL3NEWKVHOAuBX7MF+1r1ybCA/QJhKtv8klpOSdpb0xkR/iUnPrlB2mZbjBM8iqF+h
         8I8bQkJ3J3Fi4JnlYEqnJ36W70eO2rTT58FnL+oODvmolZfPd2G7n+X+Q4T+kATjbo
         oKZdMuusVVCgXEN2G2aBVX+pLs6JtwYQvA95NWHyeU0CEhPRF8AhioSHziwzCTSBEy
         +pBy5o3aqzOr4cipAWa6Y1O4lySPNeGGwEaILAfhnOyVo5cCiughaWPZttu3qg26jm
         38IBP1wTLojXw==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/3] Documentation: stylistically normalize references to Signed-off-by:
Date:   Mon, 19 Oct 2020 14:25:43 -0700
Message-Id: <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603142543.git.bkuhn@sfconservancy.org>
References: <xmqqmu0it6ls.fsf@gitster.c.googlers.com> <cover.1603142543.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ted reported during patch review of the previous commit that an old
typo was present in the git-commit.txt and merge-options.txt.
Namely, the phrase "Signed-off-by line" was used without either a
definite nor indefinite article.

Upon examination, it seems that the documentation (including items in
Documentation/, but also option help strings) have been quite
inconsistent on usage when referring to `Signed-off-by:`.

It seems the original usage, seen in Commit
3f971fc425b (Documentation updates, 2005-08-14) initially used "Add
Signed-off-by line", and Commit 6f855371a53 (Add --signoff, --check,
and long option-names. 2005-12-09) switched to using "Add
`Signed-off-by:` line", but didn't normalize the former commit to
match.  Later commits seem to have cut and pasted from one or the
other, which is likely how the usage became so inconsistent.

Very few places used a definite or indefinite article with the phrase
"Signed-off-by: line", but that was the initial typo that led me down
this investigation, so I have normalized using either an indefinite
or definite article consistently.  Since usage of
`Signed-off-by:` (with the colon) was about six months more current
than without the colon, I chose `Signed-off-by:` (with backticks) for
the documentation files and Signed-off-by: (without backticks) for
option help strings

I left alone a few places in documentation that used the phrase
Signed-off-by (without colon or backticks) to refer to the
process (rather than the specific line), and I also left alone one
place where many mail headers were mentioned in a specific way so the
style for Signed-off-by and those mail headers remained consistent.

Reported-by: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20201018151315.GJ181507@mit.edu>
Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
---
 Documentation/MyFirstContribution.txt |  2 +-
 Documentation/SubmittingPatches       | 10 +++++-----
 Documentation/git-cherry-pick.txt     |  2 +-
 Documentation/git-commit.txt          |  2 +-
 Documentation/git-format-patch.txt    |  2 +-
 Documentation/git-rebase.txt          |  2 +-
 Documentation/git-revert.txt          |  2 +-
 Documentation/git-send-email.txt      |  4 ++--
 Documentation/githooks.txt            |  2 +-
 Documentation/merge-options.txt       |  4 ++--
 builtin/am.c                          |  2 +-
 builtin/commit.c                      |  2 +-
 builtin/log.c                         |  2 +-
 builtin/merge.c                       |  2 +-
 builtin/pull.c                        |  2 +-
 builtin/revert.c                      |  2 +-
 16 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 4f85a089ef..9a7f76cdef 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -249,7 +249,7 @@ component you're working on, followed by a blank line (always required) and then
 the body of your commit message, which should provide the bulk of the context.
 Remember to be explicit and provide the "Why" of your change, especially if it
 couldn't easily be understood from your diff. When editing your commit message,
-don't remove the Signed-off-by line which was added by `-s` above.
+don't remove the `Signed-off-by:` line which was added by `-s` above.
 
 ----
 psuh: add a built-in by popular demand
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 291b61e262..d520eb23b1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -209,7 +209,7 @@ send them as replies to either an additional "cover letter" message
 (see below), the first patch, or the respective preceding patch.
 
 If your log message (including your name on the
-Signed-off-by line) is not writable in ASCII, make sure that
+`Signed-off-by:` line) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
 
 WARNING: Be wary of your MUAs word-wrap
@@ -229,7 +229,7 @@ previously sent.
 The `git format-patch` command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
-Signed-off-by: lines, and a line that consists of three dashes,
+`Signed-off-by:` lines, and a line that consists of three dashes,
 followed by the diffstat information and the patch itself.  If
 you are forwarding a patch from somebody else, optionally, at
 the beginning of the e-mail message just before the commit
@@ -298,7 +298,7 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 patch.
 
 [[sign-off]]
-=== Certify your work by adding your "Signed-off-by: " line
+=== Certify your work by adding your `Signed-off-by:` line
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
@@ -347,14 +347,14 @@ then you just add a line saying
 This line can be automatically added by Git if you run the git-commit
 command with the -s option.
 
-Notice that you can place your own Signed-off-by: line when
+Notice that you can place your own `Signed-off-by:` line when
 forwarding somebody else's patch with the above rules for
 D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
 [[real-name]]
-Also notice that a real name is used in the Signed-off-by: line. Please
+Also notice that a real name is used in the `Signed-off-by:` line. Please
 don't hide your real name.
 
 [[commit-trailers]]
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 75feeef08a..4b8e8bc484 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -104,7 +104,7 @@ effect to your index in a row.
 
 -s::
 --signoff::
-	Add Signed-off-by line at the end of the commit message.
+	Add a `Signed-off-by:` line at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
 -S[<keyid>]::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 93bbae4ded..8f0ff51237 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -165,7 +165,7 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 -s::
 --signoff::
-	Add Signed-off-by line by the committer at the end of the commit
+	Add a `Signed-off-by:` line by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project to which
 	you're committing.  For example, it may certify that the committer has
 	the rights to submit the work under the project's license or agrees to
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0f81d0437b..439c2cf461 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -119,7 +119,7 @@ include::diff-options.txt[]
 
 -s::
 --signoff::
-	Add `Signed-off-by:` line to the commit message, using
+	Add a `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 38e15488f6..2ad5f9eadc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -496,7 +496,7 @@ See also INCOMPATIBLE OPTIONS below.
 See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
-	Add a Signed-off-by: trailer to all the rebased commits. Note
+	Add a `Signed-off-by:` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
 +
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 044276e9da..e89359d4bd 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -99,7 +99,7 @@ effect to your index in a row.
 
 -s::
 --signoff::
-	Add Signed-off-by line at the end of the commit message.
+	Add a `Signed-off-by:` line at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
 --strategy=<strategy>::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..e9c0f22700 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -313,7 +313,7 @@ Automating
 	the value of `sendemail.identity`.
 
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in Signed-off-by: or Cc: lines to the
+	If this is set, add emails found in the `Signed-off-by:` or Cc: lines to the
 	cc list. Default is the value of `sendemail.signedoffbycc` configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
@@ -340,7 +340,7 @@ Automating
   except for self (use 'self' for that).
 - 'bodycc' will avoid including anyone mentioned in Cc lines in the
   patch body (commit message) except for self (use 'self' for that).
-- 'sob' will avoid including anyone mentioned in Signed-off-by lines except
+- 'sob' will avoid including anyone mentioned in the `Signed-off-by:` lines except
   for self (use 'self' for that).
 - 'misc-by' will avoid including anyone mentioned in Acked-by,
   Reviewed-by, Tested-by and other "-by" lines in the patch body,
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 6e461ace6e..5063b02ab6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -164,7 +164,7 @@ can also be used to refuse the commit after inspecting the message
 file.
 
 The default 'commit-msg' hook, when enabled, detects duplicate
-"Signed-off-by" lines, and aborts the commit if one is found.
+`Signed-off-by:` lines, and aborts the commit if one is found.
 
 post-commit
 ~~~~~~~~~~~
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 29e6030131..0eed6a7bb2 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -79,7 +79,7 @@ actual commits being merged.
 
 --signoff::
 --no-signoff::
-	Add Signed-off-by line by the committer at the end of the commit
+	Add a `Signed-off-by:` line by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project to which
 	you're committing.  For example, it may certify that the committer has
 	the rights to submit the work under the project's license or agrees to
@@ -89,7 +89,7 @@ actual commits being merged.
 	leadership of the project to which you're contributing to understand
 	how the signoffs are used in that project.
 +
-With --no-signoff do not add a Signed-off-by line.
+With --no-signoff do not add a `Signed-off-by:` line.
 
 --stat::
 -n::
diff --git a/builtin/am.c b/builtin/am.c
index 2c7673f74e..e13b121b76 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2237,7 +2237,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_SET_INT('s', "signoff", &state.signoff,
-			N_("add a Signed-off-by line to the commit message"),
+			N_("add a Signed-off-by: line to the commit message"),
 			SIGNOFF_EXPLICIT),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),
diff --git a/builtin/commit.c b/builtin/commit.c
index 1dfd799ec5..6e254440f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1507,7 +1507,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by: line")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..615bd69baf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1738,7 +1738,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('N', "no-numbered", &numbered, NULL,
 			    N_("use [PATCH] even with multiple patches"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, no_numbered_callback),
-		OPT_BOOL('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by: line")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..5a2b4ca29e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -289,7 +289,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_AUTOSTASH(&autostash),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
-	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
+	OPT_BOOL(0, "signoff", &signoff, N_("add a Signed-off-by: line")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
 	OPT_END()
 };
diff --git a/builtin/pull.c b/builtin/pull.c
index 425950f469..4d47fe5d3c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -142,7 +142,7 @@ static struct option pull_options[] = {
 		N_("add (at most <n>) entries from shortlog to merge commit message"),
 		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU(0, "signoff", &opt_signoff, NULL,
-		N_("add Signed-off-by:"),
+		N_("add a Signed-off-by: line"),
 		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
 		N_("create a single commit instead of doing a merge"),
diff --git a/builtin/revert.c b/builtin/revert.c
index f61cc5d82c..1c895efedd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -107,7 +107,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
-		OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &opts->signoff, N_("add a Signed-off-by: line")),
 		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
 			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

