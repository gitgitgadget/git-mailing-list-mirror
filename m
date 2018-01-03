Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BA31F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeACQfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39445 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeACQfM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so3638081wmf.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdbdIGiZIQJkdMCGj5v2ZlPBvIJkNCHLVLHhRxPt1Ww=;
        b=WeRdL07ESS7DCkZRxtYzj0J+kf7Yyx3itQpi8V4DTkz/2hKNiH2FWhLaqeXxcfkviY
         iReRvzGjONTAvuq9KxjJPrjdukvpz8Gv95YPjTj3tX7MTwP/AMGJvaJzQl0DvyqWqQOm
         Z+/yXtMyCqPT4fquI3WXUDimqSctbYHrshpTBTgavgzlO4hgs5ECjHlsqPRqGv6X5Jg+
         EY+H+s4E3mtmPblmqEgKTztTg4yNviQlizr8xhAKsR/CmOKghCRLaJUcj+fUa0lCu5bg
         edKUS4Yf6cRZgBzwPhBPV1PolSNeBB0Z0f1D/MR/MARrSEb2hShGuNX9gZZV0OH02LE9
         iDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdbdIGiZIQJkdMCGj5v2ZlPBvIJkNCHLVLHhRxPt1Ww=;
        b=rlaIa5sR2jQos1AXvYCpU0ZF8iY9BZlxtC3YjCmCheDamwTyQqUTSdMLxWCW12u9sW
         KllL8vRyW3H1+aW6j8O1UzmjFZG2umVZWIx+tw8WrLWlw1uc9Z5O1vCtouTt26EYyDFS
         ajnYyA9XI+HSy2/07v3BiccW3lzw2WEBG9lFM6tb6Y9ORv3LP9zPJlKYotlB1n0W2taQ
         pRSqo2V1Dlprcg+IeuQfsx9ZhRBhIPPsBieS5EFoI6btLzUNTiASTjfBkmIGwp1BIpVh
         ip/lis0cVUaMCTEW804x3ocOOgEghTLU4aYHARWqSN/GPCN2CH+KFTydN1CYPSpFGLtc
         dtkQ==
X-Gm-Message-State: AKGB3mJlflt16Y+tIuH67HZTf8UXEAVUN92HKsk2bT7xfLaX7ucNq5MO
        6KQaYLXwYH8+PoPlWJhwXWAljuNG
X-Google-Smtp-Source: ACJfBosyP/2id3VpS7QuVYpn2/Q2GGKigGpf4wLRsuM6tLyOqWcrCzrTYrN8W59EAlqL9VTLYBMQLg==
X-Received: by 10.28.91.74 with SMTP id p71mr1941763wmb.61.1514997310322;
        Wed, 03 Jan 2018 08:35:10 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:09 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 32/40] odb-helper: add init_object_process()
Date:   Wed,  3 Jan 2018 17:33:55 +0100
Message-Id: <20180103163403.11303-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the infrastructure to launch and use long running
sub-processes as external odb helpers.

For now only the 'init' and 'get_direct' capabilities are
supported with sub-processes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c |  46 +++---
 odb-helper.c   | 474 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 sha1_file.c    |  12 +-
 3 files changed, 491 insertions(+), 41 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index f38c2c2fe3..50c1cec50b 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -81,29 +81,11 @@ const char *external_odb_root(void)
 	return root;
 }
 
-int external_odb_has_object(const unsigned char *sha1)
-{
-	struct odb_helper *o;
-
-	external_odb_init();
-
-	for (o = helpers; o; o = o->next) {
-		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE))
-			return 1;
-		if (odb_helper_has_object(o, sha1))
-			return 1;
-	}
-	return 0;
-}
-
-int external_odb_get_object(const unsigned char *sha1)
+static int external_odb_do_get_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 	const char *path;
 
-	if (!external_odb_has_object(sha1))
-		return -1;
-
 	path = sha1_file_name_alt(external_odb_root(), sha1);
 	safe_create_leading_directories_const(path);
 	prepare_external_alt_odb();
