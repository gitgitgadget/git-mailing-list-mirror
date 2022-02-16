Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C9C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiBPQeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:34:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBPQen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:34:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4E253BF1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:34:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f3so4237458wrh.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hCn69NOG7xRDMFGpkX43xIwrDVfVC0eXVdNFJbB3fG0=;
        b=RYHazmXfRYJu2PVYzkUX7rcWj7yFXTL4LxWC4023iD/bz0nwPLB04rwrtHanqNnyah
         AuIUOv4bUTfjAIMGOslse7jyFG9FJoRxiZ710fZm0JGbrPDfskSJ4rxT4LBl+myt+fE9
         MzPsM0xSFsR7Twfcu9oHJx7YmJwoiRQ+FdeVUe7FBazEUIrIK+ZjE8eWeRwhX/etKRA2
         LASkitJ+IPfGDKaJPhuyN/H8bEIcH6zj0BI+cWFCqnRlQRb3SwrRexkfhpolxpeMrp4S
         OmCG6YNldTlZA3jnQfsprqUcrBx+t+qpDCHgGJrem2x1CWvpS9nA+iIqlBvm29AFkH8f
         Wk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hCn69NOG7xRDMFGpkX43xIwrDVfVC0eXVdNFJbB3fG0=;
        b=AsoQZBxH1WNT1tJDiXyAwo4CBm98HHwE3pg80ECqQYMD702xnyN5gUuvWackkemxZk
         heNaQUZw4yQugIGuIwTUQV2s7JOeuSDfVG1yxwPet6fT6nysGY5dbM3cq2+DkKtm5HU8
         jeRX9MmVVzWl13L1tRylKEcQgtnUSQmt6h5L0nri5qzNNuX4nBDC4pH1mPpNaqK7Paev
         SXAu8dz1P13OOk8/yjSuiieQc0yddvrvhiocq//rEQt6rbWt+UIIBPWtdvVdYcZUzNwW
         YAFkFhMnhoSNRnUQ1xiH1ZTN7V93W7nB6LL++n7iTcJ8Lenslj7mA/+vEeKENkc2Fgdq
         IrAA==
X-Gm-Message-State: AOAM531qEdduoTXoAiIYtYUKdBLdkABgK48f08+zH9umY/Q3jBvLKmGk
        8A+qmTS1HkIKEI5GzvRRDXzYExIOwjQ=
X-Google-Smtp-Source: ABdhPJyU4Q+CwKAz/3Qfter8hmirpiEcnJ8h+pMNU25pSNd2timW8GWdYECaqcAPYznyttBkZhG+Ww==
X-Received: by 2002:adf:9141:0:b0:1e3:1379:4cc6 with SMTP id j59-20020adf9141000000b001e313794cc6mr2965236wrj.249.1645029269022;
        Wed, 16 Feb 2022 08:34:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm18223545wml.38.2022.02.16.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:34:28 -0800 (PST)
Message-Id: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com>
From:   "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 16:34:27 +0000
Subject: [PATCH] docs: update coding guidelines to be more inclusive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>,
        "Merlin (they/them) Patterson" <merlinpatt+githubgit@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Merlin (they/them) Patterson" <merlinpatt+githubgit@gmail.com>

These changes make this documentation more inclusive.
Using "male" and "female" as examples of gender is unnecessary.
The use of "it" shouldn't be used to refer to people even in an
  example of what not to use. People are never "it"s.
There's no need to specify a person or group of people that
  learned "they" is only plural.

Signed-off-by: Merlin (they/them) Patterson <merlinpatt+githubgit@gmail.com>
---
    docs: Update CodingGuidelines to be more inclusive
    
    These changes make this documentation more inclusive.
    
     * Using "male" and "female" as examples of gender is unnecessary.
     * The use of "it" shouldn't be used to refer to people even in an
       example of what not to use. People are never "it"s.
     * There's no need to specify a person or group of people that learned
       "they" is only plural.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1070%2Fmerlinpatt%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1070/merlinpatt/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1070

 Documentation/CodingGuidelines | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 711cb9171e0..ffd7fa9c0f4 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -552,9 +552,9 @@ Writing Documentation:
  Documentation/SubmittingPatches file).
 
  In order to ensure the documentation is inclusive, avoid assuming
- that an unspecified example person is male or female, and think
- twice before using "he", "him", "she", or "her".  Here are some
- tips to avoid use of gendered pronouns:
+ the gender of an example person, and think twice before using
+ "he", "him", "she", or "her". Here are some tips to avoid the use
+ of gendered pronouns:
 
   - Prefer succinctness and matter-of-factly describing functionality
     in the abstract.  E.g.
@@ -566,8 +566,8 @@ Writing Documentation:
      --short:: Use this to emit output in the short-format.
      --short:: You can use this to get output in the short-format.
      --short:: A user who prefers shorter output could....
-     --short:: Should a person and/or program want shorter output, he
-               she/they/it can...
+     --short:: Should a person and/or program want shorter output,
+               he/she/they can...
 
     This practice often eliminates the need to involve human actors in
     your description, but it is a good practice regardless of the
@@ -586,15 +586,13 @@ Writing Documentation:
       versions.
 
   - If you still need to refer to an example person that is
-    third-person singular, you may resort to "singular they" to avoid
+    third-person singular, you may resort to singular "they" to avoid
     "he/she/him/her", e.g.
 
       A contributor asks their upstream to pull from them.
 
     Note that this sounds ungrammatical and unnatural to those who
-    learned that "they" is only used for third-person plural, e.g.
-    those who learn English as a second language in some parts of the
-    world.
+    learned that "they" is only used for third-person plural.
 
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
