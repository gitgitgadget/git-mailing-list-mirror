Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204797;
	b=MEa7NpqpLHNLAwprYd4Y2x+WP0Q/hqc6LuDtHe818HlH0mfEfZd9xTbWd5CkUXyeu+Fj
	 F1FfbYjrSkYSk5rTxFD1gJyxXyErLgaEaH8Yi/xaefHbnKq9mmb4Xy59xRIOQd1tEsIei
	 msNMyUD8/ARIyAKSuZnip6lkG7CUl5JZXRynQOE3jQxucLg7e5/kCtr/HXMKl7OWk8rg6
	 jAe+Og9sHy4992Mv6bhyApdRiD4rBH/YXVyJoInna4PHntKmk7hj5hqpIVNZwl7+Z+4WR
	 SyaBiFv22RbWZnbl+gywh5V2nSZ+ezH4sn5ScA7ZzqkhVisoWa31CcuKL0nH66uk08g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204797;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rh6O6bqg1Ib6WSHbQ7eAiZTxG51CATO9Z5Vizb5THgw=;
	b=FvxzdwtKesLOrNmGR+A0CFFIq4gWuFaoRmI4pVMhkwlhCxGcqVi1y10U3mjsYGhiWhEb
	 VWCYxYKqE15jGAenjmK0knUgC5HTsHEGGZYeEKFFkcuqmaT//1o1+rlTXpVAWTkw17FQa
	 IaGAHP4Ex8g3zRpfjBaDYsaOK1pBcfdISGWs3ScC19NOIh01gcr2Np84psSy7PQ6ABmvo
	 dTVpUthZ8sqCxsdakBwupEGB3XdrsdMVZ3dl8jI4CzOejOPDeyNFnw7FT1/i0myWR46vr
	 +S58e/ovfqrvKyYqdN5Ogv4uNXhSzJXSN7KNBBlTbBJTNhhA1Nb9JycXe/qcV5OdqCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kTxqpdJm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CTlgQ0DO;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E5606A32A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875E5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kTxqpdJm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CTlgQ0DO
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4A357A0133
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:26:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 12:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793204796; x=1793291196; bh=rh6O6bqg1I
	b6WSHbQ7eAiZTxG51CATO9Z5Vizb5THgw=; b=kTxqpdJmmmj14sXAfR8PXq/1o7
	Bg+dqj+Xple5UMAld3KfXPiqhL+60Y/OdJFxJ0IWtBygoWtjbI/SB/CI1Pm26X9B
	af3P9AdXuR1mkA+cN6oQdWtvXbVHgJxWmyZEr1jAxW1DJF9w1VjIG0TrcO+DHQBa
	qml7qnexaDWPDDjBkVZPOFv14LxQR9ufhGa+NrNQ/jKjcD6+r9766/FZ7jlAfp0P
	+TFM6GN2hxFcvcOXaix87HcC1uMXlWfB3IJz1rlNJ2HMdchQj9y6AKfjB2WsssQ5
	hJX0e5cLTzzDLVZLV0yHDUdiTiNNEQ9wYrd8mf3lQziXHKoKU11gzxyfIZRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793204796; x=1793291196; bh=rh6O6bqg1Ib6WSHbQ7eAiZTxG51CATO9Z5V
	izb5THgw=; b=CTlgQ0DOTdRj6KA2auFIWGYK1V+7jl4BSXl6GkQpB9e9eo+d7SU
	lfzX82uF8qrEYabZamC+qa7z3V2rQvhs7HGoo2nMUH2Re5OCdLFnVYz1/ro57r14
	hUMlJb2J4r5ffE+qGxAeCmny0ZfQAPfZvFmZIpK28tAhkR7p+++UCI7uF30Gaye5
	brYZbB8zzrtRREaM1/S4uTowwdTngmR+RzupnvwW/R1dm26dmaA0eANypV9My0Df
	B9H3Vd78Ih9xbJfP0u1smh+aBMiyXPCYuYJH4Meu/Yl5Qw48Wia40GAMo6q/mPKH
	vg92sCZGHEV6VmVt8jQP04UExpQW0Kzp/hQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793204796; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Uwzq1DGVEYLPV3JuqvdjrDYNGUlCD2PvebM/oPeeHTtVEgy
	ywcuPeBm8Z/T/cr+0/CkEIXnbtQicQH4SeZytcsq9mh5wV2rpJa6SBkE2gqgUo/b
	WW6W16L1h+AVhilJJCW9wx3Pwyww4YM9bsc7Px2aXa8iFTiwQUNtiLmyqHiBd90Q
	DvjENKq5XnDjyb3SC+9LAJ2KGEGkVcjYBg6hP0F3aJ+Qd5QwSPD/0IBTRUyPRoc8
	74CCWYVjwFGucMXYPtKRPHUZrQpmkslzB/m6pSbzhDv3NxgfNCRGig+Hk3n8dhwY
	AnYPB+dIGDp9RHfGkFKOlslyFCKmxtUqT1YSXSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jYu2i3XxEp1SbodhXqGeyEJGbQ8YFsAEZ7J+NA7saGo=:uAhsQl4pmwgmvgq6EBRcpBegRVAyel1uSUnrs/yYDk4=;
