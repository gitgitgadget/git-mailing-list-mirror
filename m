Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738036;
	b=rCc3F5ggu/+oW2uGGnNSvHzIJiMJksj1Y65qpzz3YRW2/oc1i5u90z50jxj5c0n8byUW
	 RrpKOWiTQrynjRADDhbsNQJ5b2IkOkPrtQUVOvTwLCYYo+7KPdyPAcgsBtXMPfx1NzG1K
	 beBN5sO41OFBFVBq24vVFIx3AaJh9p8KnyZdNKbyAecUTKRYb0jclRusMSSC/T63eQ4V/
	 MzISb59rTyc8Vq5mujSxL0NWzQ416gdmF/heoQJr5phOqsMRkk2E/4bTUmMz4eBfHVV0W
	 7RWvWQ7pqWUP7Bd1RxUSb/1JoX3VEn8ENtfaOxc0ZE4e/kd0mXqDVLgOWXVmpghR/tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738036;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=f2K9mhM3o1PGtZncDST+UaOfAs13Qip3msrA1Xo/liI=;
	b=cDRHxtvHrVKEyOMTaGAf/3xfJ+owKRxxiDypyRgS5/CeSKcEEGgylV5BvtWszO+yXEGg
	 nflIbj8qf2AnOb/ncbZDAnONhpCwVJfhXBk84Pwiwt2ZLx56BFv/qD1Xb4Iesm3c3WWEr
	 QI5PqdHCI1MCBkuKI/KaEEZ06PbDc4Y2FhgQ1eKwlhGfwxUVi99GAeJM2Bed3EDTXccnJ
	 iOiA5osJJdMYm2UZKfl1T6gRk+nluL++eizZTM2G0o57625wxYw9FLFb+6p5Va8tELTfW
	 Ni0tY2Pov3QyeUX8QCK0IposfPN1lUgWmEs3jDlO9D6FL8maFdbL/7bk3c3CzkiSrOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NM8NAWb8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PwcKVlWX;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D4606D804
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 20:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F7D4606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NM8NAWb8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PwcKVlWX
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D95CCEC01EE
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:33:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 15:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793738034; x=1793824434; bh=f2K9mhM3o1
	PGtZncDST+UaOfAs13Qip3msrA1Xo/liI=; b=NM8NAWb8+jz8Q1wfgss9U43Yra
	sQQodANrIsxBMzYbMQ0l9BHBBwTvnBVEyjIXNYL2U+ksj2lt5g99TtUqWD8jpbIv
	/Qz73iWLHv3ddK4cKXdFMkpRlHNLrLavOPkYybrxvJweQnErTY5sSxMrMOywI+EO
	QRnZQ0l3v+MhZVG8kdzxi29fAQ2QY3JLEJ2vDLs0uVvL4QpUNRaqgQElqjETMdik
	ifJS8QerNcO4i49O5S6kNs3rAkK5Vv9kiz12JEUmkIlUdByudm1pdKZiU+LMJFQG
	fh6pEW1LC+ZK5ngAjI05F2Ydvv7Bh2M4Ok6H63xFwk1afzmnrxcEti/SGz7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793738034; x=1793824434; bh=f2K9mhM3o1PGtZncDST+UaOfAs13Qip3msr
	A1Xo/liI=; b=PwcKVlWXzq6M5shk+PoCK9J/FBQfLf8d392NBBJXCTYX7YA/zfr
	9O/mq+0gP/pR2inxfWAnTyXM5Qy70XFmad2iiwI7+NIjPDzuoNfHTp6Tv7z6ZAyp
	BlNbq0CXqEiUlNz4D2kn8s9KcTftHt+77Xu6pE6XUa2/6P2UH6u6plXNx1Z9tTpM
	KAnJOSr2ZIR8oaFD4IhCiqQb5AMq5ozOkoUMq4S8GNkJwp7oQuxCqqN6oIbJuwtS
	LL7ULQlA/vIiVqAEweuY5lB1oyifHHIOAmslKE5HIUMZ42GTj8DXFrWvJsc6V6PG
	kAeXijkWBIj/N9E5G4xac06VKEmr6bu/rqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793738034; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fGjJGNlSOS+J8MIWG7vd3kWsIL/q3IdpUIZp9m2MHVqTTHb
	/luLYcixK3gXoDvwfwp4ebNYDPlyMo892w64InrsybnTfOV4a1z8DAQpy97kg01B
	XpeVkfKzWNXWP2lPfJ1lKYtPf6V7G+IVgy3b0dDsK7waJW1srMesQOyPy0DcCfR5
	o7OkMCKKEL6MOc6TkaR9KENmMm4Q58hpfeKQZuBzJ4kI9cz8y7AAvdNtL4SL0Hue
	MA+vpSd2kbJmDqCk/dJSzOfaglqUIWUd107zOHk+8iDMLoiIGlkwuwCWZSKpWU48
	SslaYPrUxbbNZlYeDCS/0cgqMpayAwzrLEZiXjQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tRaJLPEkT5Fr9Vq5nNjXMa1uVJV9CYtMgeB2BENQSc4=:iz5qSI6eyXoWoJmGeaPf282y7mkAO3wOvRNpmsVL/5Y=;
X-ME-Sender: <xms:MkXqalL-4JIp2-0lUvEnfwhtk7_8HjZ-K7MjiJ_p3anbkZw5wkOk1Q>
    <xme:MkXqaoDbDlnU-qykSCni0Q_I24mpoauBtzMPJpLQBHd9lZfJiLax1TH7zuvWPH6Vq
    2oQKSduvSPIQUd9BhD4BUxU5NYIujJqgQdMy8BFlrEmz0TUD-UBnw>
X-ME-Received: <xmr:MkXqamAIm0Gaz4fWl-I3NrAeJbgAOvjaFGr470mG0wvhUDOY2iTrWyZEu31K9yfXeCD4jqLX4xg14mzFTFsj0fS-P85iyQp9AlUQ>
X-ME-Proxy-Cause: dmFkZTFoRsyOzKpdwgM3PeeZ2oQSqDgX0yCcMGmY3sLgNdU2ZIXG3QswbdnIAlH6Wyz/W2
    8Dnpwmep/Rx/sM2fbGUHCb+/r7MBdk4G544mBuueSW1RHHVMbK9WPQTOzCIuu0ClkrjRi/
    yS5v2+3PeaNx3OJlHKglEzrtg8jUGLSglFw+psC9Fw+p6a9rWdpUEkrWMFxFj9cri3kV8D
    CD79MtrnzW2VlO1ECicwa5PadDub0HPtrj0eR7SWTXWLIz28IPoF4yphbwpSBF4FDg3/A+
    uL4fVzkQPYMFwsZyEfshVpf1k9/Bg/ZhDgWr2Sh0Zysux+3SHX8DEvbiwn7Z+JyH0duqsi
    GDPQasfoA3QsiD1dAbSCLWsAQA1X6QbQLt9q3s4cOGtvSiLQZDoM8do4iMr5Zk8eR6LI+d
    GpEn7jg451G2YHfkWpFOZ+tmor+pBX/lp9yGhbvFcI5l/vKrNYjLFkiTU8+wCrBKhFEW/4
    Z1KgLcQwXMccqXZNjjcNu2dH42FgJ1xm7oYMdUuWzGdmjMWYHIEJ/3zkIIelDYEx0Bb0hO
    I34/Y0xLTfgL2sSPk4gANoqt2xvdLpT7NZ98RCzithyVGPEps/wYE9uD+jlS/bkkf+7akP
    cwlXEZw8Wq1FW6JU5E/b3jSOmSgfCk1k1JwavirD0Zh+VZHDGS9A2RRYHuSA
X-ME-Proxy: <xmx:MkXqaiD7qbYHCDD_tglxrx0BQ1HJiFHrirPPwp7-qRJ2ReK8uiorrA>
    <xmx:MkXqappplPQNFNeVgZeHzZ5tpAaLyP_p12MPIiADOaTDwy0PiFgb4Q>
    <xmx:MkXqakmsBWTtXh-lqrqCIuGc0VUkrA6CofwvKjqMb9iULb9TykXZZA>
    <xmx:MkXqahw5uSb8MbgNRQnCm6TJYWQUt8zqagV7reIcJ0qcvCn19mitCg>
    <xmx:MkXqapDvEmQR3vNDMo9gSBfXyuXuccfKDJs4dcIoyeWKfMRjHPlFZkk2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 15:33:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <9a6ae876-78d5-4513-8c75-c4c071c3db6a@app.fastmail.com> (Julia
	Evans's message of "Tue, 03 Nov 2026 14:52:16 -0500")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<xmqqbj857l9r.fsf@gitster.g>
	<9a6ae876-78d5-4513-8c75-c4c071c3db6a@app.fastmail.com>
Date: Tue, 03 Nov 2026 12:33:53 -0800
Message-ID: <xmqqtslx64em.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

>>> +|Show staged changes
>>> +|`git diff --staged`
>>
>> Do not sneak this change into an unrelated "change the format to use
>> table to make it readable" topic.  Doing this change to just this
>> single example would be a severe regression.
>
> I can change it back, I didn't realize it would be an issue.

Changing this example alone without checking its fit in the wider
context is what made it problematic.  I do not personally support
"cached to staged" because I consider it mostly a meaningless
churn, but that is different from saying I will veto it.

I just wanted to see a bit more consistency; without changing the
main text, the change to the example made it look like a very odd
thing to have there.  You see the option named "--staged" but it
is explained nowhere other than being a synonym to another option
that is much more widely explained.

> I dropped it because I wanted to start with just the commands that
> people said they found useful, and it can be hard to introduce
> too many "new" commands that aren't well-known already.
>
> That said I think `git diff AUTO_MERGE` seems useful and I'm happy
> to put it back.

FWIW, what is in the current document was added by choosing what
were found useful.  So you would want to think twice (note: this
is very different from "do not change") before removing existing
ones or replacing them with something else.  After spending a
significant amount of effort on these documentation updates you are
making, if a new person came and rewrote them again without
understanding or paying much attention to your reasoning behind how
you arrived at your version, I would imagine that you would feel
terrible.  Please give the last person who wrote these documents
the same courtesy and respect.

Thanks.
