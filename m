Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C2B1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 09:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfJaJ0q (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 05:26:46 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39990 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJ0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 05:26:45 -0400
Received: by mail-pg1-f175.google.com with SMTP id 15so3665295pgt.7
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PxOV363m1vNlwQ/gyxMAES4j8obbNydbPqnv3X08cI=;
        b=V18uLr2H63zmBH8kQx3M+TBYb2pcQUqpusHoDWZKUNU9GA9Cs8ZEAfwGH6vMApZiep
         I7ptk3oAYOdSR5/euqmC7EYAwSMDk3pL6Ec5fyFwZPkhCG3oZiYgl1DiaE7OTsbgDOBa
         NtAvWz3Zd57nsIDnzgfcXu55eEfsYJjUuDUydUX5Il4CdLBXIzBQbrvigbB458RclHvo
         AyhxyPyz53SxFKrI3OTgwPbiePELVxi8pbLFAegZ7flcInEa3PKf69CpahGtPnr+MjVL
         lef6jZgUqeU3li/zxK5Mb6ZL/SyHMmrSZrudk2ZV92wf3BhyrH39+ENIiOeK//VJjbFF
         Xymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PxOV363m1vNlwQ/gyxMAES4j8obbNydbPqnv3X08cI=;
        b=nu5r/gDImZPMQTpWbjnxrOp5xTegC6onx34//+MehgOX6LN6ZEU/khFG3tlH5Tr0Rh
         DZo5zlGVqfSBX8iTlkeqDcbR76xG22d/W1zAHUE3VY32lx/Yk/cnNjLpxG7qfO6fuj/b
         hn0A/EpG9kRr/BVoR/bdsqd85W6DXEVfYvzqZ7j0RhCxPkD93SIt+Y9TSAqobbk3QpKt
         0BuGBkZT2ZYQx41U5s9SaWtcBUylrq5+X+l39NcmXZV187Oi0armdwWBXSxXuo+qPgT5
         7W7CGd5/yR+VxuvAfKkh3qqlwW84lb1utzFWsQjJdKcljA9ClCgxxeV0aDZRzirunPdv
         Drcg==
X-Gm-Message-State: APjAAAXdNPRq/3cuij941nBmuul9NTWKWoD2ZFs4cxHWUDCNdNSsib8N
        Rl0COeteuzVnxhfvUxYBZFou5IPe
X-Google-Smtp-Source: APXvYqxePoPyQ4SVj4+lCoWJT5k/oPFSbas7hxT3Yhyni9aELoLoIYBqJcR4tMs0nNrLYnxFT3L0uw==
X-Received: by 2002:a17:90a:7188:: with SMTP id i8mr5874884pjk.54.1572514004796;
        Thu, 31 Oct 2019 02:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id y24sm3570558pfr.116.2019.10.31.02.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 02:26:44 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Date:   Thu, 31 Oct 2019 16:26:17 +0700
Message-Id: <20191031092618.29073-3-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.3.gc8da3990e5
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From commit 79444c9294, ("utf8: handle systems that don't write BOM for
UTF-16", 2019-02-12), we're supporting those systems with iconv that
omits BOM with:

    make ICONV_OMITS_BOM=Yes

However, typing the flag all the time is cumbersome and error-prone.

Add a checking into configure script to detect this flag automatically.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

Notes:
    We deliberately fail for ac_cv_iconv_omits_bom on cross-compiling,
    in order to ask builder provide the value for the target.
    
    We're relied on this technik for ac_cv_fread_reads_directories and
    ac_cv_snprintf_returns_bogus.
    
    Adding one more failure for configuring on cross-compiling
    is not going to be a burden for distro.

 configure.ac | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/configure.ac b/configure.ac
index a43b476402..790b53bbdc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -690,6 +690,28 @@ fi
 
 fi
 
+#
+# Define ICONV_OMITS_BOM if you are on a system which
+# iconv omits bom for utf-{16,32}
+if test -z "$NO_ICONV"; then
+AC_CACHE_CHECK([whether iconv omits bom for utf-16 and utf-32],
+ [ac_cv_iconv_omits_bom],
+[
+if test "x$cross_compiling" = xyes; then
+	AC_MSG_FAILURE([please provide ac_cv_iconv_omits_bom])
+elif test `printf a | iconv -f utf-8 -t utf-16 | wc -c` = 2; then
+	ac_cv_iconv_omits_bom=yes
+else
+	ac_cv_iconv_omits_bom=no
+fi
+])
+if test "x$ac_cv_iconv_omits_bom" = xyes; then
+	ICONV_OMITS_BOM=Yes
+else
+	ICONV_OMITS_BOM=
+fi
+GIT_CONF_SUBST([ICONV_OMITS_BOM])
+fi
 #
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.
 
-- 
2.24.0.rc1.3.g89530838a3.dirty

