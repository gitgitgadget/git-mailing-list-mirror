Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD60CCA477
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiFDLSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiFDLR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 07:17:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0897
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 04:17:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d14so4388374wra.10
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4yB7Px2TZcbzgD7bLULWr1MIQJCMeGKAZG3VIdlHz88=;
        b=AcfRDXbIzO2Z0gQgRGfAt/wwx1tn5Yp47cx0LnShRNCKvWsB16c/6z5wEv/ZOIFqAA
         9eCM8yksb/3gWZIFNfwgquAvmgDm2ZbEoliZobcZzKEn/wKzZtM6G74Gg8sqpRE+4tKM
         LMJabGg2Z8NYM5dEkGMeshxm3XBrUl0/c9Z6/TZbpfRwNHIQ9fIbdgWfE3rkfdr/o97N
         B+G+dq5zxEg4tnah0147oCwAa7Df7yp7//GxKX5MZRZs/D//SU9M45+YbCstW8MazLji
         n/8Xu/YIyIvFLBadxjOekDkm0D6hMdynluuAhYhIb6WXQXvyoOvRMP1CE0vjKMk+xDqm
         l38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4yB7Px2TZcbzgD7bLULWr1MIQJCMeGKAZG3VIdlHz88=;
        b=UzGLXMmAAMbDJPUDIWXah3MmfqEUFxUzM/YehZOOenM4G9OmodxJQq/VQebp5SrijR
         xSGcvNsEya6RFxvl09DTyzTCkQds5Sb2zeVB3byODP+zZjt5NuDTtR09V+1SsXDqfKa6
         VAzUMJJXapJRRVaWt42iZkpM9FvFNxfuwDyWLrY3kFEw0ZYwga6DNaI6WKFs6xCbt5vB
         lCKDQT1dAfPs6vhnrQl9Kqut9c7QvfRY+FGEeLXr8E2nsX9Fp70hmKif/swYLe3L0iYC
         aAwQCUUm8CUW0T2yuYK8pBZ4BBUm0ifDMjpF7zukRs/2JblkkgWLJnWgdu5uzWOtOJnB
         mzGA==
X-Gm-Message-State: AOAM532fsCqqmpB6mCI6h+0JcVLnu44LHIKl7izP6utUmrBzMs8SQggp
        3P97rEXwZPxTfLh4s9RSt7HXEF0H5PhleU8p
X-Google-Smtp-Source: ABdhPJzuJmp9c87BG4WK+K5j/YTsPB2Mcqvr0zgepG1jHCjgfWTVWzmfd91OtFBgPkauRr20MzZu/A==
X-Received: by 2002:a05:6000:1842:b0:210:3d62:2768 with SMTP id c2-20020a056000184200b002103d622768mr12438925wri.301.1654341475648;
        Sat, 04 Jun 2022 04:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b0039c2e2d0502sm8811970wmq.4.2022.06.04.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:17:55 -0700 (PDT)
Message-Id: <ae02c6d5a6e9ca3da8bdf2188da933a6b8ec33ed.1654341469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Jun 2022 11:17:49 +0000
Subject: [PATCH v2 4/4] rebase: translate a die(preserve-merges) message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

This is a user facing message for a situation seen in the wild.

Translate it.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5f8921551e1..640b6046a5a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1183,9 +1183,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
 		if (!(action == ACTION_ABORT) && is_directory(buf.buf)) {
-			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
+			die(_("`rebase --preserve-merges` (-p) is no longer supported.\n"
 			"Use `git rebase --abort` to terminate current rebase.\n"
-			"Or downgrade to v2.33, or earlier, to complete the rebase.");
+			"Or downgrade to v2.33, or earlier, to complete the rebase."));
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
-- 
gitgitgadget
