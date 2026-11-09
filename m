Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210932;
	b=W5FkgQ9uXJSpqILx1l4SVY/lx/KP0JeyInvwi5gJk3o2uKrK+iUHaQwqlNgcec+YRBJe
	 tCXOqeldUR5G+4JNkwh6H44PBVWdw7uHL5VolDJVqIEdPGm1cgA/AQsnEuNvsyAxqVUTF
	 RMKswIrNwRWQ7MpujnMlLNjKqrZqf72WWISvfVocpsiN7MuBT1qQ44fyNVgk4rLbLZNjr
	 RuPeZFebnPNSWp3SToRQ7S014NXDKLvpP3h2RaTZq/9cshGKZaqA1dp+GdfnjzObU+RUq
	 1YQrIFuLS6yRcK7jVg7chiFbCLImNH4svoEt1aAWtJeu2yB4nVxSscxiNMbHJIeUhHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210932;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AqmqyU/z2ADe3ewz3KRxu1R+GppXPFYREyoLLfAs+yE=;
	b=i5JEbep5XK1L6BjU2LMuc7hMjKggBDN1AZ9pGvOumCr3rLDjnLP3I70mYXPw6hVPNEFv
	 HnI1EbtB/p+tSEq98TDOxvtT34PLNnx/6XqimGywjq7PK5GblUif03Au9tjRv72sb8SRI
	 7wtmo6eoWa7EJ4/caLAY/PERAT9WhW0z8yU/A6ERUGxL/J0wU/yYCJq6eubSvlCKDI+Eq
	 +1jB/C/zhACyEASLXis3XexvRy5CQbW5JiLzcottQUQam1STAUQ9TkP0Jjr0wOCbCEQoY
	 lgtEsMEfkXiyBuUF0jbXbkt9sDmzOFD45aEgpe9hz0BI7NwD17AHlQrfruHhSoz3qSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="HeT/ShPt";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="onwK/kt4";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03E9606A322
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F03E9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HeT/ShPt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=onwK/kt4
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C69F7A0120
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:55:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 02:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794210930; x=1794297330; bh=AqmqyU/z2A
	De3ewz3KRxu1R+GppXPFYREyoLLfAs+yE=; b=HeT/ShPtwJwZKXeroDtv8revOT
	iTE4wcby4L2TP59jux89YzQJrKKzCMNX35KsVMby3YCinUVv7SJAmjocgddI+od1
	0oK+Wq/13s/VsAwcU6W5AWaByOqRkJwDmIiv2uH77Pk4b2vn+Ty01xTrB9B2pv82
	rIavS0cHPZQLhG4VgtdgdB6gkrHxgjrkGscsNL0ZE0nJydsacHZe+NdhRRYF5IYQ
	kx7wJTCRn/0ld9R/6kZf9HvlYPk4gQbXUc6+Se1A55LBvBN3ZkM7cC2m6vMNjMxK
	tB5F40G3Sv+X4PkYFaj5dnGCmtVX4wDa27PD10WjExkoHds/yju8eBCvTENA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794210930; x=1794297330; bh=AqmqyU/z2ADe3ewz3KRxu1R+GppXPFYREyo
	LLfAs+yE=; b=onwK/kt4vXN3wbKDpgIPWPOsSBKZq9D5hV+S/LN1d8ZgajD7gKm
	NoVvfS1p3UEB0ja2tUnnxuPBIVoWvlvpMEjgkDxnn3dMCXV+kAXvt4N/SfZznnW3
	JRr5qVLNdFSsI1XNmOH35Msg5RPQxXNXDJ4H95hURWsvLwD4SflVnVbvTvK4ogyg
	665e23QBQVHg/ffXQ9Sho3XDeOfOmUq4Y//EdKeI/BIY/1M+qBBhg6Y82qBMbPrG
	sxAJAEuGDacvcjU7EOf6rsdLae9pVszvAOkE5atA4q9jbE96AIiNDL6fTzmFgYrV
	86KPQAJZqTC4dzcTOiuqf3T6cAhc4/VlrJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794210930; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ke6CYBQOlNI71H7yjiLdGC0764nNlHNRPfuaotYDj0tGsPw
	36loL8hoJBqcNu5Cxs9x9NYf8rpXtAM0BQB2eVfAJxP6f2Bsn5NRIrsRgAlqd+pe
	9Pad0hkJP4jCwHuWFvYMexcQjouAN5YjjldDnJA23FPfkrhCSLUhYQZiOr6HJzAz
	LqCIl6LjQISZonc3XYDdMSNSgcsmAkYUExBtprlr/0yJcQGalRIHFvt/4xZFgED2
	wk0gBWo944OlY7bgx2tileFQq9bJWem1oafJsbs6dAx/BQVEXrYIgkKzXzAy4zEI
	9BQ6F/KjoyOUsL42pm9QQmzPDS0ZJv2O8SBAefQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eaFrts0n4KrsAsAbDrpI5xDDMRZvCPKHc6D6vUuo5R4=:7iuYQYduwdiRO/wZZ2Yu+0OFtsNNz0AlkJ5cZBU3Nyc=;
