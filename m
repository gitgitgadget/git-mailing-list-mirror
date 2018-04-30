Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96C821841
	for <e@80x24.org>; Mon, 30 Apr 2018 09:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeD3JvO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:51:14 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35780 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeD3JvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:51:07 -0400
Received: by mail-wm0-f54.google.com with SMTP id o78so13294234wmg.0
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7KDrv4q7i47gtqbmpOXXj7mPBpW6PfxjF7eHCEqSVo=;
        b=oiw5+Te/A2rDSJj0BLtvBgVdBpq7Gz+kkCe3G/hMQ89S2Z9rCN6H8N+yqGioHcvatU
         RYUm53GymKNydFnmyFwhLZ+9PdnVXlqKuhAyg/7OqJ3cj0D1XWaZX56cPUFP4HA9gSg0
         Yzt5i65xgAHZPzh3mrv9Fe6CInz+cIgTH4v3wgCKUZR1Wk8yTNmT0cYmBMo5llnV3rID
         0ZmWROkxJTMCKXaeIzpAe7bAknLao0iv1Z+q8LoDe1agCHgVA4ZJjOZ5wjJXBQXdwXAk
         c6j+/vMrqYzKDJVG4bI63JrqwkWlYzqjjiiF9tjUsoItaFjyDsBL6bNEqe6xIZZovsWg
         iC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7KDrv4q7i47gtqbmpOXXj7mPBpW6PfxjF7eHCEqSVo=;
        b=HOPrKxAXKYeQ1pfxERzt3JrGCT7ru1Lqjo+yktIpoTFtjM/XukvEQcT2XVD1x1zAgV
         oXBvZ91GoMZVS8a++NAowfDXOX/b/jGXxnmOJsGCNE36MTrz9ZDZpweHOM4EJEeEl6vP
         8QvEc6c9Qhx4i2yXOfZNNPcRBvxJvqivNUXyRuoXDLIQiQbVFT+cu/l5cyNTUgQBkFpX
         DgEpGEA5tJy/Iy0qJW+Y/+vf0aLpY/ED6JrYiGgMnSAm+ACdGdDSpAmJ7uGfhuJxZrwh
         5Kp3AM7m3EyB6UR3awapnqzcbLDYo/2+31zCque0HCqftWMDeCm3dEdUE4NbvOXjDz5f
         OvOA==
X-Gm-Message-State: ALQs6tBXACYML5Lg32A3ekqeuqaPhmvfXHApIPIpu2bOTH6oqSVUOSEd
        sdAPd2DuPFFezeDd77nroL1JmhjB
X-Google-Smtp-Source: AB8JxZqXGLajELxvhOBkJB8DpiLZD99mzODTg/Zn13512Do4/4Xouc33KQHyKdX/J1Ogvb4C2xGlqA==
X-Received: by 10.28.166.23 with SMTP id p23mr6440578wme.152.1525081865310;
        Mon, 30 Apr 2018 02:51:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 42-v6sm13178687wrx.24.2018.04.30.02.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 02:51:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] i18n: translate the git-subtree command
Date:   Mon, 30 Apr 2018 09:50:44 +0000
Message-Id: <20180430095044.28492-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the advantages of having git-subtree out of contrib/ is being
able to treat it as a first-class citizen when it comes to
translations.

Mark those messages that make sense to translate for translation, and
add a comment to the ones that shouldn't be translated. This has been
tested under GIT_GETTEXT_POISON=1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-subtree.sh     | 90 +++++++++++++++++++++++++++-------------------
 t/t7900-subtree.sh |  4 +--
 2 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/git-subtree.sh b/git-subtree.sh
index 1b8cd53c7f..03ef175428 100755
--- a/git-subtree.sh
+++ b/git-subtree.sh
@@ -141,7 +141,7 @@ do
 		break
 		;;
 	*)
-		die "Unexpected option: $opt"
+		die "$(eval_gettext "Unexpected option: \$opt")"
 		;;
 	esac
 done
@@ -157,23 +157,23 @@ split|push)
 	default="--default HEAD"
 	;;
 *)
-	die "Unknown command '$command'"
+	die "$(eval_gettext "Unknown command '\$command'")"
 	;;
 esac
 
 if test -z "$prefix"
 then
-	die "You must provide the --prefix option."
+	die "$(gettext "You must provide the --prefix option.")"
 fi
 
 case "$command" in
 add)
 	test -e "$prefix" &&
-		die "prefix '$prefix' already exists."
+		die "$(eval_gettext "prefix '\$prefix' already exists.")"
 	;;
 *)
 	test -e "$prefix" ||
-		die "'$prefix' does not exist; use 'git subtree add'"
+		die "$(eval_gettext "'\$prefix' does not exist; use 'git subtree add'")"
 	;;
 esac
 
@@ -187,7 +187,7 @@ then
 	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
 	if test -n "$dirs"
 	then
