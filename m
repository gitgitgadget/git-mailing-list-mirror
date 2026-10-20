Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516538;
	b=TppwsbN/iEDwkUNrk2ngMbaJvuS6InSStPBjRqsOZEcRUjhZHnW+T4Byk982IFcaIMfF
	 7sois6TrHDHnaARCX1OQjb0b2WUIBYXN7PHpBRHgPSjYzbW4xU1lTeQ/xEAPbt6S/HHcY
	 1U/1Oqw7GNXHaTKiKTw0Ul2Q6ClBjZLrrRxfKGJR2YVcl99uxbMXr8O+fAeqY7KG1JXFx
	 n105yAKXq8EpzDFL9727/QcsirsIZT7Z1Z7WqSWJrApIo3WPZRcC+gxslAqJwM1WvS9TJ
	 k2tdQFUUqgo4APT48nTRoL3usSlQgd0R7n+PuiMw6oWyBgzKRu7geBdkOBVh6VhxDqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516538;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Ih9qUoln81FsmMQtYh4gyzmVNGGMyT694hFWJJJGxXs=;
	b=eUs0EYUA0u4sK1+e0QFDDatYLMXiv5XqckDAemIG1JZQtxuiwxaselRVY77RES3JW2HA
	 8bq02JGDhsdZMGZJRiJeOsGsGk2mKWYjXESLexaJsgfS/kq5NwoQO21pmgatZGbH6zXOJ
	 pVQBXFHFpBhWupruhwYkeCOrnbzSaQeB96ngmuks0W48c0PNqj37Ad9OpY/Bt1f9b4AQ4
	 JHKj73KWfwnAEreuWM08X8zIAxOTlc4AmYTjsaGLri6BhXO/IV/eJo3e33mVRs3YdIhpP
	 B1RFOP0aZxXHx2WPb7S04ZdOf7lusWk1FQjm8p+koy5AqpHABS77svk3HdXrJrlHAmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=exF7Guep;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hWpb9Geh;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8D606B533
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 17:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC8D606B533
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=exF7Guep;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hWpb9Geh
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F10FD140009C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:15:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 13:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792516536; x=1792602936; bh=Ih9qUoln81
	FsmMQtYh4gyzmVNGGMyT694hFWJJJGxXs=; b=exF7GuepPRhyJSQLxQfm+VurvH
	I/UvokHiU2svLUfrMcu0tZIQm2IbA+0BLbaAH1z8AJWXQzYWWSvJ2ldLaQBJMHiL
	GrcBv09VCIBjn9FI8c9M9Y0DMJpGgNn5YOh5izgh+gIhn9n+wcpFW99G+Ax+sls8
	PqVKbog0zXEL6uu3MC2wmvl7C7Pgsls4hcaChYES285TA1oaYcT9IhVDzqPE6Y0T
	aJx91pbNQ4jwkTaFs3Rc61IvPpj0HxRfC0ju4vCppNFIiRJwmBvI545bGJBXAlz1
	0ksjgfPdOY4iMO24qEcO3J9PHtWiiI31hsYdZPE6kpCtEhtACp8dgYQPfSDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792516536; x=1792602936; bh=Ih9qUoln81FsmMQtYh4gyzmVNGGMyT694hF
	WJJJGxXs=; b=hWpb9GehAxIrIXIUQNHFE8dt1RUu4siP8j8TqfbRUkzDlepIVX0
	aiu+rwdiKfsX1ABnTeb7FdGQj+hVukGMBHIE/XBEcDLue89DfZRKQJQkClBBLHd2
	0WHBiZ8mgIiE+gcg6HSayNEmGin0Shy1LxrbJTqgl/8eazCu2Z7Rlsq46K/CldxR
	9IX2CL9dtwPtExvHUlamFBKBl3G/xRquekCgIuHPHUXJcbC4Zfgcc5aJwdCZd3zz
	EFFRWsMR4lEBJN1G3AYCmVI+kp4P/pVTdIfsNpIXn89g+K4SEjx2OdeHsDzJ7b7i
	5m1EpO0Td0uMQapYd0HFWJB7Z9N7gaz/bVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792516536; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IZ/yojvdsgDkEq2yJPeFmMeGHa2Iu/z7sItkfeB6NlYbSsR
	+LOHCzXvLCWAw2ZImv6VPUYEuK6L4fi5kgogLfbekRwFIxr00eUGmFvyhivjnCX0
	T+anVn2UisnjhibXq6wq8VTuiAeI0Zx3SXq1py/9MqUDGH4xQxe3tIac7N3izvhs
	4Or6S/RzUdu2SFf58V9Fb7srrYVRE+W25aADu2bdF/3NsuIKdAwPpGA3UoqTWq5S
	CpXz1cJqzW05GKuWe/ZOXwButE2IY2wbSTPD2RIONu3ZCwHS2Hv0qtezOdoj3uss
	FtVI/1eMN4o9t0Z5KZofTRPGP3NRXc5s0tlTB+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:G1l9ZBBhUteSsoq8CYwG7cv7pw3C2OEm3HQnR9MjOuw=:QXDxfVSXmTTar5hGLteI1H3KOvRgh2p/xh+Bnnax+mA=;
