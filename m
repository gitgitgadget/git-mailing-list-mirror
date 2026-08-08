Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123B76026
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147355; cv=none; b=DgAXEZJNURFA22SD8QE0Xh1wz2ziRYcu3hOnC963WHYN4KOTCOz8Aruy21Qrx0omjejA66wpVBptVHKV0BBNoto58W+9X1w70azb+L2se1EM0zSXWMA8Ufz+jK9X152M1VUgJP+8CCZ31WywhMgqd4xoTE9dLC1/FF4LgDlL0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147355; c=relaxed/simple;
	bh=M07/+AqfIR8b3Qw886wpi/b03waDmuatO9YmsjhqoaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grxABlx/+h4IE/NMKJOA2Hg90z5xNfaj4V8PkfMXXwp47+k96eSfxFGOuiTmJxn4wGnAqX/zx1mf+7JvyvxyRAs0zvSWNDCLY3iyKQY7rbaUVPxgnlOK88L3FMqSuDOHlEj3hCVi1/rXgxuVK9zCeoFvkEmdmHqPCamjP+qhqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktUNJCrV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktUNJCrV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso19436935e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147352; x=1786752152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qcz57JL1z6mNZ39aCKpjk9p+7WX1SNeZrHeHLAkSY8=;
        b=ktUNJCrVThhlBF7VHchiNqAIk+iaBpzrBooHBVwkRPvT8LsXR2rbpSjbywx7cynYDS
         HiTOcjcJY1aanPVoIXLgKyS/1WdJ8eykOpTAZiq2ucVcSvrDVdh+efZaumeRlYCYMa8j
         JTfmSOMY21WoV/LXQfDae/BvSI8JeTyGiVs6j7JKBX3iLCoOywaOfq/KAv/eH1ZYFOKC
         iI3HBvaZQK1lQMWFzhrxVWgUAHufQO2P7nFbyap5dfgNsiQbj7I/uoE4wfUTXSaSXWhb
         ueWUsvRtygotUJ8QU8hfZnmnLSIs9mDRKSZfXIhVAzhMWMPY8X5qrtyF8DLMsGYP2jct
         9gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147352; x=1786752152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qcz57JL1z6mNZ39aCKpjk9p+7WX1SNeZrHeHLAkSY8=;
        b=JF5cFq2WqYQjU+3JacKNzdYeORnpvUWuqy23FBRukg8CQLywougsRXBCuPggdoztnm
         X8/bqCBC30Zl/jmy1D4tH5ACvaxBe+nBRErK+RkqmzrGa439HW3V4XvFnh/2zrr5W1AG
         rPQQyfpjktwM3kTbqkDXOMF9TNcoFzC6a8ljHicmnYr2d1V/zc4LMekvmTOzsd+l1EOs
         7oPHLVqDF3TlXCaOs49XAX+oeUZciM8DEx+g6c5jYIgFA6BCKR0RHQAAsluo7zDdLM5w
         TSRwBrSVqS+5dNKR2ql0K6OjwvmwaByVuqADV9gcfqwPHsty5vU1R76LpjYsIpagFrR8
         JEGg==
X-Gm-Message-State: AOJu0Yzphxz+eJZd6nf5CLL9cf9XC97O1z//G/0QHF2u6Pa5QVa0MpZW
	fKBZqN07VPlRc9cImhlR/hrjeriNc4YDN99LUhhm7+GcbOqyTvqozng6
X-Gm-Gg: AR+sD117XP36QWodCrt8RxuRD747x6oBhbVMzI2R7LizmyKAf904NwdoZ00bVU+3wKF
	9juyGaS4uktor7aqA52tUT0D5ilsZVloPsCOMqduuL76ysXXki6W30+rUZ0frFCjC8ZGsMshlXa
	zgcopc0BndzoswXbos/mZkuxIixxU0B2Q/eH+fVU6OCJyGpVE2j3HEnOvDEuFkhALMZtMbBrtOT
	f03jEL78WTaFeRA5f0oF7RawMgz+DgxWX/Lejh/Y6i+4l5qNqf6tmMVePtEv0iBpHgptQSi/aHP
	MgUBKnqMQf2jRiFGYJ+/c6EpurTg+7NO9NmwrbW5Y94DMlUgKeasWBHOdoL11aJ1tmdzb79A3rp
	M8t2JxnBbVKd4/ogKcDbdftG6a9NOKd3kaOjUScAW0/PRAol9hwTjwusiQKnZRvewsex9FrDF6A
	JS84viFgdclKNduRHNH2MVMYAJRkmLm7IvTXxQjATtiWRpq3xElxkYxVNX16F6AkO29atQnJn9t
	lW42tpPB3eVBNw/hHqarfnVg8Zq++vssQTl3NcM3de27gfOZEa2J07agDgI23pxjq+V/79uIjhs
	CzUDYKYaxRa2hw6Hdkgb/ftAFUfk+VcuGjV1200dnmwbUujXLkojvAZyBRcePF0KQfVizewikUY
	yGb9sXAwUx5yMiaFA85Q9Qurjy52vIO+rDiHtXSMxU9YTGEXy67YcrYgnzGkTaYH5l4df1vowWd
	rZDfo=
X-Received: by 2002:a05:600c:3b10:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-49962462c19mr18843475e9.5.1786147352392;
        Fri, 07 Aug 2026 17:02:32 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:31 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:21 +0200
Subject: [PATCH GSoC v6 06/10] transport: drop remote object-info fields
 from transport struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-6-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
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
 transport-internal.h |  6 +++++-
 transport.c          | 14 +++++++++-----
 transport.h          |  7 +++----
 7 files changed, 27 insertions(+), 19 deletions(-)

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
index 4db879c2dc..fe26bf4bbc 100644
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
index 60db0bedcd..a10b27cc81 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -7,6 +7,8 @@ struct ref;
 struct transport;
 struct strvec;
 struct transport_ls_refs_options;
+struct oid_array;
+struct fetch_object_info_results;
 
 struct transport_vtable {
 	/**
@@ -51,7 +53,9 @@ struct transport_vtable {
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

