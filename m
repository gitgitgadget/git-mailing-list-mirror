Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81ED720248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDNVJv (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:09:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:09:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so19199072wrm.4
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaAakVCjgt/IsKWlGITLLkRYvqHQoTy5lBbU516cqbQ=;
        b=EbYnNDPb1IBkQMvqsLd0uZCC/X77A6cFA/cYhtpPN3yUBTv98uCIYDfQKOtOoDitj2
         dHciuyJnIwnC9y4Zq47nAoMF0/95pJ9JBiWTmT2TyZa0jlROwuOezixFYrkcyQemhpBl
         18TWlJHlJAsxMyXcyL+qbrxdoYAjBhWyvpSDvY769GZU446KrgHJmtLMA90ZL95t1Yff
         u4WdivnKYW02e7w2ZIFjVdXKnWLa9DZPS+/5MPNsf+dSDISnwvqeXOf1AdngmYvSPMfr
         vCCPQOvG7eUWTSCRowhqlSPGj9czSSwrgBboGDa0YhFg8LFAowts4PRbDV1VixzQl511
         XAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaAakVCjgt/IsKWlGITLLkRYvqHQoTy5lBbU516cqbQ=;
        b=TUA6SdYm34R7Sw4bZRS0tQ4RfRO+Wk84xkNTAJbau1r72j33ZNB16BPhDVjDiSzxVb
         PJ+ydoXJQQi9OhRwF78WwGlLsmDO8zoc8gB0MRAEOwwEjQZmUBhzw8r8M6FOxx5kYuUb
         TsPG+nBLr8G00G82HbPXyLM/5HQbv4DQhZZ164Gt/H6zeHQBzC69ZsJO/o0RZWWs6bjj
         OPoVdseUdR1CVBvJ8sxEB9zzxgUDFHQKr6JoSp9qZSihTjH33kOqc3+MP8yurIa5iUFE
         w3qxbwrxarn4oCF2GmmEGeI3oyos0UdqXnAboOGeG/87i/9TQkfHvv5L8kgZBtUZpfEj
         vVWw==
X-Gm-Message-State: APjAAAU75JY63ZEk4L1+HN/00JAgBLyc+xo3/V8yBn7OrfXP1Xkkm+Wq
        FF7aK+YtcHL4Z093R4xDoBfHmXlE
X-Google-Smtp-Source: APXvYqzRpTBHaRe8M62Fcy9SYgNF+8TH1S1XlTZQXJ8rsGsQ8VIAtnZrhD5tO5yxTwbCXWwkqRxxOw==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr30837604wro.180.1555276188640;
        Sun, 14 Apr 2019 14:09:48 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id y3sm16396543wmi.27.2019.04.14.14.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:09:47 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 4/4] range-diff: add section headers to the outer hunk header
Date:   Sun, 14 Apr 2019 22:09:33 +0100
Message-Id: <20190414210933.20875-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e1
In-Reply-To: <20190414210933.20875-1-t.gummerer@gmail.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the section headers we introduced in the previous commit to the
outer diff's hunk headers.  This makes it easier to understand which
change we are actually looking at.  For example an outer hunk header
might now look like:

    @@ -77,15 +78,43 @@ modified file Documentation/config/interactive.txt

while previously it would have only been

    @@ -77,15 +78,43 @@

which doesn't give a lot of context for the change that follows.

For completeness also add section headers for the commit metadata and
the commit message, although they are arguably less important.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index aa466060ef..15ac54f369 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -124,8 +124,10 @@ static int read_patches(const char *range, struct string_list *list)
 			strbuf_addstr(&buf, " ##\n");
 		} else if (in_header) {
 			if (starts_with(line.buf, "Author: ")) {
+				strbuf_addstr(&buf, " ## Metadata ##\n");
 				strbuf_addbuf(&buf, &line);
 				strbuf_addstr(&buf, "\n\n");
+				strbuf_addstr(&buf, " ## Commit message ##\n");
 			} else if (starts_with(line.buf, "    ")) {
 				strbuf_rtrim(&line);
 				strbuf_addbuf(&buf, &line);
@@ -387,8 +389,8 @@ static void output_pair_header(struct diff_options *diffopt,
 	fwrite(buf->buf, buf->len, 1, diffopt->file);
 }
 
-static struct userdiff_driver no_func_name = {
-	.funcname = { "$^", 0 }
+static struct userdiff_driver section_headers = {
+	.funcname = { "^ ## (.*) ##$", REG_EXTENDED }
 };
 
 static struct diff_filespec *get_filespec(const char *name, const char *p)
@@ -400,7 +402,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
-	spec->driver = &no_func_name;
+	spec->driver = &section_headers;
 
 	return spec;
 }
-- 
2.21.0.593.g511ec345e1

