Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675A81F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbcIDUUD (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32998 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbcIDUTt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so10457403wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JevmNPdZHynDFP8A8IapMXlZzXq+W8a5BuEe+waKAbU=;
        b=q5elczbetBuXJsXoeZSkRu5J76l5eUm1Sze23+CBydo2zLouKgohIA1EHpK2v1GZuz
         yTdHg4gmDyQRWgYWe668J+EiBvzTHMQR1VuktNgKvuOQGCbN9EvG55mCLJolzNFKr3g6
         eM3rpnUN9yBqj9LxtDgmCq6wWTdh15JimhjGrpM+B72u4VSSIsfuE84bGCtHgsUKndw8
         Jemx6mP4GNC1wyuqXuM35zvBJgvE1U3PMdAHssi/AIcwKCp69Wahh4QU9cNg7cJTsbTA
         c7L3xX4vzpYRN4MPyg8eBq5OJMku6o/dgC/h2viKeUPTDpHa9VGkh3WQc/JENWxZK4qr
         csKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JevmNPdZHynDFP8A8IapMXlZzXq+W8a5BuEe+waKAbU=;
        b=Cpk0THJi0f+DRvfKz8C3j7AY3JF+l48mAIs2m1m67GAscLmBMbyQph4MxdaXWcd4VT
         wgNvW75/SeEocoThRdCiTb7RkLbOKjXIltIHWToIlYxyVeHPEohCwnFk4m16gE18QUl8
         HEN635gAtSMU0AkbV2QJ3q5kbFp2IxYB8rOCuHhJUUgmooCG3wMZKiG04GmVz9hn0FM0
         l7XXNn6w5I9E5NtDtf9YF6W3cLurEC1u3VK4FSsJeKif68Iej8bkmMVAwK/xtiBE8TIS
         x7Q7b3k0FpsNQWu1j20h2rqHgsmwpdhYJ0MnqsGFW62+he7xL62lzaL08vMCF7NiDcbi
         pMow==
X-Gm-Message-State: AE9vXwMlGbc2XBJJiZc1QD/L5cRHf5a+eVIhJATbNRUo0MMVmiH4sRGvJ6szVRQbmYLj4g==
X-Received: by 10.194.222.194 with SMTP id qo2mr27217425wjc.109.1473020387664;
        Sun, 04 Sep 2016 13:19:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:46 -0700 (PDT)
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
Subject: [PATCH v14 35/41] usage: add set_warn_routine()
Date:   Sun,  4 Sep 2016 22:18:27 +0200
Message-Id: <20160904201833.21676-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are already set_die_routine() and set_error_routine(),
so let's add set_warn_routine() as this will be needed in a
following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 usage.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index db89ba7..d189b4f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,6 +440,7 @@ static inline int const_error(void)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
+extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/usage.c b/usage.c
index 1dad03f..67e5526 100644
--- a/usage.c
+++ b/usage.c
@@ -70,6 +70,11 @@ void set_error_routine(void (*routine)(const char *err, va_list params))
 	error_routine = routine;
 }
 
+void set_warn_routine(void (*routine)(const char *warn, va_list params))
+{
+	warn_routine = routine;
+}
+
 void set_die_is_recursing_routine(int (*routine)(void))
 {
 	die_is_recursing = routine;
-- 
2.10.0.41.g9df52c3

