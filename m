Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8947CC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhKWLbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhKWLbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:31:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EECDC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:27:58 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o29so18413999wms.2
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EeZQP1mgzMsi/xgRhFYcRk2bBECX+07KOV8ZayylIkY=;
        b=eODQT21sdY8OUWQSEHMFGhqmFKzDzg0p84n+OYSmkmqXujo1Uv43dyVigyhUzD60j+
         G2kJFor6IEND5WQPlSDrxHGwysiEgcXi0lNBkD3zbuL4h+IUi9ERMPCJy7SdBXaajkxO
         wCtkfgbDCosr25sFGdckwNubgeiPzOd37fBOZcZhkrbpQLyeL43r9sNRQ43AKDx80Plb
         kR+RinKR+IaGWKSc9/h0bUP4M5gexLm+MlPzgHmahuUAXuH7tn4+nFkqhJS3Xtm5KHeV
         Zft9Pf+r1eXld06VgNrKsAxUxtco5S0YjgcYuzHUx8K6gujM+ypCyTSGFfnm4gOlna3b
         Yxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EeZQP1mgzMsi/xgRhFYcRk2bBECX+07KOV8ZayylIkY=;
        b=FOJSQreo+r/kFrks1DPEOgh95mVFypHOshqOD/B9JGyC+HuvDk23XCYpTDOVqu9Bvl
         6RgbroWgafAKJFM4+b+/ne68bKa8CLZOfStWBtccGJU7INHazBLJ42LTRMBXYYPrV7ft
         MccyfACFrqSS4LFu/mlF6NIfMId51JvjgaScv0QjR13T3EZpAaq8AL7tORMWyiUcTrPs
         hiUcrmJtCEv0rR161NP7sr+5IEenxMkUqfvud1ijfuU/Dh1zBUNmYBWM4f0vfTp7ohqw
         IcoAPfF1w4Gfiqp7iBGtDOiSiCPsgkm0izH8I1vphbzyLQTBRzRpEwcqrDOLTcTXjvHt
         CVZA==
X-Gm-Message-State: AOAM531OODbe0RSiIb9YMHJEMRzcfrGDeW1kJYU+Pt8IZ4QVGjpXSUMb
        Bv/aeZJTgjpD0LK3YlmCeA+AcJ8up5Q=
X-Google-Smtp-Source: ABdhPJy4bpyjRDm9cvjD5QngvCNZZVXHADeId0x2hz9uXOspfBHuLLlnkmCXWmVwGaIGyEmEFVUbSw==
X-Received: by 2002:a05:600c:2205:: with SMTP id z5mr2130616wml.40.1637666876593;
        Tue, 23 Nov 2021 03:27:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm14902877wrd.24.2021.11.23.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:27:56 -0800 (PST)
Message-Id: <pull.1083.git.1637666875171.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 11:27:55 +0000
Subject: [PATCH] completion: add human and auto: date format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

human was introduced in acdd37769de8b0fe37a74bfc0475b63bdc55e9dc
auto:* was introduced in 2fd7c22992d37469db957e9a4d3884a6c0a4d182

Those formats were missing when other values were added to completion
at 5a59a2301f6ec9bcf1b101edb9ca33beb465842f

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
    completion: add human and auto: date format
    
    In bash/zsh completion for git log --date=, following values are
    missing:
    
     * human (introduced in acdd37769de8b0fe37a74bfc0475b63bdc55e9dc)
     * auto:* (introduced in 2fd7c22992d37469db957e9a4d3884a6c0a4d182)
    
    They did exist when other values were added to completion at
    5a59a2301f6ec9bcf1b101edb9ca33beb465842f

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1083%2Fyoichi%2Flog-date-completion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1083/yoichi/log-date-completion-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1083

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7c3a75373a4..37fd5c4c885 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2001,7 +2001,7 @@ __git_log_shortlog_options="
 "
 
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
-__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
+__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
 
 _git_log ()
 {

base-commit: 0ea906d20517145895193a99666d5f2860a04360
-- 
gitgitgadget
