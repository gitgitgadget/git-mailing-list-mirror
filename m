Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664662035F
	for <e@80x24.org>; Sat, 29 Oct 2016 00:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbcJ2AFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 20:05:25 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36081 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756115AbcJ2AFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 20:05:20 -0400
Received: by mail-pf0-f176.google.com with SMTP id e6so44712886pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uwCUMPHvmQT2ErPu6RKSSceqMeKwD3Ve1kTEqjRorbo=;
        b=HzjZEuWqSd7XJZzMcpTUPp20LbMrei5Glb05Evcf9n2L7n71BJ8isTOqvQNEmG8V/L
         O/UbMaoHCswbNQcI7goZ+L0KODr98IzLVD48qa8lEXCOt5GLet8WdahiF3OSdqyRCOm2
         V0ZgrY3CnaoVLC2HKCgt38Ln3Vbs5cbLCk5FA6bjwbtce+hn0traVuTB6Dl2zjSC+uMW
         UZEjXsj0W9X3W9p+5Or4qAX7+pnXH/y8o1Lu4LYLYBwabqWSKQLeCnbTCVYj8AzjDAT6
         TEmc6Ie4itbe183ZhMEhFWkcHCwtRUDvX/YcXivEu6gmsiUnBVhxMbrGGWM0fDF+gXUT
         viWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uwCUMPHvmQT2ErPu6RKSSceqMeKwD3Ve1kTEqjRorbo=;
        b=cAiBk3xuEimjdp70CQ6hOySDlFZw2Ot5nfnQnNQ3rDPxCm77+KmMSL++85Kb7kcW4h
         FhCnXOcZNbtET7/+If2ANuHS6T9CJQTqDbScjUFnICSDbOc+zkQSVvmuYaRvEgPa7tUR
         bmPUEVNpbK7SxkodpI83YOZE5j6Z/GTbNk1wsiM2/ClWd9opDSuqjXwYhHc7w6uOdH3p
         QE4/UPfX2HGEETbKZAa8qy5OKyQEcD05M8mzw/IyD01malm8L9cOe+Hk9KGVjdnhHmSL
         ElaUe5DExOgmN13wQjUxFTaPFa6Of/lbmTHSYK4lWUhPSIWR4snDA26+rdnyMb5H7jyN
         0JOA==
X-Gm-Message-State: ABUngveq2enM1JaBXDVA6Zo0V9X2TLjsG7U0R/v6QM+En8Dq8t2i1nZLLGLi/x0e/b0M9e6x
X-Received: by 10.99.114.73 with SMTP id c9mr24201593pgn.175.1477699519252;
        Fri, 28 Oct 2016 17:05:19 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b66sm21356750pfg.10.2016.10.28.17.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 17:05:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/4] trailer: have function to describe trailer layout
Date:   Fri, 28 Oct 2016 17:05:10 -0700
Message-Id: <d55ff281b88624cdbf5c21a56d817d8d17eff5c0.1477698917.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a function that, taking a string, describes the position of its
trailer block (if available) and the contents thereof, and make trailer
use it. This makes it easier for other Git components, in the future, to
interpret trailer blocks in the same way as trailer.

In a subsequent patch, another component will be made to use this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 120 +++++++++++++++++++++++++++++++++++++++++++-------------------
 trailer.h |  25 +++++++++++++
 2 files changed, 108 insertions(+), 37 deletions(-)

