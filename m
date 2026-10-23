Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738948;
	b=IDubJ/WZjEuJjaMezo98O3HNCyXwTjDbxDYDCsRtVQhcY9QK8ML20hZTCu/3GNIeK6LU
	 s4R1gY/1Un44dVwz+9FBiqGas5iQac8o6ktWBUkmxwRzXjUYWZCMSYUa8Y6GUPSH2PJVI
	 vBJe7RyRL47vvFmGXbLeud6g3PAW7pG5UZcIDxhCpazWMaf/fMasH6qQ+Tt7Nb6xEUOnb
	 +NcPDdPSFcxNg9gVzMnU3xrPE51M+j7Soxj4vqIivg4t9ONLeqIth5IBD/YhVL67FrNPe
	 ROG4azUWwU2Bq0k9BsQI+KRnPI27CAmLn96+pu8bcS9kItQXMkuQGBDakCbRbvOGvXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738948;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Io4BJOBHirvcmKDTwxnVrQenRgIHgL86fbPiCxiroi8=;
	b=KgtIWNdB28VByQTSI4gSraGUTyXjZtbXjTjiSIfpuKucnbH7h/i8SSnbfg9i0GfwlYRj
	 oQbo5gwBx0etxvtQCWz/2TXjDapaC3rHNKumTMSh1XOOA/6A9AsF58z2otFne7EfYiLo4
	 NX4LrtVXHGvHtbsfTUod/Jg0sjE8Nj6azxKHNJYeU9syydh4+onVWqeClRg/WrQmHtwhl
	 DSa5owCA7N0UUtWkzPu6wckyo0pp/PTxsk3eH8JTymR2xks6GekNLCc/i1cAop/CV1EjA
	 if2VUTFAgq07YC4C+iAbJk8Xf9gm3pkYFNeWXu4GdVkeAqu7ruAoBxXvnypc6Ha8q7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=YFYrJQoV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="RfvC/yLh";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400E606BD02
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6400E606BD02
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=YFYrJQoV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RfvC/yLh
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A5031400146
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:02:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 03:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792738947; x=1792825347; bh=Io4BJOBHir
	vcmKDTwxnVrQenRgIHgL86fbPiCxiroi8=; b=YFYrJQoVHQWFnf+MdTVaqVJXVb
	Or9PNJgjdBaKyRQKnXJyowW3zO+vr6EsqXojr3KdfOg0dwAa/IxL870g4qVPIzoV
	D/w9nJxIhwkflFSyNKRSHsPvhkULinBJ2vP9Aw5eO06tvENxNl2E31h03NJstNmN
	Y4p4dd9MjEbgHiVTbaA5E0Xo6SJp1T9TBzEov3wfvmQ0fQvn8ulZc34mZwY/qbpU
	Zrf7L7LJNHSWbM2ZXvAkeFBQje/blEpfu3aqDrQY3FkTVv/OwzLgPZrV8BJM+IFK
	di3FsshcUY9dy8d3A3KKgM79QX7G7hQi8OI14loBWdlmKx3+jMx8tv5Xib9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792738947; x=1792825347; bh=Io4BJOBHirvcmKDTwxnVrQenRgIHgL86fbP
	iCxiroi8=; b=RfvC/yLhSNM7NMSKs99lIKHKMdliAxo83aKaJuwgL1H5NggREjz
	stmi1fQrZYPM3vrqkRLvAU1Y7AP9OEn/xo5b8TDfZ63qSJxG3fNKyAjk8jyKDNUL
	qEUHvnnVhIxiDqwNiUkil4QBDEugLbcgYwQwaQSpatzn0r1VhETncUzz+mvCkqRz
	ka4Yu8UzV6k/rLZKIoVSgUr+7d+jacdhd8SkLS8YgoCQ4j6ypAS6oQ/IBhyPdrfW
	zEl58kEKwPtOS5HOFDcEYPLAuCct8T4PT6/Gi+jLkvIjSuUJCjzVKcWg5XsWtSTy
	T8uovFI7AwpWbWw83BwvTLdzjosyYivM7tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792738947; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bgvhLp0If0MOvTXExNFahaGGJBPVKn9uuGiq+igRLHpohCO
	tEosG3TZ02wmzGMlT33iMy3jIygbT5+eSQOokpXJK8MB4ShrAOeUm/tBJNr9LtzC
	HBiUeAjrUsc8OGyPzdtxkrWEAyomUWv6W/DkE8ZFLfuzqALZjvTVSJ0Al+CJxej6
	V9kDxgBH+vg+YumBw7qNafc5gTlYaPu+ALeI6+LKdGTjFx+BCIf7Cn9BHQ6qqDRK
	J8JzI+8NRuLliuVYfg2aoGjxMpGMrVSnRoKz37aY25k4bUCeryWQDmQ9vymxetad
	BfhM14hYnHQZzXKPBcCMh8J/e7oCcUkPzbcDShw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:T27ik4MVuETB1nDefrz+QbRZK/eZlHjwQ54omg73MI8=:e7boW4D/J+mpEKnMRJaFIwDLQHfRYXTkZYviL/U7lAE=;
