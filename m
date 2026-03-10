Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889D397E96
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144560; cv=none; b=noRH1urFB/OJ+0y7LHEZ6Nbg10JYXFTNrWro1GCgIirYrZIrSzU/BDfA98p8aIg0+jb7V6QdOfil1AgijKd/r4l/FYr79WYAxclwfS0XN/RJ96TDBlElg+joqm+3WrEYI6Ysrc53mkYW27DXQbaPT6nKSIj3/ih4o/manzLp6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144560; c=relaxed/simple;
	bh=bo2DTmIUuUGUiVlgH3xhncfoMFO68xPNZGFRqF/x2AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqhxYIrr/NfTNp0RHFk5T9bJvLA1bgJvxvcHIhUxsdhhq/+HBEtR1NDa2ggh0sEnMYxhTboaLmCQxana+xDHDBM0csjGp130pJX/DYh3jy48s1JabDspUjQTcZkp8dZAegSzwDCRZgEGWTNAffH8MW84qodqXvmae56qG4WrZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axBbt6xt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c5RcG9o/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axBbt6xt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c5RcG9o/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 44103EC0C56;
	Tue, 10 Mar 2026 08:09:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 08:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773144558; x=1773230958; bh=282PkMUr6Q
	wc9l52wZO2WgzPxCefCVW2ocKUtQkAKnA=; b=axBbt6xt6sAvOevE7U1l8DAvom
	d04ci7jSumNfLO5XMknpC8h7WsT+yMEFZbUBdyMm+6Xh7DSzbpt7f4Hjb8QVuHLx
	1qjvU/eY16mQLiZoXm/MZkMUpmEdTj+dX5NiV66rn7q6x2DmGCCER74uqbGdJiUj
	K3KREK0hUyjVoYtB9rDK00PDKy5pdGMZZmd/Vw0LUQ06R2H5RXiOCFPWkX5NVH4D
	o6aW8vxFKgStM7cjXMOrHuhcKxHeUPtGJpXIo+RM5ncC6j2F2EZ7yXpK8KJc2Mbe
	gjdkBm08a3EYNCLOnd5Wo6b0+gsjgIjNRwEfa6W2AbhahU7UmaDpqFU9XNZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773144558; x=1773230958; bh=282PkMUr6Qwc9l52wZO2WgzPxCefCVW2ocK
	UtQkAKnA=; b=c5RcG9o/EhnA/3RfALiTJCsvHSJjSBgUWmA30F+iMdpOqxCV/Lr
	5ZC6+vGvYzGKmbnv4hsS2YyD8YOH5Sry3YqdJ1uDCuIA6TtoJrnLdAsiaH8Wqaks
	WIMVgkwqBA+w6SONbm1buoNUQkfLdTaS6xddF2clcg1lMYT4g+x3WNBWPpOF/qjT
	CifIM+0H+ecRWrmMuHQLJcLOTDBgzPTpTTmMD7PnXy/DJmzysoJWH44ppBqA0JK/
	DypzP4Jb3HdeX+aU3asOrCfjnJm2gwQaehItGEn83fEONa+KsECfgwOrU9BlVdrt
	OEMc3Ef2N2uhTwvTXGBxiaqk2EswcoPHRqg==
X-ME-Sender: <xms:7gmwaZx5IlcCBZ2jTIwJR5v-7-QcS7ZAxK1gpLLafltRuCFmSWZZhg>
    <xme:7gmwaQLW7JFB8uTWE4mRnL9ehciiqVnWZwplVlQivIMhS9u0bQkRNUjpjatkrMq_8
    26T-HoQZlCeR_Iy381r5Z4koKPX2EHMuws3uLHxvkUWFJNr83OQqg>
X-ME-Received: <xmr:7gmwabp9B5N9wCMIiaHE06px7inTCefWnM3sUCVVHQI4Q1r1ZCjNpbr8FnGMpGE8KDkVgO-k8i00oUEov6bpAVp6Ch2LcaVXYmxe12O6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:7gmwaXLOPg78oT283v38Rhu923OaH08tPT3AY1bxMr6frQZSIQEN_g>
    <xmx:7gmwaYQPZuCDWblx9-xm8yP1MSYyKFlMP54_ooF4gmbbSGJxkZFFPg>
    <xmx:7gmwaeuMEQfe_VJ1Up0ANNydbvIF6TWOHqEEHrf5s2r_sfwLPA13tw>
    <xmx:7gmwaRZq8c8arawWE04vSZuSpny0X6dJiESJ_ZT_JL078OTsJ_Bvrg>
    <xmx:7gmwaQuJu16qXl8MD5GYCPohmCuQl8PshM-hd8vXt5Gcci-9PJrCCD7v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:09:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25182450 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:09:16 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:09:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/10] csum-file: introduce `hashfd_ext()`
Message-ID: <abAJ6mkYp5chzXrt@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-8-7321830f08fe@pks.im>
 <xmqqjyvr5jos.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyvr5jos.fsf@gitster.g>

On Wed, Mar 04, 2026 at 02:11:31PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > -static struct hashfile *hashfd_internal(const struct git_hash_algo *algop,
> > -					int fd, const char *name,
> > -					struct progress *tp,
> > -					size_t buffer_len)
> > +struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
> > +			    int fd, const char *name,
> > +			    const struct hashfd_options *opts)
> 
> What does _ext stand for?

"extended". It's a pattern that we use in lots of other places, too.

> More seriously, this essentially chooses to pick two parameters
> hashfd_internal() takes and put them in a struct, which would give
> us a clear upgrade path to add more to the structure without having
> to change the function signature.  But what is the criteria used to
> choose these two among 5 parameters the original function takes?

The criteria is mostly whether the parameter is optional or not. The
algorithm, file descriptor and name are all mandatory, whereas all the
other parts in the options structure are optional.

Patrick
