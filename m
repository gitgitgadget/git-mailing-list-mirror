Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C161442F4
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621438; cv=none; b=F4bDb1/X9G0EUovWVsk2wQ3AX11tFLRkPNGQoGBh52bThh8T2QCk4x3mLy9zlNZ56QTh0c58bYxG5AtH34AWSWq4CVRT1wa9HOu0MJ6KmwsPI/8rxsUOXTldqVu5NPyz4dpDzQr/Zj4AJBxw8RFXqNVOwd5VjqdezkjJ8oCgqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621438; c=relaxed/simple;
	bh=zJWPe59nDTqmz8WXhZyrmBoVjVcctLfLdhauaxghwBI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cT7dcmJvhaS/hMtIwfBjk0ODgJQ5eoqGetJhMHQNYfODsJmDhpT+OCionUM4ztsEvagANzQDa4qWetyQKJKT4ER4R7r4021r8PO+YLVjDEERzc/NNucibkS7yGVvWOZH29qOJSvEURXccnEi8vQfXmcqlJRWqfsEx6Tfu/VmA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Ib7O1ZAs; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Ib7O1ZAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743621434; x=1744226234;
	i=johannes.schindelin@gmx.de;
	bh=4mb33NDHovw/TOiH3ve+szXUfk95M9nD33IAW7CT11c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ib7O1ZAs+Wochoh3+N9y51bT8vaA4OjIRvzlkQ13NQqp0i/zsp1wP+vrK09sWBPy
	 vSS6oLaCGG3qXqKdPz1GZDRy978g3np8hMiCIxbhqWvq+l5hpDDX89w8dYK0TntDZ
	 +Ze28Xk9QySVZybAc4y7d/FwD8Hq3ipC40YPcRzN1CY9DvynRGM+lLLbxKRg84AJq
	 JAQM3vU0Cb7WNCDF3JpJomrs1wIxTQ9HFp4i9SfCeHkWFeRJaG9DU3skKLYjdhO/B
	 rtkSPAcO/Sbor37fhtTlBt3BpIrXvstQyLvhx5CXvsOlHmhoSM16U6yE5PFXBMDQI
	 2j6Gp5tzWZVI7Q3Jgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1ttDwh1v9l-00DTyi; Wed, 02
 Apr 2025 21:17:14 +0200
Date: Wed, 2 Apr 2025 21:17:14 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 13/20] t: refactor tests depending on Perl for textconv
 scripts
In-Reply-To: <Z-zkVL8cSYEiR_T1@pks.im>
Message-ID: <62c3f77c-32f4-8c24-560d-24fac9b2e807@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-13-b436de9da1b8@pks.im> <9f477166-5667-a051-13d3-43d56a7a8ec1@gmx.de> <Z-zkVL8cSYEiR_T1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LC6JWNVbClf9Ye9taMNCfhyf9hz76VaDCVQtQJ7Y3/A6fVeoNVy
 DIV8nZFbnqtjUB2wS+V08ix9HUqQgJtLQ2EbTgfSGqnpPpmlgF6JS/5OYYHUM6mVJT+JZIV
 rfTZ9yPPKRNeHL2tDPxYzRsWMa+9cGAM4BFCZUAL9FhG3FiaSQZtaGNc5xyV+Nxk/GowBd4
 KbROuBYw0z9JcRCIrCeRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zKnB92kK0BE=;lydjwqM0UhHRPQzM/t58QtE0+jX
 iQ7xdIwbBagneSm+QhQs98Z3R3T0tV8+MwjEoYILaFRspRXEOVd+Xm7IML7UYdEPAogVIqkEa
 0RSg4HyIvVaayNOB4OxgoVE+Ji0Sn7x8j63JiPNj8QWpFJVvMtG/l5hNCNJRI1XwEGSvDhZaC
 p2kiuMqLjwtWwQqZ0SXFbLW5W25f/isFwwUkv9YMqJpNX2QMIomncvWaVt91X432Tv3zPZddA
 nhOoUu+4nCBg8Cz2ayMH8SOd+2oVQbaERih1gWDYl9Hr2M/AfIn6Ua5+0B4I2XSaHr2EmdCqF
 5m0m83F+m1p5yRJg2gWtY0GoLDygUyn+OtGXd4cUdyh8L3WWUlk8P1nblRAx42mBJqL/eD/Kw
 t+Eqofulsqyv25Sj5wVboLIwZAofLfVoK/of/KHMmUmn517TyGbBKseDDFcyDdMNva5Z/kmAL
 Dx/SH11ewk/PgLmEwdHApnAvVtLRQo+Lv8SolUIanZdAuEhJaq+kdkZnmHsBKH3eYIddNFQLQ
 Owrvxvfs0AzRw//sOrfzqcmr7XEMRsVSV4IMv7HEIce9LlpVHpMVyk9l0NHm0vewERCzAJB1S
 5Z1H03ts7wewktGkV16wwxWHyq25WupVkyMoCg5slgHLw0WlMGQ5gdHvj4YuxFuzqRv7mghoL
 t2dLPZMPdpLGmzC3K6y1U1igYaa/Jl/H96YLnuJNyvPAH7Xo/o1JLF06vWefH6Bf10M3oPFCk
 mUf8w9/Tmr3l+47QZZT76rRxnksFZENJ9wNR83Dn6XVTHjHBBX2K41QBm9K3foDoWLsOqTAIL
 XyoOs/kNRh9viiqR8ijUZQL+rq4Y3EvkgOnK9pfe4oPPc+oPiwgJ9DCqHaW8mDEBo6CUSV9by
 YvHOIYsWwnuZq9wpiIAnSI4PPXWS4dLinWIqui1MPpSQdHgvOv1f7z2Zls18jA3Yo63wtbd5h
 pAf6jc/1+EhaQ6xcC9Jr4XxR+xhH94HVGtnPWijS82FBdVBJYbWMyeiOeOS/IPZwnfQyPg815
 +V7iqchLtEOym8BOJLNWSNthOIBHB39lzOUBezuAPpJ5aqGq5pDDVQNdANkHIxnKKd3ggyxTA
 K9QQWILmY2GS/Y1qGXXr/mHkEqu2+96AX5vqLbGM+Lu38qbxNRnEPHQz2khwPf38ufG2jG3Qd
 JTg2dW2nWCsyKtKeqdWIClwhMP8gNhrfYIpbHfs2U4laIctb3/eiU9TTAZqi+0OVM8s4H10tu
 mg9+sO/U7mmjLQSB/HM7YH0cuPrJXl4uX5DipTzIEcbI9xzJkq+F9lHCBe1JpRYtVccQzDuKS
 lSswwLrIIIOYXtMVYhqOQUneF3r0NvDLOecVCOTjhem3vr1bgRmeLowgxv3kkakHZ7y0L2Zia
 QWL6XTLFwjZcaGo5wVw3ZzvwCfnTIVIHk8JeRCjxR3aThUzfKlmz0hRu/6TxtpTy7AiiWZOnt
 iTXw1W9l9+J6qYltsb2d+9/CpNnEb4AGNF8jfKgVVT7cHxNSr
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 2 Apr 2025, Patrick Steinhardt wrote:

