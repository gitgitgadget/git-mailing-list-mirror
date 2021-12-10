Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C077C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhLJD74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhLJD7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64FC0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so5700141wmd.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lF0Qny1Pm3N34BJO5aaQWhPF+Sj80vpS8QUoUsBKUFg=;
        b=NxfLU2lVARxeoY7U1nf9vjUvQRdK7hS1e61B6XuTCrxgH2OTN+4FTtnojPUXVxKRvf
         XO06Am8c6jhMfI0+z7fBdTzNhmhbDOllwdMmCrPAlVFIJWxWvLwEAsJCIAk4SfLiqcYK
         1l0hk1tGk0WCR+2wEi3pym9Fsd/vTWBvGM8Kn9KTC4LxmZAgU5kR72ugntguP38jzwk6
         l+K01IJkjzmLgSGv4JPv75+szNMzXUU8OK7TW0X6C/NGBu7uIVNi/wgIwWfaqB7UZbyA
         QMi37uNDtg6eZXdMBLOAsI6BwvJhHdm4QKonlbvXjbAZB7ZuUQCDczfnbIntJoYRv7de
         wMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lF0Qny1Pm3N34BJO5aaQWhPF+Sj80vpS8QUoUsBKUFg=;
        b=zqqEhZiaPEQG6tTgcLF6aK328FJdn9TfJv6BUecIlbuPUe3RbbY8RhZsl4nk99McAR
         qoEJk5OtNmsI/NS0s3tn3V9U3Ekq42RtN9w347sk2epGt/rjTHjeAzBzbW4H0vEPthIj
         +5omg+5tWjAba0lqOqq8+KsfaghFIRes/kHDTTKhMgpfQaSpcrJy2GIq1sMZj3yBDVG4
         4qcL95sxuJXdGrLg9MWFw2P/usd/0L+dW5moufDb8CAVWYwpCUGwZUoC/Nhi8N2sYiQL
         nzsl+p1qUqts1qfo3xSeG1RSnaTWh5D9UKtnXHonw4SPK8fGhQZ18nJZMN9/Rz21ehR4
         +EAg==
X-Gm-Message-State: AOAM5335m0yhG6o7HD/qEIlsN+5yW6f8qws0c5i9O4Q4v9PtXR1W7+CL
        7SDNGy14/zSTQ+SmDoVz9ygKUzoqYgA=
X-Google-Smtp-Source: ABdhPJw3nob8nPfg74dt6kvf18HexF8ZmAHuZOat88lrGaUtOhfQi/MHOaaZ28Ec5eUPFqKMlf9OXQ==
X-Received: by 2002:a05:600c:1c87:: with SMTP id k7mr13215454wms.103.1639108577197;
        Thu, 09 Dec 2021 19:56:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm1366283wru.21.2021.12.09.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:16 -0800 (PST)
Message-Id: <82a13cc01973210a8abda4ab1e7b938ef197fb3c.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:07 +0000
Subject: [PATCH v3 04/10] sparse-checkout: disallow --no-stdin as an argument
 to set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We intentionally added --stdin as an option to `sparse-checkout set`,
but didn't intend for --no-stdin to be permitted as well.

Reported-by: Victoria Dye <vdye@github.com>
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e9f644ac362..0ee28f48134 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -699,8 +699,9 @@ static struct sparse_checkout_set_opts {
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
-		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
-			 N_("read patterns from standard in")),
+		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
+			   N_("read patterns from standard in"),
+			   PARSE_OPT_NONEG),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

