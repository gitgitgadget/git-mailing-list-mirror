Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424256;
	b=a8ZclJXf0iF58DW/32H7T/Gx8Jo41AMTsOXM8Nr/Fo9CkgMZcnbEix43C87vfNMtJZgE
	 QMTuuW7tQL8wg1WJe/gbyyvEzQRH/cC1brURNYb7oPXRZxYdfcIJNhiIdWfpNBq9tkxru
	 AOB3EE8Mhg3ASFF+jy6fSeZ9MDoQCY/u0r+wkv169PO8wp7pdz1pu35+diexBoOr9M+PZ
	 Syg8HJIuZra62z3Nw9dI/N12CbsWtYeqXtHrrDepsn0dMrgDt4DTsMZcSnq2gKyubDUx9
	 r4g3RNc5THJJQD0f3YZOJ5e5G1f8bV8uaHzR2bltxPA0D5KLq5iWjDEyTU2piMFVPgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424256;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Ja1ZW01mX+6v/gbcM+DCuyNxgxKe+T5sOTYbCGMj7G8=;
	b=u1yoA9IRyhusGbfr7YQhM6GmYyge1INodsKKXEcPk9H7JiHvOQ/aGEAJKtzlcxj5BD5U
	 GqjAA++4R0YGVQIj78bKBcVkFMQgNhBHxj/LpS8TqEdifBOzjM2yascgqtrKs3o6oYeLD
	 ziW4hoH9L8PL/hK5Y4CUjQYdimsAcCvu5Y3S/Gf6W2OPTQKhCGaHV7PXJdORlKJeHPNlB
	 edBxXJtz7ZuSX3SfX1Qdr8n84/hAk3WwWQrmp2sivNfHvrl0S6Yz8rmKujzmLkyHv8epR
	 w3Yiqaklp8O06PJF/4mZzpva39cd40eks3OvnJ3IMAofvkOfcT3u7j5B1HIt5B0RKIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=WdMe2CPa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OyfTumWR;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202E60820F4
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1202E60820F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=WdMe2CPa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OyfTumWR
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 611FD14000A1
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:37:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 11:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792424250; x=1792510650; bh=Ja1ZW01mX+
	6v/gbcM+DCuyNxgxKe+T5sOTYbCGMj7G8=; b=WdMe2CPaQpI+aoFZaplEhS3s2z
	PIsx1DEJur7XUb9BPE/yrcicS1XbjWVECzEzA1JPGmMG+qE5r+VVEtTpU0RGHaHC
	u99iLCteP71F4uRRfdFKUO8MD1sWBT0SZX+DltAaighBF145YJmxZjReL1a2mZ35
	Or9dGbujSxDr+9h2/0T2JHk5GAk5825EIveXXyfBRs7tBTlwdl0wDW6mbm+thIQR
	/3ozRD5SiuilHoKcH8I2bC+/uILttW27CBCUft33PjcoRAesJLCu3DKUtcnzc1R4
	+uRoQw5PKBMueZfhqkm0oYz1k/Xhhh0FCcuSa3r+MzfcQpyg4PWlyPoA7QWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792424250; x=1792510650; bh=Ja1ZW01mX+6v/gbcM+DCuyNxgxKe+T5sOTY
	bCGMj7G8=; b=OyfTumWRT7g4GjEiChtu36I7w0deLOSXQRwVPasN15ojsOXdOVh
	QGyA9UQy1kbqUVYjZVTDe6ZezGCqzsq5omc9sDFCo/MMA4It38Em9oVuc3/b0gJ9
	SIjxnQkHAFfaXbMsOrVBEVpBukKnVBsBhQcJ09+AINWJlW4vtVcZHokKkBktjR0l
	fjBkMHwWF8qB+Q9+EQk7nkZanbG0bay5MFBj2OOsTK9jyRDt/X+PuJMxip4jOIzy
	39hLLJKLs+Vm0upfKRCRol1QleBntZWBVYklSO0r8+o+HGQuaySlQm/pKrD4KZBD
	VdIhrtKzICdnIWrj0Id/s77enM+SmezPT1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792424250; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QU5FHLUpkfkAoXn9vsgfb19fxykkuMrBoyd9vdExcx+QVva
	zYi9W2FHNxqR42PjgK7QuoLywRKxdWqhy424SDO8tA+ktwuWg9vxfcySawb5fxmd
	2I0AbGjLcbvOmBjIhF9sqjPm8xxToQZFcBZTuj+mrTi+P7UN+pwwwNMiOo/YRwH3
	nwyhy2Zq6hKkdhWcLzIOWBi0pIUSvgiQ6CSsI/+SDYYiyX9ozpevCosmzAhVgb7S
	cwJBUY7CLAnw7L9JowI1gRLLT1VonVgqm07lhiVwLtgT4fJa4LVoGR3E0O9nOUK7
	iywbDPPSknwQ6Dzwrv+q9KQI0SxttwTFJ0OBCCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Zn7Kiql69/U5iF+LFxkcAZGmvZw7MOOPaIqvpWgyLso=:KKBbthdYRO4yaqXs8FfbLIjZuiJiZEssyrbHJIJzPyQ=;
