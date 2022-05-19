Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96AFC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbiESRyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiESRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D71EA9
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so3113122wmr.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnR1tnT4QBFQfMJMAKPgZ82lu5UpfUErt1pLv/Nsqlk=;
        b=oLmxrLjRO/EqKhBEUMRnomEOqqDvY75SmhZOIvZVtd4u4w35lCud5ZDRrUUipECJav
         8RmmobbwhxH+cSXwFkZbRjtQvh1VgTEKZph2LsA/4DrpTnmoLzrO3p5gZ892/zs2HCag
         JcD+uwtmMzDE5AyVt7O42ExHmnEz52QPbKZXE9fCp5rrgJBAmjZwC0nfNzzXY6jxQU9Q
         K1ceO+UI2lNeVNKqz7UVevoiVI1pHMCOrA39pbxGRWjLVlyGrEVeIEY4DHj2GdtZ5+df
         PehvlLTTC4rMRn2PRzClUrDSqt1szrTrPk5LILX2WS9+noMTbWuzQG6PnDh6jAjGbCKn
         4GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnR1tnT4QBFQfMJMAKPgZ82lu5UpfUErt1pLv/Nsqlk=;
        b=anZbqdzU6nLUPBDTlftTMlxUCN7iGH33GBo51LYYJvtMa2z3RA7GqGvBB4EvnT9exw
         2HCOO/UXJbc4VOHXCzs7OxHiv3L7oTcgAfE41R534/c9pdAXOstPrgZLryE0hqmFlVrt
         y5Y/bVoqO3Uu4kGkjsSCKAt/psOYgiTZK5C6WlKg61NfDszErQfLDvMPBdNgWMsAlPTE
         jN44KPrFu9JH7oW59tsJ/SHrxNSPmKW1l4Y+ITBaxlb5K/8bf5AweMc0hfmzd283mfQb
         DHS2l2lDzWpdKZ02KLEZBvsZ3S+SeEPh1bauKDA7PodoArr5k9rVqX8j5pnPItn49HJr
         E17g==
X-Gm-Message-State: AOAM532OANP4s4rMhL9MyAC9so9fZBFBInkbjiwlOKPT2gY0csM00uH1
        INyPeMasny6ueH5uJWkqY/mf9QAF4KU=
X-Google-Smtp-Source: ABdhPJxIVpnnWbj/K8UQx/oiPSy7rf1+wvnOJExt9meweQGxvgrZSaKwa5yzfhssU1XJ8S+kVbjoNQ==
X-Received: by 2002:a05:600c:21c8:b0:394:7796:49c0 with SMTP id x8-20020a05600c21c800b00394779649c0mr5054396wmj.191.1652982767205;
        Thu, 19 May 2022 10:52:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b00397335c8ad4sm205458wmr.1.2022.05.19.10.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:46 -0700 (PDT)
Message-Id: <e42463de0d218b63bf0c786590708b1be32257f0.1652982759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:34 +0000
Subject: [PATCH v2 06/10] sparse-checkout: --no-sparse-index needs a full
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

