Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025879;
	b=ueuJ0+dhyJGb4pqfnnBZs69W4IKjCQahsWmZAJBD1Lp5pjJ8o9UKbSTCtVevwh6privv
	 mB43klnK0wdZxjkjy6tlSPDhNEDc/tpUiYMBKjNXOpWgQVutKfMqXvRssBMZq/nPkfL+i
	 mu30szXSgt/LPhEmVusF39Tfzvgt670+ePoVOHGPxBR6skcFz79e3jvE9o7Fzc9nHo+Tw
	 k7zvxbNL2KazgbPMSu0GHrtlm2+/dC5bkwUMZS0oU7Av5+KBMb5J3xPuv8fwT1XYuQ0V5
	 yyTmEC/Zr7qx5K10NbrXWoVliUEVCCBjto39jeXjQM/wlv8krS1POPZotVMfruv2WfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025879;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UbMxOHP2aEkdloT90hQS4x2b3jNvJ4mJJ47ksT1or/E=;
	b=OQASHBfiGljV1mttUkCe4KaypDt0KaT3w5WszJFmi75qB8N3RwuIUWfZwCZGd5WByEEc
	 uwdGF5QMVVuJnjC7qpXsi9+vguwrBXQ03bi4rUr2gLRvRqw0L4HiaA6wxrPshv55iJbul
	 J/gkDRJP8Ie4BwJXpcengoRA0iI1gee3jgFaayRgVN3n21lBaMe4wB8ON2IP3/CLPnJLO
	 FKuRNYtrlnY40GvLu+UBgDiAUx2fSv6CxWisexcQ3LFvd2DO7SEighVjafxkkjDXQwtnt
	 LqruwUqoU+meyUXKZP4Truv4S/nVMbnO2r6r7ywTpDz9ytjmqDFpWLwh4wuqGPdI6aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GC+3KhKl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UrbDVnPm;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF2606A32A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50EF2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GC+3KhKl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UrbDVnPm
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E6D0EC05BC
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:17:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795025877; x=1795112277; bh=UbMxOHP2aE
	kdloT90hQS4x2b3jNvJ4mJJ47ksT1or/E=; b=GC+3KhKl1xuLomKbzLBESa04us
	0DMUNLQnZd+rQRHd0Mvd3h0UQTRorG3248MlWVLkp6EzUBDBwHiRoMo/BPW4KDX9
	zFuccj/rsZGIxVIjYxGc4SvgiiKGf4COMJgpb/zMqVKGLt99Z8tENjzohcnT7Plj
	P6KWRUIlejSfc78TYyq9SMH6G/9ZoT07fbGuW68CsjfTTFnBVVoVAfwoc7d2Uo28
	ilFzBZ0NVXEUhObSvxGJiJj9iQs/xXdvjnwq4lgoJ9vK7fbZcZZWeGLoiRiYl4yA
	3KhQeA4fUXydLjJUVdVEZsi6d9EAz1af75CbsPQV7GGxkq6ejf1MOOiALRiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795025877; x=1795112277; bh=UbMxOHP2aEkdloT90hQS4x2b3jNvJ4mJJ47
	ksT1or/E=; b=UrbDVnPmGzDCVOoDpi1zrBJoKK3knEr9mYszmpJXmXOrpSillrl
	FuP5/5qeiiBpEKg9mYvz2MVdwz3PYGl4rTJh/F8KJCZflmIKZG7Yu/AOJEhBE7Q1
	scOgssB953Mk12X/ZBArjBZ4R5sIGCvUSvWmLu9uQA1BXArRwquaCzSbUSpvQCX+
	eEAX9X6RswEWYy2/1DV2hcSktGuEp50YF9GHU4WRKJ4zVCgT7h0T/ANGrvLeNDqi
	EnUemevqW0o4gM3nmegtdXkaobZmINVDJ/yP7CeEjKlQ7Qj5R9eXKc61+RamDvDZ
	60woSVcdOAEMeBTlesHbqYVzv4a4i5EBkzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795025877; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TjTGGosUWFLKBsUVf+MS1cVYT6dKdXcdQ8lWUrtGQ/cAkrz
	NF0VDcjeTNs8GDFjhmXYtLcRS/uh9MzCMQTkEkAmY/k4S/CFTqLycbGpk6w/2csj
	pO/iK+si8VT6CVJAtEDE567uX5H3gXmoRTI3tH8wN9OUkyeTMvfCR2/QHbrhOZye
	eKAe0Xet3BjwNog+896vFEKE7sMOraOEy685rrQ0oQ6aXQ1hxwSW/nlSsaMdOnN9
	dTvCMnpClf8b8wrdxIZ+MGw0L4Gb2KvbJKbOPyh+uZ1aTBxoFcTIRZDqka7xVppv
	wXexG74ZyppLDDQnmFm9pxqBph0xr0jDuOB/CNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:n7RjdJ/QSOKp3SKg2/OfiJ0/M7UDJ2M1Kn8/H032ruk=:t7BsCIoN6F2VFR2lHLvMteC+HtTUq5dwqRuQE/lumWo=;
