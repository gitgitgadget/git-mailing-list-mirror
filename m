Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BE2DF145
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055280; cv=none; b=VVwCzV8WY0oqrZv3OvVUqaeHBqO9J8PG+tqgsie5VDReQYIa1coWSdXDfi9YOAoUt9+yZJ2w3Q8BdqT1DYrwPcIwVPotE+vK0lxOqCfEFBJHp3boh3PiMwz35f+zcGOSx49lPOJyOMb7E5xBhYKU0v2iLPYuhOg54vMv001JFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055280; c=relaxed/simple;
	bh=A3dv2nUoP1+WFi+63suCEwYQcYuzafwxvDK+tauuERM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMhyk25h8GK1TlJB6vpCI1pM3lSC4oRAwB0Z1N63vraqc9UPgZ5756TQZ7cWO8rMVCaLforKYJozN0waL+kJgQNFS79Gb+kR1TuLHm8aMwzvFH3vA3HaWPQZIq89upnZUuWOyIlJ3YpmCr8r9kAmcssD11mV35IKzfOXZc88znI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=opt2TL3k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUcjQWNc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="opt2TL3k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUcjQWNc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E5EF7A01A2;
	Thu, 18 Dec 2025 05:54:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 05:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055274;
	 x=1766141674; bh=w/5kUjgcOJBNsselj7UU2mYMfU4ngdP0mvVUMnIwhw8=; b=
	opt2TL3kkW6k2v7WD5Ct0Z+0mwfLkiqplXxF+ZCisDkTrzJZR1ydfe885A2WVA7Y
	kvmPXhP8bRZf+XPgFNiqM2zA5kSbVRI4kNu65qkYqJhr59f7ghIJU6Fr7Hhxaa9C
	A+tZrN3YOA64l8uDdusalDI9L/tqvIr4MOJQWf+aXdouQLxDF/nTmeT7Sf+XFNoP
	1FjteZHhfKIZu7yO2/Daos4Fvf7ZodnUYJWeEdaqwBv06cORf+Y000MaZjbzwpsP
	1T/RVoRkZUtvmeIEUPYNQScyhqE8UoHxwX3CMoF6uGP9PxfDaPjOJuhGVjJSkD5z
	ZD6kPP8y2CIaJ5ilGWIp1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055274; x=
	1766141674; bh=w/5kUjgcOJBNsselj7UU2mYMfU4ngdP0mvVUMnIwhw8=; b=J
	UcjQWNc3bvuyf1xAciNYXe+qCsFsvHIOIVwzXjdei8BC19ZwGytuU4aS7tADqCA/
	dzD4HEToFINzS6bRQqrV634x5oZSaCqtxXffGtYoDoae0TbxqG9m44fKiDU/Ug4s
	gWJKhYZW1kEKHyIIV/z4RSFWmzvNoJAUp2f2Rqh2hsnXevnfHw5YqYa1Z/BYsoDQ
	q/cuk00PKlRJurQqOj6bfaRKvHGZSbWvWHlubxuxDCCLAZYedU+06DwfSO1tZkpH
	yuot2RJBIA56Mno6RUmB7u1V9mBI2y71VNk75r7kZSg5FfuuGBMBhF0mEc6nxI4+
	FlCh+veKi1OzP4f2AkLdw==
X-ME-Sender: <xms:at1Dab7QLBQBQzr8zos5p0op_XFrsCrbvEU8zCqxfSK9UkNHUnQVUQ>
    <xme:at1DaYWMmb_k79WLOnHbZUAgQ8GzjQunquR1qGlGZDbyodF1WDw6RUxweOIsUP5c6
    vzmTz2nWAYI2P9QndExQ72jM20CZQ71CW67oD0Z2S4f_rOtM3Zcfw>
X-ME-Received: <xmr:at1Daf1aup0DRKLfVu0Rcb27uci_G9dyLyqs7kzdfLn8p2MeE-XT5RBfoSkfHmE9qmODBBBR26eS6Jswa56QfCBPiQB34FiZE9cAdvIGeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:at1DaV2PHsbuCxtLnsJBeyXJOHL793mWLMwzTRDcLHlPjH3-bMWYpw>
    <xmx:at1DaS8U7gnJW9dqWavfS_fdbXBHPN-C8A6GsgIX6UQNABX7MtdSfQ>
    <xmx:at1DaS1TZohZIvU0iBS7gF8LB6x5p5A1Dqk7m_V5IU0nCiXKBs8afw>
    <xmx:at1Daf_hmiM-DVF-DW_4a7RPe1LX4VjfS8MR1K5K2qZvp91j54c0kg>
    <xmx:at1DaXef37KhcpPLO31leaDN-RxsOxImNZCu67JNQuG75qwbQ7dHmJyq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1af3ee53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:16 +0100
Subject: [PATCH v2 4/7] packfile: always populate pack-specific info when
 reading object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-4-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

When reading object information via `packed_object_info()` we may not
populate the object info's packfile-specific fields. This leads to
inconsistent object info depending on whether the info was populated via
`packfile_store_read_object_info()` or `packed_object_info()`.

Fix this inconsistecny so that we can always assume the pack info to be
populated when reading object info from a pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index cc797b2b6a..f7c33a2f77 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1657,6 +1657,20 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	}
 
 	oi->whence = OI_PACKED;
+	oi->u.packed.offset = obj_offset;
+	oi->u.packed.pack = p;
+
+	switch (type) {
+	case OBJ_REF_DELTA:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+		break;
+	case OBJ_OFS_DELTA:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+		break;
+	default:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+		break;
+	}
 
 out:
 	unuse_pack(&w_curs);
@@ -2156,23 +2170,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 		return -1;
 	}
 
-	if (oi->whence == OI_PACKED) {
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-
-		switch (rtype) {
-		case OBJ_REF_DELTA:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
-			break;
-		case OBJ_OFS_DELTA:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
-			break;
-		default:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
-			break;
-		}
-	}
-
 	return 0;
 }
 

-- 
2.52.0.351.gbe84eed79e.dirty

