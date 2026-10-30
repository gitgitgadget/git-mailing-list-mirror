Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400711;
	b=5Zwn1iuPzzQrgnB6EQhi5bNVsGq2WlXQMD1YMJPwA5G6vnUUqeZP0ixqsNPZ673NOIT3
	 9VkxWCUpfHyQQjv6DMTKBeOr+NyXc6oHLuASlHHm2LVcac7Yxl3rzVg3Wb7PwQUJwhnxI
	 +48/n4S5+vzdEYmAGfbc7VauOg1sZd5rfJ6fWaawc9vWOtgztLQ8mzT3U7hKnWRdfmgat
	 99Iyg2je29QLK58TpG5oCyOd0YYvQ0uCFyblESik+c/tkxbpuHdp3phOfPaWf+dDrXkJN
	 elcJugAlnKq+tGhdtkV072Pi7+bZIGEpoiDo2FU7FM9dvc3Vllmjng0oVzq+jbXtEFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400711;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3XA8s6arxMqtTE6HMBVqM77V92d1/qm3JbA/Xfm0IAo=;
	b=Y1BMDrm6V74gA+mohewHhRY228GdAkrq3JgL2YV8Sru1ijR2SuEsRdHveiB87D40UaE5
	 88gsE7MfIgHTBXUaaAJK4u9+eOMHJDlWf0wN9IAXWod6Jv2FFynS2AAOAE3ldGM1mNDOV
	 pszf3ZmkfiAUdZ/E7ybgrROi7ny54TCMx/GUDJUT8pbkK9zCinSsgjhAvFq0DIsvXXUCs
	 KbspiTIWEPCQc+4xtTHMUjToSFU6aI/k1RJ3XvkdUPvyJ15wM4jqunjoP7Up9HpJRUsPD
	 1i0nQM3AiR/S8eNA4UD2UNQRTCG9D0bvgyF6bo5u/LIc/QBMMXSwMP0C8a9X5S64/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Nb3v07c2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fQWkjBj9;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053E606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E053E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Nb3v07c2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fQWkjBj9
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2123BEC012C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:51:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 18:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793400710; x=1793487110; bh=3XA8s6arxM
	qtTE6HMBVqM77V92d1/qm3JbA/Xfm0IAo=; b=Nb3v07c2UOSfXJqV27jsAZBCYQ
	qasYHXQ9Sc4ztIbDQficQ8FP07imX3c6YcVYQn63NfMURD4LEaWvleXNAgOlhAZm
	m3MJwBjPim/qM/vpEzRRTMux7bDOXy0RhfQwDgKyLKqZFRIV7sOyBbtpII/M7sLC
	WlCYIusm7HTwY3WziQp+7gPATOO59Axo/T6ZFnd7L8M1rcVvw/RQVVjj2JYXWKTl
	hqtSIDx84GuSMwmwPkJiLOQHN3AEPp8NOjYyHALOILOFZcLMBlYTALxA1y9C9KDG
	//KvDfTigxKRaK1kjCFX8XZfc+RKVrzHDUxokxaSLYCFSgpIeG8IjUXnBLYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793400710; x=1793487110; bh=3XA8s6arxMqtTE6HMBVqM77V92d1/qm3JbA
	/Xfm0IAo=; b=fQWkjBj9Matri7s9Mh2cJbBuJXUpsDuckQSAMabr3TI2MI1QaBV
	CeKKozklR6zEZbVWMRcfF5ZcRYLmGOUXff2MFir8gmzi744AL0ryrfSe4TyG2xli
	9zmVxhN5dtAeZdRVZOTAX1vMQ+/PPR+rPmbLf1V90fp34aR0bvYEysEFVkMhLxfL
	IAIvR24bvXhjqLPLwz49r5GWWsQ9CdqcabNw/vLRA6vWWIyy29PT0DV0JJAh/Y7J
	0xMHatPVf5vkh/0HIb5d0hewMfZ4er0teKfjjcOq0+sQGWjddQKdx99RUVnc3hFK
	Esvy9GmJraqMyCTwkVbZNEDvV0wtt/wnFDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793400710; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aDNXmvD+Cuw/WmxlRKah8dCApoa99g3ZDC6698pg3mHD8Ln
	pz1KDfiY+ssWFf7uT0dazCcF2IylXtchKern4F4gU6IBhcbW5ClWI6VwRuoGxAbW
	VUQb1hrIkkxfgT12HsgMJO/hvMU2PlVrVEh7M1okGXBv14zMnMTHiKLBdwY8BpBj
	SV4qtn+UGB+fPNxn6HpHhl7tIEJVtmg46Vbvoc5/v2L8Cg9ALt1M2YaDvX8888oA
	OCnecqvCRKPvs6Vk+aKbi84OJreArBvAgg9UDXNpreugJ+Elsx7iB96Zmsd16gFN
	YpT50DJ0rxZAWxlOlubvvmE+FPKECr0NIQRmWTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4QtthrPvSAWMTASld+oNNnyTA+m7MVSyByhqN7sKdJk=:/YDckQAc3rHPvt2kplF5bVylEmoWPXY2Dn5HYvzIFPI=;
