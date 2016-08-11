Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DC7203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbcHKSrP (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34864 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbcHKSrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:47:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so848304wmg.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:47:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XbqIj4UuLWFaPrzVAsnyXU6yfraWzdcn7Tos+CnNNmU=;
        b=DcbzWVk5h8QMlh+IHPzln21ITSMS5DjE3Xbx/J54rINOjA8UKEoiK/QBqtQRG4WzQq
         ExSO/EYs/LKlitKF+OKHAtsU/zAfPK8/uP1S8PXmwe3E9GwO/jDPU9rWPVSEss+9jty0
         vzXNVEjhhchu81fRBqyYVGc/rvLj7F3gjjNmnOyzomoiRQRQqGDgmY3i/ZPgVS5DrGUc
         5nG0Applaxvy0kj34QkO34wsZY2v3mpV9kDqxBRE6LNOshSJMzVRfw5bnzBEzftQ4n2G
         lN+lkSyGsFI7fb6vD89QJSHV1YMp6zvJwIozZohNVJxNrJS1ADDimCxrZsdOLlGsK5fK
         jhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XbqIj4UuLWFaPrzVAsnyXU6yfraWzdcn7Tos+CnNNmU=;
        b=dU6RVn+p9j1jtaU7g1a04NKqhSRJiO52WImTK5OzIj3eYv6DUnijEiqlDUIpCynt9s
         NGXjn7ozo3zG+ReU+9SZtSmJrOrZBH+nVskrMVBRxInkB0JuTlKEsUcNh2F4mUmQY+mW
         hkEtgR3Nz/nsKwqlNkuKtvAvzTzZ4M6118axbX8n6ZURAG+hiNidPt7dLWPUz6fVLNF5
         aAJyEMMsU6yy/i24cYnb2qcDkSki3ei8Az6yNBJ37cN1LW2l66zFDb+667yN41zypMVX
         R4ZALFNV/1f3Qy/FaB+r5ceEdBXgURlJIRluYXedbthokEAJCSgtgq6aBqz3JHsha7kf
         w+WQ==
X-Gm-Message-State: AEkoouvXaNc6WV7PO6y1+AnuQPmMliuzST+/1l5RzCcQX/0ZdXaHj/IBcYWaX70ut03Emw==
X-Received: by 10.28.27.211 with SMTP id b202mr11817413wmb.12.1470941220821;
        Thu, 11 Aug 2016 11:47:00 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:47:00 -0700 (PDT)
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
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 08/13] usage: add set_warn_routine()
Date:	Thu, 11 Aug 2016 20:44:56 +0200
Message-Id: <20160811184501.384-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are already set_die_routine() and set_error_routine(),
so let's add set_warn_routine() as this will be needed in a
following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 1 +
 usage.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 590bfdd..c7a51f8 100644
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
2.9.2.769.gc0f0333