X-ME-Sender: <xms:1ev9ahGHNMIXyrK4s4Z9-CysjsWe9Vmqah35WL8KDtpMk0IGz-O9gg>
    <xme:1ev9aonMMCINzoIff9iVmWt3AwGdmtfPep1rMY-EhoD0n_RLe8tH12BGF7_dd4E__
    446HuG11VlWVhCfgfMnihZPH9iXSYgo0Ck8YCwFmb6b7KKNST6avg>
X-ME-Received: <xmr:1ev9alYIGq5QdpH60JKbHlC5rGTu3u65fIr_UDSY1EQbp86FuGISEKqbrkhP-qjin-GZ-rAAuV2fDFcMDpwHIHzqQR64TQ9FQqgw>
X-ME-Proxy-Cause: dmFkZTEmv3ca1KSBpSSLiwQPNGMQziQaqhduKmLWUSoj+y7T9kk4/LZDdC2ZhUPjxusIB2
    3NAD4PvNZC0/5HCZkhU67lxIgku67enPBKm6mR8gUfMaot9Kp9D906HweChowiin8UA7cE
    vTVq9GO6+UVOWidmosnJfvj6IDZZ6Zj5WVsWkLvNtUcqAgmiFR8ITCUlnJBAsIjzOZJMVr
    8UX9zlpXqwAgRJNU52gxdn0WQOgzgWv0pLoznYdOvYZCC6q4o9iOewNpgL1lwbZPAlqT3A
    +E1RMHFK1J/IUbdW6xJfG5aAPQfYe5pPpjgCiVEtNyMZUDxjrp6b9h0bSQAqcUuqZyucL0
    BR1SWQBE6t0PSXf3HVbdHH/yIwY3BX0ZvKoSuoK+V2wD8Qr9xx9UhU7med9SBPvDx/pfrS
    DeVyauZ9FLdqRfz48Vw3ur+16MpyfGt+iCmcH6dpaf+GmlfPDEYskL7SPDWDs9BCLtiKqk
    Wqi0Iwj45VkEKDsqsfnQG2Re2o5a56Zg9vXH0kTSSX+IPlZdowesERF1s9hwxIZDWssgO1
    pZW0hqvTYxHd6euE6l83qX82sDWhqZCWnyvvlf6m51p/zozRhMomzwnPvs18gxVUPwl8ff
    5i7698ZYTb3RB+w5N58VRb2pwTtNtJqmSm42v7vJBIDFN+E9/br5+C4yWWUw
X-ME-Proxy: <xmx:1ev9atE-ilbpXv9J5I0foGL1Ht7iDZt30o0uq55zNre8SPEDNyILBA>
    <xmx:1ev9amJZrXuplnnGD5wQjiMIiaMQFLQbzSEKFCaw14mCmkHEaaTWyw>
    <xmx:1ev9aoN6whvAPK-XKulNtCYcNaUy59p3GmEl5xbdHbAv24wMd8Zl7A>
    <xmx:1ev9amk3foquNyVee1YzJVc7AO7BSXZ-yUnSxBXwDHeoDE2xttpe0w>
    <xmx:1ev9av2SyZa4_5wYPFfWvpCBWGSyfVeLjneAcq0pjccJY6YUCB3uqzTk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 13:17:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?=
 =?utf-8?B?w7A=?= Bjarmason
 <avarab@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] object-file: check size of inflated loose object
 against its header
In-Reply-To: <av2YSgkd2fUNRlNM@pks.im> (Patrick Steinhardt's message of "Wed,
	18 Nov 2026 13:21:30 +0100")
References: <cover.1793355390.git.gitter.spiros@gmail.com>
	<cover.1794914210.git.gitter.spiros@gmail.com>
	<edb5f34498e91beb0480d9b6ac417602580b3016.1794914210.git.gitter.spiros@gmail.com>
	<av2YSgkd2fUNRlNM@pks.im>
Date: Wed, 18 Nov 2026 10:17:54 -0800
Message-ID: <xmqqbj7m6m25.fsf@gitster.g>
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

> On Tue, Nov 17, 2026 at 12:38:54PM +0100, Elia Pinto wrote:
>> unpack_loose_rest() allocates a buffer of the size given in the object
>> header and inflates the rest of the stream into it, but it never checks
>> that the stream actually produced that many bytes. If the compressed
>> data ends early we return success with the tail of the buffer never
>> written, and callers like odb_read_object() hand it out as object
>> content. For example, "git cat-file commit" on a loose object whose
>> header says "commit 200" but which contains only 44 bytes prints 156
>> bytes of uninitialized heap memory.
>
> That's certainly fishy.
>
>> The opposite case slips through, too: when the whole object fits into
>> the buffer filled by unpack_loose_header(), we copy only "size" bytes
>> out of it, the stream has already ended, and the extra data is silently
>> dropped.
>
> Hum, this part I don't quite understand. Do you mean to say that the
> header declares "commit 200", but it actually carries 400 bytes, so we
> only copy the first 200 and ignore the remainder? If so, why would the
> stream have already ended in that case?

The opposite case is that the initial inflation into 32-byte buffer
is sufficient to unpack both the header and the payload.  See my
walkthru in https://lore.kernel.org/git/xmqqbj7ndzi7.fsf@gitster.g/
and other points you mention in this message would hopefully become
clearer.

Thanks.
