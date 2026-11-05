Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899731;
	b=e0D/gJuyOqXW89VJTVEeNrFB59Tx7HT05kt+DgLhbwTk2rQmSg+R9JFUO4I8cqW4MTwh
	 074TDnMnz628/4uJn5iZGwOtfao3eaO9mn70R6ebf2y4O0FMdJkuYB71pwvHwXW/013hH
	 AfdNs8j1NeTg5NV/xEaO9ZbIfc7LwH//TVKQwBlcUE87c2xCmpDZe8eheb/QNEsCg72LV
	 7+fDUQg5t2AAtovS9e6oy4hFlrnwFzUBI3P9br/Coxmt4MX5iyFNsE1i34tEmoHAh24S7
	 e5h1Jw8zT4SuSjIMZdx//KQZjYH4YTgHUrX8u8xbSVm5B48DHjFjofouYRqkT7iEujA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899731;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UMsaNv5NHa0dyATfC3caOlpiyyWl5DzFTcFB/BVgyG8=;
	b=UG2XcGKoK/dbbvqWgU5s2w1kd772YF+mlLovldmwtDIAa0Isey4anyvOp+AZC3Pe5DZF
	 JjZmYYqFm4jWEge+RTv10pKSGki2dE1NCwBRSGNiDs5afBbHiz+OSCntrCa3veTSpAtUi
	 EPBP05AeSS6HmANadTjc2AE6YHfC7UjsgHPXFrUONc6Yh2RpuZHK7yh8qhEXt9X7DeELE
	 wuTNtuoVM7TaAnSAQrd/8dLX2r+wunwAubolCuorJE+VA0YdVs4Oc/NSEZPn1Y9sgCRuU
	 zIIFphx06o7gHhDGDpDwQqD/rgeFA1ef2EK2lTDiSg9fhh98U9XIembMADBF5V02RzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MIlWyZ26;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xv5CoDeB;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9B606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MIlWyZ26;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xv5CoDeB
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 50DEFEC0252
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:28:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 12:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793899729; x=1793986129; bh=UMsaNv5NHa
	0dyATfC3caOlpiyyWl5DzFTcFB/BVgyG8=; b=MIlWyZ26unBveI659hrU4xtFlx
	HEOKkngwgY+UvlR+FNtqbzxWegUnpKSyv/8hZC2EmJ4e4TdppWGM79UBpxSre4oi
	1QlPe6Avd3ty9hGSNWTqKxmWTNUYPI5vS5cCp/hGDUFMGP+cm/73WkX1B+V96FmZ
	heaCqLXH+k0+o4P1bjTnlnyBqjmlnwrbksJL3HDvBl+8a5hTbGYnadOt9kcY+SdD
	+Uet0Vp3wOwd7SagzunvJoqu9DTR9rFfu8OpioD6OFgvAbb/dhRVShgaJ/ftaruX
	fGSKvyEGA7yEapIZjB8my0Np7/6sMksfe6VqezyzmXEkysmM4QVQBfmNfXiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793899729; x=1793986129; bh=UMsaNv5NHa0dyATfC3caOlpiyyWl5DzFTcF
	B/BVgyG8=; b=xv5CoDeBstCe3cK+ijGzyoAqaHwddmaxAwxPaXHYnLjQX29zEzY
	pF45kuhHyI69tqMbwLut6WIlBgarkdCwNs56HJ1w+/0gMhsjaKquhwL3ScUUuiIn
	yTnaKN5qr3oj0WIAv/vSca3NOvffdK2JUV8EonA+aE6iPNmTcL8aVOY19lFm6WjV
	micvFV1ve6uNJfN45cJe1weGGsSXpWhoAIV8JN+mh7S4Qa+c/BbcfBag27G6chCh
	H2w5miZCsthLtWLpTZkeLEb9tYmGAdoSnS+kNFX6maObf8ufsALbnCSabZDI9dpG
	rzD0l/2S2ifhqR5FR+6xEOgBXJKPZJmmBaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793899729; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OS0oDCe4+O/Ilwd7f6uXo4CVnQu5rlvkrC61t/jHK+dxXSw
	LUmBKDgtrOaxu8HxcDYul9Qzq0PBWlfH4MF/8qWAxajBgi5BrbJumuFDRZxlBvE6
	7D//IyYszn25I1o/xCMnL1v4UW9Nt2YuxvWmjvTbsG7tep983rPaEXFUJMS3Yary
	ylbU6YtI7ogvQH2qAcbp7am3w6RkbL3zNJNKc+f8aHc0rYsNBcmedAVdN9ID3BYe
	EmNViLfv/JHM6HknRY9ZoGHPYRpKpIvk9g9EuloCnNPavCF2T6VHCvo9gIMekTYf
	vkfALzuJONk8Ud1JiGczSwQagnOCghx+LUoh7eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:or2lGht2cgQymWfu/+pCeQYocbCmYWthtXeHYNWYGB0=:lJFDMZMhQjsDMhwTwgNkUCXf46Gqg0jP/y2v8OJPewQ=;
