Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92EC4332F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D9961101
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhJ3VfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhJ3Veq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BBC06120D;
        Sat, 30 Oct 2021 14:32:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v127so10672255wme.5;
        Sat, 30 Oct 2021 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=382NxPxQ4f0c/RCsxp4514OouxxfYKsL18p/orKtNYY=;
        b=RApcvgBtb528hmH+h3Fno52vIcieLvVJMoIZ/1zqJ+WBOl0tobQVSbBnP1RHAni9q0
         74+I/mrMZgttS6VQ2nUMmtc5Zngyh7Xo8y5k38mPv5AgQubYBPtovU04yhfAr+c/4r2o
         TEqBcpxvs12ZolTb2YNsfnUjo97axdZJWbHJPmas1yASd4BMzltpf6kdyonoWT5HWtdl
         fMljdZ+x7xfYliI4gQH5CNu3Juy4FfvtSk8LLN03LuQb7Nc0tt6iVqsThhw/7OH+GNA/
         LfIIBH1L4peT8k2UrLRg3SADOIHxYTAgyy5b639nT/qtrky48RlIzdtKOpJEvId2muBP
         ekBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=382NxPxQ4f0c/RCsxp4514OouxxfYKsL18p/orKtNYY=;
        b=z0YqRHfsckbdgKPn766R/2ZLFavKZBrAB2+QKPstJHgL0sKIM/JDOauvw0UIkSmVSJ
         37Z77UOYrin91VJnvrr+fwBq7szpcnd4T7qhZE/mkDWKR9ZggYOXj3yd6XrM7qEwfuYH
         aWb5sR7/jm6b93ch+PTlXqwJJPpKkGf5d/dyT2tNwCisKN065NcxWsJwaYigZo//sNZN
         ry1ioP5RBQApxORhScBFvg4kR9IOClzqJLFk8t2NbZw5WSohxFe9XqBl5C5ZAWzLvorr
         Os5aGVIleGRPcdd8ZQzdEOBPUakhFxuNt7j/h9rc13a633TbD0mI4u/rGyJg2O8s2NrI
         WPnw==
X-Gm-Message-State: AOAM533+FzD4vRvqFcD4AEfHawBEjyhN5lnFowWt3nBLRsCEcPcMYFVN
        kp7+g6p93ljjEbKjlizCUjqty8G2qP0=
X-Google-Smtp-Source: ABdhPJwSTN4puVGsWOuBa1aoxcOympFlW391yYdqO+H64YHfzuCLZ/wJq0pgfMWpUY70yNi96xE6gQ==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr29245520wmj.38.1635629533489;
        Sat, 30 Oct 2021 14:32:13 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:13 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 19/22] gettimeofday.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:29 +0200
Message-Id: <20211030213131.140429-20-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use clock_gettime(2) instead.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/gettimeofday.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man2/gettimeofday.2 b/man2/gettimeofday.2
index 8101e311d..f4b7189d7 100644
--- a/man2/gettimeofday.2
+++ b/man2/gettimeofday.2
@@ -44,10 +44,10 @@ gettimeofday, settimeofday \- get / set time
 .nf
 .B #include <sys/time.h>
 .PP
-.BI "int gettimeofday(struct timeval *restrict " tv ,
-.BI "                 struct timezone *restrict " tz );
-.BI "int settimeofday(const struct timeval *" tv ,
-.BI "                 const struct timezone *" tz );
+.BI "[[deprecated]] int gettimeofday(struct timeval *restrict " tv ,
+.BI "                                struct timezone *restrict " tz );
+.BI "[[deprecated]] int settimeofday(const struct timeval *" tv ,
+.BI "                                const struct timezone *" tz );
 .fi
 .PP
 .RS -4
-- 
2.33.1

