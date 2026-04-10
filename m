Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CB3BB9F3
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823201; cv=none; b=chbiJ5vJXtV4LyBgmlDNZqZXzWbjPTtatf9VnloEu/QRXDwozZtLypm30o8NzLQ5aN/CT5DElY+BeDcZcWzmwAQuPkGgeuDiaRsyLMkMIzsFqnWsPSaQzzZFbrhQxfP+jdCWg3LIOj0N6hfe8MHzKHPjz1P/FT/AZduK7p3m3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823201; c=relaxed/simple;
	bh=THb90QdkL2DR2uEd7U2Ta56+5iHGYNUqT2Q0oYtIYL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOMp6M3dIbRSoEr3sjrGAPlIHZc8YSgJMxxruWdT8kohfbAXc6nRtNY6c8HCGCB2cVMlOndBb6mSEOdEKOf+LDTIUkz08FrHN6FWxMNYDR22hNVs/0SlnX5cZg6fUKn7Bk4rP1w3zRGON0crtBOvtNiVTOdAr3dal93CRQKPfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KAHGKm0t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBjkuC8t; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KAHGKm0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBjkuC8t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81D1C7A00EB;
	Fri, 10 Apr 2026 08:13:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 08:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823199;
	 x=1775909599; bh=l4lQ6NPafr2gQqfu0Q4iT3IUhbaOnnqUR/MM+XlHYIc=; b=
	KAHGKm0tdMeOijMcBXxKtauwGGT7cp9A2jgX+Y3m7LoRvi9MTi8N/pt8rZSqAe5e
	GvCayyjLeQvx8NmVWuFJAGvaH6LD+4qsK/jvjRPbC7VYD7SuEzrl+vb8c4OChDwM
	3FaQiEAB3/u96i1VJkOD8T1KWbc+aR7gHamZ2ZZszbEXUWVUvfYXGeWv7t2Q3x/d
	JKpBT5VOGFb94oQkS7yWzwcZwVFc89s83fBIY2FvQOcYwh46GQkEnK6J9g04L3v2
	CMJJmQum1GVdFYsebOZQp4BV9UIFpYYYf6DT5tZQjCxMesOB2iangglX8zosMdeg
	kWFpE0s5y/tuQW5LnyiyMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823199; x=
	1775909599; bh=l4lQ6NPafr2gQqfu0Q4iT3IUhbaOnnqUR/MM+XlHYIc=; b=f
	BjkuC8tT32ov0cJ/9iO3nj5fG2X0kvrSsQymPyEf9yM/HLY2DtYLCO0rWo7UYKzx
	gq2vaXWDHzMeiwWSGSgqDuaLSHfxSAfeKiVIH0/21GuLgDY2QWoklPlBz1FdOZhn
	2Q4Wept4FefWaSYAK36TxTx/0hXU/7pvF3fevHONJhC+4D1bp/W87W4undH/s8QU
	RBVzPcdziPdEFqSz7L0vbsPz1wyq3g5skqzAzB5rv9FYnOmLgtZ7bVUGSG7/kbdR
	7TVgjxdoGn94Mdpf+FmcCmkJmRXO6UQQ0NyQfOFHK10oRahPde14xicr3sHNbW5t
	K8439bIS/apR2gT4wSg+g==
X-ME-Sender: <xms:X-nYabZK6_YJKbqe0z4bAD0nXsQAUD63orYDzr3qv0mRdoU2FwfSVg>
    <xme:X-nYaR1L6OyWe8znTjUEXhVvPdq2RnSbcEK2SXQCKDrLxqx85niDRQ3w5UOLBg9uT
    vVTSLWXphoaK2x-Iv1254PTEnChvnJfGt60vRZ9ZhPPa-R0Pt_Eig>
X-ME-Received: <xmr:X-nYabURniuBBb1ZkABCZ6M5EhLCKyRahYrI9-214YAlbYWoxPv3HlntG4Fs3_1QgINXM037v77Te6S5v7hUJ9fU-pFEjbt_7-eteFBnEA2sjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:X-nYabWr3MdW-tqfqa5kq1nz7aD04Li6yyXV3_65IcziyqsoAP7pXg>
    <xmx:X-nYaac1dwaSiY-yXbgk1hwyqKRJOvYpO2-aj-jMZHIxYburEOklgA>
    <xmx:X-nYaUVjey3Jm9A7mjT4UEISbsLoDMB_AKb_BJ15z6-kiECIBb6M3A>
    <xmx:X-nYaTdMKAAH20tYROpvW91ioH-zXetA5Z0fcfY631z8OGjDxsZhfQ>
    <xmx:X-nYaZ0b-4CEbnGqAv1nMv6m6cE9iITVIviUe_ZMH65FdyM97L8ac_NI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 072a07a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:42 +0200
Subject: [PATCH v3 12/17] odb/source-inmemory: implement
 `find_abbrev_len()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-12-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `find_abbrev_len()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index f60eecbdbb..44d9bbedec 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -169,6 +169,44 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
 			    odb_source_inmemory_for_each_object_cb, &payload);
 }
 
+struct find_abbrev_len_data {
+	const struct object_id *oid;
+	unsigned len;
+};
+
+static int find_abbrev_len_cb(const struct object_id *oid,
+			      struct object_info *oi UNUSED,
+			      void *cb_data)
+{
+	struct find_abbrev_len_data *data = cb_data;
+	unsigned len = oid_common_prefix_hexlen(oid, data->oid);
+	if (len != hash_algos[oid->algo].hexsz && len >= data->len)
+		data->len = len + 1;
+	return 0;
+}
+
+static int odb_source_inmemory_find_abbrev_len(struct odb_source *source,
+					       const struct object_id *oid,
+					       unsigned min_len,
+					       unsigned *out)
+{
+	struct odb_for_each_object_options opts = {
+		.prefix = oid,
+		.prefix_hex_len = min_len,
+	};
+	struct find_abbrev_len_data data = {
+		.oid = oid,
+		.len = min_len,
+	};
+	int ret;
+
+	ret = odb_source_inmemory_for_each_object(source, NULL, find_abbrev_len_cb,
+						  &data, &opts);
+	*out = data.len;
+
+	return ret;
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -275,6 +313,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
+	source->base.find_abbrev_len = odb_source_inmemory_find_abbrev_len;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