diff --git a/trailer.c b/trailer.c
index d4d9e10..2f5c815 100644
--- a/trailer.c
+++ b/trailer.c
@@ -46,6 +46,8 @@ static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
+static int configured = 0;
+
 #define TRAILER_ARG_STRING "$ARG"
 
 static const char *git_generated_prefixes[] = {
@@ -549,6 +551,17 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
+static void ensure_configured(void)
+{
+	if (configured)
+		return;
+
+	/* Default config must be setup first */
+	git_config(git_trailer_default_config, NULL);
+	git_config(git_trailer_config, NULL);
+	configured = 1;
+}
+
 static const char *token_from_item(struct arg_item *item, char *tok)
 {
 	if (item->conf.key)
@@ -872,59 +885,43 @@ static int process_input_file(FILE *outfile,
 			      const char *str,
 			      struct list_head *head)
 {
-	int patch_start, trailer_start, trailer_end;
+	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	struct trailer_item *last = NULL;
-	struct strbuf *trailer, **trailer_lines, **ptr;
+	int i;
 
-	patch_start = find_patch_start(str);
-	trailer_end = find_trailer_end(str, patch_start);
-	trailer_start = find_trailer_start(str, trailer_end);
+	trailer_info_get(&info, str);
 
 	/* Print lines before the trailers as is */
-	fwrite(str, 1, trailer_start, outfile);
+	fwrite(str, 1, info.trailer_start - str, outfile);
 
-	if (!ends_with_blank_line(str, trailer_start))
+	if (!info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
 
-	/* Parse trailer lines */
-	trailer_lines = strbuf_split_buf(str + trailer_start, 
-					 trailer_end - trailer_start,
-					 '\n',
-					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
+	for (i = 0; i < info.trailer_nr; i++) {
 		int separator_pos;
-		trailer = *ptr;
-		if (trailer->buf[0] == comment_line_char)
+		char *trailer = info.trailers[i];
+		if (trailer[0] == comment_line_char)
 			continue;
-		if (last && isspace(trailer->buf[0])) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, "%s\n%s", last->value, trailer->buf);
-			strbuf_strip_suffix(&sb, "\n");
-			free(last->value);
-			last->value = strbuf_detach(&sb, NULL);
-			continue;
-		}
-		separator_pos = find_separator(trailer->buf, separators);
+		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
-			parse_trailer(&tok, &val, NULL, trailer->buf,
-				      separator_pos);
-			last = add_trailer_item(head,
-						strbuf_detach(&tok, NULL),
-						strbuf_detach(&val, NULL));
+			parse_trailer(&tok, &val, NULL, trailer,
+			              separator_pos);
+			add_trailer_item(head,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL));
 		} else {
-			strbuf_addbuf(&val, trailer);
+			strbuf_addstr(&val, trailer);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
 					 NULL,
 					 strbuf_detach(&val, NULL));
-			last = NULL;
 		}
 	}
-	strbuf_list_free(trailer_lines);
 
-	return trailer_end;
+	trailer_info_release(&info);
+
+	return info.trailer_end - str;
 }
 
 static void free_all(struct list_head *head)
@@ -975,9 +972,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	int trailer_end;
 	FILE *outfile = stdout;
 
-	/* Default config must be setup first */
-	git_config(git_trailer_default_config, NULL);
-	git_config(git_trailer_config, NULL);
+	ensure_configured();
 
 	read_input_file(&sb, file);
 
@@ -1004,3 +999,54 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	strbuf_release(&sb);
 }
+
+void trailer_info_get(struct trailer_info *info, const char *str)
+{
+	int patch_start, trailer_end, trailer_start;
+	struct strbuf **trailer_lines, **ptr;
+	char **trailer_strings = NULL;
+	size_t nr = 0, alloc = 0;
+	char **last = NULL;
+
+	ensure_configured();
+
+	patch_start = find_patch_start(str);
+	trailer_end = find_trailer_end(str, patch_start);
+	trailer_start = find_trailer_start(str, trailer_end);
+
+	trailer_lines = strbuf_split_buf(str + trailer_start,
+					 trailer_end - trailer_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
+		if (last && isspace((*ptr)->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_addbuf(&sb, *ptr);
+			*last = strbuf_detach(&sb, NULL);
+			continue;
+		}
+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailer_strings[nr], separators) >= 1
+			? &trailer_strings[nr]
+			: NULL;
+		nr++;
+	}
+	strbuf_list_free(trailer_lines);
+
+	info->blank_line_before_trailer = ends_with_blank_line(str,
+							       trailer_start);
+	info->trailer_start = str + trailer_start;
+	info->trailer_end = str + trailer_end;
+	info->trailers = trailer_strings;
+	info->trailer_nr = nr;
+}
+
+void trailer_info_release(struct trailer_info *info)
+{
+	int i;
+	for (i = 0; i < info->trailer_nr; i++)
+		free(info->trailers[i]);
+	free(info->trailers);
+}
diff --git a/trailer.h b/trailer.h
index 36b40b8..65cc5d7 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,7 +1,32 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+struct trailer_info {
+	/*
+	 * True if there is a blank line before the location pointed to by
+	 * trailer_start.
+	 */
+	int blank_line_before_trailer;
+
+	/*
+	 * Pointers to the start and end of the trailer block found. If there
+	 * is no trailer block found, these 2 pointers point to the end of the
+	 * input string.
+	 */
+	const char *trailer_start, *trailer_end;
+
+	/*
+	 * Array of trailers found.
+	 */
+	char **trailers;
+	size_t trailer_nr;
+};
+
 void process_trailers(const char *file, int in_place, int trim_empty,
 		      struct string_list *trailers);
 
+void trailer_info_get(struct trailer_info *info, const char *str);
+
+void trailer_info_release(struct trailer_info *info);
+
 #endif /* TRAILER_H */
-- 
2.8.0.rc3.226.g39d4020

