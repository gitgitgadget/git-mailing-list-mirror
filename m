Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEB3A0B20
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540917; cv=none; b=aYBO/Mnh9asB0no2f5G7Q2L9oFcYFrNMcgr3PujsupsCt2AdKsHnzoU2x+UOjwz32rFDaU7S5wsejcWd1+8WfJWLZPH4IpvrYzCxaVN1X5Y/o81pM1YCKFM3L2Fc9FbzjR9I8tAqIdI7bzifWbHUNh59vr2MbsDr2hBD0K6hK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540917; c=relaxed/simple;
	bh=05/0Ip1OpBVE+5JLZ86nU31gg0GW3a5rLdiCn9vQ3z0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oZgUURMHDmSPreonKSZqQspMGdM4uiuwu+ODOKQFSqM9ruA0iC8wMJ3IfzOEDLbqlAIDovKIVMdhIBd5/ZcgPk4qr1b4pDb7mrJsDOT9i0M8D8+hR0O4ycHslcfzxEAS9k5TkK6DOgQPEu6UuzMIw0oN0UgzZgKiHdd5LtAr8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gREh4TZ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkKNyW4l; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gREh4TZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkKNyW4l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A1077A0061;
	Thu, 30 Apr 2026 05:21:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 05:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777540915;
	 x=1777627315; bh=Y7aBawUe7jrjLCvxBPEIVOW8HumDo5H3Am9e0+b8AI4=; b=
	gREh4TZ6wu8GxQV7VUuxSmo+31FeL7ABLRLzEnudMz9yMKo05kH5oa+fOdSHeiRn
	EmNGPEZl/MuJxu4lomRCr/s3D/5jL9KVLAUm5FjhsotfcrGNHPUk/L2AantcOs99
	pTHgF6EHcE9QnCWuXa9W2rGQm8wkRPVEP0GnXBAfKj92VOxQW3q9iDUyOR4iIDCk
	b9b/wYPWopW6VrvioHyhEyVApBZw/0ja6RhY7i/EpsKJHcdw+GLdmm9lcRL3rh9u
	Yl5FlfPPCfZAo9dmc9HpNAXtpjLDDB5oX8/oGiaHxiOvMSd3SYDqaRoenE5QrG9v
	9qJokUtRBEnRIJBviDlYUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777540915; x=
	1777627315; bh=Y7aBawUe7jrjLCvxBPEIVOW8HumDo5H3Am9e0+b8AI4=; b=h
	kKNyW4lGR2nS7GS76aIPS2wOtebHVFiZGgI+IXDcqZUXctplrsmniV1l7di8n8C0
	0swx+11/uPCuNEBvms7Sychh9H2tRpmw12/CRDiZloUd0SEbxknFIQJrzoRn/kpw
	VP9acwmjzTlWpcX7kX74ZVnjSp3K2I/OTof4yEVLzwNuOrnMR2CqMmdBwnHgShUJ
	2l0ebD/SQW/kHus86PrCv7ijqBpvKHUsDDMuDtvcdnyv6xFMKb/uWCxcLOB/NDru
	+hGSap2hqkCO0Aj8czAaVSk6HvDrXGNHjZr14/HBc3ytPpZm2OZbM87n7XZoXhX3
	quPNGeJIovgxcmALh80EA==
X-ME-Sender: <xms:Mx_zaaMxrD7MmFj5_ppHZCZoaN36diMRZUmYzNmH5fSTaZVDjMhg520>
    <xme:Mx_zaTxovFs6_b9GfzFIzTMrD_Qv_LNubuhkt-3zwMl0vkFMuMk5TQrV7UUrJMOdq
    SXB4qN6f0x_XpS-vUTvakiMBOZOOSSwgqvj9qpq_3plygJVBd3uUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekieelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Mx_zaY5HQttxfRkzshPEyAOw2XzOLS88JU6S3tkoP5yxbcJroljxLA>
    <xmx:Mx_zaX1URCr518kpyqBs7-lM1xsCkivt4aO5Pz7m4TXot_QOFSBqng>
    <xmx:Mx_zafDEApYMB2reBsSRTVWRv3_dqPERLi0oddrYfU8iyjmoY06veg>
    <xmx:Mx_zaZ1l9aauoCFI8HXypBgWxdupMAj1mx0CtBf7FXrXKJEvaBjPRw>
    <xmx:Mx_zaYhLVEU8g2r2u1rYpGeUlLAX-VcQ52ZZQ8ghPcmcRDm3oX3PASt6>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 34B501EA006B; Thu, 30 Apr 2026 05:21:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq0cXLUbXG1o
Date: Thu, 30 Apr 2026 11:21:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <0516a53c-d8cf-4a90-9d30-0838f6135642@app.fastmail.com>
In-Reply-To: <V3_format-rev_new_builtin.66f@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
 <V3_CV_format-rev.66a@msgid.xyz> <V3_format-rev_new_builtin.66f@msgid.xyz>
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 29, 2026, at 00:25, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]
> +			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
> +			if (peeled && peeled->type == OBJ_COMMIT)
> +				commit = (struct commit *)peeled;
> +			if (!commit) {
> +				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
> +					*argv);

s/*argv/scratch_buf.buf/

> +				continue;
> +			}
>[snip]
