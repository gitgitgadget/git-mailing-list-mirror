Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF391F462
	for <e@80x24.org>; Tue, 28 May 2019 15:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfE1PTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 11:19:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45931 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1PTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 11:19:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so17478319edc.12
        for <git@vger.kernel.org>; Tue, 28 May 2019 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IfAkDnwnA7f31iaGdJFBOSAcNuTDco3poLRLhxajZps=;
        b=HqGM1r2N14ycEsHSYFAyBxzFpWezxjdbQ/9nhItpx5uG9ifIjkAScmcZiwCdU1pXbJ
         8DTO4HEQOpDThNg9FJXEpxkuIRjJofyi0scvqSHXrH4HQwtAHkAFAMNcC1JG8JLtIIRQ
         Bx/K1f66+zj1LQ6qyl3k/697V6Yw+CcxDhsgIQIq+OoP2ikZ5tLDnuztFiH5bzeoEzfb
         xYAVHGTvE6jqf/iUqO5Sz7SMEGKSoDPP31rzsbx3Q1ztrDd0N7L0PlxSPe1yqUT7XWok
         y6v9XriVvNmGsnqboNFz42kYvG9cDYmHiFn5QVr7Aq/kMCATe7N5IhqfRStdzx7ZFbfq
         ExiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IfAkDnwnA7f31iaGdJFBOSAcNuTDco3poLRLhxajZps=;
        b=DJtir/agwoNO5Z0429gj5yT4glh63B55yzJi+KDVrWdWSDKNYQYFUUtYJF4uyr+mkT
         76KMg5KwQ7wjTNWk/OdwV4Hc5FBcKUuRwuLgN6XmrO1H4XNs+JRArX5YgqWwrN/Vdwev
         N+55CcLLOpH9jzhQmE2IvNH4EAyGd26vN7S6UThPedjOyHH7TkBnxKrCCXMZjYq+q54/
         fZ39FnsVLoLjgBSEEVgBGSYteK5E6TDBEMAoKVE3Lt1AF3JCA4AXoW5639hkM2Zc0wDe
         5bJRyy9gBGrM91NDNO4Hos0q7C3mpBOrJ8UIYoVDiLQSKnQSKbmidjAZ2D1+992DBgUv
         N7tw==
X-Gm-Message-State: APjAAAVPVagtDmod9FzekT/U4Rom7MChysmXYcnkGQXI+/M6KyJPHTQ+
        f6vm1oxJAFr6K/noKSgbT85FKM7dGdU=
X-Google-Smtp-Source: APXvYqxRckAysMs3HF4xaSY/ihEfFKFgOEDPQUe9jcqjRLWNjrRUFlU+Ftq5HeHbeYqA84tFNUWLvw==
X-Received: by 2002:a17:906:bcc7:: with SMTP id lw7mr86462846ejb.106.1559056747130;
        Tue, 28 May 2019 08:19:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a40sm4350161edd.1.2019.05.28.08.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:19:06 -0700 (PDT)
Date:   Tue, 28 May 2019 08:19:06 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 15:19:04 GMT
Message-Id: <pull.228.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] sha1-file: split OBJECT_INFO_FOR_PREFETCH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found this interaction while testing the VFS for Git fork rebasing onto
v2.22.0-rc1 [1]. It seems this new flag meant for partial clone prefetches
interacts poorly with the read-object hook we use in our fork.

The issue is that OBJECT_INFO_FOR_PREFETCH has multiple bits on, so testing
"flag & OBJECT_INFO_FOR_PREFETCH" can be true even if not all bits are on.
My fix simply splits the new bit into a special flag while keeping
OBJECT_INFO_FOR_PREFETCH as a union of flags.

Jury is out if this fixes our problem, but it definitely seems like a bug
waiting to happen in Git, too.

Thanks, -Stolee

[1] https://github.com/microsoft/git/pull/140

Derrick Stolee (1):
  sha1-file: split OBJECT_INFO_FOR_PREFETCH

 object-store.h | 10 +++++++---
 sha1-file.c    |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)


base-commit: 0f4a4fb1c4239a2aa46343add84ad6f99f6f3aae
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-228%2Fderrickstolee%2Fobject-info-prefetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-228/derrickstolee/object-info-prefetch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/228
-- 
gitgitgadget
