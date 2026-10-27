Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130049;
	b=kfpn7sF2eHAkM4Rr+Id0IOUUCmK2Qy2cBKEji+UmCvefCyZ97XsQUUZdYZDY9Izz+wSX
	 /INi7kHeWO/BaoWBASa2Rr2Cu4q9NcKGrX4BgthkuK4DAaGTegBj+foKk0D8lQUcpadX6
	 e9r4CgqReyAUTrkj9phBjyv47LpQ9y/YpBEDLiN7sLJ4tpZojHyYMu0BTuEpkM8vMN0bv
	 P3akgpmA9SuRQGGq6GrwoSez26xOqhaySrVGP6obWH8MIit6t/9flKfY7Y+ExIeNY6rPE
	 N0nk5avyMFSedo41RT/MhbBBSsAdd2SYj99cWDe4yHGNIhvma1MGvfVsQ7fMCObuKOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130049;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Q0TFhgbhpPYIVaPachihSbqeDVN4Sp7opWcCRx7Cw4I=;
	b=ySpd7DcDk3HIl0GvR3/9u9+fRn67UhLnLwKjt72aDd7EMAR2OjNWT02EmX/51jYBKcSI
	 OvF/r3pQpbHoxTv9+d7djWVefnBcZYLX/dFLOTou8+C1+uRgDxdasDzf1hlfUN98eETMb
	 PGPIZgyCsHAdooJ/9FV0fFUWqfdK8+LYITPS1QwJFIcv7fuPajk0U6MtlzQsyQKBv2TzE
	 OAXJKGrUJXiDKn/UgJaoVUUXgdq7JdYiRC7wo74zDWS7YiECR2Pj4xdi3sdkGKU0ojdi4
	 UhYQ679XocxALYPEdXX2fMRoWMvbmP1u06GPYdh7qyupaCyUquPTzJoh30E0Wl0doYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=TgwhgU8G;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OaS1ufx8;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB8606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBDB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=TgwhgU8G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OaS1ufx8
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 132F67A0176
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:40:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 15:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793130047; x=1793216447; bh=Q0TFhgbhpP
	YIVaPachihSbqeDVN4Sp7opWcCRx7Cw4I=; b=TgwhgU8GcJwgpDZKMXWbZ40Q2h
	vX9Nn1Rin63WKmatePTCxY/JPzIGf2i0aaQ0yU04u7RQBjF5HnkJZh/79ecjZ4+g
	M/778vZesNGAIkGVEWIRFynJWNI6sprz7BSl9VgKPnT3qTJaW7PdBM3u4+j6WXED
	z4gjZlNSJnnVo/Z1c6FBt06+VRsIgu+7xynPXXl89EG/SbVbMG7OViZEfTkIwNQU
	zs03CWJuPhUrhUjp6CrmB2y3eaIgM3F39W0ULZ8+vTBhZ481qnI3CfJSMZ1KNvNp
	ZxX2TrNgJyklJRKwOEMGKFZ5/DkJJzLxymzvco0C2EUy8p/pS/hmA405z57A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793130047; x=1793216447; bh=Q0TFhgbhpPYIVaPachihSbqeDVN4Sp7opWc
	CRx7Cw4I=; b=OaS1ufx8A3R41k+5jOq7EcRieBOrGU26ElWph/pdvJxW9jy7tTy
	Z8v4Kj3s9n80Vnrig71eHbM/VWUyeX4vZFCTZLWgFraQCRQc2o85OUAlLwIsvXDz
	peJL2P5WG86IotqvQL5pWv7EplaW1Fj5cihsJ/tCgq5jYByrfuLTj7s1My4u4aKj
	dZV82SED6kLZoA+qsd9opT4Ri/oZ6aKTLXVhUu/8eTqTI4rUTaq5Df1VkWzG4dcj
	BhPAxxt7WLc8vLLWctb2Fh7o5yfNtsSfipYWBm5sOEVlHL/889004Ua38/JnrAg8
	YN29cPlbuV6opI15A/7uSs2WSWsaEyCf1Qw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793130047; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LNEjOI++W9EkeGIEuXbBZwf9Kv8CgVYQE2HrxJGkPYT4QlI
	Q+9zX9HA4IsrfTVn1AFbH939f8I+D03HSJJiCClz3eGkgUfTW8VydrkWS0zAXKJi
	SitRJvRyVM7i/ryuTbA2BHTchlBgrIaqM/PkXpKzXVE002Ahkumee/7b9K/hr1sX
	iLXAy915u1o0qm0qJ/bJukXjpK22KGGxcLcgk497Tk3LH3yowiES7wuWVG7tgeNW
	O3vy677+EQ6nn301VrteESdy+RdiILw0Pflza0qUl5Jb1RJ6UsTHE/rDOcm3F68e
	8i8YWFiEybXfMlRkOEeVJRGXrC7WTdi68enfBTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qZ16BrmJVjRou5LecpmkagxLRPmiQmeuLfxcIUKgu8k=:nz8EyvXB5UOx/W3zYTmqsSYOuKLOqDOXajn/JqoKyGI=;
