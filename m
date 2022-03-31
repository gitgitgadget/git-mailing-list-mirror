Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA6EC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiCaR4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiCaR4L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 13:56:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535EB60CDA
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 10:54:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w4so795895wrg.12
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwxwLfATeyXxTlrlzWWSwpvOB3cm2JLFT8I7lnwDkIs=;
        b=YmDb0vzgXXKOGIKKfnTA84Zhsa2nR7cmf6/oU7TNtexNbowY96ZRXmbDWcFv4ONwYB
         lpLsAMbemiCj5+ersW8uSGxXXWbfxsz0asHc6+Kv7d22Zuo56befO2frlHUux1CWlFun
         bfaSZ1Ysj/XtN1S8tvwd+dTjSVnQxT0YE3cbDbeRiIswfTiWZbnRla6W3tAlxS3rqPgC
         Xf7Yi1sJL0ogsEn3RS+v17FleOcIQRqPUZetDH4ZnWs6i8N/WlrmIj8Jo8Xqd07/nmuw
         Q1z7ecLa4xG00vR3R5SgnYi2+o9KqD8JKO0KKRv80P6OU59ABeHz2J6PhV5oPbDuYAv8
         YqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwxwLfATeyXxTlrlzWWSwpvOB3cm2JLFT8I7lnwDkIs=;
        b=PO6Psz3RGnGUfdPvgQs9TJrJ6Jyus1bgw/JDnPzkTTb5naRGSBntD/qkjM3OWgNgRy
         p6w2V11ECH42AvWwM81JPT61VqIYWBDO3waQVXtnRRNBZ6xCzgkB9c2dlzd9EFQHdH0C
         L8ld3Uowq8IbxQDb7DJk9RFPF16cptMITU9W5k84shE+WYmMvxtxNY/P3GJD1Ko8MvOf
         pT4Ot5nDN1gOS/pAfMSjYApGsB8i4UEQdzqt1jldcIEQZnsE8mS7LkHBX2uLvHKXzvJK
         clAE9tX3IHnvWX+NhSvhMcBb2QXL8EkQrcsrzSOXUHrz6NY/5Ae7zQbYUbeixn6mmipr
         wXfA==
X-Gm-Message-State: AOAM530muwp/+rw6uGg/wSMkvPxeoyMZtljOAgtAe3SsGPAQ9Ps8Q0tK
        gYqZ5DrHy/X7moQOy39UcQTi0LQIk1g=
X-Google-Smtp-Source: ABdhPJwtwcz7LRfcqYfOK2Y84PZ5thtT5D8zJQhAn0jQPb7OomVejfCu3PYa7XtU0M/P5h21gJCp2A==
X-Received: by 2002:adf:e684:0:b0:203:ed86:d5aa with SMTP id r4-20020adfe684000000b00203ed86d5aamr4938370wrm.706.1648749258960;
        Thu, 31 Mar 2022 10:54:18 -0700 (PDT)
Received: from fedora35.example.com ([151.24.244.110])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d64a3000000b00203ed35b0aesm109909wrp.108.2022.03.31.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:54:18 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] t5510-fetch: upgrade to a more modern style
Date:   Thu, 31 Mar 2022 17:54:12 +0000
Message-Id: <20220331175412.305968-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up the code style so all the tests, and not just a few,
that chdir around isolate themselves in a subshell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
this patch was inspired by a Junio #leftoverbit
https://lore.kernel.org/git/xmqqmtjh0x5f.fsf@gitster.g/
 t/t5510-fetch.sh | 927 ++++++++++++++++++++++++-----------------------
 1 file changed, 477 insertions(+), 450 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6f38a69fbb..d0b249d276 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -48,342 +48,349 @@ test_expect_success "clone and setup child repos" '
 '
 
 test_expect_success "fetch test" '
-	cd "$D" &&
-	echo >file updated by origin &&
-	git commit -a -m "updated by origin" &&
-	cd two &&
-	git fetch &&
-	git rev-parse --verify refs/heads/one &&
-	mine=$(git rev-parse refs/heads/one) &&
-	his=$(cd ../one && git rev-parse refs/heads/main) &&
-	test "z$mine" = "z$his"
+	(
+		cd "$D" &&
+		echo >file updated by origin &&
+		git commit -a -m "updated by origin" &&
+		(
+			cd two &&
+			git fetch &&
+			git rev-parse --verify refs/heads/one &&
+			mine=$(git rev-parse refs/heads/one) &&
+			his=$(cd ../one && git rev-parse refs/heads/main) &&
+			test "z$mine" = "z$his"
+		)
+	)
 '
 
 test_expect_success "fetch test for-merge" '
