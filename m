Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E75F20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfBXKLu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45008 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfBXKLh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so5190837edw.11
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nsFGDaUYm2we7Sy0TpieJ72cR21xwc5KcmcElxVORQE=;
        b=TfNn70n659gHs3axF9iBa9ZOfHNg+Q9C83lB8vLq057InKiRTnf2VDFcegQr4yw+G8
         HfFEoRzOvItE9PTda1xNJJY7ZLbacnIkMsw8q3KzAHQc9wPAO6vnn7gj5BCwPKsJ1kh9
         QpsvvdLKFxRV8/nWs0/J9cbgPDnqQNLfVAWQ+NupnI90oev7aa4hheeOHPVD0QxEj1Np
         3fTwIQA1YIZYq7EPHx2QPOUTz1DJ4QYi7xwMJviKsYREYQHlqTsWLq5AHgWRq7fSL8hU
         AZ3IvCpAxtwFclNT1qfP0Cemyutr+RV5zW+y4w4ii1qWT72IVOaeOiKEd/dhSLMNhijx
         6zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nsFGDaUYm2we7Sy0TpieJ72cR21xwc5KcmcElxVORQE=;
        b=MLxrWDw4mPixzSi44pEP8/hXsAes3Jt4TcyZWdu05nEhWqr1p1nNL21wH9W8mfuwmy
         hQlJT3+5fBt3MWAgs6doUKY0BVpQ/FKbLB1WAPgbEVjSbrNUyuMgndvbopzAgETzEJWe
         TEeJ57ioxsIXrU1ctSABs66sNVKWGzeq3v7I3bKyMKJZm680s0Vmig/qviCZgrUpT4N/
         u7Fs0cp6CPoeaQgFL2CjRKY1OJ29GwzEYCw4P9txp0eUSq4tCpj0DQBLjAG4/JzSA9s+
         MdK0E5Yrah7vGzvxdYUygDb2mz0nzWttuLM7Zvww3gJhVOw9QwcXC75QyJU2u1ce6Z+/
         fq4Q==
X-Gm-Message-State: AHQUAuYMqieqKNqaf1A7nM7Nel6OZC3Hvv8LJ3MXOUxoEB5oTIslvgPJ
        elSmQ8ScYTHaj4EQB5sBF4o7D1vH
X-Google-Smtp-Source: AHgI3IYcFwBO9k713pGPEjd0AM3x/f8AptFIpIOdIS+IoHWEnnXs4NnFLnX/71Vq1YOtFrGqnfg7VA==
X-Received: by 2002:a17:906:f05:: with SMTP id z5mr9241940eji.19.1551003094958;
        Sun, 24 Feb 2019 02:11:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z42sm1826021edd.29.2019.02.24.02.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:34 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:34 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:13 GMT
Message-Id: <205efd9f60801a1b553cf3fd610f37884b99b584.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 25/26] bisect--helper: `bisect_skip` shell function in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_skip()` shell function in C and also add
`bisect-skip` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-skip` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 45 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 17 +--------------
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4eb2580ba8..0818dbf8ff 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
+	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	NULL
 };
 
@@ -994,6 +995,41 @@ static int bisect_replay(struct bisect_terms *terms, const char *filename)
 	return bisect_auto_next(terms, NULL);
 }
 
+static int bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int i, res;
+	const char *pattern = "*..*";
+	struct argv_array argv_state = ARGV_ARRAY_INIT;
+
+	argv_array_push(&argv_state, "skip");
+
+	for (i = 0; i < argc; i++) {
+		if (!wildmatch(pattern, argv[i], 0)) {
+			struct rev_info revs;
+			struct commit *commit;
+			struct argv_array rev_argv = ARGV_ARRAY_INIT;
+
+			argv_array_pushl(&rev_argv, "skipped_commits", argv[i], NULL);
+			init_revisions(&revs, NULL);
+			setup_revisions(rev_argv.argc, rev_argv.argv, &revs, NULL);
+			argv_array_clear(&rev_argv);
+
+			if (prepare_revision_walk(&revs))
+				die(_("revision walk setup failed\n"));
+			while ((commit = get_revision(&revs)) != NULL)
+				argv_array_push(&argv_state,
+						oid_to_hex(&commit->object.oid));
+
+			reset_revision_walk();
+		} else {
+			argv_array_push(&argv_state, argv[i]);
+		}
+	}
+	res = bisect_state(terms, argv_state.argv, argv_state.argc);
+	argv_array_clear(&argv_state);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1005,7 +1041,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-		BISECT_REPLAY
+		BISECT_REPLAY,
+		BISECT_SKIP
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -1027,6 +1064,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
+			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1093,6 +1132,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
+	case BISECT_SKIP:
+		set_terms(&terms, "bad", "good");
+		res = bisect_skip(&terms, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 0555191c41..edfd3f8b3d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,21 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_skip() {
-	all=''
-	for arg in "$@"
-	do
-		case "$arg" in
-		*..*)
-			revs=$(git rev-list "$arg") || die "$(eval_gettext "Bad rev input: \$arg")" ;;
-		*)
-			revs=$(git rev-parse --sq-quote "$arg") ;;
-		esac
-		all="$all $revs"
-	done
-	eval git bisect--helper --bisect-state 'skip' $all
-}
-
 bisect_visualize() {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -162,7 +147,7 @@ case "$#" in
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		git bisect--helper --bisect-state "$cmd" "$@" ;;
 	skip)
-		bisect_skip "$@" ;;
+		git bisect--helper --bisect-skip "$@" ;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
 		get_terms
-- 
gitgitgadget

