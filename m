Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838231F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfFSJ7b (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45762 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbfFSJ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so6983340plb.12
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXgZOTo5SQg9+n9h8g3TqbNw8L8gspfKOGEd0tzsdhs=;
        b=b0TPgqsgzj9SShqVSsqwtEiCNRcqlSJMdx7Go0iAwRUmbMVSJ3g2O5PsRHg5hwIQRZ
         Oq6wRn34uXRAp31/TuTr+xIL2cwhCLcOmZYwpGdDqcQOron6lUcChKezDy1Me7LX+6Ki
         QaZ5V69LRCm9pC0KNMfSY0RA6qS/CB65cGBNLXGK1TyFNeS1a26lOjLcRi4n8hPDc1Ns
         3HBZmCYikyxgqAjOYiqfMnz91SbNUHSN4a1S2In7qIXy6rpy6kTtzgRjAhF9TFBfK8dG
         EfO8/mwspRE9ayh5VuJ1reWm80BzlUjxj9zXCyiytrW/la3zZIgngJpA2a177O9B0OHr
         raxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXgZOTo5SQg9+n9h8g3TqbNw8L8gspfKOGEd0tzsdhs=;
        b=OLLslul7+u2HLgRvobkNDbuDu+UstDy3ks2/9Q5EtsxoCmGg3PPxHV0pkq09en6vq+
         ZL+yvKeR1ZC2dXAd5v8FcMGmQmmtU2HnfaTJWjfyfYnip+6sYFM2dixbAqVWOZ3J3RcJ
         /4ku6iMapnmvrnZv1xoOitzBi+FjSDN59upZIcS6zDhRDqf+OLEmflKcKOWpIz0HMSy8
         FN2Jtqwdiv/0u0U6X27W+6c6PLzyGGilW4TLLQQpOorEAWg2jWLUEbZu0Otf6Y6zWbyO
         jqPlV1hfdxJ789l1CCciKtLnGzUvwOmBGp+1ZaYRSHh0CZL7eX73swbccilMdMHSi1Hq
         Wb/w==
X-Gm-Message-State: APjAAAXkz4LkLiYQ9ws6NKti9wOVlO2Xlh1uexXClmagK6tMIFQIxB1T
        7TWCJ4gFQSfu+VUWgmwRvXJBqLjT
X-Google-Smtp-Source: APXvYqwU40w1buKSuCL5koxeiQFCTnLDSvVn0ooS+zeYpPsaL2YTEDWkvGRG+oR29XrH7dXMd/dyag==
X-Received: by 2002:a17:902:bb97:: with SMTP id m23mr52298335pls.141.1560938367970;
        Wed, 19 Jun 2019 02:59:27 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id a25sm17470811pfn.1.2019.06.19.02.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/8] read-cache.c: dump "EOIE" extension as json
Date:   Wed, 19 Jun 2019 16:58:55 +0700
Message-Id: <20190619095858.30124-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 3b5c63f53a..04863c3853 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1914,7 +1914,7 @@ struct index_entry_offset_table
 static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
 
-static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
+static size_t read_eoie_extension(const char *mmap, size_t mmap_size, struct json_writer *jw);
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
 
 struct load_index_extensions
@@ -2243,10 +2243,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		 * debugging only, so performance is not a concern.
 		 */
 		nr_threads = 1;
+		/* and dump EOIE extension even with threading off */
+		read_eoie_extension(mmap, mmap_size, istate->jw);
 	}
 
 	if (nr_threads > 1) {
-		extension_offset = read_eoie_extension(mmap, mmap_size);
+		extension_offset = read_eoie_extension(mmap, mmap_size, NULL);
 		if (extension_offset) {
 			int err;
 
@@ -3504,7 +3506,8 @@ int should_validate_cache_entries(void)
 #define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash> */
 #define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
 
-static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
+static size_t read_eoie_extension(const char *mmap, size_t mmap_size,
+				  struct json_writer *jw)
 {
 	/*
 	 * The end of index entries (EOIE) extension is guaranteed to be last
@@ -3548,6 +3551,12 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 		return 0;
 	index += sizeof(uint32_t);
 
+	if (jw) {
+		jw_object_inline_begin_object(jw, "end-of-index");
+		jw_object_intmax(jw, "offset", offset);
+		jw_object_intmax(jw, "ext-size", extsize);
+		jw_object_inline_begin_array(jw, "extensions");
+	}
 	/*
 	 * The hash is computed over extension types and their sizes (but not
 	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
@@ -3576,9 +3585,24 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 
 		the_hash_algo->update_fn(&c, mmap + src_offset, 8);
 
+		if (jw) {
+			char name[5];
+
+			jw_array_inline_begin_object(jw);
+			memcpy(name, mmap + src_offset, 4);
+			name[4] = '\0';
+			jw_object_string(jw, "name",  name);
+			jw_object_intmax(jw, "size", extsize);
+			jw_end(jw);
+		}
+
 		src_offset += 8;
 		src_offset += extsize;
 	}
+	if (jw) {
+		jw_end(jw);	/* extensions */
+		jw_end(jw);	/* end-of-index */
+	}
 	the_hash_algo->final_fn(hash, &c);
 	if (!hasheq(hash, (const unsigned char *)index))
 		return 0;
-- 
2.22.0.rc0.322.g2b0371e29a