X-ME-Sender: <xms:uKHXansbbxynwS7Um4fxIQRtN5bz81EyhZ-pPs_cny9bRQ565j9iyw>
    <xme:uKHXaufU9sXeR4i3Vtre5w_yN1TOBWCVgW0mb8w_B6dFfyd3Z3oVToMJAy8k2d7Jq
    8CA1LeqRDXWmPUnnng-uyy0U5dvVF-rjDUXaUpoblVrp9Bkdvfq0A>
X-ME-Received: <xmr:uKHXaoYmndhyfMcHWNF96s_9k4jhHQDeyLQ31QvYyyYAgS8_x-b3lVZG8h4obFbNDs9vON1EK0MinD0_NsQS2AeqToTzDEj_2wAh>
X-ME-Proxy-Cause: dmFkZTEG3LtBh1fCxeth0konUR7XyK9lYkXkVsbXUH+6qerFTOoHLk/8ChL2fvww2cgkvC
    +74MPaOZSA4DNpRUFg4XtLGRtBWWuDu8qJQoaZPIyLIKGxs8FAAD1QiE9Hu4JylfE/q9mI
    MLhLKENV44ZziCb/OwjnsQHGQTHwe7slVXN42V7Pmka+7gH6kSksCdbqdBsLR7M+aPiQfe
    uv4LtE9te9FdzdIVgXn9/wYKcNmmKJzAA5yztGTJYR87QFXGj3rqEMDRYTvmKhCAQrdBdg
    YkfH+dO2ANLqpuL9xdkJbNCbxylIZHRPizbcwJIU9FWDx3Z9htkM2Am87XO58qVYAXJ6RB
    Aq0PnlukAoLQGm/g6c9Eds/vWQ9p1bzlbLT1THNra7PdzZ5R7g4MKoYGdU3LEbLEGa6vQ5
    q3Yf6LiR8GQBlNv7Q+eev48nSsoWIKwohwIP2rx2Ow1dHECOi2tAZEDX0/vKPoVRvJGXy8
    3Y42lLg0Ro+ylvrnume77sCa18alZ+eMZhRV282FWMfOcmszvYs304vH+q/05aM3+tgDp1
    NIqF1Z9QdG5JcMXS6z+SlXZykcok/jNq67kPPMjt4NZprSBLxkMLFGVUu4UMUuk91KWUIh
    kcRcUNILYy8wGmo+fPGI78iE8OtXmRuU4JcJqJhrIJdiKOjn0rfaYSXNN26w
X-ME-Proxy: <xmx:uKHXahUU6Eqe1KBA09SnSHIMrI85USPu58mZCv8cy4FoVyJgvz3zrg>
    <xmx:uKHXaqjo_Qlszs_ihlOxT264X9bYAaivmfWqdq-wZCXlmPMqzNe4bg>
    <xmx:uKHXavXqmigEpOVjTprKdRD6U1IDt32Vfq61dqQAd2nbW_IN_e4NOw>
    <xmx:uKHXahPbfmS-l3bu8bW2oW8i8gLzaKBWrwNz25TqaFBYjhino1VabQ>
    <xmx:uKHXajGDVidNtezO7NFxsVqmvzZcRhoTyM5r-DLpLtqMbyxf-eaKi7cv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 13:15:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v4] github-ci: update macos jobs from macos-14
In-Reply-To: <20261020155813.3315813-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Tue, 20 Oct 2026 08:58:13 -0700")
References: <xmqqfqy5clgz.fsf@gitster.g>
	<20261020155813.3315813-1-gitster@pobox.com>
Date: Tue, 20 Oct 2026 10:15:35 -0700
Message-ID: <xmqqv76wwax4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> GitHub from <no-reply@github.com> address keeps sending
>
>   Subject: [Action Required] macOS 14 hosted runner image is closing down
>
> and suggests to update to either macos-latest (macos-26) or
> macos-15.  Use macos-15 for two of the four osx-* jobs, and
> macos-26 for the other two jobs.  Use explicit version number
> "26" instead of "latest" so that we can more easily tell the
> differences and similarities between github-ci and gitlab-ci
> and compare their outcome on the same commit when needed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Hopefully this is the final iteration, and hopefully the later
>    part of the proposed log message explains the reasoning behind
>    the choice between latest and 26 well.

Nah, sorry, this patch was bogus.
