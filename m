Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0544B1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfFRX3i (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40048 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so17672378qtn.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPoy5SCr9H6wbbntCXImFSyMCGfsAC0sldlgcwIwbqI=;
        b=DR00RpbYwjioziuqgkmSmtG4jB91B+RmyewuvSo3YOGP870OoOd2tM9eE1XkJ3pIWN
         BSLkXSq9JkGgQF/yRNDiSnKumKlIFXwT0ghcGXVvvCJQbjPcBNAfUgJJ1sdZBd+lApCE
         /Q13SrrbVT9388oaHvxiumLrkZE3lhMjWkH7WW2UVT1t5ytjT606q3NL/i5XJUd8f21d
         e+qcvFsFw6hQUjGaAWp5N4Prcs7zQRCg1L+Kb+XorPtqulewsij8CxU3Wwp1GQcdZUJb
         7hQBd0OE80HDasxoxV8Ofbg28ivqfQ5qT4SYszDL4pdY0fjarWbzSrEegZfZt2+r8s7o
         n2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPoy5SCr9H6wbbntCXImFSyMCGfsAC0sldlgcwIwbqI=;
        b=bqiFh84SDXdeIxfWGDpicrIVVa3EsSNogjx0rqWjeBmv5+BsTqoHDQtVPgCRAVs9zb
         kZmruog4MYl3DXlMlXiPZFc4b2XfNUjfEYq1JNWOKE8Q9xSmWdEUeQZIZWZDw1IzKtsw
         Fg11NnAg73WXKzu9jk1AemXOcbdYNN6WP7NLy3/p1gpT/7ZRWFAtkHpAq9LfWpvJdwd6
         o21qo6odEie4kL5YaejBbvShwOHT20oF9KB+YDAE9NUCDelcuF5PLkzdmHXCFubNGAi5
         aKFEJ+t9c12VZsw6YdPFRgeIPwQ3l8koZJmwvJgdIyepgQ+Aa1rzoTjDtjLfSbAwjKlU
         VdDA==
X-Gm-Message-State: APjAAAWfGAv8Bppc3TOFF0q7QrkuhvsTKvtlIuvA7f+rgQSrEUdohQI9
        DQBv7xotEr4c9FWfFf/ojgpOJYfiGOM=
X-Google-Smtp-Source: APXvYqzPt9iK79IoKLI4OF41XRju+cCNLvApKONArjt2f1H1z4Zg1KbyCH8F+bSwFCZUVqVOvufW/g==
X-Received: by 2002:a0c:add8:: with SMTP id x24mr30691806qvc.167.1560900576898;
        Tue, 18 Jun 2019 16:29:36 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.29.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:36 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v7 08/10] clone: extract function from copy_or_link_directory
Date:   Tue, 18 Jun 2019 20:27:45 -0300
Message-Id: <8a3f7103366cef36d1c505251d89d64cdf274889.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help to remove
copy_or_link_directory's explicit recursion, which will be done in a
following patch. Also makes the code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9dd083e34d..96566c1bab 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -394,6 +394,21 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void mkdir_if_missing(const char *pathname, mode_t mode)
+{
+	struct stat st;
+
+	if (!mkdir(pathname, mode))
+		return;
+
+	if (errno != EEXIST)
+		die_errno(_("failed to create directory '%s'"), pathname);
+	else if (stat(pathname, &st))
+		die_errno(_("failed to stat '%s'"), pathname);
+	else if (!S_ISDIR(st.st_mode))
+		die(_("%s exists and is not a directory"), pathname);
+}
+
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
 {
@@ -406,14 +421,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
-		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
-		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
-	}
+	mkdir_if_missing(dest->buf, 0777);
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
-- 
2.22.0

