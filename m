Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171997;
	b=Q4RkwV9x9XWc/psRrvevQSjDmexW5t3YUUWvEThv9ayJ819dvU+4uh3QeiZhgbywGRjj
	 UdZDpU1qOVEQVRbRjD7ipH8klq5PHvKsZLDfh7gYjizLiB4PzZP+XfzZZRQcYPLT2iKls
	 aOnJQw8cDtzr6Y0WiAJZskpvHCjCYSXwSX3LtxxcX42xESvGEzDWxDFqExfSdFyOB/MKz
	 UkGtH+dHZbe1dwey9Dl6uvff9FGjpo9HARAKYX7c1kWuq2VYvqojudxyFPZyYakydpk7R
	 ML+/ByPw5k5qNxO/q5ptL6kGRFVPAqh+PLVYtqzfTBN/sBGSTxHLsxfe1Dr6fI5IQiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171997;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P+4m6VdyNtNrigOOJrIu7hfTp89peZtLrGKvb8rDhq0=;
	b=Q7vIlWEIXkkTApZBVicW44DWIByzHKDJuXvGQ7Uwc/HZ5AvZe6rVAmr6kFXsAtR9MR3H
	 OH7vc/0VqlvXoRcW/Tj6DqBfAnrb+Bfkxw/v1+9Mr3ZcJVkrpdDe2J42ZmuokNo10isyC
	 LcswOIkXr95tFaY3oUl1wiU8tz++txGEd15cKHES9DWVotnhBXQZtd1k7W8o7Io91j30/
	 Y2LdVZqCF+mElu3KSFv+cC9UbLEAtYXqx/syFoYUK/VUGkvzVc4FK9CGqNWiaBNBGTNm+
	 Ws/gf/28h2whz/yqdtfBfb8qhQH37QIK9DTZNJhBFiqgPE5fkt/y+hhMmISjPsrxWkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="qT+rzs3/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GUgwDycq;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A7B606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A7B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qT+rzs3/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GUgwDycq
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A24AD7A01C4
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:19:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 03:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793171996; x=1793258396; bh=P+4m6VdyNt
	NrigOOJrIu7hfTp89peZtLrGKvb8rDhq0=; b=qT+rzs3/SbSbcbz7s4oEn+YHN6
	guULPlopu1Ci4JJZx/iUw8zKmIgjlM/m63EsTWApc2M4YfENyTcJB8VnkbRJosfq
	z4cSruql7AoEZn+Gd4zrxRLMCr1UekqHVE99oaPZdn/63kbjpQUY886YD8k/R03/
	FG8FwlcDzUnTN2xtctBrj9+UP/krWpYfumb5qQp5BrJwPLZM5Iq6l5r/UfFeGwfe
	vxiPdNx0Lq0QxGEp0BcN0lqPdVaaHxn/UEeHjwcunQiUzqRS6QZz4leiZ1/v5ewa
	jqwrfwcBYZsX/3ctbS0ybILvmQztcDOOhQtGi+3UegtLbEazPrTC7fLnir6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793171996; x=1793258396; bh=P+4m6VdyNtNrigOOJrIu7hfTp89peZtLrGK
	vb8rDhq0=; b=GUgwDycqkUkzirAxGnErGdufq+n7PFot7C5xebIrg57KJCk6LFU
	wBeDCSn9HOfLu1MXx0y7I0mAnqPuQ2C9JV8UOQoRu5RUgyChAo9fmPlOr/dUFLLe
	Cwd+QwVW4vhi8iougulDMGGxSNkRSKjxPMQdih7OiZyIhvo8xvnrgIuDy4lq5GCe
	rVVN7oVaBIqS45mKROgPraLQl15GMSweRaKnJ1IDkSpOUOmKr94qyt9Oz0/IhmjF
	UmGtpuqAll0H1+pgvfEj1eub41VfcJxrXxJ82TxfWY12VIcivrQmuZtm7HK+AnsV
	AEzXHcjD/vk0ytCLx36Hxvp72T2STzDYorQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171996; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:K2TWtTkzC3vJpdAU4S+9edj2LGgjnPIFytqU5rN7sZd4+Ct
	ecjFevGDUFEmuwCTeg/R6tsvlKS6wxyIw7JrACLbYG8hdetYhIu1TLZXyEsKTmZp
	erhZ/FwyOmxbblTs2YCQpGn/KS7a+A7MPMRs9/ozY/IyLZUzV5P7GBM6B2etiua3
	VgmCzcuQYTCc4DL87PDStptOjbgyY8XL8i/5POy3Fgl/e9zF6nyrZKR3/qON05ps
	f1J4OXXHtXEra4Lmb3zindr/W49qUUw40RZ+Yq5GuzhZxYeWCdpzsQ6hpOllA6V3
	RgYkRI4souC++VM+hjttqbjKlseCH2t4gLAkUmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cNYtdAKKlXb1uXN9kx7hs/uIqlN/4yS+8kzwI5zj5cM=:P+4m6VdyNtNrigOOJrIu7hfTp89peZtLrGKvb8rDhq0=;
