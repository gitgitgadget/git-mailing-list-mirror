Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611500;
	b=hTB/u3C01vmWs97sm9sGnybdeoWJRBHcEYgR7/1peezjqmnsGHZq1f52uzhObrYkbsyF
	 SxZZD5+LMRIJlmFmBtkHDcox4QqyvW5guVopktwjavZmbJ2zIKUJTweUPuzIPF7R2VfZq
	 4AiiX8axVhKNQ8h6408qfAhO58X6XeUbwHxcFGLEP7W8zZwHi/UqEG+yj5VC8GA5yrYTM
	 Dkx54YT6MUefjF54nB90c3HJZjNWm3sR93CxxUc2MMVpXbId09rZ/hHs85Sn3x4XUcG5s
	 3ra5yjoCgj/gJKXhGXojZqskikFiDwuhUgCFh573aktn6vX4RV7nhrgHo44kVnTaPgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611500;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gAYFeRQ2k44ulQRUMzcG3pNOC8lw5UDmHAZk/I6BcQM=;
	b=gncJ4dfyXUh6bW2Vf3TFmW2mhm7yczurqd+jwTMhYCD7YyjEGZNWPh0HxM/zduB2OrrN
	 bC9ojBTv1Te58phVQP22ailjP3uTedYOH95IAtU1WieqczNd9VYUwSu32KejMHtvVMl9f
	 +I2vbRimP/XpN/UXEVD3zYFt+gfZAI1u55lRWNIVmQ0inTIIVzvXY6Tio+4ZWhOGhofwH
	 Rz69t4CK5tHKgg9pYuQSDFQnhdDEWhih5ImP3TRKgZHzZPFe0P8krUbI2JEkLFIhtriev
	 dFOrB3TjnQQQSQI4TDbFQ5LrYliGTA1MeHvj1+jPfMfsfrK2t5gXdI3WIH6qbJzATcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nW+SAbiP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D1y+vWAo;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C5606A32E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 23:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515C5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nW+SAbiP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D1y+vWAo
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67D197A00CA
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:11:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 13 Nov 2026 18:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794611498; x=1794697898; bh=gAYFeRQ2k4
	4ulQRUMzcG3pNOC8lw5UDmHAZk/I6BcQM=; b=nW+SAbiPaM0aM+zxCAgxaZKTdy
	R6IPDsI99vcVvsBH9NtHxUWTR2Ox6pXYF3zlG0bwHpni3fRp5re187UWMGYA4YRC
	H2+004g5i5rcep0NoY+zTX/yjgk4fHmXV8rxMu9YlWUMCaVPq9c6ETcK6/Cy4bqm
	gQU+AWtimNNsuEgpjqA6ykRnYvtqZxEybNBTQaRgBce4ooEGJQhT34OeZEIS56Dp
	PZpzbb0VORwAmdGElVGYpgKNY4SiFipqhS4Jn/oK8QrEpUuQ+2d2q4smOV09F6sY
	C2jGG+VcOteT66GYeZSoQ5HdSvUPdHJYVsu1eJzD1kWOIahMeXIOt1mnNZLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794611498; x=1794697898; bh=gAYFeRQ2k44ulQRUMzcG3pNOC8lw5UDmHAZ
	k/I6BcQM=; b=D1y+vWAoGUMX6U5TDRFCs3Sju3HMiTAyvYOE5yDhITBLRZsoOCE
	MmiQ85x6wyZ7SZF9SnsiqF1x+gW+eKzXJCHLiYvppFGbTZGWZvjiNdS3vB3eSsVQ
	g/bRS119xl2ct78UASSo1x7Wjvv/stiFGuRemiCKY4tha7dadkgGaEeU50S7ydrK
	giQfhg7brwsR+upNDcOXDsRhWaWEJGgIaRhIcD3l37yMXSfHMv3+g5ZRzfDOVzHg
	4tz7FU8KNM/wWvKFcS9sXdctcsw7tuBoB0k3JjWFfuspQi1LEbYEYCqXiL26wFTK
	l5hdMVL5Upj/ILN3nIOz8TvxIEqhrVWxTYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794611498; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ly1BpslSUi1o8llzfVt4zKKGX4C4Xp5c25XMXyK287lKcwd
	044d4krRNjRNyMS2ciA9HmC1MdFNW8N8XXW3q7TuBm2zOBf+/o0wd1bLrYl7UPN1
	OpEg5wy3gXSvfN9QOOGeQjA064qSE2td/QULrSJACVfz7ZzZQlJtsBsYdACaO4yT
	dXWS8qbc5yIrXPkdEmo+jcTbEhNbl9htR4PYghRv7BqBCaJKZki4AyjpNGmb8Qhc
	ch622y99QgTVJ7uEKK/vaFr1eTetLzLGcGCfExmCldf6boXwR4HgqAoKAjDeelj2
	tV9OC4EDFB6LSt6I9XzZcLnhQkx6XvpR4OTnN3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:T30hOE4ZfludSzTkRqbftcCUchq9kqQSu2uRN9JfoDk=:A3DVRFgh6r64MZtGTc1L2j/74Iv840zp3SLWDgiYZOY=;
