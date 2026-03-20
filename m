Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D535A389
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990482; cv=none; b=qhwc0b7uI3PeDD3/RbPsZ/iuuJ+wopuYxCW6R3DttFtX8baz+T44go7hMsrKot8wbHZTmMjwga9J363Xcf9n41nWCeWJZC0M+Jw8hFMCA3m++5+tlnZsdT6laJIvd5UrRTw/V6nvnRnxka+X4dGQC0Pf+hz3oEP3XI+vNMImDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990482; c=relaxed/simple;
	bh=J9E49YDiGPVsUirGwfLFHXGsF14Ob/EAPeTSDy7w+EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IT3djIuFGdQFFLUhhTUehMmBuaCgulTiILt8elEbQ2RV6m41rL2r1AzXXeci0sHel3U7u6nGnpcmmYGlj6wWG+M2pbIazgcUS3AzD6f5XsHKHdiEgGI7e+w2ugPrQhBHNMTZyWCHCy4U595e+lXf7P9qfvtdKRJhCfBV8+Uqy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GLEXfoSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zO/orc0y; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GLEXfoSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zO/orc0y"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C3B41400008;
	Fri, 20 Mar 2026 03:08:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 03:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990480;
	 x=1774076880; bh=G0rrR+1oncxpd/2mIsA2j/n81zdKy3UiQalMyLrYspk=; b=
	GLEXfoSdDqGWdtxGX+J35ZCRsLTtyk3+rxCpjL91M4t9tK3j/uNpqxbVbSnjMwjE
	SQ2hQIeo2ZKPBbgMLuinw9CUj+reYQkkgD/FqzOtzey/h89USHVUemV3UDWRqiLT
	sw0mVVkUoM/DqBHVwHYmtWVdZlaPGBwU9EtMdG1isfZ85x+bhaXBXY6+TDrhmxpR
	3GwE5jjrHC+dOJTv4qxZAiO0KSDzrHHbNa7JH6xVX1hOki4mOwAX7Mlx7gbyVDl/
	ZXO0PPJ17aC97fVMWY1udfSW+W7qEsFLnR9j993tXqrTWS5Dlble6e9l5zKIXkp6
	D9bs9zeMX+wlmdQbyz9ahA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990480; x=
	1774076880; bh=G0rrR+1oncxpd/2mIsA2j/n81zdKy3UiQalMyLrYspk=; b=z
	O/orc0y3PJgCOOt2mgoGyTjE/VAAVR7FOMo2nG6Ct0cBUbxAETnjURpwgo0EiOR4
	we0SXV9uUyz/HolLnC2Z/LvBdIEcvXUY8xk556Y6WkXFYl9hYPN0+WtWf6aUvc2O
	LvZBGSMAVIdK5eZQw+Y/Ux1uv8ERLkdVLZOlB2N25Qi0E2AnNPej9/NC4MDCl0AU
	QYUcRviS+NJfc/skKZgpJVf5GU6A8dlOQ0iKucTNtxgUVDpvw8PF0AoAietUyGEF
	Qi+TAq1Lk/304RLhtc1WSim5h6hrmxXh/4wE0bO1aWqdxDylnIlYcjWjl3YMKLpd
	RWLua+P0ninmOosk2ktNA==
X-ME-Sender: <xms:UPK8aSQ2h9oVg5MGXPLG8c3qVdtuxPE_1OdXL1I4ZPPXRvM196z4DA>
    <xme:UPK8afNcOFlWtv-kUri2Bf3FDHpXWniDCAYCa_COjUgKvDXsQ5hr7HXH_jz7C9dGz
    ej8f92XZVhcFqrbtooY58uVZuInY84NBrXNtNQjUR7JGOj9yS6EzQ>
X-ME-Received: <xmr:UPK8adPtAz9TU0VdNNIdxOPjLyLm4dr0ZU0YaRccwVk4DyIim2WkA6xvd5YdYhl0T4dx88cgYBkouW7kvW2zURcG-A_j0RgEt3qiL9aoCpL_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:UPK8aXtYpn2-Ttr9-5dLFSBkMZ-U0mvLYA0LiJjSNjKoPhNPRsa2hw>
    <xmx:UPK8afWpF5nHrodKU5ZAts69qz8IbnmPE555kv707TfA4cx2YvAoIw>
    <xmx:UPK8aXv8MqAlQeMTe31L5AK_GGHtgNPC21SwIzDYExowrvTFqFGEOQ>
    <xmx:UPK8aTUMw91j-d_mlWCBOR-md7HKrNQImsAUxoNAv4C0Fz2acMI--g>
    <xmx:UPK8afOUzUcjbX2XHDZRv8OX-oztld1TUvKLmyNA63VnmbIHJNtRjYox>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69ed3a6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:33 +0100
Subject: [PATCH v2 07/14] object-name: backend-generic
 `repo_collect_ambiguous()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-7-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `repo_collect_ambiguous()` is responsible for collecting
objects whose IDs match a specific prefix. The information is then
used to inform the user about which objects they could have meant in
case a short object ID is ambiguous.

The logic to do this uses the object disambiguation infrastructure and
calls into backend-specific functions to iterate through loose and
packed objects. This isn't really required anymore though: all we want
to do is to enumerate objects that have such a prefix and then append
those objects to a `struct oid_array`. This can be trivially achieved
in a generic way now that `odb_for_each_object()` has learned to yield
only objects that match such a prefix.

Refactor the code to use the backend-generic infrastructure instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/object-name.c b/object-name.c
index fd1b010ab3..4c3ace150e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -448,8 +448,8 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
-static int repo_collect_ambiguous(struct repository *r UNUSED,
-				  const struct object_id *oid,
+static int repo_collect_ambiguous(const struct object_id *oid,
+				  struct object_info *oi UNUSED,
 				  void *data)
 {
 	return collect_ambiguous(oid, data);
@@ -586,18 +586,19 @@ int repo_for_each_abbrev(struct repository *r, const char *prefix,
 			 const struct git_hash_algo *algo,
 			 each_abbrev_fn fn, void *cb_data)
 {
+	struct object_id prefix_oid = { 0 };
+	struct odb_for_each_object_options opts = {
+		.prefix = &prefix_oid,
+		.prefix_hex_len = strlen(prefix),
+	};
 	struct oid_array collect = OID_ARRAY_INIT;
-	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(r, prefix, strlen(prefix), algo, &ds) < 0)
+	if (parse_oid_prefix(prefix, opts.prefix_hex_len, algo, NULL, &prefix_oid) < 0)
 		return -1;
 
-	ds.always_call_fn = 1;
-	ds.fn = repo_collect_ambiguous;
-	ds.cb_data = &collect;
-	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
+	if (odb_for_each_object_ext(r->objects, NULL, repo_collect_ambiguous, &collect, &opts) < 0)
+		return -1;
 
 	ret = oid_array_for_each_unique(&collect, fn, cb_data);
 	oid_array_clear(&collect);

-- 
2.53.0.1055.ga2ffed1127.dirty

