Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FF190676
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901846; cv=none; b=G1XizRPOZoc1y1rSnI1Rr8g0CuehvcKHLha2Iw1FNmYMBahjYq5TwL0EWKDzNZWvC7UYmhM2kerPqiemqfOwks1SQnQxdcqUAvLQtwZoqHZKJHabr4o+ilpW8bRvyxvXpJ6HzRnvSTrXKXVrHNrxlh6EWJwu88wCY3ePKdhRZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901846; c=relaxed/simple;
	bh=e/VFDSg46AkyeB9O4XIJl83S2rT5FS0sWr+xdpk4HM0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DzumBnCXWzXup7BnU/fWLWkUcRZoKr8GC7yzlnow9UU2EjGlEEC1ajyzTPK+JKA5F+eEndTcVm28lkFXKtYA+3/G2kQobQabZvWGZ97qmJSS4beXoRYHOsUTenSIFh65oBFOZY/5fgxej5KAuDcALUSnQljd9+RWec/d7PT+8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ARlbLHaC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ARlbLHaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742901839; x=1743506639;
	i=johannes.schindelin@gmx.de;
	bh=3BVjdmZMvKL3KGEKEd31ItvG6D6KRpTMzxujkoJMroQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ARlbLHaC30ssfEujf2rQ9stX3teUes4AKMWZ1T7Vow++hr3riimOxVqU/6KVGmbs
	 PNRvnXW1KWkxpI8qDblUp36cpR5kWSchLg0e6gQ0BAqr+tmWkJ9I31nnsTZoeLvnh
	 TQe2PK/W3nBIlRchp8QbxG3J+ozRYXRp53rnWQuvprQvbsQue9GejvkfqeR/TYaSG
	 IoBz0rpN3wnXF7QcvMpexCN7X7Kpfyw51dyxhcGH/WkcFD5hJEdM8ItpWalH0J8mg
	 4pl6Kb0Mn5Aspb1/vIjrcn6Knu0mkl5LhKYnVw+/zsH4FWmpdd3sas6zMOhnYr0sH
	 02N1bfRXZggja6iY5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1tBNoe0TMF-010Fvh; Tue, 25
 Mar 2025 12:23:59 +0100
Date: Tue, 25 Mar 2025 12:23:58 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Releasing versions on Fridays, was Re: Git Bug Report: git add
 --patch > "e" makes keyboard unresponsive
