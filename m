Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650567;
	b=z6/VhifbN8eHKQCti7ngBY+Jjc6kBzi/cbzS5nIBE7WleZiig2DZfJQdaYnSaakRo2z1
	 +OYWulGmWN/wlYu3ZYBINAsqaulHGZrZjXyI/bqXMYkeJUwB3DuBFRvPDPX+PXMgHdvVk
	 T9WBx/jVkQY7rjT8f6vReJm+H6x7cHaj7eraHofChkZuigEsKyHPe9N8JVBBMe+KO5AsX
	 EbCwAewCrzwaP2bN5H0T1X19SQPl/IY+VJuiQrCKCzusBcDwcI6xGXn+eRGM6JJSLlLKe
	 0DM20WW+TXyroLRCTsofZaXiZFQWbA8uJLtBuzSpaC9/+O4FFRZXyflZ7/mO2ODpfsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650567;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cuPinmhF61EDqRcUwuTihyFDJJ43zoTzHttGLskv6iY=;
	b=QucUkcpO3s0otGNFXMQEps5a0QR+AxRZ3CqveECTfGmsqx+0qk2n+7cq5Uk+D0AoN9i1
	 MzVJPmKcHAnallwlB1W4dV6iQfVvcDBLmqCBG4EappthxvNqTHbQBCxXjnhheJa/OnPtq
	 5lHrdHPU/ZO63+a8C7JEsk541tvXFMfWgeVoao9sa9rbHuVUm6MnARcit/IDvzrF5pv/D
	 SgEctWX+fo2EuCN4KYKlZScdql04QLERwzOj3Ja246h4xUgXLQ0sG1t4jIIxTRlmZToDE
	 taGV/1RFvSZ1bj2BSV7HD8oY3rRAMyqmiXqDHS4jVCrjzk1HFn10m+8UsktAHUrITjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FJdp+48b;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CyjUG0p8;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152E606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 20:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F152E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FJdp+48b;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CyjUG0p8
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47F8F7A00EC
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:16:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 02 Nov 2026 15:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793650565; x=1793736965; bh=cuPinmhF61
	EDqRcUwuTihyFDJJ43zoTzHttGLskv6iY=; b=FJdp+48ba6drutjFO9cY8iZOzD
	o4mIKfxDeq7zHmsVug/S0WH5TJsRuuWCeoyZMF1xsDy6x8L3+RyA/ZzB5Ihxcg4X
	rUo39TIpyRf+K+tSxQeTAv5hrsSctzC9zi+n8lhOgO6TiTh3ZKtDPu0TNUizjr+R
	iKW+8ug26TdlANfezp5NX+CQnjsjxr5uqEK4zAhyrhjfYi+Mkf9q1OwPzztXIx/h
	3ab02TcezAeoc8dS0PFKemJ4D/32lG+CSrF5hefF6P+sk3MeTd3FZq85BVvJn8Ct
	Qjusm/yJb1uKyGgBH6apCQb6qkJq+SfESPl6+th675T3YpcpM1u1+cyNqdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793650565; x=1793736965; bh=cuPinmhF61EDqRcUwuTihyFDJJ43zoTzHtt
	GLskv6iY=; b=CyjUG0p8k1mc5dQyQAR5+hZedHiEqhwB59Dus9ViIbZTR4b5ioK
	SIcNBWDGlP5quQ6xoUHuw4pskttGhqnC4vABylFtJekYoJyMvpKFko+h/VwwVFh+
	NvVvOX16G/PyHIPMJyykd8QhtW2BaF0FD7gMT0zOjJCSHmET9gQWRh7K/p2uJuN2
	nrhTcTylnSPQypMHMU2/pE3TyPZ7aZfwpUSBlorn/SKCxVFGrL2osQG9BbNiZ39l
	b9DWLnbMLKnjlEzzFli5s8KU1Zqq6uC4h707tuMWBsxLkNKy2CjUEdG034aCewTz
	4ctC66oZHtHxd0SXmurZXpDCWWRPlv0XvCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793650565; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MM7kWDYLNj0oPJPNf9cOpJXwhSU6Gg+7gS8lYPVjDG5cAV+
	3d9H7NQOGK03X6mcjNtC4io2lHMWVdh1J6q5XejqfjOPO1sUcYRMwRk0parVQ7Ur
	sAWPJfWyH4hVa+zmO3CIji3fDULX+HynBtb2xddCod9QI1Ym5aoG85fSNZ/A8p8f
	dllT0N2FbeirjdmJnqhHevGAxuM/i/PXYV3NRHQSeQUGp80e4pxV/1q8qaJqbUjf
	62+vLeDaqQchBKrUBW47mgaNUV/vgm0bY3itrYez471v+CaqGEPqZ++pe/d1h1CG
	/+XDYzLGE1hG4O5LIE98I0Z5Iiz2oJt2pZtJMWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4XgGNd65zoQQipHQpdCxSE4zpWGRHeOQ+u6xYTfrCBk=:25lOWizOEF83VzECtWylhC+bAYwouYa/njcXYI2ry8E=;
X-ME-Sender: <xms:he_oavUC4Q1-EvNDYR4JZeSPZ9duYt7gHY_dcEt5rdODKTSnG_iecQ>
    <xme:he_oap1kIEDHufhRyuNm2vk3nxUnVSbZFVKovtUcDUammBoJD4DNfLssUK3e-STs1
    uHgkxCRdkvnE-oQotHWM_kPKnTN0SWql5xFap_c_ukBwhGugCjZUhY>
