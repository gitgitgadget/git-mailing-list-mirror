Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C629E101
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445441; cv=none; b=BclpKhtZTMBI1a57NbjcssT6RYk89nlHPBbAP9czvCZ+F3JL05X7DYLPfbOz9FKL4XaCSOtNRiXCvp2vlDrNWEcqdI3r4ruz4AHlaFcW/0D295DLdhPF0bYRsDpUzszl3jysqmQeQRhG0YvJESzY9hHRfOyt/itOrVGFmEhPG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445441; c=relaxed/simple;
	bh=Dbqw9p5TAQCa91Ix7ilh6nq4lKVQJ91YsKi7pb12fUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYukVS/DOt0pH/hdqUweL3nmwde53bjQ4uKMzEX5ITUAeDXHnz3NPz0YiKA3u3r5cDnpdyitVd99iWVLIyjT/EoezAeQY2fWg1KlLxXogPYK3/g0KNY1WgPiiplyduwHIJEYbHUzym4671MoHvePnoOAWzzbV+hB7fRpPNoRsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZpPXtSSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niaFDsln; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZpPXtSSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niaFDsln"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 417827A00E4;
	Thu, 11 Dec 2025 04:30:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 11 Dec 2025 04:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445439;
	 x=1765531839; bh=JYJg6ZG3s7rF6KFfh7bGtd9CzwcIxUTwJYA7SSy8qWI=; b=
	ZpPXtSSiFOgytkdAzAp3K8ZYw2C71IvRQnxViOLPzJrAL00WLUnRyvg/+8InR8PS
	OAfJzaCIN+vNPcL1Zw+bNoZvGlDsTteQQ78xdZEppHzfM7Mi5A24DN/Ni2arVBw7
	igmTxzL69Xu2I/i5PN5S80sXNhs3InvoW28M1Q1MbQ2HScslsVbR5g56KmnT2pA0
	+yQxBWTbC5W07vqJX3GHXMmLe11LZZj9OgNNNmRKPpZ9BsFyKfuTll5+70ikTwvv
	GanUutPHR4UjpLstLsD/LPI8DMJSzaNZ0pLbeArZixHpvDMO6/Hveftu8o98JDvi
	mNQ5uIy79CoY7hLR22fECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445439; x=
	1765531839; bh=JYJg6ZG3s7rF6KFfh7bGtd9CzwcIxUTwJYA7SSy8qWI=; b=n
	iaFDslnuqn3J3F/u/USwgH9R6lB8WwbxzuodVQIiTy6M6cCIp8tqXWwJvTrkxcrS
	mfKVN4XH6pHYY5Dp9I5HgtzbiN5dPyI0qY94w4+u6ZgDm/ZvjpVuo0gBLd9fyjBH
	U8HIWPryCYSzpvD6DOaGbEnw8WwSdnQ2ZufP+AIiamAzg3lsOrkFzP5NqKaAja6c
	rC/kPpVtajRSbLxKacV3iVLHRGoCa+XnhJK3UMrDGfvoPcNF/o+05tuUT3tqQbEc
	Vz+SjErpeS//Cr/hFb6iJJIBBsEmwaARc7PqhbDRZWlbxxVVRbcdIpTBBm0A/xyw
	zesmXWsi9EIY09LtzBoFQ==
X-ME-Sender: <xms:P486aUAQvlH-fhLbAHrl3JLB-ZYh6ASF6zUdGLNWccITeKdfWFA3Jg>
    <xme:P486ad9iWL2mftVK_4Y76mytM8OjBqyO6Ek1mE2zGUN48DMhKeA15L7y3RoLG0sZC
    y80c-MKNJPfe5T392-xVJz8IMVHafB23e6gDTxr3NHZcY5F0mouigI>
X-ME-Received: <xmr:P486aU97iMNU9K22WHiqZy3mZkLyurosK_EN2mxMhrQcrqO09s50nT-tswZ5QH3QpXHFGLTuUDrws227Sd8v6eqs_sJbP5bpfSAXLexR2QZu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:P486aUf-g_emGqdEJfXzcpRNuLpvZAEiA0eFx4xcA-LalrcsA2yO5w>
    <xmx:P486adGJfF-bhzvHJyxBQk-hr5xIodTU6H7XyxhDmwk5NPgOlv1LzA>
    <xmx:P486aSf1FeE8FfiqgW-yeYJUXCboIQIp7A6lpxcOOFocUdGukfkavQ>
    <xmx:P486aXF1YdB-oNBCmWY2kLwmvMnyxELlVTuTz5g-zs8bI06RpI_5nw>
    <xmx:P486aRYRYyJSNYuNkwoEAJdosCBoF8RiTde9SDQ6tonMmFnX05Hor2l9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f640ce6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:16 +0100
Subject: [PATCH v3 7/8] odb: read alternates via sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-7-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.3

Adapt how we read alternates so that the interface is structured around
the object database source we're reading from. This will eventually
allow us to abstract away this behaviour with pluggable object databases
so that every format can have its own mechanism for listing alternates.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index dcf4a62cd2..c5ba26b85f 100644
--- a/odb.c
+++ b/odb.c
@@ -199,19 +199,19 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static void read_info_alternates(const char *relative_base,
-				 struct strvec *out)
+static void odb_source_read_alternates(struct odb_source *source,
+				       struct strvec *out)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *path;
 
-	path = xstrfmt("%s/info/alternates", relative_base);
+	path = xstrfmt("%s/info/alternates", source->path);
 	if (strbuf_read_file(&buf, path, 1024) < 0) {
 		warn_on_fopen_errors(path);
 		free(path);
 		return;
 	}
-	parse_alternates(buf.buf, '\n', relative_base, out);
+	parse_alternates(buf.buf, '\n', source->path, out);
 
 	strbuf_release(&buf);
 	free(path);
@@ -257,7 +257,7 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(alternate->path, &sources);
+	odb_source_read_alternates(alternate, &sources);
 	if (sources.nr && depth + 1 > 5) {
 		error(_("%s: ignoring alternate object stores, nesting too deep"),
 		      source);
@@ -599,7 +599,7 @@ void odb_prepare_alternates(struct object_database *odb)
 		return;
 
 	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
-	read_info_alternates(odb->sources->path, &sources);
+	odb_source_read_alternates(odb->sources, &sources);
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 

-- 
2.52.0.270.g3f4935d65f.dirty

