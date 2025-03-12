Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D1258CC4
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794986; cv=none; b=AcUw0Z6ndsF70mD7K1eu1my543+mDA1ZC1lDtjPMB6xewxNvdK7CUy0q9meSgDsDRrHCVcx7PTn+UyeHA497pqwtKWYvkFZ+qPLhyPBRocKfvgLsn/HHbBUpGCj/zM7M+EdHLKecNArR0Td1BX8QOtdDjtGRJsknb6yum1q0+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794986; c=relaxed/simple;
	bh=evGhBHEShvx+Wz2OMlhodH3XxHSprNJWfhaFexf0qFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sY8hx7DdaYU6yTZPg28XHMsuYioXpLwL+2y8XolA8enQgtWU8y5VVSJNAdEUdgN/ikdVJSaR4QgkGHtdAsmeT1pAC5VTYg7LO+baXYyUAJdXJpqq5fBD/kWEayrpQOokdnEJGG7OPWt/XIZJ4FBwYsJeQZsmy0U1Ej+syQ0K3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hhKl3150; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1YUqBsu8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hhKl3150";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1YUqBsu8"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAA01254030F;
	Wed, 12 Mar 2025 11:56:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Wed, 12 Mar 2025 11:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794983;
	 x=1741881383; bh=3DdDV4H8cwIMEb61hTghlIJjMifNGzs3Dki56QedE+M=; b=
	hhKl3150dkKogbkA33+umxk81vl+UA8L7k8bhCwxTeckfExjwwjp3gsUedblvjh1
	F62aqyoyIEhLPoqj69z0G9A3bud2QPkLBYKqrYUm+GrWrNFoy+gT7CxUnb3ym14l
	RIk7zGrd8NMZGxz8A6m/mAGQqOofe5xo2y4xmFXHR9BTBlCutEoYbMF5a5z5oI9N
	CIZZEEZCJLBpqdYtODxrWIZ0XqXffgL1WejcQobGDmiCfYdvUgOeHw2v7ukuWmXb
	qzRH/0H+icDF9dGrM3L8Fxkmb3CDv/DJNhBuW+7eEsDJ96WFMa5jLJeLRxXAGGYp
	QnLG3EZjMfglUCyRgO581Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794983; x=
	1741881383; bh=3DdDV4H8cwIMEb61hTghlIJjMifNGzs3Dki56QedE+M=; b=1
	YUqBsu8SA1R14HEGaTOJiC03Vrw37ZfiPNdokDaVWn6hnciiMJrAqdTA8iOBDDE5
	LwqRAKpT525sD24AA0/P5QSbS8wFNUBlCfHwdj3JZ1nMArocNbNUxzB3mtHuaX0f
	fl3++CtwDGwbPchPMA/yNAwBNjwece4k9AJPH0+hfSCvVFFE/aNUyrkH6CD1nsPT
	P1dUwIVX97eifBHnt4WaZO1S9JCMouUvCc7kp6nkxFtUm4ENpk2Yf75qTnHSqtln
	BNXVElJc+YYqJhldh/+AaRFEV6YcdcWlPULgkuD+EKIsTCtSMBFRZ0YONx9ubalx
	InU13P5skF01NRpvqpHJA==
X-ME-Sender: <xms:p67RZxn454Kg_HId_qzDKoTygOyJMH8ETEENnzXWqds_1q7uzng8wg>
    <xme:p67RZ800rdLib02otv6NHrqXJeZ_qHso3GbvfR47ctJXaVLtZOXgq6BSlJfxxfWCM
    IPNwpX489uxBDmuEg>
X-ME-Received: <xmr:p67RZ3oBjLvybb-IhRe-5lT1kz73YUXmFF5yioT_p3iqOT7YkKK2ZgV63cRxvwMQTkeq8-PnctNZYz9K-OhBw5rV3S5WS4-F3UHN7TQ5-lSEa6QYqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:p67RZxmpSxEcMQkt1UBjWIL2k7rjmNY3QKIwVa8_utqtN3xug8pvGQ>
    <xmx:p67RZ_05cyQnlmQtfNJXjlupC3ZSTq0kMKYzjtSXZLysCYGHbQTajw>
    <xmx:p67RZwubS2cnVbexwf58VddEH-th-ry4DLQ44iTSmW9ZdXm8p-cp7A>
    <xmx:p67RZzV3PtPlQhI0O3OB5DVQgojuSXKZgcPXRtmGO560xL4uXzGLuw>
    <xmx:p67RZ0mMsZffoHeY85hibZIhHaRnzgREDHwtd1pBnz-QeOG10RCi_wM6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6dbb1931 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:17 +0100
Subject: [PATCH v6 11/16] refs/iterator: implement seeking for merged
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-11-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking on merged iterators. The implementation is rather
straight forward, with the only exception that we must not deallocate
the underlying iterators once they have been exhausted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/iterator.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index ea4db59481d..766d96e795c 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
 struct merge_ref_iterator {
 	struct ref_iterator base;
 
-	struct ref_iterator *iter0, *iter1;
+	struct ref_iterator *iter0, *iter0_owned;
+	struct ref_iterator *iter1, *iter1_owned;
 
 	ref_iterator_select_fn *select;
 	void *cb_data;
@@ -160,13 +161,11 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	if (!iter->current) {
 		/* Initialize: advance both iterators to their first entries */
 		if ((ok = ref_iterator_advance(iter->iter0)) != ITER_OK) {
-			ref_iterator_free(iter->iter0);
 			iter->iter0 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
 		}
 		if ((ok = ref_iterator_advance(iter->iter1)) != ITER_OK) {
-			ref_iterator_free(iter->iter1);
 			iter->iter1 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -177,7 +176,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		 * entry:
 		 */
 		if ((ok = ref_iterator_advance(*iter->current)) != ITER_OK) {
-			ref_iterator_free(*iter->current);
 			*iter->current = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -206,7 +204,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (selection & ITER_SKIP_SECONDARY) {
 			if ((ok = ref_iterator_advance(*secondary)) != ITER_OK) {
-				ref_iterator_free(*secondary);
 				*secondary = NULL;
 				if (ok == ITER_ERROR)
 					goto error;
@@ -226,6 +223,28 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_ERROR;
 }
 
+static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct merge_ref_iterator *iter =
+		(struct merge_ref_iterator *)ref_iterator;
+	int ret;
+
+	iter->current = NULL;
+	iter->iter0 = iter->iter0_owned;
+	iter->iter1 = iter->iter1_owned;
+
+	ret = ref_iterator_seek(iter->iter0, prefix);
+	if (ret < 0)
+		return ret;
+
+	ret = ref_iterator_seek(iter->iter1, prefix);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -242,12 +261,13 @@ static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
-	ref_iterator_free(iter->iter0);
-	ref_iterator_free(iter->iter1);
+	ref_iterator_free(iter->iter0_owned);
+	ref_iterator_free(iter->iter1_owned);
 }
 
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
+	.seek = merge_ref_iterator_seek,
 	.peel = merge_ref_iterator_peel,
 	.release = merge_ref_iterator_release,
 };
@@ -268,8 +288,8 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 */
 
 	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
-	iter->iter0 = iter0;
-	iter->iter1 = iter1;
+	iter->iter0 = iter->iter0_owned = iter0;
+	iter->iter1 = iter->iter1_owned = iter1;
 	iter->select = select;
 	iter->cb_data = cb_data;
 	iter->current = NULL;

-- 
2.49.0.rc2.394.gf6994c5077.dirty

