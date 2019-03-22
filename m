Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36F420248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfCVXXF (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:23:05 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40884 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfCVXXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:23:05 -0400
Received: by mail-qt1-f177.google.com with SMTP id x12so4436469qts.7
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIiOCHYHZ4WP3/M+Kt6+3GSWZEEiYjUotGx83tH2z9g=;
        b=Zgz4vakZw69OYgsYX1KGcwHLdurG2TzpH5t3P+5x2FaGX7dwWtddj031JLDWNPgyb+
         PVgbXi4dIJRJ3/JUvQkVvdQqOE18crAcggM1p/9O0yEiha5El7F10jmoFO/eXMbmqfIf
         /vX28BoKstarL21dIF446erNXTkS62ShnCoIep6BMoQxBcHQ9d7Ay98Wmg6zuHDps6/C
         6kUaUQsHYdfTk7hSnWmqJCC1MxjODUQJwXKH7fm69j+m5a3UXUdYTF0G0ELd5VxY5oR8
         Mdf7c+dXAftnOVGdotjJdRQFBdmKVQkxDbpX6TpPCP/Vsxc/lN9hpw/UyOhJWx407/hB
         uD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIiOCHYHZ4WP3/M+Kt6+3GSWZEEiYjUotGx83tH2z9g=;
        b=CxKepWWblKhqYRg6XlJsdRlH3XWNKIKz7gGF0mHK6HpkyOBJGJ6+Q9OVYHF+ERvqZF
         0RtiMobwqrff7YEA5noZWeQ1t2/auWlijDmsFLYnlWtFH6SGKgntbCSrJasRVBtKR4bg
         QXlO4PB4FmHacC7jD3QxRbAoR1BsYyTfNV7WEBOi3eYGm6xKed+c7MHao2KE/rKi61s9
         SUde/Hbp/zdf0hjX2lv9be6fUaMfWxqz8JRD4amImlfVGdDYERMIYG0rNb9aPnRs5OjQ
         XK3GOwR2l8DSL3pzuJ+1utk+kYhGrxxz2KKIL1Din7o1jUikHphDgNCKpeg7eR92nmFx
         m7sw==
X-Gm-Message-State: APjAAAWPgF2BRqnWZuczuQdyy+ufx10es0P6PhCM+R4lp8OMb5AzbZoA
        s1BHCEpLztQ15ErWzjynM72F+p15HT4=
X-Google-Smtp-Source: APXvYqzAgya1LLtFPLgSwkQYmMGdTatfzwdXbUE1+lm5Sds+p8I/jgt5cwM/X1vDMdEmRlC9ByBf0Q==
X-Received: by 2002:ac8:33dd:: with SMTP id d29mr11005681qtb.320.1553296984397;
        Fri, 22 Mar 2019 16:23:04 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:23:03 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 5/7] clone: extract function from copy_or_link_directory
Date:   Fri, 22 Mar 2019 20:22:35 -0300
Message-Id: <20190322232237.13293-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help removing
copy_or_link_directory's explicit recursion, which will be done in a
following patch. Also makes code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60c6780c06..c17bbf1bfc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,21 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
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
@@ -404,14 +419,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
2.20.1

