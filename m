Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5A52082F
	for <e@80x24.org>; Sat, 24 Jun 2017 12:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdFXMKh (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:10:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33632 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFXMKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:10:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so18931027wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZb92KcjON1xJpi3WvOXJMC7l53s5fqZWoiC74/1CxY=;
        b=k9p25XEAmoTDM2p7JgjqihMScKKjr+7RsJf5QkyOp1LUMkKTUW8rWF00A0N/uocS4I
         con8V9sNNfsMezpqBcs44MwbEmY3PYV38WGjPPu2GH5o7yi9hYUmw+GUXmPdw8YDK1FR
         oobVqzVf5glVBryVnHrlyYdkrJWa3S6ngIlU8beDWfT+SHgaZYY7y9+L0PRutHFWFExL
         uEpyAkufeyZ/H7ttlR3W6Ftun/t1IO/vke1UAZ3Vkx19y9UN3nz8nRlBCy0lyS/Jskce
         Ao8jDN5kzKBu1wn/9S4oFkSddCK+cKvyrjtXI6M5liDmyVc8ODcedO9sdQPOoCZxlTG7
         1zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZb92KcjON1xJpi3WvOXJMC7l53s5fqZWoiC74/1CxY=;
        b=lzsRvRsLoEx6XJufxhurVTmM4xPIlNTY62ZvU/cgZqmIRriPf4u141Oq6AixHRkeBy
         z14GT3zWeYTCfW8MeBpo87wy0OBnhz7G7pQddyl3/jVGVcGlaoQZpfHzhdTE4F9RlWvM
         DOV2NU678cDGSUxinscbkQFCkMF+pXJqDEDP4SN14nd63NrIr+HsuhpaqGIDGEvzdoBu
         PyGrkV02DtmKQqCQHRRm7Htg6PA/wfsOcLyhsar6gu2vtn7ScvjWBT4Rkg+x9ii9cAdR
         ueNIQ50a++TuuTYTkBcOWMF/8IFVl3rTnMXkqIenqBH9j8LlN0XOt7DND4ChEfnN2nUZ
         4d5Q==
X-Gm-Message-State: AKS2vOxOXOdleucFpwPLfEE1e660DQ8/lysOisQKjnIZNsXiYAuIHIU+
        /qLunLzhl0BuWXMeQDA=
X-Received: by 10.80.154.98 with SMTP id o89mr9885828edb.137.1498306234884;
        Sat, 24 Jun 2017 05:10:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b30sm4324043edd.6.2017.06.24.05.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 05:10:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/2] strbuf.h comment: discuss strbuf_addftime() arguments in order
Date:   Sat, 24 Jun 2017 12:10:22 +0000
Message-Id: <20170624121023.2636-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170624120259.5kbmkww66tymxb5i@sigill.intra.peff.net>
References: <20170624120259.5kbmkww66tymxb5i@sigill.intra.peff.net>
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

