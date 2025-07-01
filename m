Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D570810
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367321; cv=none; b=DXgcQKZXwBtU5NWDQ/Vz0SIGJp2HDA1rJOu7DcCaXQJq+QH2jsR/DcuKTnG+tpzM+MeFLCw/NaJa7cVbg9h4MdZlc62Qd3SRpJBTuGIXhucBvRyzjM52LFVV9OSeVV+USNxZb1WT2ys6LvrWa2r+SBu/CZOSGKLB3ba182raDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367321; c=relaxed/simple;
	bh=dM/vpPf72QiMgnrMboeCX2DnLNiOzzmxUoArGPlxVsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa/Mp+dNoqVIJDLYwG2J/lUfC3BBNfM+rTDE1vuXOaHNcm0wuvb3X/vj+Cs4l9HZgtYDUQO4QtJJ5T8HfS1Byh/MipV64xds+xSm2CCkaryOSALg92zqtWWQawXx+reVJPsrUUHnMh6HT+V/i/SZKb3US7A3i9xagF5kCIVvVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VD6zS5KO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JOgcwGaH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VD6zS5KO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JOgcwGaH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BBDF7A0116;
	Tue,  1 Jul 2025 06:55:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 06:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751367317;
	 x=1751453717; bh=NUvoL6TyHO0Kr3o8Ez61refUw8R+mSdA20OafC77IK4=; b=
	VD6zS5KOx4GaRwlbpc+GKnvBF9KcpwG/FUpfq+N2392lT7ojOho/WBSfmDD23tfi
	zpDEpjEaSsTmYFaS8zso/D8urQsA4Z+bnAPYxcAnVCtUgF7y96qnAXd5gzhW6Erk
	kA8aQ9BlGwrd71hyH2kOK33YurolT05dyf19Gw4/W6qkzW953CNYL1AcIC8bpY6l
	FTPpVZxQ8lNd7F4ZQrLJxq8Hnl+uf4CrKyNPmgIe1e2DmsAQtuZ8TloSphc0UNor
	kqlC9VJG/P1S1JYCRdid+M3+yorF0nOJgx3g4EEWFGxAKSguRQ1KVtPiNH1/ls9E
	zJG6iX1t0hz+xB3VUUqcZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751367317; x=
	1751453717; bh=NUvoL6TyHO0Kr3o8Ez61refUw8R+mSdA20OafC77IK4=; b=J
	OgcwGaH+kzP8x0YQ9wrwE+4gVuNY7hN+QCx4rZvM9m+5rjhCUt5iW4qNPG3CRWd8
	Jv8WF3JsRkHxnXSUjzCezh0xJP0U4xr1iPCUHcBE/n3yrrfFNtV81frW1m1XRb33
	eiVfBDS9oFqLP66fzWa/WDkX+0Xlo/2WXD70iHNH55oqQFXPqL+EQuJsYTeEVaiW
	lNTVSwSLlN8qQICI9hhwVIjth83jx2Q06dDLQzRY6A4N6YpFfOdOoYtB9mm9WaFn
	8SGUunR9or99XggYdO0XoFE+ogE0dgoJbBi+Nl++W3Bq+rihh0+YGS+BhWis1evf
	6iwHuqZrGconrKQMEe87Q==
X-ME-Sender: <xms:lb5jaPE0NJvSgf99yzXAAb91TdAdUWf1i2A97yOLJwbxqGTRy7bPgQ>
    <xme:lb5jaMUs7RAmNOLdvlA3rkG7GJ5T1cc7MfgZo0oiPm1NksWdxV8Dn1Yj8VxyTqyYD
    FC4FUSgh7Yticr3Cg>
X-ME-Received: <xmr:lb5jaBJmMV7iiLENSYC-eRN0YZD0PKO21lo67Hf8Dus9007xchnOYkp3oiMnEyRSnZnWtw9Vtt2sgyzMhmsZfmEnp1j3YSiLzXuebz3Xgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lb5jaNENOHbvvZzx6n1KCBWgxvE_DrVI6plY0DmbyJZt5U2mCstL9g>
    <xmx:lb5jaFVsN-nh9ffyEy06ufykiX5Ia9DSsqpe0cq7BgOFq3ipHDnLNQ>
    <xmx:lb5jaIMaMC2b8f5J1Vs90rfZf0rUXdcwaonxbjrAnE2ydEf1MRaqiA>
    <xmx:lb5jaE2NrvKTCGfyBMcCBfwGWPClGy0UrWf-uCQxezq0wLRhKbnvQA>
    <xmx:lb5jaLGbgwIbftQRqnYqTP7StLkjKSeGFNHJiBIVmULlBZ3fWYj6NbCr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:55:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e4cce57 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:55:16 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:55:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] parse-options: add precision handling for
 OPTION_BITOP
Message-ID: <aGO-kbdAgMMef-A5@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <7b970f48-05a8-40c6-8e5b-95ce830705c0@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b970f48-05a8-40c6-8e5b-95ce830705c0@web.de>

On Sun, Jun 29, 2025 at 01:51:19PM +0200, René Scharfe wrote:
> Similar to 09705696f7 (parse-options: introduce precision handling for
> `OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
> for OPTION_BITOP.  Do that by requiring their "precision" to be set,
> casting their "value" pointer accordingly and checking whether the value
> fits.
> 
> Checking "defval" has the side-effect of also requiring PARSE_OPT_NOARG.

Hm, requiring PARSE_OPT_NOARG for what? I cannot see it being touched in
this patch at all, so I'm a but puzzled.

Patrick
