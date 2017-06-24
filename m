Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AEE2082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdFXLgw (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:36:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32901 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdFXLgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 07:36:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so18775841wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBGcQcNWCueW6kwIRm1Yk2R72U8/kQu4kx1038EqPg8=;
        b=Jh1PNr/vx9+ONnHbY+1tN3oLorUWgduHhWumndFgCU+XhyjW6M4P8WGEebIAYDfs1R
         ys3sWmv7XNs7NUjTiNvt8ZXUtRZNEHLRX+0K5lGIuGk3H2wIgFfn7o6PXO8bPH2pQTsF
         JGUuIAAzvumpbjisr1cLTzeTXD7ng3WA+qSPzp1X9ftIN5TB/2addK5SPKtZ7FSK/A4K
         mvric9GhL8E6xWBQBbHg9avI5SxcjrcNJNEWmcoGuTzPL4LZfsDOfgRjCqRWJxrPidkX
         dMngNPdfevXDznCBXeyilBqjRcwpb3iza6yxG5oDkp6WYk5xOXoWLIlNLuzD9Xxhp++o
         Z/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBGcQcNWCueW6kwIRm1Yk2R72U8/kQu4kx1038EqPg8=;
        b=iiDHxQDy/CAOuP/+Wjgq1M77ZnZrG0Mk203ulUoe3GCRqg/0+WQkGbVEHUtgmL1KSZ
         NqnggOpc7rMLiU2f+c8RudJwBBwQOjHU0O7FYcfucdpFyU+EzEMS8DkoQA9jd06KOw6c
         G8li2nCeKc9nL9Zat5JAQtzBXMcAI4QVpJ9G2OmlfMQNYiGAqxHSZz2btc9UR2L9nvqv
         0LT7Iz7AtebjnXZ3zMW/z/hOYIfBPb4TMvdhFDwyM5TB4By8auqltIwgMegAAhRzSjvR
         29EJ7aZwMlQI16pdbHTfk1x8e5aMSsXc7M+myM+vwiLFBPnLTliJW1LSOrhUyyT837n/
         nnhw==
X-Gm-Message-State: AKS2vOyoNFiuCzihtVRy394vXsmzD7qLDj3WRF3jC8IF/CSW3VHAz+hY
        zDc1gLoCYQrbAzgkZAw=
X-Received: by 10.80.151.219 with SMTP id f27mr6636330edb.126.1498304209864;
        Sat, 24 Jun 2017 04:36:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n26sm1284651edd.51.2017.06.24.04.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 04:36:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] strbuf.h comment: discuss strbuf_addftime() arguments in order
Date:   Sat, 24 Jun 2017 11:36:34 +0000
Message-Id: <20170624113635.16360-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170623164403.bxilz7k5ny7hs466@sigill.intra.peff.net>
References: <20170623164403.bxilz7k5ny7hs466@sigill.intra.peff.net>
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

I though it was more readable to split out this change into its own
patch.

 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 4559035c47..6708cef0f9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -340,10 +340,10 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
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

