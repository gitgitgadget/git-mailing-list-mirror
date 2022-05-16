Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FDFC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiEPSLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbiEPSLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F33D4B5
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f2so14595144wrc.0
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnR1tnT4QBFQfMJMAKPgZ82lu5UpfUErt1pLv/Nsqlk=;
        b=A/VpyrnbHlk7ET2Nytz9p1bSCcrdBFUulpfm91riUyQyVGWIPCCQH8ZMBKDPEAia2X
         NF5n20V9TEmV2hHVISOuZPu2O1Jo22kFxcbbMNeYlrcfWxaG7IMYU9IlVIAcpihQDESE
         8V8P1tuX/O0KZ1YzICpP7cNlTYK6TDZ9t6coUWK2EN5A4GaE6STnPb3F2kpuBnTH4/13
         2nnuyMumESD5S75UJb3/rIGw/4tZcLJF60nQOF14xu973XYuJzMoAm3Lg/oUyN5tg5vd
         Ql+H+M8ywy9SdHpTK2djlAqfiuqlAFHvN2KqA+bwLk5/ezB4ubZ4uj9B/HUawqfZiCKG
         ISbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnR1tnT4QBFQfMJMAKPgZ82lu5UpfUErt1pLv/Nsqlk=;
        b=EvPprIwHKa7K91a5+hmtSuMIEUETB98MceJohiaWhB+7jxLZp9OiSVpPwMvxBCgYlH
         2iQh/EuL/qYEKMmlyg66rxkg06sYaWYNtsMJQdeQrLgoIpMSA19d0FMGQRg9HF2HUbii
         7WyoFTjbqrLMr0wO/twKhmPcAdPO5L54q6mAHXnq3PwI80fYtRqUV3HOwrSh3ggxaJws
         QpVqjV361zhybPf/FxrLId5qci0EZvfuw7GoNhN9z+ID343mDSqk+WL57t0KrebBKwyN
         +rQ4SiIAv84fh/4Tx3gJ2MzkmOcfl6wZ/7OdKUvlColXKbjMtDI6rsqdXrnbAzngPbiY
         rgXA==
X-Gm-Message-State: AOAM5312+m+ZRoOMF7lbFzEJcztA1h3vxdOd4Mb1eVDnWKWvfPw00bYM
        i2wQVE53ypqHaCQmt8U9hEFJr0AaOJ4=
X-Google-Smtp-Source: ABdhPJwCWSxFmPcXUWhcGuYS6NYCIZLwHMaXcTYu4Emf+jgodkpyiuesHi+S0+S7wOU4d2+S84fv9w==
X-Received: by 2002:a05:6000:1e0e:b0:20c:59b4:e9db with SMTP id bj14-20020a0560001e0e00b0020c59b4e9dbmr15681482wrb.524.1652724699769;
        Mon, 16 May 2022 11:11:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t21-20020adfa2d5000000b0020d0f111241sm1959496wra.24.2022.05.16.11.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:39 -0700 (PDT)
Message-Id: <d1fb2e0e0d3df29e38c92b0e5d24ff797bfa53b0.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:29 +0000
Subject: [PATCH 4/8] sparse-checkout: --no-sparse-index needs a full index
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
index 88eea069ad4..cbff6ad00b0 100644
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