X-ME-Sender: <xms:P_7gapzTlr0xS0MiOKg4CL7LNZmU48X-iLov3S7IuwZjwvj0P6Ke_A>
    <xme:P_7gagQCVfrXKMG0V5VW7A854nM4oGufngKsFhC0MfRVgx47FSNfrTvSnCf-zOyky
    1ygtkdCGNlBqpX_Z7Mh76qLEUMaofHFc5mlZGO5dvwETOdT8NUb0oQ>
X-ME-Received: <xmr:P_7gaoWBm7e33_VJuZx7ZHW2EmTkebhxQqqp_gNoKKPbSboOZdU-PzMEV2yg73h0IZyLPSuJNsmNsix2R7TWxacjlB0ZbD4OekGi>
X-ME-Proxy-Cause: dmFkZTEOIJOwH0AGvgxZRyRy3+tr8Pg6dEnyka1CvWU3F1RNYu9Mga7j1kJ1Y+HtsPgsNF
    HYZQTc9koXjRNBeM9bMde98r76pvT0aV+9rGbjnXkTCtVGoeG5Gm7sdojCuEsprJDuN+uY
    vzf9bXvt20rWwu8i1W7/wlJiUtC8wzNiHtn+XfHKcDmaxcMcZ1U0dozd1IIWwrIzAnMKGO
    zNwzUdD6VQuMaQDF9uD6BbY9jAKJzZQvGZr+JvqgwxTIY8T9sWtF32E0xYm3B6cZf//JxO
    4j7UKd/pheW7Vpkjfi6tXl2b7SRLSFyPofH/AMASN2nIAMbG5RC1YDr6A8gaRWpbhAauML
    dfZPqVgvilevtTjpAwUv51XPsK/L2/Yd/xjuIY62TEnc6GEgbP4c2IEAKzr/jrIc/s9obn
    2Li6ADt1kRWMXnqoCAmaJHy72kvmp+4RrWpNsqw6VVfFHjxZXte7HSpyzs5xHoBXOX0pqY
    g/J7hFFmsDvFIRv6WdHRbbAslgUNCur+PWL/mLpKEnbQmUs71BwBoN6L4/x/MaSMOQyocw
    epp09y7HKaYrvEavWUmq6olo9nIv/77icV/FjVKxPQBmy1jpwPtpvshoNziDlMSUSNByf2
    Pr38bl2TtqkOCO6TkuEi0AtssrSAmNKLFs9zy1BNTRfGfMoQ4HYtYuQxz28Q
X-ME-Proxy: <xmx:P_7gaqaxT3ly1zT6JfgUhnijBH0mCl_57WByUMyQ-yStdWxOT7ivbw>
    <xmx:P_7gam390qar9Lto0R3CObTjbOU3KZ9z57We0aVyQhbt4yQmTrKmvQ>
    <xmx:P_7gakgjmAx9umOPbB6AbCz9McfBOw5sM4j_Xaa4J-wcbUYZ-BCk8w>
    <xmx:P_7gaibJxIpa7dS8xqoIc0rk5eBHkJHJzLUaRBtX_vLkXHiAJdPN7g>
    <xmx:P_7gam8ceSPd5tJV2m1L2XCQl6h3dtZb0AlRyhPasZM05zX_ilWR69af>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:40:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 02/12] rerere: convert flags into an enum
In-Reply-To: <c23c4593fa3add2b40613febb2911cfb@fastmail.com> (Mark
	C. Chu-Carroll's message of "Tue, 27 Oct 2026 10:47:17 -0400")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im>
	<c23c4593fa3add2b40613febb2911cfb@fastmail.com>
Date: Tue, 27 Oct 2026 12:40:45 -0700
Message-ID: <xmqqzevzhqyq.fsf@gitster.g>
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

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> On Tue, 27 Oct 2026 11:46:45 +0100, Patrick Steinhardt <ps@pks.im> wrote:
>> Our modern coding guidelines say that flags should typically be passed
>> around as enums so that it becomes trivial to see what kind of flags are
>> expected. Adapt the rerere flags accordingly.
>> 
>>   <snip>
>> +enum rerere_flags {
>> +	RERERE_AUTOUPDATE = (1 << 0),
>> +	RERERE_NOAUTOUPDATE = (1 << 1),
>> +	RERERE_READONLY = (1 << 2),
>> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
>> +	RERERE_NOWAIT = (1 << 3),
>> +};
>
> If we're moving to using enum flags, then wouldn't it be better to
> explicitly add a "RERE_MERGE_LOCK_TOKEN" to the enum for that case, 
> rather than have this value only documented by a comment?

Perhaps you misunderstand what the comment says.  It is an
explanation for the next line, i.e., it tells the API users "If you
want the 'immediate failure when locked' behaviour, pass the _NOWAIT
bit".
