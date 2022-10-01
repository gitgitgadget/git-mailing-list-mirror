Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652DC433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 10:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJAKqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJAKqL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 06:46:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841A1543CF
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 03:46:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a26so13704403ejc.4
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=R9KqzXVwkgtPAkqCMZNiBdnOP5o0TVaWcnH30doaIOQ=;
        b=VPtXFJVIv5Gu85zn5Q/Pb1rhOpScsV/e/hv4Ih2TWeCCZbSU0Y4ksHP5qDNlhbORKY
         4E/uo3wSrgnFEtvbPpW9+t0bIJYmOC3sGqqBArScNF2Vu+g/hhs7c1c58EPJmdWzdLph
         lPrfX2b56KENzQD5i2cFxtlMCQgqPtPopBI7M7KK+H33ByCEzKEBpU/xmT4A1+vBjh8G
         FpyC8ct43THZSZOkXAG4BZfZFYiWR57JDo0WWC8MzDSQv1HmDzaREP0pvM3fuYTEGZ1W
         QF+iyzs5QjQsNk5nbOfzao44133OgeTKQxzb/UVJEw2kmqUJ8mYH563WhJMOu1X4xkm0
         vyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=R9KqzXVwkgtPAkqCMZNiBdnOP5o0TVaWcnH30doaIOQ=;
        b=f/g6vc+UQo0tTo5X6wPcLXYeGU8E4q+Hp3K+/6lQi7pP8e96KGCJnDv3nBz54SlEmJ
         5TeuWEyaEjeAEyJKo3+S+qFYQAkz0NNukyfIQdwMmvV6wf58nodaxc7U6Gh7FyesmqzV
         kT6cQaeSLCOabDNZkb8y19p0mNT3pcX9ohEZEaw7T9An8ZamkktJMGubD3wJWBEmdh6M
         SiSK4TwXDXIUOcD6frX+2grTpk10zTWqPCPRjsYiT2ZSmUMprUJBEIrOsVNjnOtJC3MZ
         wzn4i57AI2YQWksdBYGkFTJE0/+QqVC7BfCXcqhbdV0u/7QHncSPNlkjUfrB332MyOpa
         xDyQ==
X-Gm-Message-State: ACrzQf3YknGksoHhRP0PN79Nq7R7lqYAa8ULwBbpuifQDsAdhTZ28YEV
        q9kkhj2AQz9cWR+R63zOrPsELCDpvGy5Tw==
X-Google-Smtp-Source: AMsMyM6iC0D1tHj4ZvsMmDqCpEBwp2KgUPtp8ht4l+yySkzlKnucz28SuyTSQ+ACXEQ6I5+3tDimfw==
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id xf9-20020a17090731c900b00740ef932ffdmr9228854ejb.584.1664621168946;
        Sat, 01 Oct 2022 03:46:08 -0700 (PDT)
Received: from localhost (252-168-166-62.ftth.glasoperator.nl. [62.166.168.252])
        by smtp.gmail.com with UTF8SMTPSA id vw19-20020a170907059300b00782667df018sm2532471ejb.54.2022.10.01.03.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 03:46:08 -0700 (PDT)
From:   Jouke Witteveen <j.witteveen@gmail.com>
To:     git@vger.kernel.org
Cc:     Jouke Witteveen <j.witteveen@gmail.com>
Subject: [PATCH] send-email docs: Remove mention of discontinued gmail feature
Date:   Sat,  1 Oct 2022 12:46:09 +0200
Message-Id: <20221001104609.18453-1-j.witteveen@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for "less secure apps" ended May 30, 2022.

This effectively reverts 155067a (git-send-email.txt: mention less secure
app access with Gmail, 2021-01-08).

Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
---
 Documentation/git-send-email.txt | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 41cd8cb424..0c70ba2647 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -507,14 +507,10 @@ edit ~/.gitconfig to specify your account settings:
 	smtpServerPort = 587
 ----
 
-If you have multi-factor authentication set up on your Gmail account, you will
-need to generate an app-specific password for use with 'git send-email'. Visit
+If you have multi-factor authentication set up on your Gmail account, you can
+generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
-If you do not have multi-factor authentication set up on your Gmail account,
-you will need to allow less secure app access. Visit
-https://myaccount.google.com/lesssecureapps to enable it.
-
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
-- 
2.37.3

