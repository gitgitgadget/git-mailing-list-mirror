Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637266;
	b=guWHWBQKlgb8vfJ1lyh0d2CU1GEZ6BGs1FrVjGEBiuIdIMn/4aeEUsZnQmoUUk1pXgnz
	 doCtFdSgDVVf+P3pATzBwdVIYB7i4OX+O8nF0I/1URrC2II7KGs2VRCYQM2upkaYL6qkw
	 HGYCbPL9sWFQddk+YlvK4dZlY0NbVi/A/rRxRrk+kKdo2uyAf3my5pl6COM1ewHkshA7q
	 /uECeRgZ/q6R2Yvq/8KfxjlZNDWh3AEKLo4BHEUkgN/kJ8yRMq8/1FtSUmYFfPOjc91Z2
	 4yZCnayiL89SzzpnXyUvQCXLdU2PpvvU73EprD9Wx19EwgqUK/6InauApofMufzu8vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uOUu8nW4SWTNfW156wWGOQUBMFYPeI90XJX1yJDisH4=;
	b=gx1q/HKLzdLeyKh6GAaxOc12/ZJC+Yxc53hWJyxXJpQ03FTfU5xMd1NgVEzbVgGBiTTj
	 vuoHC1MqKV+nesi2lLkVqOjV6sIRacfCn4YUSW16rxSgqeAlEevu147giIzusYOCVPSKs
	 TphYlB44TEy/F2V7K3warG1CAwbdG95VMDNaplEFodh73KCeEE0wtZR9qOuTn+mxjkBNe
	 MB28te4LE5DX+0DUIFuLJQKEIPH/e6xzasGkCLuN8Vjfk/hOjIXWjCj4s6H+OStwU6Z70
	 ULHjn2jO26PJ88W6/u/P1It9ppw6q+359r7HLJQLv+Y8aTz431CZP9ul+I8OT1zo3+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVxIj8tz;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA4608B07D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83AA4608B07D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVxIj8tz
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b042c0728so750716f8f.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637265; x=1794242065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOUu8nW4SWTNfW156wWGOQUBMFYPeI90XJX1yJDisH4=;
        b=HVxIj8tz0clFj8L8hjV5+UdGH0uzFsv5l8XFKvGC0FdVgcIBBzbKxsPgJD/woVGD16
         YNFRvltpXO3tMkCi8WhAKRQEYPME9wZOL2eZWhlQJbqqQ6PpUzP+TSY2mqspjW9yOIsC
         QO3ewmuamHbvt/077nqC3i38ennD7YlBiy6c/uwwXfywX/qpapJ/MpkWS9DPIY9q/2NG
         qcvbUiHHueuItXUeT+vrXD0HXOOBcOLbVDsFvjMriuHfvSWwu7ve3YOH/g/qacYu3ch+
         ZpnIBZRW7EyjcgDNUQLnJtv866lT4P3hdDQOJTwua4Bm41apDnQqpupIK/2DESdyNpOW
         vqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637265; x=1794242065;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOUu8nW4SWTNfW156wWGOQUBMFYPeI90XJX1yJDisH4=;
        b=0izFLxLx5+8uE1Xiby/KpqbVvdwyMKJ499hmjN3cxd+Osh5MF5lOY9hcLGMDEbsJp3
         rD3XsKryA40NQTRxMWwNnLiJH4fVlHJ29rhdKeI2A385I7iX5WUhINdCLs1doIJHmD6v
         IqglTRpTtIufYqV7QPDFr9P+WkjBFRxf6vqBkZsuZV2Rm4BKxCK74xEwyHF9fqUM9X+O
         GB+cbbdDMvKyBp6GDxssTv+eNNUUi8Ll4RuuEe9ZzVwFsCq6J1pPtpq+9kW4kf9LUtmO
         vtbgM9PHWrqGiuEmMoUj6U3H7QiIYtx/iDtbMs3ngOmfhyTsaAcLBoM/eppJrRpMP1fd
         71vg==
X-Gm-Message-State: APuU4Z/5iJ549YfcbhtnZ7tjupSMe163hBDACgJ9BZOFzz7VfAZ/sU1u
	QSrs5cO88koEHwNgKXdr2TDJkMSlpnlnPwp3aAgPG9lBtA4YCq4zyfC2TyGysQ==
