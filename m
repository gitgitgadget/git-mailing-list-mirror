Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944143F4A7
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775251; cv=none; b=MsGgSH345/UpULIhKCL//xitvI1g3S7mW3l3LkIn72JDxPuP2dPPw5/ogWbVcYpM3aCutYvql7DoySv9AozU6qwl6QRyefOLCJnYe9J1SOF3dSWI9Ao17A4l4sUTqHDMzuT423AJZhYe2f0NFTTKTsQzoPnUdhQkLD6Hjm0QSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775251; c=relaxed/simple;
	bh=9msYVxqHlZRW2/P9vr0YM67XVZlDc0G+L3r04eW99q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT/lODxxysgwvT15HLdnisz24YS5DYCbiinlZYPLekB7Dm7ldY2Ed6u5jchdGhhQ/Wh6lEm4te3CjTFdstIytF41DJuGfzvSwzt1ql/S4iKQ9FBMJ5AmNuX4SwI5FJ6IgpGS8Ax7MTGY0RdrDyCGCdzhV9a5qWvRG+Y8w47LRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lvcxdjUc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXwbnAGQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lvcxdjUc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXwbnAGQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 990EB14001F2;
	Mon,  7 Sep 2026 06:00:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 06:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788775248; x=1788861648; bh=4paOsg6bzM
	h9ISpihLZIdY50gmAlMOIizDpa/ZDsj7I=; b=lvcxdjUcDX0hMoJZwR8BMm3oyf
	kr2FiqUtCkeuisOGsWDWvn/VwIaO2NBIqVbgRVU6pAQa+2t5+59AtvleQphLCshp
	mv2VKcgciXV5Rm9seM71MpyJMXUhIpqgtiTDmLyRCwCz0xAPuBlO1bQUHmwq5mdu
	rz0zUSJ3gRBj5xzP0jcxk5a4HtMxpsGKn4ioq5a5wqxmiY3eophq3FHTqbo8Gk/j
	B1lL4perz8kD95Ho4C4OAmrMlTQX+pJomGmzMPz8r6DmohBczjX3Fxo0AIA1JmyV
	lJWZs3ZFNzzlyLdCv8uN35AS77xpNNVqQ0S/UpKDpeMAkFgllQ4XfIzG4fmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788775248; x=1788861648; bh=4paOsg6bzMh9ISpihLZIdY50gmAlMOIizDp
	a/ZDsj7I=; b=TXwbnAGQtW97KKpm6481n2csA69/g1tH9nGA3il6MYcaMxyhJIO
	BHcTC4AVhNkZOMtSR1eU7t+0C3dJKKiqUDq92wrcCRAHtq50mGRSGDXSQyiT7YS7
	X73y8RTcy4vNsWjkD+TQKSlQ6QF514xnspM/9SU7IZGJxeR5zjLEcLgmUDmqdmFI
	LFo5/CqlG4o66sZLbkolbrxWaSitKAa/fqgjWJyzrUjnro7UdrgR8mZm7si9GVcy
	HWfXcxWofqYiL1J56lyHpfKQCEX4FRWI+4m3RkPj8pr2qDogeQDyoLB9wu39fC1z
	At1OKFu5Ep47GubffXo8U0LPwzVdkwzNyzA==
X-ME-Sender: <xms:UIueavre2Ylfuj5FhZ6Wv95OL7qquiaD9srYr-1bYVLpksB9Ef94cA>
    <xme:UIueavorJKOefD3wcVxpeFpIuqeSC_U_7rLyTuT79XXdPoaw1KlQN3bAVeMr04YGl
    tSZ1hv1aszi0bCcevNs7uh0TM1vUBDHcVKQoOXUrN4w-9IVP2XBuA>
