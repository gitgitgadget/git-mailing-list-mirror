Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688477;
	b=v6REWzPa/Q0e1Jsw+qYwexOWajlJtKeEMw/fDF0KpgMR5hgNncDRqdHHeLsy/r1iMIYg
	 DEP+pdS8PUQoGjdnJm1y1GMtLdIVLZ+NmR4s0hVIrFO3ic9G1sSSWpU3Nqvs9XITDOqzA
	 HFMaMMa5N3YkVxb8WHK9BWMHdN9Cf7VHXC337X6iew6OyDRj1mwav6lU06SfJZYezAKVQ
	 wrrKfzTjUTe4XnU27OXFI8Slg+GYTkGxO0UZ8CS3FsBEApwxCY0+/UitS+Hnbk7/yRDh9
	 FN+alu2M1qg58+Sx56t03bBpKOHLV4MzL93XH4+8aHAjBa16Tnpftd+rKat7rzjYGxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688477;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Ej+hlV25vQhfgruNXgOChCb9kpK/GX3h8Aeof4IaPh0=;
	b=UGK8MgpTPQ5cAVg/h0q3Y7mJGeh9fWLqYvJBkGoavnGEGYwY8tAt6AZS+xggncEqKFxd
	 DyTMvagWCQoS5dAU2tyWuDVzB30LVN5/Y0f14rGACCSp507K0bhHxK7uBoqms19/ZDs8r
	 9N6yHmaWtlFjp8Uck7pb6d52xrgfygQKpRtWlRNWe9F1PdceG/76EnHYBgCtIITxEpMwi
	 izUkVe6izhpWcNACD7Z4zL5nIo5CGs2aqYU2Kedkjd3/BF6x0BbTIqg5Keg/z7K4i16GE
	 dwxsN0JfV3j3ho7tvDM06zEn/hW3uQaT2gPO411d4puB9axzS5ARKIHBuNi04bkXDGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gD0ENzan;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UDw7AY1z;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFF606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BFF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gD0ENzan;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UDw7AY1z
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 852011D00166
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:01:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 13:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792688476; x=1792774876; bh=Ej+hlV25vQ
	hfgruNXgOChCb9kpK/GX3h8Aeof4IaPh0=; b=gD0ENzanKRjwMJXmtRV8yBLmyn
	EUtskiLNAzlcnBp+zb2uo2GukTnO5rA30TENFzHIF0mxI4js+SD4/Bi22St7tDY7
	VQIryJuWgJdtJk/vbOWKRNcjdoMuMzvYiA3zXwSPz2VsfVKNgmYKXg5y7PGD+sFr
	PQt6QVfRfcVhlje7jSQE+0aaDtuVMTE2odnYh0BbaJRxxQSsfa2f8aaUyZX4qKHt
	IW135yaYg0BZXr8d59EkXA1xNoAz7T7FzIisO5s1mrbEFzpVesUVunAf/XYSRb7g
	v5EnaPyyqe7auU/1ZSBfhJwUGnVm734Pr32DqEzQXJ/I4zECNzRYhbbTD4dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792688476; x=1792774876; bh=Ej+hlV25vQhfgruNXgOChCb9kpK/GX3h8Ae
	of4IaPh0=; b=UDw7AY1zyVgkB3XoGXpHVnh9bi0AaeMdn93FBHeJLSmG0eCq6+d
	pkmpk7KXB2P+Vmyl3eO/bYixeZiRZoVEUhiRw/f5nuwyC5GuFJXmu6vwn38OdPQR
	3RnWdKP+R3B+2O7zNZG2e1BGkYMMSn3AnisB7qDX/aVVxgX0O0aZUAq3y3cjebAk
	UfdgJuL7G2wnWf+Wgrx8S29KDMW0hZ0vwiawDKQ/L55qwbHglHjRnizaTmucsyMz
	5tZk5zyveC2Oqew0/p+jHyRztLvTiQMgh1xW+yxbO4oJv/zxo3X+NyOT+ooMj8Gr
	oR+AiCJulS+bP9u53R2mSDim7/rcn2LQrUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792688476; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:V4tZ0vJgRbW/k/Xn4tNkhRqlQGLDWA3D4ezHmKyvmqgSUb5
	1lrEW+5k2cT7S+NxEF9uc3/A3wT8NRpmMl6k/YGcZWfeUjlrlpRc0UJrJO4xfi5L
	bN5T0GRya12U6ONXvkc9Y8Eb4UgREBXwhvq7nty6JA2yzJqb3PjCn/1uO7LmsKDL
	2/FoWWCZnm4bxGmFmGYwr41/2Ck4RzqmEF+UceKmtPdiCZ4vpCZt89KfV7PEpnpk
	3RcSWT9znWYY37FvWojTqzAYubzJ8mZCAY0IE4PfuCGecriGPtefE2EqqZx2LifD
	hKJXCfJozFrIrhBP2Mmg8bOCGWQWHafAIQpkSmg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YQLdRVK5wDVby6VGMiGZA9MEpDS/ai+WULtBLWb0B80=:BaCXp5J24ucLv24OTia/DUDljdEpkLrcaK5WD/9bbz0=;
X-ME-Sender: <xms:XEHaagpvM4QvRKu23e3h0tO-Wg78wO4yZfYmFGPHHnnqF0qozPyyEg>
    <xme:XEHaatoDEOxiUB2Tt7NbH2oSSb9rt_DHHXceV_wOhs9M-Sfecd2t5n0LlGmmKMfxL
    eHYo5KQ4EOCxqu_IL8AX5VOTfBBqZQGZFMjOU0S-DCbJLTpdT3QFLcl>
