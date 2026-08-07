Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32945C6FA
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140445; cv=none; b=bjtA087OxQ3GMfmZ/hP+9UuGrwfcmBequmxT61MRSU05vvj3eWZNVsRzIc4p/gNAwpgKvpVsv96CrEF29AK5Tvq1zfR2XgjRrZeuS/LAKXuEBTieodI9xVB6K5/TPAjA4dbOZuvJg36JvBV47E9/GKGZfBD9/YmaqW508z5vnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140445; c=relaxed/simple;
	bh=yrwtFzCEchDcYbpCMA22ITQs1onEecI2QIY2CA3kfpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYP8d1F3e8BKpCJETgYUUXF5R7uufW/Ziu2nkwTZHmdh5vJA4aVGnuHBLYahrWAHBNAxMa0XSt0Ls33ex9Y8BAfMnAr8j0+8jUzHhfVsYr40e4NrOmFEEPgGHERjJin9x6FvIaIeXuBiMDkG3Qi5+0dK92IXks9kNCg0XLT/QGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMRGfmLz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMRGfmLz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so327025e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140442; x=1786745242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KykNgSNJwBlEShYvNjntr3w8A++rwDV9EWIiCa/y7vw=;
        b=tMRGfmLzqkr84Pte6/nvGIrQQOz2O+xY/aLLqxakcJ6oxGvASIWB316Rzh7K3eCV1A
         E3ZIBEVaHJODl4oBhlBRQArEvUlDYANRb8zdFPxkfj7ZhmPjka57S0LB9glGGs06Qb7g
         kaeMTTe4HNtz3tWHsyAhP5HUk7+ODyn+tNZTCQqZtm1N5ogeisLxumykUHbSOuyu7Xou
         HFX7fWaR/xUVn1ZpdQolf1Co91nDnufz5AjfD2zoL7Z2eLtk5vQMwlNFqTEQ87jNzJfU
         iI1WupGQV+9UNOQoEElkS4siGott1luYM5ZoQ1xDsZ9X7QUTuZV7Lb7DWhWGx5YaI1E1
         ZlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140442; x=1786745242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KykNgSNJwBlEShYvNjntr3w8A++rwDV9EWIiCa/y7vw=;
        b=Zo/Wpmkzx1TMp2z8nYrDy+qFW+VIKU8uCUsGbl58w12SjywSIYoWuRM0FPDyXT3cUX
         D/q+28R88Kt7JtK+D0GlEOZOENa+lAnLraNsNEEaKtlV3GGhV5/GHGNRzAsH/PovUpmm
         IYD/rjtBjA/O7Ch/NlGCx4blkxvyyPJAWqpMXEjzVKvofUi/6Hk7wEJD8ZlplGEFL+Oo
         MAge+lL9SzHJ+F+iSCZFfMAAC55Jtdcrx1r5ecjv8WzQibEdINCGxj5noO56nOYchEpb
         5lMXmgqfyGu/tC9HGnzMnlIp2u5j71sY42W78NwklZtfITsezt3f+ifNsCOc2PXwnjUD
         3GJQ==
X-Gm-Message-State: AOJu0Yyes0zKVYfZi1CUvvjfZr/BQJsHDy32tLWGG5BAnlAh2L1GrfAw
	M1j25kLmKAkI9CiUTppdU+zIEFeR3DcobueqE9BwX9H2yef4LLOddMru
