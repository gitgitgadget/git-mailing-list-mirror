Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED841F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfJUN4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38941 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfJUN4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so3327463wme.4
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xCZIUJKlOnbwNhuxRGiI7T/gfJU3N5zEWpmYYb9368g=;
        b=oESJxDEPb4CG7bfP1yxGsQmbSoGjdkDn5rXDNL97dGNtBUZLYQylx+Q6jyh1j6ah89
         r6pNvGmmQQXd6LoRlvZRj97EoNbPneoKnUzmstq7mHv7AKJVM8qECnl6TMZs7+AQ9Pyt
         4REj+kXQLEsKFqBYJNzd4pRTj2SAu7XUAPQccF4IaWamArrux/bxJBeFoYg0a4hm2Tm7
         CIhqY+FcO2GziW9pO/Qq38UmOGaVvjSxb2iZcpxzILusJGfNHYFqaSoD5usA5sknglcA
         rWQAZC10WMcmyTMYVTvRsAPRr9XtRSJlrGCOCxvDEBYMrnQKpdpmeJY8ZuXegtYawF4C
         U9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xCZIUJKlOnbwNhuxRGiI7T/gfJU3N5zEWpmYYb9368g=;
        b=Kd8ClGmdS6EJQxREyHeOco2ux26hje/uvEBVBnO3yWm25yJWLB59CoeUT1bz6a8K9p
         lxBaiAE2p3nECXKJzjZ1th6xFmb+5POoteAJg+rUMnqlg+yUq+VhLCbUPDUx1kkL8Rd8
         u/wVKKaPGDn983urb8zRzLipV7kI7uMZCxQPaZcOveJd/bI4VcBLEq0QuYKuz8b/6f4U
         sEhyFVG2uMx9uf16FxA9wHZlUiVmVcWJybYx1XCIC9xe2S1gTjxpeP7cqQxiR6yEp+N1
         CfBM6FGDw9QbPJ9QZSNxckfZ4tkW+gtF7NuEvbfZK7nTV2fo9yWxMWMXWuvkqBieiUnw
         Zgxw==
X-Gm-Message-State: APjAAAXvSRBt3pPlnSlf1X0XEDp4p9cxFEaUWX/AlxMcOzkviPbkWEkM
        W4AJQGZV+UdycRBf1rYi5rXUmXUa
X-Google-Smtp-Source: APXvYqyq8W9JtPHMvWeDlY0X4ky1gY6FE9aLoJCTP/N42YnRE5vKm/eum+QV1W0HMF8DhgPcO5/IFQ==
X-Received: by 2002:a7b:cc8c:: with SMTP id p12mr18859537wma.167.1571666198925;
        Mon, 21 Oct 2019 06:56:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm12134660wmd.22.2019.10.21.06.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:38 -0700 (PDT)
Message-Id: <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:22 +0000
Subject: [PATCH v5 13/17] read-tree: show progress by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The read-tree builtin has a --verbose option that signals to show
progress and other data while updating the index. Update this to
be on by default when stderr is a terminal window.

This will help tools like 'git sparse-checkout' to automatically
benefit from progress indicators when a user runs these commands.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ca5e655d2f..69963d83dc 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -162,6 +162,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.verbose_update = isatty(2);
 
 	git_config(git_read_tree_config, NULL);
 
-- 
gitgitgadget