X-ME-Sender: <xms:cnzxaqSnwBIfsgYsfHuT_APAyM9eW7advL4aGvj_r1CPddrS9dhQ6Q>
    <xme:cnzxaiC9otQLzo-owLxMLSH2mokDSLfe4JP1HdJA-o-7G-7OowflGVY-ski3Xa_ka
    gQEgE9VqT65luPfK17pHIR23gLjLe-dbmfJU4dMsUPu8S0al4T0qUU>
X-ME-Received: <xmr:cnzxaqEi-cPqIPSiaGY5Za1THSx7bfQ_4LYo4MGAn8lufgkXdg7XhV82TzcGqjyeHrzdV3k>
X-ME-Proxy-Cause: dmFkZTFSVZTHWwaNhma5sLmOQKqy6Po5E2cau6YcS7ABoTZpSQkg9hzCLBE7LpfONyho4v
    syKr+7Qm+8Tn+QcpZDwNmDgYYOyJ3ConcBtObHx7jZRE8AwmXvbs18/JzNG78/4YTXWgtP
    1B3gumB70q1dOiFm4wM65bBxuQrN113o8vA1/OAZ5lx7My/nTCbtIA715tsA61E8JRkO0q
    Xa+54AWyiKQ+MsMIpOE66Cuo7ejs/Jq677uexo6Hby/eXWIpslBsQWFiLVcuhMPZJLRMlf
    9QK1Nudn3ixv7f3Z7lBu3XevrRKQOLkk734tmrSyfRhQkSRUsT6NPzl7z6DoBpvrdsfCeP
    UYk/KVVvfref8kMruikQwbiXob9bbqtUBHJ9YT3Nn/GRFL1JjFyX+gCWFYtdAyTI6FkOjW
    6EjOIlFTh9dK+pGjvHLxIyOlOxOtjMbeicdpmazzmN3OjeK5xhTySaAx1+gj6eg7/6jbnH
    deSddNnHIyjA2Q87gaAqaR9afp3vSaQi+Th6s8XdnUDqvztUnB8FLfcmRWkamzjLEluxCf
    KA+lXlsKG5ntEecvLHuTpFiMNNrbMqJRog/WtneJ8fTziiEMVPrRd3pVJwcOR/icxg0PZl
    VHSrwzKMuThCnXnRVSGN1k6bATSJcPOFxOYmP05s4xCwogKD1/WQY6+/7Zuw
X-ME-Proxy: <xmx:cnzxasDSS1-nrMxXtCi4irRhoEbj0iIegq-4AaRndov5ptcX1uCgkA>
    <xmx:cnzxaiUQVsNaNeVXsMScaJN3aA7qXC_nVYrYI-0e-Q3_U4JOTDAcpw>
    <xmx:cnzxaop9j8j8jiN-scu0XzaordKbYJRHHGvTo7cjR2FoR-0aj8vijg>
    <xmx:cnzxamTL9CroWUWmALIgR8nKzkYH-AUudxq3ydIrPVV1otStiF7ybA>
    <xmx:cnzxakwpj7BYwUmlbNuJzpifIGUdNlZQsV7T1BsbHtwLWLS8uLf-cS8Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 02:55:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b107c8d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 07:55:28 +0000 (UTC)
Date: Mon, 9 Nov 2026 08:55:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 2/3] credential-cache--daemon: allow a concurrently
 created socket dir
Message-ID: <avF8bbgwqIBJbs2X@pks.im>
References: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
 <20261104-fz-credential-cache-race-v2-2-ddccd0831eba@gmail.com>
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
In-Reply-To: <20261104-fz-credential-cache-race-v2-2-ddccd0831eba@gmail.com>

On Wed, Nov 04, 2026 at 11:53:15AM -0800, Farid Zakaria wrote:
> When no daemon is running, two "git credential-cache store" run at the
> same time each try to start one. If the socket directory does not exist
> yet, both daemons try to create it. The one that comes second dies:
> 
>     fatal: unable to mkdir '<home>/.cache/git/credential': File exists
> 
> That client then fails with "cache daemon did not start".
> 
> Fix this by ignoring EEXIST from mkdir(), and checking the directory's
> permissions the same way as for one that already existed. We create
> the directory with mode 0700 instead of fixing it up with chmod()
> afterwards to avoid a race where another user enters it before the
> chmod().

This sentence is very puzzling. Why do you explain how we create the
directory if it's something that your patch doesn't even change? And
also, why would anybody even get the idea that it's preferable to use
`mkdir(dir, 0777) && `chmod(0700)` over `mkdir(dir, 0700)`?

Patrick