X-ME-Received: <xmr:UIueap1LqoDo5io62Qy5UROWMwDbMdSAnz51MZiI02J8Lj-KXHGTYA>
X-ME-Proxy-Cause: dmFkZTELu5LARr1I7KfDH8ShO7tj4FO8Ak1xE2cFzFTSuMLLd5+UhEjLlh4MjrT8mz5f5w
    Hab8Y7Q7Adt1E66RM2/FFcsUwAD+YqJNJoEL8nXEmO+oO/gG0NMGj05FVFtnoHk+tOthIB
    c3+o0Z04fXk32R9S6t3WuGlZjNcpyEESD1CAoadL21drDANekvUT/FK7b29Uq2S09rEWX0
    TyCq75FWTQ3JV1ztsECGtBGLbYZdpemTDSP6WGgHisDPF8dCCG34t0YJi/2rjRf5je7mJd
    Z65azDieRwvYTqW2PDtJ0CEX+stawV/sCkTkFyi/GRbglsXbxEtpdyIvQIe24vWeeTgzsW
    ASRnY+PWg8bNjZ3rPWpI1vQ2RBzrnirlSGrUf9VRD4ze12QCi/5pi9jHiky0uoiG5/9BY8
    F9o/EnGZSRhlbg7naxb2HOMcIIeY4v+TylgqS+ihiRfdN77TgEnEqyDz9Y7i+o30ACxiyZ
    hN9jqlnpVzZC8bxwEkMIjqNfFebxVTZlsvu6KjG93uLrMXa1r57jch0hFpBiMNNtkRuK6X
    uWt5HAtonS/GeyqmPlTOJvd+GihvU0kg8YnwOiI//N9eqwtxh6MF2cHUNJaz2x6HU/JEhV
    LDTGL355zBiaaa6OVWIKogxDV3aVQRZqZfySDaiqqyc7Gn4/spXdfHg8yMOQ
X-ME-Proxy: <xmx:UIueauCIB8tPQrwwIbJO8BKW--iW4SaNNq9klzX1RnlFWWdOobwBiQ>
    <xmx:UIueahcFdY8ukCN9xqY9msKtpTqQxNqZW9Z-9Cm12JJiFVU3P0yOQw>
    <xmx:UIueajjAMXhOngJdjnRvkWkB0qmTqXDrI6RlK8P_liqZO_HT74Wc5A>
    <xmx:UIueapraFX_h9IKK2b7hewyWCVCo43kEGCwBB-ThVuz546GROvNx9w>
    <xmx:UIueapa5BAy37ijkKwuDE_ieTKHwYv6x33-os5QWnDjLujoPBw1TnBJI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 06:00:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d67855cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 10:00:47 +0000 (UTC)
Date: Mon, 7 Sep 2026 12:00:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] builtin/init: rename "--ref-format=" to
 "--ref-storage="
Message-ID: <ap6LTHNgPGAVyZDu@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260904-b4-pks-unify-ref-storage-format-v1-1-08144e5004ff@pks.im>
 <CAOLa=ZQO05kg6ekVJf-0Hkmq8rMVQuGox6O7DJL6mMTRA7_HLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQO05kg6ekVJf-0Hkmq8rMVQuGox6O7DJL6mMTRA7_HLw@mail.gmail.com>

On Fri, Sep 04, 2026 at 09:05:20AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> > index 7b4abdaf8b..9c78440192 100644
> > --- a/Documentation/config/init.adoc
> > +++ b/Documentation/config/init.adoc
> > @@ -109,8 +109,10 @@ int cmd_init_db(int argc,
> >  			   N_("override the name of the initial branch")),
> >  		OPT_STRING(0, "object-format", &object_format, N_("hash"),
> >  			   N_("specify the hash algorithm to use")),
> > -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
> > -			   N_("specify the reference format to use")),
> > +		OPT_STRING(0, "ref-storage", &ref_storage, N_("format"),
> > +			   N_("specify the reference storage format to use")),
> 
> shouldn't we use 'ref-storage' for the argh value too?

I think having "format" as parameter name makes more sense. In any case,
going by Junio's suggestion I've now renamed everything to ref storage
format, and that makes "format" an even better parameter name, I think.

> > @@ -173,10 +175,10 @@ int cmd_init_db(int argc,
> >  			die(_("unknown hash algorithm '%s'"), object_format);
> >  	}
> >
> > -	if (ref_format) {
> > -		ref_storage_format = ref_storage_format_by_name(ref_format);
> > +	if (ref_storage) {
> > +		ref_storage_format = ref_storage_format_by_name(ref_storage);
> >  		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> > -			die(_("unknown ref storage format '%s'"), ref_format);
> > +			die(_("unknown ref storage format '%s'"), ref_storage);
> 
> Funny that we error'd out with 'ref storage' while the name was
> ref_format.

Well, it's inconsistencies all over the place :)

Patrick
