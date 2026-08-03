Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786174137B9
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768015; cv=none; b=i4C7utEdZh/BG6tJjcq+kXKzJVtk05uh5kSTMaxfaHgrF3c8CWS9qiUZodR8c625N1xOtW1+xHDhTnJ3nZzDcttZRRPztcUYQGWkpLKZeROynWQA8UheEOSKxbFkpyo5nnCS6UT0djGhxIB/movFHenia2915dmGxgVHekYNdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768015; c=relaxed/simple;
	bh=XSFbWYsnTmFGrUIxm2LQfmUo8qK/8l0mkeIJHrtrkPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpIUwiaTr/TsZXTqjoV/HjTZEy6e8++ixz6Of87LEgquhgNj8J+6np9KXT+mAR8YX3C9AC2oRwqR8WLS3x9GIhVDn79FFQmL1CflljaQDW34XyNuDSvLf5g0AzeSPl9Mluok/uyrlzpG8VYVwERt8PENriRe0CEO4/Q2mi9JIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdJrMSJH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdJrMSJH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so15054485e9.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768012; x=1786372812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TGsUM4j9D0gHMYAV855sfdAj5adnOA/4/RyEQoHlWIQ=;
        b=EdJrMSJHEz3nBnYTlRaX61EexcXgMCWLBz9BT4CR8IxZ50wgsS02QDnU76SbVW86Uf
         6XQxYPDn333uc8Y+4x5ArnSgUqwtliNIn4PkKsyfFGofxAIwhDczS6urVH1QhXR729i6
         b1iHUJ1tIn8TW7Pb8k/9XFLLxv+uPe/dnSDHpW1Aq3xhekHxcspPAqdrvtdnYPtZ/mbh
         QhPitJpXAr1tScj8KZXvRV7517OiUjykyo5kBCLQDr0oNpw99DI+2GR8vcyaejs9yuTq
         gguRND3qJE7bn4DBt4NE1+O19HnbUCIiyqc9mDWRCcUH0ncan46CK7D0fUfqIrBetll1
         PwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768012; x=1786372812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGsUM4j9D0gHMYAV855sfdAj5adnOA/4/RyEQoHlWIQ=;
        b=l5MLPT0AlV1JBSUvTPOYbfY0AFBhZL5NZ0aYIYf8b7dDAOIduUwVbEt8/eqAibNA/l
         hlPkosNjD07+CGu3D2T0PuLZhBbqMJb4mZyW8VR9JQ2gdsV3I35fz4vL3SQNd6AR8B0p
         M9Rev7E8MYcFhgdOA/XNAPk0HA4J2CSRx2nKRSOeh8FTF+fCTRAboWv/kLSztrByQNn2
         wqAZlrXoJS1M/qWGnfmrXeAc2yq+CGuNLOhPjAwJ+FPaSiI6RVM6A8XVESDhy/RQfYhZ
         DfMwZs72YT3b/lOaBxu44kjKIk+/7sj/V+5qOC+V2VVHVCtk2J9FTwYa2V9kMBRSNuW5
         s3yw==
X-Gm-Message-State: AOJu0YwRH5q6SGKpsruUxHYXzkniRFeK02yqe4uog6GBAk+R1VlSS4Vk
	LTqu1NNFIQCGar4flUVIDInwv0vjhD/XrZKPFuYBqs2Y0rxbvs8Bv/Kn
