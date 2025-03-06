Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4F20897F
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273731; cv=none; b=WYKjOIkqTcnIzrcAgsmv0+qmgg++dC9jsQMyBf9vyN1YsXAmfBwKJ/4gZ6ov43tsITOK6yI7nLmG9trzVylyD0cbUy+jgeQ9a81hcYCnF8wERv4Le2ihAW3BKAq+5RaSPYnxs+Ljxwg+kaL+lhPizTeHi7jZMHMvN6iNll3uqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273731; c=relaxed/simple;
	bh=BF5wtmUe1XZEe3gRWoVlmpeBoEvugVXNMSCQKdPZZRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cx+NHMv7H7Mqhyw7ofaotVv+edtaSZooBUTEz47FeAcYA0Gzp8sfzAASySVtmKYaGERLGZJBRYjBdHj4UEJVnXkT2pryBT4vVEsLJECnUbSVrX79m30TjkQH2IDhW4BVBGJul3X9n1BNJiVZaoh+GJzxhvtL7s4sm9WQFN9JQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m5LeIkOn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=09bABsk7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m5LeIkOn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="09bABsk7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AEF91140106;
	Thu,  6 Mar 2025 10:08:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 10:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273728;
	 x=1741360128; bh=Gkpk2yNagRtaVqgMY0LYBj2dB1FOlgSLKE27KW096RU=; b=
	m5LeIkOno1kjoSA6TlMdcfA0jBesRXotzNPaaw1tTIHr5tgU2sSNUQJ6rETbgewW
	D90UyA7Nt4VNaL4kNYBNASabh1v42FmRz7QbVy3ER3KrGS8KpVXu7yhVGfPja6gP
	aCQqA+pEMUnhzyxtqdR6grzhHPuBbUgGQuyr0Zk3yel5hADyAYPCY0CBCo/oE1gX
	mQsT0XtVnEYXeD8mzCnd1tbivD6+lZjdIPjpozm3unG0ErKp7XsYvSAqTFN/m+iV
	gOZkPNl+jPZWRBF2beNzvencSapDXZRhgAbdmeYmdeZdXUbqmVXh/xa6CqqU0Lkh
	hWuEag9K00A+ap6nnXo2Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273728; x=
	1741360128; bh=Gkpk2yNagRtaVqgMY0LYBj2dB1FOlgSLKE27KW096RU=; b=0
	9bABsk7tQIYkBHwZf4rku0aqcj0rha3oba6kBuwcn2k9RPXkjTaJT/7a4ugiPc83
	I5eusjR4OoX6m6wg9VYRQEhUF8x0X1CUF8xoIxprVu+gvHNBf34RGcc9NrPXUJjP
	vjLIROMOfBGwcH++fLbjvD1QCASacTgPpZ9A57I9vDf+UkMWONd/okxbJ0iyMORQ
	n6zPhWvG8jGGUpemCkX497/Nfzw7PkiEl6Ey0qJkvk0p0o0wsWkGStB7v2iqzP5z
	Y6BuDSayPlXQ/cbDe1UKykTrENx609ZoPupvLPqF1u0GlWSJaVYiYni2wwfy9Shs
	2O6Bc8ddTRuNCc3mKrJjA==
X-ME-Sender: <xms:gLrJZ5JH93sys9-whQUz9pnAVCmE6oySACdFl5GULh4VzBMeYGeFYg>
    <xme:gLrJZ1LBJNEhAEQoLexWxoKHHnES7QB1JhMKqYW7CGMEZRQzAnwyRwOcrblPuDrrE
    ffR6A5WNU_XWQ7ppg>
X-ME-Received: <xmr:gLrJZxtUTl2YStPrqPLv8uRHYmuu34QCStLo0H3z6ZrJH5LBdmjX_OHtcVR0NxTfR8eLZVxrfkUY5ogvCGCNzFvhq5D2mcHlOXT2wAH34o_74A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gLrJZ6Z9sVFfrtsNcgd9fkfgbK6teTlovl06wZX1KD62VBh-cRmSwA>
    <xmx:gLrJZwZowUTC2r0l_Hi42dZ92m9m1S_pB8Lge20wSN-Sth_wxTO93w>
    <xmx:gLrJZ-BKPaSJVuBZ4YR_gyRNQ7HNwEoWnt-XKLoHuWDmGZbUYLyB4Q>
    <xmx:gLrJZ-aye7iq5tL2EN26we7JYqgmh5f_TmJVi7Td9khsbogJj-oixw>
    <xmx:gLrJZw5Eaa8K0v36lX1zN8iL6rFGelV2spMimFzHk4K9Aao3ektVk2_x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d90c211 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:36 +0100
Subject: [PATCH v5 05/16] refs/reftable: batch refname availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-5-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Refactor the "reftable" backend to batch the availability check for
refnames. This does not yet have an effect on performance as
`refs_verify_refnames_available()` effectively still performs the
availability check for each refname individually. But this will be
optimized in subsequent commits, where we learn to optimize some parts
of the logic when checking multiple refnames for availability.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d39a14c5a46..2a90e7cb391 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1069,6 +1069,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
 	struct reftable_backend *be;
 	struct object_id head_oid;
@@ -1224,12 +1225,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * can output a proper error message instead of failing
 			 * at a later point.
 			 */
-			ret = refs_verify_refname_available(ref_store, u->refname,
-							    &affected_refnames, NULL,
-							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
-							    err);
-			if (ret < 0)
-				goto done;
+			string_list_append(&refnames_to_check, u->refname);
 
 			/*
 			 * There is no need to write the reference deletion
@@ -1379,6 +1375,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	string_list_sort(&refnames_to_check);
+	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
+					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
+					     err);
+	if (ret < 0)
+		goto done;
+
 	transaction->backend_data = tx_data;
 	transaction->state = REF_TRANSACTION_PREPARED;
 
@@ -1394,6 +1397,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	string_list_clear(&affected_refnames, 0);
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
+	string_list_clear(&refnames_to_check, 0);
 
 	return ret;
 }

-- 
2.49.0.rc0.416.g627208d89d.dirty