X-ME-Sender: <xms:0bzsas9KRqChJVLIOYE75C37lpIaf-x2orjCM9oEMtTfK1UBBqiHgw>
    <xme:0bzsarm6JPne_HOd96TnPVuunFSe5Ne3soZgamRThfxlbNodEj6y-Q_uaCUtyZW40
    a82kbfwYBhQ_oda4IV6QywNM_RQjNHBYJfGigsvRGAmhN7Nf3WKD5c>
X-ME-Received: <xmr:0bzsaqVJBEjSYbosnIBb7bVc8itoO4MgaDu-Hy28gY85MfliybUSBHo0RwZ4p2SuwF9_7DY_6xCy9XIOj-_Q-sZCHdBRwRxI0AHl>
X-ME-Proxy-Cause: dmFkZTFK9OhgY06CnU9gD5FpdnfwQAX+0UIsr9pGea3OepivBjJAv6/laztJI9/soM41vA
    xzcGGEPxTKqOY0QsZctEIonhTdoaBIwtYOle8Z1JgYyjAbPSq2e1f2RbDMNAxErnfwGR1S
    hGzdcg23FzkF3WAsQUCjF3EepMuH7z+MgLA84mvIoWofo+K7MkGQew8QDFISfw/O7/Za4p
    XXNeQHDt6lOWbWvS7jROpPWDQYjTTv6qWn95Hqwp8aWZzc93qmvT4CJ6qOpae1vue1uc1l
    PyDREP8/hpZVlFgO8Bso8I2NJjklwx/15SjWn8RnUdNIsZtPU10rMXzAvrMjDgXcJLkoJU
    0M3qPi3NTHbM4Ihb9oDZeU2kfxdA552jcFvBsftNjNbdftXn+CLgTtSI4DAPGAEef87770
    OImIvjIB6UeI3jpL1HW/lMeCcvsY+yProtBsmkMGeseKTu9QVsirQ4f4zAE7MPjwThopZz
    //61ZYs48jwdhXbDdT1AsQyErx3ubBgh/8awhXE1xCHSQA53uUJFW58wBVmabpHyi+Lpmg
    RrXyTjFiZVEkhcgkvhkpHcMJXf67+EwlR59Fv/jFOBwZJLPz5jNJ5S1XO1TzErYtcOEjpE
    IHI9t4/4jHoMtpfGiFf4Ntedj2g5mfFgcePdBJDm01rSCmnfHW2KHj8/Lmzg
