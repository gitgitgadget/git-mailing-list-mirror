Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668647;
	b=eeqm6ugJYLCXxqHXyy/+AVvqjh3wegAGz+DuknyIhI+2AKND8GNlmLK86jQA3A8q2X+Q
	 s0FN6w1ONZsuHgNNEQFG9mjNdgCfK0VVpLpqKq49oyTazg/t3ywd5wJ/KDIsXgORM9va4
	 QhYeHupk8rhaQY9yiERb/dCT/Av++P2oRUWjk5VCpWvZL9toZH2oZQqNcwpBArZhQHAnE
	 +7WMELv0QFW1LLGLY6GzUJP9TLbTxBKsK8tq2WlmrnwuazezjIn9TuoLlvXP+Vp79WKi2
	 nZ6MVpLNDwnkTAnUnlKwyOiUP1dt+1mBuk7ZS2jHR2Pzw7uoVOdQ2IZ6m2DVCRTbaxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668647;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jCiJaZAtXmZqm6f9GQ3JZR7dzUx99StF8bW9w8uTNM4=;
	b=p/MAPE5QlXG7tubrzgJf8dX6cq3kg7sMRbpSBbEMpzZYtwEwv8ewKxUDnLJdpX/pkaNY
	 aB51F7biCjRFmdkzGsOUMTL6eZfyDrrficeCdmudVItjbifQO0Y8e+1RKApUjdq63dmnz
	 pyXIm4tYlMOoBjh1I+JM03hDfZnOXRhHvRwNciVZSll6CA/9sY6ZI6RNurmVWuByGlzpM
	 Ly5nEXTuJVn8o/sJ44+nnlq1421Lfg8kBF8ig3Chvp63tHkISJjOdfUbta0M9IYZi5ydG
	 tN+Y+18toKZpECf9ugaNhiCQ+IWGgSBWFLM1vjgN3VGnOzXIFcqssJZw2eQSSlILOGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OEtG6kC5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QruafGDW;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96B606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F96B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OEtG6kC5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QruafGDW
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ECB2F1D0016A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:30:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 07:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792668645; x=1792755045; bh=jCiJaZAtXm
	Zqm6f9GQ3JZR7dzUx99StF8bW9w8uTNM4=; b=OEtG6kC5H/P28ovmy+W4MthRZm
	uz33le66DBlRISyukJvXxd1cP6+AWyBggJm5XlWMwZ+BqKlDpIYAf83QfQP7p6Ub
	us9rPpbiaJmLp8IRafP1ZmuM/X/P3rxCrVflQw8d8cPSCTqRBWQIDocnTc8kSDqQ
	M2rpkiUgUkaSjF2MgkML/Xmh6X6RnMcjC+BpdzQrAYDYYBRflAoalk+1vNwFCfiX
	2fQM9CENhXCNahb7242hVYhtwAp/vG+buzFql7UTrCgirZ+Vy68t/TIlGEOoLZHR
	wh+J9hQuayV+Bx7fNHsoh+z3Yk0lDTwDsgEFPAoTrfnmMuCTEa+LII44xL2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792668645; x=1792755045; bh=jCiJaZAtXmZqm6f9GQ3JZR7dzUx99StF8bW
	9w8uTNM4=; b=QruafGDWCNZF1oi6kBLfoDtv8i0LUV0thDC+//inNTNslpeuwQ1
	T9vIlPsIwUw3Ur56L2Mgeye7PeSTp8l93ACt4bApFfTtpihHrAjg8xaweBy6FVVP
	uMDTCaRowjlzUhhh3F2uXnr2bgqVi2/SYiNY/BXNX93Taq4THhm8GKF4lao2snOM
	oG62v7akwZxcIUUb2PZMfpCTQ8XJh8cCYyLps6+GPQ0AZYLafDbLcxEvLTdPWWHR
	Zo4JDW0d9uUzwNA23Vkrxp/QkBHWtTW3aMjIUZsf6NZPaOzkrUofkH9vWWb28N9o
	vhWf4Uf4ZO+OjZja/6s/IytZBj+16XB1hCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792668645; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SHKHkbu1uQ4xMKDvzbo6+2RMjwvFIwJ5JLWXuyoHLPo6qjA
	tVU/bUndY0K164c3O7FIP6ID8zS39OkNsWYFMUHVLfHgl5FUpwjx5cwhLUChAKye
	vpBW7am+g5X6rwXq9/AcAtxhdtAWCiq5oViNS5TDJ3fKA+XoEqOfAmLsi/+RvQMy
	ZtMb+LE6mFREpw88V2pVUdrJ6MyFA9boum0etRezkI1XskIagTlpmJZDLtt1GlL3
	MmYgTQa64rLoctYq1k4K19a6Pl5otDirAhpu25LY7a+uJFvpMkHUU5QzA69iUhT8
	P2/WbuxmvqadhNtpWlLRqxs1fkIlsKiRYG7zg2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jlvo69ZZD79bw9VpzsZZdbRKN+Ci++GPE9QLc/dntHA=:M0BAqZjZ5yEcpKklXOaoIxWWembJ5tyZSLnKspHamF8=;
