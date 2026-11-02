Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609480;
	b=OlcsLhqNweL7YClvGijXp3jdKgJt+QxFgEejPsnh9GyNZ3WaYHJzBQKIrJDq68OnWaN+
	 9XBjFOvJTekbHG4ZHAh3K4M5utTSPS32HnIl50fdoMUpe68giN4EMHIJW+MGShno0fh7D
	 2mska5AYFO6m1yNGp90XynkljQa00e60+dFmml98iJHUbkvPzgc+jquPZgDGxb2qIuuEZ
	 Omu4b4x/tROd5xeK6RpXLCjMop3acHU8CUvEbQEhWv+f7xjbLnPv6mddijXS8Q3DzoVfA
	 u4je/35EuD7m42IeUSgfzVSfGzmiw6DIbmQ+zqbJnv0L5peHFLTXGq58LBN3N6BOrdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609480;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SoCUKve0oex3H0kq9mHINFOKeFgXmhxGHzDqTgGTknU=;
	b=FwBdCYICFIT/euX4YKpSr+ub3T6jlXC9SQfue8AmtNkrSai/YdEmPpoFBAWc/54JPVzH
	 piNIpVQcWF0GQRiZPx6tUiLzIGf4WwItAnwkrcQh6XhWIxucTUuW1ICIl170UYZzDC/ST
	 RbcBcLZiKyxAHouVfIONlfmp+C/yIRP5vzT5eTTtJLDZIwprl5/hzY6WSiPR/sjVwt51D
	 YaG9YHFOIJ8Lm+jF56/OxG1dp1ft5jn95TlSxRXKYkJW8uRNYqBLGUNGgvaHQGHyNALeS
	 QlrvPQsav85V0+YFPMFxgXcvxxkFn01y1fNd9Ww5pslBFd56d8XZ3+/OsJJgB6rfQTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="h/pgWvxb";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="J/F3ZLOX";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98EC60A260C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 08:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98EC60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h/pgWvxb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=J/F3ZLOX
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DF767A007E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 03:51:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 03:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793609479;
	 x=1793695879; bh=SoCUKve0oex3H0kq9mHINFOKeFgXmhxGHzDqTgGTknU=; b=
	h/pgWvxbP9opJsfNSkUn2D1Eo2YyGh3/0aIN3uuOVZoQ9QNJ/byM4/RxPRO5IstP
	gsRREFwiwlxPcUlNqRxTKOgNyYpr7/KsTgclNWnEkq/q9chG9bI9qTbBT0r971tB
	JOypycPJry6oA+3QJ0z6v8WOET1gDKCQf8IfJKVFIW9susI6MbRDl8o4S9VtUfG2
	ZMawoFlbJztAnkitEQrlGbk+XXsCgqi/Srq/BdIcyhbBk+Epcn8gh1On/4LHFxg+
	0Q4k3bWOsKlqMPmMV1QvhkscxcZ/U8SGctpsKgsWxDN9z63dnLbU72G+gbVEvO37
	kpy5QwXKrYzaTdJ2bV56kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793609479; x=
	1793695879; bh=SoCUKve0oex3H0kq9mHINFOKeFgXmhxGHzDqTgGTknU=; b=J
	/F3ZLOXqcLnt+2ISYbCWiYPa6/WKse3kgIdBfx20MZAAA54TvjzN2Y87dZu8a8eC
	OAV1kMounESZohi1JhfuuFZrEJi2k4CWh+/uGNL0/vifYniAzwe2pWlChCHlpEvj
	28qMCUwV001Axs3z+/Jm04jEfPqtQUHN+caOOgg7DSQ9u06XQ+umDA2Z1IMT2Xmp
	7XE96DQDe4Aj9xKyKhKy0osEegjw8AExWRPEdI7tTfjUxGI0GAHDQb+SVf4XFH6H
	lDi4Npj1JKPi6E+O/4eWAJzpdDr+6TIl1sb+kmsDu3t8iuRZW6OCHAZmnKL6H3i6
	vr2UYRm6MJb7KSacJazcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793609479; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YyL5dVxphTGJyxky4noaPlKghJHyGwcxrsmQEPrU/CVnPE0
	E/ktNQ+FDCK72giVY9RRtzc4GqbnvDLvo5OqzGBYx1z9+c1S/QNjFvxYoGo+j9Oq
	4yx2XECztnYhFXVXmMKVnsXo8qQkwJahCyCPzCQfQnNFPIr7Pj85BWBojd7S/1PT
	o76lmQiJ+w+5BBJpqk6cOBVDCE2jluDWOTaIZPSC9GABl8fwcD029cYkQKRgnMLv
	fz2xtnCFsGqCYmcCMKCag4ju82KgZ/xNTp3jLmbsZqp3wt+WnRiNw18S/ytQctMb
	Zn9/KiAm8SOTWK+B28W4PhYjMlJT79Y/k6ygMNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:4Zb7KiJq/4fYGYAtFrqMbZMPqAPYnhLkYtakNmYAgzk=:l8zRCuZ9Ycr1lpLtWFPga6LR8sOnuernW3PgVEHNa/4=;
