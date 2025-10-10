Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF9247284
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099304; cv=none; b=eEMCTrhXErNByjEV7GI5brtWGgs9Lz9Z5WK1anxwVb8IM3ItANG8iLcnhoHGXCrKzckDNwSvrT/8nVFEOVWy5MCLleIp/VOE7Tkx6+Ygw2Ep39pEema5JBjrIaYpXlzkKvRks/u64AMWMFZAyQqurjiDhEXbOksifJKif5/9tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099304; c=relaxed/simple;
	bh=46lg0BVONdLTwptAkoDyvtjjbOMr6Jck9rbVeQy2/6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+7e6EeIsVnKk3Mp+bVF1Kc002qXSRO+DtHXOSkmaYI+iNtJtt08EXXaVCyAOPGYHZQqCF56JCKlSjpXvyF7vA4MHbf8xFL95O2fCxO9nmz3KekOZe76zABKuH2/Ay3KwbdED/G8y+SKsWSjLjtGD1vHmElDTyx4qTkPtPfv95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h0hP2uCy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRL8XvhL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h0hP2uCy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRL8XvhL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A8D814001D6;
	Fri, 10 Oct 2025 08:28:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 08:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760099300; x=1760185700; bh=+27pB8jLbB
	nf1eLSEQbsvPQk6P7vpQ4BZztR8NhWMTs=; b=h0hP2uCy+zj9wrm0S9pfzCReLl
	/nSJwgCmHuecd6TDywEBexSH2wLGfGi7tKTZf52wlJVJXuL9hpgVZQzWS3xotsnO
	3ZXlRRxsh2qP1J6TqPDcw+EIJ684tf3EzUJ4hNgwb5gRpn1ZbivmA5Lze1WeC6OX
	tUT8dwlt8U/BlEz6wPY7i2ft2jN6LUKMPK8IN9GI2WmR5lxPaioi26T90E+gF1yY
	tP/yaQt4S3B2RgoVqy4C6TzJzbSUooO06gpcje3N650iFqQhOTN9ICOSPWWpALzt
	YZxDMvaWBmo6Zs6a4JLDZWTkpvEr2zWjqe2KcAvPgtEzQxh7B8CUGHz32WJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760099300; x=1760185700; bh=+27pB8jLbBnf1eLSEQbsvPQk6P7vpQ4BZzt
	R8NhWMTs=; b=aRL8XvhLz3l5UHoqq87HG1c6sZI53ZtaOuyb82fgl9g+yOkIlVL
	pZlSFjJfPWsAVg2zzeSMkBL2di6oaJ97fCCXPdGVrEamvWW/VudkNAn0ols+Iwv/
	m80u0rhzd60VFsWmKGFWrHeczsFFB6iyjt3VKF1cwXwfbb6xkPxfA2geFDQAqxdq
	eTn/2sr5augVfCS+ztrcwpVyr6oI4ihhCDqxqgfjudrd4sIoEMdOB2L0sJA7PTln
	1qHDeiz2V67L0/+sa6XZjLfnKS4qhs/2dNg0BFWOX0GXvBXSBXLco6PcsGiccuuz
	swsobUfD+SmHIs1FmvJHsVXF7oVernD5ZkQ==
X-ME-Sender: <xms:4_voaPm5j_eNIMoPbQ7EDxI3iyv7n-y9-jpSymWqUvlDB4fek5Q3sA>
    <xme:4_voaGgmReB2M_usrGYtlviJNfAjENcIH7zgkWZhjuF8-3AzVRmfcHSZUheP4pMLu
    PYbFEiB9UbKX_ZV_jhOEgDQU6WyHtU3a23fGLweMPYZLMKKxEJd4Q>
X-ME-Received: <xmr:4_voaPckln6Wcp8g2NbBtzZRJqBmHC8lPoiJeZd_H3Cwna9sSypKFsXp1HB1_ezL_OxLR8GvsB3APaG_A_DBsEAuRyGvqqSaWiGpGR2ydw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4_voaOgWxfTP3ZbXorwdx_AIngyAPIn1pMWCmb_1bQWknGA83W8fbw>
    <xmx:4_voaPz_1P7Vf4sICuaPA2eI-Eqy17H5wavRkIEYsSXhTYPrjgVDSQ>
    <xmx:4_voaCOFLfJywkcGKPMe6ZjUarsXy3_1YjVoVdrHnNKYGTpxSf8AMg>
    <xmx:4_voaIWYSyfoTGNBXi3spBaxA92NgvcRm0kiUsll9cyE5fz1q2WgxA>
    <xmx:5PvoaOCB_jxaBceUcxX6usFl3FzN-CkEdp6JkOKkUmJC0fgjPlOCwn5s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 08:28:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91ba2e19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 12:28:17 +0000 (UTC)
Date: Fri, 10 Oct 2025 14:28:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 38/49] builtin/repack.c: inline packs within
 `write_midx_included_packs()`
Message-ID: <aOj72bpVTCXuFSHN@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <c2c7ca9f9e917392de3819ffffffcf78622972b4.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c7ca9f9e917392de3819ffffffcf78622972b4.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:09:40PM -0400, Taylor Blau wrote:
> To write a MIDX at the end of a repack operation, 'git repack' presently
> computes the set of packs to write into the MIDX, before invoking
> `write_midx_included_packs()` with a `string_list` containing those
> packs.
> 
> The logic for computing which packs are supposed to appear in the
> resulting MIDX is within `midx_included_packs()`, where it is aware of
> details like which cruft pack(s) were written/combined, if/how we did a
> geometric repack, etc.
> 
> Computing this list ourselves before providing it to the sole function
> to make use of that list `write_midx_included_packs()` is somewhat
> awkward. In the future, repack will learn how to write incremental
> MIDXs, which will use a very different pack selection routine.
> 
> Instead of doing something like:
> 
>     struct string_list included_packs = STRING_LIST_INIT_DUP;
>     if (incremental) {
>         midx_incremental_included_packs(&included_packs, ...):
>         write_midx_incremental_included_packs(&included_packs, ...);
>     } else {
>         midx_included_packs(&included_packs, ...):
>         write_midx_included_packs(&included_packs, ...);
>     }
> 
> in the future, let's have each function which writes a MIDX be

s/writes/that &/

Other than that this patch LGTM.

Patrick
