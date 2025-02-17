Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AF226164
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807441; cv=none; b=HGskIwX/cYbpFvZnqzwSNULwO+iqYtpikJA4+z4bifkHH2AEQP9NN6MNdysOzpkgAXCPddkLXREM50WcN+Mx9+Cp65UhqcpqcEEZ0NtAEWI+1oigHi+GjaZDDkeDILkvBWnP8zxac3QOu1dVpydWto3KXAUuNgeFqUlF11s6Qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807441; c=relaxed/simple;
	bh=FAw7E6D8hVaD2NlviC3DKf8NzcOCLFWq3tCAnYrXw7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFbsXy8mlo+Kw4TGwzg9GNwHI8T+uG7fQCc69OycEo/tPKRFTFKuBWDOMoSm4jSVWYyjMeq2lI2TPHsB7eSXzK62fLceNH1/wT9vgwqsi+NUJc2BzFVaT1V+aAVf/jKN86vB0ZcfTUBJu/HIpxXOFOskBXL6lRSLJ/BRlytPr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ty5iWyy9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGNNzf4C; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ty5iWyy9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGNNzf4C"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D00931140190;
	Mon, 17 Feb 2025 10:50:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Feb 2025 10:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807438;
	 x=1739893838; bh=xnYZPOJE4NpKJ4WHQ+iMDRaEa0xJ0PwXGnTVFnK9OUc=; b=
	Ty5iWyy9oPUdPIgtmy5nxA8bY4dLeGB1OI6mCpIYJj7F3C/zrSXACj7ce4j3Tt1Y
	IeSS8dcf/nV2sWenSoqGK3CzcnwVh17VSmDL1fikkmigeLYN/oK9rJaJ++gwKjB4
	qk2nq686t/GSqdVCP2xUjQOHuelhvJICEKcfJsSVNnO7wI37t6/r1/FQsSRJU7MS
	NHsQnZpaWTTMp1i0HhjiAq/ZZwoaBBSqQE3xCpOihdc3O9VnR5XtmKyqXiw0B6jj
	sbidF4eVk+PQhzf0cB3Kt8kb5vLZNmY1BVJLOZ4bVK0oVWA2Z0oNYSXEsu3NAhzR
	2TJ8MKKyLrGTHqRvW/EDkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807438; x=
	1739893838; bh=xnYZPOJE4NpKJ4WHQ+iMDRaEa0xJ0PwXGnTVFnK9OUc=; b=l
	GNNzf4CZp6TpmoREIZVYvcLaOsGHnS2Pex8bR56hoNjI/Ck1GdnnvS+hx/Z2rEvC
	3UMXldrAYWD2JJycjqmI5EQeyORXZv2A0uTvSM7Is+8+Ow5SLpP28QPvBsgvdmhZ
	RyRfU4xVHCMTEDkGwwlnTWwkepMWDzNJjhywGGuVOccsQ+sxNj2MDkaTOzfyygPx
	DcDeeNZHZcnGTwzs7lCneRGfZ1qqXSQ8ixpt59klZCPS4MOD60+Mbxl26VLpp7hO
	c8ObDlKqAx1USymDseKKFVLDT4TvZL4FguKrdvIIJnZY7290LWfVrvlbz9YHI+U+
	+TQQIjgGoojwWqt/hn6BA==
X-ME-Sender: <xms:zlqzZ69vBhJ4JqJUcLfbaUkwDjXkeDb-iQlamIkRr23se4cbqjB5lA>
    <xme:zlqzZ6vjXnR1IKNKfd4OB8B9odZy6m6fMxICnoltfF4IIYmoFf_i3h26MsLS-yjHY
    GApUtkTLUF7a3l7yQ>
X-ME-Received: <xmr:zlqzZwDq9u91LbNLEwdB9PqyukRNzPddkUaRkeBN1bSMrAbuthRUox99U-1Dzkv5TR_wvjFJUYZA4hgl3yifKGmEASzb0qAe_t_iIxSZq35ucA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:zlqzZycOQf-SlW8MCZTL8d-arcqyJpZWiXQcsYu48xlCvj7KXL6UnQ>
    <xmx:zlqzZ_PUoTs4E84WbwWUAlfItSh9qxIYMo07D7ym2-20QtHDFEPEsA>
    <xmx:zlqzZ8mZJFR_W6VLMLAlvFJcSal2aEpT_GDeTsxjXjSZRUkjr67_cQ>
    <xmx:zlqzZxuiqTtKu255n9C-pQhRC_1eSU4m3nR45sY-jTGzzZjojMdgeA>
    <xmx:zlqzZ7AeO4cy47Eq4UCnMdhvPSSclIgIUasKGE87z9GqY_DFhRoPwjlc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd3f6110 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:27 +0100
Subject: [PATCH 13/14] refs/iterator: implement seeking for "files"
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-13-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking for "files" iterators. As we simply use a ref-cache
iterator under the hood the implementation is straight-forward. Note
that we do not implement seeking on reflog iterators, same as with the
"reftable" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9511b6f3448..acc28e1ad81 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -922,6 +922,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct files_ref_iterator *iter =
+		(struct files_ref_iterator *)ref_iterator;
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -940,6 +948,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
+	.seek = files_ref_iterator_seek,
 	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
@@ -2298,6 +2307,12 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				      const char *prefix UNUSED)
+{
+	BUG("ref_iterator_seek() called for reflog_iterator");
+}
+
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				      struct object_id *peeled UNUSED)
 {
@@ -2313,6 +2328,7 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
+	.seek = files_reflog_iterator_seek,
 	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };

-- 
2.48.1.666.gff9fcf71b7.dirty

