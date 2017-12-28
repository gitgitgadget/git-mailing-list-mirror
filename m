Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18BA01F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbdL1EOL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:11 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35275 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbdL1EOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:08 -0500
Received: by mail-io0-f176.google.com with SMTP id 14so30650771iou.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NZ1LhXuMm3gvekdRB0raJgszuzfabd/slpiHVGScdo4=;
        b=lmot5BprI87wcf0kTnRdPadpmNN1Iyrda8TshZBXz9Boa11EOjqBdivNJSmS5zRITY
         SWv3qgrxkD5DewHwxzujeptNWMJDEjzmo+VkgnhnBepkEcvB0MwroRqPxFFTDQr/LFd0
         cOyu2dyXTgB+7wLFN5smtE8Zrp8WVL2gUOwOWYC0Dkw9GPW1SmHfw3S2mHaG9kLpzbKX
         L9Ud38tfCNGRUQOieAHNsYxpFagbgJv+itBGDYajDjPahjIfm7qyFEkoN0fv+HANEv+f
         IVcUrnv50saSgj0JE/wvVDHNIcg9SxSVlA9YQxGuUxmKMStiFluAlYva2+2XMU3fEAno
         LwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NZ1LhXuMm3gvekdRB0raJgszuzfabd/slpiHVGScdo4=;
        b=Ny9Rw3AxGMecSKurU8JtcLHhxW2qXt6K1opKLzVb8kOiHWXw7s6R863WMX/V9SSMJR
         u1DhexEyoMGjf33D8XC8b8dFnsTXgI8/nhqFwTZHLu6kW3sxAq/6rV845Db+cuqUIvRD
         2xi7sfL0iFB813N/HS+6tEUe3HGXmiQARg+p4FTAmd2YxOV17KUFuED5Iy2L7jTx5wuT
         2gbiFa4iPOfxbUakCeTwrDdeBsVUXfCkRgLxSu32yX/5MIJ3H1W45YiDSQONG+fbI+ye
         eRZmIwMerVqTXcokwBQjq1wE5So2My4KffkV/PcOWgYxfVHCPRkB6/trjkNADPJOWbDI
         1rKA==
X-Gm-Message-State: AKGB3mJPWXxvq7O14z3fE+SCArJLlCDVtD9wP2Chcbze06qhxgUc7Lua
        kwuczjCt6VOs6emMHqxKvgUAZQ==
X-Google-Smtp-Source: ACJfBosWPYhItEwLW2ZnU5ptlRaOsp5j/ZIwkhT5DYJx8CAWQEeMvf4ri+ONx0BNovKhXS8uxYyXvQ==
X-Received: by 10.107.38.146 with SMTP id m140mr30928135iom.114.1514434447360;
        Wed, 27 Dec 2017 20:14:07 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 07/34] directory rename detection: partially renamed directory testcase/discussion
Date:   Wed, 27 Dec 2017 20:13:25 -0800
Message-Id: <20171228041352.27880-8-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 104 ++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 433d99584..28b2d2a2b 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -714,4 +714,108 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
 #   of a rename on either side of a merge.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 4: Partially renamed directory; still exists on both sides of merge
+#
+# What if we were to attempt to do directory rename detection when someone
+# "mostly" moved a directory but still left some files around, or,
+# equivalently, fully renamed a directory in one commmit and then recreated
+# that directory in a later commit adding some new files and then tried to
+# merge?
+#
+# It's hard to divine user intent in these cases, because you can make an
+# argument that, depending on the intermediate history of the side being
+# merged, that some users will want files in that directory to
+# automatically be detected and renamed, while users with a different
+# intermediate history wouldn't want that rename to happen.
+#
+# I think that it is best to simply not have directory rename detection
+# apply to such cases.  My reasoning for this is four-fold: (1) it's
+# easiest for users in general to figure out what happened if we don't
+# apply directory rename detection in any such case, (2) it's an easy rule
+# to explain ["We don't do directory rename detection if the directory
+# still exists on both sides of the merge"], (3) we can get some hairy
+# edge/corner cases that would be really confusing and possibly not even
+# representable in the index if we were to even try, and [related to 3] (4)
+# attempting to resolve this issue of divining user intent by examining
+# intermediate history goes against the spirit of three-way merges and is a
+# path towards crazy corner cases that are far more complex than what we're
+# already dealing with.
+#
+# This section contains a test for this partially-renamed-directory case.
+###########################################################################
+
+# Testcase 4a, Directory split, with original directory still present
+#   (Related to testcase 1f)
+#   Commit O: z/{b,c,d,e}
+#   Commit A: y/{b,c,d}, z/e
+#   Commit B: z/{b,c,d,e,f}
+#   Expected: y/{b,c,d}, z/{e,f}
+#   NOTE: Even though most files from z moved to y, we don't want f to follow.
+
+test_expect_success '4a-setup: Directory split, with original directory still present' '
+	test_create_repo 4a &&
+	(
+		cd 4a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		echo e >z/e &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d y/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo f >z/f &&
+		git add z/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '4a-check: Directory split, with original directory still present' '
+	(
+		cd 4a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 0 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/e HEAD:z/f &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d O:z/e B:z/f &&
+		test_cmp expect actual
+	)
+'
+
+###########################################################################
+# Rules suggested by section 4:
+#
+#   Directory-rename-detection should be turned off for any directories (as
+#   a source for renames) that exist on both sides of the merge.  (The "as
+#   a source for renames" clarification is due to cases like 1c where
+#   the target directory exists on both sides and we do want the rename
+#   detection.)  But, sadly, see testcase 8b.
+###########################################################################
+
 test_done
-- 
2.15.0.408.g8e199d483

