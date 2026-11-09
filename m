Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251636;
	b=Wzn4lsirptbMDygJrs5rIXrBSxCuvGZ/Y9Y62DHt8HvRhiWy7stobH4Xq2Xa0dDgPkhe
	 to6qa8cEkvh/R1gjXwKTbxJOEZQwCEso8uspXnynaN00oBTlVZZByk7lqU3ezCz/JGxgN
	 DlYLfAwUHyKbMifmKVgCruBmZqOfHhcd4h7MySbTiYdBrSgfC22pzm3EFgPKmhtmc3Nom
	 yWiadiJwXI/EzKw+HoTt/BFJhgJuTEHg2R3+UUEiioCgzOKwft9P3QjGgoIiaxoe9kdqc
	 zvUIlb8PUhbAA448WMwRA10mAHETIOgd/ZukqWgOozVGTdBOb4YquMFndxxsiTbZynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251636;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=u3U3Xkf0ArSgQX2h3W4/6Rl+xOmjUjSFkkdVzyEnzVU=;
	b=pvqL5hD4aKbN+RLzbnCWHjZG6qir1tq2JyaUtq3Oc947+UI+hr1WU3rB2Q8qulAUsYBp
	 8ZI6zKx5K0jpT/SmjAx6nLLKYZXI7FlaZVqnPx0HuRPqZ07wOocyIJBeE4AkH4e4a7zJa
	 SfFBu10G2qtn4oB5lf8HolbKYhLtHNf3X5ONFnKFU+Wva8sBoz7tB9+qj48kcAynVZoAv
	 AjjOXSG+FCubYX0cs1OHGjFvHzhyf+WeWvukUmoRSkZalEbfaIex/E039ZPlNG8DiPrBw
	 5KaHFFEIkn9C26mNTsUyp1vvIp4ScuTqlZtUsAlBHKtS+xxc5MSsSsOHTs/t4oEpTOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=F3eexq74;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pG8uSVHB;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F3606A330
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 120F3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=F3eexq74;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pG8uSVHB
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 225CFEC0123
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:13:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 09 Nov 2026 14:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794251635; x=1794338035; bh=u3U3Xkf0Ar
	SgQX2h3W4/6Rl+xOmjUjSFkkdVzyEnzVU=; b=F3eexq74vMumBmcs/AwaPmBbGb
	GjTOlJoMRFB/IYpdsM0P1LzOOAup12NnpjqG3wDpDvLRxPUxcu3rTApBdOOs5Cda
	olF07d/ucVz93HUffCxuOXiOmNfAcxbrXkMru3zPHi+e/EdQO6Fu5w8lqrNetREs
	ckpjFK2A+JR68jxu5Ma+UW0kYj5/ysBhTbRo8DqoDA+q3EAGe5Ml74flAOYkPT57
	dx+jww3Uj80wvY/ms+txEfuMb/8ICLbt8B/bRPpQgoZSpfz3nw3hqZ4NtvaHhrZk
	e0KAWzUwhxZaHngOgkbQ7FUHDkPrAqKtcVKdS1mQbzZUSjr9rMnhWLEYfBxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794251635; x=1794338035; bh=u3U3Xkf0ArSgQX2h3W4/6Rl+xOmjUjSFkkd
	VzyEnzVU=; b=pG8uSVHBGXor4VvBhr978z+vVVaGn3xbg1wURoNSO3o4/seb/55
	Zd+UeoDT7WOaTu3OHinC/BTHfUmmNsS0qckU9mNAm6OXE85kFlSk0QjMjO/rUpdc
	1X9Cd345prB2YoKsRosxqsXCsjU0Sc5KCRjGs7ORX0qeEUQAfuBss2ADXyqc5QT/
	v4GIcvkrarYDfHSOSfW/PoDgV1t+jjCP8tlPG5VCO/EIwLV+9iPzZmlRxsHtYLNm
	SV3/krson13MXf07/e5AjbUotgzLSKpX17cK61Hj87+lZYfEgqRVeN6rUoj/GcLj
	fsO50PjNzKN0CW0we9fJtYKG6ahZ46EExKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794251635; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GpSmWWzqVQsLbXAbPZSPOLr3W4TF5j5GlzexDSIuRc/hnEf
	qRHrf05zZPqdXCBiPV4nJX9RTgz890uZGUON8Pz5I1pEvk7hT8jWcnlvmW+JLGiy
	K0er3PqNxDdPJ7bbpbupPCmeyGX50CtxUvrqHxOQFxJ169b01ogKqI5JA18L3eOr
	mzBNJ9av6GqjTnGUZL/GH10KrpzsP3LCOH96UNpJaBdjYfxYADtL4oJg9pq535Si
	iKvEjQ2rfhcfsDA0qC7jZaysbTNfa0W1r7SISvQzd91KTQt116P3n/7R4ADdgDOR
	WPO8F9VlfTa5JNoIK+Oj7zFznw0F0pYdNlzBwhg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EN/cM0K+hiByae60sOGgV1kZCQhPhtbhnBnFv9SSux8=:bPlNc1RYlPkGDaKh6kMNo7wCiWdUKUp8GtiR3AwQWwI=;
