Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801E190661
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099652; cv=none; b=b0ZncqIEt5S/1q7zQYiVWRgbO2gr+/ObZ0JkDuUH1sN+2/tKm0pfX7r2F0xolOVJTIgtwBkFlHrejbDtwBlOVLjes2PN3Rtfvuvb9RJuH1515wCb9Sau6MEtnS/gGb9pkvwaVVgBnNzSOrciMw/Or/40FE1zlxPHmcUEGiKczHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099652; c=relaxed/simple;
	bh=FYFVFWZwf+u8DHYBHlhEg8JH4fYjJV6vKmp2Fu24Npw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvt53Kmq4qwEV+bv0J5k05WUz/bMJpdOYJpUoCk+sF8Y/7VzMK3scCAbF/S5GrptM6OyRb3ZvRnQyj5y7onZx0jOKRpgtsUBy9Kg2ZMsHvnRHVA9qzpwG35ukvGtIhgFqN+sIzSutcyqkomGYizBmGxtaY5kGGO4Uw6nB7a/xfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=ZEJyDubj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="ZEJyDubj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739099647; x=1739704447; i=tboegi@web.de;
	bh=rg7aAMWKiHXqA8ywgzzewjcrC09mrll7Phms7cwL7uU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZEJyDubjAdjmz9C2zfuOX3rYM7TiyW//UYvVJKx49sjPNwwjVtZqBO+kMtD2Y6Au
	 b5xCWNdvlT7Mz7VggnupKBy0vHfkBSaadCxfQcEpMwA8inGXXqyjpg08r9LPJ/U7P
	 FXrZXrvGpl6vzLbENoTJpa88YwFUY6upcoTOiwoukqLcwQl4dvKlpLlVfFm1KldWJ
	 zJdpDeRygzzfUjVY0S2maIpTMYuTmSRmeKK976Bl5HyR0BxPImy6vjAvgbqQf+Ff0
	 rgxD1xcMMSuhfVxtingJhRV4HVGrMGvxAv/5wbHdmt0ZH/0A7mNHgJAE1B/Scmzd5
	 /In6yXEWueGuq1SQFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1tQF242KV1-012rvn; Sun, 09
 Feb 2025 12:14:07 +0100
