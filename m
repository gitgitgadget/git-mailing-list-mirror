Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656DE20284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970176AbdEYTra (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35950 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036739AbdEYTrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so54298653wmh.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcB+b3E4GDg9S8+aTv8iIlxO2bbIkGsrRzWjf4ZOwFQ=;
        b=BMTmnHG5OaXcKlHXjX16ATg0KhusjrnF4XYoOBh20yKcLLQGTAIieUoD43pDz7UK8Y
         GGDOVjNcJxJD7UzML8Zkp6ur9/YSf5W0yz7bCjsDZShg8nXhZ1gfD6esJ2ZzPj5IhQvL
         /SByIy/v/FbGAaIN18KFhAiEeS2KtM+qn5xfpmOab6q1GrFy1Bz7rTtkuPDeDVGY4c/4
         70WS3Dy0TWhJSAhImuYQR8hfJ3pkNrQaM1RRKAAWSTMF5h/Zx1uNnkL67rSSgf8hjSmC
         pOaUQw4KXlWQ0SPGDjPM6fivyFQ+I5CNBL5wNzY3fM9uXvyhSHTvBXCx0SWl8PDB8iiU
         5CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcB+b3E4GDg9S8+aTv8iIlxO2bbIkGsrRzWjf4ZOwFQ=;
        b=av5hDYHyX9gmg65FjM0BZScGZhmeSVvNpDZiE2x1xg/oxwbNIqRCvKXI7FD4iGtP7S
         41IV3SsaS1Fi6ln7loxq4k9RCh7rCqYtmiYDtiLndQHXIGusK16gdECbPOsV+fJ/APMH
         vp7uO8+5i/iE8NHi9A+wl+MJCP4oAXTEOmnj6XI0dvxTqX9QC61wwaC+/o7wotWk9ovE
         2u1aESFK3TabUfA1NYGxbrKK4haJinEOIdJxOrXE69K6ZdJET5nUivIm/afuT6VioXED
         Gjjw6c0AA0kk51fH7/lAltS7LZFAZplHseQimzhOhlzhxML3ki/M3GPtNrGggtL9l8gn
         TkyA==
X-Gm-Message-State: AODbwcDjqcz/8085tcrtAfVTsc2uC0ngL7DGmmObbtY5B9Q6ta9q9Dfj
        X8ysiYzsDApDDF4I2rM=
X-Received: by 10.223.131.34 with SMTP id 31mr29469606wrd.95.1495741634930;
        Thu, 25 May 2017 12:47:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 23/31] grep: factor test for \0 in grep patterns into a function
Date:   Thu, 25 May 2017 19:45:27 +0000
Message-Id: <20170525194535.9324-24-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor the test for \0 in grep patterns into a function. Since commit
9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
\0 is considered fixed as regcomp() can't handle it.

This change makes later changes that make use of either has_null() or
is_fixed() (but not both) smaller.

While I'm at it make the comment conform to the style guide, i.e. add
an opening "/*\n".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index bf6c2494fd..18306bc605 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int has_null(const char *s, size_t len)
+{
+	/*
+	 * regcomp cannot accept patterns with NULs so when using it
+	 * we consider any pattern containing a NUL fixed.
+	 */
+	if (memchr(s, 0, len))
+		return 1;
+
+	return 0;
+}
+
 #ifdef USE_LIBPCRE
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -394,12 +406,6 @@ static int is_fixed(const char *s, size_t len)
 {
 	size_t i;
 
-	/* regcomp cannot accept patterns with NULs so we
-	 * consider any pattern containing a NUL fixed.
-	 */
-	if (memchr(s, 0, len))
-		return 1;
-
 	for (i = 0; i < len; i++) {
 		if (is_regex_special(s[i]))
 			return 0;
@@ -451,7 +457,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	 * simple string match using kws.  p->fixed tells us if we
 	 * want to use kws.
 	 */
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed ||
+	    has_null(p->pattern, p->patternlen) ||
+	    is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
 	else
 		p->fixed = 0;
-- 
2.13.0.303.g4ebf302169