@@ -157,6 +139,32 @@ int external_odb_get_direct(const unsigned char *sha1)
 	return -1;
 }
 
+int external_odb_has_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE)) {
+			if (o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT)
+				return 1;
+			return !external_odb_do_get_object(sha1);
+		}
+		if (odb_helper_has_object(o, sha1))
+			return 1;
+	}
+	return 0;
+}
+
+int external_odb_get_object(const unsigned char *sha1)
+{
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	return external_odb_do_get_object(sha1);
+}
+
 int external_odb_put_object(const void *buf, size_t len,
 			    const char *type, unsigned char *sha1)
 {
diff --git a/odb-helper.c b/odb-helper.c
index 91b4de1a05..a67dfddca0 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -5,6 +5,22 @@
 #include "run-command.h"
 #include "sha1-lookup.h"
 #include "fetch-object.h"
+#include "sub-process.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+
+struct object_process {
+	struct subprocess_entry subprocess;
+	unsigned int supported_capabilities;
+};
+
+static struct hashmap subprocess_map;
+
+static int check_object_process_status(int fd, struct strbuf *status)
+{
+	subprocess_read_status(fd, status);
+	return strcmp(status->buf, "success");
+}
 
 static void parse_capabilities(char *cap_buf,
 			       unsigned int *supported_capabilities,
@@ -40,6 +56,384 @@ static void parse_capabilities(char *cap_buf,
 	string_list_clear(&cap_list, 0);
 }
 
+static int start_object_process_fn(struct subprocess_entry *subprocess)
+{
+	static int versions[] = {1, 0};
+	static struct subprocess_capability capabilities[] = {
+		{ "get_git_obj", ODB_HELPER_CAP_GET_GIT_OBJ },
+		{ "get_raw_obj", ODB_HELPER_CAP_GET_RAW_OBJ },
+		{ "get_direct",  ODB_HELPER_CAP_GET_DIRECT  },
+		{ "put_git_obj", ODB_HELPER_CAP_PUT_GIT_OBJ },
+		{ "put_raw_obj", ODB_HELPER_CAP_PUT_RAW_OBJ },
+		{ "put_direct",  ODB_HELPER_CAP_PUT_DIRECT  },
+		{ "have",        ODB_HELPER_CAP_HAVE },
+		{ NULL, 0 }
+	};
+	struct object_process *entry = (struct object_process *)subprocess;
+	return subprocess_handshake(subprocess, "git-read-object", versions, NULL,
+				    capabilities,
+				    &entry->supported_capabilities);
+}
+
+static struct object_process *launch_object_process(struct odb_helper *o,
+						    unsigned int capability)
+{
+	struct object_process *entry = NULL;
+
+	if (!subprocess_map.tablesize)
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp, NULL, 0);
+	else
+		entry = (struct object_process *)subprocess_find_entry(&subprocess_map, o->dealer);
+
+	fflush(NULL);
+
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (subprocess_start(&subprocess_map, &entry->subprocess, o->dealer, start_object_process_fn)) {
+			error("Could not launch process for cmd '%s'", o->dealer);
+			free(entry);
+			return NULL;
+		}
+	}
+
+	o->supported_capabilities = entry->supported_capabilities;
+
+	if (capability && !(capability & entry->supported_capabilities)) {
+		error("The cmd '%s' does not support capability '%d'", o->dealer, capability);
+		return NULL;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	return entry;
+}
+
+static int check_object_process_error(int err,
+				      const char *status,
+				      struct object_process *entry,
+				      const char *cmd,
+				      unsigned int capability)
+{
+	sigchain_pop(SIGPIPE);
+
+	if (!err)
+		return 0;
+
+	if (!strcmp(status, "error")) {
+		/* The process signaled a problem with the file. */
+	} else if (!strcmp(status, "notfound")) {
+		/* Object was not found */
+		err = -1;
+	} else if (!strcmp(status, "abort")) {
+		/*
+		 * The process signaled a permanent problem. Don't try to read
+		 * objects with the same command for the lifetime of the current
+		 * Git process.
+		 */
+		if (capability)
+			entry->supported_capabilities &= ~capability;
+	} else {
+		/*
+		 * Something went wrong with the read-object process.
+		 * Force shutdown and restart if needed.
+		 */
+		error("external object process '%s' failed", cmd);
+		subprocess_stop(&subprocess_map, &entry->subprocess);
+		free(entry);
+	}
+
+	return err;
+}
+
+static int send_init_packets(struct object_process *entry,
+			     struct strbuf *status)
+{
+	struct child_process *process = &entry->subprocess.process;
+
+	return packet_write_fmt_gently(process->in, "command=init\n") ||
+		packet_flush_gently(process->in) ||
+		check_object_process_status(process->out, status);
+}
+
+static int init_object_process(struct odb_helper *o)
+{
+	int err;
+	struct strbuf status = STRBUF_INIT;
+	struct object_process *entry = launch_object_process(o, 0);
+	if (!entry)
+		return -1;
+
+	err = send_init_packets(entry, &status);
+
+	return check_object_process_error(err, status.buf, entry,
+					  o->dealer, 0);
+}
+
+static ssize_t read_packetized_raw_object_to_fd(struct odb_helper *o,
+						const unsigned char *sha1,
+						int fd_in, int fd_out)
+{
+	ssize_t total_read = 0;
+	unsigned long total_got = 0;
+	int packet_len;
+
+	char hdr[32];
+	int hdrlen;
+
+	int ret = Z_STREAM_END;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	off_t size;
+	enum object_type type;
+	const char *s;
+	int pkt_size;
+	char *size_buf;
+
+	size_buf = packet_read_line(fd_in, &pkt_size);
+	if (!skip_prefix(size_buf, "size=", &s))
+		return error("odb helper '%s' did not send size of plain object", o->name);
+	size = strtoumax(s, NULL, 10);
+	if (!skip_prefix(packet_read_line(fd_in, NULL), "kind=", &s))
+		return error("odb helper '%s' did not send kind of plain object", o->name);
+	/* Check if the object is not available */
+	if (!strcmp(s, "none"))
+		return -1;
+	type = type_from_string_gently(s, strlen(s), 1);
+	if (type < 0)
+		return error("odb helper '%s' sent bad type '%s'", o->name, s);
+
+	/* Set it up */
+	git_deflate_init(&stream, zlib_compression_level);
+	stream.next_out = compressed;
+	stream.avail_out = sizeof(compressed);
+	git_SHA1_Init(&hash);
+
+	/* First header.. */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
+	stream.next_in = (unsigned char *)hdr;
+	stream.avail_in = hdrlen;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
+	git_SHA1_Update(&hash, hdr, hdrlen);
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+
+		packet_len = packet_read(fd_in, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		total_got += packet_len;
+
+		/* Then the data itself.. */
+		stream.next_in = (void *)buf;
+		stream.avail_in = packet_len;
+		do {
+			unsigned char *in0 = stream.next_in;
+			ret = git_deflate(&stream, Z_FINISH);
+			git_SHA1_Update(&hash, in0, stream.next_in - in0);
+			write_or_die(fd_out, compressed, stream.next_out - compressed);
+			stream.next_out = compressed;
+			stream.avail_out = sizeof(compressed);
+		} while (ret == Z_OK);
+
+		total_read += packet_len;
+	}
+
+	if (packet_len < 0) {
+		error("unable to read from odb helper '%s': %s",
+		      o->name, strerror(errno));
+		git_deflate_end(&stream);
+		return packet_len;
+	}
+
+	if (ret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+
+	ret = git_deflate_end_gently(&stream);
+	if (ret != Z_OK) {
+		warning("deflateEnd on object %s from odb helper '%s' failed (%d)",
+			sha1_to_hex(sha1), o->name, ret);
+		return -1;
+	}
+	git_SHA1_Final(real_sha1, &hash);
+	if (hashcmp(sha1, real_sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+	if (total_got != size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, size);
+		return -1;
+	}
+
+	return total_read;
+}
+
+static ssize_t read_packetized_git_object_to_fd(struct odb_helper *o,
+						const unsigned char *sha1,
+						int fd_in, int fd_out)
+{
+	ssize_t total_read = 0;
+	unsigned long total_got = 0;
+	int packet_len;
+	git_zstream stream;
+	int zret = Z_STREAM_END;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+	struct strbuf header = STRBUF_INIT;
+	unsigned long hdr_size;
+
+	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
+	git_SHA1_Init(&hash);
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+
+		packet_len = packet_read(fd_in, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		write_or_die(fd_out, buf, packet_len);
+
+		stream.next_in = (unsigned char *)buf;
+		stream.avail_in = packet_len;
+		do {
+			unsigned char inflated[4096];
+			unsigned long got;
+
+			stream.next_out = inflated;
+			stream.avail_out = sizeof(inflated);
+			zret = git_inflate(&stream, Z_SYNC_FLUSH);
+			got = sizeof(inflated) - stream.avail_out;
+
+			git_SHA1_Update(&hash, inflated, got);
+			/* skip header when counting size */
+			if (!total_got) {
+				const unsigned char *p = memchr(inflated, '\0', got);
+				if (p) {
+					unsigned long hdr_last = p - inflated + 1;
+					strbuf_add(&header, inflated, hdr_last);
+					got -= hdr_last;
+				} else {
+					strbuf_add(&header, inflated, got);
+					got = 0;
+				}
+			}
+			total_got += got;
+		} while (stream.avail_in && zret == Z_OK);
+
+		total_read += packet_len;
+	}
+
+	git_inflate_end(&stream);
+
+	if (packet_len < 0)
+		return packet_len;
+
+	git_SHA1_Final(real_sha1, &hash);
+
+	if (zret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (hashcmp(real_sha1, sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+	if (parse_sha1_header(header.buf, &hdr_size) < 0) {
+		warning("could not parse header from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (total_got != hdr_size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, hdr_size);
+		return -1;
+	}
+
+	return total_read;
+}
+
+static int send_get_packets(struct odb_helper *o,
+			    struct object_process *entry,
+			    const unsigned char *sha1,
+			    int fd,
+			    unsigned int *cur_cap,
+			    struct strbuf *status)
+{
+	const char *instruction;
+	int err;
+	struct child_process *process = &entry->subprocess.process;
+
+	if (entry->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ) {
+		*cur_cap = ODB_HELPER_CAP_GET_GIT_OBJ;
+		instruction = "get_git_obj";
+	} else if (entry->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ) {
+		*cur_cap = ODB_HELPER_CAP_GET_RAW_OBJ;
+		instruction = "get_raw_obj";
+	} else if (entry->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT) {
+		*cur_cap = ODB_HELPER_CAP_GET_DIRECT;
+		instruction = "get_direct";
+	} else {
+		BUG("No known ODB_HELPER_CAP_GET_XXX capability!");
+	}
+
+	err = packet_write_fmt_gently(process->in, "command=%s\n", instruction);
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		return err;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		return err;
+
+	if (entry->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ)
+		err = read_packetized_raw_object_to_fd(o, sha1, process->out, fd) < 0;
+	else if (entry->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ)
+		err = read_packetized_git_object_to_fd(o, sha1, process->out, fd) < 0;
+
+	return check_object_process_status(process->out, status);
+}
+
+static int get_object_process(struct odb_helper *o, const unsigned char *sha1, int fd)
+{
+	int err;
+	struct strbuf status = STRBUF_INIT;
+	unsigned int cur_cap = 0;
+	struct object_process *entry = launch_object_process(o, 0);
+	if (!entry)
+		return -1;
+
+	err = send_get_packets(o, entry, sha1, fd, &cur_cap, &status);
+
+	return check_object_process_error(err, status.buf, entry,
+					  o->dealer, cur_cap);
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -118,15 +512,12 @@ static int odb_helper_finish(struct odb_helper *o,
 	return 0;
 }
 
-int odb_helper_init(struct odb_helper *o)
+static int init_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (o->type != ODB_HELPER_SCRIPT_CMD)
-		return 0;
-
 	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
@@ -141,6 +532,21 @@ int odb_helper_init(struct odb_helper *o)
 	return 0;
 }
 
+int odb_helper_init(struct odb_helper *o)
+{
+	int res = 0;
+	uint64_t start = getnanotime();
+
+	if (o->type == ODB_HELPER_SCRIPT_CMD)
+		res = init_object_script(o);
+	else if (o->type == ODB_HELPER_SUBPROCESS_CMD)
+		res = init_object_process(o);
+
+	trace_performance_since(start, "odb_helper_init");
+
+	return res;
+}
+
 static int parse_object_line(struct odb_helper_object *o, const char *line)
 {
 	char *end;
@@ -435,36 +841,45 @@ static int odb_helper_get_git_object(struct odb_helper *o,
 	return 0;
 }
 
+static int get_direct_script(struct odb_helper *o, const unsigned char *sha1)
+{
+	struct odb_helper_cmd cmd;
+
+	if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+	return 0;
+}
+
 int odb_helper_get_direct(struct odb_helper *o,
 			  const unsigned char *sha1)
 {
-	uint64_t start = getnanotime();
-
-	if (o->type == ODB_HELPER_GIT_REMOTE) {
-		fetch_object(o->dealer, sha1);
-	} else {
-		struct odb_helper_object *obj;
-		struct odb_helper_cmd cmd;
+	int res = 0;
+	uint64_t start;
 
-		obj = odb_helper_lookup(o, sha1);
+	if (o->supported_capabilities & ODB_HELPER_CAP_HAVE &&
+	    o->type != ODB_HELPER_GIT_REMOTE) {
+		struct odb_helper_object *obj = odb_helper_lookup(o, sha1);
 		if (!obj)
 			return -1;
+	}
 
-		if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
-			return -1;
+	start = getnanotime();
 
-		if (odb_helper_finish(o, &cmd))
-			return -1;
-	}
+	if (o->type == ODB_HELPER_GIT_REMOTE)
+		fetch_object(o->dealer, sha1);
+	else if (o->type == ODB_HELPER_SCRIPT_CMD)
+		res = get_direct_script(o, sha1);
+	else
+		res = get_object_process(o, sha1, -1);
 
 	trace_performance_since(start, "odb_helper_get_direct");
 
-	return 0;
+	return res;
 }
 
-int odb_helper_get_object(struct odb_helper *o,
-			  const unsigned char *sha1,
-			  int fd)
+static int get_object_script(struct odb_helper *o, const unsigned char *sha1, int fd)
 {
 	if (o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ)
 		return odb_helper_get_git_object(o, sha1, fd);
@@ -476,6 +891,23 @@ int odb_helper_get_object(struct odb_helper *o,
 	BUG("invalid get capability (capabilities: '%d')", o->supported_capabilities);
 }
 
+int odb_helper_get_object(struct odb_helper *o,
+			  const unsigned char *sha1,
+			  int fd)
+{
+	int res = 0;
+	uint64_t start = getnanotime();
+
+	if (o->type == ODB_HELPER_SCRIPT_CMD)
+		res = get_object_script(o, sha1, fd);
+	else if (o->type == ODB_HELPER_SUBPROCESS_CMD)
+		res = get_object_process(o, sha1, fd);
+
+	trace_performance_since(start, "odb_helper_get_object");
+
+	return res;
+}
+
 int odb_helper_put_object(struct odb_helper *o,
 			  const void *buf, size_t len,
 			  const char *type, unsigned char *sha1)
diff --git a/sha1_file.c b/sha1_file.c
index 8c873554b2..300029459f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -735,7 +735,17 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	int ret;
+	int tried_hook = 0;
+
+retry:
+	ret = check_and_freshen_file(sha1_file_name(sha1), freshen);
+	if (!ret && !tried_hook) {
+		tried_hook = 1;
+		if (!external_odb_get_direct(sha1))
+			goto retry;
+	}
+	return ret;
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

