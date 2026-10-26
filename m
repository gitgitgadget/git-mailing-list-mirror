Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990713;
	b=eK56eJ0rDwpfIiAC7O9ZczJhQOX4IOrwfJ0EtsYYPRAxeC0eF4A4ts71J6YFxceJDsmb
	 lQpSMswAAcc/KqAkpFzFtQ51W1dx+giX2BK4G3J5Mr3X568MV0RUM0o1JYFkS06MbyiCv
	 T0lDOE4ID08YCKRTKG0YPx3rLk1/ZnPQkGo8jTWEkjYcdPIEuuk0QuwTwQccKQTZjf8RC
	 rdiu443DCyHD7tkDpBuwI+pSZyoGBqJqqYYM9IPA5r28XtlX+V5Q8REPuAlHOqeQg2tcf
	 STXmOGTd3pinQYphdK4Jvy+/BYmsTkQE2z5SEk3kqtCK7zXkEerbFYyw22MaukHAYSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990713;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tLvOtCmQNfBRMdufqC9JydtAgGslmFW21rzS2r0ckLc=;
	b=Q+FvsJ8cGwpThOhPcNFlrJ9Rj1lXJ6KC7YbfB8h49zmT1QAHtgkh4aLNCt32P3jvQxdI
	 SEnDnRcHO7rVtEwrZWki7tqYYdBU0JRkbNSqEUknw2W7tIsZuQEc/iqA+xXKoRXN0vh/m
	 z2rfPzNQrBaOX0I5LKCT7oqkUkbWlpH0LQziUBARvu4RmuaZp5knY3Oj4TWqx7vJcmdxy
	 zJ08le0CYL3sZRLP/nrGrzXDJcsJYFkn8ikQZkY9D6M6wZFgChN5+wrrHlo8qoEJEGe/i
	 vbU7Q1cgw54Slm6r43MYx9dgb6IqMH57NtFrMY2KikH8Ea9P/HT4o6uscnSENF/mGoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=W1OLOfxj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W5jHLOfL;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07D606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF07D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=W1OLOfxj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W5jHLOfL
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE7941400054
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:58:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 00:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792990711; x=1793077111; bh=tLvOtCmQNf
	BRMdufqC9JydtAgGslmFW21rzS2r0ckLc=; b=W1OLOfxjENwwE9IBWVCDZbECup
	ItP8GCfYCSCaf5EgOp2VzkAvRo85gY1syBOit2Tkwggfltx+VUq8h+8byx3AjXDN
	emysUwm3vCAFPHa2hlm7zW32Ne0RxW2NwDBL1pYflv12ThjejOiR/WOZR2bGeuFv
	EkPRqpeJrFzKL1nw6x0fWVCLc2q/JRjB2zKwHXZJXDyqCwTqb1DLBFgwNDY21hvZ
	kI7L5rmrwaIiEQz3op4ef+FFMrtzM3FhWTQoF2vFHilFErFGMr78Sn+qyCs/y3FL
	P67FUjZ/9Gdnaz6mXNDU1DB6+EYnP6nsQNG+ZMCzRoiwG8owq7RHwrerCHsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792990711; x=1793077111; bh=tLvOtCmQNfBRMdufqC9JydtAgGslmFW21rz
	S2r0ckLc=; b=W5jHLOfLZEBLHpArJPPewuwwY3cDPIJKz0NKvATQOZKdlr30JFw
	OQrNDiEhRypoI9jh8kAu/xrYZ4uFJOD6UBp/eJCxKIP+TK0yWoA70u8aciWLUteD
	uET7LTQJHLIvWiLV5pwxXGALrY6aveqjsDqHZ5DRmRcYRDqCg4+4rrdEIWbilb7v
	sc3BO8auUOCS9YV5xIskWnVk6zms6/qkQFOHHAWPTuvJdegcyRzXQ3QFJlcNyHI6
	KcBX9JfxKTiJOU9c2vsfF3xvPkFyt8AI+bdeTo5YEgI21W7ByW14bSajVBgm1elU
	OJ41F2aaJ5gI44v2rkvRufdusA1dxOVc54A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792990711; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kRgtDfuFmjqOw+eg1wDiwPGpRBUGcUSMZqdMoG2/eXx+vY7
	W9QXKj684kNaz7sHEBMXNRMBL7Yzmhf42a/axPtvo0uhOcxNssy66mQ+ZqlmXn6H
	Y1/AUrW/u0URAlcn4a8/mksXD6ju3VFI8UsEbrCdqxUnU9zRf0kBTA9jvgR5/p+1
	SA5PhHjoOavXgie3NkrYoqE25Uqn7L9dvCr1HR6FUdhwdUtVLXvSxezNWaAbmuW/
	k1GJ5ka+PBlFTvRsXx4pxu+f9BT3cbreBz7ynzsb1OZvwb1kGnYF/jqaLrpD1rgl
	K7zvZ49Zl/TsfUFQYGJbnO1QyhYqQbKVuuuzWuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CUfHJcHYJVwN7m5eUlrcTMF7ltMPPhGXLMHDUWQ54pg=:zzHOrA6KQhjaOXOvyyOGrHyJZzEkON3Dn2I4txSG/qU=;
