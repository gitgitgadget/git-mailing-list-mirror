Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541541F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934607AbeF3JUw (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40789 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbeF3JUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so2884585lfd.7
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbzFXWDbmkwOKxmRn/fk66jnUVQzZ+ljWbAC7Djx7PA=;
        b=mz6VysBU9B9cR9/ZXEUS+8kPjY1Rjq3t71X+KAZusEzB0ZC60AjlSP3lrfcRekTIMM
         4Jwi2lQS8mEEVDMt6B9NqNxz0Ut6CskonIKcruzczVm2O5k5Ssca/lBtVZl5Lu6As0lY
         sdciaS1QHE2eBuWjhvVJQplvAm/nsLKZ1oy7F3sc0rm5dL03WicnD8S/hj1vaKFj8nZm
         OESGAHxBnfT/fCxzznnMUPCo+R98TvoFd7eT4wHzixj4fMxkKtgYda57a4NtQDAXoLqd
         /hBrLmfm1GSEMQBTz3dCZOV180dupkqJaXSPDAARdQe+OXeQNzQREwPUTJFigQ4PLuMJ
         5OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbzFXWDbmkwOKxmRn/fk66jnUVQzZ+ljWbAC7Djx7PA=;
        b=LHr269XVdouPRwloDdq4HNE7zsbtvg8v2XndIQhENDf1psc54CubfDyeu0F8mQ2hBM
         hgXe/NUg955S2urY059x7lyN4aOZmp9IXvosAaW5/YiBtBanczGOdRHfJIk9gKlUwhq6
         beJTKiXCDk5m1d5E+ZGv68T/EGwuQXJb2kNZyJFjNhjRFQJwhRtksX2LazE5TVa8NCfg
         7vvWvI4VnuWopCd7CzbuBhokwspj6VcunjNY8dp44LdgOSKIPL9jZCkrAAzEkedCKcbT
         S6+J8jskFeFxpgRr9P7Zu1GWOzkXRMheiHONXPNk4ynFHGCZHU/9jzvM4qTs4uQDcz37
         hFPQ==
X-Gm-Message-State: APt69E1UffSClkPp0xNfrnfE0jcPNWtBhcKPKPtSFg5YFMjXX+vgc257
        cCOi3pWGWwNJ0a/GcG3DHfGFKw==
X-Google-Smtp-Source: AAOMgpesPNEpB6AfXPoALdDfYwxdJYXy8SRU24BcloMBCroVwe4CngSjfIvsyw5o45ybixe1l4ue8A==
X-Received: by 2002:a19:4895:: with SMTP id v143-v6mr11149736lfa.82.1530350444427;
        Sat, 30 Jun 2018 02:20:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/12] convert.h: drop 'extern' from function declaration
Date:   Sat, 30 Jun 2018 11:20:24 +0200
Message-Id: <20180630092031.29910-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
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
2.18.0.rc2.476.g39500d3211

