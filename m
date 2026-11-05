Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907667;
	b=rKhJKgCHUlb7BtSeIK6a+PX1mjUwe4BNtM85so0dO2WGKTezPgUeIcZ5phj6ImwJOEjP
	 XoWwad+5YR1bQTtetm9emlyqefjr3IxeEeqDVfjWykes9Oy7hJShgZ4u0Qnoet4WLmmcb
	 2scLIRn4c4aLykuioiVEQooEaJip2LWyqaifeL4zPcyX/WbnPGA7L9+3vNOCwTi3xkt93
	 DRpRjXRRwy1Z3IhHE9KmavGe/j8wKHn9zo+FtVfJpHBAZJoIWAa+G0GnZeKwaCTgsitSR
	 3xnuC3xyD7382G+wRrPaCdjbq6qT+jjvgIZSvpJqIzTj/NQFv1w6cPvDvcopLfQfqLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907667;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=POZiw6u/XyTVogd6y539p3+ywNB/ldgAoXJaxkGm1mQ=;
	b=S9ii4RNjbszNjV43t0og/pdn4EoZle9wj0B0NBGsSB8aLVqLjSybPXBfaXxGk135jv/u
	 HWH6oBNlUWRxk/kYu3f6uHGr51P9MKdhTEdEJJiiDX3eWm6dsCq4rxnZKuaJGVszqfWrT
	 4K0HilfCuXMl6NcrtWnhrNpv1e8g65pYh1BOOnMtqxZNHFNpdQOx4uPCL8819NTJnpox7
	 SIwt2otR/RCkF+eDUp33S2DaygFN8OnkLovjluNj2TwrbCF/V9ahsj3KWgUgR+C4PGBey
	 LdVhuriD7sB5F3FRVTmYlZPvX51Tp/0GcgxQrxhVAA1qswMg4BnPcke2/3rMveag5Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JSn89SeI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eT7Bm9g6;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248C608520B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7248C608520B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JSn89SeI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eT7Bm9g6
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB827140011C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:41:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 05 Nov 2026 14:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793907666; x=1793994066; bh=POZiw6u/Xy
	TVogd6y539p3+ywNB/ldgAoXJaxkGm1mQ=; b=JSn89SeI6BnIwuImkzcDyHunRG
	S21lcYq5z3xGbAVCIqkX0mvltlevutfN8GAsJFaap8BDKtW43Rn310MfayASNFyw
	adzMzFrJP88DZgostnwdaQMtIZtMTIHIk8eURsN9f84AB2/cTLCQoEj2FGd8O2FI
	a7/+6YdId0Z/c0yttTns/f/lJXnub7dq5NL38LV+OJ7Ugj49hmc12AoFoo4mmezm
	Skmhi3XVVdElYWcSktFnIq7/ZEeo/v9F5GK/gpfjvKAYe5EwGKKrI8GYN5ob4oxM
	f8tINSyzZ/PHeOO8elN9lRrlyYLkH5uzKEqk8gM7c2unoTljja+y2jvwSIag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793907666; x=1793994066; bh=POZiw6u/XyTVogd6y539p3+ywNB/ldgAoXJ
	axkGm1mQ=; b=eT7Bm9g6J84gsehUe14/cndqVyQ3zob6gsq81vAFEcnCB0loJzC
	HMK+EjqE1sQvg5EX7PHWrH+2cBUpt3yrQym+HbKxGbOtPE82y0XhMoixWIirr4m0
	OHgc/tojt8tvRg75vJYCHBWzWKHeQFuy+CU2vv2sXyOW384E52vA/xtfOVZvWx+Q
	NoLamu2yNMwV7zqpMWlcpmcwUvbm6YRKTPOTXtlylc24rc5jrX6QwsS8ZS9k1XMM
	0ZkS5xVqyanPbwl35BIzduVAQ/Y7fSsjBR3cgSG1vM2HUglpL/33LOIBNPYePiZL
	PWxQ5sn2E0qikEpNmiOehh3AlRA1Q7W53wA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793907666; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cQ1DZ2qSRwiRUNVG/ppGGT79Faqj4muIVDJzbRybOzDC24J
	eSVdR/ZQiaRpnbLy6HnfA6fG8hnLs+moY7sCcaCETIY/mjKzxypCyzSShncYhec/
	9QG72Egxtk8JmUHwFU847G3C7GbPW/gFUO1tetJIVMKgEFupHVApbmFld4S71Zdm
	vCF+Z94Cdmku3k4OYFLQm7l7SGRZb2+TXnZPvAyLC3CmwcA2lOYQwVI9KFjypt+X
	iGCDI3cYmbtMlRYZwLl9BZ3w2CN3mc1dXm0rNxrcsB8VBy/w7vlHT0cTEx7BBDCh
	QGcwWnsG7Fqetg1HB1lm0jNlJuVtMbMIUTLezEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XZXlOTcl9OXKiSBSHAexAnu3Ug721an83eLFAJ3pQew=:p+1z/UoEjrelIg2sooJwMdj0PS01MZr5syRvRM+ywwM=;