X-Gm-Gg: AR+sD12tSQQFjYIFJp0w9uLWECgiqU9RxsWOQF6+8E2oZuGOmkRJty+WGeAbSY/g5uG
	Fx8HWwSNIkMy+67qXWVehnqrTMqJlz/BoecIG5/T0rbXN3AFalOYlfZx9OLCULY6NK2hV4LmVNq
	8y9/+zBy/6PjZjprMNy0fQIoSRdNUXtsJ7xUVXOROOCDOOnJClaZJ38/unb7GhaDFjVTjHJpmLm
	cEk+K1Mfx3My8esaRRVOj7ub/AJqz5HcDJkHwCkUqZfPSWwCPVUzud9Ey/czppgYcSmnw7UI55X
	HWX7scXhwD33dJUP8e4ngyAvRBOzQKQ9rnG5rincXE3X1x84Tnt7Fd+WBzRbBhExZOiFVB/pjmi
	rI4toQpegB3fgYkJAq2mfAlM36CBEhMDWxY79tlrsKEdrbzCJfyEby5hfFu4zwDiEi1l1jOibkb
	+r0EJQXeGs9GQZEzmvkCMPKaNkmitSqq4ttzLXxydJgcltKphJLF+r98TVLcHQIM1YfdUzW/AVk
	xayCLIswQihOuYLrc8gSN6rX72kVi1yQtWj8YX3Yt03pPVfwTY/EzOR3SdAPaecYm0BZekvmjq7
	KBsSJ6R3dwAXFGbRAnAj2y4hprL7uSmcbKYI+jU/bhLKtBGgezKq+fv+X4L+0ATGPQieGROt0rE
	cnPPXeRDnhghxqqqJidwlc8rsfIfCCs/KW8t+HB281hKViOnWPllzP8zeml1VhhqNTtY3
X-Received: by 2002:a05:600c:470d:b0:499:53aa:a86a with SMTP id 5b1f17b1804b1-49953aaa86fmr201301935e9.13.1786140442100;
        Fri, 07 Aug 2026 15:07:22 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:21 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:07:01 +0200
Subject: [PATCH GSoC v5 06/10] transport: drop remote object-info fields
 from transport struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-6-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

From: Jeff King <peff@peff.net>

A remote object-info request needs three things: the transport for
contacting the remote, the list of oids to request, and a place to store
the output.

Rather than take these as function parameters, we take only the
transport object, and expect the caller to have placed the other two
into special fields in the transport struct. But this doesn't make much
sense. The set of oids and results are really only valid for one
request. There is no reason the transport would need to hang on to them
outside of the single function call.

Even though we save a few lines passing the parameters around through
the various vtable functions, the result is harder to understand (for
example, who is responsible for cleaning up results, and when should it
happen?). It also opens up the possibility of a subtle bug. A caller is
likely to point those fields to stack variables which could go out of
scope, and the transport struct would be left holding invalid pointers.

This is mostly harmless now, as we disconnect the transport immediately
after the sole caller of transport_fetch_object_info(). But conceptually
we could keep the transport open and make multiple fetch calls (and
reuse the same connection to the helper, to a remote HTTP server, and so
on).

So let's pull these out of the struct and pass them as function
parameters. It's a little more verbose, but I think more clearly
illustrates the intent. I've also tweaked a few function signatures to
mark the input oid array as const, since it is purely an input to the
function.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c   |  6 ++----
 fetch-object-info.c  |  4 ++--
 fetch-object-info.h  |  2 +-
 transport-helper.c   |  7 +++++--
 transport-internal.h |  4 +++-
 transport.c          | 14 +++++++++-----
 transport.h          |  7 +++----
 7 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e1650b2921..8dcad2f5eb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -724,10 +724,8 @@ static int get_remote_info(int argc,
 		goto cleanup;
 	}
 
