Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261581F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbdL0KUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:20:15 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37731 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdL0KUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:20:14 -0500
Received: by mail-pl0-f67.google.com with SMTP id s3so19221800plp.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xS67OrXnP9XykoZid8DrcjhEymkTlPym2v60qm8FHas=;
        b=sPKpVkM7RShOIr2CJC7rxtolZQwtf+6Lz0YCeq3ZWbQOEl9w9GKSwYho8bohxhY4jT
         /lUXdJuFcrQ2mP8BJzj83XlTqFofNJKA1mlal2xkBMDLOjLKpGFYxc7oy4mDJY1PhAhU
         cG+dC594VHp9PjLAErdF4CccXrx+Mdr8/9u/djAOpGFn62EY2Slvo50cUKl/lAeHejp6
         mYjUjKKoLMXg6oOHbXiiB9G7sRJNQ+HJ6T4bp8gY2PXijgU/0py8ZVqvCYGmDE1Gr6SG
         OEEDCbXiUE6e7lO3VnJvYvqQPrTHwMtXXUbqHNBHcXLr/RmMU/p0NNskapxn0PtghO2n
         OzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xS67OrXnP9XykoZid8DrcjhEymkTlPym2v60qm8FHas=;
        b=Bh0OGRPPizynrcHHgKc8MzugBhg3/Fh8SCnZjPBvqVPT4PL3/gf+jlWfjeMB+XC+ze
         56T/JYe9p8ptj/Kr4eS+eJLX/SWjKoe2hXb4FxJezCz0UlEEsT6KWV6s42r4FmzaDnd9
         iLdstl6rUourNdmmssyU60d9vx0wiO8Mn67aRET3rnc1LyOq8BjOsR9F1EC2DTrcBUCK
         lH+stY031hqMzCz2KRz2o79hby2PptnhmKCKqnZ/JcZoCQwk3TbJd5Gw3PjDJiuU5ZIF
         8p9CZ5KsIVvK3DvSdMdnITPFQkwTHqEw0ReUdlkYuv0XfmP5p/NUKQEgzMAJvowbzm0d
         ImoA==
X-Gm-Message-State: AKGB3mIIB57afCgTNP2QG8eq0oLzkVNeUaNEXcf9Xl4h/Sq86lVetALt
        srcuv3X/I8NzTcvkvTlKgq2KDg==
X-Google-Smtp-Source: ACJfBoton4wUM8wm77CUN1D42X+j30gp5wuqlOkUiykPhSteLgJS4oHa4OhU4iv0gJ+IwVCDTJIBAg==
X-Received: by 10.84.213.9 with SMTP id f9mr27905394pli.26.1514370013914;
        Wed, 27 Dec 2017 02:20:13 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id s65sm66295677pfk.7.2017.12.27.02.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:20:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:20:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 4/6] wt-status.c: catch unhandled diff status codes
Date:   Wed, 27 Dec 2017 17:18:37 +0700
Message-Id: <20171227101839.26427-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 wt-status.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index db06fc7c85..05af895fe2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -468,8 +468,8 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			oidcpy(&d->oid_index, &p->one->oid);
 			break;
 
-		case DIFF_STATUS_UNKNOWN:
-			die("BUG: worktree status unknown???");
+		default:
+			die("BUG: unhandled diff-files status '%c'", p->status);
 			break;
 		}
 
@@ -549,6 +549,10 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			 * values in these fields.
 			 */
 			break;
+
+		default:
+			die("BUG: unhandled diff-index status '%c'", p->status);
+			break;
 		}
 	}
 }
-- 
2.15.0.320.g0453912d77

