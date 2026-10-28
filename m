Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204731;
	b=ybXQdJ7Yh9H2X+fZmZacq9dcGRx1nWK7qOfvlVkZNOuyUBiCWcpvxVPIoG1wGQzx3TTD
	 YU8MTHUjtjxC3Vnm6b3v1h9fbaPxhx4Cv25bq7H0qmw1Ds1F2kEYQxV8MjJZvsvPYVKIe
	 dxqBiYNsjZ48RmBuoF5AeN1csIP4y8nTeOmsw/RKSBhFmMVlROECZs4VCPhOkk2/6MDUm
	 YhQBqPWOQkuvG2gLvDE+WCXWmEk5mD+kHzijvqan8VR5DnzL0HovovWCsUXZyG9xb4uwc
	 EvqrpfaSbzNxToH41aeu8Nsl7pl2hybs8jIJSGFeM1cVYA5magLbYa6cNtjLG2UJq1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204731;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mrZH+LI7XO96ufv5Fu60gb5Ce9JL6r99QvK1xabqcLM=;
	b=sVVXWy7absRyIACm9qQiMRRzgcIDd3i3owigeSx9C6U9we7/5TTF6ESE8aSNSeh+NHAt
	 5zmJ+M05Honaq0XZ4yKAVvS7vshAuxITExLE3Rx/Vg9D1nWA27SyAewSMugoqKticn/RD
	 CU3QnxSCLd3ioINIYYxwY8pACx2l+BDSY5nGDmdo9WZe5W6b+VnurVQdIP8xQAdfMwLva
	 yezOJsbBE2lFZ8UQhPOToY9rMDEQzpXX6vANAFMcPkTUKJOD+pmJYuOmaY1GopYcpKY0u
	 63pSXnHQ994Sj4byoB1rw8R2ph4A4UlXWkDFZTgZT8GUM5ISAnUpbP5JpWrISaEBUiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bHE8ncv+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LOxs0GcN;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45189606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45189606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bHE8ncv+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LOxs0GcN
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 94E6E1D001A1
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:25:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 12:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793204730; x=1793291130; bh=mrZH+LI7XO
	96ufv5Fu60gb5Ce9JL6r99QvK1xabqcLM=; b=bHE8ncv+lyeZofJHsg0JX95mz1
	ma0Pb6t3/JCjQuh7SVIE4hHfXQIwH4tJJ/1d1WHDbFE2xkUGsS+Q6WvcTYNVrj3E
	gUxa6h21N8PyTj34IFOPyJJhvjg66Yupg3hKoI6CdCVRWGegX1ROdmWixW3UsBTu
	gBj97YuHIthFnGu0PqX1DT9px4EGpGZkV7oicplyS+UT++YnJTH0ZNo4bihuOjMs
	bpR5jFLdm8U4nXyYox9umWRBtzkk1fH7QlyckdZoaDcidqCM2WGKaP4jsH5T+z3V
	mlt9N3DDDUedCiTU4LiYHLue0CNihaem2Bx2Yb+jadz6PoaUF6bnqA1HfEUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793204730; x=1793291130; bh=mrZH+LI7XO96ufv5Fu60gb5Ce9JL6r99QvK
	1xabqcLM=; b=LOxs0GcNlDELsFeJShrpo3T7iK+9yCtVRyWfyEFJg5C4br09b0Q
	/iqSKNBaKAsoSMSNCHO23UUbi0WGPNYJhkqMty1tKL13NNE2BYQ3vQscuMW6uLk/
	/YuFVTWNczgWf1ULL5x6hTvixJyM9Yc/tw1eXWRnYRE60GoC4/9FhI7v3gAwVVQK
	0q/Zc8kNFU3GGDcz1FFxRjPaMjShJ+jv5JoDcM/lR5pGaBL6zJtMJeEAWK3kvyE6
	ZGMzpUxRMtrUngpNgxRC6m5OD2o6yb/Qk1nEIlQrxkXqU6hl9BCMq6dE6vC0CQ1W
	s5xDMZbQ7ANj+Tq3RDvP/Vy0kumi8y3dRQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793204730; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JQq1+/f3h5Jn3qv004k8UOiDY5gxD/FClI2G8M29M7vAL9s
	zCNZKE2Re+q/VJgPmbi+1WhZgkXj6z7P5RYOYyq+7Ck8+or+S8sZ0zbyJLY/VTrR
	lWDqBuVJTpOi3Mw82EVEOQPfu7Tx7erLUW+67PV7c7+WgIL3oFa5jFzeDtjLEG/q
	ni87F3PoGTzK0n/HZUo4h9KscExn2AQo7aXZCSs7iB8ONHgS0ZUYrZXlL5GADgAS
	zfWOad7HXYisVJjfKE75tuT53ZaGcWLJ1whYAA18YvacoKaR0tajO9Qczpz3zjQd
	ImU8+QQOgGkJ2Qr/0z2J/fTqYpCYShoKylk6ivw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FfaGUMX4HPoOvch1P3W5HQc/FIEIowt6sXWJ0ZBLAbc=:aDuslkzZlq9IuneIFKgZyfQQ34WYzXKUiOCH7R3zM4Q=;
