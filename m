Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DC71F51C
	for <e@80x24.org>; Mon, 21 May 2018 05:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeEUFwT (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 01:52:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52443 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeEUFwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 01:52:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id w194-v6so23111806wmf.2
        for <git@vger.kernel.org>; Sun, 20 May 2018 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NISLfb5nkkto02fRFwMtw9f5qnXmizHjzE6mGmnOCg8=;
        b=jvgt1FLTv5vxZ2NQ9AcGi3WjnMMkeo61zbuL6fYmNSGQv4QfF5UU+2zHUeHOM4YQPr
         u0m8tgmo5g/Uniw6P7vMLEpQvGipGQ72Mg+yXT1IEaqrRI9xELN8qLw5YPGgT3gH84gL
         LuN5nfzOOIJNhaVCGvzCxHpRRyS1U+zSUGjT5O92PEvJXFU6SgpGYdt/UX28piaMefYv
         NuhdfehPA7YDzd7vLxvwa3wtrRuaPnnpZojexvWm3orVzVN6e3yO56J+SqaSdjPesGyV
         MQGEtPxtBs5v7s+5v0py1el5rGQcCeW+CEjfsg8dtLsp/7VUn0tDYM6e2ERO6A3dSs2v
         rYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NISLfb5nkkto02fRFwMtw9f5qnXmizHjzE6mGmnOCg8=;
        b=bgxPiI7DUDN0Hs6Xf9ksrtMJSvbDq1hvrYa5WEUUHxgNPOL0ZDUFJdl+9qCmCX6uIi
         NxcVd+TCmJKEPHCXM26GXlXIPedPkDSjTBcuQ2gcksV74qrwrzvqAFWfGvkFgH/AAbG2
         Wl9dIiPt2gC2EXXZiXhBTzMruk3ty8+FeASUmfNybHFaY/NKWI6Qu1eMhCuRSx+0JmJT
         ZMbpUnISpEdN3I6/OIq3ECDARGHK6QrqphuISC8gpSO+JYW9fzRA6mz+TzLr7g0XmEfL
         bZ36+8hL+B2YfaPWvCoTA0YIDNquoJqyiuN+ZbaKG0BHqt+8chGOEZYekSZ7imennmDP
         pelQ==
X-Gm-Message-State: ALKqPwfDQxMK4z7oD/ca4G1Pl3cIaDEN8a+vLIKVcpeX9Drk8u7z0ulR
        aOFf4TgttqsYHmlxwi1shtZybdL7
X-Google-Smtp-Source: AB8JxZp+5n1yKI+JgbYf1qAfCa8tcHvXenwGpITy5XC36YP9J08HLN53yljoMOYuMjkKofsD8VNNQA==
X-Received: by 2002:a1c:e854:: with SMTP id f81-v6mr9465633wmh.14.1526881935030;
        Sun, 20 May 2018 22:52:15 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h12-v6sm11367044wmc.7.2018.05.20.22.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 22:52:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Subject: [PATCH] t: make many tests depend less on the refs being files
Date:   Mon, 21 May 2018 07:51:43 +0200
Message-Id: <20180521055143.14701-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

So that they work under alternate ref storage backends.

This will be really needed when such alternate ref storage backends are
developed. But this could already help by making clear to readers that
some tests do not depend on which ref backend is used.

This patch just takes care of many low hanging fruits. It does not try
to completely solves the issue.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Thanks for all the great feedback regarding implementing reftable [1].

Looking at David Turner's tests in [2], it seems that they could indeed
be already valuable, so let's start by extracting most of the simple
improvements they make. 

[1] https://public-inbox.org/git/CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com/
[2] https://github.com/dturner-tw/git/tree/dturner/pluggable-backends

 t/lib-t6000.sh                   |  5 ++---
 t/t1401-symbolic-ref.sh          |  2 +-
 t/t3200-branch.sh                | 18 +++++++++---------
 t/t3903-stash.sh                 |  2 +-
 t/t5500-fetch-pack.sh            | 10 +++++-----
 t/t5510-fetch.sh                 |  6 +++---
 t/t6010-merge-base.sh            |  2 +-
 t/t7201-co.sh                    |  2 +-
 t/t9104-git-svn-follow-parent.sh |  3 ++-
 t/t9903-bash-prompt.sh           |  2 +-
 10 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index 3f2d873fec..b8567cdf94 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -4,11 +4,10 @@ mkdir -p .git/refs/tags
 
 >sed.script
 
-# Answer the sha1 has associated with the tag. The tag must exist in .git/refs/tags
+# Answer the sha1 has associated with the tag. The tag must exist under refs/tags
 tag () {
 	_tag=$1
-	test -f ".git/refs/tags/$_tag" || error "tag: \"$_tag\" does not exist"
-	cat ".git/refs/tags/$_tag"
+	git rev-parse --verify "refs/tags/$_tag" || error "tag: \"$_tag\" does not exist"
 }
 
 # Generate a commit using the text specified to make it unique and the tree
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 9e782a8122..a4ebb0b65f 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -65,7 +65,7 @@ reset_to_sane
 test_expect_success 'symbolic-ref fails to delete real ref' '
 	echo "fatal: Cannot delete refs/heads/foo, not a symbolic ref" >expect &&
 	test_must_fail git symbolic-ref -d refs/heads/foo >actual 2>&1 &&
-	test_path_is_file .git/refs/heads/foo &&
+	git rev-parse --verify refs/heads/foo &&
 	test_cmp expect actual
 '
 reset_to_sane
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c0ef946811..222dc2c377 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -234,34 +234,34 @@ test_expect_success 'git branch -M master2 master2 should work when master is ch
 
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse --verify refs/heads/t &&
 	git branch -v -d t &&
-	test_path_is_missing .git/refs/heads/t
+	test_must_fail git rev-parse --verify refs/heads/t
 '
 
 test_expect_success 'git branch -v -m t s should work' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse --verify refs/heads/t &&
 	git branch -v -m t s &&
-	test_path_is_missing .git/refs/heads/t &&
-	test_path_is_file .git/refs/heads/s &&
+	test_must_fail git rev-parse --verify refs/heads/t &&
+	git rev-parse --verify refs/heads/s &&
 	git branch -d s
 '
 
 test_expect_success 'git branch -m -d t s should fail' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse refs/heads/t &&
 	test_must_fail git branch -m -d t s &&
 	git branch -d t &&
-	test_path_is_missing .git/refs/heads/t
+	test_must_fail git rev-parse refs/heads/t
 '
 
 test_expect_success 'git branch --list -d t should fail' '
 	git branch t &&
-	test_path_is_file .git/refs/heads/t &&
+	git rev-parse refs/heads/t &&
 	test_must_fail git branch --list -d t &&
 	git branch -d t &&
-	test_path_is_missing .git/refs/heads/t
+	test_must_fail git rev-parse refs/heads/t
 '
 
 test_expect_success 'git branch --list -v with --abbrev' '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b172..1f871d3cca 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -726,7 +726,7 @@ test_expect_success 'store updates stash ref and reflog' '
 	git reset --hard &&
 	! grep quux bazzy &&
 	git stash store -m quuxery $STASH_ID &&
-	test $(cat .git/refs/stash) = $STASH_ID &&
+	test $(git rev-parse stash) = $STASH_ID &&
 	git reflog --format=%H stash| grep $STASH_ID &&
 	git stash pop &&
 	grep quux bazzy
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 0680dec808..886a9e3b72 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -30,7 +30,7 @@ add () {
 	test_tick &&
 	commit=$(echo "$text" | git commit-tree $tree $parents) &&
 	eval "$name=$commit; export $name" &&
-	echo $commit > .git/refs/heads/$branch &&
+	git update-ref refs/heads/$branch $commit &&
 	eval ${branch}TIP=$commit
 }
 
@@ -45,10 +45,10 @@ pull_to_client () {
 
 			case "$heads" in
 			    *A*)
-				    echo $ATIP > .git/refs/heads/A;;
+				    git update-ref refs/heads/A $ATIP;;
 			esac &&
 			case "$heads" in *B*)
