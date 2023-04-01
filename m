Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1CC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDAIqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAIqe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967AEB61
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id f14so4864391oiw.10
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgKE71beAWoC8WrJ3PpwJo/E2/kKUMDFrNC9BHDi1H0=;
        b=pDFWjWcsmuFNHm9qwcO/qWfwVpM4ckpDsjS4BJZ/aq1du0PcG6B5w8AMemQJuumnj+
         DNJ4WRdxkV2IHfAFRkUQ81YX6sMzT4eaAfXh9CNY7OHdnp2evxd97Y1QDO1ND1ofqNp9
         pEEwhvyrKTZQ1RLCl++/PQau9w+uD2lmrWE3kLvLGN8dCJEO2MUkiFS6vThBpzpjgqTw
         R0bw5rl3NIFce1ytYPcyeJHbl6v4cMlAGZmFxryY6bhqQvR1TzofDVJp58MFF0/GTwGz
         cfreL5rsiEtVIt9Zs11NTTtvFe5xOG6HSsSXVdLs8KQMp46ntt8fDSwtHjUak7ULp0yk
         NxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgKE71beAWoC8WrJ3PpwJo/E2/kKUMDFrNC9BHDi1H0=;
        b=1m5cmX8SsGWM8FkL/+F+GH3EfHeNni4u2S/bjC4RYoufkbObq34mDPxrjimKK/sYxC
         SUCeLO85t8I6FIhiboGjMOKtOPpxo0GxJjtMmFXwI0u46p59g5mx9uv7siMaysxvIAup
         NwvoY64iRvGMedh1kCKW7b8hKlOlZGa0H/XsBRBszqByaoJtXnMvmjn/O6LnPlZHx2nu
         5lEGKTOQg6vjx9TBB/MTGAvuXSf3r0raXyG9Zu8jR8mDsAPa1o53SbL2PxX+DuISOqR0
         zLVT4KLA4mQkzLL/Z4LVggiK9mQJczs9dBclci/XYsgdXs0ydTs2LDgKICnZxVE+0WKz
         mjgg==
X-Gm-Message-State: AAQBX9dqVhLB+KyKD90xcI8rGBqmB0+jGTtjQXRxPoKUO/BbGYADtSvy
        Iic4U+3V2ERvw7e2XNHngGZrm0LBEhU=
X-Google-Smtp-Source: AKy350Z/xBqM5SkCXlas6VWaHyShs093xGNmJl05HW9cu1O2sEHVK3bBB/h6eNFFzz25y937ac+1DA==
X-Received: by 2002:a05:6808:3c3:b0:389:50f2:4ab0 with SMTP id o3-20020a05680803c300b0038950f24ab0mr7564881oie.10.1680338792335;
        Sat, 01 Apr 2023 01:46:32 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t4-20020a4aadc4000000b005264a1472adsm1743481oon.15.2023.04.01.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 03/49] zsh: remove version
Date:   Sat,  1 Apr 2023 02:45:40 -0600
Message-Id: <20230401084626.304356-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doesn't seem to be useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f61881..c7bc6a8f8e 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -135,11 +135,6 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
-_git_zsh ()
-{
-	__gitcomp "v1.1"
-}
-
 __git_complete_command ()
 {
 	emulate -L zsh
-- 
2.33.0