X-ME-Sender: <xms:993eatGzCrAhzOPnEkz__fDTmf5rhuWX61wkliyJUsZR7W-GxtjK8g>
    <xme:993eahZRMSM4CAHMvBpCBfRDc_A4WwK-BDUPC3w_tIoXOYn1yfEeEJpwsKCdnMbUT
    bS7IU_MhzVDpoNvhICJf-FDNiyrh47v82R-Lq1RTl5yBVtwmrPrzV1p>
X-ME-Received: <xmr:993ealUIrrIwWUFlp-Gap8a_-2-itZsvbYNX5U5enC9pjt3qGskpSGXTNBqdT3nbzIslsETLAn5xQBklIwd4CqqpK62lXqdNpoqS>
X-ME-Proxy-Cause: dmFkZTEFWExk/ydTa5EctmbDVn8tjcigdqoHHErzGMIH1yLb1l0Es/2C33ANz3Gqj2P6aJ
    dIn4tdY6j+6LJW+APudGzZGaHtzwYVokToruAqGz9eicvHgKkxN4XnbbTkGVcqpVqCXyNj
    08AuQnD9puROQ0UlhrQjxNldm2VhgjiN77WP8iV0O2X9rUzREAD74jmq7rCQf0Zo/oH5FS
    GWYlp72G+yxg+OINCS/iyZ/ruuj3sDXLa7Pdz9RREyRXvX+S/E12ZfEB/kRILzbzbvjsLg
    +DHB0ijuyay8+2b61uylqXACMFJkPQKXpUglkTfHtjrcMeawxDpx9jG9pMbQLllK5+ALRF
    Iz0IfpyeCQq1xnNH3pKdtyOdTmnlW1DuQeENJ6S9Huq2CidiqJoVTvXnmJzQdB44tT+/zl
    DF7rfmSOSYgTLzKwKugp/rkXMjx+ze/KyaNe/1JJW8rhu0wSv9GuqsBtfO2a2j8druQZdO
    TwwbAWvVwGKYGqt69weh9IrkUDsY5d1rRcTs2fe786PfIUiLXCUpizhBExH62zFGxghJ5X
    BLisrbwSdLLaUYva/n4uCqwIwdGO2+nkJjC5LEi2dmaEOAt9AqKXo3jnRDkTaz3JmLpZJA
    Cz7sI3kSOVJBMQJJpb8/quRojBMlpGr+Hu9hgubvh9sw/re0YEXEl3T+mnTw
X-ME-Proxy: <xmx:993eavkH20g4QoWR-nt5kBc1ezzxLsep18-mUUisSL0teusuMZUfSw>
    <xmx:993eaoCpNj5zpu_j2lei4cA4SFFMd3QqdbX2B-A1SWE2jtsOgbAGxg>
    <xmx:993eamgpR7zgZdpX9vZbCcop_yUOpY324XteyMS7gigAF28DFQitaQ>
    <xmx:993eatxhI_iCaN-Q5XTWJrII66khg-Cr-pH2ij8s4b82OyAju_47UQ>
    <xmx:993eahCAcPP3zUatoFOVL8RXFwvvA1S9S5JfkzgYLcwDIFZ3FMIETF_K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 00:58:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com,  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH] git.c: drop NO_PARSEOPT from builtins that
 use parse-options
In-Reply-To: <CAKrRMNqtqYiE2YKVky+mHyrkqtW2c_L_DcCen1hyaQa8D0+fWw@mail.gmail.com>
	(Tanga Joris's message of "Mon, 26 Oct 2026 05:59:53 +0300")
References: <20261024052449.95869-1-tangajoris@gmail.com>
	<8b60c7f6-4a1c-495a-a594-aaf322279539@web.de>
	<CAKrRMNqtqYiE2YKVky+mHyrkqtW2c_L_DcCen1hyaQa8D0+fWw@mail.gmail.com>
Date: Sun, 25 Oct 2026 21:58:29 -0700
Message-ID: <xmqq33ttvz0q.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> Christian, I plan to base it on top of your early-scan series, since
> it touches the same code. Would you be fine with that?

It is not something Christian can approve, nor do you need his
permission.

You need to make sure that the topic you plan to depend on is as
solid as possible.  Those who write topics that depend on other
topics usually make sure the topics they depend on are at least in
'next'.

You know how you can help make Christian's 'cc/early-scan-options'
topic as solid as possible and help it get merged to 'next' sooner,
right?  In this community, topics do not move forward without
positive reviews.  As a potential user of the service the topic
offers, you are in a better position than random bystanders to
carefully review it, find issues, and offer improvements.

Thanks.