X-ME-Sender: <xms:Bk_oahcEhnnQz8YJ_7t8Mykb-foMYsPNlcnvFzKijr_68BZQmjF8Yg>
    <xme:Bk_oapOF2VE_q2w-UvurMLUQh4hPqATiBxfLWfU14cbH_OGbS9DqC_W4mwS1KA7if
    r50GdA_PRMJGmh-_MRZoKwBIFHE6UX_LZOlOAylFSTrglLg2Vyf5Z8>
X-ME-Received: <xmr:Bk_oahKAYg2f4Af2hjd6XB0INUwktuDYbWy_FSJrfkK0Imz4GiZRXT6iXONqhU9IfYmySNdJ21Z0JXpt7WdNqSpE0Qb6URkcJf6s>
X-ME-Proxy-Cause: dmFkZTFdpP50+ztUVDI1bmUg4n3faDvkDBuOpiFO3lEKzeRI8nOyoPjL2PV7DMiiIK2uqZ
    msEevQj036ZUiJQI6hSy4Imv6rrDSTIDoNKNMW3aZYQJlWuJl0uA6v8GIkgrDHqsE2I69m
    5aJxR7PJOhssTIBSgkuF9ZOAgjG0NfWE9Whg3F1LyxQPFFLGv589JRPgFzKpryJBcEKSwm
    ogUhryxegp6k1GoYUoOuSE/imut/NAAljbU5DIuLyzdcq2mSvtEf7ZXB/Wez5j45QnDrz0
    EyyQp4nUWM3XUsyRKctQjIbq9nUcJVpMMX6YZmKPpI1odoIgiJ5XzAn3xA8ueMuepj3urb
    nqMtC6MdjEnB8uPiA7hc9HGJEII6MtvFq8ZWQj878Ft0vnVT6IIAiK1aiPOc0PgwUevKp+
    yNWaq5dErBjYpVeW2are9aecfW/boqyPYHXJGmS4eiHwrWFnpTQFHcvRUzYFN1CyzpjFU8
    vQhs1ohoFbZ3W2MTxzDxkhzQZ9XY9JFANJndXyCAgO0nl9UYBW7s05Xx9N9liJMxkMVU7m
    AnLm07k61yvQboBMIsj3z8ImQeODtBf36tG/kfJssUtxovv+mYhG7W/wx8lsJXU/hogq00
    zPZ0xA1pwnwRy45TC1L9yPAY9XDWWX40SWFKi5j4i1iXYqNNw3BAIEX5NM2w
X-ME-Proxy: <xmx:Bk_oapKxUL8nucUqDZbnEZGEPF58dkxqvCfQmXtGS24tgBlDQuVw0Q>
    <xmx:Bk_oar4XQMan4YsU_c9915a_T4N-k2j0hRTqYTkcyAdTjoq7711P7w>
    <xmx:Bk_oajewetj3LABV9iQ6ak9uVc1UTE7eDq7l5bSlqB0gNIr8JZwN_A>
    <xmx:Bk_oamFGYBIhtw44GjQILqtzHSDwxC1xHN8bUPop1WDHD0tctgO5hA>
    <xmx:B0_oap_t3wTxqBKrfB7fQoA3FtIxLuJuIBTff2hQA_R92ZUqWkeTtZhi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 03:51:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Glen Choo <glencbz@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/2] fetch: make submodule fetch errors configurable
In-Reply-To: <xmqq1pbkiy50.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Aug 2026 10:34:35 -0700")
References: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
	<20260810150844.4003918-1-paulius.zaleckas@gmail.com>
	<xmqq1pbkiy50.fsf@gitster.g>
Date: Mon, 02 Nov 2026 00:51:17 -0800
Message-ID: <xmqqse1jmxa2.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Paulius Zaleckas <paulius.zaleckas@gmail.com> writes:
>
>> Gentle ping.  This has been marked "Needs review" in What's cooking
>> for a few weeks.  Ramsay, Jean-Noël: you already looked at earlier
>> rounds -- would one of you have time to review the series?
>>
>> Thanks.
>
> It has been more than a few weeks now.  I read the topic back then
> and pointed out a few obvious issues in earlier rounds, which the
> author seems to have addressed.  However, I was not aiming to be
> exhaustive, so I cannot say I gave it a thorough review.
>
> Any takers?

Second call.  Anybody?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

Thanks.
