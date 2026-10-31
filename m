Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412201;
	b=4lSoO8XP3cHmFj2mykt+JMGhI6eruyo499eFq8lXXuBUqOLfXZ3zC1EnxUod1gdblHYN
	 rZpGRNJEgPWIW3g3cwu5vuZt99aidd4voOl6mU3MQXTf80yh/AfLqCyfkgJ3kJGWGZKxt
	 trLHQ1BO1zBZwLRB0/0/tLimF5FvDQj7b/h97Q5CDU42KNT+JmuU+N/5iiAk+8283Cq7C
	 cVg6C/Nowmxm7YwRKgYnMxLzZTiwUqaPdKud8g3WrFgKBkyAI6Kd+N13RYaRjY6aJi0Lo
	 xiV1bYoEgezBNAXks83XNBaGvtAzErjO66qs0PqYVxZuxgHfsqrQuYK5Bz2NFKoC8JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412201;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=TyzvCZAdz+uCFWZsgUBSfk5BJbNoriXDQ0vFFVmS9sI=;
	b=016HcaSIsnL/0akonq5j9N6gOAVd7yYLXUKKGl4FDatMwqHpWfaDNSVxJWewLj886EES
	 WkEip5T0px0ebqjuWdNrmB4hVfp2mJjp+1M8cAIKBj2s3+zvHtIe0vcD3S1vz5d5qQ1W+
	 KcgPMyJnQw2IDGq8fn6dH8K6zbKtqtnQc9Ny1rHrdcEAMPRZ3PQpARh+/SpWrfXaNviup
	 oZOnVuLrMtc22+RCpt871I0YvDKZqT8simBDVT/bE2Z1Tyh2UlRypervZz0C9DUFr4Apd
	 4HQ64SRbpbIDCeNrqHn5t6hcLp20yzeSeS3enaGth3ncXb0EuRt8q0c9aaoMH1o1Iew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aHtwvqzg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QhyK+bVQ;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A3606A323
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 02:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19A3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aHtwvqzg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QhyK+bVQ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 562CE1D00154
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:03:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 22:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793412200;
	 x=1793498600; bh=TyzvCZAdz+uCFWZsgUBSfk5BJbNoriXDQ0vFFVmS9sI=; b=
	aHtwvqzgb0MQ+lg3VVk77YM7ivvpk43G1fK3d5qRdHzCXLplkXyDSGbGOY8PBvRV
	8L/sSE55tGiW9zOp0nMeDy4IlBE5SA4G1hW/oqeSv69V6diabwfv80KIvu24/xX8
	vJtapgeKMIX7ZYsSRAwlgz1oZcoBgfmbMC9780hIWdSzbZb2SVbq+FL2IeDWUWzk
	0is0ez16GkRvS5ig1lcwtVS7HkRm6CLF9NxcjhDxdQub3cZvpFw5TtCPc6/fZeA5
	24AbWcwTCPi8b6ysr685wp6nLECaJZj5Fzsen+tAWhfPCHON98ND5Kk0vFZPXxLg
	PIJHNygwdYiQAmkND40Uiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793412200; x=
	1793498600; bh=TyzvCZAdz+uCFWZsgUBSfk5BJbNoriXDQ0vFFVmS9sI=; b=Q
	hyK+bVQZn/AR/Ft8pqjIALruIFLZ2n5U9OnE2y/OWi1XamVvCsgIT1Imq5RL+iV/
	sNdwPFS3fJA9wLptXq6yBbj11ObyuCqHPOZCHmbTZDrSIHbICQMMSzkQorPQ0R+m
	kks3BCw1HVOsvfX9rQgwm1tOhMgpVWSrsgraVLFRpYJnAAzgXkcfNYbozwnpkj+8
	91096EtlnAWXLRfphvNNe22bovWRI8aYLgrYg3RH6pvK5NsKGPBsxoOfMFfyoVIX
	Yc+cuc17ekbDQjQnUsVnABMQOZZ+vgdSmDf1EXmIPN0mr90Fvj/drloziHrdGl0P
	+i+Z4UWuLJpMQ6FpS3mJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793412200; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ub27wRy/Ltz/Qa4QJAqGmnfRqoexiXKlhx8eSm1xtn//H6i
	93ZEzV1fFZIqg/aHffvdE6OPDPwBSDctVB0xx9OZhMqQ6CAR1bpAagi+TCi/ptNd
	ZxO8Mlg6vFC9/0XWuBmf08hQndtEITCxPfWFjWRRA+cyG3tL9rIwE28rnF3r/pGD
	RgaljPPnU3DET85+drxJGt52c+ivyBa5LDcDJ5jU4QglevgVL/2z0ABJYaw0HaxJ
	7luJZfnFbhoc0OWiw1yuCcpyUp02WenfrdmX6Ma+qlJo4CWACC8BJWLDGAWu2aIW
	AYbnmSJhMMooAb3syMdAlXbcMxUMlxqi9qzuMAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tSk9iApWy9KHDW2oq7/wyG/2tX4CvJxqbr1IUY+Y5Ts=:qQPSAGnUM2xYMzk0U/aFHIw5E2D4cM65/FdhfmpN4j0=;
