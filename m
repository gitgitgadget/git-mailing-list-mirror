Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFB25742B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794982; cv=none; b=AbACkQviacxlth1oCwVsBGIg3Q+asMsfILt3gJ8x3gRWaKGdGt8I98iiTnuXaG3qUfAengGp+RTMZg0G/1h04DaEd7nA8e6GlQcPI2WFVPKlEv0uZrkP99ndKZ+IB03eief0jSy705yH3O+I6V4gABdQzo0m4/s92bK7ZJndPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794982; c=relaxed/simple;
	bh=EjVHC1EIZ0R1PUcZLXpQz7r2BeoYcjhXsfoHHeAjovc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAL2vLWBdPzjbFa7k1YX5VX4U4rZa4StYUpWc1sI8dfCHAkNT/OY+h0Wi3MNkeX6zv/YLAfMEg+VUIwqGeX9o6yceVEjlctuecyrS53gKHWiaLdqHSqFyjs4+IjJEGgNQLNr2EySge4HeFDu4VhSHkuIPJmupCdNkbBEWv/DGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VME3n04Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieKivxEq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VME3n04Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ieKivxEq"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 89E5A11401FD;
	Wed, 12 Mar 2025 11:56:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 11:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794979;
	 x=1741881379; bh=NYAu38YE8k8/ou1s8l7G5tJ/gDFRNhbdH1V2zh43yss=; b=
	VME3n04YB6YZFtPVB2o4Xpxr4TyYau6xxnc7SK0xhsUtYuUBpp4G+RAvYd2PiEDM
	5MNDiAj5xo/hxHCK8ARzWoiI8RhLjH2PHVEdFE7gbCRzgSwuZ7l6nsnnHwvntYcJ
	QPb1nRIiKThPvDMFgBtnCzQwqBeNZYCDFS2DQsSgU3SLsjZsqyq6ltDJ/3KTY7rI
	XtN+hQMRDPak6A6a10a80SprGIun3/8io+M69nf3PUVaM3rNSrS9GOnnttTt+vJp
	K15IEJyyNR8Sr+bykdZI1I33slzZayWna0FmmHGHI/nX3txvIF40TbKk4sJNOiF5
	bRJkLA/s+aP+K30YGj/wlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794979; x=
	1741881379; bh=NYAu38YE8k8/ou1s8l7G5tJ/gDFRNhbdH1V2zh43yss=; b=i
	eKivxEqRu+wSX892tsYz7T9lzSmOV4T6TcQ6YRkvPlG3oaTp3o175w54KZaDfvUu
	QkVS1rqUeScglaDX/68i7GFP8MLXgwJKE+wAjTi2Hf6VyPgtL8dne6SDH74gCZBv
	k0xYzT099T744iuF0VORUYrJfozCYExVgtMbrWSc3UqCkpORUbru4rtttIlepE1U
	jWmhtkJ49PDJ+zo7uaXlPrhS5VgZf3QbeRtx6AL5Qtsbws/+Sur+ZmS97qMPwaK2
	qeejfE5NYvoGzoUA/+qvJ/sZdzAkJDKMG5ZeH5nP5eF1r3cH3Nr6Jr1zZ+jKCxHR
	Vor8BNX69th7kS25PjKkA==
X-ME-Sender: <xms:o67RZ2zKjP2Xe1ZKVbrTp21DkeDx7jKgha6Gsl0T0AMVp9Hnppp4IA>
    <xme:o67RZyRUVf68hpbXhczch5nJu0yKsGC7Ty2VbJ9bRkpLYQtB4uLCwTawqpjlbYpbC
    uOTpw2-yob3b-oZLA>
X-ME-Received: <xmr:o67RZ4WDfbSxZMtkazujDXSiG9mnTUfeSNqQrDUMKDZTcjMkNXW93mcj4v30KwQeVg9j4P-biHmLjWxY7UV2GANem3hnIjnctMj6hEHU3kr22okcpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:o67RZ8jpGXeGXvaRWLOnDH6GXyobeg2nwuLTK1VFTcSRrveLWadrfA>
    <xmx:o67RZ4D-tS6yKXfRf5uuZGcZHO1rB4Zx-a-_OoeyQ0adLxyEQF6j9g>
    <xmx:o67RZ9L4CoWptZWjV3BCBs-hBhtL93hGDv3mPXUFh0FjeOyZ2UE0Cg>
    <xmx:o67RZ_AubnFWGKILsE9CuXP7dvXbzPrXVpMLKKe-rpsVuStVJpcXNg>
    <xmx:o67RZ2AvDNH6lPydzHmxbyhKZa8kQ3ReVlMNlU6ayqc74foyWm2Ar37y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 922642fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:11 +0100
Subject: [PATCH v6 05/16] refs/reftable: batch refname availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-5-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
 refs/reftable-backend.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d39a14c5a46..5c464b9d143 100644
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
@@ -1379,6 +1375,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
+					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
+					     err);
+	if (ret < 0)
+		goto done;
+
 	transaction->backend_data = tx_data;
 	transaction->state = REF_TRANSACTION_PREPARED;
 
@@ -1394,6 +1396,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	string_list_clear(&affected_refnames, 0);
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
+	string_list_clear(&refnames_to_check, 0);
 
 	return ret;
 }

-- 
2.49.0.rc2.394.gf6994c5077.dirty

