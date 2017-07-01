Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC32520209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbdGAMzS (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:55:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34270 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdGAMzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:55:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so12381881wmg.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EwNvAt3cXNeURK1NcJekFCHkDZ6xixIGFT1WWR1fKa8=;
        b=stP3m0KBGiF6A33YjNr4MnEjl6+zO+5eWpu3MvRWZ73dl+S8vWl1rC2GHAUvdH3KqV
         iIA5xqc0gtuw6xGdJ098U+jO6kA32riuS+H5qQ2l+VQizPFgbvdYaTZLeig8lQi0b7xY
         cBhbbDOai6v4P2Q7wGT/+38sBifng23mjr+08yxkPOZv6DPQMHwty4ETzYoHJtPLFcBR
         MIAWQCHLl08ZZbevcmh2WLa3QTG+CZr2xnWyd6ylJV5upXZElC/mh8iOLPLbZSFl7i7k
         N6UTT2qRIy5Tn0UomYiAPdUqQ0nRl0vSV4egKGAT7q45SrF51j+drQ9I1FaDRvXC3dHi
         k00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwNvAt3cXNeURK1NcJekFCHkDZ6xixIGFT1WWR1fKa8=;
        b=G3AhL7dWPrQMYeud04HhIaQ82eN5q2ABbK8xeCafZxGWZFXhQhphny5p7ly0luHjOO
         Ar5T2NyIrdMv/5bIOXF7GKp8UKN3eqvBaVtBh6RBKHJpb5buCLBkyDgaPxa6y3JAn0XP
         0mEpSIR7BpzAaWHTNBVFzanZVClw3ZWkPcRG1VO7mNyKEGj9+bSYW3FSAl1LPrxSmgr6
         BO6M8G2NBipbu6rGjRrMLljCbSaq/XPeP833+Kv0q4mv0V8K2z9Pk4ui3WHZGOLirBob
         eVJq+7jXh8/6uYsyhQMq+sJ1QfrahqZKc67f3ydqDGQ2TQ2BgeuagPVikT8Egvo4JUo5
         +Xbg==
X-Gm-Message-State: AKS2vOz3P8oW2Rc1mQjRQSLI0uGF6d8/A5sv1E+swDeUZQzLGJdky9ZV
        RkLo2T6lbUGVwgHNC+o=
X-Received: by 10.80.211.21 with SMTP id g21mr8622835edh.94.1498913715599;
        Sat, 01 Jul 2017 05:55:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b22sm3964355edb.9.2017.07.01.05.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 05:55:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/2] strbuf.h comment: discuss strbuf_addftime() arguments in order
Date:   Sat,  1 Jul 2017 12:55:06 +0000
Message-Id: <20170701125507.27214-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the comment documenting the strbuf_addftime() function to
discuss the parameters in the order in which they appear, which makes
this easier to read than discussing them out of order.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 3646a6291b..6809d7daa8 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -334,10 +334,10 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
  * Add the time specified by `tm`, as formatted by `strftime`.
- * `tz_name` is used to expand %Z internally unless it's NULL.
  * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
  * of Greenwich, and it's used to expand %z internally.  However, tokens
  * with modifiers (e.g. %Ez) are passed to `strftime`.
+ * `tz_name` is used to expand %Z internally unless it's NULL.
  */
 extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
 			    const struct tm *tm, int tz_offset,
-- 
2.13.1.611.g7e3b11ae1

