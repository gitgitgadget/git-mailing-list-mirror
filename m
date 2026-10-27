Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071018;
	b=RiRgYJpwmxwelke2qlR9LXXSdMUDLi4CQk7r+oc6AI/exd+q7ztDwTvwG3WyP4ejH6bi
	 D2X5RM9yXNfTJIqwPttaYV+aApGIdxFxCnBCNt/d+Bw+zb1WGPKdnVgh2FcTXgDgDK7+J
	 mGZl0auHzZMI06mFqC+qCln/TdxRc4yMKgMuGPRBSfFNnbzY8TjvfvbAOILnpDK2vmv5+
	 ikTHI3oCx99tWYnb1bT/Hxq1NsNfprVpvw5ONg7OOARlrkoxvQL7QR+U7B1At9KnsH2jq
	 hJRJ/7npsu4wC+2SuG/OWeSK/A3MxIz3gtYs+Oo7j4uVPDNuWGGHvjXekNSyLl1Al9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=LQ+242XXpF4XYTgroATD+gR1LZaxLFb4lfgsfyrn/z4=;
	b=gLyGCz5F/DXK0D8qbDaP/4wPvScEJOieo9FwUztbKTuxFmLaDEtUGS0pCXaOxtYj73u1
	 gd9wCjkReLTYUnzL7lCqhlombVEjnH6LDAMLHCbome0cXydqGlgp8lfDAbLvdri19EM+E
	 iVAJdlmHJdgmm+LlLA7wu8jc2jLBX4/DdBQkp+Iexf4U3EYskfRlILukYBVJMWyPDYkUy
	 eJi//2O3k0+wLfpOpITGOwcsNLISnmcKMoptxnvALPp6jefJSgEkRKrTE+l9x4phtTr9F
	 DFeiQNEyduvY8e/0aYEHrkmdmY9trm6X+6aHe2zbVZUl1BcgUvtUEcljqzul6aziRag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rj5mz7vq;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BD606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rj5mz7vq
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so15403705e9.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071016; x=1793675816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQ+242XXpF4XYTgroATD+gR1LZaxLFb4lfgsfyrn/z4=;
        b=rj5mz7vq9ZcjRLOOQIj9TsieKRMbNUgiP1FBBzNFxXKI9DOqVqh3CDklh4QtLa6Igp
         1omG3kOUGgDEmbnx7BNWT0YTuIBk0yaOC7G1iwaSaWA3V+TCYd3SBM85Ke2IVsNt3ICN
         Rn0oeu2EVrw0yFBEFupXKEBud4Yat9lrRmsKF3lL6yrw7hOns0Qlf6OEtKGsFwIj6ZIP
         Pv01pXEqefuA1f1OZIA3zQxunStrSPGr97lYk78CNcIVSIrZsxGYCu1dFLI6cNIWFQ91
         fh7Yn7CEQtCOYk0We3o7ZW1pxkImZYbJuvg5EWlt8dKF7wvA39oazz3yXaf3dz6UyVwY
         TSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071016; x=1793675816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQ+242XXpF4XYTgroATD+gR1LZaxLFb4lfgsfyrn/z4=;
        b=OFD8YOIPAkUTJ92CCIp3oIJPsS/uiRjtCLH0T21VPisZVl+a9dK6kox5gLVAS5sANO
         utRFc+e7HsFTC6/Tg7iP0UPQF7d8aYhT52bw3tlbrzDOj/m30tXX1A0tVhMt3NQk3DZh
         StEVnkjCDERC+DlpRIu3odGhlVQx9kffOe7lzMbf7XPtvAXQA+wQ87BeDOGSQrRXc/tx
         GMFfS3Rtmi8L3Q/JoXyjNQZDq2aVkNMfcQAenLlxDOQRttLTR6k9pUjyRtbqCY9OFIaJ
         jDGBu0Sw3FzZ/9j9R79qwnu9JpOIqFB4vp2QnGuLOD9d+d6Z7Y/C9DY9LCxvYqAilRMl
         lljQ==
X-Gm-Message-State: AFq9FYJQ/98QRIlQ2GWYOZkAPNkEBmSAJkjNYRBxmeJYgkN6gmZZTPba
	an79yZnpA2hpLJ+PrXg/WHCXDXD4aJRFpiAf5obF9IqARTbibvTkT5k5I1kxkr2G
X-Gm-Gg: AYBFou1Ede+18DZtg/txRfMc6uTKbKUkS24BjVGPc1ckTpXw5dAQPJl9P9/gfdainaG
	+PZ6awYbhCoEJ+Q5DjgAtsvS7ug8b7yWYqJeZMcOZgqdqW/oWfMtVAZn739yoWjoTFonI7CFCLy
	WpHLC6Yqxna2hb7t5Y2oWYvhb2LqgT2re1qAGJx7KCpDvJniNkg56yKiWskHJjWYtVzJrWWUZrC
	myfy3TMD2tF26Zp1xDNU6C0q78hIvVxGoRMjyQyEDyjiBsmsaRP6hDh7Xtv6sDBDQu3Zf0mqbBz
	r6or284XVgCX9iKsGn9qOpB+E9eC0tmZTdYgPBzFbUwJxUhS2kd6v6ZTiPMB6pRykgATqXzjtwo
	5RQlG3fxiNcfLXdq/DLwZkv9VNEmPAK+FZhd1UCHH5iIOFYmEMdPuii36IrDraV2303LkeDouzy
	cw17b7x2bpHBMz3RaIvvjlQw6mdR0l0y0tEiyIwSmJh40K5aom6lQVE5JBEpEqdGQB8fimuPz8C
	Vha9/kwyfQBBXvEBRWormuyWssKfLO148o1rS24MQ9sHXX2W7rb/aFBFKLH9wGJIUT2qxah6Xu5
	h8+UmtuIiTOdSi2dhMo2n7Sj/zk3PVhorEZY5O1bf0G/0LGMfnp811d8sHuH32n83rsYTmyQRn4
	Z9UfwbEgd6ZsnADVR8pCR2pIenO0hmCv/PQqQ6M5mYvdwoDo5s3fefITWYxQu0EVVhIAVU9Agud
	F7tg==