X-ME-Received: <xmr:he_oatrALzob_m_cbtOLziwuA4fYToA683MR04cUhMWoCEEhCH1-mA9Gnde9AkMSJlXsS1jTMDVmmfRnaNnxgviCV0-7kxYgvcbe>
X-ME-Proxy-Cause: dmFkZTEfLKd/69oH3AYePuENXm86wZs7OzQggrbOWXhyQq32ZlMhnsEBmG55H4RrPJlO+o
    ixTSvUhsbpwt0BfvCYDBm0F7a/01rNJ+Cadkl6uGHXkcY4Cb2gGbl6FwUuufNwMRhxTsJi
    rsjQU50uXVgL+w1easgQf6/w87k1lDVNCtLSAOW5HHvT7n/bHGBoaQNMviAE38fDNcbb2c
    0UebuhDLvqwGzYB5M9lteKMsgHAxn6YBDIixzSRrJxC4ZxBkZjNlduHGh0fUctrT+jg7p9
    On2ctrONPPCfFlcA++fi1QmySDKxmemc9r8qFjoASzh0qn/UO1HOdDR+uH3M9WtGv+o4md
    8G7smyBXgkx1r3KE3BzaK57jGk352OrMdKBHhnpk5LhllNanek27xhWukoAOpeDOZPSz4E
    Rv1FEcRjzELpJbT2C4W9lrQOIXbOcn6ZtJsB9X/6mKP0j50RFhVJxkY5Xepe+shHPVVfuj
    g6Q40eFeAWiz3MBcr7EfqdExdRbDwf91RUw9HrwedIJmYiICOTBnj5dk7r1JAI9d+3UJCz
    ogIPM/Pk6sMfZ514bpyiF4NWSXgafayOdfm69QoDSKR3mqko2nluSJVmXyO+NR/MveAWU+
    CwQNUYvsxDvdjHV/5Ns8CpCUkiKsUXDLCiC6bikdxk5pV10Z7WEHSjpO6JGA
X-ME-Proxy: <xmx:he_oagVnQBHGRz2ka4ONwf673fZUpucTgw-T36PzvJ4ceYOHP2Lf2w>
    <xmx:he_oaoYvS8vfC0G3K1C_Z333zL0RL-notEA5R6vaSxszqom3S2y3rA>
    <xmx:he_oatf_inFH2_ugayqk1SfGLFElF8bOtebNrtKgOG4W7Fep-ralFg>
    <xmx:he_oai10GPqVsDh53h_XDdD28O8OKBPwru6_LOcc3X7Bjnk3kqc1dA>
    <xmx:he_oatFcQEpcifus3Eoy_LKsr0CT6qcA30zTS7Qy5AgBYO44ERM42DGY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 15:16:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King <peff@peff.net>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] convert: use size_t for text statistics and
 ident counts
In-Reply-To: <auhvUm4VwXyWNhsE@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Nov 2026 12:09:06 +0100")
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
	<cover.1793352943.git.gitter.spiros@gmail.com>
	<84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com>
	<auSDKKHJONZjx2LX@pks.im>
	<20261031101619.172770-2-gitter.spiros@gmail.com>
	<auhvUm4VwXyWNhsE@pks.im>
Date: Mon, 02 Nov 2026 12:16:03 -0800
Message-ID: <xmqqzevrgfb0.fsf@gitster.g>
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

>> You're completely right. I used AI tooling to help draft that commit
>> message, and it definitely shows. Fair cop.
>> 
>> To clarify my involvement: I review the code, check the cases, run the
>> tests, and take full responsibility for what gets submitted. But the
>> wording here missed the mark. For v3 I rewrote the message myself,
>> keeping it much shorter, focusing on a single example (lone LFs), and
>> dropping the heavy-handed explanations.
>
> Sorry, but is this reply to my ask to proof read what AI generates and
> make it sound less AI generated repeating the _exact same thing_ that I
> just asked you to change?

[*]

> To put it bluntly: behaviour like this is what will make me ignore your
> patch series altogether going forward. It is frustrating to me, and I
> only have limited time to spend on reviews. So I will much rather spend
> my own time on patches where I don't feel like I'm talking to a meat
> proxy, because I'm a (somewhat) social creature that prefers to talk to
> humans.
>
> So please reevaluate what you are doing here.

Sorry to interject but recognising the name as a rather long-time
contributor from the pre-AI era, I am not sure what answer from Elia
would have pleased you.  Instead of saying that the initial work was
done by AI, and that the human involvement was to sanity-check the
product of the machine and tweak the messaging to reduce the
machine-generated look, what do you want to see in contributors who
work with AI?

My question is not specifically about Elia's recent topics, but
would apply more widely.

Also, I had hard time to parse and understand [*] above.  Did you
mean "I asked you to proofread what AI generates so it sounds less
AI-generated, and yet this very e-mail reply of yours is doing the
exact same thing I just asked you to change", meaning "the message
I am replying still sounds AI generated", or something?

Thinking aloud and letting my thoughts wander a bit.

A contributor lets a machine generate a solution.  Then he reads and
understands every bit of it, writes a description of the solution as
a commit log message from scratch without looking at the machine
output, and from that message writes the code change from scratch.
It is more like using the machine output as mere inspiration for his
own iteration.  I would imagine you do not have an issue with that.

Now, which part would we find problematic in the above sequence if
the contributor "cheats"?  Perhaps he scans the machine output and,
without understanding the most crucial bits, can still describe the
outline of the solution from a superficial reading.  He passes the
code along as-is, together with the description he wrote with only a
superficial understanding of the problem area.  When the patch gets
submitted, it would not look any different from the work of the
earlier contributor who used the machine output as inspiration to
write his own solution.  However, if we later ask deeper questions
when problems arise from the change, the latter contributor may not
be able to provide as useful an answer as the former one who
understood it deeply himself.

But that is something we cannot easily tell just by looking at the
submission, so ...
