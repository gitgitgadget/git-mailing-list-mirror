Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EBD620209
	for <e@80x24.org>; Sat,  1 Jul 2017 13:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdGANQP (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 09:16:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34789 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdGANQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 09:16:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id p204so12445876wmg.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EwNvAt3cXNeURK1NcJekFCHkDZ6xixIGFT1WWR1fKa8=;
        b=uejlWwhpRu0w4sibHqo8pWMeeZpmkSXwIjKjrGZ5+JXz0gBFMjpm9JFibOLSBBdsng
         dqwXNJ6RwTr5tH1fv6D6hrCn9gAlQ2gl2MR2M58LDQjR+XylGZRYKZ6RsLPfS+5/gXqi
         tXHVhBtkEDHPTc0qXuh+jLMa7q0xZhQZmRcBSI3iFcR/hxyLeQooB3vaIMjP5uGjHU8r
         jVFiKz9S3jZ+UWdYLY+67W3iw7xL1n/T3JOBcVf2SWNEAtxfl02QpWNMgdb7TmOnZyo7
         NQcXmqLKOyID7GJ7LylHywKjwNbOyuDTWFUDMtZVD54Nei1S0eSRh74OvzdNZ0AMY2DE
         sz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwNvAt3cXNeURK1NcJekFCHkDZ6xixIGFT1WWR1fKa8=;
        b=G7WjZy3jnREvasgNuAelKymzL//6jHhQggtPW6pfgvQYnw3c3YMYIeRE9oTWWmmkU/
         W7g9TXDjAQxGybwSf//jnkypWdKwPY2wNCTbO3Swqh8bha9QC4coqJJW4Wy1yTRwZFBi
         ZOyz+afslv5l7fAEGRry2SvROrmSXmO0yxo9aj6n0iTQ5VuK1QDZEmjsqUhdYqyUKXdZ
         1I+ch6vpqYP4uJWCd8Ur1X8yre5dyLUBZMxtLrjpvgZbzQO6PwkJLzXS+ZS4xrWHfQOQ
         JhObnUapVInrjQhycDeoqpqZSPI1+EnodAaffhwUJ/B3/0IM33ufsSXM8ADZnnbunf7J
         Fc0A==
X-Gm-Message-State: AKS2vOzgiWd13E6LqFJJWealaMUolMxPQIj5IlNDwEgV9TlZak0jXBZZ
        X6Mv1gqOq/Hhd7Blrck=
X-Received: by 10.80.222.138 with SMTP id c10mr8025076edl.97.1498914973312;
        Sat, 01 Jul 2017 06:16:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c56sm4537622ede.21.2017.07.01.06.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 06:16:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 1/2] strbuf.h comment: discuss strbuf_addftime() arguments in order
Date:   Sat,  1 Jul 2017 13:15:46 +0000
Message-Id: <20170701131547.973-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <10b2f9ba-89d1-851d-bf3c-bf70abebc8a7@web.de>
References: <10b2f9ba-89d1-851d-bf3c-bf70abebc8a7@web.de>
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