X-ME-Sender: <xms:gwbbaqiYITHS4deNAPoGY4lYNywkI4Y6WlBlIVEe0KSwvQWay-iJwQ>
    <xme:gwbbaqHqvRPivfM6N5As9VWUzcMuWUzZwci0R-YRRRntFlvati30RYsY4WILbTGhy
    gZ1sEHjGlcOfAnHO9SjsI9BDytWcNX8UP6RoPcSpiz-Uped6eWVZw>
X-ME-Received: <xmr:gwbbaoRKooaEMRJtU9BCZf3ct1BDMY6J3q7B-pUcX8_m-XBs4dohsbO4yB1hn-se3x263w>
X-ME-Proxy-Cause: dmFkZTFTN1iA3VsQrrX5bzhG3bGWhi1vWwHBi6L/I+FZV0Q1FGoDWN1CzjkkG1eoWg9Z08
    F1Hora1MWKwWuS1e8gUSnA8r4wS/X0JEeUM+Wc6ESNQEgPPZ8NgYysIaCtGpyFQumhwVI5
    Grpsl9osUzCs28DcLAnJfhWVAn7FzxZbFWLcZafpjgu5KRWRfWSeOswG8adxeyuUROHt7i
    ml6IhbnN4UowcLBqHDrr85XU4J3PBzglYNCwkOetmJ/PuAa5dY4T7ZFWmv7PS/BLMCmX8k
    nnPeIP7Qf43rvufBv565BUNVRSF6OnkboOwQ16eZ+EkK21zDh3VdsWecDGoNrEMIW8djme
    sYLuq1+vBy/96F/siTZyOyVcdepfpCBm+6+6EpkirBHZRSdEg4Rw7B70VZxQut+aD2zZdQ
    sKlhAi2sh6dFvzC12dhSRJh1yoHG9wJbXNu6o2IpmKn7iDyqKbVaH1ElsoxdQLhJVhr4Yd
    XxdyI3vrnDij2JKNEUJ6tk4zEDymkraL4hijJW6KnTtClEfQgQ2qtWEYy9PjLzCzlDNtdd
    pSsAwI+zpM92Uu0Jnmnl9AhYbEVtjn58/zkQMVRT23PqQL/N3fov5yqjofyOrs6aiQGSoh
    VvPaduopa0QPpMRhxDsBcrjO+tsEso4F5U3Fn/XdaCEqrYgC5J97an5jaGGQ
X-ME-Proxy: <xmx:gwbbavxvpcByUg2X1UdWP5n6ZpZSzvLHFDzjpLbb4-aha6RXbjP_DA>
    <xmx:gwbbasekm5UoWN1ij8ovxSB0eAVl78TvgqUlDOvqNeAjITi8kMVkMQ>
    <xmx:gwbbaqPwe-NyOolkoCexdES3-yB1paHpvCPg1tCYAi5Z0tqJhs7eJw>
    <xmx:gwbbavs3_-jrf2yMG7xe_YLzu_KVo-bqik45XxlGusE6Ar3YGYhygw>
    <xmx:gwbbajjGE74wVanzn3PQB9M2Xm0D1jmMAuJpnG06iO01kAxx_qRTbhYl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 03:02:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5939fc6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 07:02:24 +0000 (UTC)
Date: Fri, 23 Oct 2026 09:02:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shashank S via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH v2] [Outreachy Patch] prune-packed: remove
 USE_THE_REPOSITORY_VARIABLE
Message-ID: <atsGfWzCMW0LMHNX@pks.im>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
 <pull.2266.v2.git.1792428811100.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2266.v2.git.1792428811100.gitgitgadget@gmail.com>

On Mon, Oct 19, 2026 at 04:53:31PM +0000, Shashank S via GitGitGadget wrote:
> Range-diff vs v1:
> 
>  1:  5d9ba0cf3a ! 1:  6b583e1d46 prune-packed: remove USE_THE_REPOSITORY_VARIABLE
>      @@
>        ## Metadata ##
>      -Author: Shashank <shashu8660@gmail.com>
>      +Author: Shashank S Mogaveera <shashu8660@gmail.com>
>       
>        ## Commit message ##
>      -    prune-packed: remove USE_THE_REPOSITORY_VARIABLE
>      +    [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE

This prefix shouldn't be part of the patch subject itself.

>      -    Right now, the prune_packed_objects() function uses the global
>      +    The prune_packed_objects() function uses the global
>           the_repository variable. To help with the libification effort,
>           change this function so it takes a 'struct repository' pointer
>           as an argument instead.
>      @@ Commit message
>           prune_object() callbacks to read from this new struct.
>       
>           Update the builtins that call this function (builtin/prune-packed.c,
>      -    builtin/prune.c, and builtin/repack.c) to pass their local `repo`

One small nit: I don't think we need to have the list here.

>      -    variables. Because we are now actually using the 'repo'  parameter
>      -    in these files, we can safely remove the UNUSED macro from them.
>      +    builtin/prune.c, and builtin/repack.c) to pass their local 'repo'
>      +    variables. We can safely remove the UNUSED macro from them because
>      +    these commands are all declared with the RUN_SETUP flag in git.c,
>      +    which guarantees that the 'repo' pointer will never be NULL.

As mentioned by Junio, this isn't true. The repo pointer _may_ be NULL
in the case where "-h" is passed.

Thanks!

Patrick
