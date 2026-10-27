Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128700;
	b=nEP/g/OFURN42TtoQRLW5hyd9j7YQWXxLVnck0lhP241TIHFH52XN13aBGeIHiWiz71I
	 7rC1dUXjC+JCfyXi5GeOqosZ3lX8ivds2dI7HOoSgVnwnwbXD98vLcvBNKvimqVyjqg0m
	 W/1EsjKw8abdaBvoWq/RXZKUhH0CGhgEbjGTpHnn9iWiLWaZV7GW0ffNvLYg4ir5MGIiC
	 oR48pSKlalmsp0dhxeeta/sog/p/jnEWk77wAWqWhFkImdo+V808MQwNPQxriCDPjaxFQ
	 gR5HwOSuo964xrvPdc3XvFx5IboCxStQAV8etRI5caYNdN4/HJgUNs+CYBcAHLHmIAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128700;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Qy5NDw05BCF4+ANBIhGPG+EJ4h/kY6Ebb0QgI7ZVPfk=;
	b=gVtiqMSrXq+Qw6saiDvImlyUOirqq1HjgHRhmNeTTwZrjmpE1zhhwLZ6u1vqr1QXSpne
	 t23lJaeKQkCVdTO/gEQN/vOsAZDMTHnmq/JeHq9Ql7hcjH314e6h8uN8IUAjhXTQ1ozn7
	 Cg/73GiiEUKXV9ctkSJGqtc8XI8Vs1S2xoAcOF0HikjhH4WgSTa8od7tlojYXZPzm5nPR
	 i57Jg3KoooE9ET2xhrFVXcoiwnZ+iyMaP80tnvipYsVO3ZN6T9I+QbcvOAeNOdNJkuNT6
	 WbzI1NqquWM9NpX/Tvc0205lpqIdF+yxV5xCr3ev6GCdmlKU3gBrkKv2rW37y8u3ZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OWIxpxWz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="qziM/GjV";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E504606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E504606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OWIxpxWz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qziM/GjV
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 358277A0181
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:18:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 27 Oct 2026 15:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793128698;
	 x=1793215098; bh=Qy5NDw05BCF4+ANBIhGPG+EJ4h/kY6Ebb0QgI7ZVPfk=; b=
	OWIxpxWz/MWVk6cxOM6Wvft1iUFewlULxCmahQ/57tTbFTznU30aU8EsR5S8fEr4
	7JFnA7z0dppsnPVCV4hz+LJK/51iMdwXsWF4hdaYQJEHH6k3NYXpW9NyKspvUCDi
	Bf6xo3Eb08r3vcM2/imuxRFb7mAnm5nsE5X/XdJpVkL5azlq+Tt+ErE+BFiF6nU9
	ifdrmMPGfTe5O5qigSwG2dsE73CjvAtECykSJAADFxGp3bv1a3P5PYGaWNVsJ7L/
	X128Dm1WEHXYvaeGm//uJArVSe8XOGtzRpEg51+5q+8pXboWEZzT7rerUYn/vSIn
	3gCi6uFECa3HvN7rnK2NzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793128698; x=
	1793215098; bh=Qy5NDw05BCF4+ANBIhGPG+EJ4h/kY6Ebb0QgI7ZVPfk=; b=q
	ziM/GjVWPevgT4qO3EQjn9t7t1WsnFJFsAMJ4SQz9zWYDGyy44SEQpXX141VnfzQ
	5YVR78UT72sYhlWy78MtZuIsJ9KdLBVtHpn9Pg4j4tq+4SJSL1ohqgHaF9Xh7so9
	sLPppcYIWFViDh44CI96daib01w3QIovIYcf0O9YIxcOkN495TvY4va2zIoA5M+G
	AwyHD/sCHbfEXEbkH/JyJcy68vR7Jm/xbDJfSroALAfSW/x5e9GuejSGhtEUFFSY
	lugF3V0NJfxoN7VBW9d6r/J/str2pAU2CtEb9qIT7rhe8R/q9ureHVbOYwlJ+pZT
	/SjO43UoiwaCLgbPXmCSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793128698; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PQ86OJ8ShUUcqDT493Y9kSgJcDHeZW7/AcSLGa0HRJsaXoQ
	zjCfxQQmRccHjQVXMeTZW80ZfyOnVmvhm7QYkD37VP4CapFAU50M06UkImLJzD9G
	hhE50gVGApOhuC3dhAk5dohe7SFwt358e7STbOKVQ1bs77pjzYMmatjE8yNbUkd1
	FnoHNZGDNi3zuzRRM2/soijofGyF1YykROkLu4NsNotPOXY7CvyKa0v90roGGFSB
	/jRLb8ezWbJIgEeGhd1yPn42gHZJQPGzhWodjOnPGwIM1upZpXW1PMOE6iu4ORIp
	53qwYvKmhm55rMLpuMVnQ7aUrwpPQ9Y1fWPJVSQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:XHZqNNl3tWTcmu70LDHBG8c147YeySBIB8lSPS2Heng=:HePRDKzNkKjSqcap0Yh8OjPFYoippF44NVQwD9/6Jlc=;
