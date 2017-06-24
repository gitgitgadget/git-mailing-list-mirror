Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BD820401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbdFXMPK (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:15:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35273 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdFXMPI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:15:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so19003558wrb.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZb92KcjON1xJpi3WvOXJMC7l53s5fqZWoiC74/1CxY=;
        b=NbAM8RpgR5Xmu0rcM7cpaC3NV75olqcxt+eDvr8oUpZTE8ZpucnIj9DsjzyJBDwx1C
         I6Kvtx7MGWluw18Qqpyv947ACRkkBoBeNS5ge87A/DpyaeVi29H6IaxQiv9ZVlynPElq
         A8q6e/jbdc0Zy7h1ptNJOSJsvdWpJHLM5sHeSA1iut8xEiajtP4oZMtufjt9s4UeXdne
         yoW0Hj9/DG5JmvstZet4f9PIffaZMlOOpj7dqnaqQzNxHcNxlgRG2sjDw0pjBzi0EcR9
         PsNBSeS1r62DaIDDLC/ubCnIKl7pNWVU0hsDvXzSlQ8Dyo8FGLsgyy9x+Wjoc6mAYrHC
         h4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZb92KcjON1xJpi3WvOXJMC7l53s5fqZWoiC74/1CxY=;
        b=dHJLdAwteHOtft/ttZT/eXxL0/CGsm+qh42TXel3gFkPN7rAAGGV85GXHQVPV2auMF
         svz6aRXuAoRbTToGgwJjexAkHEFOA27UL1vdWFoqXC9W0PCcdMbP4Okx4rFweYcnz33U
         FbCZAD9fTIa0EkSFM0WC9xb4v7r1bplmQCqaCK66fBJ77ckK9Cm5FK1XXYOt9rzEhrwm
         qBtplitMB6IZW5LnRmqIl9pBUmJ/pMRE4JcinzXEKlTC6/Ex8+lMt/WsLhstM2mDyFUF
         FKjXd6czVRSLHVZgLzMzr0S+T0gYB2+mijM1eERxeo7kgvlJcTI6QXJYt6ho4X/TIpVf
         cyoQ==
X-Gm-Message-State: AKS2vOzWxM8x68gDPaS9BsZ4CP4swt696cw/c5eVRGOD70dFm/EL/axE
        EjBi6PNy3jgMyrboLfg=
X-Received: by 10.80.149.209 with SMTP id x17mr9180352eda.175.1498306501737;
        Sat, 24 Jun 2017 05:15:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e22sm302062edd.26.2017.06.24.05.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 05:15:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/2] strbuf.h comment: discuss strbuf_addftime() arguments in order
Date:   Sat, 24 Jun 2017 12:14:51 +0000
Message-Id: <20170624121452.7952-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170624121023.2636-2-avarab@gmail.com>
References: <20170624121023.2636-2-avarab@gmail.com>
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