X-ME-Sender: <xms:OjnWamjJVeGA3ye35INRaCpLvLHSpa479rriQ2FjDbNEvzfkoNwe8A>
    <xme:OjnWauDxiEPUhnE-qjAm-nyeDwRbur7NPjxu8kYZT0figE18PAO6WmxLqlfJfr-GV
    iHrvRnMsjUNa517Ejr__OsohartWsaYvtcQXUn-Y1xb3v1Vw_qoMbU>
X-ME-Received: <xmr:OjnWajFKCHMJ-i0kRZU9SslvQXlyiCmGkawcrXyIl5qNGxFiaxK1jYProHLGNxljajQbXbAZ9BwwdGfZIbMmdcBXt3lZ9dch4GF_>
X-ME-Proxy-Cause: dmFkZTGgqyBx0k0LsibJDjJEqGhm0HaG1Ji0a8n9j7y6GLlAMt0MASwQu46EY8z+THHwTb
    l3I0mz+NNs1DrmxeNZtqe/crOH47M9Ms9DFhFl8jRJNh5bJ6DwQCPX/PsusTd/b0Etd5cy
    f1rvhkx+4qmdyXdxUXe/jKO6xuCvz4MOuVXwvzu7Xtcqd2XARQZu3rRg4I7ogOfrCrteFz
    PQ2l1GehWkIo2oythQbRa9656zgKhzr/weP2O5XkvDkb5pDine+w//LobNQS1sIhbv89Z/
    LLcGqx2rS027PbvTJS2VrNLey00LkZqY05G3m4sPvmPHUoki7RWwvzWlwC8+0U+xLoXVlk
    FGc5//5MaB1F0C2bYrOKWJK4hILNybfbvG2zuZvJm3bkpdLF/zuY69PiVvxHQk/iYPNa8O
    dh/K/n2tSn12Vrv/ZjgSOli+iqZUE/c+0pUlTpdEj/4tZO4lyGP5A6Wjull1oPp7bbGxWn
    IsXIkpK16Ku1MP7pe+Js+UTH4EwvDJTm7O2vt/w+fuRJKgrVJkO6k0V8kzoEXXp52AKvyl
    6a3o/GTBAAAe2tee9KzYTUxusovkgI2NI7pWvdP8BZf71UIgTQBqGauN76lc6AFY+e2BZz
    mAbtu476yIIQpVVTN/Ed0J67OkvAp0Yonv7sdSZZOJg9glfD6WY4cojhGu1w
X-ME-Proxy: <xmx:OjnWauKqeymtkDKSEkSBnA7shAY7dBTNN18l8BnycxL_33ejr5I09w>
    <xmx:OjnWavkDyPY-6OYsIjHw974_59-fUHMzcWhx1o3UIzbahYLAYfEuEw>
    <xmx:OjnWauS03azuclZQoSnuSnSPrbSXHz__jDP-9PA5tUCYyJmabK-PsQ>
    <xmx:OjnWapLwBc21xP2QgWS4nDRJLGPhAszZVqW3V5X2P67mJ2Q9XpXbeQ>
    <xmx:OjnWatl-e0TZI-EOC8JMDq0kZPQhfQIMXelKvXHDPf0nENI8NuNKBxM->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:37:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] technical/partial-clone: narrow the one-at-a-time fetch
 limitation
In-Reply-To: <20261019023408.13062-1-f@lex.la> (Aleksei Sviridkin's message of
	"Mon, 19 Oct 2026 05:34:08 +0300")
References: <20260903125531.68044-1-f@lex.la>
	<20261019023408.13062-1-f@lex.la>
Date: Mon, 19 Oct 2026 08:37:28 -0700
Message-ID: <xmqqcxt566rr.fsf@gitster.g>
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

Aleksei Sviridkin <f@lex.la> writes:

> This one got a review in September and no objections, but it is not in
> any branch and not in What's cooking. It still applies to master as is.

I just looked at the patch and shared Elijah's reaction: the wall of
text was simply unreadable, and I gave up trying to read it.  When
there is no active support, "no objections" does not carry much
weight and is not very different from "interests nobody".

I do not recall what the situation was back then.  But if the reason
your messages (not limited to this one) received no reaction was due
to especially bad timing (for example, when the mailing list was
flooded with AI-generated slop and readers were tired of seeing it),
it might make sense to polish the patch to avoid looking like such
slop and repost it to get more exposure.

Thanks.