X-Gm-Gg: AYBFou26dmKQOMdXmDdicizJ7V2/bLOHkhtyjOIm9kvEHEZ8QLG4Oplo/UihmM2mPEW
	mWiWGXENbq3nTrGT41bm3PECGGdToKqWoLlqgxcZxFZ/Y5NL6pvXk7PV3m2B7ZzDqJM48+NNsg+
	Z1/X5O6m6oAgeBu51I0McHbMN3X0qcjW2+Qq7waWCWX9oyq2m1nm6veQPj72W8kqhUml/vgVg0E
	EhZuHSxCzNfNODVi00NN1zCEv75TTfRtTWTGTjzYDE5tGfzN7b1ejLWzGa7zUPUqOY906eINM5I
	OlA+1x8dMrOYmXztslsPdge8a6sHJMnRiYKGT3b1z5AmlnS1vE4HgiE0z2+kNMeojvIfqNtz5kc
	cbG3yjHA4OdQBMzzsbwvq3p7lHnY2iQ8kh2RD1xbfJAErdGzBHrkq0aCj9F7R/JSto9KVVlekO0
	H/f9czsbxrASgrmRGJqCXQ7dgK5rABW2KfUynrzVWdTokU+mYQUh/FyI9runFGTJ2APERSIq2D4
	kAVFY64mWXAlyheXB3/C3xyaUMxR/iKa9W/gNNQgmIx3KCpmZCh6VtsnFJ53Yz3DwU+EU/Dsc7D
	IxP9HfmD6/b/rHmzVlOnH/ZcRg8ZxSMa3r5PxVTaSNxX8pGR5hO4cOpSK7qjPddHYxlJxeqNccx
	lYzRLj0YjMD7G6a/1r2Js/3kc60w=
X-Received: by 2002:a05:6000:2089:b0:48c:4f6f:62e3 with SMTP id ffacd0b85a97d-48e6e2eb736mr21919165f8f.18.1793637264858;
        Mon, 02 Nov 2026 08:34:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm20683960f8f.23.2026.11.02.08.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:34:24 -0800 (PST)
Message-ID: <48a6c039-75b6-4fa4-a18e-ea3240037be9@gmail.com>
Date: Mon, 2 Nov 2026 16:34:23 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Ejecting things more aggressively out of 'seen'?
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com> <xmqq1pclc210.fsf@gitster.g>
 <414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com> <xmqqbjbpptzr.fsf@gitster.g>
 <47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com> <xmqq1p93ofjx.fsf@gitster.g>
 <auhfD1ryB-7JwOYl@pks.im> <xmqqv76fjjhg.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv76fjjhg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/11/2026 16:17, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> One state that confuses newcomers quite often is "Will merge to 'next'?"
>> with a question mark at the end. If we were to document these we shuld
>> probably also document that state.
> 
> Hmph, really?  Just like the subject of this e-mail message, a
> trailing question mark is my way of saying "I am planning to do
> this, but if you think it is a bad idea, please stop me with an
> explanation why I shouldn't".

The subject of this message feels more like a question, whereas it 
sounds like "Will merge to next?" means "I'm going to do that unless 
someone stops me" rather than "do others think this is ready for next?"

>>>   - A topic goes into the "Waiting for response" state once reviewed,
>>>     where it remains until the author responds.  After staying in
>>>     this state for a month or so, it is demoted to the "Stalled"
>>>     state, and eventually dropped.
>>>
>>> We should probably have a rule that says "a topic that did not get
>>> reviewed for N weeks is ejected from 'seen'".
>>
>> I think that's reasonable. Becoming a bit more aggressive there doesn't
>> make too much of a difference anyway -- if a topic gets evicted from
>> "seen" and then later on regains interest then it can still be included
>> into "seen" again.

Indeed

>> By gut feeling I'd use the same rule as for "Waiting for response".

Perhaps making it clear that when a topic is ejected it can be re-added 
if there is renewed interest in it would lessen any worry about 
demotivating contributors?

Thanks

Phillip

> An obvious alternative is to queue only topics for which I can, by
> judging reviews on the list, at least say "Will merge to 'next'?"
> with enough confidence.  It would reduce the size of 'seen' and the
> friction felt by contributors when their topic is once queued on
> 'seen' and later ejected unceremoniously through no fault of their
> own, other than their topic being forgettable or uninspiring to
> others.
> 
> I do not know which one is better: educating contributors that their
> topics being uninspiring to others is something they should not feel
> bad about and giving our reviewers easier access to these candidate
> topics, or being strict and mechanical and queuing only topics that
> some human reviewers with a certain level of reputation have looked
> at and have not just shown interest in, but have said are ready.
> 
> I can do either.  It is less emotional stress for me to do the
> latter.  Between hitting 'seen' and then later being discarded, and
> not getting any response or reaction at all, I am not sure which one
> our contributors find more acceptable.