X-ME-Sender: <xms:aEzlauIVGOaBlQJgjj8P0doRhMOV7QjK-05FK-uWiLNj9o6ENzWKpQ>
    <xme:aEzlasL81ZwG_B6UkYguZw7TwZfVq7rnaNbTEepdjupEWD1LBzUta8rJrLlR8mM9S
    sSSUz7b2fwymluexKkAHiZr0ljctJ9WrhcrC74EvvpgXGt5Ho2Rwvg>
X-ME-Received: <xmr:aEzlasXgU3tgwed9SfL1T36u_wTjzLPgjFk00D8E9peS23uhNx8CkmYD5nrZdBKZ7egJr1lPpiTQJH9Gzla-M3UYsfq-VxW__ebWW1ExjYU-3rXyehuxok4>
X-ME-Proxy-Cause: dmFkZTEfMSgvvZ9eajY0nluFibK1pqjoqMM/7EidIomnWgrTobJRFpofTAUFh7hEMP6NRj
    NGAI0NEDHVyJdTkqfZmt3jX9JImyaJlIha1Fky7UPSMQYZGmW66mx0JdB+1ap5OzKDSH/D
    4+SyTsIPPrBNBHHKuUXUBE3vtheZKiuFDhwGa3CGhK6sBitlCddCZ0XFVNJmEarTp7Zl1/
    wiPKi2EeWO72/6f8f2CwcgSHv71a/bR32d91LJU964lsWbItxFQCKco80gfZewsaK1w1Dv
    cBUG/MBl8Qx8vLoKE1VEMFF00DzdbSn8vzksY//GoAUeZhgLz2CpbDZ6qRFwXqZkvOzkRj
    xJLvvZGeIZYhkGZ1/vnuuIJTzwhdi6qHjZKrO2LAdKsjOEHNV/3Bg7hSPMT5exL+FH9hbq
    2VdUkHonATIXaEG7mrIROZPSAGRe/VxTo5NLSiqQR+QfOw3BA7/xudKgELKotEaTVWawF2
    CVl81d4cI1pJOdwlvnhGNYcx/6p30o1gMtBGPrMuD4zz4rNNJ07V1846HxdGVgcIA0FIsE
    jMyOvfVf1FDaEdv5fl0GRnSDW6PyEXPmFOcxHQ7b5Vc+eozSsuCihnwteVAKw2Dbb1t00P
    ZWuPSu3orw4kenXD4vqyLo4dd9eJObfb0taweJhJHl5/hTcAJJQXeNq6pXbQ
X-ME-Proxy: <xmx:aEzlauj6HRJnXIFDag8uNfrX7-C1trtgXS_vK0GUSOibOsjPIgfaVg>
    <xmx:aEzlan_C1g1jpFgixSwFBG2-CqIGP53aV48sDM6p3WsGnxhs1PN1ig>
    <xmx:aEzlaoDV2uPhyJwnRK-lcGR4FKBQ_foAKYX_eZVc2roY0PO79BoduA>
    <xmx:aEzlakKakk2Os_Pu2A5mly4TYDikRcwNYQus_iFk6YO18Q6_jLgovg>
    <xmx:aEzlako9gjhsuzTqF7NcvoHkTXdg2LJkrxBib7m2D_pPuO-efgn2Jrrl>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 22:03:19 -0400 (EDT)
Date: Fri, 30 Oct 2026 22:03:18 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
Message-ID: <20261031020318.tLesiElF@teonanacatl.net>
References: <20261031002550.GA626623@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261031002550.GA626623@coredump.intra.peff.net>

Jeff King wrote:
> A few tests in t5702 check whether we specify the v2 protocol via the
> GIT_PROTOCOL environment variable. They do this by redirecting the
> output of "env" into a file and grepping it. But our exact pattern
> depends on how env quotes its output. GNU coreutils 9.10 will output
> this:
> 
>   GIT_PROTOCOL=version=2
> 
> but version 9.12 will output this:
> 
>   GIT_PROTOCOL='version=2'
> 
> It doesn't quote every variable, but the presence of "=" now triggers
> it. We could loosen our regex to accommodate both versions, but there's
> a simpler fix. We only care about the value of one variable, so we can
> just print it using the shell invoked for the server-side command.

Per the coreutils-9.12 NEWS¹, it now honors "the
QUOTING_STYLE environment variable, defaulting to
shell-escape style."

Not that I think we should keep the env parsing; as you note
there are some pros to replacing it anyway.  But if we want
to use env somewhere else, we can set QUOTING_STYLE=literal
to get the unquoted values too.

¹ https://github.com/coreutils/coreutils/blob/v9.12/NEWS#L118-L121

  I'd link to the main Savannah cgit or gitweb, but those
  are currently down, thanks to AI scraper bots. :(

> ---
> The new coreutils hit Debian unstable, so I ran into this doing my usual
> daily "make test". I wondered what idiot did the overly-complicated
> "env" invocation in the first place, but naturally it turns out it was
> me.

Haha.  I've had that experience as well.  More often than
I'd like. :)

I didn't properly review or test your changes, though they
do _look_ sane at a glance (albeit a quick Friday night
glance).

-- 
Todd
