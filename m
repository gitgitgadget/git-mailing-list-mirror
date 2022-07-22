Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC6CCA487
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiGVFP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGVFPu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306DC248C5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so5017119wrc.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wOGAeuZYYD1ywCQx5iNnhf8S8m5LJhjzC4NvFsDfZec=;
        b=MrpNaG+IAth1/Mk2+aleIwyDtct4C021FfAj/X2oDlhABPVn9duFFYJUOBvTlFYx/K
         ejBZoWV6sfNH5k68GfxLyffvePSKhOFY4xf3RVQGyty8SW6i42h/hMh7phtz/Ol9TcJo
         +G9JutIV9mKTShekQ7cNS4qNFdR4kAqt9a02tDyZvkooyzUeyXfO5aS7B40Sbm8LRMv7
         mvBpay24TUb9Gsb6J6WBFAM913n0O0g8t7IiH8JEn3F0m6JMw16WwehR0kIcP4xivVRl
         RvUtYugnMtEOwYeI6kKr7AMKzloIso48Q7BTXU4TlA80TT9WyBf+G09qARQIfIkS+DDp
         QRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wOGAeuZYYD1ywCQx5iNnhf8S8m5LJhjzC4NvFsDfZec=;
        b=uHzy2gITyuW9GJwvwDLzi2jgu5bXbUBBsfDbNe+0VxLm6To4l0QzrPFjAvmJdWkegn
         jaW+LGwBG4FBA+stj2DmyDMR/dYqkSyIqIHvxlntgYgv+pADgD1iREzx11v73cfQMHfY
         1RwArPiFMZQU/e4JIv2KPEr3aqCxfR85xdGVEs6cFzV90b66sNuVSyb6CkBaEeJMm0r4
         1gyp/FVNIh36x3YR8/a1MCO0FDdEMMYB/3bOkQS5c3ltXrxPh/j/U+/S74Ds6iSJ8qSa
         X2uXtkIKOsz3y8vACICbGj9i3rZeBX5X+93tHEJYODTPXcYyQrWGRtuXTh4egl/lBNCs
         0u2A==
X-Gm-Message-State: AJIora+Ym7thr56kzm3md72+WyN2qpHRvCTzVJsOHAWeKj0Qj87W8j7s
        19Hap233iPPUckeYs07ECM02G+J71cE=
X-Google-Smtp-Source: AGRyM1tfc2iB5cPZy/hxLoMD9g9weSNeS8tsmFMgnedppLi054vDsb5fUgttYgGrvv6KD/AqYjSXYA==
X-Received: by 2002:adf:f0c6:0:b0:21e:4480:2fa5 with SMTP id x6-20020adff0c6000000b0021e44802fa5mr1121413wro.377.1658466947409;
        Thu, 21 Jul 2022 22:15:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a7bc382000000b003a3253b705dsm3689034wmj.35.2022.07.21.22.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:46 -0700 (PDT)
Message-Id: <02930448ea1fbf7084b9d78813908b6355304457.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:38 +0000
Subject: [PATCH v4 3/7] merge: do not abort early if one strategy fails to
 handle the merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

builtin/merge is setup to allow multiple strategies to be specified,
and it will find the "best" result and use it.  This is defeated if
some of the merge strategies abort early when they cannot handle the
merge.  Fix the logic that calls recursive and ort to not do such an
early abort, but instead return "2" or "unhandled" so that the next
strategy can try to handle the merge.

Coming up with a testcase for this is somewhat difficult, since
recursive and ort both handle nearly any two-headed merge (there is
a separate code path that checks for non-two-headed merges and
already returns "2" for them).  So use a somewhat synthetic testcase
of having the index not match HEAD before the merge starts, since all
merge strategies will abort for that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          |  6 ++++--
 t/t6402-merge-rename.sh                  |  2 +-
 t/t6424-merge-unrelated-index-changes.sh | 16 ++++++++++++++++
 t/t6439-merge-co-error-msgs.sh           |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 13884b8e836..dec7375bf2a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		else
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
-		if (clean < 0)
-			exit(128);
+		if (clean < 0) {
+			rollback_lock_file(&lock);
+			return 2;
+		}
 		if (write_locked_index(&the_index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3a32b1a45cf..772238e582c 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull --no-rebase . yellow &&
+	test_expect_code 2 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index f35d3182b86..8b749e19083 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -268,4 +268,20 @@ test_expect_success 'subtree' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'resolve && recursive && ort' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	test_seq 0 10 >a &&
+	git add a &&
+
+	sane_unset GIT_TEST_MERGE_ALGORITHM &&
+	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
+
+	grep "Trying merge strategy resolve..." output &&
+	grep "Trying merge strategy recursive..." output &&
+	grep "Trying merge strategy ort..." output &&
+	grep "No merge strategy handled the merge." output
+'
+
 test_done
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 5bfb027099a..52cf0c87690 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -47,6 +47,7 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge branch 2>out2
 	) &&
+	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>expect &&
 	test_cmp out2 expect &&
 	git reset --hard HEAD^
 '
-- 
gitgitgadget

