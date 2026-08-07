Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA238E8A1
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073690; cv=none; b=rpemH0hj/aydKqCWI0zvIiawweCbLqqNQ3RgzTLQ7x1afhlNLZq8Wlc10xmjy2Ypzcbb0SQUv6gh7TZPgbXS/+IXy9ROOpOq4135cQ/1Jfn8dd9OU2gCy8TO1gE7gUeeOM0TQKr/zU9KMhUjEX2Dw0qyxjtwCDQD352bwABV6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073690; c=relaxed/simple;
	bh=qEMyA97QN80BJQZbvp8T92nhqr7SEs+qbflmgdfEoE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0eB+PM6oiuwW6PgS69N19snjjrOsaW/PDIwiDEFTLNIV/jbA1SeiLojLxKqSfCsLRLUmBdau2e4SjpV7cQIROs4tjsG7i9fWAN4PdO4jFGhhBVIon9T0r7TfGleu+wKTcKpOQoMZLhRBDXXORA2BGNrKieuEpw23wVJ2N5yoG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=at6eyay9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNREpccm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="at6eyay9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNREpccm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 74C08EC01E4;
	Thu,  6 Aug 2026 23:34:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 23:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073688;
	 x=1786160088; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=
	at6eyay9citW3HyvWbj9t9+210rVAm2VUDGG6aBHNxYCgT3Vp+pyX9wzuOBB6MNy
	2vKAP+r+MDIi7mEM9wTS+MGWzq7kjHQDfuSNwoKL0CcMjhwfOgn1sjsXpO+gAgmH
	b7nllMyaPKfPvLGVEzaOg3NyuvlhMUabIeeErTY9zK86ds10ZNAFlIzfbi2GWERw
	2P3xFS20WQXzSuhtobsB2gafT3u1o2Zpv2DVNHby77TytnrxQLZ792QlwcbuGQpZ
	MWAv47m/1Vm4rm5W+o9lHHbu6GHajPsElGGclaNCK0ymHtJAlOjuiuLv9bXzIeQy
	SFhi5gM5p33jtcCt+Rv2XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073688; x=
	1786160088; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=f
	NREpccmt7b/EqHUTykSOEKUuOinsVV2FdIjfFe8G5x8WgEayB7a/4acNhtRPnW/n
	a1BZb/ukObk7vJa1me+Nl6/htaqv/dX4f92/91tcyN3n4LiFCx4/ofEOZ4pI5hUF
	hO8n0voc1Y70sS2VH6pzEU2SW3eJpjZh2IVLGoGQEjupAFtEoJQHJqJolsVqFZXr
	pj6wcMUulV2bhe8Q0D//QjCR1t6hHJZ85f3dfGvq3vwEWsJ2jYOw3uspwecl23RD
	WlIiFomBhi0FoL2XJx6KgXXLYSFA7ys2bc88AJNF33pJtIyI5u8JGYITplfFDt5t
	ESdnKsc4vgkADx4zydtUQ==
X-ME-Sender: <xms:WFJ1aqq7GCBpnfymWUgZ8OENY0Z4yTn0LoslBOU92Pj1WZix8iBT-Q>
    <xme:WFJ1ajOxxL2v-Bsx1S4FKwbnG1OFysj3YLGs_-42TctnWgKuYN1QvVAZ6RnLVJ81e
    SarRSesxQ3fTTPxf56I9yoH754GSWV1k6J1dIjt4Z-dFav-dlSIJQ>
X-ME-Received: <xmr:WFJ1arxSF_LEpk5yDcUcBT3bJoxsz8-qF4IqT-tw7vsjdJNZKohaxcgP9TX9dle9z2I_DHlDvjhmO-adhIasNuU1SSewZL10OWJvNslEwpkifQ>
X-ME-Proxy-Cause: dmFkZTEKRkOWJ/79eTxFHozgQoSfya5Dmt7QSyQzTzBw8Q4WvNos5TWmLG+Mbzm0NS19Xh
    UGh6LEYUcBSqFhM6VbYSqhy5ktsqjsVUXGqrPuzG/NpAmKu2cbT2Vb62vZBKfPw6hQ+T4d
    vBVNIAnNf/Nzg4jBnvB8JwWpO8jLewlWcpiZ1GhS0Eo+6rHOXiMaNPUT/UfieO6Gmm3S26
    OMJalkHauPln5FoRrq4Uw66HR4VlKcUxHbeQjGhZFDQr4GEOv3puH7p11dhl2WCDZdWrVU
    JUdidM3se9pfKMqG9CpAZoIGFIUD6xaqHksnUm6bYxGrMq7Jok7IMVzWnA1vlPs5+KrNBC
    mv4PMV7dzMz099fdqjwVDeh5wAT+38o5gQcYBrTzxQRZpO6/qo3k8zhjgVNVUIPJ3OMy9K
    MXaqUiSePUSMgytx2AzKz/zhoYC/1LajpWIWf9rxafao3SwD8VFWChDzeF+7Z0yfpO8+6o
    c2eLXBsTM2H7tZtgj57MUTmli/89fB/lEQQhrTGseLK7Jk6PuMpMgrhub3/UiWDHFfyP70
    YGnh1HHT4LwhGfm85pGrq3DYrfSxPwOVcfQc+LjLnu+UsujSXuZtqpGeTm8s2ezxyb+whs
    0kYMsFCSlfFTswrfgHDcILzTMl1HQ8QduixOW7Ayuc5Z2xF726q/9XRSLxXA