-	cd "$D" &&
-	cd three &&
-	git fetch &&
-	git rev-parse --verify refs/heads/two &&
-	git rev-parse --verify refs/heads/one &&
-	main_in_two=$(cd ../two && git rev-parse main) &&
-	one_in_two=$(cd ../two && git rev-parse one) &&
-	{
-		echo "$one_in_two	" &&
-		echo "$main_in_two	not-for-merge"
-	} >expected &&
-	cut -f -2 .git/FETCH_HEAD >actual &&
-	test_cmp expected actual'
+	(
+		cd "$D" &&
+		(
+			cd three &&
+			git fetch &&
+			git rev-parse --verify refs/heads/two &&
+			git rev-parse --verify refs/heads/one &&
+			main_in_two=$(cd ../two && git rev-parse main) &&
+			one_in_two=$(cd ../two && git rev-parse one) &&
+			{
+				echo "$one_in_two	" &&
+				echo "$main_in_two	not-for-merge"
+			} >expected &&
+			cut -f -2 .git/FETCH_HEAD >actual &&
+			test_cmp expected actual
+		)
+	)
+'
 
 test_expect_success 'fetch --prune on its own works as expected' '
-	cd "$D" &&
-	git clone . prune &&
-	cd prune &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-
-	git fetch --prune origin &&
-	test_must_fail git rev-parse origin/extrabranch
+	(
+		cd "$D" &&
+		git clone . prune &&
+		cd prune &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		git fetch --prune origin &&
+		test_must_fail git rev-parse origin/extrabranch
+	)
 '
 
 test_expect_success 'fetch --prune with a branch name keeps branches' '
-	cd "$D" &&
-	git clone . prune-branch &&
-	cd prune-branch &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-
-	git fetch --prune origin main &&
-	git rev-parse origin/extrabranch
+	(
+		cd "$D" &&
+		git clone . prune-branch &&
+		cd prune-branch &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		git fetch --prune origin main &&
+		git rev-parse origin/extrabranch
+	)
 '
 
 test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
-	cd "$D" &&
-	git clone . prune-namespace &&
-	cd prune-namespace &&
-
-	git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
-	git rev-parse origin/main
+	(
+		cd "$D" &&
+		git clone . prune-namespace &&
+		cd prune-namespace &&
+		git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
+		git rev-parse origin/main
+	)
 '
 
 test_expect_success 'fetch --prune handles overlapping refspecs' '
-	cd "$D" &&
-	git update-ref refs/pull/42/head main &&
-	git clone . prune-overlapping &&
-	cd prune-overlapping &&
-	git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
-
-	git fetch --prune origin &&
-	git rev-parse origin/main &&
-	git rev-parse origin/pr/42 &&
-
-	git config --unset-all remote.origin.fetch &&
-	git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
-	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
-
-	git fetch --prune origin &&
-	git rev-parse origin/main &&
-	git rev-parse origin/pr/42
+	(
+		cd "$D" &&
+		git update-ref refs/pull/42/head main &&
+		git clone . prune-overlapping &&
+		cd prune-overlapping &&
+		git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
+		git fetch --prune origin &&
+		git rev-parse origin/main &&
+		git rev-parse origin/pr/42 &&
+		git config --unset-all remote.origin.fetch &&
+		git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
+		git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
+		git fetch --prune origin &&
+		git rev-parse origin/main &&
+		git rev-parse origin/pr/42
+	)
 '
 
 test_expect_success 'fetch --prune --tags prunes branches but not tags' '
-	cd "$D" &&
-	git clone . prune-tags &&
-	cd prune-tags &&
-	git tag sometag main &&
-	# Create what looks like a remote-tracking branch from an earlier
-	# fetch that has since been deleted from the remote:
-	git update-ref refs/remotes/origin/fake-remote main &&
-
-	git fetch --prune --tags origin &&
-	git rev-parse origin/main &&
-	test_must_fail git rev-parse origin/fake-remote &&
-	git rev-parse sometag
+	(
+		cd "$D" &&
+		git clone . prune-tags &&
+		cd prune-tags &&
+		git tag sometag main &&
+		# Create what looks like a remote-tracking branch from an earlier
+		# fetch that has since been deleted from the remote:
+		git update-ref refs/remotes/origin/fake-remote main &&
+		git fetch --prune --tags origin &&
+		git rev-parse origin/main &&
+		test_must_fail git rev-parse origin/fake-remote &&
+		git rev-parse sometag
+	)
 '
 
 test_expect_success 'fetch --prune --tags with branch does not prune other things' '
-	cd "$D" &&
-	git clone . prune-tags-branch &&
-	cd prune-tags-branch &&
-	git tag sometag main &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-
-	git fetch --prune --tags origin main &&
-	git rev-parse origin/extrabranch &&
-	git rev-parse sometag
+	(
+		cd "$D" &&
+		git clone . prune-tags-branch &&
+		cd prune-tags-branch &&
+		git tag sometag main &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		git fetch --prune --tags origin main &&
+		git rev-parse origin/extrabranch &&
+		git rev-parse sometag
+	)
 '
 
 test_expect_success 'fetch --prune --tags with refspec prunes based on refspec' '
