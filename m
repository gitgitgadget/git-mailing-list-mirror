Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477206;
	b=Guhr3ND5Oq34FarW2NIR21Ioy+I8ctEAwJUqLVXoQJIxMZH2oWFsmhYMVsqFisNz5Agx
	 s5zLxEz0nu0xc5sTaNEfq6OohHp78GkEwXSytT5trtFFWLLgg7nSa+ZSfhmVjn+FkyS2M
	 5N0A4dRF80W4D5r8Rho+VQ8ukCU1Fyf55JtJ4nY83GojgMAUFaeyIU4lP9lbxsGm9b92Z
	 635UcTkACXpPIIyAZEBYkJE13xsAffFoI9KioWaxSF92xRfTbZjlaMov3/02IyIbqFzbQ
	 16RhU4W4jOesq7mY/XwEz3uPLgrfzV+6OstYWJgmkqjknrQobD9/FG1EQb1M8/o7zAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477206;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7byijkQgaYHQ4+2OJrrvFnapRt6yXyrBRe5iLhAZGm4=;
	b=n6AXlNrm7NBZZxJvNdDgBLJrbQuGO5k4Xya8gLF4xfL2le//wRBpnzk0nB0mb27t6SFf
	 cNJxYap6sAXhtfD2as3AS0X19TpkpCxJ1xZqvFrY/9qC5BDv+q7/UtZyCJOqEfW+QXV4+
	 hO1jLqpRH+trFiGNiqxfYDDAMbGq9cSXTJO9MoUv9wS4myMC4K382wAOTxI+tnKroMRs5
	 tPSXE7Hkd9w3Dg60hKVKIOqWpmEiKzEvC85rgVFqfgaWQqP+G6PbNW7uwV+VT/5G+uZuw
	 dqOd6zLqjfBMpxedQcA8pG64KE1KyNokC4ViOk4kZ2YGI03iKcapZv33jvANiV3wyeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ab3tkDCR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n2KhjnzE;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABCE606A330
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 23:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BABCE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ab3tkDCR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n2KhjnzE
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 153E21D00652
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:40:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 18:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795477204; x=1795563604; bh=7byijkQgaY
	HQ4+2OJrrvFnapRt6yXyrBRe5iLhAZGm4=; b=ab3tkDCR/Iqx/D7nZvXg0iR/EA
	V815E1wwoEJl8tejK8LZD5OSU6JvBdOdDAI/W7YqX0xduYxK+OlQzfdxgG92Iwmg
	Kwi+kGsnwBtRJQxxbZEdLLIrZWae7DYpACiI+Ho12afuiJ5x8gIl2gDLEzKyyEbz
	A6ns5oAlMhm0F6mdUEF/7h53rsLm1uNEutBUczjOlbD4w0acnBIADzjw5hzxNTVA
	xPJ+hmvGo5TpoLSkqS2FF6QTojReyS+DaVSjJkKbP4fzRMCFE4rg72XZCsZJM+M+
	GtDLHB72cQ3GbZyzQU920ao1wd2Zf1o1U7RlVZQ9CWB7YKBSvBgwBJYB2AVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795477204; x=1795563604; bh=7byijkQgaYHQ4+2OJrrvFnapRt6yXyrBRe5
	iLhAZGm4=; b=n2KhjnzEHwcFN1grTj1Ibo7e5Vhm06ljzGvBBdSSjPyl+dftxJN
	7kvcRcrNHDwh4XyHLLxXniWAwuBCDCjcS+KW6eWrjJaTZYFwgv8jeId0/FEECeQY
	FuXGy5TrlUWGfEfekZ05Lc/MiF+cD+RwfwMrRLbWmBg9VwSDAxBEvDW/2hz5Hm7x
	4fp43SrZiK18FWTZlbIT4SyO9CKprWDsh2QbgHW0tF0p7HmiKIqnEzZH/5tD4KF+
	uQ1lBYKBc8ilha12R5Np1S+mp3w9ktivLaxyY0Kk451ic8zMmfgdcL470OCqJVKE
	d5RKV3iJmC8mmM8Ia1R70JiIBtYO0CCpJjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795477204; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aPI9B8ffW3LHJUj/ize/VBvJ3cf219enBTXA1yDYmJzUqfw
	naQ2W737gCTdxrAsxdXSUmhGvKpkf86yu/H0A/7wHFvaWOlEPm+vrxV1W70iV2xX
	TIm1GmIx421O0n8FlQGeoLSJ+c35+h27razJ7pHM0Vx58U9am/v3NZNQEidcGB5i
	S3WW9I8MP/QTBcDF7m52MpUpdYzXeYRNPlHHkDRgiKm5Q9GZCYYcEY1J3QIYNX5W
	Ghcny9pfL/8U855SwrG5PJ/ZsRRgq9ljkL5txgH0b3JFHCYpjhOkDrA10RMwafws
	cYgCq5SM+liBtsrb2tF+8cwjrztNQUgvgVbgYsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XxnGE5T8W5H+4GJNq5O1Le/7FUja6YD2J9VHpyYxJAs=:R+OcWgb31HjDjXlTXTSZxnkrEhBnFxCUfuN/E5BR7GM=;
