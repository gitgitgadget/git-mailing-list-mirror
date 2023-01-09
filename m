Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B1BC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjAIKra (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjAIKrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 05:47:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57F622A
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 02:47:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id az7so7705979wrb.5
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CBT6d+3Eo22oLmrSNFBDzIOAhHZ8z/YYogmcePYuFo=;
        b=RVPOzuPo3AFc2AG2kwfMapoFVPrkC+w2JmQKdi96u2VoriUS33iDjPp/wBipLgmJFW
         /oDoAr+sIBWS7ia10bXMmYoTzu5nBSuSA0tfhV9WeopuaWDBnohCxvV35I4vlVTzh/gy
         2TxUqhFlmtTM56+P190x2vxSZUOaG6wv04p9Q1MRpIZ1r+PK86HFp7lvf4GlFyhexo5w
         LbxfeDXHmynLuRXuFcmu8QRSGAn6sqUR62ZJwuMUPSSOtSCK8E1bV8IAHgAFW2WGgi/3
         ky/7+hQCda9rogcYenOGImpy0/JWcMxJhLoCUif7Uhl2YRoq34MIDoMnNo9NFPFwOuJq
         6pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CBT6d+3Eo22oLmrSNFBDzIOAhHZ8z/YYogmcePYuFo=;
        b=Dh3T6iMgvBHe/Letw8TXXv4TCuMmq5+uILAme4cOpttXHjLN5pChgUoSS7Bv7P422X
         o6znKtcqeKFwWwMztqfgHTHlqkvrqoaLvT0mMwPpcowlyYCq6WuW3gIc2lH3BADt2i3D
         UmQh+Zudr+jFuBT+YgSRjCf/OUmkaB5GZhBSQq93cynYvAFPwPVhx9NEnBHEoYKUi/qC
         4n6S5WlnzvrlA8lxzcfoBGCbo8OEvtJ/6umjErCbTGK6CcH1wYIL57trH30wy0muk+do
         Pd4jDH6SkcjJ5m2Yz0INd451bLth7g3/7iQZZx7ZsHUNEabtrNxJNYOW/FaVBlt4qqHc
         dcIA==
X-Gm-Message-State: AFqh2kr6UXkCQtv3/S4XctVNUh5hfnbsO7MeDTRdECSIP71QwX6UDPWx
        ENZm4e/bj8jYJG+5VqjIVPPxJ/xnkq0=
X-Google-Smtp-Source: AMrXdXu43fuFBY5lWfGKxgu/nr6sW/1cWKo+4B09UX8rslnD0PuZPbbLr6HHUwMHjb91XTvlGWit8g==
X-Received: by 2002:adf:ed0b:0:b0:2bb:4b40:2d1a with SMTP id a11-20020adfed0b000000b002bb4b402d1amr5318918wro.56.1673261238972;
        Mon, 09 Jan 2023 02:47:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bx11-20020a5d5b0b000000b002366f9bd717sm9964642wrb.45.2023.01.09.02.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:47:18 -0800 (PST)
Message-Id: <pull.1422.v2.git.git.1673261237449.gitgitgadget@gmail.com>
In-Reply-To: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
From:   "Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 10:47:17 +0000
Subject: [PATCH v2] doc: add "git switch -c" as another option on detached
 HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Yutaro Ohno <yutaro.ono.418@gmail.com>,
        Yutaro Ohno <yutaro.ono.418@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yutaro Ohno <yutaro.ono.418@gmail.com>

In the "DETACHED HEAD" section in the git-checkout doc, it suggests
using "git checkout -b <branch-name>" to create a new branch on the
detached head.

On the other hand, when you checkout a commit that is not at the tip of
any named branch (e.g., when you checkout a tag), git suggests using
"git switch -c <branch-name>".

Add "git switch -c" as another option and mitigate this inconsistency.

Signed-off-by: Yutaro Ohno <yutaro.ono.418@gmail.com>
---
    doc: add "git switch -c" as another option on detached HEAD
    
    cc: Eric Sunshine sunshine@sunshineco.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1422%2Fohno418%2Fimprove-git-checkout-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1422/ohno418/improve-git-checkout-doc-v2
Pull-Request: https://github.com/git/git/pull/1422

Range-diff vs v1:

 1:  b7a11452979 ! 1:  2103912b406 doc: use "git switch -c" rather than "git checkout -b" consistently
     @@ Metadata
      Author: Yutaro Ohno <yutaro.ono.418@gmail.com>
      
       ## Commit message ##
     -    doc: use "git switch -c" rather than "git checkout -b" consistently
     +    doc: add "git switch -c" as another option on detached HEAD
      
          In the "DETACHED HEAD" section in the git-checkout doc, it suggests
          using "git checkout -b <branch-name>" to create a new branch on the
     @@ Commit message
          any named branch (e.g., when you checkout a tag), git suggests using
          "git switch -c <branch-name>".
      
     -    Use "git switch -c" and fix this inconsistency.
     +    Add "git switch -c" as another option and mitigate this inconsistency.
      
          Signed-off-by: Yutaro Ohno <yutaro.ono.418@gmail.com>
      
     @@ Documentation/git-checkout.txt: before that happens. If we have not yet moved aw
      -$ git checkout -b foo   <1>
      -$ git branch foo        <2>
      -$ git tag foo           <3>
     -+$ git switch -c foo   <1>
     -+$ git branch foo      <2>
     -+$ git tag foo         <3>
     ++$ git checkout -b foo  # or "git switch -c foo"  <1>
     ++$ git branch foo                                 <2>
     ++$ git tag foo                                    <3>
       ------------
       
       <1> creates a new branch `foo`, which refers to commit `f`, and then


 Documentation/git-checkout.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4cb9d555b4b..9f116acdbd6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -477,9 +477,9 @@ before that happens. If we have not yet moved away from commit `f`,
 any of these will create a reference to it:
 
 ------------
-$ git checkout -b foo   <1>
-$ git branch foo        <2>
-$ git tag foo           <3>
+$ git checkout -b foo  # or "git switch -c foo"  <1>
+$ git branch foo                                 <2>
+$ git tag foo                                    <3>
 ------------
 
 <1> creates a new branch `foo`, which refers to commit `f`, and then

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
