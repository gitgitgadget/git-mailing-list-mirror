Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207505;
	b=J5S1TuaETtRpsoXBfDeyt6V9elTXbGf60Q9rTwwT4ZaRYTpMBLyYAYCmJ4Pb/aJHHRUJ
	 1i19vfLCk/yOgAeGw37kgxn2DeFTzaDlg71mKnt6ukihwj1P/qqAVtIdszbsQwSvVb6vr
	 x9q+gWo6RsN6HHXtUzOCHnhpG4Do8V8WZYGTr+8hqn58J5h5sft40TExrkkTPeuubm4k6
	 HeDdOfSe2WVYp9KbPzWlgdZo0GieH6EeDB8IXUY0Q4809ehxEdzQAuBFc+U+VnYqt0KP7
	 ST/KN+h25a2IxPInxPjNL6zcW2DznIxbPB+m1+z5bvtZvOxmS2stX0y1mSo2v4bsVLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207505;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5PvQsJZeXjkZso7/AMxH5hemYX/yc0tyryqo8m5kF9g=;
	b=5nYH4f2BSc5oX2l6ef9JOmaBpUF84UMTfQ58JX4Z1+ke+mRH41fXgRSu1kShNivY5OqK
	 xkYK1Apjv0+1pH++d83PX12+YXP0NbkfmrYTmHK2tqNXyfjmP2ezrfc+MKoRLsIgflVXY
	 rWORo0cewP2G8RgAONIcoUy+APTKjRL3NXBsPVzerbWj51EZ0xOuU540+Oj7e7U/tn2NL
	 94wEjTb2KJsLjAe7f7ayuJyurlam5b6sEW6L5HNSzFm+PfKue1e5Yd5zTyVOwQgW+epNK
	 WB09c27AB+Qa4KMf1rqBkXgY7Nr/A81bbKcukJov+TMaE9SYwNXCPGS2v6jRiEJzcTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WGGxQXVb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dgXm0Rmg;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D114606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 06:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D114606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WGGxQXVb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dgXm0Rmg
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 14E7D1D000DE
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 01:58:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 09 Nov 2026 01:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794207503; x=1794293903; bh=5PvQsJZeXj
	kZso7/AMxH5hemYX/yc0tyryqo8m5kF9g=; b=WGGxQXVbc/HVKe2aUudzqpwmAL
	x9ANvRaieW24jWyUF26P/Jpnj783MnfdTnajluxD3FmMmtG62gFUlxaioEY+dfpk
	hbN31pe1NeFVx+rDbA8nL/CptOkYpyJC2lb551FlUrXRD4CiJbeE2xSp4Ct2q6IP
	d2XST7YlHGeiPHPPvK4k/IH4bd1uDs8PQ+lKhZPpB3oq1/+KS6KsdDcDNaGq2xav
	xjhZ/ZmHvTD03MTPaKF6BtGFcPvss2dXu4F4oXb7VeIoBmgFl2CSa1ocKk4Ap6Yf
	rJTRV1zbK/FnL0j8+NdCGGrTuNe6LcSPp162Cb7M0orT2biyFzijtQmNGgVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794207503; x=1794293903; bh=5PvQsJZeXjkZso7/AMxH5hemYX/yc0tyryq
	o8m5kF9g=; b=dgXm0Rmgasoml32CXSnw3JzGW6RGHvDLdJMOVPEkEONKJSnSsj2
	+p+fuTet5UfRVvP13mY8MqdqhiIw88vszamMV/44GA1DDZIHhFl7ZYsnVBQXrY0b
	BviSdF/bvtk7V0xxJGMMnZUFaTrT4r27044lfKSmUr7+JyXMEfy3eF2yIkjht63E
	HGJpIGLStTEY0F3/UyWkgmT1pQtKwwatIbIlp/KHiLfTb6Dfk1jqO1yZolRBrGS7
	QCKV5qLVZJ1zMTm8uB40Kqt50e/Ra7+cNrGIgfBSRdxQPknIA7Ht4VQ1Og0C80ey
	Em5+r0PU9lfrp2lAMK/PqrpmK22lylLhMSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794207503; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:pQtI49WgPja3nK+PVP9IDaJ1TfYxetyGLrJbh6DqMmYRi4u
	l7i0qrWXj+VkhWvEpJsLv6z9ijvbQAWWkPE+pEUJuq0FT5ooXcqGHLruQjQEn/JA
	AwjS2bPLPwct66XLeAgDxQyXhCHWzM30Q6SxbM3etAByzTSJaVWDQdB7rg6tk6lE
	ficQ3sSdUJxbEKkD/jcc/7xEZt71ArwvhQKKez+2qA6HKRxYNeO1PpOp+Qkssyth
	ix7z9rkmcvtTnP5w9bq1f2EtnnJPr24kD8PX037T4gKyKMHzmD4BMGYU7LO3dvKC
	CS8uX+xpEA89NfFURS0zhzltlcd2rhsH3oPO9DQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8JAVpqAFQplvGcGfqbSKz8qJ16VyvudhMcbzvH2TlVM=:o2LBgk58vb04FIveLcgWutPcLfYLGzgkXScGw5+zbzQ=;