> On Tue, Apr 01, 2025 at 08:55:22PM +0200, Johannes Schindelin wrote:
> > On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> > > diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> > > index c7d8eb12453..f904fc19f69 100755
> > > --- a/t/t4030-diff-textconv.sh
> > > +++ b/t/t4030-diff-textconv.sh
> > > @@ -26,13 +20,10 @@ cat >expect.text <<'EOF'
> > >  +1
> > >  EOF
> > >
> > > -cat >hexdump <<'EOF'
> > > -#!/bin/sh
> > > -"$PERL_PATH" -e '$/ =3D undef; $_ =3D <>; s/./ord($&)/ge; print $_'=
 < "$1"
> > > -EOF
> > > -chmod +x hexdump
> > > -
> > >  test_expect_success 'setup binary file with history' '
> > > +	write_script hexdump <<-\EOF &&
> > > +	tr "\000\001" "01" <"$1"
> > > +	EOF
> >
> > So here the `hexdump` script is written, basically replacing NUL and S=
OH
> > with the digits zero and one, respectively. I wonder why the script do=
es
> > not call `test-tool hexdump` instead? And I wonder even more why no te=
st
> > case has to be adapted below this change in the same file. I _guess_ t=
hat
> > the reason is that the file named, creatively, "file" is initialized w=
ith
> > a NUL and a newline, committed, then a line is appended that contains =
SOH
> > and a newline, and then the test cases verify the hunk _headers_ only?
> >
> > If using `test-tool hexdump <"$1"` would work here, too, I'd actually =
have
> > preferred that over the `tr` invocation, even if would still not be
> > recapitulating the functionality of that Perl script (which, contrary =
to
> > its name, seemed never to have output hexadecimal values...).
> >
> > To be clear: I do not suggest to change the patch, I am merely puzzled=
 why
> > the more obvious `test-tool hexdump <"$1"` was not used here?
>
> Phillip had the same comment, and I was trying to address that by
> improving the commit message a bit. But seems like it still isn't clear
> enough.

Or I am too slow, that's also a possibility.

> The reason why I decided against using `test-tool hexdump` is that it
> would have a ripple effect. The output generated by that helper is not
> the same as the output generated by the Perl script, so if we started to
> use the hexdump helper I would have to adapt a bunch of tests in this
> test file to update their expectations.
>
> The result would look something like the appended patch, which I think
> is quite awkward. On the one hand we have trailing whitespace in the
> expectation, on the other hand we have weird seemingly-unrelated changes
> in other tests. So I shied away from that and instead decided to use a
> simpler variant of the textconv script.

That makes sense. Not only would it be a chattier diff, it would be even
harder to validate. I would probably have written an entire paragraph in t=
he
commit message just about this decision, if only to get frustration about
the state of Git's tests off of my chest. Your decision to avoid spending
more energy on this than you already did sounds like a smart one to me,
and I am sorry that I forced you to explain this one more time.

> Let me adapt the commit message once again and make it a bit more
> concrete compared to the current fuzzy description.

Your explanation is sufficient for me, therefore you do not need to send
another iteration merely for my sake.

Thank you,
Johannes

