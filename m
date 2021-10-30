Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00CEC43219
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA49661100
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhJ3Veo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhJ3Ved (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01DC061570;
        Sat, 30 Oct 2021 14:32:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so22132706wrd.13;
        Sat, 30 Oct 2021 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBMSulGK3Nqsb7tFc593UmMoQTQ7x/Z93s+cV07aIyY=;
        b=WUM7L7sORs6JlBEp3tN1exTdzJqkohbQS2jAPWbtazUBeNjhoCC247mOb1si/npxJo
         MdS+epXUwWPnpPEIHrE8pi3VBPgmK+WQl/pnIOqBN659/TOnfVVpzk2mnjEQxy+wAd9Y
         bweuP4l31xM6bhMbs7Qr70iayxzYLaRRXyoMR6o3phScHHXYfnAzWLh40Lw5hOaUJD+p
         EHu8I4pbVak4611MwIAp69LPrvWmuTp8o2xg7XYi0Zyt/hETN0TwBF79Bo6tkSF7ZWQq
         bqv9sbD9xFlSCZcMYHZzth/75K2BARkp7aTybPsiVJTl2TN0Q6pzWPmUnmigtH19drOF
         0I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBMSulGK3Nqsb7tFc593UmMoQTQ7x/Z93s+cV07aIyY=;
        b=ny8TWiBA0PPtOhigC498rguYBC0ZZ2+oRggpTb/t3Fb+rkVmXmypRW753GWvDzz0VA
         rziNlxKB7KtY/XOe4/EF2BgWulNL6d8hJ7tKMc4HkQtzzi9f2t+KjtbMYpxJ96j8uuw/
         gerg/WJImQeGXfipTtF6DGtFTveICOJbrOuXJCj+2NA8KUdu7d2IvcmmesAXJfXpOBH/
         kiQnfHywb7oEC4RxHZ8LIuJ8uM9Xdm4cWVP8fyWUoYnfha/2xzbjOapNpg3HWoLetFMv
         WARUXIYiK+uAJMSQTUdApk1rJt62+g+jrguVdC9I7H70dBIWO0sn34aNc40x+Bhv/XfP
         Pgcw==
X-Gm-Message-State: AOAM533IujM9dlooO+Qgv3EUiMuycxKbxqMSUbocRg7c/x3zWEskerNd
        n5vCwNyrKoPbzMPig0zUgLo=
X-Google-Smtp-Source: ABdhPJygtra77BfJvUh9R5A0GEAfwc4dRto1OjD+5dwgCh0kTYUPCe0w8DwiUZd7gwG5K5LrROlPJA==
X-Received: by 2002:a5d:42cc:: with SMTP id t12mr23346245wrr.129.1635629521380;
        Sat, 30 Oct 2021 14:32:01 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:01 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 08/22] sigprocmask.2: SYNOPSIS: Mark the legacy system call as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:18 +0200
Message-Id: <20211030213131.140429-9-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/sigprocmask.2 | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/man2/sigprocmask.2 b/man2/sigprocmask.2
index b82386f14..6d961f84f 100644
--- a/man2/sigprocmask.2
+++ b/man2/sigprocmask.2
@@ -35,7 +35,7 @@ sigprocmask, rt_sigprocmask \- examine and change blocked signals
 .nf
 /* Prototype for the glibc wrapper function */
 .BI "int sigprocmask(int " how ", const sigset_t *restrict " set ,
-.BI "                sigset_t *restrict " oldset );
+.BI "                           sigset_t *restrict " oldset );
 .PP
 .BR "#include <signal.h>" "           /* Definition of " SIG_* " constants */"
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
@@ -43,11 +43,13 @@ sigprocmask, rt_sigprocmask \- examine and change blocked signals
 .PP
 /* Prototype for the underlying system call */
 .BI "int syscall(SYS_rt_sigprocmask, int " how ", const kernel_sigset_t *" set ,
-.BI "                kernel_sigset_t *" oldset ", size_t " sigsetsize );
+.BI "                           kernel_sigset_t *" oldset \
+", size_t " sigsetsize );
 .PP
-/* Prototype for the legacy system call (deprecated) */
-.BI "int syscall(SYS_sigprocmask, int " how ", const old_kernel_sigset_t *" set ,
-.BI "                old_kernel_sigset_t *" oldset );
+/* Prototype for the legacy system call */
+.BI "[[deprecated]] int syscall(SYS_sigprocmask, int " how ,
+.BI "                           const old_kernel_sigset_t *" set ,
+.BI "                           old_kernel_sigset_t *" oldset );
 .fi
 .PP
 .RS -4
-- 
2.33.1

