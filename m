Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E011FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbdEKJUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35518 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbdEKJUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id v4so5494646wmb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnjFfGtrsB3pjXABhAF1h6QlcdMY1K/Pqg8ffqeb+ZY=;
        b=fjOD8fH8vqiXNFXsT8KzDcrzmcu0VE8HAdM1WFO01ye0VEqqJ2Qgx6bIS9T7Ks8TdL
         fAqgLhxjaTWtm6XJVtLdH6M6mCMyJVx1kpjXVkX41epm3gYdwy0nsMZtn7+KvQyDwkao
         En5Hycn2GNmc5cF0A8wC4rJDMhOvJRA+QrpoipaW+LZ08CRsjt+J4QaMe/RRve/Dr+lJ
         yh9OrwteJwvCjiU5Xywch9s20P/lMmL0MsThuVB/dkWr1kOtATwq39GkauXMDpqjlMb2
         AI9w6eoueGwTvaFySjw1ydu7hQsZTUzZi1SzGSAXkrv5oVIkvj9EPNiuoNo3vZ5u2tk+
         nJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnjFfGtrsB3pjXABhAF1h6QlcdMY1K/Pqg8ffqeb+ZY=;
        b=Po02oAR9Ilh8xj8C7Y7eAL/xAWmBUY9n89JeQrAJU1n11a9Qk/ouN6HHropCXJHPWb
         b3V5qKrDACZ0pdo4XyRG50+d+tgs1E7NibvruqlABAkYEztTFi5v2cUKrOtO/sf4ZKmm
         dKAZrOjP+QhoOU8FVFj/LonZ1a9I8T1CxYwHvUUfd+ec5T0MUnBKlCXi3tlreZTXiPwc
         2ZFumLPCnM2WQmSItxYWMvpoS4sDWmMvsPdu1LbM7AuecLfjdRkDqp/Z1cxc1edbSRZV
         HaiKPd8/4Eh6+hiWBBOVR+7AVvXWzmlu4En/dXUcVz9wmRjGqrEy4X09E2YGboaJFctU
         XNTg==
X-Gm-Message-State: AODbwcCMDCxiL2xuuPj/j1hBNuYkejGeG0E8S/cLZD0LHUoRyeQFZGxt
        m2h3ubq66mupR/n1V3I=
X-Received: by 10.80.173.4 with SMTP id y4mr52735edc.16.1494494402072;
        Thu, 11 May 2017 02:20:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:20:01 -0700 (PDT)
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
Subject: [PATCH 24/29] grep: move two functions to avoid forward declaration
Date:   Thu, 11 May 2017 09:18:24 +0000
Message-Id: <20170511091829.5634-25-avarab@gmail.com>
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

Move the is_fixed() and has_null() functions which are currently only
used in compile_regexp() earlier so they can be used in the PCRE
family of functions in a later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/grep.c b/grep.c
index 4507765811..5c808f8971 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,29 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int is_fixed(const char *s, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (is_regex_special(s[i]))
+			return 0;
+	}
+
+	return 1;
+}
+
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
 #ifdef USE_LIBPCRE1
 static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -390,29 +413,6 @@ static void free_pcre1_regexp(struct grep_pat *p)
 }
 #endif /* !USE_LIBPCRE1 */
 
-static int is_fixed(const char *s, size_t len)
-{
-	size_t i;
-
-	for (i = 0; i < len; i++) {
-		if (is_regex_special(s[i]))
-			return 0;
-	}
-
-	return 1;
-}
-
-static int has_null(const char *s, size_t len)
-{
-	/* regcomp cannot accept patterns with NULs so when using it
-	 * we consider any pattern containing a NUL fixed.
-	 */
-	if (memchr(s, 0, len))
-		return 1;
-
-	return 0;
-}
-
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.11.0