X-ME-Proxy: <xmx:0bzsaoHDugOjwQJE5vh2RC3GVSxdLbyHxdx5J3RLqyYB3XRIEoqpQg>
    <xmx:0bzsaufgLLDfq24Nk2EP59MVFB5v91aXgpfC3sskolLlyOW_XRiNUQ>
    <xmx:0bzsahKmGwAaP-xaMb9S3q9kPo9xOaWStU3RQ1QNIzM0DjVM1UKV1A>
    <xmx:0bzsarEpy-18HAbFlfNpkPQ96gQA4JV_wI8-k4UnvCm2xvbFU-gRwQ>
    <xmx:0bzsatgcxg8UVDhUFbs6O6f2EZd3clmFawGzRJXsiXWTCPBbN2Uea4vK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:28:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  git@vger.kernel.org
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
In-Reply-To: <CAL71e4Pp=rZSKd+vC9anjEVHS=a6DOoK-HC_Z+3vDaqjo0+6+Q@mail.gmail.com>
	(Kristofer Karlsson's message of "Thu, 5 Nov 2026 16:42:29 +0100")
References: <20261031065525.19883-2-torvalds@kernel.org>
	<auiGP4XhObUzC9vD@pks.im>
	<CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
	<aumKXUS7_x0i7ZU1@pks.im> <xmqq5wyd4epv.fsf@gitster.g>
	<CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
	<xmqqv76c1mwb.fsf@gitster.g>
	<CAL71e4Pp=rZSKd+vC9anjEVHS=a6DOoK-HC_Z+3vDaqjo0+6+Q@mail.gmail.com>
Date: Thu, 05 Nov 2026 09:28:47 -0800
Message-ID: <xmqqy0b7w5kg.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> I have a series locally that builds on top of this topic
> (lt/describe-commit-date-skew), and while working on it I
> noticed that the topic makes an expected failure pass in the
> commit-graph test mode, which fails the test script:
>
>   $ cd t && GIT_TEST_COMMIT_GRAPH=1 ./t6120-describe.sh
>   [...]
>   ok 102 - describe --candidates=2 HEAD # TODO known breakage vanished
>   [...]
>   # 1 known breakage(s) vanished; please update test(s)

Yes, that is exactly the one I pointed out passing in CI in a few
message upthread.

> That test now passes when a commit-graph has been written for
> it, which GIT_TEST_COMMIT_GRAPH does, but still fails without
> one, so it cannot just be flipped.  I think Linus's patch is
> good, but it needs something like this squashed in.  My series
> would remove the unset again once the test passes in both
> modes.

Perhaps.

We'd want these tests to pass whether we have commit-graph or not
(in other words, the presence of commit-graph should not affect
correctness but only performance in an ideal world), but we live in
an imperfect world, so as a stop-gap measure I think it is OK to only
test in one single setting, even though I would really prefer to
test both with and without the feature, and have all tests pass.

Short of that, it would be better to test only the "default"
case.  Since mid-2019, core.commitGraph defaults to true, so it may
make sense to use the same trick as your patch below but freeze the
setting to always test this feature under GIT_TEST_COMMIT_GRAPH
instead.  It would require flipping one expect_failure to
expect_success in the case involved, though.

> -- >8 --
> Subject: t6120: keep disjoint history out of the commit-graph
>
> With commits walked in generation number order, the
> "--candidates=2" test for disjoint histories passes when a
> commit-graph exists, which GIT_TEST_COMMIT_GRAPH=1 writes, but
> still fails without one.  Keep that history out of the
> commit-graph so the expected failure holds in both cases.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  t/t6120-describe.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index a75f9227d9..969f878946 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -704,6 +704,10 @@ test_expect_success 'setup: describe commits with
> disjoint bases' '
>   git init disjoint1 &&
>   (
>   cd disjoint1 &&
> + # describe walks this history differently with a
> + # commit-graph, so always test it without one,
> + # whatever GIT_TEST_COMMIT_GRAPH says
> + sane_unset GIT_TEST_COMMIT_GRAPH &&
>
>   echo o >> file && git add file && git commit -m o &&
>   git tag H -a -m H &&
