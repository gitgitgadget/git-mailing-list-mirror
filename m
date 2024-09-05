Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE719938D
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530968; cv=none; b=ag1YbQXYt1Xi7h8mTDP/Bpzq6IztwVT/kQ06Nj5z3UEHBSwPTK6eUyIfe9X61LopBZ2p1CTstTzqF1+LaCXCPmER4NUc6rJKaBKEtEU+iN1lJ9Opcd4LWSwswAFHjXVLtOAEQ1Mu/pxZs8gp8lVvp/6eDlKoLJ1zhAyFh8qN1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530968; c=relaxed/simple;
	bh=84HOOY/1BwEXbQqHLt0FNDWmSDtgDj4Sm0UxGkQRfUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0EpA0lhyUs9VHdF6Y+4/4sgZ4gdF0z/gfNoGPU6gYDl4xvxaeySRjpQF3EerOA5Q21CqcRKGf/iRTUNjG0dvUIR45ikqQqAXgAFQ/CsKXV28q1i4xhQtcSAe/2BCApm67jSjeYcnLNbwhKfAOtwU3ireG1IreU9Wwp3X2tg2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hGiGFLIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jWkncuCG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hGiGFLIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jWkncuCG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 640E0138034A;
	Thu,  5 Sep 2024 06:09:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Sep 2024 06:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530966; x=1725617366; bh=rXhjDEdxbV
	onkdB2KRrpDpg6E05JKW39AhwEM6fxFZ8=; b=hGiGFLIBFqlFwb77uR7fQjYKir
	p5E061nvQaGGHEZGUXURIfGqSOi0fP3y9wcByCb5dM3Ok50dwcgSeBgO8tsrk0P2
	Lwm/uIwII/8i4lekhnQIuG1xxHIFVMx3Ag22pUgc1lklQ3cqVP1yQ5okL8eUkYaa
	/lxVbPW5nK0UDWoGZj4zp+ZM4GfgGmESEbzt0myHOHBA62AiYMTbWX8axIIoGejp
	0E4CGW2H39zOk+R6Pysk7VtM43weUNKDLaPNTI01K2KqEXGNyfr/RzSkCJwLznSH
	0zvYTULdYqlHFlBUy7nPqc8tGn6MfkpNY4oAGXHrpht7W4GAYzm2/xu8C6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530966; x=1725617366; bh=rXhjDEdxbVonkdB2KRrpDpg6E05J
	KW39AhwEM6fxFZ8=; b=jWkncuCGw7Z5TT3azB7lB/VIdA7QHkzxC+ZVbEGiJdFk
	gc0Dq2zglodiAU7EKhNcy2cfXsNIV5Kx/ZWawaUojlip2nEQtNNYj5/haZT80f+r
	kWzwvAnZoXANeYHfpFjoXE3ouCA3nID74gkoMU8HsjbwELrCIF8wSbPS8/BeKk40
	dLv0G7e4jsAMbLN8E9lnLjqyuljvH5lXIHx5JfypIPTTCsL55fP6H3Car73CqRPs
	F1Uwc/ftS9MWKXmT5o6mVA5WRRIkdGGdyW7tV8uEdq2iDFv7xPxapt56lysjWgn+
	HWS4lL+4Gh10yXuGWQa5LnZTOz4o2aMKBJ4c9/1ttA==
X-ME-Sender: <xms:VoPZZocnqaM1ydn-vCI04koiUQEWxJhr_S12V4CHG5QTufpj65kvmQ>
    <xme:VoPZZqM683Jor34OazIL08k7xownWM6j4kAfdHppMYmYdO78FjV6prsTOmWKbGErP
    EUowDI1Xja3c-dLOg>
X-ME-Received: <xmr:VoPZZpjB4tf8DIyx7LH4b9UyYxSQQpaJ7c5gLn2WUBd5N_ZHDPLi4JmATcFFL7Px5t4ubWPBgYb2HqaNDUX6ueGSN2soz6Gd0fj7xTLkCBNaJN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhif
    rghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:VoPZZt9pfjIoZrJnYEIAdDUfxx6DBD84lXqjs3A-eYZzxRMBSqxj3g>
    <xmx:VoPZZksyyUpVFMtoFpHXa2YOF4aNGU1RPdATA2A5TNfFAU9wakzOaA>
    <xmx:VoPZZkFo5ILQ-pRGOSz5HIV9mkyuta6pL8iT68kZOwsaqzIckDxuPA>
    <xmx:VoPZZjNbdN25eXJYxLt3rznOE02nTD_IC2-3pkrDCxmAseeWtC6bpQ>
    <xmx:VoPZZoh82xRf6GB61lqGmGLkY1epetqT6btO_8euPr-zRVxQkm4aCLiU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a3022ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:13 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 16/22] builtin/repack: fix leaking line buffer when
 packing promisors
Message-ID: <78c1e5e1772d8920859588c4eaf67faab0b5730e.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

In `repack_promisor_objects()` we read output from git-pack-objects(1)
line by line, using `strbuf_getline_lf()`. We never free the line
buffer, causing a memory leak. Plug it.

This leak is being hit in t5616, but plugging it alone is not
sufficient to make the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8bb875532b4..a382754feee 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -425,9 +425,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 
 		free(promisor_name);
 	}
+
 	fclose(out);
 	if (finish_command(&cmd))
 		die(_("could not finish pack-objects to repack promisor objects"));
+	strbuf_release(&line);
 }
 
 struct pack_geometry {
-- 
2.46.0.519.g2e7b89e038.dirty

