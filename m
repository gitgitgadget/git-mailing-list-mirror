Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2AC433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiD0STp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiD0STj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499D18E19
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso3920856wme.5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l0GBE4Bw8UswNS7OaBN/M3WB04xhQh/eMswefjKAN3Q=;
        b=kudCW9QO8G+paHZs7zdmT+Nb1Aip9sMj8XgtjiBd7v1WcjnMrZ8pO5IUlXgC/2K79m
         0EKdlJcS/3NSGH1W0tLg/i5VYnqVF87NdPtHTfDRJjccoKaMpxS66tCqBaq2zzdMh5vq
         /SxceoqYiNs5Zoe3xMiZV2KdJ6KXEU9KCXJtxERZTImRQR5SXgwGvWgLodg4HwofKiQ/
         zT6Yyl+Dx8w/wDQV25po1gwL2NG1t0LNVV6Q1PHopXZaEGGaUGm1SzjeTT+5Bws87FFA
         RcoQ4py2DD9eY+Oz6pXT4+VFpPeSzpkxGBxVTKOGf6hvw5fd/e9SfJovlbn/dBh+1+xo
         NFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l0GBE4Bw8UswNS7OaBN/M3WB04xhQh/eMswefjKAN3Q=;
        b=UuWbuRtvrVSzXhhAOfiM3YMB9pfcALPLveMDK7rQ6bnZzG6OSw6K5NdmZi2yyPrqwk
         biDu124ujG54xldR0cubj4I6iO4EbPmhaF3jAmp6tHSU3b++YhONhpqMw4Wxvm014bLr
         P45tnQFOgtJ4GeCkcgKcDx+ZFNccaa40/PHlB4+TlNcm3LnebTV869AhTY3TKljuRIKG
         z2HPx/nWlYccyu6qzJLb2FWv2FvqfOzwgK43KbcIwBgCghOfpgEryswk3MsMsGsCgEZS
         XLZTLVJEZLMsU9zEMyGdvscbaRGuZ0weeclsIJhBFZOmKAS/6Wt9c0he1N2HspeYexY0
         qgFw==
X-Gm-Message-State: AOAM533uSHHT7kIHrJuiauyCpsMcLShDEsU9jQrwPa6JPl2+l+Wz7pfH
        UJ4GInxFJGZBgxUwKD42mpxQBXqpeGY=
X-Google-Smtp-Source: ABdhPJxRpAn2cnST9jeyxtSDFUSSR22Rf8VVyKtERXnalH0zumzQV+WV33hghDnbNlO5R4VY1oBhvQ==
X-Received: by 2002:a7b:c086:0:b0:393:f6fa:cfc7 with SMTP id r6-20020a7bc086000000b00393f6facfc7mr9570464wmh.62.1651083384906;
        Wed, 27 Apr 2022 11:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc14e000000b00392a3e62b66sm2032024wmi.33.2022.04.27.11.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:24 -0700 (PDT)
Message-Id: <73f04e95400f7fc8ea43a48abeb29b5c70244fe8.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:14 +0000
Subject: [PATCH v2 3/7] sparse-index: expose 'is_sparse_index_allowed()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Expose 'is_sparse_index_allowed()' publicly so that it may be used by
callers outside of 'sparse-index.c'. While no such callers exist yet, it
will be used in a subsequent commit.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 2 +-
 sparse-index.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8636af72de5..ffbab7d35f1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -118,7 +118,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-static int is_sparse_index_allowed(struct index_state *istate, int flags)
+int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
 	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
diff --git a/sparse-index.h b/sparse-index.h
index 633d4fb7e31..f57c65d972f 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -3,6 +3,7 @@
 
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
+int is_sparse_index_allowed(struct index_state *istate, int flags);
 int convert_to_sparse(struct index_state *istate, int flags);
 void ensure_correct_sparsity(struct index_state *istate);
 void clear_skip_worktree_from_present_files(struct index_state *istate);
-- 
gitgitgadget

