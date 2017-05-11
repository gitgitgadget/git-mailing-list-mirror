Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B5F1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbdEKJT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35202 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbdEKJTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id v4so5493679wmb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xb5PmJwwlPn5UY3VV4AnG0+JkCsTUKjlHhu0BsRV5/o=;
        b=Kons2sKam6gJZC3Kr7McOGqtQR/1LIeE0zEBvgfKXus5Y6+bKDSpG+HFWQrk5iINv6
         z/yEyvmpCiT8Xk3yHXNO2mBBK+YUE+xthM8EaHmaA3j5dJgJERH3sqhhKqUXToXt0U9t
         elRoDW8OMZrXGwClxP4snNkxk13Z1HeqMeovkycflZd8+dggdJ/hD1VtZAHflXiP8vUs
         lwJptuZjxuXKdQUgEAjee77kRLzhwmpfhfwvkgZqx8Q2EsARwPVNkMCAEBOYf0G3emBw
         RnFevbYYA36TYsGrjU43r/Q9LkAD9L/VAv6Kgc5B27ELTMctNN9mLUFzeq8PdlSgQvqi
         kTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xb5PmJwwlPn5UY3VV4AnG0+JkCsTUKjlHhu0BsRV5/o=;
        b=nbJFVLJp5PvaVPoyTsS/OiCJ5dm/WNNJ0Jb243uLYJFQU0FuEhLhc4kQvsvbQBKgok
         43QlUlV+JrOSK39+lkh7kPgM+3BXHu8+tgP7zIwU5oTy7mLajRBRedgrZapS2b+hZ3bc
         LPdc5qRSm3ZX0We/NHeTZpU8Gp351qru51qc/B2SzezLsrOyK2IYcz95snG4xHiUPVR1
         ixYOFLHa0quY6XO7sIJ9yczpI0twqLUNkjz1z0xJHUgO3f4UCkTsiabDK8RfJmbw7LZd
         xMRJdVJ38GqpgEwMYGrslfssrPjPlyAFK7i1Ep7SiYoMxm5oVp4gvUh2o6Frl4l6UFon
         MZQg==
X-Gm-Message-State: AODbwcC8OqQ1jJO/xxBW5mZIw6TNQ8Wb0LUuFxqCI/Lve4MebSxH7tPY
        bhav6KAU21Q0fA==
X-Received: by 10.80.205.212 with SMTP id h20mr45111edj.58.1494494393187;
        Thu, 11 May 2017 02:19:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:52 -0700 (PDT)
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
Subject: [PATCH 21/29] grep: factor test for \0 in grep patterns into a function
Date:   Thu, 11 May 2017 09:18:21 +0000
Message-Id: <20170511091829.5634-22-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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

This limitation was never documented, and other some regular
expression engines are capable of compiling a pattern containing a
\0. Factoring this out makes a subsequent change which does that
smaller.

See a previous commit in this series ("grep: add tests to fix blind
spots with \0 patterns", 2017-04-21) for further details & rationale.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index bf6c2494fd..27de615209 100644
--- a/grep.c
+++ b/grep.c
@@ -394,12 +394,6 @@ static int is_fixed(const char *s, size_t len)
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
@@ -408,6 +402,17 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
 
+static int has_null(const char *s, size_t len)
+{
+	/* regcomp cannot accept patterns with NULs so when using it
+	 * we consider any pattern containing a NUL fixed.
+	 */
+	if (memchr(s, 0, len))
+		return 1;
+
+	return 0;
+}
+
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -451,7 +456,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	 * simple string match using kws.  p->fixed tells us if we
 	 * want to use kws.
 	 */
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
 	else
 		p->fixed = 0;
-- 
2.11.0

