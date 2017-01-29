Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9411F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 20:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbdA2UYw (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 15:24:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35401 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdA2UYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 15:24:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so4342255wmu.2
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 12:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MeGU1Of5AHrS5ujnHgFScfYDiYXJogbMkQFk/T9ieI=;
        b=AjWKyh7mOfDoctd4Ldv/0YicyxyY/72GV+4184cS0LpHTAL1zWpzEhGMI1kYJ9YKiu
         0MD/oJ9RCvpxxApp2ku+LBxePWaqFROzxz6Y50QLrodNGJKaSVFrnjTvegAjcdhnpHp2
         r4L5gp0zg/R+R+/I8qXutmBoM3YSbGOilmXRIYcaEs6gAUQCdXXuaIi+ZNgaDvrfAZBH
         Gf28tpRrx3OEheJS1hRM5SassgaXcBstX28MM/pmYxWmhQX7ISEeUCMiWNZ8RqSLnqC/
         4m6CBKF9YnF59h2eJmpsBawtmPsVz0ZBTPsTQj+s12QXZjyuyuwX0YjHebgb0ihh/MlO
         EJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MeGU1Of5AHrS5ujnHgFScfYDiYXJogbMkQFk/T9ieI=;
        b=Uc/I6El6C7eT2xrGvETrEU4LVD/R0PjrxakTMF/Hgfs8MzMKL8O2jol9k0lkNmjCck
         ndBJ4MfoQU/1wXaBP6RxAJWc55Vwh2I1hMH5GVLWBhldSKxJB1IfGP7FW8Q7L9iQC61V
         gEvRLVSF5KyT8ch7mHJNv5kW4vLtx+Yc+2KDggzNJ0uvb9h44jOXxMa/EF1it0jnEJxY
         q05UFRT8CK6B+5Cbi8y/JmktaoQEtXsqxPm1zpR4xBU4HlPVwfj4GaSfCXsyGKGhWuox
         zJfLvcLcIYxMdD9a/pH3eX5cMavaqNfr2hUa2kwHRlzZrJ+lWDKs9y3HSKraosqgkrod
         GCJw==
X-Gm-Message-State: AIkVDXJX1rORdnbQu9xKDFLPSC0Bc23mgXojdNDm/Rpvulj7el5K2zS3mh7t07Of+oVU/w==
X-Received: by 10.28.34.194 with SMTP id i185mr10743299wmi.118.1485720949982;
        Sun, 29 Jan 2017 12:15:49 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id z67sm19329301wrb.49.2017.01.29.12.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 12:15:49 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/4] stash: create filename argument
Date:   Sun, 29 Jan 2017 20:16:00 +0000
Message-Id: <20170129201604.30445-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.297.g9a2118ac0b.dirty
In-Reply-To: <20170121200804.19009-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous round is at:
http://public-inbox.org/git/20170121200804.19009-1-t.gummerer@gmail.com/.
Thanks Junio, Peff, Øyvind, Jakub and Johannes for your feedback on
the previous round.

Changes since the previous round:

- Re-phrased the Documentation update.
- Added missing $ in 2/3
- Added an extra patch introducing a new syntax for git stash create,
  where the message can be specified with the -m flag, instead of as a
  positional argument
- Filenames with $IFS in their name are now supported.  Added a test
  for that as well.

Interdiff below:

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 871a3b246c..8306bac397 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -20,6 +20,8 @@ SYNOPSIS
 	     [--] [<paths>...]
 'git stash' clear
 'git stash' create [<message>]
+'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
+	     [-- <paths>...]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
@@ -51,8 +53,8 @@ OPTIONS
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<paths>...]::
 
-	Save your local modifications to a new 'stash', and revert the
-	the changes in the working tree to match the index.
+	Save your local modifications to a new 'stash' and roll them
+	back both in the working tree and in the index.
 	The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
