Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742931F453
	for <e@80x24.org>; Thu,  2 May 2019 14:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfEBOs4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:48:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41914 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEBOs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:48:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id c13so2759606qtn.8
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2gW/CcdAiDBBt30D2AqoHyC+lsYwURGdt3xL3StYGU=;
        b=hdr3QiqH2Q5aow6tKa27B4FQ1YPyzKbQHcAEu+53xhnigUJQxYW9HmRI0zXuXgLuJO
         IF3lR4H30TkYQvYep2DHcAg8YTYs/kJgoHd4+xCKAEJFYWm6m5Uo6U++JGuYhkIFHHwF
         bxOh9wQ3qQ/1s59ymaaRFqo7Dqyo5zo+2nZh8BH/6jsM+rEVkiFy8dTZ2peXZ12Ls9u4
         F/wQxn/LAzyzMpk8OHcK5rwfnDkWaqC+r2AahVRfJwJyJO5HUYB32woAl5peUJPpKQ2P
         KlclwxghtcU1gro/oDDS6E8LuHTpZ4rFiXRli+iK78KcG6RpSc8qNrTVzf1jZnWMGhqe
         y2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2gW/CcdAiDBBt30D2AqoHyC+lsYwURGdt3xL3StYGU=;
        b=Zoshvp1II4J+n+OxeCFK7ch87RtAdsn4N6N0MEn12CmR8eTbh6/LyxF7qPTFIJnKXF
         P/H99VhRFDHjLGt++o8QW8C8eTmPVa46CSwAia6D/k4yl9iy+JqknG+HWqCLZ7nbiyS9
         YFML90y+nWFrcEszfjO/JFZf6s1urnzCNB9asjesK8AfSjJkIU4UjIEy8wIaNdB0HGjH
         H/eoLvylI0gJPQQnWPRWHhI8dbvCvMuwnEYX/dKe4qpaWDwetn75y6drobm1lHL6sGsX
         Zz79AGpxqMZTAIZJnizsBy53A6q361fOVkTRoYfLPgRo5bb5qUHfj8YWvmEQe1RdU6zZ
         RtpQ==
X-Gm-Message-State: APjAAAWdGLHyLdvFo8Ao6u86uzpwD/zvDJ36D9B6X2Wc6RbGGDMK74/o
        1HKz9c4/Z1yIe+VIZpxO91qrzt2LGD0=
X-Google-Smtp-Source: APXvYqzW0/8X1g9MoM3gxIDbrGYnEUFcecWwBFRw4xbp1NjyBJMqkJcR0NFRshW2BvZ6Eu5kgAyqag==
X-Received: by 2002:ac8:548:: with SMTP id c8mr3474096qth.54.1556808534683;
        Thu, 02 May 2019 07:48:54 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:48:54 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v6 04/10] dir-iterator: use warning_errno when possible
Date:   Thu,  2 May 2019 11:48:23 -0300
Message-Id: <20190502144829.4394-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
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
2.20.1