X-ME-Sender: <xms:-vjgamgUxsB-AknoixZINjyNvkR4RibrOQXS4AFyO8L39hjRxCDTPQ>
    <xme:-vjgaqth_QEl0R0DjsE_fOeqoZpBVaFYHlqKQnXto-uH_CYHvPAqI7rp47diUuZ78
    YELByXSR6LP5CTcG2n-O6GuDMCHbv24On9mV8uq4gf-TNMIPQcUYQ>
X-ME-Received: <xmr:-vjgan6SCRs29w2BZE-rauw6qlucwmAkXm8gNqhIKm3oYHpMasbL5wKB8nkUYcSpt1h7_biJqeTexNBJLmyNupHNd7mUK9ka1o4F>
X-ME-Proxy-Cause: dmFkZTELto9DpNdEM6B0lgwM5n8r2DaZ/Ulc6cLlbFEc8sGk6hEZEYgcm0LlNkpI3h4KxI
    gLItw89mZH9iXPUl9NpJc+ECX7shiJC55EHq3rGPnq8YFSEwWw2ZFgK0aXtgLt/dwPBVPY
    QHXPl0RrDSZ4b9dRwM2yY3FojpV2K79FLdVCgEAp6FaJl0i60G+76c82/65qCr1VNdMIPm
    zlL+DFwOAt3HCzLEkJbZ+neM1wUzaLanDgPStOv1jVOs0ULgAfld251K+y/6nv9+/pTpNW
    TbimbuSN+aTfpyz+9sykAGQNRlxUNgc3PP0agEFay0wO2Lwc8k/uqnioW7Ba2iY1V+ZVZ5
    EQJCAORuYbpa70HfgqkbM0j4lPz/ORzE8xJqXT5NCZ7cnfplq+pf4wt9w83HmEJKXfou/f
    wAiDvq1v0hjuwBR4s+skS9XsaUrS0BzYR2YthVW3YarT1kRF8mO/+h82/Thawz7ofnLaiW
    lPNED/rZoZBPiliYSc7I8AI8K7yPkQwgcGy3lscEn0CxWwm/ZRXdiEXaa7LCKjiKM6Hk+j
    QIxnm47VVKehBeYtkBnZtziINsqeQBviUc4LEM8R26gThebEIaM06F1Du+WNbeXhfRN8tp
    3WXUkc+qI+FrSvcSBQP47O1DI2IRBH6OHuH5GJlyIh6YUiA10vwme9R5SSQw
X-ME-Proxy: <xmx:-vjgamMDxlAxS6rj-hWqPLpC42aC86S6m54UnSHKK-JjtZMIZcr36A>
    <xmx:-vjgalsyFKv0HcQB_ep7dNuJfWTVLHJ-GNjzI4wOXO21JBXd7tVOvg>
    <xmx:-vjgapZR6-HPf8HI4nHeuYFjpkZp2xwUHTnCSwdCqWGsVSO5hxYvow>
    <xmx:-vjganz3zvTAry3iH1ihjbJAYGYr4jbLogazwWeIhHXTx7nJLtC9Uw>
    <xmx:-vjgauSu7D_2N6egInye8WAzpSucC8-G4hT94FJgUuIOs5pv-5ogiJUi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:18:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
In-Reply-To: <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 27 Oct 2026 14:00:12 -0400")
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
	<E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com>
	<xmqqh5i7kpc0.fsf@gitster.g>
	<CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
Date: Tue, 27 Oct 2026 12:18:17 -0700
Message-ID: <xmqqh5i7j6km.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> I can't speak for Julia, but I read her attempt here to clarify things
> in line with the ways folks usually use "ID" vs. "name." Of course we
> don't always want to let what other people say dictate our
> terminology, but in cases where we can make things easier for folks to
> understand by using vocabulary in line with their expectations rather
> than subverting it, I think that's a worthy goal.

That goes both ways.  You can tell that to those who are subverting
terminology that have clearly been documented for the past 20 years
in our official glossary ;-).

> I still find it strange to call "main" an object ID ;) even if our
> current terminology says that's fine. Heck, the glossary says a name
> is a "unique" identifier… so there ought not to be more than one way
> to spell it, even if there are many notations to refer to it? Alas…

I do not think it is OK.  "main" is *NOT* an object ID or object
name.  "main" can be used where an object name or object identifier
is called for to uniquely specify an object.


