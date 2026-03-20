Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBE36D51D
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993989; cv=none; b=KPSyGMc3bA20R7ZeGZibR2A1qUMd/SmnLAVoG50a+oB8ZQUqmjixDjnVhjuN37PuF4HkM0/l/rcfDxdh4PzcZgZB3KaFzpVBEt/U+SGexPC3PSHMzMhkutAZxFVfURieumjQWp69551fnbLCAujfPJ8N8bPR1UrzsOo99yIsknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993989; c=relaxed/simple;
	bh=apg2wGoaikvzOGQLOwWfd14nlBdsFEuPV7Qo4LMVVcw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y959ZDBpnUaEkinXJDClKZ6eiv17YHpYSWHA5nXjpB5yKsgVlHt/1e/GWkFZNv7XOb/tElg6a1yVf/43JvicnAZtfvhjHJ+hpuA08cSJ3dhfFymfBaA4jvzsNnuoh1QFWhdXvH+IC8lh9So1jFSp+7SlIFA0a1kjNiMtswwwSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ogIFwEbi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ogIFwEbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773993985; x=1774598785;
	i=johannes.schindelin@gmx.de;
	bh=byiX3QiwfWx0YppKWwRJqhwlmprJ48LAAoN8YVpH/pg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ogIFwEbi7qpcEtT/SxlmnFFy2BEjirEo+c/RYMMVhSI/BG4bL6iVdyoayuEBMkD8
	 5Jf/9ZbZBZZ5aCZi28KmJlmvby3YFjNAZYPZJVMmtFV2KM2uCORSoApIPIOJcYCru
	 d9RCXz4OWI5MOYjX0g3CCRYofY/9/5gHCTctckk6ZZ2R8s1FzCS+15OSeSTs63Z+W
	 wrrzkR1f1yiQDlgZzTT8AZVNvnWg0CDe1FQ7UEI6IJSQPjwB0Kiuc1XkBcHSSStwA
	 kcqtjIokhuyW9WJpf1/s7UDfnQd+ZpxxroLyqE1DMecllLonoZhfCfEfufm/vvnFY
	 WRz/i7mMOFcNgwCvCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1vH13A0h4D-00ZYeK; Fri, 20
 Mar 2026 09:06:25 +0100
Date: Fri, 20 Mar 2026 09:06:23 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] regex: not all macOS platforms seem to have
 REG_ENHANCED
