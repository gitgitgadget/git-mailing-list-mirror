Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18BD51F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932363AbeFFHkf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:35 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45550 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbeFFHjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id n3-v6so7533426lfe.12
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7XFFb5snzfikBLGk4PuVcmsbm/hAlK8J8Jv7Jy3Eys=;
        b=QoExQsKd6njfnOLTYa1NRNrwkK0kX+wASqciLeIuTzodmt0uTGETvIhseAf1KsN8RM
         RJ8IIFoon4JNEC7m7Tzbgmo1lrG9upSJKPyMUGrCcuP26ufz+ej4w+Hye8LGCW8gE3yP
         pjT+22BDXmwKnmC3YOmRxQejofhhVQzftNcQJypKuvFnZlP9OiNjWTPUFmvaQ+rNgPIr
         fMGeMr/wtlBlLpBZ8ln9OMrJ+aRA/YE1ONd1ApV1sH5tPscDjQ+mz4UkViIj8tpJFTWm
         K9DfoXEWpfeNPTI7/202bxMFcX4JFsdjlSDXN0LRWJP5SUDgu9RA6YDjlvpP4fVnaDUD
         MB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7XFFb5snzfikBLGk4PuVcmsbm/hAlK8J8Jv7Jy3Eys=;
        b=STX2CX8SqyqEfZvD+u9J3k3QSZm0gq+8qot7bweMwqy9vVp53mwBrEfhEXJvbyi5Kq
         PNMIOZK2g9Mm4VV7FIYeyNa7TOsppMiLS6v/5rbMqYGSD7ilwp4d2TJuZP6YpMTN3Nm3
         W5lbq1//X3Iw/ZshPXtVwzlcMW4cFPW106dB9hHqxf3NSlfO4oIIzicrpHVtgo1DTJP2
         F5fWiVewWc2mA25Ov4JgCNntFJXs8mG6nIDDSlMst0+EeSCQ4I/jnSmw5xnxnwUw5nbQ
         nOXGhkjjC76MVjRcztyd28XgFhelbCh96FQ0qQY5qOD0K7Z6GRhHj/iP87vmSWakU046
         Nf4w==
X-Gm-Message-State: APt69E2qU1DLvLEerhJWJd9kKcJuUfDKGAy1Hge39FJz0AtL4Llokcnt
        sdbf+MLz5FpQtfjwegQMM7JNlA==
X-Google-Smtp-Source: ADUXVKLRIGl1JP96kZJ0J1MBUI38mfXR76sNnghySd3L6Xk6d/OsQMrgWdqjOVHIgTQ2bkS9S6k2Ug==
X-Received: by 2002:a19:b587:: with SMTP id g7-v6mr1193582lfk.144.1528270793952;
        Wed, 06 Jun 2018 00:39:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 08/20] convert.h: drop 'extern' from function declaration
Date:   Wed,  6 Jun 2018 09:39:21 +0200
Message-Id: <20180606073933.14755-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 convert.h | 56 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/convert.h b/convert.h
index 01385d9288..0a0fa15b58 100644
--- a/convert.h
+++ b/convert.h
@@ -57,35 +57,36 @@ struct delayed_checkout {
 
 extern enum eol core_eol;
 extern char *check_roundtrip_encoding;
-extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
-						  const char *path);
-extern const char *get_wt_convert_stats_ascii(const char *path);
-extern const char *get_convert_attr_ascii(const char *path);
+const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+					   const char *path);
+const char *get_wt_convert_stats_ascii(const char *path);
+const char *get_convert_attr_ascii(const char *path);
 
 /* returns 1 if *dst was used */
-extern int convert_to_git(const struct index_state *istate,
-			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, int conv_flags);
-extern int convert_to_working_tree(const char *path, const char *src,
-				   size_t len, struct strbuf *dst);
-extern int async_convert_to_working_tree(const char *path, const char *src,
-					 size_t len, struct strbuf *dst,
-					 void *dco);
-extern int async_query_available_blobs(const char *cmd, struct string_list *available_paths);
-extern int renormalize_buffer(const struct index_state *istate,
-			      const char *path, const char *src, size_t len,
-			      struct strbuf *dst);
+int convert_to_git(const struct index_state *istate,
+		   const char *path, const char *src, size_t len,
+		   struct strbuf *dst, int conv_flags);
+int convert_to_working_tree(const char *path, const char *src,
+			    size_t len, struct strbuf *dst);
+int async_convert_to_working_tree(const char *path, const char *src,
+				  size_t len, struct strbuf *dst,
+				  void *dco);
+int async_query_available_blobs(const char *cmd,
+				struct string_list *available_paths);
+int renormalize_buffer(const struct index_state *istate,
+		       const char *path, const char *src, size_t len,
+		       struct strbuf *dst);
 static inline int would_convert_to_git(const struct index_state *istate,
 				       const char *path)
 {
 	return convert_to_git(istate, path, NULL, 0, NULL, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
-extern void convert_to_git_filter_fd(const struct index_state *istate,
-				     const char *path, int fd,
-				     struct strbuf *dst,
-				     int conv_flags);
-extern int would_convert_to_git_filter_fd(const char *path);
+void convert_to_git_filter_fd(const struct index_state *istate,
+			      const char *path, int fd,
+			      struct strbuf *dst,
+			      int conv_flags);
+int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
  *
@@ -95,9 +96,10 @@ extern int would_convert_to_git_filter_fd(const char *path);
 
 struct stream_filter; /* opaque */
 
-extern struct stream_filter *get_stream_filter(const char *path, const struct object_id *);
-extern void free_stream_filter(struct stream_filter *);
-extern int is_null_stream_filter(struct stream_filter *);
+struct stream_filter *get_stream_filter(const char *path,
+					const struct object_id *);
+void free_stream_filter(struct stream_filter *);
+int is_null_stream_filter(struct stream_filter *);
 
 /*
  * Use as much input up to *isize_p and fill output up to *osize_p;
@@ -111,8 +113,8 @@ extern int is_null_stream_filter(struct stream_filter *);
  * such filters know there is no more input coming and it is time for
  * them to produce the remaining output based on the buffered input.
  */
-extern int stream_filter(struct stream_filter *,
-			 const char *input, size_t *isize_p,
-			 char *output, size_t *osize_p);
+int stream_filter(struct stream_filter *,
+		  const char *input, size_t *isize_p,
+		  char *output, size_t *osize_p);
 
 #endif /* CONVERT_H */
-- 
2.18.0.rc0.333.g22e6ee6cdf