-			    echo $BTIP > .git/refs/heads/B;;
+			    git update-ref refs/heads/B $BTIP;;
 			esac &&
 			git symbolic-ref HEAD refs/heads/$(echo $heads \
 				| sed -e "s/^\(.\).*$/\1/") &&
@@ -92,8 +92,8 @@ test_expect_success 'setup' '
 		cur=$(($cur+1))
 	done &&
 	add B1 $A1 &&
-	echo $ATIP > .git/refs/heads/A &&
-	echo $BTIP > .git/refs/heads/B &&
+	git update-ref refs/heads/A $ATIP &&
+	git update-ref refs/heads/B $BTIP &&
 	git symbolic-ref HEAD refs/heads/B
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ae5a530a2d..e402aee6a2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -63,7 +63,7 @@ test_expect_success "fetch test" '
 	git commit -a -m "updated by origin" &&
 	cd two &&
 	git fetch &&
-	test -f .git/refs/heads/one &&
+	git rev-parse --verify refs/heads/one &&
 	mine=$(git rev-parse refs/heads/one) &&
 	his=$(cd ../one && git rev-parse refs/heads/master) &&
 	test "z$mine" = "z$his"
@@ -73,8 +73,8 @@ test_expect_success "fetch test for-merge" '
 	cd "$D" &&
 	cd three &&
 	git fetch &&
-	test -f .git/refs/heads/two &&
-	test -f .git/refs/heads/one &&
+	git rev-parse --verify refs/heads/two &&
+	git rev-parse --verify refs/heads/one &&
 	master_in_two=$(cd ../two && git rev-parse master) &&
 	one_in_two=$(cd ../two && git rev-parse one) &&
 	{
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 31db7b5f91..56c4d91812 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -34,7 +34,7 @@ doit () {
 
 	commit=$(echo $NAME | git commit-tree $T $PARENTS) &&
 
-	echo $commit >.git/refs/tags/$NAME &&
+	git update-ref refs/tags/$NAME $commit &&
 	echo $commit
 }
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 76c223c967..ab9da61da3 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -65,7 +65,7 @@ test_expect_success setup '
 test_expect_success "checkout from non-existing branch" '
 
 	git checkout -b delete-me master &&
-	rm .git/refs/heads/delete-me &&
+	git update-ref -d --no-deref refs/heads/delete-me &&
 	test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
 	git checkout master &&
 	test refs/heads/master = "$(git symbolic-ref HEAD)"
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index a735fa3717..9c49b6c1fe 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -215,7 +215,8 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" '
-	rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
+	rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
+	git reflog expire --all --expire=all &&
 	mkdir "$GIT_DIR/svn" &&
 	git svn multi-fetch
 	'
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 8f5c811dd7..c3b89ae783 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory' '
 test_expect_success 'prompt - deep inside .git directory' '
 	printf " (GIT_DIR!)" >expected &&
 	(
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
-- 
2.17.0.582.gccdcbd54c4.dirty

