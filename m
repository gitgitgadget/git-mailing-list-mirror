Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2289A20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBXKLu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46648 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfBXKL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so5181122edy.13
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3cXln+g4eS08s1IYGhPuWoWR4LXb0ZaLcI1AklOivA8=;
        b=dPe7MSI3XTK65OmcVS8e+l6sRpOs0zODbyMxh1lGmGTc+su7jjChR1Cwd4ifGg0hix
         eQZQCQAz3b0z6G05WkCPY5wW68Cqwkl1KRg0iwNnWL3d5jcrOZTkXSB7fnN8/j6V7GLc
         /ZceToIhtviOJSSbTbbyscoQXSte0z/yS4PMBWOeWyLXT26GPH8g86pSSr4ZC1LOV2UE
         3+AId+KkH57+MgQLU0ZrhHr2URNrcnfkD0MXpRMRa3svpoB4TNwvAX9jiE9GwVGNcYtZ
         REaWZHSUiTKCPf3dDTHUosswOfPaKSSG2gO09OucIkk0Ac46ahIoRASPdMIf4QxokJGn
         0+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3cXln+g4eS08s1IYGhPuWoWR4LXb0ZaLcI1AklOivA8=;
        b=X2uwAcedsy6ikDdTdpFM7O5OmVOaCr0zsB4ee9b42OqB2lEKG90xaz9kgqQCXisS2z
         hQhzxZxIapQvNFAHC1v+9D4IetXF7sxjAs90uhC9xSSBIL2ybsTepBSnDag17HUVCfHE
         Ir7cH4x2aNjyr32B6pAMACjcZ6l3VOWrtqdWOlt/5O9CH57XBHigUh/380uijJDZoZ+C
         18YsXiCAtcoudzDDd1rboei4Tej98u/hGe1jLc2+dXWvE3Q9YnUfbH0QUIJF1eXx4gcM
         hVDFurjOZdmTMUHvhp2gMkO8UKgvJP0mFcN+7X8wKGo4N5ySlsMfoTXpNwQ/mxT/2JV4
         YBjw==
X-Gm-Message-State: AHQUAuY3wWVQui271fXNdpfk98vLvAgzMtneNBu6UoYlQjMZjlXJV30z
        uhwmuqsA8fvxC8SjR7fOVO9xE2Vj
X-Google-Smtp-Source: AHgI3IbGcukBW8IdHxSOOaRGDotnKaCdyOTIw1ckGPJXVCEbWq/lEE1KDFXedBssSy8rGq/6prr7Fg==
X-Received: by 2002:a50:a086:: with SMTP id 6mr10136713edo.88.1551003087432;
        Sun, 24 Feb 2019 02:11:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm1838468edb.60.2019.02.24.02.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:26 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:26 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:03 GMT
Message-Id: <c5ed159ec58b26c1b46e63cb698dc377d582ef10.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 15/26] bisect--helper: `bisect_autostart` shell function in C
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

Reimplement the `bisect_autostart()` shell function in C and add the
C implementation from `bisect_next()` which was previously left
uncovered. Also add a subcommand `--bisect-autostart` to
`git bisect--helper` be called from `bisect_state()` from
git-bisect.sh .

Using `--bisect-autostart` subcommand is a temporary measure to port
shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and will be called
by `bisect_state()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 39 +++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 23 +----------------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1a525faf27..61c3cc517a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
+	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
@@ -56,6 +57,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 static const char *vocab_bad = "bad|new";
 static const char *vocab_good = "good|old";
 
+static int bisect_autostart(struct bisect_terms *terms);
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -530,6 +533,7 @@ static int bisect_next(struct bisect_terms *terms, const char *prefix)
 {
 	int res, no_checkout;
 
+	bisect_autostart(terms);
 	if (bisect_next_check(terms, terms->term_good))
 		return -1;
 
@@ -788,6 +792,32 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	return res;
 }
 
+static int bisect_autostart(struct bisect_terms *terms)
+{
+	if (is_empty_or_missing_file(git_path_bisect_start())) {
+		const char *yesno;
+		const char *argv[] = {NULL};
+		fprintf(stderr, _("You need to start by \"git bisect "
+				  "start\"\n"));
+
+		if (!isatty(STDIN_FILENO))
+			return 1;
+
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Do you want me to do it for you "
+				     "[Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
+			return 1;
+
+		return bisect_start(terms, 0, argv, 0);
+	}
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -801,6 +831,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -824,6 +855,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -890,6 +923,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
+	case BISECT_AUTOSTART:
+		if (argc)
+			return error(_("--bisect-autostart requires 0 arguments"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_autostart(&terms);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index fec527e1ef..97bb15b38f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -49,27 +49,6 @@ bisect_head()
 	fi
 }
 
-bisect_autostart() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "You need to start by \"git bisect start\"" >&2
-		if test -t 0
-		then
-			# TRANSLATORS: Make sure to include [Y] and [n] in your
-			# translation. The program will only accept English input
-			# at this point.
-			gettext "Do you want me to do it for you [Y/n]? " >&2
-			read yesno
-			case "$yesno" in
-			[Nn]*)
-				exit ;;
-			esac
-			git bisect--helper --bisect-start
-		else
-			exit 1
-		fi
-	}
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -86,7 +65,7 @@ bisect_skip() {
 }
 
 bisect_state() {
-	bisect_autostart
+	git bisect--helper --bisect-autostart
 	state=$1
 	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
 	get_terms
-- 
gitgitgadget

