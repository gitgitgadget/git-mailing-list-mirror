Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B997C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 13:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiKHNBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiKHNBc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 08:01:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77EE53ECA
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 05:01:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w14so20846224wru.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEBx30LICdCRu/SFzwquL34DYhr81TMNOEj2EIfIbAQ=;
        b=Is694VpbPXeD9geOElJeu6TvWMRT07vq6sUDh4MB8F+a1W9zoknlsPpnt339su33e1
         EManFbsAWq3gQOMkrIErBRpwPqq5Qw3B3pH8WkjB97tXyPVRdLwxbAskODKDEIiRQnZs
         uG6OSwE7LVE8AlEMuGzY6luBSn+Z4xerziyMDqFJ1wzv2AQzJrH+Dv+2Z253R6kEjFGx
         lOg/bPx2RVb9U7I3uX4cC/aTrYuUfN2EPEUj4G+p3MwR6h57/fQPSUuyxQXowL80DLbk
         7JMrSJ4zMH7WnSUdH+yvK3J3F9Vm90wHSVoGp+wvqwhFTdIlaz+nccDjwl0I5Oyek7pc
         kGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEBx30LICdCRu/SFzwquL34DYhr81TMNOEj2EIfIbAQ=;
        b=SohT+1s0hz34BJxKV+bKtCRP6oCRW3lRrEioerPsTjKZKuu2A9x7uDvUwwQP0jbjyA
         9Tkx/INSi+OmJp1gCHr0erPvBlohmUwLIgPnR3TwhwBRjNDQiJC24i6wA3tzzCnBqel4
         WGki87x1DQIRc71Zv0OzaOod78V712A7mu2QBdGeifuOwDeeE5cAQ4eZQbII2R1aCBkp
         vaY1DPXDP6mBL6CCJzFybaEYbagf6OwJsKtOTxIX5uuZ1fO2yaAbqx5DNCufAZiunam9
         s21XgbY6+WmAdYuF6gYcm9V16/dFfFYW0xhtEEPq7O5s2MBJJ6oxxeJDV5EXCODI3vei
         ZNpA==
X-Gm-Message-State: ACrzQf1meFanK1cN3Svxfx+DkTNjua63nVAfW6EeBbDfytJyn25fj/vX
        i7/jTVE8L20LEJO8C/+ml3cO1tGaNyw=
X-Google-Smtp-Source: AMsMyM5nt8a5nJnnYnSG+SP8mDy2F+35yPxumleJ+IXJRwhInlhmVODjComlWS63I7Hc3jDpxix0vA==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr35546063wrn.251.1667912489468;
        Tue, 08 Nov 2022 05:01:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b003c6b70a4d69sm11029108wma.42.2022.11.08.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:01:28 -0800 (PST)
Message-Id: <pull.1396.v3.git.1667912487608.gitgitgadget@gmail.com>
In-Reply-To: <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
References: <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 13:01:27 +0000
Subject: [PATCH v3] Mention that password could be a personal access token.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Git asks for a "password", but the user might use a
personal access token or OAuth access token instead.

Example:

    Password for 'https://AzureDiamond@github.com':

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Mention that password could be a personal access token.
    
    These days, the 'password' for a software forge might be personal access
    token or OAuth access token.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1396%2Fhickford%2Fmore-about-credentials-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1396/hickford/more-about-credentials-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1396

Range-diff vs v2:

 1:  0bb69988ad7 ! 1:  7be4a631aca Mention that password could be a personal access token.
     @@ Metadata
       ## Commit message ##
          Mention that password could be a personal access token.
      
     -    These days, the 'password' for a software forge might be personal access
     -    token or OAuth access token. These are popular, so worth clarifying that
     -    Git treats them just the same.
     +    Git asks for a "password", but the user might use a
     +    personal access token or OAuth access token instead.
     +
     +    Example:
     +
     +        Password for 'https://AzureDiamond@github.com':
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## Documentation/gitcredentials.txt ##
     -@@ Documentation/gitcredentials.txt: in order to access a remote repository over HTTP. This manual describes
     - the mechanisms Git uses to request these credentials, as well as some
     - features to avoid inputting these credentials repeatedly.
     +@@ Documentation/gitcredentials.txt: DESCRIPTION
     + 
     + Git will sometimes need credentials from the user in order to perform
     + operations; for example, it may need to ask for a username and password
     +-in order to access a remote repository over HTTP. This manual describes
     +-the mechanisms Git uses to request these credentials, as well as some
     +-features to avoid inputting these credentials repeatedly.
     ++in order to access a remote repository over HTTP. Some remotes accept
     ++a personal access token or OAuth access token as a password. This
     ++manual describes the mechanisms Git uses to request these credentials,
     ++as well as some features to avoid inputting these credentials repeatedly.
       
     -+Some repositories accept multiple passwords, including personal access
     -+tokens and OAuth access tokens. Git handles all of these the same.
     -+
       REQUESTING CREDENTIALS
       ----------------------
     - 


 Documentation/gitcredentials.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 80517b4eb2c..6df50e8a144 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -17,9 +17,10 @@ DESCRIPTION
 
 Git will sometimes need credentials from the user in order to perform
 operations; for example, it may need to ask for a username and password
-in order to access a remote repository over HTTP. This manual describes
-the mechanisms Git uses to request these credentials, as well as some
-features to avoid inputting these credentials repeatedly.
+in order to access a remote repository over HTTP. Some remotes accept
+a personal access token or OAuth access token as a password. This
+manual describes the mechanisms Git uses to request these credentials,
+as well as some features to avoid inputting these credentials repeatedly.
 
 REQUESTING CREDENTIALS
 ----------------------

base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
-- 
gitgitgadget
