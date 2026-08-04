Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BB2E7623
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832212; cv=none; b=Mjfb/GqMVSt/tH9bU7Pg5GYFNW3sUlxWQiwkTBgf0KlZIx3+BkHksAEJYuXKcY8mlx6Lp7oSXO3EWKR824C6T/fmdu9DRRo2DzBcwBjNjMi3VTw4zHImYLLW/Qpzd0qiH9AUGCG/l2UxkZ2pRohk+Oj3+R+43R6tlrhOKkr3OT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832212; c=relaxed/simple;
	bh=qEMyA97QN80BJQZbvp8T92nhqr7SEs+qbflmgdfEoE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCyDU2sahueORA50CB8nEBQ+//Ii9dCX2DN3iIdJkJU//Yz2q1aXOmx2jfdN5L08BW5QR/3PFmGH+n9Nu1v757J611gkuHyuT+2Y4WBMLMBbCHzz2jJFHt6ek1YEhNvTIsByJH075aoQfyz+vG5nNS/tRD9oCZ2I1qqgfeSn8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZlZWNinE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ai/DyoBt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZlZWNinE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ai/DyoBt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30C4D7A0155;
	Tue,  4 Aug 2026 04:30:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 04:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832210;
	 x=1785918610; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=
	ZlZWNinEVfaFjR8bD1l41etLfyjElUauFjXsCcpeyGyK97eCGPGKH3A803X1VAjc
	NweCqXBL9IT9jOVBc4dhz4cpG2K5ULUQZoz9otgTuKm/8cUAQwn1W6jisYs8bQjw
	jn1bzodET5NJxfhSIKE/thgm+slOwrbuiiYwryDzgiwZAX0PH4116jrTqkYnPv9/
	eybTIeCpXHlRhGRARaNEkUlmhpbN6ob+ZQTUwhiO6kjoYx3RceHZv2ebra+OMJRs
	9TUaUwLlOA2udicOFNFAHSVjPjOUuf8+3XnRkraOn9w23LrayiSN8Zc+CfmpWnXm
	KGP2ly7zXX7IOpaPaJDuNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832210; x=
	1785918610; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=A
	i/DyoBtCu8D90j8GvRaxUFen6T3KQpVbEiAeGB1Kbn0sJxfHf6i/myQsba0a4oTm
	mXAos6PQfozeE3G5SuarhCyxJKdZ4cyzTtLkixC9Ve6i1b9D56+WvdF9rxsZMYhv
	lU4kqMTOVu19I/oe/YQT/P7o/l8eY/LkJUyF5dexgbBV/KKvHmxEkWlnU+AAFNqp
	CHoaWNnG1j8dW9wopAplUPP1xriO54nF7NRZBZ6/XApBdNN2vGFcmGsMSufLkqDo
	gLEjqdO1h34CjVUHGYpxkImlAL8Up4EDTEXUvFWDyG/IYLsT7XS34mkF9bKIDNZq
	8kHHYqkizUz3rFY42+KJw==
X-ME-Sender: <xms:EaNxaswNJBdv752v-bPkVI2BbUUzv38PKTSCzgC0Vjh2DAvM7TsjBA>
    <xme:EaNxanTo_UGQZYOgGXkLf0E9eMAAxRW50Lx0EU60gJQda-Js7CkysakDg2cEGLhwa
    AI-jOJNpX--hAlFvr1R7QQz4jDDSZNG01t06HwZrbB2Tf-z7QH8P5E>
X-ME-Received: <xmr:EaNxajU_zogPkcXpqTMeWqsyPlU9VzuLst-I544RVT2JPscS0NeBSXrlpvjQ54IfjxSoZdMKS0bpz7S1cc4hprCkXH6e6dui_VPjByki>
X-ME-Proxy-Cause: dmFkZTEbgtzG3LVU36iLnTJFOTKaJnVb3Xpa8gL5U4HxfIGy3b8t4xIrlpDR2DpqRIZvzf
    n1NI56hVabElJrPx6MSMtz1cn1wl+/2e6XDDCQz5bBcc7tZPYbMw6N04VMFOLBi2SKlZCi
    bIg2EyW+/zEy6CTrZbhGwQc/+oDHdUmiW5xr3HKqR+v9ls9TXLukerfdzTR0S7RkaDq84C
    Pr7XwrqTs0UBCsvWclzxevhVY9QLcuIyCKGZfoFXEvWt3uFBZ852qzUxPP9qmgChakaEfl
    TykiJDiQj60J06EdA2jtQ7uStMrFkhicj42WfaCa9v3sW7CnzNa4vaxT9e6yFwS4In4JF1
    V1JYfTxax3+NDYSUjumSyJ431ldnbzFZ4e/WKP/OfJaGMF1zMmYIoFtw+9KcknojTiXsEt
    O129HtjcLT8HmTg3IPaSDpHkyBAAjyoBpYatPqRleayf6KFAhLFy0zO2k60LwjyCGt6ty0
    s51VBDk2abPju9FzsIrQFtjaXjP0ZGId0r1RYJZZJtz7aGCPQU0yh4IVww3sJak3IYU0Ph
    XBEDp/Dq1ck1Nowratw2pY7oO6PEzbbldSgoBtMEYmTLGLFfmH5fHBkKXfTp+JEprEym9z
    AoC622lgycSaTbVDcq7PbdPLmAaCS9AkLjyS7Eq5Q+DbsB0RMPo3fn/ezmVg
X-ME-Proxy: <xmx:EaNxapaVlqChSLqUnsWR8o1lPhrHQoQQZQX2-lxqWzuRb2dThXPn5w>
    <xmx:EqNxap2qC1JU2o6uo8E4JVYQMA0nvO67tkHCfca-YX-LeoIaLfzHjQ>
    <xmx:EqNxargAkyc6ce918BbDEpnq2ckAX-V8Tau1XpM8a0QEHfSDfIx9PQ>
    <xmx:EqNxataxx62_oTt9cfqVqcs_UZkWuFCRYK3m2bmrSixyC2p8_44Gwg>
    <xmx:EqNxaiXQoE1WZ04DmjS47w0uMCM0Au6BrYjPcTGrkWdEM2CwXg4Ygry6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:30:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21a41086 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:30:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 10:29:09 +0200
Subject: [PATCH v2 4/5] odb/source: introduce function to map source type
 to name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-create-on-disk-v2-4-ddf8b59bd207@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
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

