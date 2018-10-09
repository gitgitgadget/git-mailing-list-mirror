Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3671F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJJCxq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:53:46 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52434 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJCxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:53:45 -0400
Received: by mail-wm1-f48.google.com with SMTP id 189-v6so3029948wmw.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gfnS2N3qsH54HXWCUsy8mbWNITMc7fg3pnFCfzgrCk=;
        b=oy6nt1K/eRlyhwMn1YnW/HiIOF/eBOzNLrnuPoydm+GSCoX8RncudSaeiEo4GQATI8
         zJUN88v3XyxzfN4EgZoIgliVqI6dSjFMCAxrRJklhBWxrotx9kVloYj9jvuukQyNgg+J
         ax9CREHmhjRuWjlJ5lcDAukO6VIfm8f4e1q6K5bTKnwFVsqMIponqdI40cn0NAjbLjyU
         1KLGo9jelIgA/Zid1nt7TQWyfGx535BPp9JVVny4WSR3pm67x36w0VtKNTFIFa5pdjZx
         NgOxD9sH3TCN856Jzxm6VpSQ/p1D3/SL0TMeUO3bI2+4HD6U6REdTqk0YjwXPtQLSElK
         5OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gfnS2N3qsH54HXWCUsy8mbWNITMc7fg3pnFCfzgrCk=;
        b=hezeBTEbdbQ/pqqAmtAExpwB3He9qCTPKlooYHs3v8ywJWbwhVwLP+4bfY9I9BaoDm
         T6yfmbb1MwYXv1ssYtg3/bKr0+cWB7AE8U4FwoZh2DJznLCLjEDaSeFdF6PDNGFVcu/q
         9W6C69l7ZyPYfhg7kgm1i77V1oE6XiMUJja8U9IuyInCSQd7LcfmbzUiotLApT80ZTnX
         RjhbDt5ydR5Wo3Co84UXSUfZUHvbtqbo/PImew7xO48oWrXpP4+fDTEuvNR7yfjzdd0C
         afIUwWnopQOmy6ui91Xe+whIlL/K6btogDQdLp0/20FmUntxrHxG5lJHG93SML63OlXr
         IxQA==
X-Gm-Message-State: ABuFfojGqVuZVVgXdlgnTFNltZAKpPlxCyVgewOKooHvO4L2a2udbj4B
        YdA/SXOllYrRvYG0JCP2LnWYipt4
X-Google-Smtp-Source: ACcGV62owx7h4bxGhPVad0UHwJRopYOtmaOHSjvhLiCzIF//cwBPDdpn8Jsc3jQvBwIj1o6P2bBITw==
X-Received: by 2002:a1c:8fcc:: with SMTP id r195-v6mr3158278wmd.44.1539113712474;
        Tue, 09 Oct 2018 12:35:12 -0700 (PDT)
Received: from localhost.localdomain (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id e6-v6sm18823117wrc.70.2018.10.09.12.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 12:35:11 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] Add a (very) barebones Bloom filter implementation
Date:   Tue,  9 Oct 2018 21:34:42 +0200
Message-Id: <20181009193445.21908-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.409.g0a0ee5eb6b
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Makefile       |   1 +
 bloom-filter.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 bloom-filter.h |  39 +++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 bloom-filter.c
 create mode 100644 bloom-filter.h