Date: Sun, 9 Feb 2025 12:14:06 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209111406.GA12069@tb-raspi4>
References: <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <20250208205709.GH30202@raven.inka.de>
 <20250209092514.GM30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209092514.GM30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:KWSsDAtGFGwejgK1XoBVnieXPGwUXrNoqmTGxBSS+mL5G8tQF0I
 Z9X0oSyYUE3YXdhwzEsGmnig/kg2D6chPn4hC7sYZlML4k7oNJHWhPBEU5VSqGDIGP//bIw
 HbKuSmtS/PytDrjP4/twO/yuR4YZ4FT7kmg+TN3wxwwPLSQLUdIyUURJPZOxdbuDyTEbLXP
 9ryiHJqQc4LV8H6tq0DaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JaDhKd+EdMk=;19FKtbOzQJZYitw5K3e8b139BJJ
 7bAjtdA/VvolBMHipAcyGsMRaHOG5Lry4KvwtGeb7rAwflsmBC7b6UUcP8EtuvczTxkp1dNDN
 SH4+0Mr/mRD/DEStnTgszs6nSS5j82DNykPIRtXVgdcrwUBMDR8pN3LRqOPRL2E+kWQxixcbg
 g2NmROymaT+ZeOCuqEtU2YrWl4Rb6v8PBkGlYSc1onVe/DXigxVh+bQfCKJh8bsV8qpLJp7S3
 pMJRnBa5vTv7uadWoFHy5IPGUDsE89w5/XSkUea15oHJ8lNDoZTrDKgduoq7dezef6oGV7wG1
 uKmtDZA2Ux+4OtvwFv5KPd1EZVCbPxb/0H8b73leD+lh1Tyz/MDEo2NbD2dMvvhFLYwW0KMly
 SQAYuNdsJhbvqjmQLFjHoa2EPAgdK11ChgOi2O8bjRf0W++CLIttu+4mhVA+ST1RUMRxW1i6j
 GxAJ5SH1Q7TU9M7S4VrQuYq5JluMzlLQwQmBHFqEPw0gdDb8T/JTdV9CG4BepF3bYhp64iRdn
 8x/U61/c7rHJzAz5a4XbZGHojyBQue+Ywfq0shlQyUeqXYFNInocc3kvcVNEkbIowA5R/OWYh
 fEzoHNoVCxE8DDiV1mF/384PgG1KcbOsOBA45La796V50k1zhl0Xb7bYM8jd5y0npJ0czd2Hb
 /yvvZtz8O+q9pDaNTsrzR/S8f0dMbCqZD4UREx+BiagMY9Qm966oa+SKBgsCdfl8/vlF71l5J
 8rBcZMd9HKpxf5RwqU1a9z/iOfsgJcsCp+yoiIKubwhZ3/Nqh1x+aBnAkVU9gJvl/HByYDbK0
 xT+v82dwEl+gv0zg51sQTPCuG6wddnX2E8WojuPVUhU7AWDImQimZH9RL2t7USfeArmW7N36J
 Jd/YyDj+sFZXe4INBto/bqfM4v6x7nCmmeIJQkxdFnrSMc4ebAUAXr9Bdjq0cOlr0qOojWqVP
 euQq9J41J3QKSGbhp9JbPSQuZ7ihjaAGMBHioTay1OuBDnSoCDyEosmuRr4SDithsNDcbIzmC
 XpskQFYCN+GvJKUn7WIFPlF9mrWRplShNbDFMriuoyYxu0GdZ8L8dFVR7bDipP1VBxN79+WEn
 SAkER4AMWCDticDVyfMeJOzC1dscRJrN4NYqtuTK26CMxnGIPqiLouGQDBTiVgrbrfwgAEtCR
 RUddt8izv1Fs0dSInCSufhvzch5+Wb65uK1kEfS/Jh0bHCyg66fpHTqOUNpq/anxYkz8Or0Z1
 iOQnaERp3r60NrBay8INGGYZwx7sMtv/8JQq/Q3GhZFnBuwGYLH6wcx20XjbmthNsWe5XEnny
 08ioNcU2845wrfjx3rqPGCipncyuLj+5IaLQBDjiDo0n0kz1jeGXIX8AN8tIHoucEcmuxYa4w
 S9GhRZDQwXU/7n2kKh1m6fsGf+S5yL05n9QB6zF25f/KpA/8I1kBU3KrZ/
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 10:25:14AM +0100, Josef Wolf wrote:
> On Sat, Feb 08, 2025 at 09:57:09PM +0100, Josef Wolf wrote:
>
> I just stumbled over another wirdeness:
>
> > Oh, have I mentioned that I am not only about line endings? Yes, I men=
tioned
> > it in the very first mail. In addition to line endings, I am also abou=
t XML
> > files from a proprietary application which reorders the XML-elements i=
nto a
> > random order every time it ist run. So the clean-filter needs to sort =
the
> > XML elements into some "canonical" order.
>
> This application stores the bulk of the data as text files and XML files=
 with
> CRLF. But there are also some binary files. So I set gitattributes like =
this:
>
>    # Catch bulk as text=3Dcrlf, rely on git to detect binary
>    */*     text=3Dauto eol=3Dcrlf

This looks a little bit strange to me.
What happens if you replace "*/*" with "*" like this.
*     text=3Dauto eol=3Dcrlf


>    #
>    # those are known to be text=3Dcrlf
>    */B     text eol=3Dcrlf
>    */P-*   text eol=3Dcrlf
Same here. What is B ? Is it a directory ?

>    #
>    # smudge-clean filter
>    */B     filter=3Detsfile
>    */P-*   filter=3Detsfile
>    #
>    # files I dont't want to touch (mostly binaries)
>    */*.dll       -filter -text
>    */*.ver       -filter -text
>    */*.lang      -filter -text
>    */*.store     -filter -text
>    */*.ets5hash  -filter -text
*.dll       -filter -text
(and the same for everything else)

>
> But "git ls-files --eol" gives me this:
>
>      i/lf    w/lf    attr/text eol=3Dcrlf      gt8/ETS/Projekte/P-0113/B
>
> Why is git ignoring my explicit CRLF setting?
>
> This is on linux and on Windows+MSYS2. I don't have $GIT_DIR/info/attrib=
utes
> and ~/.gitconfig also doesn't specify any line ending things
>
> --
> Josef Wolf
> jw@raven.inka.de
>