-		die "Error: Use --prefix instead of bare filenames."
+		die "$(gettext "Error: Use --prefix instead of bare filenames.")"
 	fi
 fi
 
@@ -201,12 +201,12 @@ debug
 cache_setup () {
 	cachedir="$GIT_DIR/subtree-cache/$$"
 	rm -rf "$cachedir" ||
-		die "Can't delete old cachedir: $cachedir"
+		die "$(eval_gettext "Can't delete old cachedir: \$cachedir")"
 	mkdir -p "$cachedir" ||
-		die "Can't create new cachedir: $cachedir"
+		die "$(eval_gettext "Can't create new cachedir: \$cachedir")"
 	mkdir -p "$cachedir/notree" ||
-		die "Can't create new cachedir: $cachedir/notree"
-	debug "Using cachedir: $cachedir" >&2
+		die "$(eval_gettext "Can't create new cachedir: \$cachedir/notree")"
+	debug "$(eval_gettext "Using cachedir: \$cachedir")" >&2
 }
 
 cache_get () {
@@ -252,7 +252,7 @@ cache_set () {
 		test "$oldrev" != "latest_new" &&
 		test -e "$cachedir/$oldrev"
 	then
-		die "cache for $oldrev already exists!"
+		die "$(eval_gettext "cache for \$oldrev already exists!")"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
 }
@@ -311,7 +311,7 @@ find_latest_squash () {
 			;;
 		git-subtree-split:)
 			sub="$(git rev-parse "$b^0")" ||
-			die "could not rev-parse split hash $b from commit $sq"
+			die "$(eval_gettext "could not rev-parse split hash \$b from commit \$sq")"
 			;;
 		END)
 			if test -n "$sub"
@@ -353,7 +353,7 @@ find_existing_splits () {
 			;;
 		git-subtree-split:)
 			sub="$(git rev-parse "$b^0")" ||
-			die "could not rev-parse split hash $b from commit $sq"
+			die "$(eval_gettext "could not rev-parse split hash \$b from commit \$sq")"
 			;;
 		END)
 			debug "  Main is: '$main'"
@@ -401,7 +401,10 @@ copy_commit () {
 			cat
 		) |
 		git commit-tree "$2" $3  # reads the rest of stdin