In-Reply-To: <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
Message-ID: <77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
References: <xmqq8qbnigxp.fsf@gitster.g> <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1zDQzvRsVWuDSbIigbmpeSrEcJgy7fIW6BDi1nkyvhExp2hqGkV
 dvrJ3Wkb07zyU8i6yjF2XX7tmGajSvwuygMSPnje+by3LXdBijEN6ejrvfp1jM8J4I3F3A1
 35llBqSpILrkrzs4WHzFWrrzRNvldObhV/P4u8nYhsLT4SdPIm9brpVCehQLBKjwDcbjnpq
 S8wqc7QpT5crT+hIUsbUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Depb5lIswM=;kkfeGMPtZ9FueTc2Lhce0LYhowP
 9BHhL9KVNaZExC7XXrg6vkEhVJyCB9jIHNup3yHZ+MBkPhE9BRoaONOg4XxXLtGkraykgYS3/
 19yLVsI33yFDPxtvgEEf5vV3JE3z+uZN6epb3DNSfix3yQScUepm7SKFAnINt5G622Tm+cYQ4
 9lUZlFW6NZ+4pgOYrl4D5R0qF5hgwlnyP0tUU3DySvqm9FOLIrfQZXuAB0KFLjucp9hzst2uv
 VelrvYFRTpUylq8oT/P4/ly9Cx1jG6wdXeXA+8DVlb75GkCWx3iCWqhozWHp3AkJQzJFL1PWD
 TKfmMXNMUmTPCAxU+8rLaRBNqOT4T/2dw+CkKkwCJ1X3j5/+0fBUxUMed+qC3JKhmCM8mRRLA
 MhWrw85aFpe+/0uesv5o4Guakld+UjinpIF3b3GYEPEleCGUYMVFHiGPeO/GZXiS6h/hMIFgY
 r2nxMu0KHsv2tAt4hSZBarWrEUBKOMaMuEIuykXrVsiZmGlG83ZNJQpwmYtTS3gVGMRLAuA7m
 FGSYPS3d/3ldgueac8o+RO+axtiQCxxZMG+rd1hvab1VRyrGZbOSLfmGpaszD+1IDO4qUZgCm
 GUukldTykCMpmXhxlk5olm/ruGdhLsA/stTTD/sI1s2R/9S1p3rkbA8BcHj0tV2mMthG+J1Hl
 /WnLzqNpeO3RgjO6j1S6cRg6m+QKMFcB4IYv2KcZyXMuAxjLIjJUdS/1BSMszuDpx153PaiJb
 wxwEiEds3BPNxGB2PNFbgHRL/X/fXQJd5hienROFkFWYthG0Wx7rEAjw70sC8jyOZtz0Fkxdk
 44vcVS8ycYIlfalPYBBWK9hq90rAhxP7Gaq6kbuETObY+Sy3AKm7utmB4Q1ruMrFOGbZAobi0
 Hk3C/5s7Q9X1rgeR9zO8f8dSQUDRi4w2pYA6LLw3JvGv4v2cuedU+SZ2o4ftZZjiGx26h6xkR
 Zrt8HPigRc0Q6p1K7CVa4VC6edwdHV7oZRRZD98ObzByiz49R5naak2damJEK2vZLLBIVkP3K
 t8oUSrtx1l0gxmaKVG9xTLyHPMgXTAuCeRBNdWSLDcEtXFsX4o1nlBmnIZ9sx7Vo8TY2leGzg
 beciN/1+JJEJPB/3nILRe+gstmJESF3s5BEg7oL/qiWbzkROipdDgTz6ma51ljWUIFe7kYU42
 D+2qRWiMo6c6x+JGTxEDOuhuNi8HkzFdYBvTT0ODL1tKQRRvWldNzmK4d3rIc+FoLJXtIhDF8
 CVtzpAU6lwc38tAkQxu9ZagcWHVTyw+FMvXbJ8vsfK/1e8W8L+1a3YlU83ygGgga5+03eCL/5
 XlpkbJ57bJHJYW/qF+6ybCG+3OdE3fekrXx/6E2DlbFy9xKwkW+4lE0Thwy69+PAxbCC9ogjI
 6q2c5QdMpvDr/jTHHcaZ89HfsewdE1B0ZEYg5k3eC6EHK35AhNpXUcNwK2uZRVZFouKlgM4lF
 U44TkCm/pm/kRH4X3lNHOGMHcx5u41aiegQPewxnmqEmXsX95Y638bQ+Z7en0amm304gropcC
 OHri78T2NQ3+zAkrNkBLFiLBWUYlohNO5EBMwauhYlMa/Ic3GPI2SonOX2sJ0DEttWokml6bI
 MoZxBkGEHzXdKlOPFSTPvoK8fct7fyzUCzY8fJzm9VRO5DaW7hGua0S9P6RhFmL5RXQLjUiIV
 P3j+Upl63Wopsk1Lmi8XtW2NjOvn23cPbuAp61nOhrUIVRJ07MZd1s6aVf4qxuU/hu84C7M/r
 rF5dljZqRBzMIodwEp678//eetAcXv5pSP6z0iNTx4V1n5Z5mxoeMFieFpbnByMYGrOBdaRDM
 5+J5FuwX9wwN2vMiFqwBkFvOe6zC2+9zjF8/iQ5wCIzBKbiNH6ZrPZu+VRis7AW5OwQp5XreA
 wzmsaQsQtI9zluT1aBkvYF5jVc0YdpRBxCMC3hFC4K1saNx4DzsM8q2VVA8ebna93JOzSG9N5
 6+nXUqpBlfD/YNQMXB+GZQFHXfT0Ec+hY0xGJls5iFPLrfvKKVCPrLpryacucHIJoiL8/X1t8
 I2E1cbm6+kfe/Zoar/KtWZZ0KxJCZ6URgxim3W+v0try0L0D9EMDZnrjz0ATwAvxHwsDPkGuk
 9JmD3R8/503o87eVL265qd1F66jC+I+W2ujdF5X2Sx9uEhKGfr6hYBajH2jWcLL6dZZkjoN8M
 jZlWG0wIAddU6QNB4Xfjs6VyyQqun3Dcj4HjQ0WwCWBJCmVIdDjamFuaOBdXhebVTR53MH15U
 3HCvW9Zve2af1zsspAN6bBKhX4pd8zJ6GO8bJaHRcrCh7Wyy4EtweR55Z+OhnaAHK3UNVTaP3
 NYCSJen2jYDwEy1aeR5iHJP7EjcxaBtwyDI/x4EpPa1atgHbjdKpb5KmSQ1iL7197JzDPUSaf
 4qUWcwPn9BUXKsAb4t2/yozxahgp/t2P89nmAKZB7NsPg0iPFC7UHREAwosG9J/6jC0m9Dobe
 2PpLq06fuiOAjZ3B3Fy4dsdYnyC1SlAJQrqUjsQkpX7kDRaExYs7WZGeH/UXpUT/saogi/U1k
 vQUVdf6+asNuMzS/XD3p2ilG7VCqqjGeDlIIa+zj/Dz4kIFPSm2JELUgsfGsi4O0N/Azp91Ji
 Tz+oztP+pYEiulM6LnGkW7C3jN4qqvgtxamzTZY6f6PXJyBS9OhVsZmTD/T3tCOrZAdEYgeKy
 QZmN/95q70W8dHu7r9KBN+XhG1/xoKIC4an3MZeYFEPs0eee2cwKKyV1xsDNeYvKLvolXmvNd
 GERbnjwA2Qrk59yfGEtVioLS879vi3yznn0MisPQK4eItAxtq74c1aDjieaWOSBhZMOw9aaZU
 O5lCX0b+hBt2KD03xmvkoTWEpf6+nZDmcNHJrHGzLVtmkCqnjrOHxS5g5TyfQd+F06DwslGE5
 dLLE4RvLOPXZCX9id8C6PXbOHktMbFwoO4ppvpMXBmKa9WDNiGUsG7PrAjsQPG08ASkjsMGvl
 +2MB10FxDCcCLWyaPUlxN4tPJCKHow8QbAEt5iwGgScLX8cPj4gymDq+lfP8tdYqA2kxrJiiT
 +DhhNJcYBpPhfgabdxwrXVdqVssO7pkQyjUcbFozVZD2pNChwdJAxIsD7ooiEW0WUOVl9YgYT
 YLmla6vpGH4M78PauAt/wSBnmM3n8A0nF40b8ZWrSRTzVamRs0Vtq4ErrSLSYmwLsMNy/kbSU
 0cojHQIgH7AqBKo9x4swsRJ4ClZgh6yIaRdRDtc0i42Yc4rZaf4grOAYrClDKSW9zGZTsZca2
 QINJ3OB5yY+YJK9fM9IMI2adFjYfChvezM94cgXTiYZjjm7QBs/i2/pZc5WJakZKf8KwUJOC1
 0er4dR1FF7DzGn34rrbocBDZj4CC9cyQxe44/S5tLItjXmkUhjuSqMy1s0N9n4Ck8pAkwTVpp
 ocZcQUUXIG5Im3XJzKuCdN1HGZSI2VSbi18ofCHeEirRxbMDTwbDWri+lZ5XoyneTo5zL/y1E
 UzgvtDFQZXFu/Wqa6Ql+DVF2uHzu+q7fnaPKDb0v0Jmli1HKNFoH6bkJOy7hU1FT9qRJ8lwSD
 8sxzCKifByVL/Cb3ptpIiNEIudF6yWwHInWa4hr73gKO126Lr3w6REoeQuKE/vQkS4frAriSe
 Ff7D6JXTHrCUYRHk15l6Hd2lJ3nNutoGbDAYcdaBrhpVU+M/BifPS2YNazfHUDRJR8jl7uQxb
 sGFP1MuBRk8P6DbaAEyzkz//ueZFWr0dmvcHLWU4bayPynmF/OiUfMFGpKSH2RxcA72yb0DEZ
 0KVp6/HusdqLkdnrWX9zWM2SKrgbAw0qi0TnF0QQy5t752bjfOjatkbKrVel4zU72h0Bn/c8K
 IL77Mrq+Zvoku4egjGFapqlnrab5P99Ptq7uwInS69LruUU09vk6KxzWn72a6xYRZL/I5jtTJ
 1ToatITIu4d40kClZZMUYnCNKVOT1Mcl0jf1unBe7gtMxcx2typdKyMCmSPn2U9Xsw18C+Bf8
 mtU1rm77x8kfDbPxgXyuXsmjGYU7dkTS4JQPUTWn/cKink5h5WGonR0VjCgVzq6Ii5oybkQ8D
 GAKgueC/C9c7S4ewCpmeFTKmxm4uHSrftNjv7MlkzqSF1Sp/1kNkRpRm0nTXJ8Cg+6hDHBjAl
 PVssWnPJMy0TwDv7L2G0tjrW41othUwzfCq11hAC56Zs4k1iOSOZp1qXusrelQg0f2bdyuC3B
 XqkIGRjWRbOhPANyYAHBQ1dbhSHPCeX5BIraYgfn5zbxIJqp19Ylv4C4xM6eDffAW8DVDhDJE
 lBTNHnM8fs+f+NIBeKfx5wjPIuELOI1JbQeBCV+LsLLCwAo/M7g1XDBKxbkRliIzK2J4Qiu4l
 7fI1hMiCSslU6knDWlk5uAHuBDocAvMX9RWzt6q9gyfGM+a/YPmRLyU7M6eRurLnLy5VpDnrk
 0/8+SkyE3+Fq93/yrXvVsBuGrEQlD5bQfl/kwWy63r2UTMAN4wnSCSWBl3THL0jEjl3Mr8q7t
 3PDRGlvl2pPSGx4W1oOn+CUj6SHyZn6tybCjF3UhbGGb+UiFaiQCkLqrARxHbh0QzXtiTC+1m
 5VBbPBAmz8/3szY6DqekKsa8gFmKk5owzkx145y5f1GwQb8L0Et+bEES7qzFEiYHvc3pqGLbn
 Ol+UxBDC/zqfNYrXWQfqY075AbfifxA49T/YuoFlXEuPnMFGMyKHFZ2wBpaBcTypPtEluxXLy
 WmH7JPmjuxPpBjVOQ7WsoXaKIlptYzgqvlvguY7AgO1+ASvvdVV2XHe+dR2o5PyFsFdh4vQ9x
 adHTdpfAYXLwiMOCddpIOEawqxzwruRsfdyrG6bdt+eDI0jwJxUL+wdeAVDCPtdV1AbFZ+xi2
 ZRcVBigC5r0ijPCP0RmYXb0WU6BzoyW+iv80ieCjaM3w5EhKiTrJcfJCeUhxMVmjCyTV9AFe6
 Jgl/EroKmGOdEUSACpQyyEKHQqlpHVN0iiyiIYs+eWf2PpaH8n5VyoFb2X+GHQ0IKihWFqo2A
 ZuaVO7Fce86IlrsMZutbVU9QEVq4WRUdXzNsSOJFuD82keZO31jbuex8kyZblMooqk4cwKq4F
 eJhN1duiRogQLOvaonFaa2Uhel9OMry9VZl5x0QwFYnj7dTt+dhYw0HTABNd+4Y03TxxRu9pO
 OGoMPshnhJU02oo4gwHe1lgslsGwjPstsVLnRR9q3X8KWr0vQ+onRrELCd9j1HqbNeuqph5U7
 b68llNCuI4hkSUx5sKI4KBItlLith4hvXds69FQ2L6TGAZOmTfoxsEwkXBgE9GMIlECl2VaPH
 8C14/QuHH0vVw2CdbYLLRYvzFpxQvrYAm3LK4foMxRdnPL/IzA8JQIwEp6G8kD5BxGu0UYvBa
 soXDVyQ+EvrjHe9uYHBXBFuS/t7dzNdMg==
