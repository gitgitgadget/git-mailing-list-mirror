Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321A32018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbcHHVFC (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34112 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbcHHVEw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so17868811wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ptPYPFAToXei2SNkNA9s6qV1wjo5Ssh6vEjHk/vPVP8=;
        b=S9IJN2xZd9XxeGUuech2BtDoDI/mqRqt7pRRuhUH06P62LT05PodRKbj2Xh5n1cBn6
         KMj6tBRZLMSvKmzWIuLK0GzsGbAKlwu2Awnrfnc1xeJMGrgvAaGssi8YjoT7D8730g0c
         q9MvXulRh6X4S1FJ6zlFScgVM2+8MM49W1W2aFAWHwYkCPkf+8Yyx5YIyQ22KfKIZLv6
         +PTITp0rRMmAwDik9HVmpQGVAQaNkzqO8G7RkuNkuJmB6gAVB40BS46f/O2rYjufxDIj
         92MzOnLhglHs8kA6yfVW1tvwcxSi4Ha1pa65wswvDlxVN2L703p5acSciJTCogI8lmkH
         ZcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ptPYPFAToXei2SNkNA9s6qV1wjo5Ssh6vEjHk/vPVP8=;
        b=hAfycR1HHMfMy7FkmomeGMBxxwlt312ZtZDCl/O0wyLYNSYa6/S/xzSK7rAsdGCZEM
         /YcgTt/UcEefjE00To0g2GDW79fNGjACraHlm2iQnU/YFaW2K0YHVcuTMuZVkvV3nl5p
         xpc2iKzBEtCXh+j0lW8Ph8/y0fqP1fguhMEvXOL+o67uQxUzYb88F/0ZDuuFXVP2+a2V
         p8aNJvhS1KyCbNPZMSgjLeZ/zHM/u3/7zcfR1gcRpc0JY2oALGhBsjPG4cVO4slm3b5Y
         gwWl/Xq6WotLcQLBmxNMOLY1xWt7mgXeqHmLGuau9zJsLsts52Mtl4qQC9DUwBRiSlou
         rwWA==
X-Gm-Message-State: AEkoouuKn8P7MjLl/SXk98uP1WWu4Jv38NqSC0Rzc0RNHouOi6tP+QJzxV0/tijb4Q7EIg==
X-Received: by 10.194.118.132 with SMTP id km4mr9083975wjb.158.1470690290855;
        Mon, 08 Aug 2016 14:04:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:50 -0700 (PDT)
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
Subject: [PATCH v10 36/40] usage: add set_warn_routine()
Date:	Mon,  8 Aug 2016 23:03:33 +0200
Message-Id: <20160808210337.5038-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

