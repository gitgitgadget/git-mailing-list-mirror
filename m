Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C5C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B28D60F4B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhJ3VfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhJ3Ven (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E9C061570;
        Sat, 30 Oct 2021 14:32:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso14416676wmd.3;
        Sat, 30 Oct 2021 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2wbJ4JsbocNf7EAP8YCLkgi2hnmkqHXAS8BnCkOlT8=;
        b=Ak5cH++M2lAqc0kT2xKu8H6JG/QkXFLtL4FTucwVJI2y+5drUiBR1Ma3pZe6kk2bHM
         Zf030DdfsSZVFoKJRrnzn1CJPlrmVY+BIDw5jYMop3UtdGzwZX2LJKd53RgnikHBzndU
         ZFZmxYuS5koNF7zRX0w7p2LL8fMsrQsiNQC7NGTO3UBLTZEVlpfIUppeVqJz5jXxzlQ2
         944oTu96egIjgmSIQdylGjGq00gZl+SUZGoaHMnZxsUMlzs63xCCqy1P7FvmhHtdyrdB
         snwWQr03PfMBjOtcv7W3rzwTy1ljXA0kuzuFDXyeeZZ+e8G555FsgVtzJ3i5bJdxaL71
         D8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2wbJ4JsbocNf7EAP8YCLkgi2hnmkqHXAS8BnCkOlT8=;
        b=Caez9mT33mgNI9U6EdFs5vOBzpqVeKgyk+hrHF9erxqzuWl63MqFgT+oOUd+O17Jwx
         jX4eUq510Tet1lpO7ativT/4CGfvsy2TPjl9S1vz1eyok0VRy30BydzbKaU3BOm9NikT
         9mVHHOejVKo7ald8OJ/yICsJFsPltxOqiHdCloyeGsgulWHe5Zj4iqeW21mYmMXoRx2I
         4cJ3b9lmmu/zTkxWmvhSPwY69kcdUVtjNxW8mzaTyrGcgVDNYb2QPo9gYmqyTR9xnVxe
         gCELJX1OhUZ5B5NS2nPf+iNjoPneVRquBc/DoxAuzu19JNHmn+YwFeBNnW8VEKZpUFTg
         6jGg==
X-Gm-Message-State: AOAM531M/8xswwp2lnebD6qMEc3UrpGk5L5qMw5zNENi4vODIpJVmwd8
        RYrJrquL+ywzVgUWXKFZkeg=
X-Google-Smtp-Source: ABdhPJwxxYco9fP/s0N10kJCvm2DWTJczIhG30x/xDZOjvyMF7rJmePJ4CNpHE/OGsFrLTaLIrtiBA==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr29347084wmi.145.1635629531430;
        Sat, 30 Oct 2021 14:32:11 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:11 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 17/22] getitimer.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:27 +0200
Message-Id: <20211030213131.140429-18-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX deprecates them and recommends the almost identical
timer_[gs]ettime(2).  Those use 'struct timespec' instead of
'struct timeval'.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/getitimer.2 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man2/getitimer.2 b/man2/getitimer.2
index 7d74df174..9c9ad1978 100644
--- a/man2/getitimer.2
+++ b/man2/getitimer.2
@@ -17,9 +17,10 @@ getitimer, setitimer \- get or set value of an interval timer
 .nf
 .B #include <sys/time.h>
 .PP
-.BI "int getitimer(int " which ", struct itimerval *" curr_value );
-.BI "int setitimer(int " which ", const struct itimerval *restrict " new_value ,
-.BI "              struct itimerval *restrict " old_value );
+.BI "[[deprecated]] int getitimer(int " which ", struct itimerval *" curr_value );
+.BI "[[deprecated]] int setitimer(int " which ,
+.BI "                            const struct itimerval *restrict " new_value ,
+.BI "                            struct itimerval *restrict " old_value );
 .fi
 .SH DESCRIPTION
 These system calls provide access to interval timers, that is,
-- 
2.33.1

