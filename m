Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4A417BCA
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868988; cv=none; b=DpVUY64kiJUVmAaI/x1KlJ2j3f6MPgrmoULlcI76IN1OyrS5CoxavVEUmbMgO+m+FWJBNNbtzryKi3UMR2M6dFfSvkTWLj1m8/FqKAGSBXpBIWMCXtnW9SB6t/eODz0Pac6HPB5Nn0JvAlCWpNg1gYLHYP6jcoXEGb2Zi2ZIU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868988; c=relaxed/simple;
	bh=fyyNPyL/ru4MsFCG8ODotyZsjA/zIQRn55PyPNTAOVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7n8xQxvh4N/tnXdLNMXHBM3pmN4/CAMiiCtFmVlPaQAyzrtgzXHtrspjS1N4uvE/REXqRoDmuvBSRmdUL1L07+qMWk4hAEkUv1Bj7aaOrlLaRVKX40MBoHTZl1F/gZui+FB63qszI07jRjsuJMiLtgBefKN78S28+N7AFGO8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFIz/tf2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFIz/tf2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956242332dso929995e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868985; x=1786473785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9zCwsXNDtXiqXIbpmgOu8lH5sAxfofpNdSkuF5sBgrE=;
        b=cFIz/tf2EBQnmY89PCR4rtpAwes4jnGiQ9cnuOHoAIqlnu/7p9UbnKb3tbBI/pwVXb
         nB8g+m1CuNFsNsXMxjEkX7k+7sZwMkLv+4pfRet67wGBDb90J9sh+mXVnNrRPcGDuUNr
         dp12qUXK3mzrvEK3lQ48WUDiX83W7awjYwdE5IDOksd80PM1g6roArMFYhmW/UabdpyL
         CVJ5wrSB5Jxde+V4yuhToRSIWZHMNd6I5Gbp4ixIp4buZ3cpGetdqe4HefEywf64iDI5
         fbH0u8ECVPtbsHKyL96DEqO3rOlAW3YQidHlXbQCVCPIqqOyMkMT6L2Dwq1UAzr3LFa7
         8xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868985; x=1786473785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zCwsXNDtXiqXIbpmgOu8lH5sAxfofpNdSkuF5sBgrE=;
        b=C/k1EJY5HPnnt6dlIMZEZN4QXGS6ymMJ6UtKHvh1zzaT3Gl4F9wgqokRCr1tLkikQ3
         MBi75+4DHGO7pkm+Jb/iUzCHUb3vH3LqijnKIkqijaorDCXqn61dvT2778G01ATjLYIt
         2YpNytX4BhNlOZYuUHcRk2Vac7SDmO2Y+O2pbfYBOrxTBCUrdO5qRScjyYz6NhQUjAd+
         Nni9R4bLrD1jRm6QX0+qVpbBnET+ONadnEaurIjCfIfE5S0kQkGbBFih+3s7zlZsUbnC
         Fl9M28EHwDlFRTHoej+cUbuxiMqvk4fovX9oS96W4at9VQ4ZmjlMNILXLWaYcXVzUQb7
         XBmw==
X-Gm-Message-State: AOJu0Yx1c8pIY/1zy8DiJJxv0F/JNayyRIKP+6etPf3Xznt4CG86Ooa6
	fUY3mjqLhv5fLOIdJ6Rs/vswdyH/5znjFiQ9tMQx/gQL/iNOgPyWCdDNGODzhmXX
X-Gm-Gg: AR+sD13k4WjX9srqa412JGxrVbptlVInnA+Q/4thVC+CvDLUJsDhIh39VVljwBw/XX9
	8jxYaEdblndThgj1Ie8BQrlAw5h0sI8U2k5Ui7QvqDugSr3B4mXVNfwjoy5tP3WxW1UTCpf94QO
	kq3Yi2/Cr5VcdltmliR6F3QAejeJpCZYuz5mXt4//32WtRqvFF3yxpQwzRtcqAVmKMWVcY18uhI
	IEXOompZm9cWzjUE4P5+OJinbfkWKIOxbn/QmqgCS6xqrm5GMNbIUAcfCgHZx15qoHivoIKKxh1
	fl2GAUeZO4bP9ddOIRDkTftbQW4JMhNr9F4Sz26o+rX1s9RmzYjd3SdwV614CbTN2vgXsINna9H
	rD7XEQfGxx2PaQwaGuUrSZxy3ehekBxTpSiJRxjxQhVL2QFL1tLVouD1VNYfYGbjzwaAYCjURX7
	/KRsoBe7bAg3HdI82LDwLbm7wj3adISw/iEqW2UFkmR2i+NJQEcZrSqfy8VRls/oEMtzaLxjbIx
	Gx4VDSaLyx0XUsUDUSpjiHpdTOAVpYBjlzPf1MRHFSvK8wyLBfPTD/bD23eRh22P8Uq7eWHh+Z2
	2tSqbzbSTS+3BsetCfRVwiciGsDlMM8KrkBek9ZWR3tOC6HH2yyIo3A3MQd2+M6BYVYHtsJ0eKS
	FbQ40GzX8qZrajWbU/bHLha457Bbg
X-Received: by 2002:a05:600c:c3cf:10b0:499:49f2:bb86 with SMTP id 5b1f17b1804b1-4994e71af2bmr5260345e9.6.1785868985120;
        Tue, 04 Aug 2026 11:43:05 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:04 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:42:59 +0200
Subject: [PATCH GSoC v4 5/9] fetch-object-info: die() on the remaining
 error path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-5-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
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
index 46a1289ff3..6069d6a58b 100644
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
+void fetch_object_info(enum protocol_version version,
+		       const struct string_list *server_options,
+		       struct oid_array *oids,
+		       struct packet_reader *reader,
+		       struct fetch_object_info_results *results,
+		       int stateless_rpc,
+		       int fd_out)
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

