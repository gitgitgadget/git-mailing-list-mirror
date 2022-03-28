Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C03C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345669AbiC1UuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiC1Usv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3FDDEBD
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:47:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r13so22026262wrr.9
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cjEMdvwzkM/bm1Rm8GpRkkt/iYXUIfXiMuNcqbo3O7Y=;
        b=BIkPJxUelvfiYMvgt3+c76wLq/Z9W3zy18fETwN5FvBRGGpWkOGf9Geg1UR5S7DWjA
         OMf3k7ApfJMP4yaxtw+hwvLUlGi6uHcxeDCeN3f9w67pvPxVLaafnRQb42vmnD/mi2C3
         QLFT/ShYWQfYK5+9PVomBrMJSPK/tmvstLzQz3HFWORRyUp+gqXoX6+5VsENX4VinUx/
         GFgBVEKjiFQqRwNibS+doB0S6KywEoVu1YDBgIDEdRrvBAz9nlr0Qy/9tCSafVN+gM6E
         c++LOmmqM+mDqiiVm71GFUsaidc1320BaRx4uLSlvwJBpp5/eUS1O1O1M74y48OOgPa6
         E15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cjEMdvwzkM/bm1Rm8GpRkkt/iYXUIfXiMuNcqbo3O7Y=;
        b=72mtQn0ZhVnUHdiS1nLswS8stXgEpDSOCcCBUHxcT9I7Ovz2gCsXOhb4EiCuBraHlg
         mnZ8Fp4X64JUs63XtwnTE1mfKKMPgWkCTi8mUlHtCLBXGx/feOKo8T6RtlLFKCcr6mQP
         F8qsVFOPOUPh5e9cByt3lz8ymoiDhc4JRrAEpVxjB0YaCVct3mDupLkE0UGJMlYE6ta0
         1NTUgVDxVhrAzC147bMPJYOmT7ffQcCema2pJk2KwHjwWAC8We7DQomZCJoij2lqGddz
         n9X33Ail0Fn2lQBqaLBMxoxss4wmfFKFHa4D0YoXI7jRkcGelh0/QCKflL7Ou45gavJc
         xMgg==
X-Gm-Message-State: AOAM530Jz4782wfCunnmJSw3zm5ITJWlH9ZdaxdeWVY7QODVw3c5SFPT
        gKMd1m4V/GSdgka/y8J0Sq2Kkctzobo=
X-Google-Smtp-Source: ABdhPJwxueS8K1K5ohGZJy5JSXHdXNjP8k4SmgrWev8jkl25Vcu9jCAyIIk6UFyaTUeSewOrHFXH6A==
X-Received: by 2002:a5d:50d0:0:b0:203:ee99:a8fe with SMTP id f16-20020a5d50d0000000b00203ee99a8femr25090491wrt.600.1648500428347;
        Mon, 28 Mar 2022 13:47:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm19246247wri.0.2022.03.28.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:47:08 -0700 (PDT)
Message-Id: <e0bfbfd5320edad29d20bef5e4eab2750bc3016c.1648500426.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1188.v2.git.1648500426.gitgitgadget@gmail.com>
References: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
        <pull.1188.v2.git.1648500426.gitgitgadget@gmail.com>
From:   "Des Preston via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 20:47:05 +0000
Subject: [PATCH v2 1/2] worktree: include repair cmd in usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Des Preston <despreston@gmail.com>,
        Des Preston <despreston@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Des Preston <despreston@gmail.com>

The worktree repair command was not added to the usage menu for the
worktree command. This commit adds the usage of 'worktree repair'
according to the existing docs.

Signed-off-by: Des Preston <despreston@gmail.com>
---
 builtin/worktree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2838254f7f2..8682ff4c417 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,6 +22,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree remove [<options>] <worktree>"),
+	N_("git worktree repair [<path>]"),
 	N_("git worktree unlock <path>"),
 	NULL
 };
-- 
gitgitgadget

