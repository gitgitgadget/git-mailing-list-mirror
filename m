Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197618;
	b=SPsj8Fu9HdVqDUL5HJOzzEzTjUUzDPq83nmw81+J7PyFD2CzVyPqMF9u4zlxvlefLDcc
	 gk26n5maUJxY3FWja7sbsT8DVHo7dI2F3MXFeoyK3foiw41iVi7kf3wxJQEG84SyG+tLj
	 5qZvaY+sViljiODL5gfVkqiO1JzDnsaafsYdChsrnH3eI9DzysHRRAyNeJBfsy206Ulz4
	 TrBKe45ESZYJMSqbhR1ia6Ukc17z3sEWVemEuK8OihO+UVeGp+qSa7fGuUtytnF4cUK9G
	 1MISoYG96QhFO5HShb8Ejzp1T5337Leli/F5CLPWmpWEZPrTF8s1GvAMbfH5l627MBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7BAIWCZSWQRkYeroqmed6D/4bVuEIDSIZ3ugWdqh3HA=;
	b=PncQa9q7n5Nj6qsNWBm+K6kC6SMcvcCqXY02KwVcHGigedUet+qRoibebP699+ocYJEt
	 Va8SxbHu71xraUBlUHqwrtl9SmxB+yKo3f8tbksaHdC1qQrrMsz6ax5edKa0UM2ZdC0jQ
	 WqMyiYDbpBECCKGif/VJZs3JquthKgRvBraqy9fnRvZ3BOE+KJ0Ni67h4vU0kMjcmdrLX
	 isjKEZ7L2DhFXsxLhAnycwWMJ1Z3y0FtqqJrWzveKaMRKj9B4O6cxfTI7vGe86cMuuOZW
	 q4u0C1ngEIKttPL+45wNO54FjHevDETHsGXCmUeLMGqCX6cTQbLDnhR61zZ4tKXfJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DSsk3qT8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UfDze1Gk;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2528606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2528606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DSsk3qT8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UfDze1Gk
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F3D27A01B6
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 10:26:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793197616; x=1793284016; bh=7BAIWCZSWQ
	RkYeroqmed6D/4bVuEIDSIZ3ugWdqh3HA=; b=DSsk3qT8fLuX+NGO8f7bd3yW04
	jF8Q5pFMf/uI8rNw2n7oIlrrfo6+t9fg37GPMPANJUk+5+f4XuSHNtXwAm7W1i0K
	FMGDPGoc/2blG/S0D9T9GcyF4K4sHDeE4CPsFZWECLex26OKN05CQEt69lPlsZDE
	4LLeDmnQUXBOkUWl+4uYe3V/H94vtLR8OsH9KLSUFy6ZKBpf4TN4qx/B95axyIsa
	50xLS61QvXALQtFyZe87gfy6yaPQccB3o0XXShahghXx8YMXVSoAz9Zq2vbIsY5o
	HaXVVPqNaJsPya5B4VvdvW4M9E2uLE+G9bffqCBWrTchLObsj9C8MvBz0u0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793197616; x=1793284016; bh=7BAIWCZSWQRkYeroqmed6D/4bVuEIDSIZ3u
	gWdqh3HA=; b=UfDze1GkRE8oRvk2ukrgX6UcpvgdMSoHQSUq4FnVxgZr71tEeqi
	H8T3jZ4KEfmRzjZTwciiE9czBhuuCKF4yvUta2mYZrtVZYLr0tuOnQ4DvTaIE2s7
	JmbGk1fUik0cgmk/NshNAuTeM5z3zTkTPHAPXl8eUGnC9UFSSguAIX+CZ72YR0cY
	d95VyJ5fobrHewbqoYJjUwlu4UU9W1L28cEqJu597Bp8uowMz44PCdaksepOUQ7S
	6ouPh8tIqI5tkboRb43ScCv2jIt6CaDFf3vVLgdSIH5T+xa4Vad5lfi978nlAlhm
	aqrqnmCsE6WbV9gcjI4p9vzIT5urmheAFxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793197616; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XPH7qAi73nKcZMyUPtdbrhi/sBCZEqpLGNUTgCPlIfX9lP9
	IS3uQcjGzUdgkZGJK1J769QprDIbYOvZfpNpeOUg55kcrCrMC+eV+B8N9/8PmHDD
	46ds1BEBPcRk4bqZNDnr21cMst2xAcFbkSeUJ4TKhumd39Lj+pNQ509RX3K8zStO
	Sf1DAZQpEHSdCawhOB9fdqdkkMmauJswCrmXoPjiEZIXosK7JbS5Dv8a6bsZcylS
	zwSwiOsq/UwwS+uDZfUhRLGVKrBBH9+enjoV4Wndxmwcc63B0B0eQleOFpnZtx9V
	5MagBcygTVHo+nq8zxUqLxEkV/ybpSlcnAXTnOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:uVPHGN2OcglJxl0PlUwAqbOKeUbrIkV/GPtwUFmaWac=:wcunnct32wOvs4zYC0/9cedB0AzhtYlX72mDo69jlnM=;