-	cd "$D" &&
-	git clone . prune-tags-refspec &&
-	cd prune-tags-refspec &&
-	git tag sometag main &&
-	git update-ref refs/remotes/origin/foo/otherbranch main &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-
-	git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
-	test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
-	git rev-parse origin/extrabranch &&
-	git rev-parse sometag
+	(
+		cd "$D" &&
+		git clone . prune-tags-refspec &&
+		cd prune-tags-refspec &&
+		git tag sometag main &&
+		git update-ref refs/remotes/origin/foo/otherbranch main &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
+		test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
+		git rev-parse origin/extrabranch &&
+		git rev-parse sometag
+	)
 '
 
 test_expect_success REFFILES 'fetch --prune fails to delete branches' '
-	cd "$D" &&
-	git clone . prune-fail &&
-	cd prune-fail &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-	: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
-	>.git/packed-refs.new &&
-
-	test_must_fail git fetch --prune origin
+	(
+		cd "$D" &&
+		git clone . prune-fail &&
+		cd prune-fail &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
+		>.git/packed-refs.new &&
+		test_must_fail git fetch --prune origin
+	)
 '
 
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git clone . atomic &&
-	git branch atomic-branch &&
-	oid=$(git rev-parse atomic-branch) &&
-	echo "$oid" >expected &&
-
-	git -C atomic fetch --atomic origin &&
-	git -C atomic rev-parse origin/atomic-branch >actual &&
-	test_cmp expected actual &&
-	test $oid = "$(git -C atomic rev-parse --verify FETCH_HEAD)"
+	(
+		cd "$D" &&
+		git clone . atomic &&
+		git branch atomic-branch &&
+		oid=$(git rev-parse atomic-branch) &&
+		echo "$oid" >expected &&
+		git -C atomic fetch --atomic origin &&
+		git -C atomic rev-parse origin/atomic-branch >actual &&
+		test_cmp expected actual &&
+		test $oid = "$(git -C atomic rev-parse --verify FETCH_HEAD)"
+	)
 '
 
 test_expect_success 'fetch --atomic works with multiple branches' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git clone . atomic &&
-	git branch atomic-branch-1 &&
-	git branch atomic-branch-2 &&
-	git branch atomic-branch-3 &&
-	git rev-parse refs/heads/atomic-branch-1 refs/heads/atomic-branch-2 refs/heads/atomic-branch-3 >actual &&
-
-	git -C atomic fetch --atomic origin &&
-	git -C atomic rev-parse refs/remotes/origin/atomic-branch-1 refs/remotes/origin/atomic-branch-2 refs/remotes/origin/atomic-branch-3 >expected &&
-	test_cmp expected actual
+	(
+		cd "$D" &&
+		git clone . atomic &&
+		git branch atomic-branch-1 &&
+		git branch atomic-branch-2 &&
+		git branch atomic-branch-3 &&
+		git rev-parse refs/heads/atomic-branch-1 refs/heads/atomic-branch-2 refs/heads/atomic-branch-3 >actual &&
+		git -C atomic fetch --atomic origin &&
+		git -C atomic rev-parse refs/remotes/origin/atomic-branch-1 refs/remotes/origin/atomic-branch-2 refs/remotes/origin/atomic-branch-3 >expected &&
+		test_cmp expected actual
+	)
 '
 
 test_expect_success 'fetch --atomic works with mixed branches and tags' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git clone . atomic &&
-	git branch atomic-mixed-branch &&
-	git tag atomic-mixed-tag &&
-	git rev-parse refs/heads/atomic-mixed-branch refs/tags/atomic-mixed-tag >actual &&
-
-	git -C atomic fetch --tags --atomic origin &&
-	git -C atomic rev-parse refs/remotes/origin/atomic-mixed-branch refs/tags/atomic-mixed-tag >expected &&
-	test_cmp expected actual
+	(
+		cd "$D" &&
+		git clone . atomic &&
+		git branch atomic-mixed-branch &&
+		git tag atomic-mixed-tag &&
+		git rev-parse refs/heads/atomic-mixed-branch refs/tags/atomic-mixed-tag >actual &&
+		git -C atomic fetch --tags --atomic origin &&
+		git -C atomic rev-parse refs/remotes/origin/atomic-mixed-branch refs/tags/atomic-mixed-tag >expected &&
+		test_cmp expected actual
+	)
 '
 
 test_expect_success 'fetch --atomic prunes references' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git branch atomic-prune-delete &&
-	git clone . atomic &&
-	git branch --delete atomic-prune-delete &&
-	git branch atomic-prune-create &&
-	git rev-parse refs/heads/atomic-prune-create >actual &&
-
-	git -C atomic fetch --prune --atomic origin &&
-	test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-prune-delete &&
-	git -C atomic rev-parse refs/remotes/origin/atomic-prune-create >expected &&
-	test_cmp expected actual
+	(
+		cd "$D" &&
+		git branch atomic-prune-delete &&
+		git clone . atomic &&
+		git branch --delete atomic-prune-delete &&
+		git branch atomic-prune-create &&
+		git rev-parse refs/heads/atomic-prune-create >actual &&
+		git -C atomic fetch --prune --atomic origin &&
+		test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-prune-delete &&
+		git -C atomic rev-parse refs/remotes/origin/atomic-prune-create >expected &&
+		test_cmp expected actual
+	)
 '
 
 test_expect_success 'fetch --atomic aborts with non-fast-forward update' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git branch atomic-non-ff &&
