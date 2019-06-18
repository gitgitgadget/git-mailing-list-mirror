Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797671F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfFRX3J (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33133 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id x2so17711051qtr.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqQHOlwlfENkwc05/cG9Y2S77go+PAKki+Y1xBT2URM=;
        b=DIsFbjIxO1FXBBNKP8jjjxHOPgqiC0qnzqcLbOaD70idRR2Oe7Qytem49li77aAIbq
         7YWNl6b02hTGiNyvHYQQZTGHjlfEqoyNnT7XsAFTJ8PvAcZ9Al44H2z7HVgY5LF1Qx6u
         2QtoQ5CpSnamqCOcEBQPK/lrtCcNzUrN8ptih19H77ODqJYVFw/4stjVuMZ0Jasb6+gV
         CeQUCP9A2vIJlGYJDxphcnbx8hKDeFQ2Nv1LEFo39UZ84jlGNL3UEW5DUb6CwVCgG1us
         GXv3q1rjonPozp7FNePDg2ZgcUzvxcNJhAwnmmA7iqCdAXvvgoL0Osk5isXilcKz05O1
         7+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqQHOlwlfENkwc05/cG9Y2S77go+PAKki+Y1xBT2URM=;
        b=nPI5BV8FoMsdPpRM6OUf43fwUAEXIc21PtcCDo1bOJ4pbomZ7gNyF36axtJqyndAtc
         0kpA7VOJBNL40UhpHFAe/aVPVSjqsd5d32u5/BF2Kxnr/H7V1gVvdsimFWr3ntHaYIUs
         KrrVy/vViK7jSPoS6fLfyzrAbtZm6vHv0uVYS0QGbOnoRLzVy32j9atqTFCXJVNe3+iO
         huaj/FH0UDUlQSV432Z9lKgHp3PLwKLFwVxaPhlAsMK3d3Mm5K7uZSalgDXX23veyH+s
         zGIPJyrBu/lu86bqfy3IdI6+wXOocPbAkQWg9nret/z5720xpYr3kstfVLFpeOAS0jhH
         Agkw==
X-Gm-Message-State: APjAAAXR7DxkTpRe15hM/SICGCf2k7mHgGKo1NWs3NhP6CnFC/2NwHeM
        Q/++n3kgQpT24sb3xHcx3kDYEJMDbWs=
X-Google-Smtp-Source: APXvYqx+YgaIql4y1H152zHK7kdl73puLl/tY1ESYGMHvbwTFu+Atij/fsCPHhuJQuaVvbLaQOt2Wg==
X-Received: by 2002:a05:6214:248:: with SMTP id k8mr30270010qvt.200.1560900548393;
        Tue, 18 Jun 2019 16:29:08 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.29.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:07 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v7 04/10] dir-iterator: use warning_errno when possible
Date:   Tue, 18 Jun 2019 20:27:41 -0300
Message-Id: <8b060b3bf4389d337d84d53cebcc8b02aa1a7a74.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change warning(..., strerror(errno)) by warning_errno(...). This helps
to unify warning display besides simplifying a bit the code. Also,
improve warning messages by surrounding paths with quotation marks and
using more meaningful statements.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir-iterator.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f2dcd82fde..0c8880868a 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -71,8 +71,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 			level->dir = opendir(iter->base.path.buf);
 			if (!level->dir && errno != ENOENT) {
-				warning("error opening directory %s: %s",
-					iter->base.path.buf, strerror(errno));
+				warning_errno("error opening directory '%s'",
+					      iter->base.path.buf);
 				/* Popping the level is handled below */
 			}
 
@@ -122,11 +122,11 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (!de) {
 				/* This level is exhausted; pop up a level. */
 				if (errno) {
-					warning("error reading directory %s: %s",
-						iter->base.path.buf, strerror(errno));
+					warning_errno("error reading directory '%s'",
+						      iter->base.path.buf);
 				} else if (closedir(level->dir))
-					warning("error closing directory %s: %s",
-						iter->base.path.buf, strerror(errno));
+					warning_errno("error closing directory '%s'",
+						      iter->base.path.buf);
 
 				level->dir = NULL;
 				if (--iter->levels_nr == 0)
@@ -140,9 +140,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			strbuf_addstr(&iter->base.path, de->d_name);
 			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
 				if (errno != ENOENT)
-					warning("error reading path '%s': %s",
-						iter->base.path.buf,
-						strerror(errno));
+					warning_errno("failed to stat '%s'",
+						      iter->base.path.buf);
 				continue;
 			}
 
@@ -170,9 +169,11 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 			&iter->levels[iter->levels_nr - 1];
 
 		if (level->dir && closedir(level->dir)) {
+			int saved_errno = errno;
 			strbuf_setlen(&iter->base.path, level->prefix_len);
-			warning("error closing directory %s: %s",
-				iter->base.path.buf, strerror(errno));
+			errno = saved_errno;
+			warning_errno("error closing directory '%s'",
+				      iter->base.path.buf);
 		}
 	}
 
-- 
2.22.0

