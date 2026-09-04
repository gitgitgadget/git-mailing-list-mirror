Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF552D2C1
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553961; cv=none; b=sqte31cOtHRyPRDaTMBSLgM+7ZZqBorwRk8kQinLn8hpjDmjDQ5vvPGBSu0zXSEliWGqA6tQ8D73+CCUZeoaon82S28IlruL6Yjix4NZOYYyspAJNU6W7Ete0JHt99ekW8nXom6L/4uWj9uk4bcNxfC+iXV/2y2Yd3h17oGwa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553961; c=relaxed/simple;
	bh=NGYu2mVEymuDjOSy7zsiQayop0oCT/1g9RiTz1B3inY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rCk62jwrxhjAu5FSO0VsfCgUAUTq0RRfUrUzhmSXTetHSodQb0V1b/TiwYuA0Lz+Ttyf4y3V3KcNNKdL0Y98+2CiKcvQC3Muucud5Se/pkp9joQfgjGxXlRCF99fiEbtpH9kX7ETF5IZrmjTVahO/NZivb9NnuHmTUU/nsBHc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com; spf=pass smtp.mailfrom=artagnon.com; dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b=I5NkqBHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tehdnWUB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artagnon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b="I5NkqBHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tehdnWUB"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id A219D1D000B9;
	Fri,  4 Sep 2026 16:32:32 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 04 Sep 2026 16:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788553951;
	 x=1788640351; bh=KARdYzIWz1bFjGqrxQz90UT0oA64EbsNgIlmf9973u0=; b=
	I5NkqBHpHaKqmg69Fdutqe95n/D/l2Bs8JVfGBh3BzAAbGA+MVK7UwqVKyaFBU/v
	3rMlRoLpFm9psS2jJtNLx0sGF2BE+jqYsfdbUd45uKQRRELSsmBSrkNbz0i1PU1F
	mNA8VYr5MzLcdyDvYE+J6XEpWDzOuF5mre4YSCqWqQ8Urr8kLzMTvHPdaKUvfkba
	G+LPS3cMK0CAgimZnEiQoNxHj13iTXy+vi78pqdqS7J7U7ZsV3DkPBN1ePeN9345
	QM3KlnQAHwBKNZuI9Ls1GI6Q3nM82oVhHjixOETr2SihPAkbzdK8Dzke6YkZIbyI
	/oaNV3nihq/ka7viWZsKPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788553951; x=
	1788640351; bh=KARdYzIWz1bFjGqrxQz90UT0oA64EbsNgIlmf9973u0=; b=t
	ehdnWUBAn4PpzBoBqqnMT+RGnT1PIbEETULGVbK/sr/Hu72vHDP4ir88J9PGEkRd
	7T63jcNZPEn8Wfv/+8vatbFcg0QPYDZxEtbYbgErNoeeUdc7cZVFjBMC++Xv26uS
	TQY0Ymn2LiPF3P5oYjXPv2kyM2fRLG2X8Zgq9WoouhO101+U3xoXjBwouJPkAkV5
	wO6yCSA4WEoh4rthpmZtE1aM9o89uIuk4wQwO/HOXA5G9D0j3dnsFQg5JiqRg/WC
	sqkb9WO/rI+xE9af/tKDLT1o7Cq8zdzy2SKHDGKI3d0CSSeB6LLEqQhWl5cYOIUz
	IjK9psadiPkOlR7Kzg/Ng==
X-ME-Sender: <xms:3SqbahZ1gypnr8exCuKqXor6dp1LQHd1Mlgtz8o1frl8nyFflMB6dw>
    <xme:3SqbajNyARVLru7Gt8v0AS3Gz0-J-tJNRFkUcu1aDnWgY48RyhSXVyCi4-8eqqC5V
    i_Z8_67_qaEFrwuk72KhkupiCh_m5lxdpDndrlYaX_rv3XaWyLt0E4>
X-ME-Proxy-Cause: dmFkZTEsHpVO4oMLOWTsPUlWZREZsY64Now6js+Ia5MfhdeMy7vVRWECWIR/0tZlaMOdvp
    Lmmo0NjLnZNPgNUCBf8We2DCn6wp4AIZmYZSFPwbpzSmY+13gqB40hZFbkevjhKpOpIYz2
    2n8v4C48/XDEfaSsZi5fR/97LFKRT47S14SPsUaYZhp5Ge4mRqMUoAq/xDZbUvSYDxgB3R
    jpgfwV9WCDy75y3RoKX4KiAKgT7tc6af8bp92sYIdcIG1Fg3mbPKmGa0nw4zoAcsymwB9+
    zMOkh15XqtRdqDTjzXy67cqdvpXRCBMTVsKSliYCmw1Dsji/Uw2XJn96wBRFF2RqDO5skm
    6aAdsLOpihp+iLmfqDhAC6JrCiDyQ+5oYI9VXOAQ/BJ9kEnHUjOoT36paxM2F8/muffZ8E
    umWimYeCwrVKC86nf6BBK6uNYCd8BZDkzmEuLqErQqQD2HjijlYOXeqrbucFAHdItoaGxu
    6+myHfvjBsD94O55p9bdgXeEgyMD3XC5LJll/hrxSPbb8GaI/yjYDMTrY+Pdf4UcJQKmDh
    om6DwdyLQbNGSV4fONx2iEuqr6tUrQiYeyL7LHtp9cL38HZgHEHhUAGEQ3F6AkgkaI/n8h
    vU0WDW23SSNS/AReqZGz/3pM4YzSAmMIM/UcMbdY62h3zIrDTI33pUdFEtxQ
