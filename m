Received: from sonic311-15.consmr.mail.bf2.yahoo.com (sonic311-15.consmr.mail.bf2.yahoo.com [74.6.131.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1CB134D1
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786944; cv=none; b=W+HBrwFOCfuNfAtzcpRJ0KsJRG8omzgl55VAiMHUz+PLum/OHwBFzagMFINF3dCcdz5W8VdNx0TfqGZe5gBryhuWl6NGGvSBBmzjFjGyfJn3FmaZx3Chi2v1SE/Kocm+A2KO1h4ybeY5oOGgK1/Zv9iR9FZZdtONTwLyd2aYNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786944; c=relaxed/simple;
	bh=o2BYm7p5PtOdEMv2y504dRo6VribKqTWQddilYhTGCE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Nn00l2ehuMjw1xkTgCCWolIFg+wvJMGn6wUfhFb7sIHnpe078uhyqdY0532Zqw1FB4Q9EMBLavWRS+lLnZcgtY94JKojpzumrZmx3jLsk2BLSCCG2TArDWfZEbHj6etOto17JccLKARdAs7zW02x6i39ZT+XUG6+u4TpPu/4yzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rlMcYRrg; arc=none smtp.client-ip=74.6.131.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rlMcYRrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721786941; bh=o2BYm7p5PtOdEMv2y504dRo6VribKqTWQddilYhTGCE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=rlMcYRrgQmb8JV9eaLyaX9ybk949f9jv9CGz1P6vyJMesJ01DhAaggtqjNfm0fdBO+jcLw0GNPBMgE2ikoMcc1SBdjN+e2FfDj4rhdT86AtPmU1IMk3SR+A1ImhxEgTcrehm1/WHlu2et8UukbvSkSnVG2B+e+tW3iMpfOBIMQ1Xlks2DoNGqrQFUmyRKHJR8snQJKcqDUB6dNg4PpAGL+68Y7iqZEoH8MQrrFJ+cdx4uCuAgt8JKNfkfvXW4lwTGh8ozC2lJw5qckxLmJ1+atexuEVnR9LKhyIzsZf87Cec93Vxa3poV4Z/wBAMoGceLPQw01zvC/7sZ1mkkzSMFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721786941; bh=3AJEd/OfCXNtX/5GK+Nj+//GClNfAa0ohD5n0MBrvg4=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=N+OwKY8oxsRA6llsmQsQfi1EOjM44ltdIIAKmDPsgX+O0oyilgnXfRKQH2VT1uqbf1dV3CYxyKwfs3ebSwaf3YoPcIbZBTn/dkIrkePorbQXsbfoQ+EiPbYGDSrfaE4hokwShIWFT1HAq1F49oqZ7t5wyjEs/eWLk8VPyNS9nTQ622AHgMd/qUJE6ljwqm98TFu5UFg3WxZG3V/TexTOT0R4s1BOom+F1c8AXLwzut8rYLuqBXjHyAe2DETw+2cRydMRaUOQIlblnGIVkozHBjmCvusG+ffxNzsTL9ggALP7lYDOge1/WyR3pVpa3pYgBT8aJ8cvXBCEtLiQleYbyQ==
X-YMail-OSG: owHQhTwVM1kXP7i9JpxMeEjzJDBR8D9BAh5JUWGxHCoja11PSZ3Ti35F5BBtRk6
 mK49jt1bmTrdjy6Gy52crfGKgkrEgjjiGK34nuy_PeQQ8TcllGj03n2sY6.HI473M.WCstD18So0
 Q5A8cj2ECDzhHSAr3SjZibBubIzS6ZddKZqdbN_aIJdANhZU.2R8Wt01A0J4a0iGCKMbS5dsxGz6
 Pw3YmvgtH2_AklzZZCU0wp4UcLL7qUoHacHnrIkqPMeQxzJfd0UhzilRqPyvd5lRVX8o.fgASysX
 kyP7uEarhMsvkScVTxZRRpVf4kEZUmXzvAIGt0e37vjzLMBwVBSLsZ_VJForplZuVXjwG06303bI
 WULQGeVyRGy2d7TDFjfUpBu9qCujCrGON6hFgR1TaaQk46Um8iF_4v8ULQaWzkZ1gnDsUcDdoaDV
 7sFeCk9T_QxeDMGxue29l3RvnxNYqsITo9MTImOjHxyiuWhHlH14QIj6RALEGwjO4b.gGwfuREfz
 w96.5kvJOCHWwrscqbhUJHmtFR18h0b44bcgVrZtktrxxGgCMqQ8297h5c0exopGZnVpKQJ7gU60
 VLptB62Odgp3mEH222Mj8sOcASuGT6XfCx8nvvLMDqQZAf8Y3tELWBLrPYdsUOqtxj9a7xTG6b7L
 b5u.6RMu0nkBE4qDMlpEvPnbJvNXgRpH4hvB2zDUsesidAlWClVhbyB2YyQbUurz8zx6EMPoMMHJ
 XVvSFY7hLhw207nIdTsmWDk2eod9_khAIBoL0DWq1JAhxAtidjcaI4iGMErPQXKSf3mxkIvgrmv2
 weluiBK90DGud._CP6WvQF.pGSbZmQLrtwLhW9_dvGWVGzUL.Ezk4ZbRhTUyE76Ur7JZNG6WriBH
 9O.wBI5U7EDs52.aGGj4WNoM2s6UY5k6g1.4ZvFc4ipytJt3B27aCyULhRuBZSg56H0WYDHb.rBs
 fCZExO.NF3BrYlj_ME5DLyGKW5OmWOfryHYxYNqnj03sPjIlwjZbQsK_ookU.pdcdtwQXSq6vnlg
 caRKehkNutAIzSx4eUtAdAHjy4.gMbiANxnBg6q7QNsCoQVptfcUWWCU65K9UX6sQFweIQJkLWgd
 OZuTOnb4CrsdTUp4Axwtt0uzm_y6k1INZsbEXSNSjBWZHfbRhXBaJ2pQZASHaCQi5nOW8lTc9BD.
 Q_4doCkAS01Dss.SjV1wkMBYQnfwlGiHbjvYkoqCwMQq6mCd.wIGjYy5O74QHpRK9e20wg26PtL9
 ALjFUUbk18bv0Vdo..dvgsKgrbdPaP.2t3o7qF4cZyXwm6yDP_j4OtNw9iAGrjUVtR_SZoJ9eO4n
 y8dsujSgVI_CsZQotbyNZ_p7GKsXBUd0QoLBDDMIXYcZYZD_rPaMMuM4T9d.ERTuoulCozA0kZ6c
 oankV5VGFW3sLVtXisWqfyJicgfPuqx4nFislC5qHuVEoNhs4F36qNB_.UO1tRwIJQByrS3jC9.W
 0Cllw5MMFvmmtdMO4Vmo5kQzqSrGIOSQoXX3FReI4HP9a4Y.Z6jlC8GDp6CS.xo8jp.ZLj1NWXiv
 yiYD1VioNBEhlDi5NHDIIghM_2csCjGN44XAfUH8Ob4jiV_Lfud38hJ4U.JgyewXi2wWy.V4DjLr
 Aa6lK2nWhedPNZow_h9FW57_UP4awJ.CK1uyosZf1bjkcalQv3kPwfxohSsB7ZPIKe9DU6mpKeQ3
 kll87WW37rx1UI4OGJQeA_oXRNO3j3bGD7msg912N1JqwZdhW3dAt8RCpnz062rH0ooOVQb5PZU8
 4rzfhwxfm0424aasZ2rPkNPKCLitNFJOFKKaZZ52H.Eoa8yfwV2jAcNFlMhr9SrCP0d4irqxMEjV
 _QmRFUKQIkyhZ1t_uHHE5NhCBEQgo_71.VGE.lqNV5FtyF1cgNZO8m8ywNvg7Mn_DYNN1nkddjTY
 9El0vdDV2myL3H7chrAoW0HOyCOKLicmhVB5ApBDnN_Ux4twWov5krXmsCxfE6FO2yAfEKjPe028
 wuk4YcuPF13dbJ1CuA0YvRRmNJEl0w9kJXeSGCy22QBuPxA2csHNuSUgmYyjmvLylLgku6NMoTFg
 X97zrqJinguhvB87SqOz3eP7i7_8NGPWv_KEZl2YILecZx7Q0eaUzmR8dtWWTTr3FyVpDBwavivh
 fTst7DIzG68nHxti8FYwa5oGEzzj9YmM0MBZVObvZKwwPSEYPtWMe3GtMlRMB.4DAgD51kiJaCox
 Jar8qh9Wq07Aum2I-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: d9050487-19f9-4924-89a2-5e488cd52117
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Wed, 24 Jul 2024 02:09:01 +0000
Date: Wed, 24 Jul 2024 02:08:54 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1542063589.2363688.1721786934049@mail.yahoo.com>
In-Reply-To: <xmqqy15rzwi5.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com> <xmqqy15rzwi5.fsf@gitster.g>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin


On Tuesday, July 23, 2024 at 11:25:29 PM GMT+3, Junio C Hamano <gitster@pob=
ox.com> wrote:

> > $'...' is new in POSIX (2024), and some shells support it in recent
> > versions, while others have had it for decades (bash, zsh, ksh93).

> I will not look at this series futher during the current development
> cycle that is about to conclude, but ...

Thanks. I'm happy to continue whenever others have the bandwidth.

> > +__git_SOH=3D$'\1' __git_STX=3D$'\2' __git_ESC=3D$'\33'
> > +__git_LF=3D$'\n' __git_CRLF=3D$'\r\n'
> > +
> > +if [ $'\101' !=3D A ]; then=C2=A0 # fallback for shells without $'...'
> > +=C2=A0 __git_CRLF=3D$(printf "\r\n\1\2\33")=C2=A0 # CR LF SOH STX ESC
> > +=C2=A0 __git_ESC=3D${__git_CRLF#????}; __git_CRLF=3D${__git_CRLF%?}
> > +=C2=A0 __git_STX=3D${__git_CRLF#???};=C2=A0 __git_CRLF=3D${__git_CRLF%=
?}
> > +=C2=A0 __git_SOH=3D${__git_CRLF#??};=C2=A0 __git_CRLF=3D${__git_CRLF%?=
}
> > +=C2=A0 __git_LF=3D${__git_CRLF#?}
> > +fi

> ... I would prefer to see it done without any "fallback".

That's fair. I'll change it.

> $(printf '\r') would work with bash, zsh and ksh93, too, and one
> time assignment to these variables is not going to be performance
> critical.

Generally true, and also mostly non-generally as far as performace
goes, though personally I'd prefer to avoid command substitution in
this context if possible, as even a single one can have non-negligible
impact in (very) hot scripts.

But it would still be very small, and doesn't matter with this file.

> Just forbid use of $'\octal' notation in the coding
> guidelines document, and implement just one variant.

Agreed, and the CodingGuidelines patch LGTM.

However, off the top of my head I wouldn't know how this variant
should look like. This one printf and splitting it later is a bit
meh to be used in every script which needs control literals, but
I also don't have anything cleaner off the top of my head.

> Perhaps we should spell more things out that you wrote in some of
> your proposed log messages more explicitly.=C2=A0 I think these have been
> rules we have followed (grep for them in *.sh files outside
> contrib/) but I did not find mention in the guidelines document.

If I can help with this, let me know how.

> Thanks.

My pleasure.
