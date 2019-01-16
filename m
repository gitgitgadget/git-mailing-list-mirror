Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92F21F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404112AbfAPKcT (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46381 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so2815487ply.13
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flZuTF3Bu1w35FXuUxUj0OIBbxZcWwkYwS1FPBYivUE=;
        b=pPvsKxsCuVLRg/bJgijG0QPLS3hGScBpaLUxo0kdTw9PisF93hMT8g7MwA+zvXcDIy
         +g0zQNFkOYjpesbkYc5yMAYhWg8R9Gw94qybUv18UBhNIqg7c8bMY0a4GJiAYXakkOYl
         W8/a0dyr/93EPKxfBonALbJQi0O0DILPe+fjrtF526F/RoMyxoT1K3/jWgZVu73dmb7N
         Ap1lEg7gLcYW8APX3f3umbxyatGaWJvkhNUAJfvNZn14jCIGu0DYC5mV1vQaNLvwIkct
         yfDbZKgsSNU7FKcQFLF+F3c3r+itmohuY0pZGwoyIeGtJS7v287ON1EDt0SWlVcRfmlE
         rKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flZuTF3Bu1w35FXuUxUj0OIBbxZcWwkYwS1FPBYivUE=;
        b=GkZluFByNmHP5bWJCB+SFVy9zE+UnSeIvh4an2usA/tzJuWf/GlGaBkYrYmrK1ccxD
         1a5jx/bK5HTBwUgnGLof9poa9670DoJBTtbRa8fw9jrOkqScPHGAnzCVbCWsOWb6cvZm
         KJaVrxSqF2A4Rpj2aVLXhuqfzG222e6iGgKRioGdIunozDSap1Ypr6P+mCDLsYZfzMqT
         ZQMOORWe4cr4YcOAkkG9inO+fuCMUQzOL3CjesN61V+FJG5/Xtjh0QgFdERJQiL7xmDK
         7JGLfi7HfO+jpG05I2bipBWvWltrN5ULGM5quCO/nlSUcvFFL1QBp7QOQB7Pwy0jC8h5
         BRRA==
X-Gm-Message-State: AJcUukfpkkEauvQQsfbGjk/mfvNO1y+me+5obLbfVS4+AOnU8MIN+28n
        Snk6UlNPLdvIoryGNg0s8Lr2z12c
X-Google-Smtp-Source: ALg8bN4vjdL8+8aedy03zOpp9QSBn1uN+F9FUkb5z37AddqsfvIZ18iJPML+Zb3LRXi2178q5fB10w==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr9047327pli.64.1547634737734;
        Wed, 16 Jan 2019 02:32:17 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k24sm8422967pfj.13.2019.01.16.02.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/10] submodule--helper: add missing \n
Date:   Wed, 16 Jan 2019 17:31:51 +0700
Message-Id: <20190116103159.9305-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..232bfaac7f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1297,7 +1297,7 @@ static int add_possible_reference_from_superproject(
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_INFO:
-				fprintf(stderr, _("submodule '%s' cannot add alternate: %s"),
+				fprintf(stderr, _("submodule '%s' cannot add alternate: %s\n"),
 					sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_IGNORE:
 				; /* nothing */
-- 
2.20.0.482.g66447595a7

