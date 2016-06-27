Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EEE2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbcF0S0A (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33763 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcF0SZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so26998765wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BIsuYFvuxERMIHz5hUO0dSx9elDlklvRhZgfDDqGtw8=;
        b=0EPaKTy4Bxy0cQTNk6IgtB6vs+B8faKzw3eZKX1uADRXsvB0b5uMvRyHVz7Xu6pBqT
         ONM3LqvOCmSW4cXO8DyZ3vxg4dyGeOloMNcKCWuh6rYO1m4hjOkXXxJfWkvvgKNVpDvM
         dsxgNRqzy8BC3Mmgbg0ArPRuMWrqUrYUARqUg+FW8KLkDHoRdDehhgrnFg2Av93KkrMu
         WpQUFqwMtbPTGz7C60sxwm6Yw+zxYkFCqsnzq+Iwf7W7zFQGNfRxdRUktHOJVyAZ70Wb
         +qL2mJhBY7C3pBgFhiKdxaBIjCj50zXwr3C/Ehq+5fFXCI5rSgpT+Uo4t8J+WzaJXHQd
         LigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BIsuYFvuxERMIHz5hUO0dSx9elDlklvRhZgfDDqGtw8=;
        b=iLF12iQEV+dHNXbZ2oVUYuHbBBxbfNRHbYyCAooqSNq0Y60+a4gmEf8qjHOCKKeDVQ
         ZXajXD2KLSj5x8xZKnWatQEQ7a5x+G7X3YGyreNle6HCbYqEb1U2oH5t4JIMzQMGsNws
         c16fJXwEZAL0My8aVT541jX+Cs9nufQ4HMoMlAPuzljFe9zIwA93aqW2tikhxKWan+UO
         4o8Bu5MmKObilD0dxTJ8TEV5Fal3FY7SHF7Htasa2yNoRmnWJkMIEqNcuepAA8kVOiL8
         PLlkCGCtfwuyfuq/xzWbR09cV5e6EHbkIubDGX7zj0SBEC6HeUkF5hITd5rGslLu7g2o
         cd2Q==
X-Gm-Message-State: ALyK8tLBuzstZLtaM/NRfNxTy9CorLGUnPBjR6Ec9sQEqCkpud8t/VgaH6BDfQ71Tp/qYg==
X-Received: by 10.28.37.2 with SMTP id l2mr12352574wml.23.1467051944323;
        Mon, 27 Jun 2016 11:25:44 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:43 -0700 (PDT)
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
Subject: [PATCH v8 33/41] write_or_die: use warning() instead of fprintf(stderr, ...)
Date:	Mon, 27 Jun 2016 20:24:21 +0200
Message-Id: <20160627182429.31550-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In write_or_whine_pipe() and write_or_whine() when write_in_full()
returns an error, let's print the errno related error message using
warning() instead of fprintf(stderr, ...).

This makes it possible to change the way it is handled by changing
the current warn routine in usage.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 write_or_die.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 49e80aa..c29f677 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -87,8 +87,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
 		check_pipe(errno);
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
@@ -98,8 +97,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
-- 
2.9.0.172.gfb57a78

