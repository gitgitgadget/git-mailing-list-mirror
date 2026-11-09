Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209493;
	b=jSF6+AJgryI0NsZFShhy54I579Oy3rm3JLw7RXnOZC+/Fj5VsbXRzELpPGvvGJcjlbgS
	 pnu/NWQBBZ6GQPdmdaC9V6bZsFTga8eoeuTR3MVSJv92oY8VLfdqX5jY6D7iWT15uB3E9
	 qLEO//qI7fpDSqCy/TJp7J5LWA79T/7GHYdtb1hLS7RiPHZyj1PJ1hScZ4xMlKaQDyXE2
	 owsDgsiZ262x3VfinHhoyF1lbt6fMhxXppkRWDlfKWS/2JagRC2pPFRzf+B5f4z7dE76j
	 cRR06ywpAN1W4lOx+8rpVWGQfKYG/h2lmNiC/ImRAAif9nz7X0ETlq82KIKznmPtHEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209493;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PYuMc4p8GxuuS6G79jfABdKhB6Gg3UAs9wVnBYN3HIw=;
	b=bMnTmilnrh/9Me4zMWhl52ZkQknNmSbmcK34vu4t8wEwIzJKpnqx1QoEvPJOxoyExMaK
	 ElbtB0x8epM/n0zNta0NWzxlqEPppyFGBIv6Ff6PIwKpTsweuUibhLWprRGEeiQda5dS7
	 S4pgrxIhXrcCy58e+8AUIFZuhuV+4NSXKsGBncJxeB3hFP8fZusN8lp0LrN1XhZtx1R6y
	 4oBLnjdk+kiIoy3f69ksXU8S8J386OdTII9RhJmUnT6yBwpoSBp91mgs3wjAx0XoA2fHb
	 sSG3MJLz0r2NLI5ImInz42FHw2MZ9tisD1u2vx4H5cwI/tKYHJuDiz7/bW5XDrZZMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hFr95HaI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fE3iS5yV;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77531606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77531606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hFr95HaI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fE3iS5yV
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B40E27A0043
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:31:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 02:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794209491; x=1794295891; bh=PYuMc4p8Gx
	uuS6G79jfABdKhB6Gg3UAs9wVnBYN3HIw=; b=hFr95HaIjy+iEnNSyrFDaiJYzB
	2OkHLCnIzSBTKW8DaIDa9QjUYltXIJigI3xNHZLLw1N3gflGW74xSYpt76/f3aHb
	CpGHTtchihJblRsgPR8/SYnBccmF8SugZ9Ce0PXSbSjwGDNje1ASkpi83vr6j2fG
	gKU3ynJDhRTYA33vvnW42aMsnbAIZDfDm/OVgLiq6oeapE7mX6U64J9gAdFCUQUv
	+ptbB5vfb3c/4cLG/QHkOEcCjVEsI49JNQIAV5jZWzq0dnS5X21PVWffAwvXQPv5
	KfiWoe95MF6H1zdrlG6kkLPde/ZwlDPM4Q/YDXwcmLoRoDxFk6JDsqo9Bo+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794209491; x=1794295891; bh=PYuMc4p8GxuuS6G79jfABdKhB6Gg3UAs9wV
	nBYN3HIw=; b=fE3iS5yVTXcEh/czs2a6rrFU6cCqRmGmPoQutFqrXeoQ5rUrCJi
	/P3RmgWQ+2jiQIFcI/MZ28xBiHEeA+48Z2a2BLhtV41bsNh9Gxz75oZrCHUW0mrQ
	78pWGGLagryG4v9SlpNEEIW/y04RPFRdQmtD9jVh4oNkQOf6nkaLdgiBn9kTm+g0
	4GyFw8XjSEs3PExZ2OiYDAIGYTWqe2sGROFcxaSR5Z+Gzqmvft7GIEAf6cgC1xX5
	JPd7HABUpddYWNLujfS6erJkBSjQbLeCTKk5VFkqDuLbZxatW15XfXpPPjGj4Qbz
	bzFIuTwBtRcM2OJ1s5tCzOP0KBax9D3IGvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794209491; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fdxg91Bye0MZ8S00T5D1LkMzxOmbBs1nUMnVVsDj9RCdwc0
	Tk2euKLqBmJh8b2NZ8wAoxFPo6/FmqVXufc59H5kqWgKLZx2AsTtHy4PR6uYWksf
	RbUWk/QYfY72/DQJmMdWwgtRBalkaY/Nw7eivFabDwK/Kd6bV/gkWp0SPboB+R8f
	Jw1rwP0U/4KVlIZDHw6rkUf1c2pwwsCzluctgYylV/W8683PvrUEaUPlmX1HRtFr
	j66Y1caqm+fzb8RsdOVd62rS9RbneWf4dI8A2Rq8IrGHsAilYo19yS6h0Zbo8sD5
	M2Avxizent8t3o45XcFjnsX+KV87dEx/6zL2iGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G5SLowIEGPAL3iSnGZthrzgmNrc/yNpUjtgmJsHqASk=:uLp/53GjsbiYjaF3/QvYjVEmpaO19LxiJhy7ZBng8bw=;