X-Gm-Gg: AR+sD10iuYrXr+iNGdME+NBeMBCGr1t6/OHwOYgNKvzJxWQc2BoOt1Y0IhpvAWv92o/
	Syb08V6ygXh6SWDIAsmD4aRnssFWUdiuQ/AHTgoRNRNRHtlhXwPhnVtQ4Ilz2oLK3nAx/qR1z0r
	KHA50VkCZDcxOQuTiRtCvvag+5tVqdNIYSbk/mhsI0n9R4TrczltFwoKc2+pnHfXyGOf4g6ghKT
	kGzdD6m/GDd9b2yLTE663VgzLDCVM8OjsszlqaECjaAC//uBt8eZNmENuyEcuIq9ARJ+gWDFOBL
	RkNejkTaopx/38lU5GhlvjTPCtTsMIpKsdzfAiaHtIh8ZyiGu3XmnnkOW41pQusLCf5rsNN+WsH
	wVgAEYQsNRqheC3yL/qTzRJJzrnQOLZtFJtTBGLIgxrY0CrTHJ8PmG1gDRU8/h+kKrrZiBDLg81
	Qx75Tt5OQdryJdkFpHxSx3MhRpgr8QCG1WGYRCA8hhmU+fBrUxBNObbcsYjsruYs5eIR0lES3KM
	Hy5mrbnVrb0RNaVLGleY7MSJ72TSFsPSU+1IIylPXdF4BmAYa0iVZNNoWVcJb5Zp8MtKMw/ujfF
	Z0HdO8sUidcuoNIkWfbtd3/dtATIos1fWZ+Ql6NPt6tvqDedyD71HZnoLDFSHtFWa3qvILr1E6e
	SrkcwQzuBDiuw5aer
X-Received: by 2002:a05:600d:17:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-4980c653e94mr249559615e9.10.1785768011221;
        Mon, 03 Aug 2026 07:40:11 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:10 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:30 +0200
Subject: [PATCH GSoC v3 3/8] fetch-object-info: pass arguments directly
 instead of a struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-3-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

struct object_info_args groups three pointers that already live in the
transport and are given to fetch_object_info().
Grouping them into a struct reduces the number of parameters, but it
suggests that fetch_object_info() uses all three of them.

Drop the struct and pass those parameters directly to
fetch_object_info() and send_object_info_request(). This should have no
change in behavior.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 53 +++++++++++++++++++++++++++++++----------------------
 fetch-object-info.h | 17 ++++++++---------
 transport.c         | 11 +++++------
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index cdb7f936f9..a8db196928 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -9,20 +9,24 @@
 #include "string-list.h"
 
 /* Sends object-info command and its arguments into the request buffer. */
-static void send_object_info_request(const int fd_out, struct object_info_args *args)
+static void send_object_info_request(const int fd_out,
+				     const struct string_list *server_options,
+				     struct oid_array *oids,
+				     struct string_list *object_info_options)
 {
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+	write_command_and_capabilities(&req_buf, "object-info", server_options);
 
-	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+	if (unsorted_string_list_has_string(object_info_options, "size"))
 		packet_buf_write(&req_buf, "size");
-	else if (args->object_info_options->nr)
+	else if (object_info_options->nr)
 		BUG("only size should be in object_info_options");
 
-	if (args->oids)
-		for (size_t i = 0; i < args->oids->nr; i++)
-			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
+	if (oids)
+		for (size_t i = 0; i < oids->nr; i++)
+			packet_buf_write(&req_buf, "oid %s",
+					 oid_to_hex(&oids->oid[i]));
 
 	packet_buf_flush(&req_buf);
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
@@ -45,8 +49,12 @@ static int parse_object_size(const char *s, size_t *res)
 	return 0;
 }
 
-int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
-		      struct packet_reader *reader, struct object_info *object_info_data,
+int fetch_object_info(const enum protocol_version version,
+		      const struct string_list *server_options,
+		      struct oid_array *oids,
+		      struct string_list *object_info_options,
+		      struct packet_reader *reader,
+		      struct object_info *object_info_data,
 		      const int stateless_rpc, const int fd_out)
 {
 	size_t i;
@@ -65,16 +73,17 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		 * because the number of options is a small known number (the
 		 * supported placeholders which currently are size and type).
 		 */
-		for (int i = (int)args->object_info_options->nr - 1; i >= 0; i--)
+		for (int i = (int)object_info_options->nr - 1; i >= 0; i--)
 			if (!server_supports_feature("object-info",
-						     args->object_info_options->items[i].string, 0))
-				unsorted_string_list_delete_item(args->object_info_options, i, 0);
+						     object_info_options->items[i].string, 0))
+				unsorted_string_list_delete_item(object_info_options, i, 0);
 
 		/*
 		 * Even if no options are left, we still send the oid so we get
 		 * at least an existence check.
 		 */
-		send_object_info_request(fd_out, args);
+		send_object_info_request(fd_out, server_options, oids,
+					 object_info_options);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -83,14 +92,14 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		BUG("unknown protocol version");
 	}
 