-	git clone . atomic &&
-	git rev-parse HEAD >actual &&
-
-	git branch atomic-new-branch &&
-	parent_commit=$(git rev-parse atomic-non-ff~) &&
-	git update-ref refs/heads/atomic-non-ff $parent_commit &&
-
-	test_must_fail git -C atomic fetch --atomic origin refs/heads/*:refs/remotes/origin/* &&
-	test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-new-branch &&
-	git -C atomic rev-parse refs/remotes/origin/atomic-non-ff >expected &&
-	test_cmp expected actual &&
-	test_must_be_empty atomic/.git/FETCH_HEAD
+	(
+		cd "$D" &&
+		git branch atomic-non-ff &&
+		git clone . atomic &&
+		git rev-parse HEAD >actual &&
+		git branch atomic-new-branch &&
+		parent_commit=$(git rev-parse atomic-non-ff~) &&
+		git update-ref refs/heads/atomic-non-ff $parent_commit &&
+		test_must_fail git -C atomic fetch --atomic origin refs/heads/*:refs/remotes/origin/* &&
+		test_must_fail git -C atomic rev-parse refs/remotes/origin/atomic-new-branch &&
+		git -C atomic rev-parse refs/remotes/origin/atomic-non-ff >expected &&
+		test_cmp expected actual &&
+		test_must_be_empty atomic/.git/FETCH_HEAD
+	)
 '
 
 test_expect_success 'fetch --atomic executes a single reference transaction only' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git clone . atomic &&
-	git branch atomic-hooks-1 &&
-	git branch atomic-hooks-2 &&
-	head_oid=$(git rev-parse HEAD) &&
-
-	cat >expected <<-EOF &&
-		prepared
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
-		committed
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
-	EOF
-
-	rm -f atomic/actual &&
-	test_hook -C atomic reference-transaction <<-\EOF &&
-		( echo "$*" && cat ) >>actual
-	EOF
-
-	git -C atomic fetch --atomic origin &&
-	test_cmp expected atomic/actual
+	(
+		cd "$D" &&
+		git clone . atomic &&
+		git branch atomic-hooks-1 &&
+		git branch atomic-hooks-2 &&
+		head_oid=$(git rev-parse HEAD) &&
+		cat >expected <<-EOF &&
+			prepared
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
+			committed
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
+		EOF
+		rm -f atomic/actual &&
+		write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+			( echo "$*" && cat ) >>actual
+		EOF
+		git -C atomic fetch --atomic origin &&
+		test_cmp expected atomic/actual
+	)
 '
 
 test_expect_success 'fetch --atomic aborts all reference updates if hook aborts' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git clone . atomic &&
-	git branch atomic-hooks-abort-1 &&
-	git branch atomic-hooks-abort-2 &&
-	git branch atomic-hooks-abort-3 &&
-	git tag atomic-hooks-abort &&
-	head_oid=$(git rev-parse HEAD) &&
-
-	cat >expected <<-EOF &&
-		prepared
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
-		$ZERO_OID $head_oid refs/tags/atomic-hooks-abort
-		aborted
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
-		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
-		$ZERO_OID $head_oid refs/tags/atomic-hooks-abort
-	EOF
-
-	rm -f atomic/actual &&
-	test_hook -C atomic/.git reference-transaction <<-\EOF &&
-		( echo "$*" && cat ) >>actual
-		exit 1
-	EOF
-
-	git -C atomic for-each-ref >expected-refs &&
-	test_must_fail git -C atomic fetch --tags --atomic origin &&
-	git -C atomic for-each-ref >actual-refs &&
-	test_cmp expected-refs actual-refs &&
-	test_must_be_empty atomic/.git/FETCH_HEAD
+	(
+		cd "$D" &&
+		git clone . atomic &&
+		git branch atomic-hooks-abort-1 &&
+		git branch atomic-hooks-abort-2 &&
+		git branch atomic-hooks-abort-3 &&
+		git tag atomic-hooks-abort &&
+		head_oid=$(git rev-parse HEAD) &&
+		cat >expected <<-EOF &&
+			prepared
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
+			$ZERO_OID $head_oid refs/tags/atomic-hooks-abort
+			aborted
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
+			$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
+			$ZERO_OID $head_oid refs/tags/atomic-hooks-abort
+		EOF
+		rm -f atomic/actual &&
+		write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+			( echo "$*" && cat ) >>actual
+			exit 1
+		EOF
+		git -C atomic for-each-ref >expected-refs &&
+		test_must_fail git -C atomic fetch --tags --atomic origin &&
+		git -C atomic for-each-ref >actual-refs &&
+		test_cmp expected-refs actual-refs &&
+		test_must_be_empty atomic/.git/FETCH_HEAD
+	)
 '
 
 test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git clone . atomic &&
-	oid=$(git rev-parse HEAD) &&
-
-	git branch atomic-fetch-head-1 &&
-	git -C atomic fetch --atomic origin atomic-fetch-head-1 &&
-	test_line_count = 1 atomic/.git/FETCH_HEAD &&
-
-	git branch atomic-fetch-head-2 &&
-	git -C atomic fetch --atomic --append origin atomic-fetch-head-2 &&
-	test_line_count = 2 atomic/.git/FETCH_HEAD &&
-	cp atomic/.git/FETCH_HEAD expected &&
-
-	test_hook -C atomic reference-transaction <<-\EOF &&
-		exit 1
-	EOF
-
-	git branch atomic-fetch-head-3 &&
-	test_must_fail git -C atomic fetch --atomic --append origin atomic-fetch-head-3 &&
-	test_cmp expected atomic/.git/FETCH_HEAD
+	(
+		cd "$D" &&
+		git clone . atomic &&
+		oid=$(git rev-parse HEAD) &&
+		git branch atomic-fetch-head-1 &&
+		git -C atomic fetch --atomic origin atomic-fetch-head-1 &&
+		test_line_count = 1 atomic/.git/FETCH_HEAD &&
+		git branch atomic-fetch-head-2 &&
+		git -C atomic fetch --atomic --append origin atomic-fetch-head-2 &&
+		test_line_count = 2 atomic/.git/FETCH_HEAD &&
+		cp atomic/.git/FETCH_HEAD expected &&
+		write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+			exit 1
+		EOF
+		git branch atomic-fetch-head-3 &&
+		test_must_fail git -C atomic fetch --atomic --append origin atomic-fetch-head-3 &&
+		test_cmp expected atomic/.git/FETCH_HEAD
+	)
 '
 
 test_expect_success 'fetch --atomic --prune executes a single reference transaction only' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
-
-	cd "$D" &&
-	git branch scheduled-for-deletion &&
-	git clone . atomic &&
-	git branch -D scheduled-for-deletion &&
-	git branch new-branch &&
-	head_oid=$(git rev-parse HEAD) &&
-
-	# Fetching with the `--atomic` flag should update all references in a
-	# single transaction.
-	cat >expected <<-EOF &&
-		prepared
-		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
-		$ZERO_OID $head_oid refs/remotes/origin/new-branch
-		committed
-		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
-		$ZERO_OID $head_oid refs/remotes/origin/new-branch
-	EOF
-
-	test_hook -C atomic reference-transaction <<-\EOF &&
-		( echo "$*" && cat ) >>actual
-	EOF
-
-	git -C atomic fetch --atomic --prune origin &&
-	test_cmp expected atomic/actual
+	(
+		cd "$D" &&
+		git branch scheduled-for-deletion &&
+		git clone . atomic &&
+		git branch -D scheduled-for-deletion &&
+		git branch new-branch &&
+		head_oid=$(git rev-parse HEAD) &&
+		# Fetching with the `--atomic` flag should update all references in a
+		# single transaction.
+		cat >expected <<-EOF &&
+			prepared
+			$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
+			$ZERO_OID $head_oid refs/remotes/origin/new-branch
+			committed
+			$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
+			$ZERO_OID $head_oid refs/remotes/origin/new-branch
+		EOF
+		write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+			( echo "$*" && cat ) >>actual
+		EOF
+		git -C atomic fetch --atomic --prune origin &&
+		test_cmp expected atomic/actual
+	)
 '
 
 test_expect_success '--refmap="" ignores configured refspec' '
-	cd "$TRASH_DIRECTORY" &&
-	git clone "$D" remote-refs &&
-	git -C remote-refs rev-parse remotes/origin/main >old &&
-	git -C remote-refs update-ref refs/remotes/origin/main main~1 &&
-	git -C remote-refs rev-parse remotes/origin/main >new &&
-	git -C remote-refs fetch --refmap= origin "+refs/heads/*:refs/hidden/origin/*" &&
-	git -C remote-refs rev-parse remotes/origin/main >actual &&
-	test_cmp new actual &&
-	git -C remote-refs fetch origin &&
-	git -C remote-refs rev-parse remotes/origin/main >actual &&
-	test_cmp old actual
+	(
+		cd "$TRASH_DIRECTORY" &&
+		git clone "$D" remote-refs &&
+		git -C remote-refs rev-parse remotes/origin/main >old &&
+		git -C remote-refs update-ref refs/remotes/origin/main main~1 &&
+		git -C remote-refs rev-parse remotes/origin/main >new &&
+		git -C remote-refs fetch --refmap= origin "+refs/heads/*:refs/hidden/origin/*" &&
+		git -C remote-refs rev-parse remotes/origin/main >actual &&
+		test_cmp new actual &&
+		git -C remote-refs fetch origin &&
+		git -C remote-refs rev-parse remotes/origin/main >actual &&
+		test_cmp old actual
+	)
 '
 
 test_expect_success '--refmap="" and --prune' '
@@ -397,89 +404,86 @@ test_expect_success '--refmap="" and --prune' '
 '
 
 test_expect_success 'fetch tags when there is no tags' '
-
-    cd "$D" &&
-
-    mkdir notags &&
-    cd notags &&
-    git init &&
-
-    git fetch -t ..
-
+	(
+		cd "$D" &&
+		mkdir notags &&
+		cd notags &&
+		git init &&
+		git fetch -t ..
+	)
 '
 
 test_expect_success 'fetch following tags' '
-
-	cd "$D" &&
-	git tag -a -m "annotated" anno HEAD &&
-	git tag light HEAD &&
-
-	mkdir four &&
-	cd four &&
-	git init &&
-
-	git fetch .. :track &&
-	git show-ref --verify refs/tags/anno &&
-	git show-ref --verify refs/tags/light
-
+	(
+		cd "$D" &&
+		git tag -a -m "annotated" anno HEAD &&
+		git tag light HEAD &&
+		mkdir four &&
+		cd four &&
+		git init &&
+		git fetch .. :track &&
+		git show-ref --verify refs/tags/anno &&
+		git show-ref --verify refs/tags/light
+	)
 '
 
 test_expect_success 'fetch uses remote ref names to describe new refs' '
-	cd "$D" &&
-	git init descriptive &&
-	(
-		cd descriptive &&
-		git config remote.o.url .. &&
-		git config remote.o.fetch "refs/heads/*:refs/crazyheads/*" &&
-		git config --add remote.o.fetch "refs/others/*:refs/heads/*" &&
-		git fetch o
-	) &&
-	git tag -a -m "Descriptive tag" descriptive-tag &&
-	git branch descriptive-branch &&
-	git checkout descriptive-branch &&
-	echo "Nuts" >crazy &&
-	git add crazy &&
-	git commit -a -m "descriptive commit" &&
-	git update-ref refs/others/crazy HEAD &&
 	(
-		cd descriptive &&
-		git fetch o 2>actual &&
-		test_i18ngrep "new branch.* -> refs/crazyheads/descriptive-branch$" actual &&
-		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
-		test_i18ngrep "new ref.* -> crazy$" actual
-	) &&
-	git checkout main
+		cd "$D" &&
+		git init descriptive &&
+		(
+			cd descriptive &&
+			git config remote.o.url .. &&
+			git config remote.o.fetch "refs/heads/*:refs/crazyheads/*" &&
+			git config --add remote.o.fetch "refs/others/*:refs/heads/*" &&
+			git fetch o
+		) &&
+		git tag -a -m "Descriptive tag" descriptive-tag &&
+		git branch descriptive-branch &&
+		git checkout descriptive-branch &&
+		echo "Nuts" >crazy &&
+		git add crazy &&
+		git commit -a -m "descriptive commit" &&
+		git update-ref refs/others/crazy HEAD &&
+		(
+			cd descriptive &&
+			git fetch o 2>actual &&
+			test_i18ngrep "new branch.* -> refs/crazyheads/descriptive-branch$" actual &&
+			test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
+			test_i18ngrep "new ref.* -> crazy$" actual
+		) &&
+		git checkout main
+	)
 '
 
 test_expect_success 'fetch must not resolve short tag name' '
-
-	cd "$D" &&
-
-	mkdir five &&
-	cd five &&
-	git init &&
-
-	test_must_fail git fetch .. anno:five
-
+	(
+		cd "$D" &&
+		mkdir five &&
+		cd five &&
+		git init &&
+		test_must_fail git fetch .. anno:five
+	)
 '
 
 test_expect_success 'fetch can now resolve short remote name' '
-
-	cd "$D" &&
-	git update-ref refs/remotes/six/HEAD HEAD &&
-
-	mkdir six &&
-	cd six &&
-	git init &&
-
-	git fetch .. six:six
+	(
+		cd "$D" &&
+		git update-ref refs/remotes/six/HEAD HEAD &&
+		mkdir six &&
+		cd six &&
+		git init &&
+		git fetch .. six:six
+	)
 '
 
 test_expect_success 'create bundle 1' '
-	cd "$D" &&
-	echo >file updated again by origin &&
-	git commit -a -m "tip" &&
-	git bundle create --version=3 bundle1 main^..main
+	(
+		cd "$D" &&
+		echo >file updated again by origin &&
+		git commit -a -m "tip" &&
+		git bundle create --version=3 bundle1 main^..main
+	)
 '
 
 test_expect_success 'header of bundle looks right' '
@@ -495,43 +499,53 @@ test_expect_success 'header of bundle looks right' '
 '
 
 test_expect_success 'create bundle 2' '
-	cd "$D" &&
-	git bundle create bundle2 main~2..main
+	(
+		cd "$D" &&
+		git bundle create bundle2 main~2..main
+	)
 '
 
 test_expect_success 'unbundle 1' '
-	cd "$D/bundle" &&
-	git checkout -b some-branch &&
-	test_must_fail git fetch "$D/bundle1" main:main
+	(
+		cd "$D/bundle" &&
+		git checkout -b some-branch &&
+		test_must_fail git fetch "$D/bundle1" main:main
+	)
 '
 
 
 test_expect_success 'bundle 1 has only 3 files ' '
-	cd "$D" &&
-	test_bundle_object_count bundle1 3
+	(
+		cd "$D" &&
+		test_bundle_object_count bundle1 3
+	)
 '
 
 test_expect_success 'unbundle 2' '
-	cd "$D/bundle" &&
-	git fetch ../bundle2 main:main &&
-	test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
+	(
+		cd "$D/bundle" &&
+		git fetch ../bundle2 main:main &&
+		test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
+	)
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
-	cd "$D" &&
-	touch file2 &&
-	git add file2 &&
-	git commit -m add.file2 file2 &&
-	git bundle create bundle3 -1 HEAD &&
-	test_bundle_object_count bundle3 3
+	(
+		cd "$D" &&
+		touch file2 &&
+		git add file2 &&
+		git commit -m add.file2 file2 &&
+		git bundle create bundle3 -1 HEAD &&
+		test_bundle_object_count bundle3 3
+	)
 '
 
 test_expect_success 'bundle should be able to create a full history' '
-
-	cd "$D" &&
-	git tag -a -m "1.0" v1.0 main &&
-	git bundle create bundle4 v1.0
-
+	(
+		cd "$D" &&
+		git tag -a -m "1.0" v1.0 main &&
+		git bundle create bundle4 v1.0
+	)
 '
 
 test_expect_success 'fetch with a non-applying branch.<name>.merge' '
@@ -581,15 +595,16 @@ test_expect_success 'quoting of a strangely named repo' '
 '
 
 test_expect_success 'bundle should record HEAD correctly' '
-
-	cd "$D" &&
-	git bundle create bundle5 HEAD main &&
-	git bundle list-heads bundle5 >actual &&
-	for h in HEAD refs/heads/main
-	do
-		echo "$(git rev-parse --verify $h) $h" || return 1
-	done >expect &&
-	test_cmp expect actual
+	(
+		cd "$D" &&
+		git bundle create bundle5 HEAD main &&
+		git bundle list-heads bundle5 >actual &&
+		for h in HEAD refs/heads/main
+		do
+			echo "$(git rev-parse --verify $h) $h" || return 1
+		done >expect &&
+		test_cmp expect actual
+	)
 
 '
 
@@ -601,127 +616,139 @@ test_expect_success 'mark initial state of origin/main' '
 '
 
 test_expect_success 'explicit fetch should update tracking' '
-
-	cd "$D" &&
-	git branch -f side &&
 	(
-		cd three &&
-		git update-ref refs/remotes/origin/main base-origin-main &&
-		o=$(git rev-parse --verify refs/remotes/origin/main) &&
-		git fetch origin main &&
-		n=$(git rev-parse --verify refs/remotes/origin/main) &&
-		test "$o" != "$n" &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/side
+		cd "$D" &&
+		git branch -f side &&
+		(
+			cd three &&
+			git update-ref refs/remotes/origin/main base-origin-main &&
+			o=$(git rev-parse --verify refs/remotes/origin/main) &&
+			git fetch origin main &&
+			n=$(git rev-parse --verify refs/remotes/origin/main) &&
+			test "$o" != "$n" &&
+			test_must_fail git rev-parse --verify refs/remotes/origin/side
+		)
 	)
 '
 
 test_expect_success 'explicit pull should update tracking' '
-
-	cd "$D" &&
-	git branch -f side &&
 	(
-		cd three &&
-		git update-ref refs/remotes/origin/main base-origin-main &&
-		o=$(git rev-parse --verify refs/remotes/origin/main) &&
-		git pull origin main &&
-		n=$(git rev-parse --verify refs/remotes/origin/main) &&
-		test "$o" != "$n" &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/side
+		cd "$D" &&
+		git branch -f side &&
+		(
+			cd three &&
+			git update-ref refs/remotes/origin/main base-origin-main &&
+			o=$(git rev-parse --verify refs/remotes/origin/main) &&
+			git pull origin main &&
+			n=$(git rev-parse --verify refs/remotes/origin/main) &&
+			test "$o" != "$n" &&
+			test_must_fail git rev-parse --verify refs/remotes/origin/side
+		)
 	)
 '
 
 test_expect_success 'explicit --refmap is allowed only with command-line refspec' '
-	cd "$D" &&
 	(
-		cd three &&
-		test_must_fail git fetch --refmap="*:refs/remotes/none/*"
+		cd "$D" &&
+		(
+			cd three &&
+			test_must_fail git fetch --refmap="*:refs/remotes/none/*"
+		)
 	)
 '
 
 test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
-	cd "$D" &&
-	git branch -f side &&
 	(
-		cd three &&
-		git update-ref refs/remotes/origin/main base-origin-main &&
-		o=$(git rev-parse --verify refs/remotes/origin/main) &&
-		git fetch --refmap="refs/heads/*:refs/remotes/other/*" origin main &&
-		n=$(git rev-parse --verify refs/remotes/origin/main) &&
-		test "$o" = "$n" &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
-		git rev-parse --verify refs/remotes/other/main
+		cd "$D" &&
+		git branch -f side &&
+		(
+			cd three &&
+			git update-ref refs/remotes/origin/main base-origin-main &&
+			o=$(git rev-parse --verify refs/remotes/origin/main) &&
+			git fetch --refmap="refs/heads/*:refs/remotes/other/*" origin main &&
+			n=$(git rev-parse --verify refs/remotes/origin/main) &&
+			test "$o" = "$n" &&
+			test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+			git rev-parse --verify refs/remotes/other/main
+		)
 	)
 '
 
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
-	cd "$D" &&
-	git branch -f side &&
 	(
-		cd three &&
-		git update-ref refs/remotes/origin/main base-origin-main &&
-		o=$(git rev-parse --verify refs/remotes/origin/main) &&
-		git fetch --refmap="" origin main &&
-		n=$(git rev-parse --verify refs/remotes/origin/main) &&
-		test "$o" = "$n" &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/side
+		cd "$D" &&
+		git branch -f side &&
+		(
+			cd three &&
+			git update-ref refs/remotes/origin/main base-origin-main &&
+			o=$(git rev-parse --verify refs/remotes/origin/main) &&
+			git fetch --refmap="" origin main &&
+			n=$(git rev-parse --verify refs/remotes/origin/main) &&
+			test "$o" = "$n" &&
+			test_must_fail git rev-parse --verify refs/remotes/origin/side
+		)
 	)
 '
 
 test_expect_success 'configured fetch updates tracking' '
-
-	cd "$D" &&
-	git branch -f side &&
 	(
-		cd three &&
-		git update-ref refs/remotes/origin/main base-origin-main &&
-		o=$(git rev-parse --verify refs/remotes/origin/main) &&
-		git fetch origin &&
-		n=$(git rev-parse --verify refs/remotes/origin/main) &&
-		test "$o" != "$n" &&
-		git rev-parse --verify refs/remotes/origin/side
+		cd "$D" &&
+		git branch -f side &&
+		(
+			cd three &&
+			git update-ref refs/remotes/origin/main base-origin-main &&
+			o=$(git rev-parse --verify refs/remotes/origin/main) &&
+			git fetch origin &&
+			n=$(git rev-parse --verify refs/remotes/origin/main) &&
+			test "$o" != "$n" &&
+			git rev-parse --verify refs/remotes/origin/side
+		)
 	)
 '
 
 test_expect_success 'non-matching refspecs do not confuse tracking update' '
-	cd "$D" &&
-	git update-ref refs/odd/location HEAD &&
 	(
-		cd three &&
-		git update-ref refs/remotes/origin/main base-origin-main &&
-		git config --add remote.origin.fetch \
-			refs/odd/location:refs/remotes/origin/odd &&
-		o=$(git rev-parse --verify refs/remotes/origin/main) &&
-		git fetch origin main &&
-		n=$(git rev-parse --verify refs/remotes/origin/main) &&
-		test "$o" != "$n" &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/odd
+		cd "$D" &&
+		git update-ref refs/odd/location HEAD &&
+		(
+			cd three &&
+			git update-ref refs/remotes/origin/main base-origin-main &&
+			git config --add remote.origin.fetch \
+				refs/odd/location:refs/remotes/origin/odd &&
+			o=$(git rev-parse --verify refs/remotes/origin/main) &&
+			git fetch origin main &&
+			n=$(git rev-parse --verify refs/remotes/origin/main) &&
+			test "$o" != "$n" &&
+			test_must_fail git rev-parse --verify refs/remotes/origin/odd
+		)
 	)
 '
 
 test_expect_success 'pushing nonexistent branch by mistake should not segv' '
-
-	cd "$D" &&
-	test_must_fail git push seven no:no
-
+	(
+		cd "$D" &&
+		test_must_fail git push seven no:no
+	)
 '
 
 test_expect_success 'auto tag following fetches minimum' '
-
-	cd "$D" &&
-	git clone .git follow &&
-	git checkout HEAD^0 &&
 	(
-		for i in 1 2 3 4 5 6 7
-		do
-			echo $i >>file &&
-			git commit -m $i -a &&
-			git tag -a -m $i excess-$i || exit 1
-		done
-	) &&
-	git checkout main &&
-	(
-		cd follow &&
-		git fetch
+		cd "$D" &&
+		git clone .git follow &&
+		git checkout HEAD^0 &&
+		(
+			for i in 1 2 3 4 5 6 7
+			do
+				echo $i >>file &&
+				git commit -m $i -a &&
+				git tag -a -m $i excess-$i || exit 1
+			done
+		) &&
+		git checkout main &&
+		(
+			cd follow &&
+			git fetch
+		)
 	)
 '
 
-- 
2.35.1