X-ME-Sender: <xms:chvyaq8f3Pj94cW2ANzPxW12_3EiEZ833EBeNtmSpM0hG9AZwarkWQ>
    <xme:chvyahmescwOTexX0bNi1XJZ8MYc1Iydponxqmk8WZd8bWpe1Q0Dl_RgHDfSisvU_
    piGDibQwwq74FUua1hmET0MyujGizc7ZzpGbQH9Zg-rtm2hxBgCURU>
X-ME-Received: <xmr:chvyaoVZycu1w5j5Oh8rS_rsuUdnIiU6nAdjeHzPfzyWcbQOiwWhmwapZhlRBpuhTKJjU0lc5Y9rrtxiIzUtMsCGzOV1paUXLDiL>
X-ME-Proxy-Cause: dmFkZTGmqL24Gy2iNeksnGyGJgT3yU697/SlpMAWdyCPC1jVXPR4ORE/EFJOMC34ljIxE2
    mBOBYJ9nDyaA1ZYnAuW01IBwJ9ocP2QPBcQ671XmkrTcMoj4+3ul7EOijRqyIc4uLz5UIW
    noUpBMjjoyiLURzppnF2ILmXsuOKN2dXSGxHrQgS7Yrdkb+V3bgweWi1cWajHli4Yx+EAs
    vUsQnXz4jygsw23XtLH8c/smqsHLdOOtkScN7r9LjpFamj8aa8smqvq52WxvDnH6pknisx
    lMVbFRouOfCQg3OQ/yOdZYf5h+SZpkg3SUu5fOF+sC/COoPGfcv4ou6nSwJYl8iWA1ZYt6
    1iCbNWusxge4RS5a7ajv8H9+A3SwTXlw1QueWFBGlsSnAK+OHuwOWBjCHT+T+fhXme+mIY
    Irbz6vrXZhWXc+aOIwkeCrrdIA6nU+EiChb9Q5QwAtQNj8C/gaBPGuYFoMRYUMwcW3IrZ7
    hvn9DAgWbqgcByJOi0wULh7lWOEVupFb6JdylqGNBJ2FzMiWCTjs1WjAYPbtSn2c2BI1zw
    GQtqsBKVPumTp1ms7Ia2DLtgNhdu6sckvDQ+sa13Bb9GbiMq9fjcLJ8FzYiqoOKPRKxLkg
    839+xeL4cKx5JXl8FcXA2vGr2bOdGj4wTRyv08P61Aa4X9E7pA1ddfOEgTiw
X-ME-Proxy: <xmx:chvyauHFZQ1lJ-k_To4gW0h9vSWXNYVeGwvoTPOGCODtR6RY4n4pPg>
    <xmx:chvyascjn-IDcTBX7fhACJZZXAXSIKNEWR66qnXItfQvbozmp88O0w>
    <xmx:chvyanJfVwkYEbuYHwdpUPJXTkHpBFCBehAGVAEzbKOx58fU2R61Bw>
    <xmx:chvyapFXRanb-WHS4ZLe2bFhrOZCfSTX6_swCAJbl6SmsktL2koigA>
    <xmx:cxvyalXrwMLO5JRxU1DlDb8943IybEI9aSuI59crBHIGFW3-6vcJ3bcq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 14:13:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 02/12] rerere: convert flags into an enum
In-Reply-To: <xmqqld7210a2.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Nov 2026 07:40:05 -0800")
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
	<20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
	<xmqqqzgxlxrq.fsf@gitster.g> <avFxCywngxJgwylf@pks.im>
	<xmqqld7210a2.fsf@gitster.g>
Date: Mon, 09 Nov 2026 11:13:53 -0800
Message-ID: <xmqqik25zuku.fsf@gitster.g>
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

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> What BOTH versions lack is an explanation why RERERE_NOAUTOUPDATE is
>>> needed in the first place.  In other words, "How is it different
>>> from the lack of RERERE_AUTOUPDATE bit?" is not answered here.  And
>>> I think that is a lot more important thing to clarify.
>>
>> Heh, in this case _I_ thought that it's implicitly clear from the
>> comment of `RERERE_AUTOUPDATE`: it overrides "rerere.autoUpdate". I
>> figured that updating these comments would cause some discussions, and
>> that's exactly why I didn't dare to update them at all in v1 :)
>
> ;-)

The command line can give us not two (which could be represented
with a single bit) but three choices, (0) the command line has no
preference on --[no-]autoupdate and follow the configured default,
(1) --autoupdate, or (2) --no-autoupdate, and that is exactly why we
have these two independent-looking bits.

But two bits can express another combination (i.e., both bits on),
which probably is invalid.  The underlying OPT_UYN() calls
parse_opt_tertiary() which only chooses between 1 and 2 so we should
be safe on the setting side, but I offhand do not remember if we
detect when both bits are on and BUG() out where we consume the
value.

Thanks.