-	gtransport->smart_options->object_info_oids = object_info_oids;
-
-	gtransport->smart_options->object_info_results = results;
-	retval = transport_fetch_object_info(gtransport);
+	retval = transport_fetch_object_info(gtransport, object_info_oids,
+					     results);
 cleanup:
 	transport_disconnect(gtransport);
 	return retval;
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 7a337a6857..f269a5d8a8 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -11,7 +11,7 @@
 /* Sends object-info command and its arguments into the request buffer. */
 static void send_object_info_request(const int fd_out,
 				     const struct string_list *server_options,
-				     struct oid_array *oids,
+				     const struct oid_array *oids,
 				     unsigned ask_size)
 {
 	struct strbuf req_buf = STRBUF_INIT;
@@ -49,7 +49,7 @@ static int parse_object_size(const char *s, size_t *res)
 
 void fetch_object_info(const enum protocol_version version,
 		       const struct string_list *server_options,
-		       struct oid_array *oids,
+		       const struct oid_array *oids,
 		       struct packet_reader *reader,
 		       struct fetch_object_info_results *results,
 		       const int stateless_rpc,
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 97ee5314c9..10cf9f5f63 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -26,7 +26,7 @@ struct oid_array;
  */
 void fetch_object_info(enum protocol_version version,
 		       const struct string_list *server_options,
-		       struct oid_array *oids,
+		       const struct oid_array *oids,
 		       struct packet_reader *reader,
 		       struct fetch_object_info_results *results,
 		       int stateless_rpc,
diff --git a/transport-helper.c b/transport-helper.c
index b109fbd8c3..e729a097de 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -784,11 +784,14 @@ static int fetch_refs(struct transport *transport,
 	return -1;
 }
 
-static int fetch_object_info_helper(struct transport *transport)
+static int fetch_object_info_helper(struct transport *transport,
+				    const struct oid_array *oids,
+				    struct fetch_object_info_results *results)
 {
 	get_helper(transport);
 	if (process_connect(transport, 0))
-		return transport->vtable->fetch_object_info(transport);
+		return transport->vtable->fetch_object_info(transport, oids,
+							    results);
 
 	die(_("object-info requires protocol v2"));
 }
diff --git a/transport-internal.h b/transport-internal.h
index 60db0bedcd..e7ead5d785 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -51,7 +51,9 @@ struct transport_vtable {
 	 *
 	 * Uses object-info capability of v2 protocol.
 	 */
-	int (*fetch_object_info)(struct transport *transport);
+	int (*fetch_object_info)(struct transport *transport,
+				 const struct oid_array *oids,
+				 struct fetch_object_info_results *results);
 
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
diff --git a/transport.c b/transport.c
index 35acdf71a2..25e2c14a7b 100644
--- a/transport.c
+++ b/transport.c
@@ -433,7 +433,9 @@ static int get_bundle_uri(struct transport *transport)
 				     transport->bundles, stateless_rpc);
 }
 
-static int fetch_object_info_via_pack(struct transport *transport)
+static int fetch_object_info_via_pack(struct transport *transport,
+				      const struct oid_array *oids,
+				      struct fetch_object_info_results *results)
 {
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
@@ -450,9 +452,9 @@ static int fetch_object_info_via_pack(struct transport *transport)
 
 	fetch_object_info(data->version,
 			  transport->server_options,
-			  transport->smart_options->object_info_oids,
+			  oids,
 			  &reader,
-			  data->options.object_info_results,
+			  results,
 			  transport->stateless_rpc, data->fd[1]);
 
 	close(data->fd[0]);
@@ -465,11 +467,13 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	return ret;
 }
 
-int transport_fetch_object_info(struct transport *transport)
+int transport_fetch_object_info(struct transport *transport,
+				const struct oid_array *oids,
+				struct fetch_object_info_results *results)
 {
 	if (!transport->vtable->fetch_object_info)
 		die(_("remote does not support object-info"));
-	return transport->vtable->fetch_object_info(transport);
+	return transport->vtable->fetch_object_info(transport, oids, results);
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
diff --git a/transport.h b/transport.h
index 6948b65db9..39193d0077 100644
--- a/transport.h
+++ b/transport.h
@@ -57,9 +57,6 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
-
-	struct oid_array *object_info_oids;
-	struct fetch_object_info_results *object_info_results;
 };
 
 enum transport_family {
@@ -317,7 +314,9 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
 /*
  * Fetch the object info from remote
  */
-int transport_fetch_object_info(struct transport *transport);
+int transport_fetch_object_info(struct transport *transport,
+				const struct oid_array *oids,
+				struct fetch_object_info_results *results);
 
 /*
  * If this flag is set, unlocking will avoid to call non-async-signal-safe

-- 
2.54.0

