Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA9C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiEWNtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiEWNtC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:49:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE4562DD
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z17so1953403wmf.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QfNYBTxrTPqEokKT3VQEYgaGYVZKk2yWs7owInO/GCg=;
        b=SAcV2oPCjhM7cOEU5PWVbBLAE2TQs9ktziOKYDxiEpFYevsqwYbzL0VRbTY4EKmwPd
         Czsik3vZZ+of1okcJhTaBC4LsxRz+VVYWKZXUEdgWLH1Hoy9m4s4AZJvykclqxPbr7EI
         +qL6s4LQ45Nrevy/N+MlduHIP2x1ZAbZi5BIpMg6hL2r/z/42VESuzzKETFTW7SxpJSG
         1Ur/pEUxxpVi8kP9rrUzuDd5mabM6uSKbHPRe+JjRkSkk8rFgvovjDs76BoKFeCMoE93
         5SFToMdtmrCMv/RhZljGpWdAGgYs9KOp3fPJnq0RlGXCCF2vEqWNd1JdQPNvobXdUgvV
         0xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QfNYBTxrTPqEokKT3VQEYgaGYVZKk2yWs7owInO/GCg=;
        b=Zpgd47MHWau34N2Db6Ca2wJ5QXYqz4ZEfrfmLlqNaukjrlUDTIPc3KdUzV1/wPJifq
         vTd5dX+nHgra3bLX1NA+jczObsGfnKbikyAbdAO/vrJwK8BSkbAqAqnQRcNtKVeJotMx
         qA9awRUkczb46k9KgAr4bUzGV56NPqjh+wiFrg911wVftObzoYV4y59mFUVH+YCPs9tr
         dV3/pb9Fsv9Fbtyia8JnMhnNOgfAXbQ9Kne/aijqp0atXaGigE2RUPgquZ9RlnMRwZo2
         I5HZNUCfCSdEj0nPohZr6kfWp8xfNYyiDCbyW5eyV3/KqPYNVzg6v091bA+DKXYGCY6L
         /Cnw==
X-Gm-Message-State: AOAM531tg8gdXXtsNAbJEP7w7s7lEpjyQ4svuVtGADbQ23p3hOXaTJaY
        SpxCOgVJxMwG3qmbXYKLxhruJrYAVKE=
X-Google-Smtp-Source: ABdhPJyTDPNYyqHJ22taDwzeeO1pA/PRLKWx7+6fiVVKKaiWvpkyf0dZe+fgKvygj6Ztla/YCPHxwA==
X-Received: by 2002:a05:600c:1552:b0:394:52a9:e48a with SMTP id f18-20020a05600c155200b0039452a9e48amr20692757wmg.45.1653313736039;
        Mon, 23 May 2022 06:48:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22-20020adfa196000000b0020c5253d8dcsm10364402wru.40.2022.05.23.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:55 -0700 (PDT)
Message-Id: <75ecb579a9f69c6dbe5d88ecec0d8e7e15c02efb.1653313727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:42 +0000
Subject: [PATCH v3 06/10] sparse-checkout: --no-sparse-index needs a full
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When the --no-sparse-index option is supplied, the sparse-checkout
builtin should explicitly ask to expand a sparse index to a full one.
This is currently done implicitly due to the command_requires_full_index
protection, but that will be removed in an upcoming change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/sparse-checkout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5b054400bf3..1db51c3fd72 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -413,6 +413,9 @@ static int update_modes(int *cone_mode, int *sparse_index)
 		/* force an index rewrite */
 		repo_read_index(the_repository);
 		the_repository->index->updated_workdir = 1;
+
+		if (!*sparse_index)
+			ensure_full_index(the_repository->index);
 	}
 
 	return 0;
-- 
gitgitgadget

