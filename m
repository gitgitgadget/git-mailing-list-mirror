Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609360;
	b=2C1WG1qQbESNuVXpqyMQSQzm7jai6yHanyl1V/17qq4PCthZe/5m6XD+k+LIY0tb79ws
	 40kI6j+aTyAoVRl8Oc5niMWrlrQNX2TC2u7Mr4TtsvRwHRSJ4s6RQRghtSam8jU2h6Gdy
	 AdD3ZwJWYQyYio9Cv/ahRcSedLYwmTZ7//eiSIku/E+G56tVL5RJbijo+k7apl/fKlMI3
	 cPwE5RB6tkWMHtL9pr0soFmARAEqjzZhh7sYiwjkcq6q5Hj6lwAsyAGht5NnaXpMWuiEI
	 tCo9m+dFSKhv/jjoAMkZcSo45BtiP7q+V4UXaL1IenHJvm0sWBXPNgYHad566qV9CkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609360;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UgA9qEsGLn+zroT8nRzasPK4qGVHQw8zbAiV5phA4qs=;
	b=eUqOEqgLohq8wW2lqtjlGo392y3w5pqB3Q4G84Ys6efRMBv9YmHVKrNcawr5bAPnyUaM
	 XVlCQ9OiFgi1GE1kMxGy0dnzYw0ka296dxPRtsJXLdlI+/KHkDp8qNqeTeSGq3yZQXWWj
	 UoQkERlysr8qR0QgJHhCFu6HSOHyQGZYD6IwRj3fUvXWgNPthDSDUyFRpycmvaGGH95H1
	 DaWy/JHX1d9pjkeYJYuwpIPaFmHuG//oh+xC0aDYV7/HLcpQd9P5pDqHPOOKaTREmOgEC
	 WgUyUSzCJNR4QhwW3f4OvC01KG5sjV6tpBrAvrGQGXwWOOL9ZnwKo6p+xs+5r3bv1mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pNidVjTs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LMhLaPoT;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B835606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B835606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pNidVjTs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LMhLaPoT
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 486227A00A1
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:02:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 15:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792609358; x=1792695758; bh=UgA9qEsGLn
	+zroT8nRzasPK4qGVHQw8zbAiV5phA4qs=; b=pNidVjTsB43hdHypjHjNMVq6Mo
	zO7rJK937tS7mvfrGO8EL04wsBgeWilPHeHnJvLnXUK79ItrnqbonvOmIaEKlRAE
	owphQf38BJPKcfZ9a3d/IRqR7ieipzBppDfOK0RjdPsNirBRIFddgKOg3TgA8vEk
	TE3yejQ5jSKRt1xSDBMdWw/JXL/MIo75VAN7Tilc4Mn+oDH+I2f5v/DuM2nxgNHQ
	mQq7QOJ62L/93fJiaIyglth66+8o1TRjazFOs7k9tRUVv1hpq/GUdz8zYv7OL31s
	zMjh9vm4hkMGfOahqhE6E1k0Zf6y4seMyXGKkMO4xbafHF3dUGbudZ5Z9lxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792609358; x=1792695758; bh=UgA9qEsGLn+zroT8nRzasPK4qGVHQw8zbAi
	V5phA4qs=; b=LMhLaPoTeunYZSszi+KAhRyu7cXAqubRm2QVFYxEmflEZC3C1WJ
	acBdICwhQv5N/zOauH7cHAUmz4yl3YcvUjylLV8hzneJC96Dqy+/7qgd0NtM/CM6
	Pft7B+9OVbbeCYoq3orb7TjCdaY6wGO9Gqic7RUxA4jt2stQC+aL9CdKch8AQUkA
	S9C3xBNsq4CyXunkdnCyio91U2y43Tq7qqFSI0MB8zH+ilN3tsb/9G3KTmqLIVOK
	0t3SpIIVlbNyTy2HuOL8r1M6tGnDyp20e3o7olJ9PDXPIV4PNBIVI3ONt9ww+2OR
	JCGggr5099UNIHztQJrPL7YxcpjAo0ZqJuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792609358; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:khlwYgUCeM4BfRwECQOgW4imiZ47KUAzkTULWORDlZE9Jhe
	tCMz1E9T4NhWhpOfmdojazEPP49qP5uUEkTHsKOPm+aMq0slaDCBLHq+7HfVLfU7
	pT4oOxcZz7rBdgmV4/AiWtW/kIj3n/jtZ/rNoxW8llEjAmasSpESGQ8z37tmADaT
	AFdyG01I/HJBjbaJ62XAhnbDuadkMtgSDtPLUmQ6OL9/W3L9mEE50o6d0q7bPLAo
	JtxDYFUD+6tB+WbTUFNIEzYWkijyjAPuwfAIRbnOCm5wePNYiLp3guAGw5F3HBh3
	nkxlMWGC5MbH425iVcc/j8MPLZNKiS3rnLyYiQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:PRRrJGzPbVXB3inpiKag4zUkN8CHKUQa2tZD+3876Rc=:TSIlcpnLYoR/e5fEW/wcXKmpk72OkZw6gxcRWI4jn2w=;
