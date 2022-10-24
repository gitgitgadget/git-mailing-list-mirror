Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72408FA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 07:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJXH55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJXH5w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 03:57:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FF5D107
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 00:57:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g12so2000854wrs.10
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/b4kpopHfyn9SW8RnlH0tuEZV1fQ/tDEqkPaqxF16kM=;
        b=ankCh7mMrQ+PIDxSCKMBgpDDeJ2TCCGxsyPxm+1wkuQbfYPC6xLfl4KP72rRnYSGr/
         fDqRqeb9dPE/th4s59VAguxSMLOaSqEorz6ahZ552x+hnb0avkogTid3gCAmlW/vRVPw
         07DU4/o8LfW7PJYMuYE3ytbwcOLTZdLc5H0ZWKn1+AUUmbtKrb4rbik5adkkRjo70+pf
         U0rgED+Rh4NTfv5FBvXG2Y/DXCjKqfKCNX7jzDF3R0jg/KbBFjF3Anvt0hpvFiPcLHid
         tOIIaGjVTIzDScndWN2+oTuvVqIsroplaqgN9Dj4xZ91TpTw1Ew/E3PlK/3MWq959qRB
         hUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b4kpopHfyn9SW8RnlH0tuEZV1fQ/tDEqkPaqxF16kM=;
        b=gBENedU3LH8C5yw2wm3nbuPz8H+i5t+wUUoL7Mb/3kMdvuwx6Pqj0Rneq6uidz2v9p
         nMozc1yEdQUPerphkmSGOWeseIyR5gl1lFCfCOEF0BSsPcOH8t7gtQLvKJZUGbefdJNX
         hwJklzNV8IxySZA+8lvER6k5HKnu8Z0EmW9SPfFYHajIVoelt58XAuLfvVN473CoePU4
         3QCISI8Ojy4GAmi46P4HtgVcQ1XFo8B99sfPA227WoIG9Bydfc8jgJRv1cdVZTiRhhN1
         2Z3jlcX67VvdpLvfdWKKHICpQbr/5dy6LSj+PUPWfvEaFhrjrYstz+/NeJF10+thLiCj
         sUdA==
X-Gm-Message-State: ACrzQf2bkASxBEnmPwYAAmSktkvBiMaRdUEbSqHR/XwVyv/Ahmc9tqpk
        7h6B0PpDqJxlH+7zU/qZIRlgm3V2PHI=
X-Google-Smtp-Source: AMsMyM5TDsjPPF//fRhwhqFXgcgWYyjSDRT2TV7epPw/+gOXjmxnfhEkv9N7JF/w2kZZAT+DZoZUZw==
X-Received: by 2002:a5d:64c4:0:b0:231:3d94:6eb2 with SMTP id f4-20020a5d64c4000000b002313d946eb2mr19990347wri.580.1666598269631;
        Mon, 24 Oct 2022 00:57:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a1c5409000000b003b4868eb71bsm7362705wmb.25.2022.10.24.00.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 00:57:49 -0700 (PDT)
Message-Id: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 07:57:48 +0000
Subject: [PATCH] docs: clarify that credential discards unrecognised
 attributes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

It was previously unclear how unrecognised attributes are handled.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    docs: clarify that credential discards unrecognised attributes
    
    It was previously unclear how unrecognised attributes are handled.
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1393%2Fhickford%2Funrecognised-attributes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1393/hickford/unrecognised-attributes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1393

 Documentation/git-credential.txt | 2 ++
 Documentation/gitcredentials.txt | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f18673017f5..ac2818b9f66 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -160,6 +160,8 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+Unrecognised attributes are silently discarded.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 80517b4eb2c..e856e3c8330 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -269,6 +269,7 @@ stdout in the same format (see linkgit:git-credential[1] for common
 attributes). A helper is free to produce a subset, or even no values at
 all if it has nothing useful to provide. Any provided attributes will
 overwrite those already known about by Git's credential subsystem.
+Unrecognised attributes are silently discarded.
 
 While it is possible to override all attributes, well behaving helpers
 should refrain from doing so for any attribute other than username and

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
