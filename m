Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49134C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382163AbiDTUqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382157AbiDTUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37EA3DA46
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4504456wme.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=E/aeU+tyQeU64OOCduUCtqneaVwXgKVG0aEJ6Tle/oGlKs1K2NbX/SZJWbfBCNRpxp
         LtJz3PyHlCIXh3oQUtLXSCz4c05IimMohpGxorpKAco9qZwxf0aXLmDRv+/spJ7Xdwe5
         LSVy24gTi0eWgzPkdPXR5YNLpXSCYu2rngGt/L8u/IprVixbVCPdv2sDtNxncAHCgjCD
         tSBTEzKU/hxPSJx/bD8EMfp1GPaAtpe+QuD1cS1M7qQtx4I29JWVtfHL2yhVZd/Dsclr
         0xYBWFCUyeQmhUXJctNKMDVqxm4zOdZdZdb/K9fFRxVsa1a9p71/PqKgcSPytQaquzDG
         99kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=ptWB5lQcmYs4e9IIcntAFGv1oJW2fbP2WXaeeJMtSS0e4DqBPYh9DIcI6I7qcxPVw+
         vwppzPMAnMcPlxJWrD9r8quYD19LCMWK9RafWJUh+d9GgAqFQZUYmDUfagCLvBmYAJZp
         H9ZBHSfk7st7Lkmhsl6sF99V2Z+lsZtrP/S+XShHCSwuoquo6yIFLYD3shWPzwtjdXJQ
         uWvdeAGB1ciL3iyb+w3FMmJMLr12+esFZ0VbRGsQVN0fnctoSGIA9Rx/gd8FLKTb9Z8m
         w0Vepokw+3ogvWu8mQQbzfwwlZpwzBVRXrwM2B/Tr1D+1RNKvVsJc25mlK5ODOAAP1KJ
         c48A==
X-Gm-Message-State: AOAM531kEHc4HRNaMWEQsbQOVIz5lipJqkntgEYUqO5K5PAGjb7ZxbZA
        f9E6kPZzDE0qBkIEK3Qt9xt4+kC+h9s=
X-Google-Smtp-Source: ABdhPJwWeD3yrk5JGRVjlv6P/uicmvnzMqg+9PjKliYXyafp6EoqPbkrT37JIlsJJjTMld05jFF+wQ==
X-Received: by 2002:a05:600c:1d8b:b0:392:ab4f:365d with SMTP id p11-20020a05600c1d8b00b00392ab4f365dmr4770106wms.113.1650487415220;
        Wed, 20 Apr 2022 13:43:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b0039187bb7e9asm316128wmm.6.2022.04.20.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:34 -0700 (PDT)
Message-Id: <8d48d9c562369a29c1488dfcf7bd51a58158236a.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:01 +0000
Subject: [PATCH v5 11/28] unpack-trees: initialize fsmonitor_has_run_once in
 o->result
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize `o->result.fsmonitor_has_run_once` based upon value
in `o->src_index->fsmonitor_has_run_once` to prevent a second
fsmonitor query during the tree traversal and possibly getting
a skewed view of the working directory.

The checkout code has already talked to the fsmonitor and the
traversal is updating the index as it traverses, so there is
no need to query the fsmonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3a..888cff81f9c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1772,6 +1772,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
+	o->result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
-- 
gitgitgadget