Content-Transfer-Encoding: quoted-printable

Me again,

On Fri, 20 Mar 2026, Johannes Schindelin wrote:

> On Fri, 20 Mar 2026, Junio C Hamano wrote:
>=20
> > Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
> > 2023-01-08) started to use the REG_ENHANCED option when ERE is not
> > in use on macOS.  The build seems to have started failing on
> > macos-14 CI jobs at GitHub, however, as apparently not all the macOS
> > platforms have this flag defined.
> >=20
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  compat/regcomp_enhanced.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/compat/regcomp_enhanced.c b/compat/regcomp_enhanced.c
> > index 84193ce53b..51e1358170 100644
> > --- a/compat/regcomp_enhanced.c
> > +++ b/compat/regcomp_enhanced.c
> > @@ -3,7 +3,9 @@
> > =20
> >  int git_regcomp(regex_t *preg, const char *pattern, int cflags)
> >  {
> > +#ifdef REG_ENHANCED
> >  	if (!(cflags & REG_EXTENDED))
> >  		cflags |=3D REG_ENHANCED;
> > +#endif
>=20
> While this lets the build pass, it _does_ change behavior. Where
> previously, EREs were enforced, now BREs are silently enforced.
>=20
> So it might be desirable to instead imitate what `meson.build` does,
> namely define `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` on macOS when
> compiling with `clang`.
>=20
> But that should already be the case:
> https://gitlab.com/git-scm/git/-/blob/v2.53.0/config.mak.uname#L151
>=20
> > ifeq ($(uname_S),Darwin)
> > [...]
> > 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS =3D YesPlease
>=20
> So: hmm.

Ah. That flag _is_ the reason for the build error: I misunderstood what it
is about. It is not telling the build process to compile with
`compat/regex.c` and using enhanced regexes, it is telling the build
process that whatever regex library is used _does_ support them.

So I need to pivot and recommend something like this in the `Darwin`
clause in `config.mak.uname`:

=2D- snipsnap --
diff --git a/config.mak.uname b/config.mak.uname
index f9ffefa67a4f..572f8967bc36 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -172,6 +172,10 @@ ifeq ($(uname_S),Darwin)
 		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
         endif
=20
+	ifeq ($(CC),clang)
+		NO_REGEX =3D HomebrewsClangSeemsToBeMissingEnhancedRegexSupportAsOfMarc=
h2026
+	endif
+
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
         ifndef NO_PTHREADS
