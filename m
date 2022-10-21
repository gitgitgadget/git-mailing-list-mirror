Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA11BC4321E
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJUPOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJUPNx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6590110DE41
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f11so4892961wrm.6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut+xy5XYlXlpAwbLAcjtmwQZAsBzHKwqZnS6hCBqI7M=;
        b=Dlfp05HiMINYHxuV/DrInGRaJLAVY/ReNXnrfIpK31HL1npMf6feRp4eLcOz8l2IfB
         LgrwnZYyCXNjryOQSASpy2uH6VcJaUfRWeAeUynBtqw73gXo0ZH1t0G0LTJ1bONr01UP
         ket8DT6OCjxL3WOeBX0WbW5TidaHtqWIN9cJFpUCDsFBF09LkIgVJzsOsWX7JX8owqOg
         9thTgyhQETI6YgmURMQq/8ck8dHFbY16eNS6txt/4hKbgYrnzWl9e6CcUl866j6z5yWx
         SDnKHYrLMclsA/lN88fRpfEj7Y995u9URqV1Ajt8qrBzqlUuaebfrWdNbmdxtA2Ez63H
         zAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut+xy5XYlXlpAwbLAcjtmwQZAsBzHKwqZnS6hCBqI7M=;
        b=gv51wMw36m+5PM4muYgggjceSEYXEcsT4GNvK/HHvRH+M/uCpJef8MwXGCTVaBg6V7
         Sxwq4t6WP6FiQQt2NCbjXFCv9spqJdYTl9Mbf0RvyuNXRKWx/c+apev2XneIs8t6ZWzq
         OVLDHzPmp/iaPasF9alrW/r1NsWbojjWNv/VkxSMZ0u15ayfAK0ZteVVI2nw4MJ1s6Kh
         3YO4NGJzcJvNHEx5kPD8xY4PLw2bGR/HwL3eRiupx+gbi2CkB+9vEwpEAe9yLNbT7a0v
         7zpQTe5fOX66C6dCE5QychuvXHASPf5xC9WGUQM7bVxuB1M9pws+XVFb8963fuKRKOba
         MH3A==
X-Gm-Message-State: ACrzQf03Jo7OZ1nkYQAyypj8Cs8l5jSmHMYb819u+4sBqP2wjM5czC+3
        jrjP1zhCSo9WAmlBUhISkJqYd5sxMJM=
X-Google-Smtp-Source: AMsMyM4iqE/acKvVQ9v1eJ2J3cFVcIHUeIWKLThIlLCV+6NE5k7BU55wBHekAL5Cqx7eHAe5PYh+3Q==
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id g2-20020a5d64e2000000b0022e7060b4a7mr12085632wri.129.1666365228561;
        Fri, 21 Oct 2022 08:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10662030wms.0.2022.10.21.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:48 -0700 (PDT)
Message-Id: <a70fda5582d6bd84b8bedaba33768d3886846090.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:34 +0000
Subject: [PATCH 4/9] subtree: prefix die messages with 'fatal'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Just as was done in 0008d12284 (submodule: prefix die messages with
'fatal', 2021-07-10) for 'git-submodule.sh', make the 'die' messages
outputed by 'git-subtree.sh' more in line with the rest of the code base
by prefixing them with "fatal: ", and do not capitalize their first
letter.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh     | 60 +++++++++++++++---------------
 contrib/subtree/t/t7900-subtree.sh | 12 +++---
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index f5eab198c80..89f1eb756f0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -98,7 +98,7 @@ progress () {
 assert () {
 	if ! "$@"
 	then
-		die "assertion failed: $*"
+		die "fatal: assertion failed: $*"
 	fi
 }
 
@@ -107,7 +107,7 @@ die_incompatible_opt () {
 	assert test "$#" = 2
 	opt="$1"
 	arg_command="$2"
-	die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
+	die "fatal: the '$opt' flag does not make sense with 'git subtree $arg_command'."
 }
 
 main () {
@@ -155,7 +155,7 @@ main () {
 		allow_addmerge=$arg_split_rejoin
 		;;
 	*)
-		die "Unknown command '$arg_command'"
+		die "fatal: unknown command '$arg_command'"
 		;;
 	esac
 	# Reset the arguments array for "real" flag parsing.
@@ -244,7 +244,7 @@ main () {
 			break
 			;;
 		*)
-			die "Unexpected option: $opt"
+			die "fatal: unexpected option: $opt"
 			;;
 		esac
 	done
@@ -252,17 +252,17 @@ main () {
 
 	if test -z "$arg_prefix"
 	then
-		die "You must provide the --prefix option."
+		die "fatal: you must provide the --prefix option."
 	fi
 
 	case "$arg_command" in
 	add)
 		test -e "$arg_prefix" &&
-			die "prefix '$arg_prefix' already exists."
+			die "fatal: prefix '$arg_prefix' already exists."
 		;;
 	*)
 		test -e "$arg_prefix" ||
-			die "'$arg_prefix' does not exist; use 'git subtree add'"
+			die "fatal: '$arg_prefix' does not exist; use 'git subtree add'"
 		;;
 	esac
 
@@ -282,11 +282,11 @@ cache_setup () {
 	assert test $# = 0
 	cachedir="$GIT_DIR/subtree-cache/$$"
 	rm -rf "$cachedir" ||
-		die "Can't delete old cachedir: $cachedir"
+		die "fatal: can't delete old cachedir: $cachedir"
 	mkdir -p "$cachedir" ||
-		die "Can't create new cachedir: $cachedir"
+		die "fatal: can't create new cachedir: $cachedir"
 	mkdir -p "$cachedir/notree" ||
-		die "Can't create new cachedir: $cachedir/notree"
+		die "fatal: can't create new cachedir: $cachedir/notree"
 	debug "Using cachedir: $cachedir" >&2
 }
 
@@ -342,7 +342,7 @@ cache_set () {
 		test "$oldrev" != "latest_new" &&
 		test -e "$cachedir/$oldrev"
 	then
-		die "cache for $oldrev already exists!"
+		die "fatal: cache for $oldrev already exists!"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
 }
@@ -396,7 +396,7 @@ find_latest_squash () {
 			;;
 		git-subtree-split:)
 			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
-			die "could not rev-parse split hash $b from commit $sq"
+			die "fatal: could not rev-parse split hash $b from commit $sq"
 			;;
 		END)
 			if test -n "$sub"
