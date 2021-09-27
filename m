Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD95C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B5660EFD
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhI0Qfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A505C061740
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a131so1027432wmd.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fdxSgXAkjKOC6rvLjgYPcBbfMtTZ4/NxPILc4lAO8W8=;
        b=PpkmOA/EuJHaIh49PBItTNN2G2izMj+3NjgLeiKBh1j1lRotaS+Bok08J5kKW54gfX
         9pgjQ7X35/Lu7gFP2Yd5kZXRk2B9EYzcGsuKsYWZLnAKw8rbsQSpokZyMdk7kFPqPJzL
         CCDFmzTFC7ja+eOfBf7OUjfI9S3n02pnMyBN/AS1DXN9T3kihk1UZ9AJ/chsoAK68RYm
         lgyvO4LdXbNFpaINt7WvJtkLWtQHvBpTdB6rL8DJ8wcPY5WBgzNRjuoFe8G4JinE0lqv
         Ff2k42CpB3Lz+5MfBCsEBv6Op5JpeRWRTk75pjjVUwMnmS/gzQEzMo5MNjJGShA5j/5/
         +SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fdxSgXAkjKOC6rvLjgYPcBbfMtTZ4/NxPILc4lAO8W8=;
        b=bUXWAERb+rFDa+/MUIHpF+sa9N57Nfj3T2EPpmvsefNz0Y1sDSwaAF6t7zbr0H+QRp
         nSuf11G6BvdmI1TwBGCfjZE638ziAfAjq/k1pBv5f1cLw/D15a+AUXM4/7pi2WszbBwJ
         1RG/1brGghXB826SUoUKFloCd7ZIWnGl7LbZo8NbJtbn4MlBWxEbQHqfXzakjy6PIJvy
         eBeZa/nQXw56oy0VPoYl8ggoJAbY2MHcR18szl0FJwCE8M3KH+C20/0iAwqFP4W0mo6B
         3c3PZQS7lv9smegbfymxbVR5tS6VopQE4bxIgcP4wKg8nxtJ1V7GtR6Yo0Ci5SNE7aWX
         UaMQ==
X-Gm-Message-State: AOAM530CccaeApkXo6+rN1X3R82BLtL1Tokees0S1TGjOs6tEY3SzGGT
        /z9yE2RItpscI+wwOvL84T5OA8bR5Tg=
X-Google-Smtp-Source: ABdhPJzsU8/MosRXOmhYq+3efc1U8SGHXFQuzyv5RLHyMFujkGFvg6hbw6G9uySyWEFcE/KX2lBaxg==
X-Received: by 2002:a1c:149:: with SMTP id 70mr16392364wmb.187.1632760430731;
        Mon, 27 Sep 2021 09:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm3554674wrv.31.2021.09.27.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:50 -0700 (PDT)
Message-Id: <0c74285b25311c83bb158cf89a551160a0f3a5d3.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:39 +0000
Subject: [PATCH v3 02/11] checkout, read-tree: fix leak of
 unpack_trees_options.dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c  | 4 ++++
 builtin/read-tree.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72a..5335435d616 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -760,6 +760,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
+		if (topts.dir) {
+			dir_clear(topts.dir);
+			FREE_AND_NULL(topts.dir);
+		}
 		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			/*
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 485e7b04794..96102c222bf 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -250,6 +250,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;
 
+	if (opts.dir) {
+		dir_clear(opts.dir);
+		FREE_AND_NULL(opts.dir);
+	}
+
 	if (opts.debug_unpack || opts.dry_run)
 		return 0; /* do not write the index out */
 
-- 
gitgitgadget

