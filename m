Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214B01F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbdLZJKy (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38862 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdLZJKx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:53 -0500
Received: by mail-pf0-f193.google.com with SMTP id u25so18528982pfg.5
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEsYf3DnHknTR2uI3vqV12YFzki2p3r4/L6F16Mb62s=;
        b=TYtdZf8ZYh2RcxY1SjtvkpcIBiaVGkytAUs4r4uv7LYZYY2o60KTITPc0XF7C8YyIk
         t4yKeiIxHiYYMdfY7a3Syjr39ZIBoeGC3O+kIZMz0S6Bl6+t1/6bfDLC4o+TdFZJ0Ptv
         iy2rH9MMxNGPgUojf//JwT+C3I9+ra69rkFG08tAKdqV9yH51ELaXi5MXgr5Uq28J50L
         /WY+4cvJB+zn9RUYkJWqTkDondxP9aLwHoOFidbaYwt2ubPYpZRa3ac8AGEs+hTDgk3o
         4fEg1foTAEQXXffOd88/ZRNZueK5xBrk9AA1KBUteOpIzoXlMwWKznDgBv4bcE3cLDmE
         bUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEsYf3DnHknTR2uI3vqV12YFzki2p3r4/L6F16Mb62s=;
        b=XX2INvqIt9jSLG2LNkddSRyhaHburxH051vwM/GyJalDY01/+pn31VSwJkeJYx+Z/K
         sf9KOe/sAQ1dkwcG46W6fMIHErkLshxhWKbRUu15Jo1tQtT4dfb6M1biNNCyzx2rO7ZD
         dbk4DepJKH8jQDuUuMF+5lCTEYWiDbZNNzuFzDNaW27l1BiWhCS6FZNdNX96TyqOOvIE
         GDe7Tc29ojIiJKPXonF+/3jmPE+jAe1Z8R2q7WAhllZluSd2fWkEnyMrINAiyY/4yK8k
         3Z7mtJRZ3Xlf8FTiJsjdKKLlPm0q6hcvb4F+x2/hs32ZOczitZpp0F8Gl6QJXh7vKLKN
         /cgg==
X-Gm-Message-State: AKGB3mKU0PDN7s1GYt8xG9FcroW3037yhN/WKqY7lbIbZVbksQ/LdH+g
        7Jl9+deDpXfilDDYTTgIMVfhIw==
X-Google-Smtp-Source: ACJfBosWdsSE7FHSZaZGmW8BbhTrVWTo6ukMo2FNY6ZvWXapGRNJRErTtl9GcO88AWaYJXgszgBEnQ==
X-Received: by 10.99.117.24 with SMTP id q24mr21983903pgc.69.1514279452911;
        Tue, 26 Dec 2017 01:10:52 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id k89sm59086421pfb.104.2017.12.26.01.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 5/7] wt-status.c: catch unhandled diff status codes
Date:   Tue, 26 Dec 2017 16:10:10 +0700
Message-Id: <20171226091012.24315-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
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
index 0f089c5789..c124d7589c 100644
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