In-Reply-To: <xmqqsenb70u0.fsf@gitster.g>
Message-ID: <2dd6e0fa-b997-f69c-874b-f424325123a8@gmx.de>
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com> <84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de> <xmqqsenb70u0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AL/kgRk3MsxGTgvedcEryJ3tdNBzS0GuBhzZTdaCPzcTjcGA5CU
 ts31vnOVLqtBuxfigpP5WkvQ/PHvY6QdcFmn3CKGBuZKipMa6C1Fvn9/B17k049tJSFvil3
 VwQqZExWJRVC17SHuG44myxx3m3OTOOXeSeLhTEPQ3wfdOUqkhJsfgq4wTOZpE0weu2FTST
 u++cwliCeYLJA1Xspp/mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:izHsVz2SKUg=;CW0Dn/gJuQEcMgv6iOXuRDC8hwZ
 f6utc2wkmlPUgQENz9+0H3JPYH7wv+6MrJxvB0kkDLO4Wkxamt5bVDfASLzSUQc/gWew1kgkC
 /CHHj8JulrT3ciMUAxq42p3fRuYYBfr6N2ScFzlN4vbhcUELPKu64H2bf15dZR9+N5QhHp5oJ
 /cN/X2R6Ey2K2sQnUtRaVghmfwg1TT+xYbccSvujEcxoeWao3uJuy+IwxljlQPsk+xDRvjhpN
 2lozC96VWpC9/2ka/FXkCJ32fZmIaurVRR5yBznrAYym9/LLG3KHbcj9tcvplPuBo8Pt8GmFv
 D8PdK039pIfdiPJKbs78uT7D0ptUQp+D29b4KP6Xl5ckzrWGY2ff8sT7Jl7wjdJywALxEKhBS
 fKCpDjx17+njBMunBy1JF0Ai1CIaGDs1eJqJv+LRGvOJeI6DCrfgGKtqi5Zy5bMJ/3FGJWlMc
 KoE0a6Q36EEbGAi9PKX/H8kBHB9U0TLkJBSBT0toFmYhg+YkL1JgC7hQ9DEP52aISkhwTMdzc
 Py5Gcs8zEMLAIy7ClZsF6zVtm2zPDYAfsTK2aLvLhHYL/e6FnGeFWJnrCWuEseTHgK9sxAmiC
 YzNmTq/7EIWGueefAGpkc72n89XtCxEMl7bK/L6sb9SNBwL6lWoSV1fG2dzGoG58/IhNPdyJy
 LO4hp3sQwuhkGlQr3+S4Pz2rQZEopxtZeVw2UNemK7HqtttVSFfO7vmn7Gz7FL2+AJwnd/q6n
 Ugw8p8KIJwxZSR/mQchKdYLnl0I5HFlqxej07RgELYFtXrjRdtQ8JAbcJZpdluJlM6wgkDUSP
 hvBbBo04FcuO+MVRfnA6X9j6SM9r/NYgXcjq+Fp6cY6oEg9VMANSFU5nhOEZ46gkNC3X2fg72
 fDqCn0q9CEWAhKFkCHIJtuk1mrgIwe1pydHhBwbrHX+mERzC6g0M//8yu5dc/qpdhMmwMgcVv
 nVuakLaoIrViIe0Xxr+VQyiEm7sRyspYz/wcDU+cwuX/ko9Nks97LBxjAFD0cFdshPVqiUN2g
 t5A2tuZV7r63xu8PIO7KlNV0bmNMA0e7+Qp+TVS0uFYcWI7CEhDU4TACsNRS3ZonsCdPPO5Kw
 HGu67XWYwKeBVZyHUboeUjXAGKJppT3Y3NVD6whe90oSEKVQ6Ch4pF6e8iBHlL2KgA7TedzNz
 8gyswxqnM2MK994yYVj9M5/xAhoEJ1FpOdL3JOYfWbHGUXAivSg3XA28JCrRuMnXU+WhYj9Az
 WgiM5/XnxfLlWNNgzBeEJv4fD6KTd12w1gmz4rsVIf7HcgSSIRDEmvFztvJ8P0gWIrQfUdp+f
 FOkky1wkdO6WQzTnSq2wlAH0yqK1Fyw8cE1SxihNtBMM1FYOtoIj82jDnKNCSrPG/f7zrD+bI
 Em6olF3ibrl99D24SwfncxBCyw9q455aNTtnr9SCQf+UVkKktpjAHzlmv0vL1SGBwSzal5h+l
 NzbJIwk/Lxp7D4BvSXOki42NvNVVGaJnJKYaJrmnWtvLO8geE
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 17 Mar 2025, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I refused to release on a Friday (absent any good reason) which is why
> > this version is scheduled to appear this coming Monday.
>
> Not on-topic for any particular bug, but do you want to probably
> coordinate on what day of the week a release is made, perhaps?  I've
> been trying to stick to the same time-of-the-day we established
> earlier for embargoed coordinated releases, which is 1700 UTC - 2600
> Asia/Tokyo.  But the choice of the day-of-the-week has been more or
> less arbitrary picked by me to happen on Fridays for the past few
> releases; it seems 2.47 was done on Monday.
>
> Any preferences?

I have stated my preferences previously, even attempted to coordinate
between Git and Git for Windows, and I observe that the way I present
arguments is ineffective. Therefore I will try something new: Refer you to
a couple of resources that could elicit some introspection and
(re-)thinking of existing practices:

- https://daniel.haxx.se/blog/2022/08/16/the-curl-release-cycle/

- https://www.researchgate.net/publication/268815678_Why_and_How_Should_Op=
en_Source_Projects_Adopt_Time-Based_Releases
  (old, still relevant)

- Notice the weekday when Firefox releases new versions:
  https://www.mozilla.org/en-US/firefox/releases/

- https://msrc.microsoft.com/blog/2023/11/reflecting-on-20-years-of-patch-=
tuesday/

- https://www.linkedin.com/pulse/best-day-week-release-software-rajith-mud=
itha-attapattu-wvpuc

- https://corner.buka.sh/why-dont-deploy-on-friday-is-more-than-just-a-sup=
erstition/
  (yes, new Git releases can elicit support escalations on weekends)

- https://www.wingravity.com/blog/deploying-on-a-friday-to-risk-or-not-to-=
risk

- https://www.sinergiapositiva.com/2024/11/19/friday-deployments-arent-the=
-issue-your-quality-processes-are/

Ciao,
Johannes
