Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375820;
	b=X2kRfFzlrvqnoJbobE8n0oDSsyNFQX7+ztyVe2gB9n2VWH3VxjMIZPBd3HcDOWOsYiWw
	 y8TQykYo0zQ1eNF+RO9g5LsfuV4Bt0WYn1mTtpKiAnbtIUjfWG0OU84nD9WfV9Oa48Xr+
	 Qg3bmiiUJpwiqC0myT6ayq7L2aChnuAZTt1huXDc2dyIuEG66F2A0rTCozqOWqcyRV1/7
	 +75qsxt324YueE0i5aItEe308bLfZKHDm84ippQISV8BFkUXqnktcicGIXapRsHvrgfcM
	 XNdaohKFaF2L0w3uPy0OxJPopRpJgzOqpDtFLu/TMl/Dkw1GnCkQryy0epit39G+pEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375820;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=98QYFfxqtN/MSiaS875G7fdGu+uPikGjY6e+yr3N2mg=;
	b=AHWK4KTXUVL8LSZa4ebz2+nDc6a5FJWTzt4UeCreCCCKwthvDrRMK4R/MFkwi1x8X8s0
	 xeAshpa2A4WAW2JrHthY7MKLGEe9dLzb0ABmoaUIuIx94bzlU/APInzOY41xAIUZOVpm1
	 97j9C1LFS4xuK3kMBVSVWgnWk51G90uH+ic6IQEmcJ1/UMmo5PcZo/yhQT05MS83U6S+0
	 AxV4QRixLNEweGz8+ym2Ob3mJKLc/OYA9CD5sqTDtTfNdcMR7d5mr10hSSJ9EwopHsPR5
	 s/IDy0n1/eQZZQOme/4tbIJ9tejErk3TGoNV8Y/Gw42TM6te9nwlS9WbEx995vU24Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PsK0atV4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="Dn1K6Ck/";
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAD606A31D
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 19:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0EAD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PsK0atV4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dn1K6Ck/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F194FEC09FA
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:30:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 22 Nov 2026 14:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795375818;
	 x=1795462218; bh=98QYFfxqtN/MSiaS875G7fdGu+uPikGjY6e+yr3N2mg=; b=
	PsK0atV41vthGyuvaNKAwMDQ5ekPIMAoA/OK74n30+Dp8nwp64aYkhF606G8NYV+
	/iU0uV1RMAu0dDlYZScfBgySwFC9mTmV/Em/G6+pq7eaHjgfQUUS8meJDZIbyjjr
	SxdQxpW3GM2HPxQmM93o/S4IYFTT7n2gbub2FrlcRPH+Eyhq5qadv9GP3qljuyjA
	o8mAfCYYXLELmQkQ7rJsEIQ9a2fK4FzkhoXc95kmbbYariUJeVU3RsMl43vI1old
	1c1YUVOU0PsJAq5CFEKrtLmXXfhTuWfOLq6QGgpJganfZm7uHbRgZHdBEO9p3FW7
	aIZkCjMwLWXCGMHSnaiYHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795375818; x=
	1795462218; bh=98QYFfxqtN/MSiaS875G7fdGu+uPikGjY6e+yr3N2mg=; b=D
	n1K6Ck/8W5z5D4sUhihwyZPZEbGS5b3BwkofC1SAgaTLFwq/twcoVw27AtcMKX32
	qrbQrnPCIVzgkjD9+zfKPLGOxJK/WRxKTXflVKvOeE1fgnkwGi40MUSUztA6zp/z
	pkTNDxg2IvCocaWG+1e4m0JaaZAvmYXPFQGm5FClNjW95OdYcjoRDVEAk9AACIXy
	cHMNyuj+rn9rmCSvoAaHZvWS7jc1bGsn+Hqh/Puq4Ik8WlFjjKRmUo1/Mg3nrZGB
	hqU2v3JoLzv5ev/jPh1FQoGqQNnmMb0lPIUVDdXGjt8AiWyO/7H8m5AIOyghrseb
	uxq9AASVFgUQwg/l/AYqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795375818; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:I3peRkZsjY/mIOWMsYm9V8M+2+PeI+qsd79DCe5h/Ak0uo7
	9kAxO4H1rR8x633kJlCyKAyUnapT0CIp3D1sI6wIW35FasGZzopqbibwLCq4GUau
	1ouulMg+BeS0leDCV86B1G+9JDojgY2p+xMLysKhEr3/+YWkgP3JG/Hoo/ZvfeyN
	nI5ajVAtZMoZjHsgB8fKzThkUGKhWsk1uALlN91h0iMhgHE6BbKpzKpvEDo7x1F4
	84uxAMgevHszJ2ffEu+emYbUATYD843s2S4Ern+PoG63/GiRUOZYOCTQIo4qFgjd
	tMTx8TuaBm1EMhYVCjWtSWGWPS6h5L5e1W1VMRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:qeimbxucCy9Gyo3xW1PeP/TYddNADhdyZKc94HFteBA=:LsXyvlr7uGcBmlXAMybdNJDe816M1xIUjIxg9YUbXSs=;
