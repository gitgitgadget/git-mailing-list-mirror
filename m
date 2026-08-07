Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184E45A2A1
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140440; cv=none; b=RMWEWxVSJ0e0I9XyIWKSgiTgMeM/qOwLY0CtFwREgKMfD5fopIxmMGdIzITNXCybaj2lZwz6755qK4SHfNid2mm6f77+ZXqigxGgE1uo/C86FvBwfN9ZCCo+CIiiAWjoqA5amJHl7ukCzFHeZ6lm+z0tgeYbIE/ylLJEkNcB8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140440; c=relaxed/simple;
	bh=/OV/sojD0YK71B63yfakM86ZVYTR6wLE+2MEM/6Pv6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS1i4Viw56tuubmyZr25H0t2kOqcR/7M9Y0+GYCGuziEKTNcq9FfUg9z8lclPgMAZBHGAHDYz2hdC2q4Abw8zNlr97rSIwg25B4ZZ+vdQmkllytLEu2yIlW3YdkEtXHLXreWsamvnkPrvbDbMfVRGTqwIlgfQGkcRLI9hdB7JVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1P1it0/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1P1it0/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955de8797cso261265e9.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140436; x=1786745236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuZm0avdONcYGuG+BA1JIRTjIc0Mot8x+/uZ+uK1EEY=;
        b=d1P1it0/OVzxlQfpUxZtPzxq6N4hNBX6SOooLGnsEFCQXMu9MHpegNJdzNDSsNci9P
         gXWMu1bmJBOzBVbANO0wjxinjkanAuskIcmc3WaYfjqOA5Mw78ezAOp//MOcGUrI4qQT
         25RSG+fSmCqO85JZ09AlZctZQlqX5V8jFlv1u4101ljk7WkVxi4r+x2aYbQVtec0NxZd
         ZcDBej4J458/j09V6c1gOYLZi6JOwkDyMAEXfvDOAQyKs19bVfN7zJtvgAw3CZU1O+uj
         ndZzDjm+g/NbcvZCDh9f4O0rhLcJ+9ICxWasJCgsx74bFfr/92jJeR4nwAYhK6jYevIS
         Tjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140436; x=1786745236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuZm0avdONcYGuG+BA1JIRTjIc0Mot8x+/uZ+uK1EEY=;
        b=JKn7zdOMjdgu9RsO7kO0p30wcfUcOI/YGZuRr5dsTg8zPm2Ek3lleuNBuNROXz7Jbj
         ZNQT8Yqm4Yaqqqt4xx9D6SQVAZQ3e77qODgc8/azuHo5X96wQabtJhRlS2NTCba1UHqp
         hWDKfTuYtSvpGNr+mpQPnmUxiPAiLWNTRbLPihdqsImtpKenXiIadU6YNB5OfplFv2PG
         10iI0M4M7Imdk6Em4IPatrFWMmD+Po/xouGNqYU6RTM3n2w08nMSmGimOQgpOxc8qVW9
         ByBu09YP1CBXCIDTVyNuO49iT8uWYzV+7s4nIrG6e500Igd6HjHSi/6rfMsfUgTWSmoM
         oQ1w==
X-Gm-Message-State: AOJu0YyWqV0EVCDcnx0BW+cOCbAbzmtD31suJi6qvU3upbS2oKNH3dns
	cWLhk86/yqHmJlHQaq7Jk4dI6BB6BvY+uqgHwK1tlzUDkoHX/y7/UQUN
X-Gm-Gg: AR+sD11d2DM161Sy5JhlX69GC4hiiV7XL/quQ+fKDUGp3fjFswg0FBY+f2aq+CiwNUa
	8BNWrfF8wkWWCzIjPSYQbb6YkIwVl7v+5Yo3P26XgtWxEiJnslwhsKIofuYrblz/dFNINAx/1n/
	c0mvrbCx5SGydXttEL9n3YFdIQAGrSMMcJX1zSs5NH4bYwnLjmkHnNwdB1rFci2Z8/JF1j0wkLK
	rkMLOV/UnWVr315Rg3rJCPYhmCVSsqqNPr0+FavyR16nLANmcgRMPMIHAgodANay02kUmdfAAQ1
	VsSMG+j0SD1xdu8QJJIxh/7WJ2UUdhjT2EvTyDx+b3HXa/DodGBLLU/F3KnzsXHUG6coxTdKscD
	LcdqS9UYLc+G3CyMDiLms6fbxoKznOUc7aLYQ/Vw2mRhzJDSrUMCS1S/9u7jwBmtErDxMuAggbN
	UWaC931OkLZJGYNmRD8PkO6j/RASDB+EhTQsB+Ip4Q/pXnSraIh/FLiL+ZG9SsFbKiKE/9t+Zus
	yCjEneBeoSjRTytfq4UhweZ1F3OkftLUVk62Nam6J6R7CBeBKnL1PA/6QrEIPPqFiBRlCTFIm5b
	DRx34F0TkYCDLKo4D1a+N2StZpO1g6uo01QeoqllWbSTVdp07h+rck4fMgw2tMmjH6+IFsPZXTQ
	VDaqCcEVtTyWe5gTahotFE9CGv/aYZlNcUkjOvdM59bYa/PKYNGnfzFee4e6+v4re8xs5
X-Received: by 2002:a05:600c:3548:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4995e0def7bmr87422865e9.14.1786140436192;
        Fri, 07 Aug 2026 15:07:16 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:15 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:06:58 +0200
Subject: [PATCH GSoC v5 03/10] fetch-object-info: pass arguments directly
 instead of a struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-3-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
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