X-ME-Sender: <xms:D2_xarwnFajYjQf80hYXwfQ_24vsOPvHA-hZ94OtM03SxtFyuGA3cw>
    <xme:D2_xaqvK1u3aMsH0xrZIJRJsA-Dw-ZNYIwhWF1A9Z1gndRu_CrZs4FKjWzCc0FG5y
    sLC8SAnCVsYiMcVENuzOFJYw6wd7ENBY9yxjmqJfK-MK2jM7UVoTIU>
X-ME-Received: <xmr:D2_xaiv1q5LHAYIroHoeObqz5UPEIALAEC9hhW1JxIdpmxAPbwXjY8_Km6IW8CmKX9uXXeE>
X-ME-Proxy-Cause: dmFkZTF5CvkGGGIR4//eoNjjj6CLdse7TSaoCH+Huo6ZKtI2G8pEpCHOZpCNs7+E7LhcKP
    1P4Q10N5QLrP/TlM8a3PAJYsaWL//VI1u7raiAiQ6NQyf7UQcJwOqYJR711NGfwmukSqIz
    LE4ugo/pjq6JTtcF7me5QGRU8xjTZVrjjPS32bHRWoGKY/5ERkHxlqQcfB2913j6b2ks61
    rknsMIZzkf4vCZ+Qhj3TxL317V4L8bA9rz2ULyGmpDLZPjyQ5V8tvTYI5UBLrrGPdaZYVv
    vPm5pmCqXTzKn20ypAFOXoDCEVTijRsDlHH2dmJBWsdSB8vfuB0XGs+8R1gND4PIQ7J+Ce
    Q2WU0m+bMGO9wefnyzml7OjLUous6UPjmBYcD4pBo+OJQfegP0MoRL3RX24lDRPpUm1o2E
    Y0IvZyxABlTLDIud/xbKmQPoDXKCYIcqcXBawjLVlsTqueOJeJzL9udAU7ysq74FZyd0F9
    9AWel4UKtan7vLN3quDigMArnBNNvv4tJLNcYesarmmyk1khhyqLiElRrFbkNuQw/SsJ49
    L3zd6XlhTBrl9zVDxEjP/rq6nuGmfQOZY8vvhn9/N+cXlDGaeN0h18CQaTx2EwbLHXW/0C
    PP1BCjGMDaXHj9eK5EkPqs4m7mQK1mFKh7XjgwOjVDnsH6apTrtWprM/5VSA
