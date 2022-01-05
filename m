Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE2C433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242212AbiAER1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiAER1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D5C061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so3708566wme.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=eYhQO4WwXf0uE9Jh00Xwoo98cqFX07KpKEbC8zwt4xVpuUeGCwPXaFJZ0WgkEphWaN
         Ez3CH+eX5V52Tc1lZXxf8QQdXi+wVs9ijbtajl4y/YeBIBmyaE1GZCfmsqhn7gkDWJS9
         PuYWmECezzvt6pZl7fiCR7f3Hb5LlVHc3g53LT+Jjwc1cXFYHLDhM2jqPnRXOuEW+Gsu
         pm5CsfAXTjpyz87bIk14GrnLndPtctpMdBZSE8jsvmJTTlq4SJdPkQUeGOv9/UC1gwcG
         HLcl9p71kPKvq4/7s0h+u63c7jaUFlPrI9PA3tJf6P1XMrM+K/RdEp+6bzQSkFW/S939
         po1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=iLG6x9lhxJOpvDNhao60ZQBLXywCaOT9e+C9FjFZiaIeIfCRVdEnUFr/z5TcwtNWfC
         fQXfr12PGICS9CZibgZbsjXSDsQpa8gyIgRmSlyf0l8drYDumQnVzuPKYKFRjWFQrw4/
         didvo5YNnjxb8tmPFFgrAsmtiQihevzjQV2MS9QLAxrxTUdCLBiYmEj0XGaFIo+T6jgE
         I//WrUjmW+excVwa0WdJ9U8jATqRjZx2c3Yd5zJTNhPoLftwM74tOESdNByqIYH5ggYK
         JG1/WUQ5P7VM0f6nNU5d4lx/dxrmj4kAIfO/yPae+RbVW+RI7F098ASO/6Z0OSu0RNKT
         HnXA==
X-Gm-Message-State: AOAM532Zk5+PwYJeSdp+IGVFMay0lmdm40ZEhftX3rCsbk7lOYG78dqE
        iyF13aMd5V+gIHpI5eL4KOgqtSqk9/Q=
X-Google-Smtp-Source: ABdhPJw80r7fAmnuV4tNLRM1Th4yEWTBI24YXkzYn/E3PNZHAItNwWh8StO++9Cr8+EngE1bRIMqWw==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr3701611wmj.168.1641403657983;
        Wed, 05 Jan 2022 09:27:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm40802111wrf.39.2022.01.05.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:37 -0800 (PST)
Message-Id: <aafe67d7c6979aac5764e300ebbe3033fe7103d7.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:29 +0000
Subject: [PATCH v2 2/8] merge-tree: move logic for existing merge into new
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..914ec960b7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,12 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+static int trivial_merge(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +383,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget

