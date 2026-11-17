Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939093;
	b=OSNUYwlmMkHYo22vobtyhCPdTqKeyCS/B5feHCJSR9r8STOfBcJoCrqzGkiK6XLlwHm0
	 w+n2RHzgPVOzJSiSaMkqicjd+9NWdQ9Er4KD447U5YFZzAQIRBMMcMZ1OKzN3TMe1kylA
	 5gIpnKrKdq9eh2G4Yt5ij+M9q0K0akowxbkdZabFQ7TXXrER04mtxUwcN+PJ3SyZpaLpb
	 kwhlTp6800GxcfZipQlwT4+CiPZodUh/ICNBlGSjw+6y4hHZTcjTcD3x3DrKU255Lbmis
	 u5W/G1c5v45sdXVElHRjwI4jdV68PYqqJVMpVR4pCe2ldzfiqxqQY0x8LYxaFYgA+5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939093;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wXJTi7QZBkJKIQswppPlMDYK3ozNgmcdlWIgz93HUNI=;
	b=faZHgoooC70ygvWuo0Ra9Yx+OVBmFCmfZS6SDhbIE8i/C2+gCD+voU6vaMP15o73c0G8
	 ome/p5f+x47uPPNPua/mnNzIoBI0xufoMpG1RXqLZ7Zdo5kJV9rwKUjd9FllaQVyrwIWT
	 UOih/OAebj3LERFqBQ7FMndSFEVqWogDBE0Qci9Rcb7ngEnJSvHBXX3jcHYoWmjT3kqAq
	 5sa04xz5LTPrvieXJI9hAmvS1os7JF06y9CFJBkC6MiIJRHcMd4f/CNATX6d/IitmeEKE
	 2UHNBJ7DmW5CyYBl6Z14AF0A713qsdBY4QcJnTePgNBo4vp5bz+lj/6O48vij8w71GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=UDVgRrqo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Kq1kbMOY;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891A606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6891A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=UDVgRrqo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Kq1kbMOY
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D156B7A0254
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:11:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 17 Nov 2026 13:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794939092; x=1795025492; bh=wXJTi7QZBk
	JKIQswppPlMDYK3ozNgmcdlWIgz93HUNI=; b=UDVgRrqo1dBTq50Op6JlUopg7+
	i9i7eI48PgpcOCyC9EgMgdsglQBrK1ieaUq5YHh6+shKLBPgIHBOw3WYmA7mSuGW
	N45nItC8ogLxKg7aMPVt3SejSVPGHzh51J0bZL3o9vAgILK/w0C+UnZpxCoiK6ac
	eFq3xSXuEXjzo2CGDRWg3RXKhOwhCBs/rqMKLNciIh+a0rXZ4nKuGc+HYGY4AKuA
	rE/5aB8DtMlXsvetBoBCG4xF0tcGkeow4oSe5q2EQbZ7z0v6JVnjBaqcoYecd4b8
	UOErl616EJrfRDbVmdtnGnn0VfYV3Hol8daB2xOxtZp4niT5DYj5dGJglGbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794939092; x=1795025492; bh=wXJTi7QZBkJKIQswppPlMDYK3ozNgmcdlWI
	gz93HUNI=; b=Kq1kbMOYtRG7iIq18EYfP1minV6i3awpA4VDqA9flHkGIC8JB6/
	eyIwnn0pWtBferGHbl2lbRqQqgkPPou+LIntjB5RL/P7G+6PIou4NjLEzoLD0n+q
	I7IFNC0MZxLMLodqmRv4HJtcYmkpzESMR656rLlVELIbGk0sOllfxyDveeWpwROh
	rV1XMkWZIGYFx882M+Q3334TrmMKkIirvLCVwSMjjkmnbHqWT0R+EveHnyJqwGa2
	9TCp0u1vce7/fChTdwyyIk8cZv/FffPFYsRwwG3Hf/XfEFJNDo348lStTD7AF09t
	zE8i4LLlsOp/Dqd3CsL/UBknqxdAo4gpGoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794939092; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cPjhXXaJRhLV7TUzxYtO1gsqmo+PtPPHAiRUuiQkOH0z/or
	x1rwLsX37cpe5lIXbeo6uHR7g2tiO4xBfOMD2AL9SPV+sPZPQcINIfTJndH9k+PF
	BY1csWYC+h2hGh/psJLfNcVfAkrx1I+iFz04hV8LrJEr+nv9RYX8EYB8fu+GdjlA
	rNlezZk6jSR1VwGYF7+DyrzyfBIvdEjYejH2dK5vxc56bjfm9UL2gGnt5JWxubrE
	QsAWQnt86iwEArDLrbaRpP/p4UKMPWyqu9Evsz/92caomVfhEqYNoddtBbyqI3Qi
	jLsOGaRD0Pbgk9CyfI8O5b6fDKADhZ5/fQl2KyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:z0/XWp9oNh0f5f8R0+zQoGdm8kobc2VUQlgRuQWRHBc=:RJ3djz78djgQ+cYcxQc1ME4+Qz4G2Cr1dbUS5NKlx1Q=;
X-ME-Sender: <xms:1Jj8atR3Umc3SrKC7J38Ghf40JxFxguFgT3iBBPCzuDcf-VNPCNDqA>
    <xme:1Jj8auN0BxfnxUvXCeCDobEQUob78Fd_ndHZNJnlYjvrBgPSbzGO3wtscBQxiiRCG
    OaJYWd6biWt1mtELn4shbmQblRb1u_oBRfnYEmitTLdnaYC3son0e0>
X-ME-Received: <xmr:1Jj8agO_8lBM7OSqWHccj-0Y32jlJSjiMFr1AQe2RYWwpTssHJ2STKUrSGxbsYeNEr7J96wzfG0rJ8Q7jcTBSB9bYXN4Pcrf9Oti>
X-ME-Proxy-Cause: dmFkZTE1vzcFaqx3b+laObAJ/6Klq6MySkb8jVdV1T98IhhA+cWaag8QbwD8xXYb9z5H2I
    Zsczl43WHcKs5Q0cJYdLmxXGrr1MsS56KVJrRvj8qBNQ+pb7psPpkB9Pio7cOs59aZHObT
    5CbX75q1kkOE/zzARrZPL0pmmkEQIHb+zut5dSKIk5cf97asTTvfR2lDVDObOpUiG72x4X
    a0oX4N7pQmo5DxiFfNk28yPDtkqbdk6ZZzW6c4bWYfOzRSjuN4CrM2jLpRGKcGgRG7Flyy
    AaaVONXi54uyfQ6OpzrYiAHetUMi4NOUWy9kR7Cfzd6nRiahCiJrD5OrNYl0TM8NS7ZaXn
    n6IddStutaShcr7gU88hgceB/LIQ1Wa3xU2/jqxxfjmdCu406ewlyoD4kd0VFE2n9mq5SR
    GIav1HRtu9epLaHBE6lX5l4F4cPru1yP8N+9rPHRH7vGI2y0YkY5NwVMk/3dFQXSYm27B8
    fStNLRomx94qtIBtPqRiXiVlmhRTURw71MtXWYLyo9vHevH8ZZQXnbM6KDSRUWbRpfJM+B
    As37bVkDQBn7n3QDIA+ZJS98jBaqbKirj5CrOPYZT/41mlcL2aCDd08WmPBflOKq5uqIBl
    QddLJo2PtfMR/k+M5ZB5P+2hkZ6tZNzcq2P94fxySnJaLjeraS0FsM40V0KQ
X-ME-Proxy: <xmx:1Jj8auuJhiguqNnsTdarfEd0GBKuQaz9R0bOx0KW47RSaqpl1K3N5Q>
    <xmx:1Jj8aqVWN3qG6x73059KDSmTDAxrSgaM9QnI09K04JR6v5VdKe75eA>
    <xmx:1Jj8amujFcJ0NhqymSjIcEpKCgRNzTlM160SwAF6d6zghsWeDJV9Wg>
    <xmx:1Jj8amXAf_JdHQ-UzNA_841ufkUDigCwNcwp0gJAhmg1DEdfMVlGkw>
    <xmx:1Jj8as3qrvTeqWZ9FczbTQrcI1cmCdbFe2L4IOc52BcPu3Gy0KGZ1zKP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 13:11:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: respect bounds in utf8_strnwidth()
In-Reply-To: <ghbj7nmjd7.fsf@gouders.net> (Dirk Gouders's message of "Tue, 17
	Nov 2026 18:57:08 +0100")
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261116-master-v1-1-dc2a50ce0aa0@gouders.net>
	<xmqqld6siau9.fsf@gitster.g> <xmqqse0zfn2n.fsf@gitster.g>
	<ghbj7nmjd7.fsf@gouders.net>
Date: Tue, 17 Nov 2026 10:11:31 -0800
Message-ID: <xmqqa4n7fhv0.fsf@gitster.g>
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

Dirk Gouders <dirk@gouders.net> writes:

>> An update to display_mode_esc_sequence_len() to take the length
>> limit, including its fallout, is shown below, and it does not look
>> too bad.  Not even compile-tested, but it should be sufficient as an
>> illustration of the idea.
>>
>> This does not make your "after display_mode_esc_sequence_len()
>> skips, make sure if we still have remaining string to grab one UTF-8
>> character" change unnecessary, as I said.
>
> My v2 would have introduced two new functions (see attached) to replace
> display_mode_esc_sequence_len():

A two-function arrangement would be a good idea for maintainability.

Add display_mode_esc_sequence_len_counted() to use the counted
string API, with display_mode_esc_sequence_len() keeping the
original calling convention (i.e., we call strlen(s) then call the
new helper).  I was too lazy to do the function pair in the
illustration patch, which caused all existing callers to be
affected, but given that there is another topic or two that are just
being proposed that would add more callers to this function, it
probably makes sense to keep a function with the NUL-terminated
string API as before, and add the counted interface for callers that
care, like the one you are fixing.

Thanks.
