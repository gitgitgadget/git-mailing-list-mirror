Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250119;
	b=sw27wiaSloS/FuYkuYkjLuodTUm7cGcefy5Gzq9ZwWL/8NrpB5F2tFrEVd5B2sTLSsFK
	 1tbC1ESdNZkrcf9LxI2gjfktvmf5WewnOVxbvqM31VONei5sRGFJoXulNjnON6RUIPdhi
	 Dzb3sVWJhKQ28HdYDKbAfnIw7PaVn7hqxdDxbpChmLGXBSbQyjFVa0Lwayql/0Uo9oZIY
	 jJ0au6WaTahfBK5WeDEcSf2lstb/JaCAmgbrIvpTpEtW9oD/gwkf+U6pYmDALk8aq3jyU
	 KZS/D3TgRbCHfbwIrlhnmhcyXw190hW0n9RDpUDl4U6ujrEWwPCGVb4Ow0ssN6Qh2hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=r5z9t1hgTfC1tDWn4hmCpn4wqjkOnZsNmjzA6AekNp8=;
	b=iEaYJi8bkfgieSnmwN3G3jglI57ICUHSTN226cbfzx8iq0FyX4IwOZGLtPL8YZccA0bq
	 9BnDqNiENnPQE1cwfhF28IzURv1IYUzr+3+x3pUEFruW8L6zsJ+Xdp/DZnBfUNR7AoWoK
	 LaOCxDOlQI3B2Ndk6vDUkPHWt1DUCNwt9MQrDIfkPX5bNtiT821v1M1jmKDGsqAlH+rAj
	 6jm6JP4GrS7OlIA0AGn+TlAhD5xN36YT++LO+NYr5CBbTjDOogRJvIg8NGVOFu8bRPWaK
	 V1SRuFKVwJj/0H6FGuvjHiDHZPDKLaStn8H9M56vEp+MGIOg/t8SuaSgkCZpqEwEk+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BwN0OPxY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QXPwMXve;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87F606A336
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 18:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA87F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BwN0OPxY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QXPwMXve
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 173E01400182
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:48:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 09 Nov 2026 13:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794250118; x=1794336518; bh=r5z9t1hgTf
	C1tDWn4hmCpn4wqjkOnZsNmjzA6AekNp8=; b=BwN0OPxYLgTYpLtAXeGTLAYKxx
	QF68+KZwN3sPtZPqu7gdwwU0lZr5eIQT04EKXEDpEdBxh/evUklVztGRGv3G5xnH
	gIpYFPpSRxGXuEJpBCDE6AxdBG59xgGId/4xtum1rSQC0BpQYAC8KNHUGK4yWfSm
	ZbAw9qrcyD9+8ZIc+fMjXz1z5D1tn2348u98UA1eb9LFK6qzrDKCBGa6GK7t+ROq
	blJG9kzfqfCHZXry43qv8C3CtkzLR9kMbr2DyqJDCVtgb2Hsrmxmk7k1BL0U6T1q
	qZV/IqawLSL49Q/2PtfrEZUknM7JmWvH6PBaV+N/635/ZHdxXfjBQFDnrSug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794250118; x=1794336518; bh=r5z9t1hgTfC1tDWn4hmCpn4wqjkOnZsNmjz
	A6AekNp8=; b=QXPwMXveHyFzbdcaQJIYBFe5diu21lRSzzW+F7Hd+QHxdUiNpo2
	ZkFmh9wDnVI3dMCAYvumf9py+yZ+8Sta/iIaO/QExAMPfxRQ27u/lNpNFm9bqhxV
	95O8XYJMvGC74hHkKJnIZBjMlNg7fKqC6cb/cLvwORC8Qi/7+RPBYvU5MEpqIEeP
	y1cuVW7Kw5GPqj375v29fRfbeIORtz2TYsZ9UtikBtg+blNDhzg++yi1qE2KTzO/
	E3y1F9VviZNWNigYZ4UMuFzoBJmF5JdM0QgCdlqQp5Av/MIvBrPWsww29YLqhkfq
	L3MPUIIRG1y3CCyWbZ0ob+4fdXTIuSocqRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794250118; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aYTtsq9Ad5HDcroHkWL7q7jwUdjA19OEv+nhQMX5mWZREHQ
	5ai0NceRnW/iPNQssKJqfLbqyE+D5OKbs0G8tG5Wd10Oz8+z5a26rnylv6E/pu/d
	qT4i1pZmTwylgQbf11jJ0BPOWNDGvIquJkAP+TX3NLkbvMMrppJabOD2Pb4Iwoak
	nRiJfNKhne+YXRhfD7eadebG7x6rMgb2Fd3BO1y8fOGYDmxfInT6oJIspWefHIUi
	OyrkFnmKnAsYBjyomjAoZ54i5CWxmqLJkbDaJN0OcQi72tMMJGQ4XehZ6viQHfj3
	kzw9cU0q53bI2+coi8KNw4Az5n9yVLatkAHE5mQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nYWnQx6Zmka0+fFMXi15UceOTOG8GGuLwFlJrXtUsdc=:c/n/hpFA/03R76ugwq1cjTsW76ULjie4t6CVoHRZCm8=;