X-ME-Sender: <xms:03bxase1f-QfCxk_RnlMZ0pWgjVfI67aICgwTrfz7Q2NuvyMDTMSrQ>
    <xme:03bxakPPuAXTScdp5_uaLXdigqm9_JQLSbRMNKz3RuzGpyryC7z7BAA7pwKgL66y_
    NDMnlBOFlWiST2pcvJHZ_CJLhLIPhK47Zzxg0eUn07f9_J5xHuRAm4>
X-ME-Received: <xmr:03bxarJn89m0JisoOJ56gq-fCXUH28F-b51OQ46WO8HAoKMc-CZPCGVj4OBc-6x4m1Uzr00>
X-ME-Proxy-Cause: dmFkZTG2KtZZGKvhGblMNEPSWzpo0HH33FZCii5mE3KvFVaALt2MZzE29ixAWEclIeAqO7
    Rtto6kC5ZvK9DJbulu5txZHGajc5aWPPjfpA2vKCHyKNEd/gHpVa7XzC4W9WIzDFFzJH0h
    aKuulfHnW2/nxkVbP8OdRrmYQF7xNmDHSnVOk07d4MuydBA8fYbxpDqcEkoPuSjpZwS+8f
    /v5amaec1/UnDLApAB2P5tk9fXmp1r7dtMPF6/mdYe0eQcVA+vh6/k05SUpN3WMZqXNYFf
    829S8zQvMBht/DRNqvr4dTR/Ru+AfyoJNBUxq8TK1nMQ5pqHsQ5zw5zKsDMq+s1zLPLvSj
    Ir9g9X38T4GEZRf0Oiqb1auEkZC0hEzed79Rc7AqunlXng6GzArTbdDKtNFGr5ucoV1gpW
    CXSbbdWGE3F1AD17NoWwVlZc4tNx6b+zBykmSJz3P4LwP3YaXoy+aV7jMpNJw7LTUzb8eI
    aP2Yrtd2yNeDDLSG6IZPkVFc7JCS7BITLhTBsA3U7M7vuqXt4vZ1u3nCwzUUhHABIuqzXk
    qcL7sBQTwJv3wHB53Rt26XWCUE+jlFKYUV8HPHNDSAd4jpWDVAweQkgzOTKZQ5HHChUVKu
    8XnHSRp9hu1AldnnRRmMjtIiWPl8Pr0AEG23hYKXw5OI8rsoqw5yZP7hPPqQ
X-ME-Proxy: <xmx:03bxatFbv5co-OGT4kCfYfvyhV_pPN1tvnSthbEDKHDQZ5mUQpOFVA>
    <xmx:03bxarRbalWuYLXd3xT24T1XnrRTrA3fU-0pqr8Q3LHLh2xAfP7clQ>
    <xmx:03bxahGvNCy3CShWvOEdX2xEVfjNpThU6OCKM2PHe5pvUPYvnMZbWg>
    <xmx:03bxav-C-CRVCvVHuxSTkzQQ_tNlRpaGyB2NDBEDmLTqIDdA48IaZA>
    <xmx:03bxan0zHhR2P2gM_1i1FhlSahHt3JqLIKL4TApXt86-eLGHOb2ZRAl3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 02:31:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c044a31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 07:31:28 +0000 (UTC)
Date: Mon, 9 Nov 2026 08:31:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] t: allow testing with a non-default object storage
 foramt
Message-ID: <avF2xjwjcyU6egIf@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
 <20261105-pks-storage-format-improvements-v1-5-870bb4212518@pks.im>
 <xmqqzevliy6j.fsf@gitster.g>
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
In-Reply-To: <xmqqzevliy6j.fsf@gitster.g>

On Fri, Nov 06, 2026 at 10:59:00AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Subject: Re: [PATCH 5/5] t: allow testing with a non-default object storage foramt
> 
> "foramt" -> "format".
> 
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index a893963f86c..7fdd8272162 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -576,9 +576,13 @@ export EDITOR
> >  GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
> >  GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
> >  export GIT_DEFAULT_HASH
> > +
> >  GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
> >  export GIT_DEFAULT_REF_STORAGE_FORMAT
> 
> This unrelated change created unnecessary conflicts.
> 
> No need to resend.

Okay, I've adapted these locally so that I have them included in case I
need to reroll. Thanks!

Patrick
