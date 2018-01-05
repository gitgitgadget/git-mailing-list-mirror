Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DB81F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeAEUaS (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:30:18 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36835 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeAEU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:25 -0500
Received: by mail-io0-f196.google.com with SMTP id i143so6987587ioa.3
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPQdUyHNjeRrE9xG2o9W48hlZKz9WRpsjR3PHEnvyDk=;
        b=Yy2CzLPTAJwt/Omm3XN5zLavxcedNGh/WEjBwzTyn9ioQD4zRJFJtkajS0k8s1DaBv
         ZMW3rq4Yj7yl7vjqB7rxwpcSdus05cJCPg2IAYjewnjBHSPnoNroKJWlktkuDPGLpxky
         bWzDCF9iOG7nqI6pO1DkiffUnU1F22UOP3a1MIwGPg1TGstsfFEJe3teuSor72dFpkQa
         SrMjTwOziGhPrjtpVh5c/zXOzGpc/uJ5sCHILJsFfHuWbacYpWQToG7kG9WF//0Ii0zM
         0xrpEvDkOLVLEy48k835QbWGKSPB+D64PgVzf1rY/86qbzrSAS9F9NyxIxEp0+M6oK4Y
         5M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPQdUyHNjeRrE9xG2o9W48hlZKz9WRpsjR3PHEnvyDk=;
        b=LCsUS1Hr5/b4qKyZeRlqG32JTFjWQd199b9mMKulgBximl8dtHL2xjbO2BnxAls2uj
         TaB/fwv6Xs/FzGLfuvZnrVWvSprvirf61JlblpZWag3Bfmpn1Hc6ham9t796zMyfjrnu
         I2NddgpLgUsTfoL+GkaFHXkfhLZ3KlELx+PGyZledrMo6IyuyM1pps0S73FRtivrithr
         5UfmCzua/tNCdS7K9Ol9DPRU8XB37yAyHwet4LaONn+adg5ve7VNwLxSiWsv+wWOlzoZ
         NVhqcIahDRiW/ugRvnrxuG5sM5mDVaD78KROlPCX0fz1yzH/27/TSxJibxTWAo20Zb4h
         yWZg==
X-Gm-Message-State: AKwxytda0oPuHxRpCUjkvr1fs17RMVbGnpsuVG7+XhbgH0cdzRKxf8fx
        gIK6ePhyTofNFmuTpIj8cBEMob23
X-Google-Smtp-Source: ACJfBosV7+dRhsG4z7+g7BXQetMrmj4M8dfptucY2lHvNA5j/1JiCLKDymhaLFjEuLgeok1gR3FwXQ==
X-Received: by 10.107.43.75 with SMTP id r72mr4142141ior.53.1515184104796;
        Fri, 05 Jan 2018 12:28:24 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:24 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 04/31] directory rename detection: partially renamed directory testcase/discussion
Date:   Fri,  5 Jan 2018 12:26:44 -0800
Message-Id: <20180105202711.24311-5-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 239819f2d..c61ecb9b7 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -735,4 +735,111 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
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
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
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
2.14.2

