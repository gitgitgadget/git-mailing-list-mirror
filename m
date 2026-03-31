Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E215346AD7
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995339; cv=none; b=RVkqVgjgNumpsbXmfVdZOxRaJFzKweLROYx3i038V7LQblAXTYEeMHbg055Z9Yq7bc2hv3BF1KbBJa6blDnYMcrOQjfbsJuxb0hvQAiAm6truPec49ZnN8B0EjJGJgGKc9zZfVP0ndJbLgZs5+kVFHwhOshmzPRXCo8oNV6uiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995339; c=relaxed/simple;
	bh=80CDVtc5SJAVE0YcWIXa19dszb1VZ3HMK3QKYsvcIqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvtmD2KSL2Ounj+1VapIisaqheXdULYfriolDglklLHnj/PQ5jzQ6hPsfMzGkyJg9TzTMFeggTUPtosYFYVcHj9J9CWiaDCabAHWoxn+REH4yl6LOeM0NUoH1zqkP0lusVbv0G1+URr6/yeryox78nJ7D8hpxHSnOJmmyFIDRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VnmbqhPP; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VnmbqhPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774995333; x=1775600133; i=l.s.r@web.de;
	bh=iTpXi0VuLrIhFDutdwuHpVCR4zPwbP3VrwYXc704qj8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VnmbqhPPftt7Ti1gERukgoELqyndNbipJsBAPSiaiEGjz3sYZGbAlXSW7jQUAiGi
	 QplVmOSppFZduDMyDBYx3+iO8LEDGgS5isxo1tinbesZ1KD7o8vX4I8YrNEhyZ5a9
	 zi05nmMuSyIU/FYC80AxcPlBlfrI+vCe/EmLXq129zw76KdUsh21ZwFb0+35cBFKj
	 l4P4GT7P4wp2otAcHG6M+jQ1Eih+tpatQg2IJNr+1yBPmsZX+J2GArmiWTEDMFBUi
	 3b/ZCMQOKIgder+KGpbeyi66rdfyoej8h4cVhvnf8ax3FHT3ghx06dATka9rMLNso
	 gSmvddOmBv8Dq72euQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1vvZNZ0BDQ-00XgZU; Wed, 01
 Apr 2026 00:15:33 +0200
Message-ID: <b19785af-c8cf-4fdd-a44f-d4e8a0f754d5@web.de>
Date: Wed, 1 Apr 2026 00:15:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
 <054e69e8-3dab-4321-b68c-a48d43dc052f@web.de> <xmqqpl4jy9p0.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqpl4jy9p0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XpFXHG9cEO3QSQJdAgbx7FlJ0xGq86SqyYo/NGlZKEHwy2VnXH8
 vYb7twHqMMXQemJy1atYYdVr24J7nrqpkRIUp2930rw2Qy/1RbXmLXSHNyVHD+Rae8KJbGE
 sd7G160d7piLdLBK5nmtCIMrxG+YyqU4Dvc2m92Osl6xEB45wD4/szSZWdOKCeCTBw2PD1d
 U4LP5uPiwldLSReyOiQQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:omAaxMNb2MA=;JIZLUvXesFACOZnI1Da+x0vXMnT
 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

On 3/31/26 11:23 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> On 3/31/26 1:26 PM, Patrick Steinhardt wrote:
>>> Not every compiler knows about the `inline` annotation for functions.
>>> Consequently, Git knows to define `inline` as an empty macro in case
>>> it's not available.
>>
>> Does it?  Only in compat/regex/regex_internal.h, which does not leak
>> to other code, no?
>=20
> As we also do=20
>=20
> ifneq (,$(INLINE))
>         BASIC_CFLAGS +=3D -Dinline=3D$(INLINE)
> endif
>=20
> in the Makefile so we cannot tell what people do with their
> config.mak ;-).

Ah, missed that.

So setting INLINE to an empty string does nothing.  We do that for an
ancient versions of HP-UX in config.mak.uname.

When I set it to '', like we do in config.mak.uname for an ancient
version of AIX, I get lots of warnings about unused functions and
linking errors due to duplicate symbols.  I can only hope that the
pre-C99 compilers targeted by this measure can better deal with that
issue somehow.

> And obviously other projects do not share our Makefile, so it is not
> too much of stretch to say Git "knows to define", even though it may
> be more precise to say "knows to let users redefine", perhaps?

Fair enough.

Ren=C3=A9

