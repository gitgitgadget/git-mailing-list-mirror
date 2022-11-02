Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D554C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 10:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKBKac (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKBKa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 06:30:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240362ED
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 03:30:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p16so4806060wmc.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyblppFnyYzYHCFfhSPVqoON5gGsjC4eXgBGOvcv8X8=;
        b=Fk6kcI/JcpNLi1GM+h7MAGsjKPaRwlSTeI34eWWKGvobIGqXZEiCf1NtjTWxEP49Do
         r/0PQgYPgGv85H0VYWDUR0niEgX/eeapDxvAJEZqSWUj62U61FbEYjPiUkoT0jYEBEeZ
         /JUAHYKoKnSdLlSbWNWjEBzBqQkHn5sC/5OAVTVditEafQGttgX1i5FsA+tp8WPfrxwU
         plUuTyzW5I0ROGNhfhf+6MmXE37k+cY+Z0GgTlONaDMb5dwru9puG8PdhLgVDwK+IrtX
         JkXPFjRHmTlvy8EBxphkDX9l4bcT1UCyQNa8NLC/HVPJnOY+veCo/XZRvW1zKl+yGQhc
         14MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyblppFnyYzYHCFfhSPVqoON5gGsjC4eXgBGOvcv8X8=;
        b=1Ms+/NJCWfTvvIDMlwwJLuH7NGaxH4GVJRmqdLj+n+Pb7Lj8udro4/kBe2IpsSqNsz
         OmRdhZXAKgf2WWtMlZ2m8Tlm06rhZVqy6Kgm97da+nqzapOa2nIGuiJyAVAecepqg3r+
         8fxjqdJb/nFeMy7rM7rJWaikDPQD4dLfp5S6XY51kcScuPWpgxkmk+J9NLXN/fxssFzs
         kwrALcZpopjNYAo95D5EyLmyEuIOSKmL9ysaVRxJ8b5J+6myUfJ+pq8JYwXw3zU63q/w
         uuYvY9sLC9xfvI9qlJbO6BCDDGHc0uYLfEMEuqCp6iMCIJ7866raajoq+iZB73tVyTbd
         Ee4w==
X-Gm-Message-State: ACrzQf30wBheCND2yD2pXmhpxozYyVrw7UR0oyQaQBYKrmjJPknSGh53
        WFjUFr5E1nFoO+Yvjy1O/pfTln+visI=
X-Google-Smtp-Source: AMsMyM5ffIL1ZkDzCK2Fu8HKVlQSLBiWcW9hGGckMcYHihynHOC89oy5UZzD96692rv+B8/uVID5XQ==
X-Received: by 2002:a7b:cd99:0:b0:3cf:7556:a52c with SMTP id y25-20020a7bcd99000000b003cf7556a52cmr8657329wmj.53.1667385023527;
        Wed, 02 Nov 2022 03:30:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003cf55844453sm1634185wmq.22.2022.11.02.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 03:30:22 -0700 (PDT)
Message-Id: <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
In-Reply-To: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 10:30:21 +0000
Subject: [PATCH v2] Mention that password could be a personal access token.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

These days, the 'password' for a software forge might be personal access
token or OAuth access token. These are popular, so worth clarifying that
Git treats them just the same.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Mention that password could be a personal access token.
    
    These days, the 'password' for a software forge might be personal access
    token or OAuth access token.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1396%2Fhickford%2Fmore-about-credentials-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1396/hickford/more-about-credentials-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1396

Range-diff vs v1:

 1:  fef359f533a < -:  ----------- Mention that password could be a personal access token.
 -:  ----------- > 1:  0bb69988ad7 Mention that password could be a personal access token.


 Documentation/gitcredentials.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 80517b4eb2c..402e067a6ca 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -21,6 +21,9 @@ in order to access a remote repository over HTTP. This manual describes
 the mechanisms Git uses to request these credentials, as well as some
 features to avoid inputting these credentials repeatedly.
 
+Some repositories accept multiple passwords, including personal access
+tokens and OAuth access tokens. Git handles all of these the same.
+
 REQUESTING CREDENTIALS
 ----------------------
 

base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
-- 
gitgitgadget
