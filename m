Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1291F16B
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147354; cv=none; b=GNvtL3EN+Y0p/gdI772Vsnp9YEVo1i74PrF8vQj30sO58zcjQ/IO7Qs60SfrICLPBrZjgCq0hcgb5p7MlMJcwn+OPPSyG2Y8pObmCz1chqoPHaGWZs2mSBGms3jmxSuXnyP+lh2yfUuztWBPUXcHYhwBMVlZAaFVoR15JrqNSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147354; c=relaxed/simple;
	bh=Q+7O6O2/lUozzK2MnHJsmRJVYAiIRFoatAWoGsbmb5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFAF/u7gkTq+SkAVHSuhXjZggtEnPWQOIcNr/Hp7rj4LfFZ5AxZPc11PbJ9ngPBBgj0sdifUS69HZHTWXAunOFbCirQNKvEqyjD07L7/HgEa57IliZD0J524xjHhK7bC6h3lhvAV8tIPM2j4ZQ+mXrW/zOd9izc5+3Iazj+a3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb69/AzE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb69/AzE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4994c49f588so827345e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147351; x=1786752151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zs67nYU7TXUCfHtK6D61IdjgktU8zAibXvoVMPdVLK4=;
        b=Jb69/AzEDWr1ViXUtV/wYgVJ2Ny14+nEWLGa6IIFI3V1L71NyC54iS/2WDLWVS2Jf+
         6xrEwKdagKRRgW9BeEyMcF+/3CIEt1W1nCMsAWSk8zlfuVcGrO89B/VMxtWOER15nKGU
         FhO4J9EC/yZdxtlxfPKEZZvsrIfuyyWrRAFBiq+yKGigExUvcTGhjmcHoeuzYAkx1rK0
         E60OZyxPB7GXLgM+OZm3fivyCRQn1SlMzMTt6BRV/opiTorA6StTQ0d8PHgpKfvJihR9
         eGPld4QA7SrHQRpEbjq+z4km+auhqI2wGa0eosevXWfpoOuS6qiHb76dlwZ83akLdQdl
         qZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147351; x=1786752151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zs67nYU7TXUCfHtK6D61IdjgktU8zAibXvoVMPdVLK4=;
        b=OnkTFbrYz6r61Qn+DqwppafA1w2PPxADajGGNB2DrJ71aNX/DMgq+ypjyXDJBj/XAz
         3oaeFTFpROyCYuTxMawBnbyIIXB3DdEAxxt85JsS61yqzRxErZXHs6l9c0AfW1jLNSDX
         45TmuPxKHRNEEwApK15BLdGfFjTGJfphoMveg/0z6ESWRNI4H7QkHnfOvN8Wquw5ZAgx
         TX0HvOfRzwDM37PZaLy/8qiI65SJoW9JLa1WIv3Tq/j+B3JIEUIcI7yBzffVEEVXazAp
         XkzRSYijifkhep7f98xzafDUXBUdDjspuh0qvROQJd7ciExWgQl9E2esOgollaQEmUNR
         058A==
X-Gm-Message-State: AOJu0Yx+hNwywCek2nqLexoM6Y6HoNvDhTIyxjV8aKANvdilwM0/p4K0
	ezL8kli91upLc2eDF3LwBqHPox8YMJopf2mjl/emrIDzWDDd/CncFG1d
X-Gm-Gg: AR+sD13U4QoAdQoAcuIGaKbpn/ZJhH89x6TP5GL6JKM5LUdThO8DHTRLiKpG1LlPbi7
	OUCsCHZdcBFWQZyfaxDqzWTCxRPj1+7LGZhXhzw9jHrh2f/xw3ctjAp/OF0n5x02liq8LD0hGTC
	NdxQYrurdfbT+6GAa0VtfYFpKLNaCw++cmh9UPEXk2fKdwmKYDtwHV09aPgr8Y+pndSlQ14bBJ7
	OiAlrueXF5SABGk/DvkqPar93df6AqnuEwOHj/QqPJM5No+6Ch+acem2QMyxem/2Rd3SSHoj0VA
	CGU/97RFXv1A4Ffj6nPAfPUzRDAVm9v24vuOpLMZv5D0k2Q4/r3pIr49we8a0EEGBKMMG1Vgdru
	oJ0F/mSpwxg+WoRb26cxL2YPYegwbdPANZU/YxrmrjtEwkvFNw3yqXP33klFk3r+8TWcfyNlUNH
	lxVL4Wv/Ew1ydwyilswWPA9TSw0qAL1Vu2SWKNnc6fLJq+lW8GvQLfsIpWWIQhmGkNffdh6vydU
	cBgkxtWmYGTZvLE4jFKkjI8oou+pwQz8roCV+C3rvXZuPz/Hd96THn0CAnfaPpy5Ovf1e8lCeXy
	XzqgK3quMwT2SWsC9REb6x4L4v4k10b/bESUlAOIxml39WjdCkseZSDXzn0HEaJw4YpV8M3XSLJ
	EFE61iEvheNeRCk9/X8Lv3NEjCJCBe9Mv2JHvfN29IO0uxDzTpa8r4zR6mZ97y/JBoksR