X-ME-Sender: <xms:hRXyajeqKzn7NOAnVzD0B-OPDpHgx1nmzvGzzJRHa1A67_ltJlJbFQ>
    <xme:hRXyagrbCuFeYyTGWFJlCxm1bpBrMyDnATLsKbrAueMhUwyQQeiYlrumQHvuW-qZM
    F_PH1qWq5ZNnqC3r4jEFwpRW_a8WpjszGoT-eilQIsZ-X8Ya8KKrng>
X-ME-Received: <xmr:hRXyap5HIGBgqLkMt5k1OC2-5ebxubyYwpJKZUH0BxbgSB_C3snnX0KkRSkqLfFcx7xPcOOqEEVSe0w4Wc2b2itC7WC2wGTyo7zl>
X-ME-Proxy-Cause: dmFkZTFhPsrZd/PctDVqC2Q5Il3IeHcYYOjRrfFrsQzFBGM68E5ebkL+rHXgJozMkcuGc7
    RTAC5NhLPDCwigBAwTcpZhPr59fnkJLrraGzntFxEnGrezVQjroEMqHjejVn3gU/iOrHFF
    JrfMJzBt+FM11cWNtwss8EeXnXbGSwQPhMOVdMpjl+W3ZKSlSP2SDYVAuN8XMFcJLdAIpx
    d4TAugKHGBK14B6zn3etR7/ctYpLjNx4IlRoqsqOhrTiL7VuUUoXuyM+DAeYOFFpARt4aT
    fq3oqfdGcXV3H8ksPpgrmUHKofE0BSwcdLwgf/LT8VuSjaR/JAU8maSNuTIGRy6PLITAD7
    4fGRttCI411Ul0abofU0rO1gvmJH2crttcUOw/tRzLpFSRBYU+LTX9nhl+5U+MjDWPcpYG
    Qrx+ohTSNnfMRUw2lnSUp+klLvlr2l6F4qsv7A+UHXh2n8F5xNoLbAw5yBVQqUI7ZLQrdp
    1yEJqq8PH7aszylXDIwcpOMAw6n+P1IrGiXrKrX+IkEt5nsC/nzcIXPxCH6dAC7B+fmUY8
    cumTYba6RMh/XlnoFspcUMejcXC4OXq5gbCgT9UP8iDMao0ZLuK+nIxdNMQY4eW/cDJ/MN
    flQq0ZZuzHSUGyk86UAPoK9nm0rXglfUZdeFvQ1mLCzH6y852zj8jY2nEGoQ
X-ME-Proxy: <xmx:hRXyaur1iOAFdWojyV-SFMRA8OFFYGJFS1ZnZYNP4HaaNUkaWLSWNg>
    <xmx:hRXyajhsWrFA08kkSZnc9DNPsrcpEdclP1gKY3bF9cQha1GhDkgDPQ>
    <xmx:hRXyagLl6x5CFt29coWocdwZvw41MCBgRWRsbM6DxJZiXjynRKp3wA>
    <xmx:hRXyarBX22EJ-Pxkfrdu0UogxDXTAksV1EX3rFeP3NIuYxsmhJHNWw>
    <xmx:hhXyasQv9MMMdOmxSPvql2j9PdW4Tof_gkdbM1GANsld-nW9uMYlT60B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 13:48:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #03)
In-Reply-To: <87pkwex9bj.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Mon, 09 Nov 2026 17:23:44 +0100")
References: <xmqqmrrlfzcd.fsf@gitster.g>
	<87pkwex9bj.fsf@dev.null.iotcl.com.invalid>
Date: Mon, 09 Nov 2026 10:48:36 -0800
Message-ID: <xmqqwlqlzvqz.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ps/grep-recurse-submodules-fix (2026-11-03) 3 commits
>>  - builtin/grep: read ".gitmodules" via passed-in repository
>>  - builtin/grep: read sparse directory trees via passed-in repository
>>  - builtin/grep: read submodule trees via their repository
>>
>>  A regression where 'git grep --recurse-submodules' failed to read
>>  nested trees in a submodule has been fixed by passing the correct
>>  repository context pointer instead of relying on the global
>>  'the_repository' variable. Additional latent bugs where grep_cache()
>>  and grep_objects() incorrectly referenced the global state have also
>>  been corrected.
>>
>>  Needs review.
>>  source: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
>
> My comment on v1 was addressed, and I've got no further comments about
> v2. Changes are fairly small, and seem not at all controversial to me.

OK, I take it as an Ack and will mark the topic ready for 'next'.

Thanks.