X-ME-Sender: <xms:0tvsamtejtOIIe1cOL4dLS2P1sS3dZ2p-9XsCkcV0N1gbLgN00C8pA>
    <xme:0tvsattZ5M_gTEVSoRgQMIRCNT31cgTdDDpN0cuSE_aEB4JeHhpWpu9A-oP6CBPGF
    SiYPdAMbeF7jm43_hiFHGcD_16dz1a8fxsHDaGNGSebnxvSAaysfKA>
X-ME-Received: <xmr:0tvsakDgHFhg0rqj8xEVQcrr-NRGd2YnmrraqHnrTX6XMYTXB8tYWbjKpV3EoSqbWnQDOQBbYn-XrHpCuzUCWDcUZrhdCdM4nunS>
X-ME-Proxy-Cause: dmFkZTE6Z061zqq2SACerQk5RFjfssyL+ClHxX8kFR68kkO1/BPqEeXoUikVSOPzoHz5U4
    ah8yetCoZdqX4X+vQtct2AmQnWq1rtX0dnuFneha7fI7dpt19z9xYz2X9+ORApp+4l26o6
    fwU4C3tiw5L3x2cucRh5w09XUZc32on9+djlu52kJBklyY6R87P6QiZlGmpx6ItY3jfbZd
    UJjatEfRoMYQWNx4FYHKZ47La8dnq3WirIeNrq/+u4e8mSCmcEM2y0SRmbwJLnt+yE0p93
    1l366LnRBZdivUU3a/WSaMq40DXi2F5ybSIMXfORM6pmzs2i9+T3yH0U+N1+Nm4VxOOvVC
    VUR9HXDpK12TD3C5d3PkBibrbMLnjbHn1ENia1AyoqhQJgHdRTkhGjd1OG15XS6m9Af/aW
    BQ+7mRnpTp6fdJA8qYN0CqF9K+krJs7Ung3uLKewsm/NSWHCSTV4g+SKjQO8bsT/gEpZIw
    VBO7H+fwNkfc/mETYWpvSbG8YqjNyqVXeUpYBYNT6WDsuIp0tTv3z2sN+MJkxVBgiuB/os
    zjRP9gYqYCwmH5CcY+C3346EAQz2iMTGZXgaRXWZQhjO3QbbUKAbvuREeZa5CunfUbwK4d
    7VhvLNWz5E8YlQeZNL4H3dOBv3w+7cFEqaDtrqZ/mW8VDi/eud0J2JlGssDg
X-ME-Proxy: <xmx:0tvsanNpdD_souWDgmKXaM3LzW4FKWAHym3ZKhJ7Xmar4BUqVFinZw>
    <xmx:0tvsalwMB9ONZs5jPiHeIV4rscpYKXi5FG3Qg8a9yT3qg5SWbQSYsg>
    <xmx:0tvsavVKOK5GlF47nxmI5tMagg_jTtEVSzeznP9sPh68GCgWTglshw>
    <xmx:0tvsavNjBsUukzWtfn3yo_p9k4lz4v7_9EgjZLl3s6_tUrrLRCNEJQ>
    <xmx:0tvsakyywk1_4EIAUX9yZWeDtpJ7guOj2z9RO2EJVbSz_EHu8eZYYpSm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:41:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Julia Evans <julia@jvns.ca>,  Patrick Steinhardt
 <ps@pks.im>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 2/2] lint-docs: check the guide list in command-list.txt
In-Reply-To: <20261029184834.2273-3-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 29 Oct 2026 20:48:34 +0200")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20261029184834.2273-1-taahol@utu.fi>
	<20261029184834.2273-3-taahol@utu.fi>
Date: Thu, 05 Nov 2026 11:41:04 -0800
Message-ID: <xmqqcxsjt6b3.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

>  extract_variable () {
> +	file="${2:-../Makefile}"
> +	directory="$(dirname "$file")"
>  	(
> -		cat ../Makefile
> +		cat "$file"
>  		cat <<EOF
>  print_variable:
>  	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
>  EOF
>  	) |
> -	make -C .. -f - print_variable 2>/dev/null |
> +	make -C "$directory" -f - print_variable 2>/dev/null |

I like this sayIt pattern to prepend a snippet in front of the
Makefile.  As we allow extracting from different Makefile with this
change, it would make more sense to (1) make the path to the Makefile
mandatory, (2) move the path to the Makefile first, and (3) use not
just the $1 but all the remainder of the command line as listing the
symbols we are inquiring.

which would mean ...

> @@ -87,6 +91,7 @@ check_extraneous_docs () {
>  BUILT_INS="$(extract_variable BUILT_INS)"
>  ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
>  EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
> +MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"

These would become

    BUILT_INS="$(extract_variable ../Makefile BUILT_INS)"
    ALL_COMMANDS="$(extract_variable ../Makefile ALL_COMMANDS)"
    EXCLUDED_PROGRAMS="$(extract_variable ../Makefile EXCLUDED_PROGRAMS)"
    MAN_GUIDES="$(extract_variable Makefile MAN_GUIDES)"

Other than that, looking good.

Thanks.