X-ME-Sender: <xms:1M4Ea31Kb0PXHVYZ7E0mDzU66wCGDS6V9fMvTJdGzv19z-_gD9IXvQ>
    <xme:1M4Ea9HFuSeobVbyNdaoegH4RDuDd_lASwvNQ1_MC46n2VNm35aTidfTQ0wDW529i
    AVFLKoYvuMxAELT3RADGuoBLnhJxCI-OS_Tdyfd2tdUKGNHW8L-p8Y>
X-ME-Received: <xmr:1M4Ea84Nadr_qF80ZNkU6ojeR9ILaDEwzVizSLg32sGW3ByFgLsLi_D073qtnRNnm-NOKjyorniuLbMpy3Z-x3B_jSILxzkUES5B-M0>
X-ME-Proxy-Cause: dmFkZTGxxirgWrIuQnLjWsOSknSJlLapBShkzgOu81OrS8voAIeG3ZRaleiQryFNSUc1bU
    wydtJifB6VOl2gfaIbpFc7VrJ0iUAgIqOJwsnTLszZ7ZnUyJRalGG09LwtERUL+4nYYZxJ
    wpIeu32yiJMzeyJiT38FUCpo33rZhnRE6ESsmO5XP3HxeTI4SOA7wcSmiKviP/2ULha+VL
    THvBzhtDQgByFO+q+jBWBpX/k0CvjV+HAl6ZatahSibnLmYKFNQnoRvXFwi3il59MXLjp+
    +N3ExntVhYtvnzfC14Fe/nKqrHw6SvVWh6iIWVDf2INW4odXxxZysR2lUrQRuxik7RGVoE
    diN5iEHRiu6LPDMVYDW5aiyECB+9Lie90IKXnrcnXCNVDICUF+SGeGSTBX8X+3cMBsVIkR
    MMyw8jr6skW76GcmqfxAEzUgzq8ewCS0u+AQ/l1R48KmELaAsrpg99vA8kzEkR+cMTAPRf
    StxaWc8g/jP9VKvp+5/ZHbwRUoHW0zN0aKGbLPoSqSfJoff8bKN/x20IuujqRCnH/xSPwB
    fEYE6q3jgULjbZIdWaAz4ohv+Laj71SldM907F2M3Vos+Ne0qebvs3QFgF3c1VM67IO1SF
    FmoES8nex4i3GchbhxnfTKV49egagec4np+iYrLhXsNvkZazyiwRwgidHZyg
X-ME-Proxy: <xmx:1M4Ea7sCKphsBiJ3cFjXxINVUlWydvV1Auy6ECYmWemSZAIxSvN3yw>
    <xmx:1M4Ea15h_OPk_SMOJlt2796KA-xiZ2wPtN-6V8XRgl6WzxAm-B-dzw>
    <xmx:1M4Ea-U2LmeEZeNIbuWzaeV8UxW3UBtOOzgFg7bhHO4xl1OL2n8P6w>
    <xmx:1M4Ea_8wBi3S3YTgFpailcLIh0tE0UyOBnfQd0HJCEL9vDjgYoDeYw>
    <xmx:1M4Ea7GljMZCC4V_LtRj8vEeSFcwANJc3dFc3FYjre0pkrPgr3ihDDVf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 18:40:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org
Subject: Re: Prevent git reset --hard from losing data
In-Reply-To: <20261123160009.61bf0bce@gandalf.local.home> (Steven Rostedt's
	message of "Mon, 23 Nov 2026 16:00:09 -0500")
References: <20261120145444.13061eb7@gandalf.local.home>
	<awC0MJDYS88yEtgm@exploit>
	<20261123160009.61bf0bce@gandalf.local.home>
Date: Mon, 23 Nov 2026 15:40:02 -0800
Message-ID: <xmqqjym33ynh.fsf@gitster.g>
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

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 20 Nov 2026 22:09:32 +0100
> Mirko Faina <mroik@delayed.space> wrote:
>
>> You could just reset without the --hard option and restore what you
>> don't want to keep. Otherwise there's the --keep option that aborts the
>> reset if there's local changes, but you'd have to remember to type it
>> out every time.
>
> I just tried it without the --hard and it reminded me why I never use that.
>
> I just wanted to update one of my branches to one of my devel branches and
> did a git reset without the hard and at the end it gives me:
> ...

Yes.  In this particular case, it may not be too bad (you can just do
"git diff | git apply -R" to get rid of them), but if path was added or
removed to the index and the working tree relative to the state you are
resetting to, the recovery becomes messier.  I never use "git reset" for
the purpose of cleaning things up fot that reason.