X-ME-Sender: <xms:MAbiaqhVzdUaCY5WuSH4VjpaBHcXCdgrAPhdwh_YhY50DNt-KGjO3A>
    <xme:MAbiaiApcY2tGHs8RinDJHL1QPiTS-ySBvMnUZ0_fAPk6ZwQ8pSXuWdSgrHvYBiHj
    vS5J9LU16g5zr2Lc1zJM_ZxkowXt9YwxVc81eJtuSxNj8LOUbf2Hw>
X-ME-Received: <xmr:MAbianFQi_u5SRMDHIg1ihf69YNHbuTnDuasZp22VrpTWDwNew94uNjBwAC7rJyO79fnAySvxvsK7IMDV9vfZU-wtJrXHHerWMDD>
X-ME-Proxy-Cause: dmFkZTGEeXGHFij6FZLwLlFwCQy6DJ5l+CENmYHnvq3M4A6Ygv3DIYanqXBDoCUKHsWC9l
    7FacsN+s1SkSCJ1ZUgNLXNWvmQBMkdAgGScoyo/Fyjy1ytUdgEcJi10siJ1FnTlqtkjxOi
    ks+09rHK1OXTN22FvB4TAdD82BVWZ+CWU6PTY/91s08YtEya3nuNSHUxdR+V0/enhpfxF+
    tQWimne9+tECa/Y8K98ZPlt8mHg1QxBe9/iQE4Ow/fGvaPkMCjLzDhWMpQfWJyOAyxUEy5
    ggP/uwA1B75BDrtI4vK5DnOdxaz4svadOaU1zBIqrQimsr67/6zMKaJkfweG53BQiEjQiP
    mUXWLNxLDh5Uqse63ncxe2dD6NIBjLItkOtOWZ/BrqEPNUCbLgIRHzt6L1NEA7v1SILEQ1
    LRfcliNdjymvbHqvKQ6bM55Z1x59Zye+t4Yd3tyjtkDMofKYSALLOBBfO2zpR/7gVm+WC0
    NBbzOlKGFc3vmZpiwahYZ8QPdtdMOBrvGqwZVjMzp6AX6P2cSxHKYqLelJ6+CtxrXo6Vbs
    Y1B9IIzBowSHRbKfATlbu2shCUfgl8Cn86nHVtpHmFSuuG0UHcdEZE3vTS+j2YQmkh7vhe
    tNrQ9WuKeb7E9tHOn74H4MOZ65KwrCIrR0nqBGZMLXpwjlPfOpIizTdFi0MA
X-ME-Proxy: <xmx:MAbiaiLU4kOYCwcmuo2bNt3lp24IgH8tjHqJuiMYtX4f3W5zIrrRkQ>
    <xmx:MAbiajkUxGqPHDu_IaBr_DuH0228updycVkiR1KjEPVi_76DZ7dS0A>
    <xmx:MAbiaiQgygDWCEBYmIljZW-AGa795OCycUT2e-Fllnp0NNl7-TASXg>
    <xmx:MAbiatIaC1DfaFQKlszZQOgTdne1IIhKoXqsb54ERIv9m-9PuMQbwg>
    <xmx:MAbiamXyi4ylHC0Oth0gq_IaSP1nUGz-5hqt-kcA8EOVfUoyOmBnbfWn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 10:26:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
	(Colin Hinton's message of "Tue, 27 Oct 2026 19:56:33 -0700")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
	<xmqqecdezfr1.fsf@gitster.g>
	<CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
Date: Wed, 28 Oct 2026 07:26:54 -0700
Message-ID: <xmqqmrrxdhox.fsf@gitster.g>
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

Colin Hinton <colinlewishinton@gmail.com> writes:

>> This part of the code becomes overly deeply indented, and more
>> importantly, the outer conditional around here has been reworked by
>> another topic and the code that learns follow_remote_head will have
>> to be reused elsewhere, which would lead to a nasty merge conflict.
>>
>> I'd like to see this part refactored into a separate helper
>> function, by squashing something like this on top of this patch.
>>
>> Thanks.
>
> Okay, I will refactor this into a helper method since yes the
> intending is becoming too much, I will also keep my eye on the patch
> you previously mentioned, and post a new version once Next has been
> updated from Harald's work so I can rebase with their fixes. Thanks
> for the feedback.
>
> -Colin Hinton

The 'ch/remote-defer-follow-remote-head-validation' branch at
https://github.com/gitster/git/ has a change on top that you can use
as a reference.  If you are going to make this a two-patch series, it
may make sense to first extract the code commented with "See
remote.c's handling of ..." into a helper function, and then extend
it to cover the lazy behavior in the second patch.  When viewed
that way, the helper function should not be named with a 'lazy_'
prefix as I mistakenly did.  Being lazy is not its purpose.  Its
point is to determine which setting of followRemoteHEAD is to be
used, and the helper function should be named after that concept.

Thanks.