-	for (i = 0; i < args->object_info_options->nr; i++) {
+	for (i = 0; i < object_info_options->nr; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
 			return -1;
 		}
 
-		if (!unsorted_string_list_has_string(args->object_info_options, reader->line))
+		if (!unsorted_string_list_has_string(object_info_options, reader->line))
 			return -1;
 
 		if (!strcmp(reader->line, "size")) {
@@ -99,7 +108,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			 * is only size. No risk of overflow.
 			 */
 			size_index = (int)i;
-			for (size_t j = 0; j < args->oids->nr; j++)
+			for (size_t j = 0; j < oids->nr; j++)
 				object_info_data[j].sizep =
 					xcalloc(1, sizeof(*object_info_data[j].sizep));
 		} else {
@@ -109,16 +118,16 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 
 	for (i = 0;
 	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
-	     i < args->oids->nr;
+	     i < oids->nr;
 	     i++) {
 		struct string_list object_info_values = STRING_LIST_INIT_DUP;
 
 		string_list_split(&object_info_values, reader->line, " ", -1);
 
 		if (strcmp(object_info_values.items[0].string,
-			   oid_to_hex(&args->oids->oid[i])))
+			   oid_to_hex(&oids->oid[i])))
 			die(_("object-info: expected OID: %s, got %s"),
-			    oid_to_hex(&args->oids->oid[i]),
+			    oid_to_hex(&oids->oid[i]),
 			    object_info_values.items[0].string);
 
 		/*
@@ -138,7 +147,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		 * the server we expect the server to answer with the same
 		 * number of attributes requested.
 		 */
-		if (args->object_info_options->nr + 1 != object_info_values.nr)
+		if (object_info_options->nr + 1 != object_info_values.nr)
 			die("object-info: unexpected number of attributes: %s",
 			    reader->line);
 
@@ -152,9 +161,9 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		string_list_clear(&object_info_values, 0);
 	}
 
-	if (i != args->oids->nr)
+	if (i != oids->nr)
 		die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
-		    (uintmax_t)args->oids->nr, (uintmax_t)i);
+		    (uintmax_t)oids->nr, (uintmax_t)i);
 
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
 
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 269cebb3f7..316bf917ce 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -4,22 +4,21 @@
 #include "pkt-line.h"
 #include "protocol.h"
 
-struct object_info_args {
-	struct string_list *object_info_options;
-	const struct string_list *server_options;
-	struct oid_array *oids;
-};
-
 struct object_info;
+struct oid_array;
 /*
  * Sends git-cat-file object-info command into the request buf and read the
  * results from packets.
  *
- * Modifies args->object_info_options, on return it contains only the supported
+ * Modifies object_info_options, on return it contains only the supported
  * options by the server.
  */
-int fetch_object_info(enum protocol_version version, struct object_info_args *args,
-		      struct packet_reader *reader, struct object_info *object_info_data,
+int fetch_object_info(enum protocol_version version,
+		      const struct string_list *server_options,
+		      struct oid_array *oids,
+		      struct string_list *object_info_options,
+		      struct packet_reader *reader,
+		      struct object_info *object_info_data,
 		      int stateless_rpc, int fd_out);
 
 #endif /* FETCH_OBJECT_INFO_H */
diff --git a/transport.c b/transport.c
index f0a6a45547..c6df56129d 100644
--- a/transport.c
+++ b/transport.c
@@ -438,11 +438,6 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
 	struct packet_reader reader;
-	struct object_info_args args = { 0 };
-
-	args.server_options = transport->server_options;
-	args.oids = transport->smart_options->object_info_oids;
-	args.object_info_options = transport->smart_options->object_info_options;
 
 	connect_setup(transport, 0);
 	packet_reader_init(&reader, data->fd[0], NULL, 0,
@@ -453,7 +448,11 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	data->version = discover_version(&reader);
 	transport->hash_algo = reader.hash_algo;
 
-	ret = fetch_object_info(data->version, &args, &reader,
+	ret = fetch_object_info(data->version,
+				transport->server_options,
+				transport->smart_options->object_info_oids,
+				transport->smart_options->object_info_options,
+				&reader,
 				data->options.object_info_data,
 				transport->stateless_rpc, data->fd[1]);
 

-- 
2.54.0