X-Received: by 2002:a05:600c:4e8e:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-4996247e640mr19560345e9.9.1786147351137;
        Fri, 07 Aug 2026 17:02:31 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:30 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:20 +0200
Subject: [PATCH GSoC v6 05/10] fetch-object-info: die() on the remaining
 error path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-5-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Every failure in fetch_object_info() dies except one: a short read while
parsing the attribute lines returns -1. That -1 is then passed through
fetch_object_info_via_pack() and get_remote_info() up to cat-file, only
to die() with a generic message.

Die in fetch_object_info() instead, consistently with the rest of its
error paths, and make fetch_object_info() void.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 19 +++++++++----------
 fetch-object-info.h | 14 +++++++-------
 transport.c         | 12 ++++++------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index 5f53dbd6b9..4db879c2dc 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -47,13 +47,13 @@ static int parse_object_size(const char *s, size_t *res)
 	return 0;
 }
 
-int fetch_object_info(const enum protocol_version version,
-		      const struct string_list *server_options,
-		      struct oid_array *oids,
-		      struct packet_reader *reader,
-		      struct fetch_object_info_results *results,
-		      const int stateless_rpc,
-		      const int fd_out)
+void fetch_object_info(const enum protocol_version version,
+		       const struct string_list *server_options,
+		       struct oid_array *oids,
+		       struct packet_reader *reader,
+		       struct fetch_object_info_results *results,
+		       const int stateless_rpc,
+		       const int fd_out)
 {
 	unsigned ask_size = 0;
 	int size_index = -1;
@@ -89,7 +89,8 @@ int fetch_object_info(const enum protocol_version version,
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
-			return -1;
+			die(_("object-info: expected %" PRIuMAX " attributes, got %" PRIuMAX),
+			    (uintmax_t)wanted, (uintmax_t)i);
 		}
 
 		if (!strcmp(reader->line, "size")) {
@@ -156,8 +157,6 @@ int fetch_object_info(const enum protocol_version version,
 		    (uintmax_t)oids->nr);
 
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
-
-	return 0;
 }
 
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 9f72e91155..97ee5314c9 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -24,13 +24,13 @@ struct oid_array;
  * attribute is not available.
  * Release them with free_fetch_object_info_results().
  */
-int fetch_object_info(enum protocol_version version,
-		      const struct string_list *server_options,
-		      struct oid_array *oids,
-		      struct packet_reader *reader,
-		      struct fetch_object_info_results *results,
-		      int stateless_rpc,
-		      int fd_out);
+void fetch_object_info(enum protocol_version version,
+		       const struct string_list *server_options,
+		       struct oid_array *oids,
+		       struct packet_reader *reader,
+		       struct fetch_object_info_results *results,
+		       int stateless_rpc,
+		       int fd_out);
 
 void free_fetch_object_info_results(struct fetch_object_info_results *results);
 
diff --git a/transport.c b/transport.c
index b0e29124d1..35acdf71a2 100644
--- a/transport.c
+++ b/transport.c
@@ -448,12 +448,12 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	data->version = discover_version(&reader);
 	transport->hash_algo = reader.hash_algo;
 
-	ret = fetch_object_info(data->version,
-				transport->server_options,
-				transport->smart_options->object_info_oids,
-				&reader,
-				data->options.object_info_results,
-				transport->stateless_rpc, data->fd[1]);
+	fetch_object_info(data->version,
+			  transport->server_options,
+			  transport->smart_options->object_info_oids,
+			  &reader,
+			  data->options.object_info_results,
+			  transport->stateless_rpc, data->fd[1]);
 
 	close(data->fd[0]);
 	if (data->fd[1] >= 0)

-- 
2.54.0