X-ME-Proxy: <xmx:WFJ1astX1AL307WaO2L9GnAwM1nN_oEHMKIybIgFRJzQ9ebc7eEOPQ>
    <xmx:WFJ1ak4RBEPj46smnNVnJ5oULp-eNFAOinur_emX--CY3i_CKlpkEQ>
    <xmx:WFJ1arSFGlB6dBn0CKStlkx2kKRfw6DShAlNumC0p9hzVGCVVgTipw>
    <xmx:WFJ1ajqMh2SWEnIPXLxpFN3W_J1VC0WE-XUWKrBFeEOWakEu42CBUg>
    <xmx:WFJ1ai58M59F3rXZWUqig0NMVNiGAdIkmm-Vs2sUXzIvz_mqlAbf7EUm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08be8115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 05:34:29 +0200
Subject: [PATCH v5 5/6] odb/source: introduce function to map source type
 to name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-odb-create-on-disk-v5-5-399da0b0b140@pks.im>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Introduce a new function that maps an object source's type to a
human-readable name. Use the function to provide better human-readable
error messages for the downcasting functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.h    |  4 +++-
 odb/source-inmemory.h |  4 +++-
 odb/source-loose.h    |  4 +++-
 odb/source-packed.h   |  4 +++-
 odb/source.c          | 19 +++++++++++++++++++
 odb/source.h          |  6 ++++++
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/odb/source-files.h b/odb/source-files.h
index d7ac3c1c81..6a803afdda 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -28,7 +28,9 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_FILES)
-		BUG("trying to downcast source of type '%d' to files", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_FILES));
 	return container_of(source, struct odb_source_files, base);
 }
 
diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
index a88fc2e320..adbad23e8b 100644
--- a/odb/source-inmemory.h
+++ b/odb/source-inmemory.h
@@ -26,7 +26,9 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_INMEMORY)
-		BUG("trying to downcast source of type '%d' to in-memory", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_INMEMORY));
 	return container_of(source, struct odb_source_inmemory, base);
 }
 
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 6070aaf3ce..3cf2e1f8f1 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -41,7 +41,9 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_LOOSE)
-		BUG("trying to downcast source of type '%d' to loose", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_LOOSE));
 	return container_of(source, struct odb_source_loose, base);
 }
 
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 77309ddd09..a0f6b5096d 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -78,7 +78,9 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_PACKED)
-		BUG("trying to downcast source of type '%d' to packed", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_PACKED));
 	return container_of(source, struct odb_source_packed, base);
 }
 
diff --git a/odb/source.c b/odb/source.c
index 7993dcbd65..30188b806d 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -4,6 +4,25 @@
 #include "odb/source.h"
 #include "packfile.h"
 
+static const char * const odb_source_names_by_type[] = {
+	[ODB_SOURCE_UNKNOWN] = "unknown",
+	[ODB_SOURCE_FILES] = "files",
+	[ODB_SOURCE_LOOSE] = "loose",
+	[ODB_SOURCE_PACKED] = "packed",
+	[ODB_SOURCE_INMEMORY] = "in-memory",
+};
+
+const char *odb_source_type_to_name(enum odb_source_type type)
+{
+	const char *name;
+	if (type < 0 || type >= ARRAY_SIZE(odb_source_names_by_type))
+		type = ODB_SOURCE_UNKNOWN;
+	name = odb_source_names_by_type[type];
+	if (!name)
+		BUG("name missing in `odb_source_names_by_type` for '%d'", type);
+	return name;
+}
+
 struct odb_source *odb_source_new(struct object_database *odb,
 				  const char *path,
 				  bool local)
diff --git a/odb/source.h b/odb/source.h
index cd63dba91f..ab16d152f4 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -25,6 +25,12 @@ enum odb_source_type {
 	ODB_SOURCE_INMEMORY,
 };
 
+/*
+ * Convert between the enum and its name. Returns the equivalent of "unknown"
+ * for unknown types.
+ */
+const char *odb_source_type_to_name(enum odb_source_type type);
+
 struct object_id;
 struct odb_read_stream;
 struct strvec;

-- 
2.55.0.679.g6767b8d81c.dirty