X-ME-Sender: <xms:TgzZanNwfMkC_CV4rNKllxqxcCfzGS2EMlw9ebh8cFZuyZxwfAZq6g>
    <xme:TgzZatydOLhQNPwhcsIseF29-akDQvJYKAr3KDwWAAzcZkGJ6FM1gtcs-FY1IYG6t
    9t2AmrjfMvCMZZUl9EtTCxDYPSdrSECD2w1RUgYBsQpggtL4f9QZQ>
X-ME-Received: <xmr:TgzZahoYEGWZavmStbWrmAe_8E5UUwmjNyjjVUr4HEqdmgLlS8XWyFGGwEPBOGvFwvlFo-pY2glPbAew-u0TnVCjAtyvr5txSXE6>
X-ME-Proxy-Cause: dmFkZTFt072HP+Kf5h/k/aXJpPQbK/bhV2svp2GXMIfgG8x1T3u+fGroBtDqq/ySVhaH7u
    auMMEDc5JLmYBzsybo92PHfHmM5EHEN+RqM936gROQ5SghyANAN1LmAyOMfUcxcBolyucF
    EBwtQ+FoGXA+RNwxKwe8R6dIdnxpUikdE4E6/1ef5NzNSKbhv2kuh0g5eoZ2RVtXiFdAQJ
    N7zIeTyNqBdj+v4Nq+8+Zf9DS6GSpvaWtEJtpEMMGeEI4037Wki9naRFRZWLRuVdFK9YlL
    hxJTUwnmskFZeDsowABvfvgCBHkJkBxKjrNy2cHuzjDpMZ24IBsxhOzCIgazX54edfe6oq
    w3L/KPMx600K7tD1KLKc8FQ78qgkAb/klxVEjt8I6lyY2a3uEjY3XNlRQo6EgjOdf5MiTd
    E24Qf2yyZE4CXXjXunTfzA8ZBqND//SYBJKgbQ3srU9sF2bY0ALDR2yAk9xgaGsFqXgmon
    U3PTnJK58Q9ORiBHDQNHy0kw/C1iICVFnZ7V0wVrQ7N+aU39O6kU5zMSxvGJ0hJ3hYAa0/
    fDZumF+8T/m6ttB5Lo3rk1kA6Jq9emYk8hHOwPwQmHXh59dPRN0UmmPjfIViKVnlmpvqbu
    IEE+8HmQ/e4GSXWswuGlRIxoliX9AKs/UR/DfWSQSpD03kRv1H5VFoTRMO8A
X-ME-Proxy: <xmx:TgzZalPcJ3QPO2LKtZ_UW9OAiaGSHqbE9ABR9MmhxiBcYooSm2FnHQ>
    <xmx:TgzZatf3-aFPqEAVQY3nMSm2Q-mOhNpdL_3EPCFjJK80Kr4ZMcNQ-A>
    <xmx:TgzZajWCTKPhlwdyNOIcXsoYudOZreNkXUvGBZt46_kNXppaXIr9Iw>
    <xmx:TgzZamAcBA2OszUkw8PW_MDcfnr8o6QqPnpJZh4FZoilLmxCea_7MA>
    <xmx:TgzZanDn4xiDtbiqUNUjIUf2CPzegPxhQRtEE-hz8Atzcfq8_2auw9AO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 15:02:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <ttaylorr@openai.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Derrick
 Stolee <stolee@gmail.com>,  Ted Nyman <tnyman@openai.com>,  Daniel Reynaud
 <dreynaud@openai.com>,  Aaron Friel <friel@openai.com>
Subject: Re: [PATCH] negotiator/skipping.c: parse parents before queueing
In-Reply-To: <athgd6Ya12zRdIR_@pks.im> (Patrick Steinhardt's message of "Wed,
	21 Oct 2026 08:49:27 +0200")
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
	<athgd6Ya12zRdIR_@pks.im>
Date: Wed, 21 Oct 2026 12:02:37 -0700
Message-ID: <xmqqv76unagi.fsf@gitster.g>
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

> On Mon, Oct 19, 2026 at 03:17:07PM -0500, Taylor Blau wrote:
>> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
>> index db90fa77b53..ed6e88b59b4 100644
>> --- a/negotiator/skipping.c
>> +++ b/negotiator/skipping.c
>> @@ -151,6 +151,9 @@ static int push_parent(struct data *data, struct entry *entry,
>>  parent_found:
>>  		;
>>  	} else {
>> +		/* Parse the parent before using its date to order the queue. */
>> +		if (repo_parse_commit(the_repository, to_push))
>> +			return 0;
>>  		parent_entry = rev_list_push(data, to_push, 0);
>>  	}
>
> Why do you parse the commit in `push_parent()` instead of parsing it in
> `rev_list_push()`? The latter would also cover the other two callsites
> that call it, and to me it's not clear why they wouldn't want to parse
> the commits before adding it to the queue.
>
> Doing so in `rev_list_push()` would also bring it in line with the
> default negotiator.
>
> There's also another call to `repo_parse_commit()` in `get_rev()`. Once
> we start parsing the commit in `rev_list_push()` we could drop that call
> as we'd know that every commit in the queue is parsed already.

Thanks for noticing this.