X-ME-Sender: <xms:G6LhasbNTEJ2EDxZTLcgFm9ayk4TyYtMAD5dKFUPfCgqR0c0VHfnHw>
    <xme:G6Lhamd8hDD9z6TIk1SigS4LsLTvDKwq_j2B9UfmHyg3Bp0SPhR6t113-mL-B4Ec-
    jTrCGj68JZA5rgU8jln8fBXops3O22dH6tXc4PirLkf9LyrB9oDFw>
X-ME-Received: <xmr:G6LhatI_rkTVcAponHfs8uhfJIx9np61BwevioedV8Ia8gTZApdACQ>
X-ME-Proxy-Cause: dmFkZTGAA0yfXr3IFFnnZJCg/glxZ2BM07TI5RzvEIsNpmhM9yG0+v51ewKplMQT1zboNL
    hzg4EBKDos8Y9E+vv/Rh/uO6aVlLrgJOwKNoKiQor3VDKaUJwUR4wXwvzF8otR8NSlfCJx
    Pm9wAcMUey1ZrcRXDUdszUz59TzLwhuDJj1Pk8vHHirvqzjhgof8Z0VkUGIvx/ENA5+rH4
    Jpak1zIaxBKOl5YsIXK15WYmkHInWd1/X9qN7Sk+Cfgq7S9SJAPWLf2JOT0q6s8KehskAg
    eF2oiVm7yI8+UllQ4UbcmDMpG4UBtofcwOVM9cL81hiqq+PuuZyZyOXiYcJg9+aL2tE4OD
    B7PViLLGQDFL3hcT2PxzcHNDyIrlXIpkn5TT4q6ZTMGROJf5wY6xBM2a6zLp5vVlQRDHdD
    3k2m0Pihk1bfXaOJWBC9phtmLxOqHslxp3SImNsSzmSLc31MoyF/qGaHGt3udlYlZw8Xs7
    hkVA7fUKJRHIm4r2ONxF+aRGzrcXkEr4E5I4eIganoRWyvyEKVrIzfh41iRnuJYvtXUCUL
    bkDLBrdxA2D9pSmlS6q7sSXGWc+nSgT+eyUb6n1xvLivzdx1riH0v4JpVFFKbZ2ux3b6bE
    IMhiZr8vT5X9RkYGiczXd25b5ooGWbR8ycbwKXT3jTbuLz8iHCeR0s2wQVtg
X-ME-Proxy: <xmx:G6LhajL2CDL95XGwflPAzGcm_10SAA2lbQbrbTS-K89Uxaisw_rCUw>
    <xmx:G6LhasVNWNX9DJ-yqMY_YvdVCtf8CCpWrhLuYvLwj9egzQwrXjjOiQ>
    <xmx:G6LhaskYzJQfmpye6Xf-VVcF_DKsWGbETvBW3nYGYnNhB9TrcDb5UQ>
    <xmx:G6Lhail0OmOWrp5rcVKsAyGzumuEjSuqD1Eeg3D8785d9-2kMjWbEA>
    <xmx:HKLhaubHNKcvFhkrNmOCLa0z-gKLaBZ4b1rKWRG-VBkkKEFROFsjl7DA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:19:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d207e635 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:19:52 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:19:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shashank S via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH v4] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
Message-ID: <auGiFa6QsNLPWK0h@pks.im>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
 <pull.2266.v4.git.1793120342393.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2266.v4.git.1793120342393.gitgitgadget@gmail.com>

On Tue, Oct 27, 2026 at 04:59:02PM +0000, Shashank S via GitGitGadget wrote:
> Range-diff vs v3:

Thanks, this version looks good to me.

Patrick
