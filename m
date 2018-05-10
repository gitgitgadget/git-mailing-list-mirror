Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F026E1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeEJT7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:59:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44940 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeEJT66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:58:58 -0400
Received: by mail-pl0-f67.google.com with SMTP id e6-v6so1890225plt.11
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LIzb+E5pyq3i0P+Rcbj8fTAhYOWCXsbUpar+qXWWGL0=;
        b=jKwB/rPWPsvA/9KswK50f/s6+XlaaGaOzRph/PbSUTGRa89/cvODFqfLYkSkBu0EdY
         QX6srRxphBFkKzzAj1lnkPdhkZVjPuyNPq8dcSysPyDSnD2GUcx8nKUGfhC/TQKOwily
         ABFONGCeaZeDDIoLM0EHArkDg+oR8w4umPc5YGzMZpiY/JSq3C717osFLbt2Isen/JqQ
         +xfY8FsTh9alJN6tx+2JUUHT8HhEAjbE284fxJLJO8Y10L/s4OczrhwhEKRJsxutZbc1
         Ub/XE4ePvpzi/OEnWEMCpWC/Y5AjeDHlaCrJcR8ZbjbneQEzgatvwlJGKLd8NsUDjZx4
         5GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LIzb+E5pyq3i0P+Rcbj8fTAhYOWCXsbUpar+qXWWGL0=;
        b=Qjo1U+T7WFHCOSlbb9TMSRj2Z7fen4zeXAEsk65X7HKiWmo8v18KN9Xx+gckEz+CYM
         8YZZuuTM/nXW6LtIeRfTu5VwdsUWzmURm2sNdc6T+g2M76kYA1E8j5+YVldMzUpLFGKc
         iYuIWTQZeey76wnaYM4CbdhpFmDfDmYNaVr5/XKg5t6QFBirmCWRtGDIfG8th0pIjvRv
         NFl9lL/6viKXmDNue4jTZnUzBzM5GyD+pPC8OAB7ROZhYsEYsIhZZDgZDFw51jJ+Q7ej
         UKExkBe9omzaVyMzB4Lz1r3PxDjc8K1HxNOgiEp9WtBO7xIdlSV1U0Q0wRZ4/cBNxEpV
         4kDQ==
X-Gm-Message-State: ALKqPwcRR9Kyk7v1FPIhOlKScRia+Zpyn2Z47WA+7n1imUSg71oisDh2
        T29DbD17A+OAlbexR+vdjKCtVw==
X-Google-Smtp-Source: AB8JxZqeMfJZSWG6K2UDrv3o4UqQHzZTPFOwktlmBldOB9stZJt3KGl00R5P9N5Et3AnTRdfzB/hKg==
X-Received: by 2002:a17:902:3e5:: with SMTP id d92-v6mr2726804pld.104.1525982337872;
        Thu, 10 May 2018 12:58:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i1-v6sm4280718pfi.133.2018.05.10.12.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:58:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/4] packfile.h: remove all extern keywords
Date:   Thu, 10 May 2018 12:58:47 -0700
Message-Id: <20180510195849.28023-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510195849.28023-1-sbeller@google.com>
References: <20180510195849.28023-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per our coding guidelines we prefer to only use the extern keyword
when needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.h | 80 +++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/packfile.h b/packfile.h
index cdab0557979..eb3b1154501 100644
--- a/packfile.h
+++ b/packfile.h
@@ -10,32 +10,32 @@
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_name(const unsigned char *sha1);
+char *sha1_pack_name(const unsigned char *sha1);
 
 /*
  * Return the name of the (local) pack index file with the specified
  * sha1 in its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_index_name(const unsigned char *sha1);
+char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
 #define PACKDIR_FILE_GARBAGE 4
-extern void (*report_garbage)(unsigned seen_bits, const char *path);
+void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void reprepare_packed_git(struct repository *r);
-extern void install_packed_git(struct repository *r, struct packed_git *pack);
+void reprepare_packed_git(struct repository *r);
+void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
@@ -46,31 +46,31 @@ struct list_head *get_packed_git_mru(struct repository *r);
  */
 unsigned long approximate_object_count(void);
 
-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
+struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
-extern void pack_report(void);
+void pack_report(void);
 
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
  */
-extern int open_pack_index(struct packed_git *);
+int open_pack_index(struct packed_git *);
 
 /*
  * munmap the index file for the specified packfile (if it is
  * currently mmapped).
  */
-extern void close_pack_index(struct packed_git *);
+void close_pack_index(struct packed_git *);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_pack(struct packed_git *);
-extern void close_all_packs(struct raw_object_store *o);
-extern void close_and_free_packs(struct raw_object_store *o);
-extern void unuse_pack(struct pack_window **);
-extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+void close_pack_windows(struct packed_git *);
+void close_pack(struct packed_git *);
+void close_all_packs(struct raw_object_store *o);
+void close_and_free_packs(struct raw_object_store *o);
+void unuse_pack(struct pack_window **);
+void clear_delta_base_cache(void);
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
@@ -80,7 +80,7 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
  * (like the 64-bit extended offset table), as we compare the size to the
  * fixed-length parts when we open the file.
  */
-extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
+void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 
 /*
  * Perform binary search on a pack-index for a given oid. Packfile is expected to
@@ -96,51 +96,51 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
  * at the SHA-1 within the mmapped index.  Return NULL if there is an
  * error.
  */
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
 /*
  * Like nth_packed_object_sha1, but write the data into the object specified by
  * the the first argument.  Returns the first argument on success, and NULL on
  * error.
  */
-extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
+const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
  */
-extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
 /*
  * If the object named sha1 is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
  */
-extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
-extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int is_pack_valid(struct packed_git *);
+void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
+unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
-extern void release_pack_memory(size_t);
+void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */
-extern int do_check_packed_object_crc;
+int do_check_packed_object_crc;
 
-extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
+int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
-extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
+const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
+int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
 
-extern int has_sha1_pack(const unsigned char *sha1);
+int has_sha1_pack(const unsigned char *sha1);
 
-extern int has_pack_index(const unsigned char *sha1);
+int has_pack_index(const unsigned char *sha1);
 
 /*
  * Only iterate over packs obtained from the promisor remote.
@@ -156,13 +156,13 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
-extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
-extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
+int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-extern int is_promisor_object(const struct object_id *oid);
+int is_promisor_object(const struct object_id *oid);
 
 #endif
-- 
2.17.0.255.g8bfb7c0704