X-ME-Proxy: <xmx:D2_xavOI6idSdpNzFr_GDYyvCamDBDfQXASzfjUP4tMvaDLesmUwpg>
    <xmx:D2_xag0dTBphfdpHu-L7msjbhIteOQhhvB1v8cz9S28Zs2Oe70d5Zw>
    <xmx:D2_xarOND61lsPcgmQhmhibGCJEMA4QhLMSiMICdQN702s3Qt6VtCw>
    <xmx:D2_xag0xxfFIZcAthx-cDymZAG18sjGp0_JEMnfvalWJKMDFlkUmww>
    <xmx:D2_xapQECcDslr459ccJ6odL2lYZzKCKDnpizIzGL-s4CFwxt-Ql7MJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 01:58:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97538429 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 06:58:22 +0000 (UTC)
Date: Mon, 9 Nov 2026 07:58:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] gitlab-ci: speed up installation of Git for Windows
 SDK
Message-ID: <avFvC80wfg2nulG2@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
 <20261106-pks-gitlab-ci-speedups-v1-1-1fa0374c7287@pks.im>
 <xmqqa4nllvuu.fsf@gitster.g>
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
In-Reply-To: <xmqqa4nllvuu.fsf@gitster.g>

On Fri, Nov 06, 2026 at 09:20:57AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "build:mingw64" job on GitLab CI downloads the minimal Git for
> > Windows SDK on every run and then extracts it via `Expand-Archive`,
> > which is expensive.
> >
> > Improve this by caching the SDK and by using tar(1) instead of
> > `Expand-Archive`.
> > Note that caching actually only gives us a win of a
> > couple seconds. The bigger win here is using tar(1), which speeds up
> > extracting the archive from 3 minutes to about 10 seconds. Regardless of
> 
> Wow, is a tool to move the bits from one part of a rusted iron
> surface to another part really so much more expensive compared to
> another tool to move the same bits, to make a difference that is
> worth doing this?

I was surprised by this, as well.

> > that though, caching the SDK feels like a sensible thing to do as it
> > removes one step that may spuriously fail.
> 
> One thing that may make readers curious is if we need to worry about
> this cached copy going stale.

Yes, it may go stale, but I'm not even sure whether that really matters.
I decided to just do this as-is and Cc Johannes to maybe facilitate his
input on this part. But arguably, we can just skip the cache altogether
as it didn't really buy much anyway.

> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 9b7698a0037..15419a954b3 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -127,9 +127,16 @@ build:mingw64:
> >      - saas-windows-medium-amd64
> >    variables:
> >      NO_PERL: 1
> > +  cache:
> > +    key:
> > +      files:
> > +        - ci/install-sdk.ps1
> > +        - ci/install-dependencies.ps1
> > +    paths:
> > +      - .dependencies
> >    before_script:
> >      - *windows_before_script
> > -    - ./ci/install-sdk.ps1 -directory "git-sdk"
> > +    - ./ci/install-sdk.ps1 -Directory "git-sdk"
> 
> Is this change essential to understand this patch, or is it an
> unrelated general clean-up to follow some style rules?  I notice
> that ...
> 
> >      - ./ci/install-dependencies.ps1 -Mingw
> >    script:
> >      # The minimal SDK's profile resets PATH.
> > diff --git a/ci/install-sdk.ps1 b/ci/install-sdk.ps1
> > index 66f24838a40..1dbcef04a18 100755
> > --- a/ci/install-sdk.ps1
> > +++ b/ci/install-sdk.ps1
> > @@ -1,12 +1,26 @@
> >  param(
> > -    [string]$directory='git-sdk',
> > -    [string]$url='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip'
> > +    [string]$Directory='git-sdk',
> > +    [string]$URL='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip',
> > +    [string]$DownloadDirectory='.dependencies'
> 
> ... we are making a matching change here to upcase the parameter
> names here.

Well, with the new DownloadDirectory parameter everything else would
have been inconsistent, so I made those changes while at it. I'll dropt
he cache in v2 though, and with that we can drop these changes, too.

Patrick