X-ME-Sender: <xms:5fPZaubiWcoELOqSnY7pyGJpK5EKq72TpcSfROoGWQRwR-qYtYHAvw>
    <xme:5fPZalGBmYHR0O0IJVl9TYnV-mzJUmsz_yZrDdc2Iemh9Wqr6_z97Zhx-sLPJj8aQ
    EI0kgtgBb6EOC0MC8E0n_Q8o45YDo9UB5Ls0If7lpfs9HgAKoc8YA>
X-ME-Received: <xmr:5fPZaiww-tVXNkEohebNj5oJ3FitW1H7ExYPn_mtRei-EcZbpB1_AHSitvE_yA84VHwQMw>
X-ME-Proxy-Cause: dmFkZTFoGq8TjXfYTuSbnG1c2MfHGBmY9NzAZdEnwndJN0djhFPN6Pe0xcUKZOmQsDuvgW
    AHq0z0zXqdpBpY9lCJMNgyNoqzeoMSUzN5jopN2REPvxgYrG8S/Oaua62lh06B1m1tPV/8
    pJGVd/fsJXmJyL75hbjih/9gAXT3dGAG/G4l+7aB3cWZVoTS3inlqVQ4FKOdaHSfFLQK2z
    1SW4MnPH6aJsgN7+QRWNW4fT/xfP0l/PMnH1pQj1y6LhANIYc8C7uCuhyaatlHtyzjnJBC
    Gguzj8MflXL6KPdkJWmvbSA2A68lF2M0Uw5QiPb1yrRBlnYNoX382hNlbyA63ML8x2+QZq
    gKR3y7hm1Gb6odO9rKluCrHkKLEFVW2MkJHgZZVM5qU91FZAD2vPCHB2l/QCNhIDVkuQBY
    GPOpZOK73QMK3j38icuqFrdCnXqUC78jKgARcej8J6ZppjGxcMhLqiBPiGTj99xpKCBJGn
    XdnzcfUrgEpU4lBwKkhtZPE+xlT81O+LHQb9tQIpS1y8Fbaf36TGLqnpmNfQGwz1+eHvdr
    8bvgrkXZXTIucuXtpJ0ZkoZszz1CxqragSRSa3G3GBlKWtnCSXPwT3cEpJOQ+qNqJ2IkKZ
    lfJBIrcEcg9BxBRNfW1RhlTOc9ea0jXLUBpo4UHcd8wpKWqODc2p2CqkljPQ
X-ME-Proxy: <xmx:5fPZanl6S1dAcLtyhyaLI-xod_usHudDRS_DmZyuf7x8iYYDIvVc9Q>
    <xmx:5fPZarmqLTcrpl1dly-rdnN-D0vIkddWsax6SqybM45TwfgajcHrnQ>
    <xmx:5fPZapwFkOWUJQwjhc2JwepH3GvsDpaNN7iqGkmNczu2FNMZ1_HQTw>
    <xmx:5fPZagoCNaW1lq0hd4kvA7Z1cmaCOekLWi2TI9gJQuxtKhYgxJXtng>
    <xmx:5fPZah-QWV2XlpPoNc1m07b02-VwZirGYNFkAngTbVxfCIPL68UysWaj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 07:30:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62031590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 11:30:42 +0000 (UTC)
Date: Thu, 22 Oct 2026 13:30:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Joy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	"Kristoffer Haugsbakk@imap.fastmail.com>" <kristofferhaugsbakk@fastmail.com>,
	"Christian Couder>" <christian.couder@gmail.com>,
	"Usman Akinyemi@imap.fastmail.com>" <usmanakinyemi202@gmail.com>,
	Joie Joie <soniqjjj@gmail.com>
Subject: Re: [PATCH v2 0/2] config: move pack size limit into repo config
Message-ID: <atnz38iLy6_wotH9@pks.im>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
 <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>

On Thu, Oct 22, 2026 at 09:47:10AM +0000, Joy via GitGitGadget wrote:
> Changes since v1
> ================
> 
> Thanks to Patrick Steinhardt for reviewing the first version and suggesting
> the initialization cleanup.
> 
> Following his feedback, I've:
> 
>  * Added a preparatory patch to simplify how repository configuration values
>    are initialized.
>  * Reworked the main commit message to explain the existing problem before
>    describing the change.
>  * Removed the need to explicitly initialize the new pack size limit field
>    to zero.

I've got two more small nits on the first patch that you probably want
to address, but other than that this looks as expected to me. Thanks!

Patrick
