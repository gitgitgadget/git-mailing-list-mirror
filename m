Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3EDC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiCAU1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiCAU0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC43888C3
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so22336643wrf.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ql7OrUv2dimnvaZBSchTpW1zo/+46L/f+KWulvTkios=;
        b=MkEkupKHdtdTqC6InYYm+pcioeqD7ysFvdIiMbl/USFns0ZzlWjnry7PwbMrmeGj1Y
         4TpkRdRdWjUHPW72jqTupn9yCyh7PIVli9yIU2BRie0k2pCJ1mXtWF/7i0OhRJDPSemr
         hrdoAnOHxvv6/RyB2WMBzFeHTDJM0yrQP4uUEdZc+0NwmWOnywLUTLbfoDX8Gslq4PVZ
         XkFceDtn0KxBBHFQig9LaYYhEWMT7S+kfJrDcbffMZThPxEOh8X0VlNG+hjAS9/MGxrr
         ubANOPudIpjcgcVcfqZ0Y0AmgxQFjtS6OVIUYRkoMX1sNGXIuckXExKolrG/48X8n7cQ
         LgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ql7OrUv2dimnvaZBSchTpW1zo/+46L/f+KWulvTkios=;
        b=c8NYY+IgqKXndDZvVHmPYZsj1Cui3dvw9vaGH8sRPHsPu09zqzerinbp/niNFLJ6/S
         CnqiP9VegFTxm8R5b3X4qc+PMqi84gIsZ3++HWFSR2htAQPKtTvSCkTmnbeklGKkKJrm
         ffbnROIAwLDg4ofwLURawjcBmTvbZlCnOjnLuhs2a7AY2SWZkpYFIeioSJykKtvxZY8E
         teqiHnBgbIla/AwD3+tjgYNTatZVSob3elsx0CX5/lpeLBwA7AiVSidS2UxIAwHdRom6
         O0+ydZtInoSRS3A7HHcfpLLVKjcxRNP0MdCgWo6WXLmE7PvTRJej2+072Bjc2+JEauGS
         Xyew==
X-Gm-Message-State: AOAM532nTwTSdUIk1O+mvIwpkcOJ78gLUTXn3oMlDJqvre3J/oOpF00Z
        j/uiSaka495rgVDQzC/D8KPKC7Gz9pI=
X-Google-Smtp-Source: ABdhPJzlCkdbGnwuUam7aLoliEOosAdf2clPEfbdwMZjc3nAIxo6BohUqMmzhc2bUjH01llfWwlIQA==
X-Received: by 2002:a05:6000:50a:b0:1e3:5af:153e with SMTP id a10-20020a056000050a00b001e305af153emr20699535wrf.385.1646166275029;
        Tue, 01 Mar 2022 12:24:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm3419003wmj.34.2022.03.01.12.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:34 -0800 (PST)
Message-Id: <e48a281a4d3db0a04c0609fcb8658e4fcc797210.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:26 +0000
Subject: [PATCH v3 3/8] read-tree: explicitly disallow prefixes with a leading
 '/'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Exit with an error if a prefix provided to `git read-tree --prefix` begins
with '/'. In most cases, prefixes like this result in an "invalid path"
error; however, the repository root would be interpreted as valid when
specified as '--prefix=/'. This is due to leniency around trailing directory
separators on prefixes (e.g., allowing both '--prefix=my-dir' and
'--prefix=my-dir/') - the '/' in the prefix is actually the *trailing*
slash, although it could be misinterpreted as a *leading* slash.

To remove the confusing repo root-as-'/' case and make it clear that
prefixes should not begin with '/', exit with an error if the first
character of the provided prefix is '/'.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c         |  4 ++++
 t/t1003-read-tree-prefix.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2109c4c9e5c..c1a401971c2 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -166,6 +166,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
 
+	/* Prefix should not start with a directory separator */
+	if (opts.prefix && opts.prefix[0] == '/')
+		die("Invalid prefix, prefix cannot start with '/'");
+
 	if (opts.reset)
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
 
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index e0db2066f31..c860c08ecb4 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -25,4 +25,14 @@ test_expect_success 'read-tree --prefix' '
 	cmp expect actual
 '
 
+test_expect_success 'read-tree --prefix with leading slash exits with error' '
+	git rm -rf . &&
+	test_must_fail git read-tree --prefix=/two/ $tree &&
+	git read-tree --prefix=two/ $tree &&
+
+	git rm -rf . &&
+	test_must_fail git read-tree --prefix=/ $tree &&
+	git read-tree --prefix= $tree
+'
+
 test_done
-- 
gitgitgadget