X-ME-Sender: <xms:PCLiajDCg-1TrQVFhy-yRVdVA4uiYJufYa9BmnYah4_3udTXkAFLOA>
    <xme:PCLiaonJObQn-CgPUxfGYAXTTX7sq080U6bIsHzKk9DIpaYhnMIGlqoovoONmmlgz
    Rm-bTNe5SMlFB-AUjrzgzQCCrQdQ2auATMJ5SPMMcymPu2az41giA8>
X-ME-Received: <xmr:PCLiakyjhNPeL7JJX3EA-v-FKpyK428LiQ4SiYNzoXnOQdy9xoe3yKYN-fK6AJjqL-X-I1aufADKhzNeloi_MiI3xeW8r1P8AjLv>
X-ME-Proxy-Cause: dmFkZTEbyuzDSXuv2YzoCIqrJikR96wi3UadC9x5kc0cdvsanzUYBOxdNEw7WOj4PwIXYo
    cqQrP4vy2f232tV/JZ/DdPVR1A/8XOS6weMCgawz0CtYJt450JWJG3w1qOAFT9fu8Ux2Sa
    7zofJoEj5zHPI2/8ocj9KyFg3ENQTapvKizAlxDiz9Ok6Pnz5Oljb1KJRtodH7c3upKAEO
    DRrVd2+iZTB+ORbOWWmjzuG7xoqVqQ4nl+pULVNtxtSORp5sEW+WtCnBt6OWsj1a7fab4J
    02Ra7rTuLaX+mWtQtF06eK72hELZ/cBf7vmL//hFna/T6D8Mc3wUL0OOjOmInT5BxbmMVb
    nLlMKzmR2bTbhGprMH0KPw/s1XCSfvRYD1M9Njhmyrn2hJHyRRcR+ZTi7K3MQz0QPhMQtx
    qF+BPk8eRE5zDo+EovVNn+r8Yy0LrZSptuQjffILBU/ExK157NNoqk9XfUqQq25BTv0knh
    /OexnfQn2U2Q5OHxTnc3vERC4SNRMLg5hjibMK4UNPiqggbLtV74caXCvE2sOBVx88KWqj
    BUNVO0Od/A/P1iFVK6l/JLs7T3+3Xg/1wUorl7CMFyPwI9zg4DzPjKMJ1NhjzI7zRhscEO
    wLjfh9tA4XX919TUq/2lRd/iZC+xNXsggwZxfKC/ru4e2V6+opEG0dctk8iw
X-ME-Proxy: <xmx:PCLiaiTtKCH4zEu5K0uCsxPrj80q4gnSBfAIs8vIt0YkVXx7y8PSvQ>
    <xmx:PCLias_e6eAq1sKvlV5KSkferD0fl1gWqH9noxF2nU62nNnM1-zgcw>
    <xmx:PCLiagvWTaspReWANTxkvtPcT1E5-kwKiiTS7Bspx3uye_5mTH-cHQ>
    <xmx:PCLiakNVWT2rXahG1Yvo6wK8ECsWaughQWYxD2SuIeurzpSq3KrSCQ>
    <xmx:PCLiaoBN9EKJzEQsSalE1Twx7QGLFXE9U8wguvEQ2imEOCczbSXxSN7d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:26:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Venkat Ragavan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Venkat Ragavan <mail2venkat21@gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
In-Reply-To: <auG5NTowgVZG9L2Q@pks.im> (Patrick Steinhardt's message of "Wed,
	28 Oct 2026 09:58:29 +0100")
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
	<xmqqzevyg4w7.fsf@gitster.g> <auG5NTowgVZG9L2Q@pks.im>
Date: Wed, 28 Oct 2026 09:26:34 -0700
Message-ID: <xmqqo6cdbxl1.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 27, 2026 at 03:22:48PM -0700, Junio C Hamano wrote:
>> "Venkat Ragavan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> > From: Venkat Ragavan S <mail2venkat21@gmail.com>
>> >
>> > When seeking through loose refs, cache_ref_iterator_seek() compares
>> > each directory component without its trailing slash. This can confuse
>> > a directory with a similarly named ref that sorts before it.
>> > ...
>> > Add regression tests for shared-prefix names, missing nested markers,
>> > and markers beyond the end of the ref listing, using loose, packed,
>> > and mixed refs.
>> >
>> > Signed-off-by: Venkat Ragavan S <mail2venkat21@gmail.com>
>> > ---
>> >     refs: fix loose-ref seeking across directory boundaries
>> 
>> I overlooked this topic, but re-reading the discussion, aside from a
>> test that confused a reader, it seems the topic was already ready to
>> go?
>> 
>> Any objections to the idea of making the topic ready for 'next'?
>
> Sorry, I lost track of this patch series, but I've reviewed it now.
> Overall this looks good, but I wonder whether this really should be
> split up into three patches because as far as I understand, this single
> patch solves three separate bugs at once.
>
> Patrick

Thanks.  Let's hear from the author, then.