X-ME-Proxy: <xmx:3iqbasFNjRuonMh2B27IeqZHcH_qmTnpNwU0aroK5ylOvJ7IHTB6LQ>
    <xmx:3iqbajTKy-K1yl0rMWtjkbgqOyGTKsjPJ7ndJMab-71yu-V170I5Mw>
    <xmx:3iqbattNJhJ1DlQ_dSQpVTWEvpPk5JXPf1R9tQ5iSQapYEPaCJhCKQ>
    <xmx:3iqbaqzTvXEUF9VpadSLOx4h1FwH3Pt-dMfhmIkfQy8W2faSGiBI-Q>
    <xmx:3yqbairFGYjpv3boeoFFVGvt94Jrt7oUYP6gIK_2v8zdQ8EfO24flLbl>
Feedback-ID: ifc014702:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EEA6EF80083; Fri,  4 Sep 2026 16:32:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHWNdWDjOfzF
Date: Fri, 04 Sep 2026 21:32:08 +0100
From: "Ramkumar Ramachandra" <r@artagnon.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Git List" <git@vger.kernel.org>
Message-Id: <5ae09f8a-4acd-4c70-9088-3322195ed08c@app.fastmail.com>
In-Reply-To: <apsaaQrngwYIVeVM@fruit.crustytoothpaste.net>
References: <7fb200e9-ff28-4b22-9d9e-dbdec83c2835@app.fastmail.com>
 <apsaaQrngwYIVeVM@fruit.crustytoothpaste.net>
Subject: Re: User report on git 2.55.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> On 2026-09-04 at 18:05:43, Ramkumar Ramachandra wrote:
>> Hi,
>>=20
>> I recently bumped to the latest version of git on macOS via homebrew,=
 and here's what I've noticed:
>>=20
>> 1. git-replay now updates the ref, simplifying my git-reply-checkout =
script. Someone on this list recommended it to me in response to an issu=
e I had a long time ago, and I think I can safely say that git-replay is=
 an invaluable tool. Thanks!
>> 2. git-pull often fails with a dangling remote ref error, and fails t=
o update the current branch (main, in my case): the workaround is to res=
et-hard to origin/main. I'm not sure if this is a GitHub issue, or a bug=
 in core git: I've never encountered this behavior on older versions of =
git, with the exception of submodules.
>> 3. git-diff sometimes exits with 0 code without printing a diff, even=
 though the worktree is dirty: the workaround is to run it again. I've n=
ever encountered this behavior on older versions of git, and I think it =
might be a subtle race in core git.
>> 4. `git checkout -` sometimes fails with an invalid ref error after a=
 pull, where the previous branch is a local branch. I don't know if this=
 is due to a background git-gc with some behavior change, but I never en=
countered this behavior on older versions without an operation that woul=
d cause this.
>>=20
>> Before digging further to find the root cause, I'd like to know if th=
ere is some explanation I'm missing, or if these are known issues?
>
> I haven't heard of any of these things and I usually follow bug reports
> to the list fairly closely.  I also use Homebrew's Git on my work Mac
> using macOS 26 and haven't run into any of these things, either.  I fe=
el
> like my colleagues would have mentioned this, too, and I haven't heard
> about any such thing anywhere, including in our Git users channel.

Hm, perhaps what's somewhat unique in my case is the scale repository? I=
 only observe this on llvm/llvm-project.git on GitHub, which gets 200+ u=
pdates over a 24-hour window, and measures 30mn+ lines of code. Also, as=
 a former contributor to git, I have the habit of concurrently running g=
it commands or terminating them early when my muscle memory tells me tha=
t it's safe: it's hard to pinpoint what exactly, but I don't think git w=
ill ever leave the repository in a broken state (I know to clean up stat=
e markers by hand).

> Do you maybe have some sort of security software running on your Mac?

I think it's clean, but it's still a possibility that the workplace inst=
alled something recently: I don't see any other strange symptoms with an=
y other software though, and everything seems to working reliably? Perha=
ps the most common task: I run llvm tests over 30 times a day on differe=
nt changes, and it never reports any spurious failures? I will neverthel=
ess ask the IT team at my workplace if something that I can't see was in=
stalled. I don't use my personal laptop for llvm work, so doing that com=
parison is not possible.

> That seems like a thing that could cause items 2=E2=80=934.  Also, are=
 you
> having any sort of other disk, hardware, or other problems where files
> sometimes go missing or don't have the expected content?

I suspected that as well, but doesn't seem to be the case: the laptop is=
 less than a year old, and I haven't observed even a hint of hardware pr=
oblems?

> Are you using files or reftable as the ref backend for your repositori=
es
> (or a combination of both)?  If you're using the files backend, does
> switch to reftable (`git refs migrate --ref-format=3Dreftable`) fix the
> problem or change the behaviour?

Thanks for the tip! I was using loose refs, but just migrated to reftabl=
es: will report back in a couple of weeks or so either way.

p.s. There was a small error in my previous email. The update to git-rep=
lay I mentioned as the first item happened one or two versions ago: I re=
member updating my git-replay-checkout script around February or so, whi=
le 2.55.0 was released just over a month ago.

Warm regards,
Ram