X-Received: by 2002:a05:600c:46cd:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4a35ac388b5mr160592515e9.3.1793071016034;
        Mon, 26 Oct 2026 20:16:56 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm21777960f8f.32.2026.10.26.20.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:16:54 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 27 Oct 2026 03:16:51 +0000
Subject: [PATCH RFC 1/3] cat-file: extract the transport ownership from
 get_remote_info()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
In-Reply-To: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

get_remote_info() receives the name of the remote and from there it
builds the transport and at the end closes it.

To be able to reuse the connection for multiple batches in a subsequent
commit, it is needed to extract that responsibility from
get_remote_info() and instead have it in its caller,
parse_cmd_remote_object_info(), which will handle the batches.

While at it, rename the transport variable 'gtransport' to 'transport',
as it looks like a global when it's not.

get_remote_info() returns -1 when there are no smart options, or
otherwise the result of transport_fetch_object_info(), and its caller
dies if the result is non-zero. Move the smart options check to its
caller and die directly in get_remote_info() if
transport_fetch_object_info() fails, so get_remote_info() can return
void.

At the same time that the smart options check is moved, give it its own
error message, since "failed to get object info from the remote" used
to cover both that case and a failure while requesting the object info.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 61 +++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8870a210ec..f7d75a026b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -680,55 +680,36 @@ static void batch_one_object(const char *obj_name,
 	object_context_release(&ctx);
 }
 
-static int get_remote_info(int argc,
-			   const char **argv,
-			   struct fetch_object_info_results *results,
-			   struct oid_array *object_info_oids)
+static void get_remote_info(struct transport *transport,
+			    const char **objects,
+			    size_t nr,
+			    struct fetch_object_info_results *results,
+			    struct oid_array *object_info_oids)
 {
-	int retval = 0;
-	struct remote *remote = NULL;
 	struct object_id oid;
-	struct transport *gtransport;
-
-	remote = remote_get(argv[0]);
-	if (!remote)
-		die(_("must supply valid remote when using remote-object-info"));
 
 	oid_array_clear(object_info_oids);
-	for (size_t i = 1; i < argc; i++) {
-		if (get_oid_hex(argv[i], &oid)) {
-			size_t len = strlen(argv[i]);
+	for (size_t i = 0; i < nr; i++) {
+		if (get_oid_hex(objects[i], &oid)) {
+			size_t len = strlen(objects[i]);
 
 			if (len < the_hash_algo->hexsz && len >= 4) {
 				size_t j;
 				for (j = 0; j < len; j++)
-					if (!isxdigit(argv[i][j]))
+					if (!isxdigit(objects[i][j]))
 						break;
 				if (j == len)
 					die(_("remote-object-info does not support "
 					      "short oids, %d characters required"),
 					    (int)the_hash_algo->hexsz);
 			}
-			die(_("not a valid object name '%s'"), argv[i]);
+			die(_("not a valid object name '%s'"), objects[i]);
 		}
 		oid_array_append(object_info_oids, &oid);
 	}
 
-	if (!object_info_oids->nr)
-		die(_("remote-object-info requires objects"));
-
-	gtransport = transport_get(remote, NULL);
-
-	if (!gtransport->smart_options) {
-		retval = -1;
-		goto cleanup;
-	}
-
-	retval = transport_fetch_object_info(gtransport, object_info_oids,
-					     results);
-cleanup:
-	transport_disconnect(gtransport);
-	return retval;
+	if (transport_fetch_object_info(transport, object_info_oids, results))
+		die(_("failed to get object info from the remote"));
 }
 
 struct object_cb_data {
@@ -824,6 +805,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct transport *transport;
+	struct remote *remote;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
@@ -837,13 +820,23 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		die(_("remote-object-info supports at most %d objects"),
 		    MAX_ALLOWED_OBJ_LIMIT);
 
+	if (count < 2)
+		die(_("remote-object-info requires objects"));
+
 	if (data->info.sizep)
 		results.wants_size = 1;
 	if (data->info.typep)
 		results.wants_type = 1;
 
-	if (get_remote_info(count, argv, &results, &object_info_oids))
-		die(_("failed to get object info from the remote: %s"), argv[0]);
+	remote = remote_get(argv[0]);
+	if (!remote)
+		die(_("must supply valid remote when using remote-object-info"));
+
+	transport = transport_get(remote, NULL);
+
+	if (!transport->smart_options)
+		die(_("smart options required"));
+	get_remote_info(transport, argv + 1, count - 1, &results, &object_info_oids);
 
 	string_list_clear(&data->remote_allowed_atoms, 0);
 	string_list_append(&data->remote_allowed_atoms, "objectname");
@@ -852,6 +845,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	if (results.types)
 		string_list_append(&data->remote_allowed_atoms, "objecttype");
 
+	transport_disconnect(transport);
+
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < results.nr; i++) {
 		data->oid = object_info_oids.oid[i];

-- 
2.56.0