diff --git a/Makefile b/Makefile
index 13e1c52478..850eafb3ee 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
+LIB_OBJS += bloom-filter.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
diff --git a/bloom-filter.c b/bloom-filter.c
new file mode 100644
index 0000000000..7dce0e35fa
--- /dev/null
+++ b/bloom-filter.c
@@ -0,0 +1,103 @@
+#include "cache.h"
+#include "bloom-filter.h"
+
+void bloom_filter_init(struct bloom_filter *bf, uint32_t bit_size)
+{
+	if (bit_size % CHAR_BIT)
+		BUG("invalid size for bloom filter");
+
+	bf->nr_entries = 0;
+	bf->bit_size = bit_size;
+	bf->bits = xmalloc(bit_size / CHAR_BIT);
+}
+
+void bloom_filter_free(struct bloom_filter *bf)
+{
+	bf->nr_entries = 0;
+	bf->bit_size = 0;
+	FREE_AND_NULL(bf->bits);
+}
+
+
+void bloom_filter_set_bits(struct bloom_filter *bf, const uint32_t *offsets,
+			   int nr_offsets, int nr_entries)
+{
+	int i;
+	for (i = 0; i < nr_offsets; i++) {
+		uint32_t byte_offset = (offsets[i] % bf->bit_size) / CHAR_BIT;
+		unsigned char mask = 1 << offsets[i] % CHAR_BIT;
+		bf->bits[byte_offset] |= mask;
+	}
+	bf->nr_entries += nr_entries;
+}
+
+int bloom_filter_check_bits(struct bloom_filter *bf, const uint32_t *offsets,
+			    int nr)
+{
+	int i;
+	for (i = 0; i < nr; i++) {
+		uint32_t byte_offset = (offsets[i] % bf->bit_size) / CHAR_BIT;
+		unsigned char mask = 1 << offsets[i] % CHAR_BIT;
+		if (!(bf->bits[byte_offset] & mask))
+			return 0;
+	}
+	return 1;
+}
+
+
+void bloom_filter_add_hash(struct bloom_filter *bf, const unsigned char *hash)
+{
+	uint32_t offsets[GIT_MAX_RAWSZ / sizeof(uint32_t)];
+	hashcpy((unsigned char*)offsets, hash);
+	bloom_filter_set_bits(bf, offsets,
+			     the_hash_algo->rawsz / sizeof(*offsets), 1);
+}
+
+int bloom_filter_check_hash(struct bloom_filter *bf, const unsigned char *hash)
+{
+	uint32_t offsets[GIT_MAX_RAWSZ / sizeof(uint32_t)];
+	hashcpy((unsigned char*)offsets, hash);
+	return bloom_filter_check_bits(bf, offsets,
+			the_hash_algo->rawsz / sizeof(*offsets));
+}
+
+void hashxor(const unsigned char *hash1, const unsigned char *hash2,
+	     unsigned char *out)
+{
+	int i;
+	for (i = 0; i < the_hash_algo->rawsz; i++)
+		out[i] = hash1[i] ^ hash2[i];
+}
+
+/* hardcoded for now... */
+static GIT_PATH_FUNC(git_path_bloom, "objects/info/bloom")
+
+int bloom_filter_load(struct bloom_filter *bf)
+{
+	int fd = open(git_path_bloom(), O_RDONLY);
+
+	if (fd < 0)
+		return -1;
+
+	read_in_full(fd, &bf->nr_entries, sizeof(bf->nr_entries));
+	read_in_full(fd, &bf->bit_size, sizeof(bf->bit_size));
+	if (bf->bit_size % CHAR_BIT)
+		BUG("invalid size for bloom filter");
+	bf->bits = xmalloc(bf->bit_size / CHAR_BIT);
+	read_in_full(fd, bf->bits, bf->bit_size / CHAR_BIT);
+
+	close(fd);
+
+	return 0;
+}
+
+void bloom_filter_write(struct bloom_filter *bf)
+{
+	int fd = xopen(git_path_bloom(), O_WRONLY | O_CREAT | O_TRUNC, 0666);
+
+	write_in_full(fd, &bf->nr_entries, sizeof(bf->nr_entries));
+	write_in_full(fd, &bf->bit_size, sizeof(bf->bit_size));
+	write_in_full(fd, bf->bits, bf->bit_size / CHAR_BIT);
+
+	close(fd);
+}
diff --git a/bloom-filter.h b/bloom-filter.h
new file mode 100644
index 0000000000..94d0af1708
--- /dev/null
+++ b/bloom-filter.h
@@ -0,0 +1,39 @@
+#ifndef BLOOM_FILTER_H
+#define BLOOM_FILTER_H
+
+#include "git-compat-util.h"
+
+struct bloom_filter {
+	uint32_t nr_entries;
+	uint32_t bit_size;
+	unsigned char *bits;
+};
+
+
+void bloom_filter_init(struct bloom_filter *bf, uint32_t bit_size);
+void bloom_filter_free(struct bloom_filter *bf);
+
+void bloom_filter_set_bits(struct bloom_filter *bf, const uint32_t *offsets,
+			   int nr_offsets, int nr_enries);
+int bloom_filter_check_bits(struct bloom_filter *bf, const uint32_t *offsets,
+			    int nr);
+
+/*
+ * Turns the given (SHA1) hash into 5 unsigned ints, and sets the bits at
+ * those positions (modulo the bitmap's size) in the Bloom filter.
+ */
+void bloom_filter_add_hash(struct bloom_filter *bf, const unsigned char *hash);
+/*
+ * Turns the given (SHA1) hash into 5 unsigned ints, and checks the bits at
+ * those positions (modulo the bitmap's size) in the Bloom filter.
+ * Returns 1 if all those bits are set, 0 otherwise.
+ */
+int bloom_filter_check_hash(struct bloom_filter *bf, const unsigned char *hash);
+
+void hashxor(const unsigned char *hash1, const unsigned char *hash2,
+	     unsigned char *out);
+
+int bloom_filter_load(struct bloom_filter *bf);
+void bloom_filter_write(struct bloom_filter *bf);
+
+#endif
-- 
2.19.1.409.g0a0ee5eb6b

