Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9D1BEF75
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234285; cv=none; b=GydapDNzEGpT0XA5fRKMizrpiveXjIBKPAa1wMEhjWS0wEZXT926CVq4WeTGc3Sfn6OJna/i/7tHyqCpyQjldYtPxAr/Nszv3RJqCzktTNHswBT5g31RfCbtv9u2k1kik2598iFjNNq5N77nHX5AbOz5N5zmvvYOIAuca/6VPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234285; c=relaxed/simple;
	bh=jlOuLbnaNMRdxiwMPOG0XBM9q34tbchb8N4BL7zeYLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lABoo6F1joHLWv1IhwYBmbhAfsTeNR+ihoTROisP8iTfmGmrSJkPrjLRsxnZJzsQJuDhyxxRBSVwFBgPG8fcLytQW+dzuu52vMF4PMmqwfCEp3zwrvkbIW75vZSmb+Gmf+5UX02eHhE/a3NAq8TuGe+dfLLbkHoB+8yIKnvhjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eQThMs4P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKwrjFVf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eQThMs4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKwrjFVf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD07F2540092;
	Thu, 30 Jan 2025 05:51:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jan 2025 05:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738234282; x=1738320682; bh=IUC2/VCufh
	GCcpr5QF9kdknD0hA97R2clMyBkbeykts=; b=eQThMs4PLWX8a4kb91eUuiTKiR
	Wf/cPjlmInEaT2xC37vcWyr6SSMlree0o57aHowEIrAwkYzWBq7tWE3wnuG0YXh6
	k8qxWsIQFMnqREHhwN8aYgKmYD26jbH1ANYkvm82fdtMBSacYhpd3g2W1/pPcqhr
	kBj0OZOfHGXfYQJmp/a9jvgqA5+fXS7YWZ/tHhZwqk27VMMoVNoKk7oeFGQHYtlB
	gJSvsr0mHqg/I3Iy+Ab82DxfqlR7JCmbMtWjHJK74ynwB8a6qp5HwWj5KupTI6DM
	DvTVDywt3PWlpJWXHhgNTQcnbijk7iwWs6dJqQ8zE9NhBHxDLOmQ6LuWYTqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738234282; x=1738320682; bh=IUC2/VCufhGCcpr5QF9kdknD0hA97R2clMy
	Bkbeykts=; b=EKwrjFVfzF7okRbfS1Zv3qzXQ1zIPnf9fU6He3tuiE7iNvJCnCl
	I8e390lPt2VslS7gDcyr9OA36keuLNqK2w686qrM1wUjSlOhzlGHPN9nMgjDNpi8
	x8XxHWwZgTWoNBPa+72wOlYfobaaf0i+HNI6nVEtQNVbI2gpWQcJa2f/6RKXX9Uy
	2W3W55UDNxmak5v8faSIkPgH94mva+9lcgLa9UjNIqHubwQ+OJVbOcP7feUq/FK8
	2I4YfXmBDCMUa0XjJshu0r9SAUYK/a3GpJUrUEv/D+BUn4C15rJeSyMPip6CVu70
	PLlMARxzo64ZdouTV12M1miYwyye1j6yvfA==
X-ME-Sender: <xms:qlmbZ5wUafXt3W31uAPi8KGzdAyjaoAR73s_HFV2U3v8MWHl5HL_dw>
    <xme:qlmbZ5QKCHY73CohdvULyuA3x_FBu8z24rf-7Ck_egrNAtqmyhtNo6C8obqAHKf7R
    lpgd5A1dPlTXg4Xdg>
X-ME-Received: <xmr:qlmbZzXRvYrTg93vgQdSNVPNt7afdvlbsC8dV6I5olSyInUPUMSYvkNKAbrZPavc1ffjS7bhUNnnf7j_U7qAca9mR8sOzVeltqytjrjh_VGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:qlmbZ7gdh7QFoH5CDEP1NxE8f1AJSYGV_nEs6ITUYRQL9_ea4uZ4-A>
    <xmx:qlmbZ7C7HnQDQo-IwiOkRtIyY1rJx-EdeQJ-K5W6ZZRAAr_whACNXw>
    <xmx:qlmbZ0Km3DSXhNwvyhEb0b88UG_pFIiDn98xTswInmce9nB06tp_vg>
    <xmx:qlmbZ6Cnx7KJqqoIrnKIEsoKkZKiYjgAF01EPjH7PAfWCGnpurGHmQ>
    <xmx:qlmbZ3sc_3hxkn5hTwxSJ6rHAGAChGUjkAeLQmpiRk1kn8ox1ERzrsNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 05:51:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc8312af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 10:51:19 +0000 (UTC)
Date: Thu, 30 Jan 2025 11:51:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 3/6] version: make redact_non_printables() non-static
Message-ID: <Z5tZpmmNpjC5-uFH@pks.im>
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com>
 <20250127151701.2321341-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127151701.2321341-4-christian.couder@gmail.com>

On Mon, Jan 27, 2025 at 04:16:58PM +0100, Christian Couder wrote:
> As we are going to reuse redact_non_printables() outside "version.c",
> let's make it non-static.

Missing the DCO.

> diff --git a/version.h b/version.h
> index 7c62e80577..fcc1816685 100644
> --- a/version.h
> +++ b/version.h
> @@ -4,7 +4,15 @@
>  extern const char git_version_string[];
>  extern const char git_built_from_commit_string[];
>  
> +struct strbuf;
> +
>  const char *git_user_agent(void);
>  const char *git_user_agent_sanitized(void);
>  
> +/*
> + * Trim and replace each character with ascii code below 32 or above
> + * 127 (included) using a dot '.' character.
> +*/
> +void redact_non_printables(struct strbuf *buf);

Is this header really the right spot though? If I want to redact
characters I certainly wouldn't be looking at "version.h" for that
functionality.

Patrick
