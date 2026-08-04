Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649A418A2F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868986; cv=none; b=HHkOcnRCXhewbbM8qy81h9Ioky/rdXn9kPjduSa89UazfJD10xcCM0rm2neF+5vXcCJoaPDOEWszITBzBnvdfFtf544kPl/L6mmdRLEM1+i0GhdVBg+mUhkucqPjONxC+yU+aiApJSyoeHpjJYfgFUfN89S2CaEyay4z5y1g9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868986; c=relaxed/simple;
	bh=/OV/sojD0YK71B63yfakM86ZVYTR6wLE+2MEM/6Pv6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFHs9DLTjjAK7ai8kzZubdMPevS+xtPmDcTZ3UXjq8LDtr6sgZ1q12UWsXoIqCPt1gN+IpVmc1uhYpVaUP1rra2pdGggRjVBDmJbCC/T84hLZQiKL7LPo1hvoOOSBY4/mAXxr3uOH+F79ByW5QRPNXSDW4nWnn4DtmWovfyGfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh0cnKGy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh0cnKGy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4994c49f588so2062635e9.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868983; x=1786473783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuZm0avdONcYGuG+BA1JIRTjIc0Mot8x+/uZ+uK1EEY=;
        b=Uh0cnKGyM5PEOcbyB8O8XRmDSha6L396Erv7vEQRMgn79JuUarK1baVzhTGGCaRlIL
         u5ANniFw1qZH63I+AK2dLuzvfkl0GIyq7fCyf/Y8325I9mjPRup9INog8c517NdMN5Rz
         yUPm+g/hUy/irgsPKpQwes8Amw2/sBaKtkRNyiexlVMtie3w+Xcn3IPusfcheaC5Xh3a
         0JEylwk65D8dx7sOTUWXivcOtIYkOtEbC7eVxjOMzA0ZtVP4+CPCPc3JPoqn90E2W1S3
         ofPD/zzlPxnxvtfoT3gAv5MieNblaM1ZgzWqe4eK1nAmlnONzdAKeb49HEcOwy4L7yMJ
         MYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868983; x=1786473783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuZm0avdONcYGuG+BA1JIRTjIc0Mot8x+/uZ+uK1EEY=;
        b=d/LNafiW9ypWb+TFhY3xAVYXmVJuEi7j0EANRqkvu1BmsC/xunquI7OGN9lVd62895
         zQYq8tn288GrrOVW/7nGAlunJn8wrhkmYw4YWvsJt2irSAkWjLl2vA077EKAbPGuCTUB
         mfRU3B/TjS+zXX1x1xgY0mjGx5cUQVVFvi81GyTsBb6NgggpjFg/Ii+Im1ntf74/p9XD
         LAmjdaFmzK7LzL59qPVHQl6QoLTgx9zpaMFBT2apCbUDa0vvjTTEhgTcy5WBvExsLFl7
         HNHb3xp52L/uqoicKSXTIXZK0UzuL0f/SvGdaX1zbIuf+aEVY/k0/yEdmAHHjHt7nbXj
         EqOQ==
X-Gm-Message-State: AOJu0YwHf90Cr63lJ16AM/OhZI5QvKKpaeaCpZCBYgTV97l7koY2KmkP
	q4TUy7edB+czxYA5UnOIUUc0G1wS3BxM9iK7HGlmpAAgyJzEN9D3t0bLWbM8vr6a
X-Gm-Gg: AR+sD10WD8qv6i71siJibRTvjXRZWdhxcFVjeO6aL1/LV+jrep57bGp0PVXem6y8v9N
	X/G9ydfFNTVFWJ4UDvKsQydbNazj+t6x/O5ThyhcfoEsuG5mao2TnqWKHSYJf0vxm1eBikhx17S
	WM8VxKjj5VRlo1qkqwifDiKTMu1JHPdlYG/Cw2VcVbm4GVR+hPw9SUeXbDWKTnScsWL8lKv2gOx
	M7BN5oDUUlzD5pxhlAnEueCn5rcejv9mb7YH9YP8B43DJWZwfHIMwV74/R8R+XfOajwZE5nLCWz
	9yMcjM2QNwSV7V0nsUEkj0ktVGhC9zdVud01vuCLDK37Pz/G3Wn5zfo4cZHNKd5xDPVqPyQqx+e
	GD0Ym2zgBkyunPyzxvK0LUJPPLNC/v7Nrrv55KwZuDgr0YRWo0H9WRU3WahK3KyrG9obY65pYiT
	g6oKxqaBg+5cZaPZy7yy/jN1ScbGuxkr+hp01PPPSGRtMh/PqXWC67/25fMCp9eUi9LDAbqC8pE
	3tYBfbhnWwK9LILRIKNdEpCSKU70F9A+nNqhanpFeyHg8iFhuDLzChwGc7mYzGnGcj5JFwleKL6
	btQIHWUlO4h7oVlkQgyhSbIA/qu6FzIIVVT062MkcXaH4Ep3whydeSYn7xZPkWEb51VzD4j6zWB
	xo5PUFXkje5iKZ+TF
X-Received: by 2002:a05:600c:3ba6:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4994e374ad3mr15217295e9.5.1785868982962;
        Tue, 04 Aug 2026 11:43:02 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:02 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:42:57 +0200
Subject: [PATCH GSoC v4 3/9] fetch-object-info: pass arguments directly
 instead of a struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-3-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

struct object_info_args groups three pointers that already live in the
transport and are given to fetch_object_info().
Grouping them into a struct reduces the number of parameters, but it
suggests that the three belong together, when they are unrelated and end
up being accessed as args->* independently.

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
index c2d4bf9403..531610e6f4 100644
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
 	int size_index = -1;
@@ -64,16 +72,17 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
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
@@ -82,14 +91,14 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		BUG("unknown protocol version");
 	}
 
-	for (size_t i = 0; i < args->object_info_options->nr; i++) {
+	for (size_t i = 0; i < object_info_options->nr; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
 			return -1;
 		}
 
-		if (!unsorted_string_list_has_string(args->object_info_options, reader->line))
+		if (!unsorted_string_list_has_string(object_info_options, reader->line))
 			return -1;
 
 		if (!strcmp(reader->line, "size")) {
@@ -98,7 +107,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			 * is only size. No risk of overflow.
 			 */
 			size_index = (int)i;
-			for (size_t j = 0; j < args->oids->nr; j++)
+			for (size_t j = 0; j < oids->nr; j++)
 				object_info_data[j].sizep =
 					xcalloc(1, sizeof(*object_info_data[j].sizep));
 		} else {
@@ -106,19 +115,19 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		}
 	}
 
-	for (size_t i = 0; i < args->oids->nr; i++) {
+	for (size_t i = 0; i < oids->nr; i++) {
 		struct string_list object_info_values = STRING_LIST_INIT_DUP;
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
-			    (uintmax_t)args->oids->nr, (uintmax_t)i);
+			    (uintmax_t)oids->nr, (uintmax_t)i);
 
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
 
@@ -154,7 +163,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 
 	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
 		die(_("object-info: expected flush after %"PRIuMAX" objects"),
-		    (uintmax_t)args->oids->nr);
+		    (uintmax_t)oids->nr);
 
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
index 42b0a2d0bd..2bb5eedc32 100644
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

