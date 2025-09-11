Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51A4220698
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611910; cv=none; b=mKaQxNcN7TT0hFKulX6vunESXr5S+5n2Rtb3/knwBvhxd8Bm7TdDC83vA290/EEUj5Md2xCfjm515PGfFi6qg4WTvAfQ6RCxzvyGNYDaBpb/1nyT4UFo0ml/fmAOtsOgY/zZNqhbWjVsrm+vrrFV/oRTYdWrqUWSXbfxLIX9008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611910; c=relaxed/simple;
	bh=JMivT4PNPm/P/PpB/wNhX0+criqyvkxZxEUrFE9TQIQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N2WDHkoZjn9n1/8oZ6x60KzysfE3amFwURsVl+VWwV6ygATn7C5Y++Y92sOFAz73iFnisMyLWVLh39aihH9bodgF3zVU2OcfRI5g0fXqRj8yWZ1pfcxhr2ScCiWKS0B0jmBxh3q48wJmdRIgLtbMfMnGmocptPtVtpsi6HUPn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZcXJhLoW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bd3txx9+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZcXJhLoW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bd3txx9+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB09F7A01E0;
	Thu, 11 Sep 2025 13:31:45 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 13:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1757611905; x=1757698305; bh=JNwnXZEuz3/ejk559EeUZfzUk9K20ofc
	R976L5c+XyY=; b=ZcXJhLoWiYGXj5/wEWOds5/Nn+CzastaapmZFM5MW469tyyu
	kF9ViVwZI2K7jZtXyensAIMRJoS/a8/QdH1jB880U+6k4Z5gnz4S8UsxNLCK0lMh
	w1C07TBsi0TLlZ9zcuKDd91oaiqfrzFtZMoMdEle5NB+xjkS7xBjWvXadyT78NCq
	zNyziyPoaVOhmt8pEt0NXH4r/TnmuCSnVqVYlFyQLzgc5RvxBX/7fcyEM+rGdp57
	hc1vDLhLcbKtyxpnA9QDf4B6iz6rll/XMbyu3FHAsbWJPCWwxWKp5Gd/rqaMfmDY
	4WiswrZOKA+QVAgoGGa32CdFOc3kykc0OFtWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757611905; x=
	1757698305; bh=JNwnXZEuz3/ejk559EeUZfzUk9K20ofcR976L5c+XyY=; b=B
	d3txx9+d/7dUhd93cstlWQnN4vA48jAoen9FOfISh8ySsihGdp4neZYePngPIysd
	Ov6a5Bdu3Nj1iulb3dYCgVufH9j+mQQ/eLK9aFW2wuyhNxr2s+JvzBWyhO+HM1IE
	L0bytU5a7jz79lUV0jhYAfANfiv89DoJKB+Uxv31ETAa7pL/4w4MqvNORJ11joqU
	/317wMR+NnASWo6lrlvFqcWmbnG7Sf/UWSPALlQxDGGR3j61GbFz3NQ5NtWKhHoh
	CUUnxCddAd9AgUEJlKTyH1p1UN2xWjIFTGACXe5rviHdqC6NM3k72Ph5lBoV6kL+
	TEyY4nTWGCwNDy9WHnGQQ==
X-ME-Sender: <xms:gQfDaHECC40d-3D_3vxP1Xi6lorDuKe-Uy9HJgjeEFuVvvWotD4kjz4>
    <xme:gQfDaEWsA3ioEgZhCX6mEkWy26xOKeY8EJm1NVJm2bCRvZRN8hR-H35fHAHT6rkMg
    yBQL7WysMPdXqVACg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gQfDaLnCcihod3qW2nkOdvzf7qWFCO3R4SdhmOHpUFOrFW_c39Owaw>
    <xmx:gQfDaL_bcHn2mcH4IOsCVfrgjUHsLQ0ZNsSJpBBJa2DLM1xOd3blJw>
    <xmx:gQfDaAqEi1SGMhHKoDPbopeeC7PqWoQaYpTWg4C_KDuY6d6GRgcE6Q>
    <xmx:gQfDaEl8eROR7z3BUlCOBLo9_bQS2Lm0F6ItlE_G9NEQyJP96yTkmg>
    <xmx:gQfDaPsaX4Ten4QtKzfdV-RYvNWChKGGtcgme3bsH-zTvv10dREYf8A5>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3CB761EA0068; Thu, 11 Sep 2025 13:31:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Thu, 11 Sep 2025 19:31:04 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
In-Reply-To: <20250910183418.GA1157772@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025, at 20:34, Jeff King wrote:
> On Wed, Sep 10, 2025 at 07:58:32PM +0200, Kristoffer Haugsbakk wrote:
>
>> > So we just need to loop again when it told us that it found an alia=
s (it
>> > is tempting to just continue in the loop body, but that would miss =
the
>> > case of a deprecated alias that resolves to another deprecated alia=
s).
>>
>> Yeah, that=E2=80=99s subtle.
>>
>> Do you think this should be a test case?  I guess it doesn=E2=80=99t =
hurt.
>
> Yeah, probably would be easy to add. We need two deprecated command
> names, but it looks like we do have that at this point. :)

Thanks. That works fine:


     test_expect_success 'can alias-shadow via two deprecated builtins' '
             # some git(1) commands will fail... (see above)
             test_might_fail git status -h >expect &&
             test_file_not_empty expect &&
             test_might_fail git -c alias.whatchanged=3Dpack-redundant \
                     -c alias.pack-redundant=3Dstatus whatchanged -h >ac=
tual &&
             test_cmp expect actual
     '

But it turns out there is a regression in my code with the recursion
detection.  Compare:

    $ ./git -c alias.one=3Dtwo -c alias.two=3Dtwo one -h
    'one' is aliased to 'two'
    'two' is aliased to 'two'
    fatal: recursive alias: two

with:

    $ ./git -c alias.whatchanged=3Dpack-redundant -c alias.pack-redundan=
t=3Dwhatchanged whatchanged -h
    'whatchanged' is aliased to 'pack-redundant'
    'pack-redundant' is aliased to 'whatchanged'
    'whatchanged' is aliased to 'pack-redundant'
    'pack-redundant' is aliased to 'whatchanged'
    'whatchanged' is aliased to 'pack-redundant'
    'pack-redundant' is aliased to 'whatchanged'
    'whatchanged' is aliased to 'pack-redundant'
    'pack-redundant' is aliased to 'whatchanged'
    [forever]

Both for your suggested change and my v4.
