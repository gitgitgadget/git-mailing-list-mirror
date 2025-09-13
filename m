Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3A22DF9E
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757800280; cv=none; b=AqnI9imCFVhOtg8VcOqjzwWLSfYtKBFeCChuRXYLDDVYyeHzGo4pXHC/0a37X/ghfIvWq42iTXp2k8gcNwqoseDK8/zGdXgABoYGoH2H1xsJ3WVpk0tSRAWD+/raBKqzLQ2LvB0mUN9xZyRU5YBp7/zSWc2m/mHM63+RqxyDCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757800280; c=relaxed/simple;
	bh=DqBo7Y0BIGNNyATt4f5XwmAUyi2TOu2tOJEKgAM5Wcg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ktXy/Q7G2hX7CHqWecXakUT1eRuNBmvNcUnzkgZmmvCFHa8shKK7Lrtu3/V7RFmDS7+NfeJnYRJNavbc1T5jk8zEK2wva+BAizhQtwH9GPxpAnf1Qurj/Y/1mZoKV9k5UEYxdTuJIe78hwQCbin34nQ0KafO3+DLdQRj6o0H4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=douItvUX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ci6R0nbM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="douItvUX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ci6R0nbM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 13188EC0079;
	Sat, 13 Sep 2025 17:51:16 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 13 Sep 2025 17:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1757800276; x=1757886676; bh=f8849SeaqFb95GopZs94Utu6H+H9aqNa
	X6Cxkp7HZKU=; b=douItvUXJsQ8Qg/7RheY9Kp8OxkZExcmCU+P+/lZpcT+Whks
	+Cqx+lkB0zWCqA39ixTF0Fi17iTXc7Fn88366XVf3rYV/16YrpBQ6TE5AlcQkLY/
	twHnMbfRzE1ffnKSAdZpJAQlLNL0Nek1Hj/DuUSU8+mBlgS7hrH+L367xJd9e6oe
	L2JxqhMeOXfhT9Ydv2uIRFdFiV793GuUsDa1PNT53SqsU9f+rK3LmLm09bpD/xZl
	j3UC86Ahulmyq08JL0awuQcQ6ToA50DPKWZgBVRaJAqcdOPoAH4J7t5cbzDUoynO
	vnfJICWyK7WlwOg1as77a9OqGNnWHHvYQqD7YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757800276; x=
	1757886676; bh=f8849SeaqFb95GopZs94Utu6H+H9aqNaX6Cxkp7HZKU=; b=C
	i6R0nbME8RJcWseFHB1MEsmHaERpN9e3tVZMiIQo/74l896Tjej3/dOqm9rFW/W9
	Fp5PhvE2Bl9aLnefbCTc2uHOPbtmtqjk6zyFftGt667X4uYi2aCfWCXTplgPsxAl
	0n3gUZzQbaArLK/9FcOIzCOfWLrAzMtR/dUhT9gWvsbRF/6xdUSqZoRSNmwhgbnv
	xE/ZIrA96nksUM0ALzyjYFnnLWfQZnkhTzNJ7L+CKizQaRsS0pssmg+NNONZm12l
	rtAQShzbGIv5WLd+sYJlKtGhgGfAe/jNmzM/0Sm190WQsz24YGpzwrVAD2lvQLUa
	ykrWMyG49j7nwrajA3PhA==
X-ME-Sender: <xms:U-fFaDMww8WDdd7tr_3-3BVmVgFBrMWzG4SFnTeQz5vVOgaKzFm3r2o>
    <xme:U-fFaN9zY4JO_HtOMIOSOMfYB2G-E0wc-J7kX--rFpX6muFIFo9TVYxIZKVmk1jiN
    GpzdjZFgumeJ-HWAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffedthecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:U-fFaEvMyAKqHxRs5shr-lKqoyNZ1VteHnVA68FL5EuOfFZDj00ytw>
    <xmx:U-fFaOkaRCsJ8Qux1nWY2mNLkaKOiauX4k3ZTQenpXTFSC1-DN2hZw>
    <xmx:U-fFaOwk9XxaZD3vAdYZJyCXQm35tZxCY07fRQNzKHTvecVJLLu_rA>
    <xmx:U-fFaIMIVnsaRY94V9Bo1GaHIfzW-fkT4eSIJpRMoHEQhQ9kAVf95w>
    <xmx:VOfFaC39issZr16ykfjc2UzA8aARkjIZJo7Ikkd-WtYWyYgxGl2BFaZU>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E3B51EA0068; Sat, 13 Sep 2025 17:51:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Sat, 13 Sep 2025 23:50:55 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <56a5ba02-8bbf-4726-8a76-ca0fb5a38e53@app.fastmail.com>
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
>> Thanks again.  My local test suite passes.  (Except
>> `t5801-remote-helpers.sh` which never works for me.)
>
> I sometimes see failures there because I've checked out and built an o=
ld
> version which creates git-remote-testgit as a built script. That was
> later moved into t/t5801 via 5afb2ce4cd (remote-testgit: move it into
> the support directory for t5801, 2019-04-12). But if you have an old
> built copy lying around in the project root, then "git fetch" will find
> that old version first (because it prepends the root GIT_EXEC_PATH to
> PATH when it runs). So we run the old version, which may or may not
> support what the more modern test needs.
>
> And deleting "git-remote-testgit" (or just running "git clean") makes =
it
> go away.
>
> That may or may not be your problem, of course. ;)

Thanks=E2=80=94that was exactly it.:)