diff --git a/git-stash.sh b/git-stash.sh
index 7dcce629bd..0072a38b4c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -56,25 +56,57 @@ clear_stash () {
 }
 
 create_stash () {
+	stash_msg=
+	untracked=
+	new_style=
 	files=
 	while test $# != 0
 	do
 		case "$1" in
+		-m|--message)
+			shift
+			stash_msg="$1"
+			new_style=t
+			;;
+		-u|--include-untracked)
+			shift
+			untracked="$1"
+			new_style=t
+			;;
 		--)
 			shift
+			files="$@"
+			new_style=t
 			break
 			;;
-		--files)
-			;;
 		*)
-			files="$1 $files"
+			if test -n "$new_style"
+			then
+				echo "invalid argument"
+				option="$1"
+				# TRANSLATORS: $option is an invalid option, like
+				# `--blah-blah'. The 7 spaces at the beginning of the
+				# second line correspond to "error: ". So you should line
+				# up the second line with however many characters the
+				# translation of "error: " takes in your language. E.g. in
+				# English this is:
+				#
+				#    $ git stash save --blah-blah 2>&1 | head -n 2
+				#    error: unknown option for 'stash save': --blah-blah
+				#           To provide a message, use git stash save -- '--blah-blah'
+				eval_gettextln "error: unknown option for 'stash create': \$option"
+				usage
+			fi
+			break
 			;;
 		esac
 		shift
 	done
 
-	stash_msg="$1"
-	untracked="$2"
+	if test -z "$new_style"
+	then
+		stash_msg="$*"
+	fi
 
 	git update-index -q --refresh
 	if no_changes
@@ -284,7 +316,7 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash --files $files -- "$stash_msg" "$untracked"
+	create_stash -m "$stash_msg" -u "$untracked" -- $files
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
@@ -293,9 +325,9 @@ push_stash () {
 	then
 		if test -n "$files"
 		then
-			git reset -- $files
-			git checkout HEAD -- $(git ls-files --modified -- $files)
-			git clean --force --quiet -- $(git ls-files --others -- $files)
+			git ls-files -z -- "$@" | xargs -0 git reset --
+			git ls-files -z --modified -- "$@" | xargs -0 git checkout HEAD --
+			git ls-files -z --others -- "$@" | xargs -0 git clean --force --
 		else
 			git reset --hard ${GIT_QUIET:+-q}
 		fi
@@ -373,14 +405,9 @@ save_stash () {
 		shift
 	done
 
-	# if test -n "$patch_mode" && test -n "$untracked"
-	# then
-	# 	die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
-	# fi
-
 	stash_msg="$*"
 
-	if test -z stash_msg
+	if test -z "$stash_msg"
 	then
 		push_stash $push_options
 	else
@@ -728,7 +755,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash -- "$*" && echo "$w_commit"
+	create_stash "$@" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3e763ff766..ca4c44aa9c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,6 +784,24 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'deprecated version of stash create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create "create test message") &&
+	echo "On master: create test message" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'new style stash create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create -m "create test message new style") &&
+	echo "On master: create test message new style" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash -- <filename> stashes and restores the file' '
 	>foo &&
 	>bar &&
@@ -811,4 +829,19 @@ test_expect_success 'stash with multiple filename arguments' '
 	test_path_is_file extra
 '
 
+test_expect_success 'stash with file including $IFS character' '
+	>"foo	bar" &&
+	>foo &&
+	>untracked &&
+	git add foo* &&
+	git stash push -- foo* &&
+	test_path_is_missing "foo	bar" &&
+	test_path_is_missing foo &&
+	test_path_is_file untracked &&
+	git stash pop &&
+	test_path_is_file "foo	bar" &&
+	test_path_is_file foo &&
+	test_path_is_file untracked
+'
+
 test_done

Thomas Gummerer (4):
  Documentation/stash: remove mention of git reset --hard
  stash: introduce push verb
  introduce new format for git stash create
  stash: support filename argument

 Documentation/git-stash.txt |  14 +++-
 git-stash.sh                | 154 ++++++++++++++++++++++++++++++++++++++++----
 t/t3903-stash.sh            |  69 ++++++++++++++++++++
 3 files changed, 222 insertions(+), 15 deletions(-)

-- 
2.11.0.297.g9a2118ac0b.dirty

