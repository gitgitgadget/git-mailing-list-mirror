Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB4A2018E
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755075AbcH0Sqe (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33466 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754887AbcH0SqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:09 -0400
Received: by mail-it0-f68.google.com with SMTP id d65so2941967ith.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7jjmnDjrdSOINZ2nHtTU8TrmbLuSGB2nPgploQs0P4=;
        b=BwbinKYHZx3IMCt0/yKbj+LlC69HVeZRcoHOWMO6XSp4tMovImLDBP6nedM7FgjruJ
         tGOT6L2A6xeMrTU6ei8jpt65p/5sfH0yHd88b0Dpf4v6j0Fv5qaLd5ofci20NPyuzJV3
         PKRrTWcOkRfDq2s76J1ZJrWeqTzsk455Wbs6lJaWL3elf2NuS75cYOaykqysyJi6EVKi
         6Er53imktEbLe62XpxXEt9uJA7fcabhJLgNihnWKJ2jF8Jhm8MCLj6g0blIINqhdHmvp
         /VVXZtrXmaotFObTWxwR75ncbvPMEsg7kwole4wiu7soANJ+N96cWuqdzZWwQSJJgBKK
         EWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7jjmnDjrdSOINZ2nHtTU8TrmbLuSGB2nPgploQs0P4=;
        b=Xye64gbv1wIN+ycD9+Yl/8q8VmBwXhPLEwSdUwR/0LGBTS+Dq5z5ekSpAoCvhO0Acx
         Y6HC66FVxMUVV04lrVj1QtcothZ2Rmf8y/BnA36XNvbwUx5OFkQMW8htL+QVCdgynQgL
         r9ZoeHLEXj5BEl8ydAoMLbdaSvLMoWPW0aqi65luh4IgC/AZ0Gmf+65fQ3RHBqmRip/p
         aoO2pp3DXa7bCeXKeftl12/VRxHZpYYZmqR0WOyBuExjaS/ei4STY0dTSv621o2ZrW8Z
         6u6s83hoLEkEz2B2+iSXAPdlCbgpeifm/5k67Uva1sKlI2oyYn4fbtUuFER2aCxFG48R
         7fNQ==
X-Gm-Message-State: AE9vXwPNbQ5TrQZUpXZrvCInbMQM5QcYQ+0xTBjfRRlITK2ymew1mr50csDO/0J0VpkoQw==
X-Received: by 10.107.6.101 with SMTP id 98mr11701598iog.41.1472323568950;
        Sat, 27 Aug 2016 11:46:08 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 09/14] usage: add get_error_routine() and get_warn_routine()
Date:   Sat, 27 Aug 2016 20:45:42 +0200
Message-Id: <20160827184547.4365-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.9.2.770.g14ff7d2

