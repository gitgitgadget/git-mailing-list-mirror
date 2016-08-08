Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219EC2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcHHVFA (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33305 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbcHHVEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so17874148wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sda+IDxqMdK6WIiMpKq0Fjo6r1+RzlyDwW4hnQt8exE=;
        b=o+toF5rbEQ3fIBlaWIwlcmc0BKV31wZk4wBRmkhdQW3praZ1wpO2sragCJoyj6sFCW
         yrCGWLAe3UfyZF+PtY25VjAN2coPIJEbt1feC6TMu3JNgd1//iLPMh3pN2LKVev0a8Gk
         RWcvPdNlqX/InCDk6AGpSqDGeSNgRkYxM5gx5tk/4wuK2Bneyt+BVgwclc3yOP915Du/
         SMdV8zYR9p8TpnKfkEoiy4CbqsOsqw5MdWMriK4mPqHulb02G9S3Eqo679X1KrDHMd25
         lMTxzJREtpdPJ1eoWN/VrF5Uh5PfBGjOyZdr6iYidcL/ECn9zT/u1CFfIb02O5E8c32A
         iZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sda+IDxqMdK6WIiMpKq0Fjo6r1+RzlyDwW4hnQt8exE=;
        b=FqlQiWrC36iEKFnGHLqiTPCnwa8sdWcSaz00gUERtopsfoPAXUPVEwc4MJlrXI12eS
         NI4ZUyurjW8tzkBSSaPqHV3ElB9ZnfqVNDVwMNfycJY8sGCCy9fbzbUx9pfdEMTiE0FM
         4q52Ax54qMzFjJe6Wq1Tt8OEn1J3KtU3YZf1cl4lUifkvh9DpnM4u6Lj7oC6eXcHCS3l
         Jvw+Ka2evdrA3/MJ1WqNOm/4E/Nacu3SHppOywStvu54HbNB+027pLVQaTJxzdauinZJ
         M0RVHw/0bhZEHn7eSx5fRo+JOnTmruMuZTBwOtRjWdNUSe/VLgbFQA8HBw7T3/rLloma
         X/eQ==
X-Gm-Message-State: AEkoousKpbVLmQzHsV+tVc5/K2uMUdZr4Yopi4t7Xz6oTKilfvmSNZAm74DhbDTJepPROQ==
X-Received: by 10.28.196.136 with SMTP id u130mr17260809wmf.83.1470690292040;
        Mon, 08 Aug 2016 14:04:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:51 -0700 (PDT)
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
Subject: [PATCH v10 37/40] usage: add get_error_routine() and get_warn_routine()
Date:	Mon,  8 Aug 2016 23:03:34 +0200
Message-Id: <20160808210337.5038-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

