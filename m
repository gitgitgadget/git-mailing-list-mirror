Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7AF1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 23:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfGSXJU (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 19:09:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42531 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfGSXJU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 19:09:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so24475620qkm.9
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 16:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sK6oRj88RopfGSLmDBaFIhdoCi5ioBLr8L3lZ5OJ7mI=;
        b=Z/2BbhyRaCMqHZ46/AzmoMF0JcCukSEFNnuRaoF8L1Ubfy1dQAp2umSs77L/bmcoD5
         NeCWR0a2IRMxoSalckIRrDRQMopPoFS2sOqsGLMjinP5UmpAANzF2xqRStO5ykK/Agjn
         tLqYf5RKl6ENibWlNPOGdFAC/NfPafEsLl1AlXR/f1krci54dlJGkJwDSmQk96vbAHfX
         kiQzEw+Yw3V+q00ZrJDc76RZz8FLLdj9nqw9weuTSFUTMchqvjDL4m5FAVsGX3utbw5H
         H23SHg0Moh9tpHq5pNBxblGHOWYFoFNRwAF4Hc880Rpkc9IZgV0w31Y7etAP3vRPhx16
         1pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sK6oRj88RopfGSLmDBaFIhdoCi5ioBLr8L3lZ5OJ7mI=;
        b=RJSxHxpp/zOCd7aZVjfoUlxiDfm1oHmxFzF0nWbhDrfPYgFO09f/B0q3k2HzkRlnV4
         m07460p09ZH4CTGmkauk42NN2dBAhN7TLdZV+STcFkMkAxdbrX/8qqWvLbDkY6LJjo6X
         DWeLHkfYNvQVCe+WUxSkqc/DnqUn+aeAFJtbty5pQm6rOlmK5rhRjfggApgiFqyqsE95
         LG2AbMPdwHbET8uaNOGRZisU2/8xysn3Mt94b1fg0/wCMo2WntyASXzpISvKytaG0DXV
         yCXVyWHYoe7LhTOr/TUlZAEgiRKs4aHWeMqRZamXFheEM6O6shL2yDHfhM3yFM7k0+Mr
         LaLA==
X-Gm-Message-State: APjAAAVvNpPfCMk5r1E2euXPpMv8HwTXeSRSLHRMk3Tz6xhPeY+dqfDa
        JCkeQQN4Ry0L15PDmu/tB18PECxsW3Q=
X-Google-Smtp-Source: APXvYqxMPAfgHpKH/3dpz2mv7KlpBlM434yua4crBlKoWsQCIVdm48pnkTMLo5IrMt1j4B18lQJYJw==
X-Received: by 2002:a37:d245:: with SMTP id f66mr37252573qkj.59.1563577758778;
        Fri, 19 Jul 2019 16:09:18 -0700 (PDT)
Received: from localhost.localdomain ([170.82.202.216])
        by smtp.gmail.com with ESMTPSA id s127sm14469035qkd.107.2019.07.19.16.09.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 16:09:18 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][RFC WIP PATCH 1/3] object-store: make read_object_file_extended() thread-safe
Date:   Fri, 19 Jul 2019 20:08:52 -0300
Message-Id: <1525a0b55c4dddef09c9ea8ed26def21a3e790aa.1563570204.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563570204.git.matheus.bernardino@usp.br>
References: <cover.1563570204.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow read_object_file_extended() to be called by multiple threads
protecting it with a lock. The lock usage can be toggled with
enable_obj_read_lock() and disable_obj_read_lock().

Probably there are many spots in read_object_file_extended()'s call
chain that could be executed unlocked (and thus, in parallel). But, just
to make sure, let's protect everthing for now, and go refining the lock
step-by-step in the future.

The only (and perhaps most important) exception is git_inflate. Since it
is already thread-safe and takes a significant amount of time, the lock
is released when entering this function, so that it can be performed in
parallel. This should already bring good performance, because of
inflation's time cost.

Note that add_delta_base_cache() was also modified to skip adding
already present cache entries. This wouldn't happen in the past, but now
it's possible as phase I and phase III of unpack_entry() may execute
concurrently.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 object-store.h |  4 ++++
 packfile.c     |  7 +++++++
 sha1-file.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 49f56ab8d9..8330ff3988 100644
--- a/object-store.h
+++ b/object-store.h
@@ -157,6 +157,10 @@ const char *loose_object_path(struct repository *r, struct strbuf *buf,
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
+void enable_obj_read_lock(void);
+void disable_obj_read_lock(void);
+void obj_read_lock(void);
+void obj_read_unlock(void);
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
diff --git a/packfile.c b/packfile.c
index c0d83fdfed..a50be4e5e5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1087,7 +1087,9 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1440,6 +1442,9 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
 
+	if (get_delta_base_cache_entry(p, base_offset))
+		return;
+
 	delta_base_cached += base_size;
 
 	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
@@ -1569,7 +1574,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		if (!stream.avail_out)
 			break; /* the payload is larger than it should be */
 		curpos += stream.next_in - in;
diff --git a/sha1-file.c b/sha1-file.c
index 888b6024d5..37cde4a494 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1463,16 +1463,49 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	return 0;
 }
 
+static pthread_mutex_t obj_read_mutex;
+static int obj_read_use_lock = 0;
+
+void enable_obj_read_lock(void)
+{
+	if (obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 1;
+	pthread_mutex_init(&obj_read_mutex, NULL);
+}
+
+void disable_obj_read_lock(void)
+{
+	if (!obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 0;
+	pthread_mutex_destroy(&obj_read_mutex);
+}
+
+void obj_read_lock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_lock(&obj_read_mutex);
+}
+
+void obj_read_unlock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_unlock(&obj_read_mutex);
+}
+
 /*
  * This function dies on corrupt objects; the callers who want to
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_object_file_extended(struct repository *r,
-				const struct object_id *oid,
-				enum object_type *type,
-				unsigned long *size,
-				int lookup_replace)
+static void *do_read_object_file_extended(struct repository *r,
+					  const struct object_id *oid,
+					  enum object_type *type,
+					  unsigned long *size,
+					  int lookup_replace)
 {
 	void *data;
 	const struct packed_git *p;
@@ -1505,6 +1538,19 @@ void *read_object_file_extended(struct repository *r,
 	return NULL;
 }
 
+void *read_object_file_extended(struct repository *r,
+				const struct object_id *oid,
+				enum object_type *type,
+				unsigned long *size,
+				int lookup_replace)
+{	
+	void *data;
+	obj_read_lock();
+	data = do_read_object_file_extended(r, oid, type, size, lookup_replace);
+	obj_read_unlock();
+	return data;
+}
+
 void *read_object_with_reference(const struct object_id *oid,
 				 const char *required_type_name,
 				 unsigned long *size,
-- 
2.22.0