X-ME-Sender: <xms:hR_lakA7KBIjf7OtuPj_ZS1c7kwo7ppwAr6bDwlxCZLQZ3Wnmb60CA>
    <xme:hR_latagiRrYs3-d9DlB6RNwEcKZc_6HGYKGFCX1yxBfU40T1JlHiw3BkpgGbWwiW
    uMyfZ6ycNj7ySCHWuzl4qFmk4fXDc4nHXHTsQFNPpmYAHkC1EPk5Q>
X-ME-Received: <xmr:hR_lav5RdG-AV_JZUyVLZU3TWaERezrrklBqdXbBsGKLQHraeIjL9N9MTQkdacAK5Hv1OXNrWBALiIi54aWzSzpD1e2MY4z0wNz8>
X-ME-Proxy-Cause: dmFkZTE+R8ChwnOYkUOXziUWT/XA9ocqVaUNSB1smDkKCpOpF86c5E24SYwib/4y4ajYRf
    7+7XFe5rYTTaxFakDZbbBlA9lb0gCdHSgGnalrk4PWU0YZuqI+eUqZE+MlU9MHYOnXvoN4
    Nwwnom9ursRrl+d6PTWiNa6gyCcjMLjPZS+nC2HU6c9qW+dtoTSVYD64Hc73XmXu1unG3H
    2LmtpyI1N/P0Lb8w5/ABMZ/XGiq3YXcrzTksBgS28tn/z2xnVXOxTCuyLp4BpgRNSWdeGG
    S2r3kQhQJr4lAqGF6LB3/Bf8GC3un0+yoDINKd2LxxFhbultUjai7dlXIbiLscC5pggTg1
    fpJxM3M1S8DPTlkGSyrDpNU901GZmu2/iyLOyURkJIMJEzTWf38MpdJxGUJzTTZv+vgAo7
    DtMp9pDdrIroqYqUX+KzKK/PTTwf/boY/JH7EkqOVfFIdCpVZGItMBRoUCKeajIy8pj2pn
    3pD9Ud8Q+E/k4Zcl52eIYmKAhWpmKS7riM7mNJWZlq53ahMzKCZeAQP9/0oVbk9MKWHZOv
    G687a94j1RjBtfnQqA1IPgJDGj/6m47GsEUM5hOzZMspofYiqM61rHdX7Zge2jPKbt5g9E
    0ckOgOugBIzo3KV86BVK6TIuOqTlUYJLX8Z6JpwZvWEGJHccJfToyZU+NcLQ
X-ME-Proxy: <xmx:hh_lamZH-lUm0upe4VjBuKlItlt1YfS9N1flXshbKwD36loQENYvvA>
    <xmx:hh_lamjH0_IBvc1peF__Wqjt_D7ft9tVDCsZRv6I0xrafsiTPy5LcQ>
    <xmx:hh_lav-wL7HUmO6gNHGfG1iur7FLuN-TsISeFxkfYbsQXDMK5JuKGQ>
    <xmx:hh_lapq-oO3Cr5kU-8Qqr24Mi22MLaubug6nNWfbqfm0G_pJ8xFJUQ>
    <xmx:hh_lahqlz4Ibpj_aw8Fgks69xDYp7y46bAdIdNYWuX8DjLXi_jNFHJkl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 18:51:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/4] imap-send: accept messages with Subject before Date
In-Reply-To: <ad3158b3367d00fb78d2fa5a55b82d5f634c3d61.1793089879.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 27 Oct 2026
	08:31:17 +0000")
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
	<ad3158b3367d00fb78d2fa5a55b82d5f634c3d61.1793089879.git.gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 15:51:48 -0700
Message-ID: <xmqqqzh6u7i3.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static bool has_required_headers(const char *line)
> +{
> +	bool from = false, date = false, subject = false;
> +
> +	while ((line = strchr(line, '\n')) && *++line != '\n') {
> +		if (starts_with(line, "From: "))
> +			from = true;
> +		else if (starts_with(line, "Date: "))
> +			date = true;
> +		else if (starts_with(line, "Subject: "))
> +			subject = true;
> +	}
> +	return from && date && subject;
> +}

The above assumes that an empty line that denotes the end of the
header can be detected by looking for '\n\n' in the line[].  So this
may be scanning thru to the end of the message including the body,
because each and every line ends with CRLF and there is no two
consecutive LF appearing in the line.

I admit that it was eons ago I read RFCs on IMAP (like RFC 2060),
but I recall that its definition explicitly called for CRLF line
endings, and existing code in imap-send.c before these patches seems
to expect that it is reading CRLF delimited lines.

I didn't look at other parts of the series, but this one stood out.

