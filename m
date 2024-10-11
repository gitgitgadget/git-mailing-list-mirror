Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5C208966
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624757; cv=none; b=VbNFVsDX1ST1SFzC6hZ4KiUXLqRwTdpdh47ou0DjmziF5c7NvE/0qjPvFmvqCYDLrWZP2Jicn2+l0oDmndFLVas6gHSUasFeAv6HzpeX69j1ft8X0axUjWmVlhOdZkp8tM0Zg28Qt1SGAi1oGJkLwECx96vYJKcSEPjNHQJC+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624757; c=relaxed/simple;
	bh=QTKqjDdWblpuH/dGgXNI7crp3s7Mktrmf+Vs+yBv+58=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tauv4efCzWnb3xnee2UoN8bApu9xj20NApaQsPCtJ9+se9ZTGHn2Q58k8JM1tEgK+q4P8mKI1hxK8LNWLe34eTWv4+/Kvt1oi81FiTfpUL7t/PH0fKtQulEofycmDkPSNDlC+npg0Qjnm61T59OevOfrdDhF2w4Gh8PZjUJli8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NRT6QTbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oqfib9UC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NRT6QTbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oqfib9UC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AD241140129
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 01:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624755; x=1728711155; bh=9hpBI14F3o
	obSsjIShGZSbESjCVSiyCsYPH5sxYlEbE=; b=NRT6QTbRPGGAYVCUhBvqydDesb
	M1ZMTLWthAFNxoDSbw9WRMAbqbF5DByBeJYTxjeHGzJWyOyGsgSHEsWgjZYvuhxU
	PXay0uvY063QLGtf7wurF1nPK+7sMp1Q0lxNmTjtvwTt/wR5wDPiT13s1hEmj1Vm
	jPE7ZX25lt+H+fqiza2t2EmTG/gh5YZezLiTUPm8/bCojvqlabXW7njcyLmybK6c
	wOuEqiu3ADg90sZ1Eh1YFVZZrVxMDMe+5Fzv37S1HIpdAUPro60VDu5xQQBvhXDW
	D7bqjoyWXQZHpu01ugwZMiOuh/LFPS+EyPTCT/CJgxHju6f3dNL1aZvPxINQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624755; x=1728711155; bh=9hpBI14F3oobSsjIShGZSbESjCVS
	iyCsYPH5sxYlEbE=; b=oqfib9UCuK74vFG7akPa/nrvt3Ri6BR07BqXufg1/oUV
	/O/fIF5TI/VThXG52LFizVJm32DdnpxprOhIWz1xLsGp+I77IpFkKI8fDpctC6xO
	oqocpBANP7TKYE+mYQyo5fCwHk5kOm/hLGvuEy9HFs8zSONv8iBz5hltag5kCot7
	trSUflYiCiLNfzX3esxE734PLIyduUsMpjD+lKyr7vf9r7BScCEzu1dj2jE4qbw+
	X4HzcmoVqWOT6cxdBoc8QGyMu+ifRBuV5DGe0bXVOS9B8Z/LiC/h4kCmPzykgFOj
	2aPbrUJEqD/q8a+NTrvuYQLeBvxUTmGqRVPILKnOrQ==
X-ME-Sender: <xms:c7gIZ30HXwkoDEena2W_45QHxCZHLowzcEFrs1d_6o0RaH9pdO8fkg>
    <xme:c7gIZ2GaYvOQxNM8ezmW6KAyRmAvK2h6WnizLIrDdwOdVFzWFLflxSnwnq42MxXhy
    fDaWBalvQkVrB-q3w>
X-ME-Received: <xmr:c7gIZ345e57_W3yFWJ5iXbVnNBAt4gqVdYhUR-8CkbHaIKyUCUZsShHzQuf1IHe-LvbtG_bMHB9NPKD_kYhaOiC8JSanlsXmln690pxnEqK8qNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c7gIZ80aKrnBoJZngFQ78s0yc7QJ0712Cs3QLpdr2CkDCkWReTaHXA>
    <xmx:c7gIZ6FbQWKhJqRT4Q-hmSNmFij21w44ZUCCk2YW0p3lHGWrfvRmUA>
    <xmx:c7gIZ99FeSU3Nwtbnktjc2FMQqDwcZBthFimJUlCS-TAZPlarJI8_A>
    <xmx:c7gIZ3mrmifChOYsCLiKGnYaH95W7rojw2yGwqHj3yySqNN--4N9gA>
    <xmx:c7gIZ8PSClPnBhKnVA8xnTjb9t4l2dAoFEWtOJimaIN6r0iyRRkhFLcp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08754e6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:28 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/21] upload-pack: fix leaking URI protocols
Message-ID: <0d503e40194c5d1912c7dd8a23f685546c490027.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

We don't clear `struct upload_pack::uri_protocols`, which causes a
memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5702-protocol-v2.sh | 1 +
 upload-pack.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1ef540f73d3..ed55a2f7f95 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -7,6 +7,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/upload-pack.c b/upload-pack.c
index 6d6e0f9f980..b4a59c3518b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -166,6 +166,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
+	string_list_clear(&data->uri_protocols, 0);
 
 	free((char *)data->pack_objects_hook);
 }
-- 
2.47.0.dirty

