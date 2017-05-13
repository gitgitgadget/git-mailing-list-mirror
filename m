Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5322020188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758436AbdEMXRY (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35454 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756291AbdEMXRW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id r58so11223157qtb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LK/yBIfvaJPcUGTbJJOdEnDBbRV9lwhR3+5ojtpR30M=;
        b=eF2NhBsFsiURqrI7JuAy3jSuCFVyMMmrZ/NJ5AUC/YUtZoNeEsCV1e34PdnfAxmj2r
         VrNnVMLwgL8jHle5Q04fSlIHzmnPKKRsMuIsxkIg8x/1F1ogiYsYGnv7FaWc87ET3xw0
         ustA2fIcWiRW/fX7ZcpXzcSbMSHeJ69p7pMkBnZsuZ3B9mPQnhFTwW3OKPWmenat5NJx
         hKpILft4xCXNCZqx6lSza5sIpXPkfEsH+gg6tHJo9KiH3fmvQ1vlKQH8Q2nuCVo0RzCh
         zRwgldPy7SRp18tX9Fcg9jLQmCY7pE9O5bXGkNtsXdQcRDheE7M8Fi1GdKsdnnPLFnFI
         MLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LK/yBIfvaJPcUGTbJJOdEnDBbRV9lwhR3+5ojtpR30M=;
        b=lhk1TIOO/USrCyCUHFTMfibb7iQiwpAic/4nLHTkk3rsnSnJBfgAGeQnXX/GSg8xE6
         FiXHqfqK4tPkQ4Yvmwi2JrqiBaslwR5vOEHY+fNWpcqH+og3V5MhSxTnSEyLQdY+oo6w
         DQxR8SJEDwthoLLJmf4tOO9vjWfHWMoZNi4nNM/79rF+sdZuIBKefUIfkrXKeP1Gvzmt
         jOLqi7JuyJNkf9ZvESIcQUN9RmXVO9Qp1ubartVhHiXT7Ld1nCIXVzVzS4pRy0EFLYLF
         eCo08sXQs2fBblCVrGObL5I843xMg3xzZeb7VDE95DLEhob96V7KLuuAtkMPTT5quuZ0
         DS9g==
X-Gm-Message-State: AODbwcDnl+Mu3bX0vtyBhV2fAeUx1v3Qpr8UEeiQC2Cis4olag1vVUws
        9hZk41ROdUrouA==
X-Received: by 10.200.36.10 with SMTP id c10mr9931919qtc.160.1494717431878;
        Sat, 13 May 2017 16:17:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:11 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 24/29] grep: move is_fixed() earlier to avoid forward declaration
Date:   Sat, 13 May 2017 23:15:04 +0000
Message-Id: <20170513231509.7834-25-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_fixed() function which are currently only used in
compile_regexp() earlier so it can be used in the PCRE family of
functions in a later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/grep.c b/grep.c
index 07512346b1..1157529115 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
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
 static int has_null(const char *s, size_t len)
 {
 	/*
@@ -402,18 +414,6 @@ static void free_pcre1_regexp(struct grep_pat *p)
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
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.11.0