X-ME-Sender: <xms:ykIDa00_f4AH2-CEDHDxkSgm7piu1pP_hyqbEaxu7rJPAOwYtx7Muw>
    <xme:ykIDa18INkV7Np6n-_401Sz0ncG9nCkVzPBELpNW9ryfnFaTttBy3Ptd9vkt6CUqs
    kva6Hz0jBPI3UT6XoNaHaK4GNLaH7WYUfihMfg1pkqHnMZlg0wzrXA>
X-ME-Received: <xmr:ykIDa1N9LcDlBtawOny0arq7OAakc-G7vYWpRu673h7U5CsOMstV0mp0RzJoAqfCNl6fG3k3L0Gd-e3JD_mVF9vLor7-hn0FG-p3hZ4>
X-ME-Proxy-Cause: dmFkZTGZ+eaRJyK+NyF828bJavFqH3Q3QTcS072ssNGIOX0BGEh4RESOw8xlaLFzLbQ/JL
    bpq817NKXDOd0VpEBM51gSq4vKS5ViFIDKpk1aEnqEalrym8KNC9jD+lrqxTvqdDOXAV43
    +zxgJq993rHXZppKCi2Bgp3r6X78IzaMb9oiYTpjF73bmmMrWS7ak52uKnHd7IOCccw8e0
    fusW2RHWB1EXQyhIv7bqy2sef0cHpS00QP2Kda05/7kpOgDWSPedQNhruHVJ35NRJoQy07
    Ys21znpc0BlnEk5z5keRAmgL5N4pnRptMqn7JOFg2hzLy3ovXuALowETVlmEgZIhsuysKl
    4prQtSiE1iJX3omSCamXoiA9xqNevvlz2kt1k8HRRRwI0rmuJIWNr7jZen0iwvuClRCkOi
    Rj0vU/edWVqMhQreN/31R6amaX7DkcZ9x5mm2uVxzVe7s7yQoVTt4+LVg3xakQCjshHrqT
    kHk90LnkcP4JKy8ULlCcT+vf0mMWEphru1SQeDSQTdmTcK2bOCmWGWy442cqhQJESMN8qP
    2bkS153zjRYVlIIU28bafgdXb2f1t7wI6qNQaWS2XYWWRYx/w8t0EkStuTu2r5zZ2G59du
    tV0lARdsJomj+EuEEpL935hQ8cYePlmagM8Sgz63Nl0HxM+fRruUsr223KoA
X-ME-Proxy: <xmx:ykIDa5cYHLrqkm7Ryj7ku1r4p0wAmOXIBe3MbZbbk9w3ZgukZD9cnA>
    <xmx:ykIDa0XfV04x2WysaSQEchFNakT3K3NgoRTQMVEY0VLYlz86Bm-cgw>
    <xmx:ykIDaxhomvtJkL2BvKdDSc9yNQqJxKJ9T_1v9HDBIi1_S1ghTXsZxA>
    <xmx:ykIDaz8qnfZKc6whhQc1mfqUywNw-dPTXZ0gHthOPhf1GRh-psMvSg>
    <xmx:ykIDa4t9H2N8Do0vY-M7F2TzSk7jSBJE24NY_W5JrbYL5UcvUSn-hiBm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 14:30:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH v3] setup: fix incorrect word in code comment
In-Reply-To: <99FFF51E-E7B7-421C-9868-8D93EFE633FF@gmail.com> (Ben Knoble's
	message of "Sat, 21 Nov 2026 13:31:12 -0500")
References: <pull.2500.v3.git.git.1795282558789.gitgitgadget@gmail.com>
	<99FFF51E-E7B7-421C-9868-8D93EFE633FF@gmail.com>
Date: Sun, 22 Nov 2026 11:30:17 -0800
Message-ID: <xmqqqzgck6k6.fsf@gitster.g>
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

Ben Knoble <ben.knoble@gmail.com> writes:

>>    Changes since v1:
>> 
>>     * Update commit message from grammar to incorrect word
>>     * Change word to non-existent instead of non-existing Changes since v2:
>>     * Really change word to non-existent instead of non-existing
>
> V3 looks good to me.

;-)

> Seems like the formatting of the notes ended up a bit strange here,
> just something to note for the future ;)
>
> In a similar vein, it’s a good idea to double-check things before 
> sending them out to confusing readers with lots of slightly-tweaked versions.

Good suggestion.

Will pick-up, and mark the topic as ready for 'next'.
Thanks for writing and reviewing, both of you.
