Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC9C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiHVS04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiHVS0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:26:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E990481D0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u14so14252949wrq.9
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Dgfsyhs0RNsaLM3l4sKhqbZHr8ElrsZ6DZM1/8tvoTM=;
        b=lK6rKXfJi8iBhIqNL2qRfabGuBn6LHsAZ4CW+miitl07n2IKxkVTp3EwOYhwHSHUqK
         e4qCjDtCgUwOhSO/hwjzfqaDqbmyZclhDmVpJs+UJW3FQLFPwHR9S1Wl25HZqOY5GmNh
         7sahLxeOumSw2ZpfkfOC7x6ZGC19pNGr+pOM7YC6oBvxbp3/wrX8oNat/15/DXIW7jk5
         97Qg2L5jfQYpkfdtW455yUqWzPfGhkSy7M70oS04MyOOVOYLwiVM/ctdthihqu78Zw+L
         zH3+ic++SfS8HoLhaxkoobLW/7Ul5AMozKCKwXy7NiQcWpJ8E3Dk7jIruYwdEo26SsmL
         0OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Dgfsyhs0RNsaLM3l4sKhqbZHr8ElrsZ6DZM1/8tvoTM=;
        b=6SExWmpUGS4VM84Or4UaPhcysI2kCZsS3fmqEk2KP/uKmiy5WDVY2UxGYCKPR/foYp
         MQtrrRmyhJItgNtMotWL+fnPgB2apwep4jwNDt8sKhuAVRORUZrngCuKLCc9UngX+lvZ
         T9t0om36ChukxKKgQ+CtANOGn6CFH3b6qOJN0mObNgxa771BW5wVH0YZykn57aJULdv+
         7RQrlVsINKD1B74QhLnRlXZmw5i+EwmpBupNtwG5EzgcMReSSenA4IbLHCxfxYrCZpCh
         2Se8QK3NK7nULyd9COkfg0umP6NZ8020J6hYtnMyHJK2Ge82WiuRkE44TVJTtBpYJ7B7
         SXRQ==
X-Gm-Message-State: ACgBeo3rLgZzfWP0v+hO1Mea2z0a1H2D3ev8TBwZHlKiJOxU6LqHrfyo
        nhtGw8bgpQ6sHCOHx7AuJ1VZXCtFQbQ=
X-Google-Smtp-Source: AA6agR6n9G7LRDpdc2/G0W8sWUvSiuX5YaGJEp+LV4s5RPiZMn0An7VpT5rK1n1UXn8bYrriWXxmGg==
X-Received: by 2002:a5d:47ca:0:b0:220:5cbc:1c59 with SMTP id o10-20020a5d47ca000000b002205cbc1c59mr11346673wrc.662.1661192806525;
        Mon, 22 Aug 2022 11:26:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17-20020adfec11000000b0020e6ce4dabdsm12529236wrn.103.2022.08.22.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:26:46 -0700 (PDT)
Message-Id: <31a962fd5070d68964e545fb5506d795e8845ec3.1661192802.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 18:26:42 +0000
Subject: [PATCH 3/3] t: detect and signal failure within loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Failures within `for` and `while` loops can go unnoticed if not detected
and signaled manually since the loop itself does not abort when a
contained command fails, nor will a failure necessarily be detected when
the loop finishes since the loop returns the exit code of the last
command it ran on the final iteration, which may not be the command
which failed. Therefore, detect and signal failures manually within
loops using the idiom `|| return 1` (or `|| exit 1` within subshells).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/perf/p7527-builtin-fsmonitor.sh        | 2 +-
 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 t/t5329-pack-objects-cruft.sh            | 8 ++++----
 t/t6429-merge-sequence-rename-caching.sh | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmonitor.sh
index 9338b9ea008..c3f9a4caa4c 100755
--- a/t/perf/p7527-builtin-fsmonitor.sh
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -249,7 +249,7 @@ test_expect_success "Cleanup temp and matrix branches" "
 	do
 		for fsm_val in $fsm_values
 		do
-			cleanup $uc_val $fsm_val
+			cleanup $uc_val $fsm_val || return 1
 		done
 	done
 "
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e13368861ce..0302e36fd66 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -556,7 +556,7 @@ test_expect_success 'blame with pathspec inside sparse definition' '
 			deep/deeper1/a \
 			deep/deeper1/deepest/a
 	do
-		test_all_match git blame $file
+		test_all_match git blame $file || return 1
 	done
 '
 
@@ -1571,7 +1571,7 @@ test_expect_success 'sparse index is not expanded: blame' '
 			deep/deeper1/a \
 			deep/deeper1/deepest/a
 	do
-		ensure_not_expanded blame $file
+		ensure_not_expanded blame $file || return 1
 	done
 '
 
@@ -1907,7 +1907,7 @@ test_expect_success 'rm pathspec outside sparse definition' '
 		test_sparse_match test_must_fail git rm $file &&
 		test_sparse_match test_must_fail git rm --cached $file &&
 		test_sparse_match git rm --sparse $file &&
-		test_sparse_match git status --porcelain=v2
+		test_sparse_match git status --porcelain=v2 || return 1
 	done &&
 
 	cat >folder1-full <<-EOF &&
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 8968f7a08d8..6049e2c1d78 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -29,7 +29,7 @@ basic_cruft_pack_tests () {
 				while read oid
 				do
 					path="$objdir/$(test_oid_to_path "$oid")" &&
-					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")"
+					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" || exit 1
 				done |
 				sort -k1
 			) >expect &&
@@ -232,7 +232,7 @@ test_expect_success 'cruft tags rescue tagged objects' '
 		while read oid
 		do
 			test-tool chmtime -1000 \
-				"$objdir/$(test_oid_to_path $oid)"
+				"$objdir/$(test_oid_to_path $oid)" || exit 1
 		done <objects &&
 
 		test-tool chmtime -500 \
@@ -272,7 +272,7 @@ test_expect_success 'cruft commits rescue parents, trees' '
 		while read object
 		do
 			test-tool chmtime -1000 \
-				"$objdir/$(test_oid_to_path $object)"
+				"$objdir/$(test_oid_to_path $object)" || exit 1
 		done <objects &&
 		test-tool chmtime +500 "$objdir/$(test_oid_to_path \
 			$(git rev-parse HEAD))" &&
@@ -345,7 +345,7 @@ test_expect_success 'expired objects are pruned' '
 		while read object
 		do
 			test-tool chmtime -1000 \
-				"$objdir/$(test_oid_to_path $object)"
+				"$objdir/$(test_oid_to_path $object)" || exit 1
 		done <objects &&
 
 		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index e1ce9199164..650b3cd14ff 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -725,7 +725,7 @@ test_expect_success 'avoid assuming we detected renames' '
 		mkdir unrelated &&
 		for i in $(test_seq 1 10)
 		do
-			>unrelated/$i
+			>unrelated/$i || exit 1
 		done &&
 		test_seq  2 10 >numbers &&
 		test_seq 12 20 >values &&
-- 
gitgitgadget