@@ -448,7 +448,7 @@ find_existing_splits () {
 			;;
 		git-subtree-split:)
 			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
-			die "could not rev-parse split hash $b from commit $sq"
+			die "fatal: could not rev-parse split hash $b from commit $sq"
 			;;
 		END)
 			debug "Main is: '$main'"
@@ -498,7 +498,7 @@ copy_commit () {
 			cat
 		) |
 		git commit-tree "$2" $3  # reads the rest of stdin
-	) || die "Can't copy commit $1"
+	) || die "fatal: can't copy commit $1"
 }
 
 # Usage: add_msg DIR LATEST_OLD LATEST_NEW
@@ -726,11 +726,11 @@ ensure_clean () {
 	assert test $# = 0
 	if ! git diff-index HEAD --exit-code --quiet 2>&1
 	then
-		die "Working tree has modifications.  Cannot add."
+		die "fatal: working tree has modifications.  Cannot add."
 	fi
 	if ! git diff-index --cached HEAD --exit-code --quiet 2>&1
 	then
-		die "Index has modifications.  Cannot add."
+		die "fatal: index has modifications.  Cannot add."
 	fi
 }
 
@@ -738,7 +738,7 @@ ensure_clean () {
 ensure_valid_ref_format () {
 	assert test $# = 1
 	git check-ref-format "refs/heads/$1" ||
-		die "'$1' does not look like a ref"
+		die "fatal: '$1' does not look like a ref"
 }
 
 # Usage: process_split_commit REV PARENTS
@@ -804,7 +804,7 @@ cmd_add () {
 	if test $# -eq 1
 	then
 		git rev-parse -q --verify "$1^{commit}" >/dev/null ||
-			die "'$1' does not refer to a commit"
+			die "fatal: '$1' does not refer to a commit"
 
 		cmd_add_commit "$@"
 
@@ -819,7 +819,7 @@ cmd_add () {
 
 		cmd_add_repository "$@"
 	else
-		say >&2 "error: parameters were '$*'"
+		say >&2 "fatal: parameters were '$*'"
 		die "Provide either a commit or a repository and commit."
 	fi
 }
@@ -882,9 +882,9 @@ cmd_split () {
 	elif test $# -eq 1
 	then
 		rev=$(git rev-parse -q --verify "$1^{commit}") ||
-			die "'$1' does not refer to a commit"
+			die "fatal: '$1' does not refer to a commit"
 	else
-		die "You must provide exactly one revision.  Got: '$*'"
+		die "fatal: you must provide exactly one revision.  Got: '$*'"
 	fi
 
 	if test -n "$arg_split_rejoin"
@@ -927,7 +927,7 @@ cmd_split () {
 	latest_new=$(cache_get latest_new) || exit $?
 	if test -z "$latest_new"
 	then
-		die "No new revisions were found"
+		die "fatal: no new revisions were found"
 	fi
 
 	if test -n "$arg_split_rejoin"
@@ -948,7 +948,7 @@ cmd_split () {
 		then
 			if ! git merge-base --is-ancestor "$arg_split_branch" "$latest_new"
 			then
-				die "Branch '$arg_split_branch' is not an ancestor of commit '$latest_new'."
+				die "fatal: branch '$arg_split_branch' is not an ancestor of commit '$latest_new'."
 			fi
 			action='Updated'
 		else
@@ -965,9 +965,9 @@ cmd_split () {
 # Usage: cmd_merge REV
 cmd_merge () {
 	test $# -eq 1 ||
-		die "You must provide exactly one revision.  Got: '$*'"
+		die "fatal: you must provide exactly one revision.  Got: '$*'"
 	rev=$(git rev-parse -q --verify "$1^{commit}") ||
-		die "'$1' does not refer to a commit"
+		die "fatal: '$1' does not refer to a commit"
 	ensure_clean
 
 	if test -n "$arg_addmerge_squash"
@@ -975,7 +975,7 @@ cmd_merge () {
 		first_split="$(find_latest_squash "$dir")" || exit $?
 		if test -z "$first_split"
 		then
-			die "Can't squash-merge: '$dir' was never added."
+			die "fatal: can't squash-merge: '$dir' was never added."
 		fi
 		set $first_split
 		old=$1
@@ -1003,7 +1003,7 @@ cmd_merge () {
 cmd_pull () {
 	if test $# -ne 2
 	then
-		die "You must provide <repository> <ref>"
+		die "fatal: you must provide <repository> <ref>"
 	fi
 	ensure_clean
 	ensure_valid_ref_format "$2"
@@ -1015,7 +1015,7 @@ cmd_pull () {
 cmd_push () {
 	if test $# -ne 2
 	then
-		die "You must provide <repository> <refspec>"
+		die "fatal: you must provide <repository> <refspec>"
 	fi
 	if test -e "$dir"
 	then
@@ -1030,13 +1030,13 @@ cmd_push () {
 		fi
 		ensure_valid_ref_format "$remoteref"
 		localrev_presplit=$(git rev-parse -q --verify "$localrevname_presplit^{commit}") ||
-			die "'$localrevname_presplit' does not refer to a commit"
+			die "fatal: '$localrevname_presplit' does not refer to a commit"
 
 		echo "git push using: " "$repository" "$refspec"
 		localrev=$(cmd_split "$localrev_presplit") || die
 		git push "$repository" "$localrev":"refs/heads/$remoteref"
 	else
-		die "'$dir' must already exist. Try 'git subtree add'."
+		die "fatal: '$dir' must already exist. Try 'git subtree add'."
 	fi
 }
 
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 1c1f76f04aa..249743ab9aa 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -277,7 +277,7 @@ test_expect_success 'split requires option --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		echo "You must provide the --prefix option." >expected &&
+		echo "fatal: you must provide the --prefix option." >expected &&
 		test_must_fail git subtree split >actual 2>&1 &&
 		test_debug "printf '"expected: "'" &&
 		test_debug "cat expected" &&
@@ -296,7 +296,7 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" >expected &&
+		echo "fatal: '\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" >expected &&
 		test_must_fail git subtree split --prefix=non-existent-directory >actual 2>&1 &&
 		test_debug "printf '"expected: "'" &&
 		test_debug "cat expected" &&
@@ -570,7 +570,7 @@ test_expect_success 'pull requires option --prefix' '
 		cd "$test_count" &&
 		test_must_fail git subtree pull ./"sub proj" HEAD >out 2>err &&
 
-		echo "You must provide the --prefix option." >expected &&
+		echo "fatal: you must provide the --prefix option." >expected &&
 		test_must_be_empty out &&
 		test_cmp expected err
 	)
@@ -584,7 +584,7 @@ test_expect_success 'pull requires path given by option --prefix must exist' '
 	(
 		test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" HEAD >out 2>err &&
 
-		echo "'\''sub dir'\'' does not exist; use '\''git subtree add'\''" >expected &&
+		echo "fatal: '\''sub dir'\'' does not exist; use '\''git subtree add'\''" >expected &&
 		test_must_be_empty out &&
 		test_cmp expected err
 	)
@@ -643,7 +643,7 @@ test_expect_success 'push requires option --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		echo "You must provide the --prefix option." >expected &&
+		echo "fatal: you must provide the --prefix option." >expected &&
 		test_must_fail git subtree push "./sub proj" from-mainline >actual 2>&1 &&
 		test_debug "printf '"expected: "'" &&
 		test_debug "cat expected" &&
@@ -662,7 +662,7 @@ test_expect_success 'push requires path given by option --prefix must exist' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" >expected &&
+		echo "fatal: '\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" >expected &&
 		test_must_fail git subtree push --prefix=non-existent-directory "./sub proj" from-mainline >actual 2>&1 &&
 		test_debug "printf '"expected: "'" &&
 		test_debug "cat expected" &&
-- 
gitgitgadget

