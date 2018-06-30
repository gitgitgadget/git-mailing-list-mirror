Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28AE1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932876AbeF3JU4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:56 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:43812 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbeF3JUr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:47 -0400
Received: by mail-lf0-f54.google.com with SMTP id m12-v6so7903097lfc.10
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko5DvuOpig+DhqGeep6L7LvqPDaOhHcIvm9wlmEMeEI=;
        b=Oeqkos1fUIUbnGyCcDaPzLmAaL7HlbC+C3difRvXO7GRtJdAzmUWypMVeJnMi/EoaZ
         Ezpr/oHMU4fR8Ic+vWM1wzFjdGHLscVrLYbW6kz7AxUBA871EWdTPz6B+SwFBdnPW9Xn
         qR+2u440ThxGyfHH5MCyYjsZGBKZSW8zfgac5TnhLyuUBmE9aCOG+BLg/PMgaLiRV7eC
         FR5Ka85ga/78US4Qq2HI4KXcXLlnqh3k5wF5HLnnBqzJoePA9JdgpTQhzlouXXDEdnzl
         V8OI7PbwW6UQE4B1oIXZyScAUsl+mY21byGKSQyGdnDL4aon9uTK1IoVBMmZeuRQZXDi
         Loyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko5DvuOpig+DhqGeep6L7LvqPDaOhHcIvm9wlmEMeEI=;
        b=coLlCarG9D+wmg5t2ckZaLqoZGB3bJ9x42pCYDzxAzIF/PFNUzealzDkJR9GTV6VsM
         8iuzOw9yNzdzIOhmzlkpJvA92szoAKispY6bBX/mGrE6Sf7qXf1U7jO4u7+eCZ6Gt/Ke
         BISFW3aZdxxsC5h08u89Erz17YFpR0eMmza5fzXPXr8kgCqWSiuXo83sTLsCppEWvaif
         ZMnMX+XFwKQ5fj8kRsd1KHbpbP3U7TuqCEoAcEiwZjW7SpbUzfcZ61pSix3RNS0KXUNv
         8SlUD8E6/GbCe9t4+y7GCmewGPAN0JUat+Kua8w87L3Q5CLEGF9R2geTO1+/z2TlXVHF
         Lj2w==
X-Gm-Message-State: APt69E28oLnR2T7o51WBH6Mpe79XmovOfr2LCQX/8qv6Fz1rURFvCB8v
        fI6uH49A6IOrL07cywNs2ww/wQ==
X-Google-Smtp-Source: AAOMgpfoVYl3e7UYYa8dsLqSvqHj690LBjnVEZNoiLZ0f0N+cFz5gMa7c/RRS0b2wG0vds82nwEd3w==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr12313084lfa.43.1530350445440;
        Sat, 30 Jun 2018 02:20:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/12] diffcore.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:25 +0200
Message-Id: <20180630092031.29910-7-pclouds@gmail.com>
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
 diffcore.h | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/diffcore.h b/diffcore.h
index a30da161da..81281a398b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -50,17 +50,17 @@ struct diff_filespec {
 	struct userdiff_driver *driver;
 };
 
-extern struct diff_filespec *alloc_filespec(const char *);
-extern void free_filespec(struct diff_filespec *);
-extern void fill_filespec(struct diff_filespec *, const struct object_id *,
-			  int, unsigned short);
+struct diff_filespec *alloc_filespec(const char *);
+void free_filespec(struct diff_filespec *);
+void fill_filespec(struct diff_filespec *, const struct object_id *,
+		   int, unsigned short);
 
 #define CHECK_SIZE_ONLY 1
 #define CHECK_BINARY    2
-extern int diff_populate_filespec(struct diff_filespec *, unsigned int);
-extern void diff_free_filespec_data(struct diff_filespec *);
-extern void diff_free_filespec_blob(struct diff_filespec *);
-extern int diff_filespec_is_binary(struct diff_filespec *);
+int diff_populate_filespec(struct diff_filespec *, unsigned int);
+void diff_free_filespec_data(struct diff_filespec *);
+void diff_free_filespec_blob(struct diff_filespec *);
+int diff_filespec_is_binary(struct diff_filespec *);
 
 struct diff_filepair {
 	struct diff_filespec *one;
@@ -86,9 +86,9 @@ struct diff_filepair {
 
 #define DIFF_PAIR_MODE_CHANGED(p) ((p)->one->mode != (p)->two->mode)
 
-extern void diff_free_filepair(struct diff_filepair *);
+void diff_free_filepair(struct diff_filepair *);
 
-extern int diff_unmodified_pair(struct diff_filepair *);
+int diff_unmodified_pair(struct diff_filepair *);
 
 struct diff_queue_struct {
 	struct diff_filepair **queue;
@@ -102,16 +102,16 @@ struct diff_queue_struct {
 	} while (0)
 
 extern struct diff_queue_struct diff_queued_diff;
-extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
-					struct diff_filespec *,
-					struct diff_filespec *);
-extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
+struct diff_filepair *diff_queue(struct diff_queue_struct *,
+				 struct diff_filespec *,
+				 struct diff_filespec *);
+void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern void diffcore_break(int);
-extern void diffcore_rename(struct diff_options *);
-extern void diffcore_merge_broken(void);
-extern void diffcore_pickaxe(struct diff_options *);
-extern void diffcore_order(const char *orderfile);
+void diffcore_break(int);
+void diffcore_rename(struct diff_options *);
+void diffcore_merge_broken(void);
+void diffcore_pickaxe(struct diff_options *);
+void diffcore_order(const char *orderfile);
 
 /* low-level interface to diffcore_order */
 struct obj_order {
@@ -138,11 +138,11 @@ void diff_debug_queue(const char *, struct diff_queue_struct *);
 #define diff_debug_queue(a,b) do { /* nothing */ } while (0)
 #endif
 
-extern int diffcore_count_changes(struct diff_filespec *src,
-				  struct diff_filespec *dst,
-				  void **src_count_p,
-				  void **dst_count_p,
-				  unsigned long *src_copied,
-				  unsigned long *literal_added);
+int diffcore_count_changes(struct diff_filespec *src,
+			   struct diff_filespec *dst,
+			   void **src_count_p,
+			   void **dst_count_p,
+			   unsigned long *src_copied,
+			   unsigned long *literal_added);
 
 #endif
-- 
2.18.0.rc2.476.g39500d3211