X-ME-Sender: <xms:-iHiapa4qy0pBw0yy3xu7TIpO_QWoaEFKqN84I6ZyJPp-G9XbEcMSA>
    <xme:-iHianYca1vhKpRuc-ifhiiqMjl2T6wpunQlCfdbowH8KYardK1tGn7OtKzF2no9H
    amaChQwmeMpVxvCBRNJaZxBnGHMSQAzu6WzfDiDd4Y8nTJpnGw84Pk>
X-ME-Received: <xmr:-iHiag8w3yZqXun50yL5aqFLthwH08YQxZnutVX2yLWNjR7FiIOvQNMRdaKQDqYQVa3T83SYrz_ApcMTLjUnr7cXn8FxhWVsU-F6>
X-ME-Proxy-Cause: dmFkZTFiyXKhX9CpOYhjacvX7Ne2GcQ/shc0a17XK0GmHKYCGDCzn6Z75iOoLoSCueqcyB
    60ZqGHtDdFmd5hzPyG16L/uQPh/rvXhRD/d9+hK7/EoWWPhVX0kjsuvoOzZ5leOZdOkMuA
    /tqUxhb7ddsNx55PbODR+08YVPML601gglZcONZpU8GvexyGXs+ZcPs2mry91sCrwkQ15y
    c/Rl+kZgO1003TYjKMYGlo82qSqctGHckO2QpIGLwTG1g7EccY9a+bJdpFRZo3jrZ8wTb5
    1KOBC8zIe3MkjfYNKPsuopIdOjYV0nFzaPD+4iRkfNb/Jb41rKqLZAzvOOHTFMY1D1GjLl
    B8WXJ6tlqOzYQGKjvFkpq/CIIGYyUtuIaQyYPLffa19vqol6YCxBIMCDRdS/zVas8hJ8EA
    LgIvkfCMAhDhenQ58/oki/dEvMnhUlpt7dI05wK9FkOn0EklTfG1GANGz89MlyOCoKS/f+
    e0pIcAFPTmsbRjKiO5Td7S0ZpQDofVoNOppwmi7VnDQ5/9/33Ujuhi5aSDI8KKr/IpX3fZ
    YPJJBoVHaVX8Kp0dxo5RWRpFYy23dKm9uppsgobZLDa7OzQ8jQtQ7z6lpPYkH/D1MlCEdy
    7ygSeipBJ4O9ypwcZXMN8ezFBariEGiLUEJ2RzvVHH61WnWEg9qydw/Cd4Kg
X-ME-Proxy: <xmx:-iHiamj-KDttkARgZSrKmbipOxZE3MsaDHdDwfIliTjspT2kzfFYVQ>
    <xmx:-iHiagf4Jmr5q7LJa8iR0h3AVu1Ay1Yc4nS3lQ8ErNOCVf9mgNnAeg>
    <xmx:-iHiatoyeDzwsCyS9Qkr77UT9-WJ_lYPV6SfJiYteOiCSmzKaQlsTw>
    <xmx:-iHialCWwDGKI9Hxo-On78iAyH_YhppqpfdVU4LKoTdhpi97WW2dGw>
    <xmx:-iHiavnX-PegmPG9tzaj2upsU1VSTmRmgKkn9eTzg8yslc-rIODTolO->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:25:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 02/12] rerere: convert flags into an enum
In-Reply-To: <auGzVZj5vbVm3-xf@pks.im> (Patrick Steinhardt's message of "Wed,
	28 Oct 2026 09:33:25 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im>
	<c23c4593fa3add2b40613febb2911cfb@fastmail.com>
	<xmqqzevzhqyq.fsf@gitster.g> <auGzVZj5vbVm3-xf@pks.im>
Date: Wed, 28 Oct 2026 09:25:28 -0700
Message-ID: <xmqqse1pbxmv.fsf@gitster.g>
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

> On Tue, Oct 27, 2026 at 12:40:45PM -0700, Junio C Hamano wrote:
>> "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
>> 
>> > On Tue, 27 Oct 2026 11:46:45 +0100, Patrick Steinhardt <ps@pks.im> wrote:
>> >> Our modern coding guidelines say that flags should typically be passed
>> >> around as enums so that it becomes trivial to see what kind of flags are
>> >> expected. Adapt the rerere flags accordingly.
>> >> 
>> >>   <snip>
>> >> +enum rerere_flags {
>> >> +	RERERE_AUTOUPDATE = (1 << 0),
>> >> +	RERERE_NOAUTOUPDATE = (1 << 1),
>> >> +	RERERE_READONLY = (1 << 2),
>> >> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
>> >> +	RERERE_NOWAIT = (1 << 3),
>> >> +};
>> >
>> > If we're moving to using enum flags, then wouldn't it be better to
>> > explicitly add a "RERE_MERGE_LOCK_TOKEN" to the enum for that case, 
>> > rather than have this value only documented by a comment?
>> 
>> Perhaps you misunderstand what the comment says.  It is an
>> explanation for the next line, i.e., it tells the API users "If you
>> want the 'immediate failure when locked' behaviour, pass the _NOWAIT
>> bit".
>
> Yeah, this. I guess we can help that though by documenting all of the
> flags while at it.

Great.