-	) || die "Can't copy commit $1"
+	) || {
+		commit="$1"
+		die "$(eval_gettext "Can't copy commit \$commit")"
+	}
 }
 
 add_msg () {
@@ -412,6 +415,7 @@ add_msg () {
 	then
 		commit_message="$message"
 	else
+		# i18n: This message must not be translated!
 		commit_message="Add '$dir/' from commit '$latest_new'"
 	fi
 	cat <<-EOF
@@ -428,6 +432,7 @@ add_squashed_msg () {
 	then
 		echo "$message"
 	else
+		# i18n: This message must not be translated!
 		echo "Merge commit '$1' as '$2'"
 	fi
 }
@@ -440,6 +445,7 @@ rejoin_msg () {
 	then
 		commit_message="$message"
 	else
+		# i18n: This message must not be translated!
 		commit_message="Split '$dir/' into commit '$latest_new'"
 	fi
 	cat <<-EOF
@@ -460,12 +466,12 @@ squash_msg () {
 	if test -n "$oldsub"
 	then
 		oldsub_short=$(git rev-parse --short "$oldsub")
-		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
+		echo "$(eval_gettext "Squashed '\$dir/' changes from \$oldsub_short..\$newsub_short")"
 		echo
 		git log --no-show-signature --pretty=tformat:'%h %s' "$oldsub..$newsub"
 		git log --no-show-signature --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
 	else
-		echo "Squashed '$dir/' content from commit $newsub_short"
+		echo "$(eval_gettext "Squashed '\$dir/' content from commit \$newsub_short")"
 	fi
 
 	echo
@@ -585,31 +591,35 @@ copy_or_skip () {
 ensure_clean () {
 	if ! git diff-index HEAD --exit-code --quiet 2>&1
 	then
-		die "Working tree has modifications.  Cannot add."
+		die "$(gettext "Working tree has modifications.  Cannot add.")"
 	fi
 	if ! git diff-index --cached HEAD --exit-code --quiet 2>&1
 	then
-		die "Index has modifications.  Cannot add."
+		die "$(gettext "Index has modifications.  Cannot add.")"
 	fi
 }
 
 ensure_valid_ref_format () {
-	git check-ref-format "refs/heads/$1" ||
-		die "'$1' does not look like a ref"
+	git check-ref-format "refs/heads/$1" || {
+		reference="$1"
+		die "$(eval_gettext "'\$reference' does not look like a ref")"
+	}
 }
 
 cmd_add () {
 	if test -e "$dir"
 	then
-		die "'$dir' already exists.  Cannot add."
+		die "$(eval_gettext "'\$dir' already exists.  Cannot add.")"
 	fi
 
 	ensure_clean
 
 	if test $# -eq 1
 	then
-		git rev-parse -q --verify "$1^{commit}" >/dev/null ||
-			die "'$1' does not refer to a commit"
+		git rev-parse -q --verify "$1^{commit}" >/dev/null || {
+			reference="$1"
+			die "$(eval_gettext "'\$reference' does not refer to a commit")"
+		}
 
 		cmd_add_commit "$@"
 
@@ -625,7 +635,7 @@ cmd_add () {
 		cmd_add_repository "$@"
 	else
 		say "error: parameters were '$@'"
-		die "Provide either a commit or a repository and commit."
+		die "$(gettext "Provide either a commit or a repository and commit.")"
 	fi
 }
 
@@ -669,7 +679,7 @@ cmd_add_commit () {
 	fi
 	git reset "$commit" || exit $?
 
-	say "Added dir '$dir'"
+	say "$(eval_gettext "Added dir '\$dir'")"
 }
 
 cmd_split () {
@@ -747,7 +757,7 @@ cmd_split () {
 	latest_new=$(cache_get latest_new)
 	if test -z "$latest_new"
 	then
-		die "No new revisions were found"
+		die "$(gettext "No new revisions were found")"
 	fi
 
 	if test -n "$rejoin"
@@ -765,15 +775,23 @@ cmd_split () {
 		then
 			if ! rev_is_descendant_of_branch "$latest_new" "$branch"
 			then
-				die "Branch '$branch' is not an ancestor of commit '$latest_new'."
+				die "$(eval_gettext "Branch '\$branch' is not an ancestor of commit '\$latest_new'.")"
 			fi
-			action='Updated'
+			action='updated'
 		else
-			action='Created'
+			action='created'
 		fi
 		git update-ref -m 'subtree split' \
 			"refs/heads/$branch" "$latest_new" || exit $?
-		say "$action branch '$branch'"
+		if test $action = 'created'
+		then
+			say "$(eval_gettext "Created branch '\$branch'")"
+		elif test $action = 'updated'
+		then
+			say "$(eval_gettext "Updated branch '\$branch'")"
+		else
+			die "BUG: Should have updated the created/updated if/else!"
+		fi
 	fi
 	echo "$latest_new"
 	exit 0
@@ -786,7 +804,7 @@ cmd_merge () {
 	set -- $revs
 	if test $# -ne 1
 	then
-		die "You must provide exactly one revision.  Got: '$revs'"
+		die "$(eval_gettext "You must provide exactly one revision.  Got: '\$revs'")"
 	fi
 	rev="$1"
 
@@ -795,14 +813,14 @@ cmd_merge () {
 		first_split="$(find_latest_squash "$dir")"
 		if test -z "$first_split"
 		then
-			die "Can't squash-merge: '$dir' was never added."
+			die "$(eval_gettext "Can't squash-merge: '\$dir' was never added.")"
 		fi
 		set $first_split
 		old=$1
 		sub=$2
 		if test "$sub" = "$rev"
 		then
-			say "Subtree is already at commit $rev."
+			say "$(eval_gettext "Subtree is already at commit \$rev.")"
 			exit 0
 		fi
 		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
@@ -822,7 +840,7 @@ cmd_merge () {
 cmd_pull () {
 	if test $# -ne 2
 	then
-		die "You must provide <repository> <ref>"
+		die "$(gettext "You must provide <repository> <ref>")"
 	fi
 	ensure_clean
 	ensure_valid_ref_format "$2"
@@ -835,7 +853,7 @@ cmd_pull () {
 cmd_push () {
 	if test $# -ne 2
 	then
-		die "You must provide <repository> <ref>"
+		die "$(gettext "You must provide <repository> <ref>")"
 	fi
 	ensure_valid_ref_format "$2"
 	if test -e "$dir"
@@ -846,7 +864,7 @@ cmd_push () {
 		localrev=$(git subtree split --prefix="$prefix") || die
 		git push "$repository" "$localrev":"refs/heads/$refspec"
 	else
-		die "'$dir' must already exist. Try 'git subtree add'."
+		die "$(eval_gettext "'\$dir' must already exist. Try 'git subtree add'.")"
 	fi
 }
 
diff --git a/t/t7900-subtree.sh b/t/t7900-subtree.sh
index a6e7103f92..009daa0c84 100755
--- a/t/t7900-subtree.sh
+++ b/t/t7900-subtree.sh
@@ -304,7 +304,7 @@ test_expect_success 'split requires option --prefix' '
 		test_debug "cat expected" &&
 		test_debug "printf '"actual: "'" &&
 		test_debug "cat actual" &&
-		test_cmp expected actual
+		test_i18ncmp expected actual
 	)
 '
 
@@ -324,7 +324,7 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 		test_debug "cat expected" &&
 		test_debug "printf '"actual: "'" &&
 		test_debug "cat actual" &&
-		test_cmp expected actual
+		test_i18ncmp expected actual
 	)
 '
 
-- 
2.17.0.290.gded63e768a