X-ME-Sender: <xms:Kpn3apGdNdOhFKOvx595QeesmYPuP_-1CMTX069XoJOuioWqIZQOpQ>
    <xme:Kpn3aiCegRBa2kbt7P_XIIziEP96wNbrZAwX_pPuiZp9ecrbP5xurtNhe-OKqU5x7
    bnNwqUgdJ-Qn-mp4_j1APnZnuiQQvvE2VRUJE6MtMOukRb9O4xq1A>
X-ME-Received: <xmr:Kpn3ak9uhEmzgynIObV-TCmua0hIBI03BY58uDvxEiwkOvGVV-R7Eqb_2IXCm-l60OxsQunEAxeRo66nNKuITwukxlnrDxXbg3t1>
X-ME-Proxy-Cause: dmFkZTFJR/0IR7XsBtDuD+bHvLLTsbKwY3/MuwLZ4y5zny0s+6q5cR9gOb1ff+QyDhwkWW
    X3UW0dJznW6fi5jq73u7P98wNwiDtEbz9O0RG1AmpoU1WO9wcj+DINuSeQ9hLLHZdHQ8c3
    fFL04HitHIX/KruWah23bDINBtU5QHb8LruF94tn0i7mkvl78saptrDEhonkRqgFcZsn91
    xFTqpcbr7vE36vrf4YezWmd7hi2nhLLr9FOqnuor1Y8BBTscQl3NdwDMOt7U15rCyzyQCk
    2QCP2O8KhRu+2D4T1GyB6s6wLker1ZbX+ImxRHLcpN6ZQ9T5F/imaoQEKMhcKi3bBdwyEe
    q15DVVT0HZRaDtRelcMGGPeqdAwuFJbpa1kkC0aLnPRu8w1Vg5teT4J0soYjI7N4mpimu2
    k6m387lZGDx+KVUPP5weeXsluIDUGFKRdLTnRXtxSXS/OzZATNZbx/1QcrKr/oxmqm6hNY
    5Y09Umi4P0Kt2TVL6ZtcMVZTiPfGa+wJYTRCo5/8JjFQapj6tqYmUmBxPw2OWhpz8lMakC
    4g/eVBAmox6Rpm7ftDfUxAOMee9T1a7dysvA7kLcyfG/xzN4uVyv+rnWKmUWX939ZnKjmR
    G6TBGWI+6uYRaCLs1PaVrHKRWZhtm0/PFqnN8TMRfbdNukHoNGKgoHXIJ3/Q
X-ME-Proxy: <xmx:Kpn3amBhP18SGcOHNFXLnr2OXW5wnzy-OeBD6gApoUkv48wmHVQc7Q>
    <xmx:Kpn3ahSFbuq3jVluWjEHPePHPZYM8-Z4eoyP24PMoLnasxXxEgC4sw>
    <xmx:Kpn3alvAPrJFsAdk3MLzcBFCeTzrGngR_eUhWxiIECARmSmxt7E3JA>
    <xmx:Kpn3al0fdpHL3bJgTt-p8_Fi0id8yaM5lnQAWliGKzUlgpzbcnI83A>
    <xmx:Kpn3ar7mQFiuvOdPtjty5rRssuuy5LryKheLwv-ItZef6QmdMCrJoTY5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 18:11:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: aeron-gh <agab0323@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Victoria Dye <vdye@github.com>,  Meet Soni <meetsoni3017@gmail.com>
Subject: Re: [PATCH] for-each-ref: avoid segfault on --no-format
In-Reply-To: <xmqqjymg9ycq.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Nov 2026 14:10:29 -0800")
References: <20261113161413.15688-1-agab0323@gmail.com>
	<xmqqjymg9ycq.fsf@gitster.g>
Date: Fri, 13 Nov 2026 15:11:36 -0800
Message-ID: <xmqqse148gyf.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

>> Marking the option with PARSE_OPT_NONEG would also stop the crash,
>> but then "--no-format" would work for "git branch" and "git tag"
>> and be an error here.
>
> Shouldn't "git branch --no-format" also error out?

Hmph, "git branch --no-format" seems to take it as an instruction to
revert to the default format.  Making "--no-format" mean the same
thing in "for-each-ref" may make sense.

The implementation of "git branch" side is quite clean; if
format.format has a value, use it, or fill it with default.  Perhaps
mimicking it would give us the right behaviour?  I didn't check.
