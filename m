Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14E2BAF4
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389202; cv=none; b=R93Hx2Iu6mk8vFF8TzBGLlvBCdGmNjQUDwYxD1nOrKQ7tlV1pCjwkzrdm7WV9qfMONxWE4/tr0JG1gUnPKB8wI2xMIfCmdQaT3n10ZNahc3P1RZteus/ffkFoQ6yEIX5kdeeCzOktIfgGjFByj0N9cNg2mVfhQFfmh0Yb/X6Lh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389202; c=relaxed/simple;
	bh=8uiXgEbKg5W3qFXr8UmT4aVwheujmj2E9mRqEQEGl/0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FXWlygnH4H087WMlfl2Pm1wFNHBid7VMCKcXvxKpenbpG9PBnFp4xvj807DS8+L7dfjxBakrk/NDE5AwK8dbok4IwecL1Smz5h2gZSl7QA5TNZv9u41TTyfJHP1dAHIwAkCQUpuLVdd4atdNvs3ARadQesZevEZ0T69iFM1kiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=F6xTxGqt; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="F6xTxGqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751389186; x=1751993986;
	i=johannes.schindelin@gmx.de;
	bh=A5beL1J4wCSxWNbo+65of+iuZq9LKudPb8AN4ur6Ico=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F6xTxGqtKpJern5R/RltFsuSUgf5LU/i2Mz1cFb4slEEHXrQCIolmJ/gnqqDypqR
	 Tzlc0wAQfWiotarqYzMyv0GewDuSdRi6tn3fxh3cVBV/fjwaWcff9xAjzhaVZ3kzd
	 G5zNf9TuL1/DujItY/KrY1l1gUf1MDxUu44Vg5D6/3i7KAhhe3ERa6d55IuKfA6HG
	 pz+/PMnBAfMWqwVo7DFgMS4sV00dZf6ZMWkTbBhJZahR57j1bdbqYBmC2o5cxrnFj
	 C1n5CbYr0wG1CUuT9W3m9wq5XXbKYch6o2rx6dcsyFoXebuObheiQ/LWhItmBXdhs
	 RGLR2Kb/CbqWQOHhYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbW0-1uTvK80cZi-00ENSF; Tue, 01
 Jul 2025 18:59:46 +0200
Date: Tue, 1 Jul 2025 18:59:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Toon Claes <toon@iotcl.com>
cc: Junio C Hamano <gitster@pobox.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org, 
    Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
    =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <875xgcq9zf.fsf@iotcl.com>
Message-ID: <49a3ae89-850b-64b0-e3cc-70a068171352@gmx.de>
References: <xmqqmsa3adpw.fsf@gitster.g> <aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net> <87msa3quzs.fsf@gmail.com> <aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net> <xmqqbjqi5tk3.fsf@gitster.g> <875xgcq9zf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IKUopc2LNv+Wgo7IQRkTvQcm0cy99ayQ69o2Sl116FUVNBn+vkR
 7YJ/qfc4GP+gL27okwjI+zo7Q5DC2BFl0iSkRDStDbOqI2vKNHP8fm0vhxX6+GFmnqXUIuU
 IQUmaeAOzhZicQF2mwAXSTFwphvIWSosM+MEFyvDhkTxc6C4tA30TVd+VDDnes0ud+N47d+
 5NfQ06N/sflXZ2QrztQPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zreSDlttMPA=;ypP8AeU6TbMfhFjX914SF40yBB7
 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
Content-Transfer-Encoding: quoted-printable

Hi Toon,

On Tue, 1 Jul 2025, Toon Claes wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> I still think that if we're going to have this functionality and
> >> expect it to be used, we need to make it the default, build
> >> appropriate tooling, and check it in CI.  If it's not
> >> fire-and-forget, people won't use it.
> >
> > There probably needs some balancing act, as I already pointed out,
> > what clang-format gives often do not make sense, and the point is that
> > they are not about styles (where we can safely say "no style is liked
> > by everybody") but about how readable the result is (which sometimes
> > is subjective but more often it is not).  Until the tool and its
> > configuration is polished enough, blindly applying the result with
> > fire-and-forget mentality will degrade the quality of our codebase.
>=20
> Allow me to share an unpopular opinion. I think you either fully commit
> to a formatter, or you don't care about formatting at all. I realize
> that's probably overly strict for most people, but I've been working
> mostly in Golang for several years, and having a tool that formats code
> and it's output is unarguably the standard is a bliss.
>=20
> I think the only way we can stop bikeshedding about formatting, is by
> adopting clang-format and make it's output the golden standard. We might
> not like it's output (similar to many people do not like `gofmt`s
> output), but it's a standard. If we have to wait for clang-format to
> support all the configuration options we prefer, we will be having this
> conversation over and over again over time. I don't think that's worth
> it.
>=20
> Code formatting should be the job of an automated tool, not a person.
> It's annoying to have this back-and-forth in reviews because it's not
> following the standard _the Git project_ has set, while it would be a
> lot less friction to follow a standard that's set by _the formatting
> tool_.

For the record, I share this opinion, and I don't even think that it is
unpopular. There is a reason why there's ESLint, gofmt, rustfmt, RuboCop,
etc. Even cURL comes with a helpful `make checksrc` with little room for
distracting nitpicks about code style, making more room for a focus on
correct code.

Ciao,
Johannes