X-ME-Received: <xmr:XEHaaqONKe1QQE7Io7NRQctEM9gdPED48wqLBqJkiM9KmdKfOkFhDxrPyy1zwuE0e7Uc1zrYz1v5KOOVc9XZxykOht28Hu6JkIwL>
X-ME-Proxy-Cause: dmFkZTGEd0QqGDiu5fKr41RqcPEhJRWMnWpzLCtmGUXlXIDhS09SsJ0IFuwhar08BMirQl
    xBMA+EEsx8NQcneImgtC9Y8xMBCowrie0tpUZYuZnn29C36EOAX4zptD7k/ZDnzW6ZUvTr
    pawC1u1EzQbl7d+qolzYhWOi+YT50/yyEeSG5lJA56+Kq1CwFf19AaTYV1lMt3wBBgAwfy
    l1YWzaJV7Q+PxlGUPODKYWJ/RdGGrxX0zAqIsosC932pxn5xAiTUqd33lAX8uDZoM7WKYT
    eZCyBSYQ0xRoooqaQhK5Qnwm2VitWBlEEMBYmQx2RbyJRHF2R06gQC6ElfjVE5hcs4goWn
    kHxmzqt57LDP3/+wbE5+VQ6rUrnNrXLlUmeP54YWOAdeyfrDeib80sjoAnECLi1KEXyJpU
    dbpKhDlwpxVPosdBWpUMFg2uQZ/8A3dsSpzz/GZ7Qp/bD4OFUiSWA54hyriQuVzy2od6Jk
    O/w97SgSM191G6+Vm4GXEJ1rMNvgK/a2JVBttMqxQ0RNx1lVr6xRZNpnVpVWNOymiqWzLO
    h1jhu1F0DO3hZhXcdz49zAeu5w/A6Xw2C3xKSofWaaTFrYqlYEspPRT3uB2QNBFZA4ZlYE
    d/rMhYrqrXqjOwffhHQSBd6bzQc6TBnv+MDKEEDf8sLUOb5yQEE26zRccf7Q
X-ME-Proxy: <xmx:XEHaamzOVRWn1jhipjCa11blwEbF-63-Shv-Hla3tl2s0C26CpHx0A>
    <xmx:XEHaarshz80RoxwO4Fyw_ZOBCtgqKhDIWU15k9MeTrzEDdCETMrPEg>
    <xmx:XEHaan6seUqTSnA-i6pho7J1gZAgXYgRkMuzYyIAXAeAfjnjcpzQrg>
    <xmx:XEHaaiS52tZvWVMHtg3HUDUxzm24mJ6K55C4wSyoMgansn-696XfTw>
    <xmx:XEHaaktGurRhRlwGsyEvBKroAk-aE8i2Bxm-kIn3ylysM6f7V4rBFW1a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 13:01:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v3 1/7] stash: use an enum for create status
In-Reply-To: <7ffce2cb-07de-4bd3-a9b4-81fd27b920f5@gmail.com> (Phillip Wood's
	message of "Thu, 22 Oct 2026 16:57:32 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792509606.git.phillip.wood@dunelm.org.uk>
	<9e27bcd676ee763ed499fb337b1497f3fe2405b2.1792509606.git.phillip.wood@dunelm.org.uk>
	<xmqq5wyvsi2j.fsf@gitster.g>
	<7ffce2cb-07de-4bd3-a9b4-81fd27b920f5@gmail.com>
Date: Thu, 22 Oct 2026 10:01:14 -0700
Message-ID: <xmqqpkx1hdph.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/10/2026 07:07, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> +enum create_result {
>>> +	CREATE_ERROR = -1,
>>> +	CREATE_SUCCESS,
>>> +	/* No changes were stashed */
>>> +	CREATE_EMPTY,
>>> +};
>> 
>> SUCCESS immediatly following ERROR that is explicitly defined to be
>> (-1) may qualify as explicitly defined to be 0, but personally I
>> probably prefer to be extra explicit here, like
>> 
>> 	CREATE_ERROR = -1,
>> 	CREATE_SUCCESS = 0,
>> 
>> even though this is not worth rerolling the series for.
>
> I can do that, though we really shouldn't be relying on the value for 
> any of the member other than CREATE_ERROR which we want to match the 
> return value of error(...).

The suggestion was merely because I thought that we also expect
SUCCESS to be 0 to write something like this:

	if (!attempt_to_create(...))
		happy;

If we truly care about ERROR == -1 and nothing else, then please
ignore the above.

>>>   		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
>>> -		if (ret < 0) {
>>> +		if (ret == CREATE_ERROR) {
>>>   			if (!quiet)
>>>   				fprintf_ln(stderr, _("Cannot save the current "
>>>   						     "worktree state"));
>>>   			goto done;
>>> -		} else if (ret > 0) {
>>> +		} else if (ret != CREATE_SUCCESS) {
>>>   			goto done;
>>>   		}
>> 
>> I wonder if switch/case is easier to read for these users of these
>> enum return values.  Some check explicitly against CREATE_ERROR
>> (like the one above), some treat anything other than CREATE_SUCCESS
>> as undesirable, etc.
>
> I've had a play with this and I think the enum is better here

Puzzled.  I wasn't contrasting enum vs switch.  I was contrasting
if/else if cascade against switch, assuming that both use enum.
