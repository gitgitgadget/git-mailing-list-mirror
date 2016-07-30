Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63D81F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbcG3R14 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35922 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so20019817wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gTSaivXg4Lw1nGcaUJJoGxEezXgxSix41pei+NGenGc=;
        b=xDw4f3omKyuPhapxYyQrSXheqtzyKHoRYI6g4CnWXAGJTZgIkM9K7Z4XnMelpbX1nG
         NZFWmwy4vpRpa2/SHGIpV1NPjStEYHwOvC1Yt6FlFGWCCCV+86e4RQHAV0o3wpukO2Ov
         IBhc5wYKtJKSpUTM4YbC9c8fya8E08vWcNq4DnL8npzrVCceVZ4gTYRsusZ5y9ktyinR
         mBytpMmYrzg6wTgpGQz5ZXDVDKaEtq+zf/Vv1fIgQnjzrKjFBRjmYghY8pv0R6KDj1hz
         H164NMLYMj3r8Ss8zf4Tc0Owxiw/qf3HyK+ReN6aI47DfWnFjABT3Ub/ByJ3Lb8DDKJ4
         Tj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gTSaivXg4Lw1nGcaUJJoGxEezXgxSix41pei+NGenGc=;
        b=k6VBzT6S1mPtjLuNV6WfJbN+ZKsUGThNvzinB8H43QO5E9Uf/SULWsmsLFR+fFJBY4
         WyHHnMRXLgAkHM17anBLBWhOsXJNxDOW6JxcShyqLizM3FD25E/1xmRiyxKyI5u8yxsX
         ZFgQUr/Xcnu3mp2eZt8UENtTMNQ3XqAY+fMwNhUd74btyVNqjwhQiUULyMSuH83H7rTV
         fAos6cY5F4I0sAaoCDMBm6K6Q+8DvNz8CKHg2o5a0k7rClPBhV3HpVb80eK3JChnR7Tn
         udy0xj1hrsp2bmHEcs1Wg8e/x0IPEB+QsVoZMlht2l9Efdp3V9Zl7Ui64qVF+/+3ysGu
         NADA==
X-Gm-Message-State: AEkoouuH2lF4QvPI0TQFpPa/8TOMKg19/K6bmzCa3FZw7W6xUQCIN3nng2WdmfwZWU02mQ==
X-Received: by 10.28.128.15 with SMTP id b15mr50866161wmd.100.1469899595868;
        Sat, 30 Jul 2016 10:26:35 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:34 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 38/41] usage: add get_error_routine() and get_warn_routine()
Date:	Sat, 30 Jul 2016 19:25:06 +0200
Message-Id: <20160730172509.22939-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Let's make it possible to get the current error_routine and warn_routine,
so that we can store them before using set_error_routine() or
set_warn_routine() to use new ones.

This way we will be able put back the original routines, when we are done
with using new ones.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h |  2 ++
 usage.c           | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c7a51f8..de04df1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,7 +440,9 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void (*get_error_routine(void))(const char *err, va_list params);
 extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
+extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 67e5526..2fd3045 100644
--- a/usage.c
+++ b/usage.c
@@ -70,11 +70,21 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void (*get_error_routine(void))(const char *err, va_list params)
+{
+	return error_routine;
+}
+
 void set_warn_routine(void (*routine)(const char *warn, va_list params))
 {
 	warn_routine = routine;
 }
 
+void (*get_warn_routine(void))(const char *warn, va_list params)
+{
+	return warn_routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.9.2.558.gf53e569

