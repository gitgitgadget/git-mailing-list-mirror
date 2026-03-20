Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423536EAB1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005127; cv=none; b=FepG1GR9+P1zZ+IPbD4Yj49buUwmYJunYxinFCvMNq4FKfW6V9AGu1rQ3zFSBXXc0WIWX7DKtz7NQMayiHsomOdFPvwzCXhlFovlqbnWQZ3YWrmkZBo2MO3yvf/SKRi1dzTgMyr5Vpa9G8MacWsppAWjU1h9JIuag4fHyX4mkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005127; c=relaxed/simple;
	bh=bbkHs12Tk9TtWnvp0fXQT+eYz7ORktVbQNEIf6QjmVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMug2cNqkYYhP56A+M7sjKvVbKGN6NpZjDUur9XMmnnQhh54fHfA3yURxYnip7HPK+AjbRgMxb+JyF34P6T2dR3izuLZTY/ttefvCcIFe9Yc0eKR/pc0FYKKRxahlsh/EActcCD0g1tgeRCm0qhH7sCmszW1YHZgxOyQyE5HUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZBJuT71M; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZBJuT71M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774005120; x=1774609920; i=l.s.r@web.de;
	bh=bW4AT7O6WA/GU3RIdN+N037mwZRskFa5MhfxG6Gjvmk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZBJuT71MYiOlYFr3Pp6XzynvWwWJa3Kb0YCv7DQsgeKk/EL5dlBgGGHf00nKu/qE
	 qymgxxkPgwsF7ewnsiE2ZmacC6YFBVK8XePh4+nErb4ua65fJ4wTV6Gf/5I+atLcf
	 HY6yG5jPNVaNhhVrsYhI7PyLUuReENgNpAZ48ojZwbcKQF/cYb9K3MCFndxqh32MV
	 iv9EBSEScrJwl11nZBpOss8jsFokloiTOoAzeMxlN1qY9R01IN74n4PjfmreYrhie
	 6OFM2VSq5+fhSjTBIM/8dD4FQtOJRxqjqcCi03lJHVNTRB//SrrlORtY8wlBJY6KD
	 EaCzXOC9V6hFi8DUkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1vQu2H3ClJ-00qRcS; Fri, 20
 Mar 2026 12:12:00 +0100
Message-ID: <5b8e24c2-452c-486e-a143-386e06a75e03@web.de>
Date: Fri, 20 Mar 2026 12:12:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq8qbnigxp.fsf@gitster.g>
 <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
 <77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
 <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:euS88GZlNFaXOI994kFReE6ohmMbYwhEy5va0ad+m/Wdyqi+ufb
 aGakvpWXMyI1s/abO9k19F+e9jmtcdOzjK2B4O0HEcXMdX0b2Y6+eCNovLWKXZ4NedCKB6J
 bzu+xLJJ9CTg9JqyEAg7dGJy7qEACsmB9CoJp3SBd4yNteMi/LVcYCh1C+eLqwZFRuoD3M+
 8GFYNGBq1L5UX/5XyDS4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Omfsh9mw7xY=;z45wMSS9HEkSrkpYwHD3lXYbuvD
 SqqR26TOSNar+n1jTaj2xuZfy5qZuofWJZHuX/+CQWulwCboOjWEYL5RXSVzRpfKyNdz73NJl
 HqEHSJPwlD//HqEGOBG0s5GOoa3iNzJOkTSlem2Nj/iQ0lRf0dlMI4Eq6b1Viltg2F6n58lk6
 o+3WqCps8HrYMnZv1mscFhHWeZnCIo4wcGY7y4BNzkc+Ag938vkvdrclXruenyZjH+axRIFb5
 kAK+L+V0qad1U93Vublr7lunJROXNr64CjePYEjFyIIyk+F3pllK7YYzINrY+jo2eGO7V0e30
 JfD/8RiAqVuiHu1n711edkE+uB3yGkjrP25DEYFdM1kZTG6AIo52UkQDpHi1zgxRLBSSSDo7I
 Gi0H6CAGJ9UgSuwLFP+gaBQ6qD8DC+MyNPvz2q1EbMwdtJIKCYXLDS/kn9QZwZRUGhexKB1+9
 XKgiv+zZHkCPtmfYVPN7xxv/l+xldOdCw39Vyje15DhSMkgYKFL1dQmfvTRReh5jPXJKu4vMp
 8zj3zA5stzxD+3vI0u1EisW0d6h48njjGCYHW6zVC/oU2vpGqOVB3NTswDOW5DC9g1Gbgcfm6
 5t1Qlp3os2Asfayk+ZATSileapeQjtV5AOARtAriMWXxt9PUo4/8eHpobSEgPp2ThBSp1PPiK
 VysRttJkdDqb+7XxD4s+abSzpkEDgCeY0kl4XX2Sbm4IMjttgeY5gJcDy2s0LMqDb8rCEetgy
 Jj1/cd140OWbF1rKcVI7cBsErRD2qGpRQTI/rjxpXaneT/QBkZocK3A9P4z6CjtLVpLxQ8hbg
 REn0lvk98zZhFju6K/YHQTsqrAs9M9gAloSkqBsURdkBE+d0/j+KROYCr0xmFZsrR7AFqBj6c
 axRjxq9Le3A368VmViFyIu59zndBrMpl3Ks5MecDaRBpZBtV/zFkMGHhWkLHy0nlVvvELvCOs
 V1wT0HIHd5VeoOks+V+LJJCdouV8bvlQ9PTwBiF3zZqw7to8zkCKsyJ8VAdf1Ku/EAkvQd7tD
 V7Dsrc48phxvY3X9VIAaNrrOZiTUhwj9hr8+DtYnupRTnGWvDQ3YYKR5K8/sZ3B/a82CcyK8T
 nV87l0kH6ZYTOOoSCMDuwniNuoo5QqCjuPvDjXZA3mKdRNYm9puAHKg4HfctagNJd66DPfYp6
 kt4Oo1p0q5IvVwat7bHX1ZtUKbG3zan8eFkWqYVdzGQjR69Vs3YVa0zLsNeVKXuL1bey7x9OC
 E5M8mYqxLiZoc9ydUCH+LjRxoEvh/CEwCByL6+4XtSg1WxCf3FrghBgq4XVdvKnHoHuXOZCWW
 sa2s+YzQ6yh6EYWZKXH/jMCtw8BHWAXxbqgGrjl6MN/+5TXYDSDFYpCRNPC+y9lsO7l12eMWm
 ucchYt+xMjM8fi6SAUrcO2/aGb7aQnLOklUWx5idV+zdxEVENLV6WWK62EsDHlKvOxwX8nnzH
 KmEOEmsJpvE4En2M7UHJrubNfcYnoBzZ9Of831U3pkPu6Av3I0gSeUlByTDNJtvIMoNSTTM/y
 HLAV4zUgebSjbHOh6TShX+I3Ll0RVahdeyvNlr9cOZVCw0CpHMT1Dqd2xhZ1SiZ5q3bxhMyoc
 nO4zOFtSV0cD2V/xMlBHLTTQAw4Qi1YYHE6hzH4OMXJd40MqLZy1fY8tQmbeyVl0FWQ6IwWic
 /2/xHbwNKY6VKLcBj8nyWkJNml+poivM4PF1yDyZeERFpB3JJtquwrXoUfKT0QviocHq34qdt
 3N+KTRYeueplzuh2IX+Wc3a9IgEqe+DWZ33qW0HYJivBNe0jLebWhcv6hHdhXr51cPBvzbQxE
 Du5OqVxKfzxHqIZf9emoUBoR1c2UzPQpFv/HiN62cu/Jo/4tMsfPNVBNCb3dLjCL+XP+LnSg6
 8MeqvgjWA0R9JKsvTdXRQAZHIEYZ9Tk+VXc8EK+rKkoXJl8ipv2TNz9jeqhIqv08SsRvSoQYi
 HOsVxU9QxKlawrZgXnxC8icIA9k5p/pE08YhY0UFjKLDuCHpNA2WRdEzAc+L1CW/wtSLOyEJI
 jj6XEA6fHs4qtxl+OOhu+oha96EMnOvKI/SVgCDbyecC431/vBfTIIBoAxzlCwSW6rr675Ojz
 KQqkROQBiBJS0HYFnyo41RU/hlCWFC6HdeyfNZngbEblaYQ61mKsEeoP4FdJ8ogp+J17eZy2B
 cYY/fbspwx6P/5ywqzZt691AJAxz6KHro8Tu0iZ86yBC+zuckifbU41/hlqAyS3pNBNCpFKSh
 uWTbJUls4z4jejTl4wLf2Gdiv05SfRH2wzz2pZMvpmyjVR3xu1GYYf2MsT1Yc+mFCq1NgIKCu
 mOB7G6dVtpKx4S3MPiKrUQyvxrThDbEdbHFmXTAeel73OV80NvIR+bEoG+bb5SNl4IE3j0e7j
 muwQXRq+WFsSpiqpVz+2/jQ/CwR1thFwSUHRD2eOmI5uga3+sH+Ka2E25Durkzh+5xW9IZ5VJ
 Kb9kNRk7LI4Hb0JsQwTeZgGvI7k9h9RdEs6IzA/TZmtXfoaRQ5DDzekoTwiYMzkm7NTMfY4vW
 oI3qTxZgv6Y4boTvpMwyzNcfPos6EWX7cYbkDv73gF6ZXDXDeX0DOufYR+NLqi3cTLluIKh07
 SEULKbuViGuHKiQr2fOaK7f7msHYkEsiK745q+NWTT+wjtk+5hCTve16N2C3OeIgDD55W039C
 CpebTPTRzVntqFZiarUp0qEd6LMYWNksYsd5h0N0jy3D8zfbiKxNvoNcHoYMJSY1LfrHhIUr5
 Ywtb/ZBAN4u2PzOd0bh3LbnFqPcUtRFKwHsQu3XAPWPkA1Kyq9GHWjaIQHau6uvO5bT+sTtIh
 oXxAn9O8IdZFHJDisueVmWeN9kMa6LeTmM1A7d3xVSAtJl1ANW8tHwsZZkzZMigtojnyZfI0j
 XERHBkK9Wv6ah8ayO/X7t0mSDeX7M/9qdTnr+oedk6TjooyDwu9kRwAm7ONSI+6z8N94A+z9t
 HpEFCXOt4c+0E2jYz7iALmeQ49UwE0HAWjt0ZI7jPL/yFGFpDb/MlwKPxAL7gNq+rFloJi9Yu
 w2M6x7N8nXlDzDwDdbHfSzT9YIEtownvrg3x4LCCbnmOWjqBxSHOPgXgb451BZRtg+Ewa3V+K
 7RjF/lbFIN7BD4Rayunw1iheZBdIYF8/sEil4vz2VFwDJyFo3iCu08uys4Qb3IT+FaXDsmnD+
 rhG10jpRegMIO+DiPFEms3gRKAOz71GZRPqjfQWz3RnZ9fQlM8lYH9YkWRGCvBKWms3pawhCO
 gGjM/KO5cohDL22brZ65krNYKM7eYpXmMC6Sd3EIBWwfzvkpgcDP7JN72NxUUL8DDLAYTDYz+
 yzrZTNtNhXmsFUMvI2Od+OWq5vKJe6tYG2qzORljySkFdgihhne4P1mbL0Rj3oGNfWqlRNpZU
 NNFG0OfjpdvLjS0ao8E944GWsmBDPF3JKYSPjRd+IUAoN6Jz4K/imr0lmxLC3c6WHCZurireu
 cdMF0wcAZkC4I/kF0pRxuifdhHpLs1T6zbWS2GrBOXiF9lfTZ8gJmYG8Ts+RtmtNu4MZ20IxF
 QUxSePkRGr7/LQm9TtxIFOqWTGR68Km0UMoscakuSSKjPOyUTXRaMH0E0bHMCF4LoYnICSY4m
 8+lSchbVTIWFM+GF/YxvoD7hTU0Z4yhlVQ08gJafFdi4qeKUS9VIUbPkywR6lpsJtQe3UT9Ml
 X4lV8XaGwVhmCK5qNrNI/TMUj39WN5IlBXmqnFfqdIhxk52Rp/8UN74PluznUXfgC4t1QeFOE
 fv6zBQmyC4HlPW8qefSd81zyyA2CKtIp93vDCNrkM2CT251V0+f+F7rnSrDYYd/S1wmrztm2o
 6rVElO8HtPILS/lmxmfX/udiwrQI8YYx8JtG2GTStIG7b1EgmPWhqy3J6e5jSVMsqr3LpWEeg
 ZcW00i+yfdGKOU9AGk75wdsPEIZKB/IQINYh6FGs4yiOY+JT1nyO7gZmOLq2ITOG2TJ1i8WZQ
 875iJXi++SALA/U0Q/rxKG2BWNdwPBQ3u9ASvZrHKBvSZabaCNzdvg0IiSQ0+OiyMmhixl9bf
 kIfOiU88tgB99YD0E/gk53kxqBBxhPQve5mvRjJ1mCkD2x8HNTZJWTUtllXkpsMbmf2dvNbt0
 qUx6H0PFb1Dscbp4HCjKm1c2hl2LzoMjphsvG1t/c2vuVZGWdetc5+FU3nmla34qQjBdy6gs3
 gLjz+DKsNu58sLAd9ywYB06y+emPLXgtachu02GwhApQNjfzLKjle+N2t7CIrVuXvpz/XRjOe
 PC//OrzqK1T5F5+s9uNrFi5OYt633kQSANonq5M8ZY/NZt3Yz1e2RGYh673PYRLcYhy8TxL/D
 hFXev+E5DbXvCn6ZzqI6zNqcrNubKx/TVjV5vTYx/rJaz4QAG8I9Pi4/bUGl2ZQP0IdMcnhER
 RwrecU3vZ58z70ddtQ5TyexgM67yiUCZtCV+l8ajhYyGwfsZ7dbr2epJbfz0wH9acJa7/UcwE
 pGAaklEDxO5suWrrLgplY+7D8H8oPVUzlp7Abze+ILi126x+NDc1IooNEvavdWn12g5qt8tJk
 D6KiovRteq+cAbsuW2W1AJg2E2I3X88StmVy319UNH/Ec7WDBZ3fGpKqDmrPvNvvrlwuGox5x
 gXjedK22N1YJj9T19xHcLGQPj8kpLYkVKepNdXVYyWEhy0Emw+UBP41mAgewuxU7EfJiKSGSq
 UQy8HW7pg9BATmD6GodboX96+1tFDdOLbJhofPQuhkbMixRuRsFP2SH3mTe+o9vOmHhpjMuDQ
 b7GOq9eD/pjDUtAXf9ae3vlBI9uulooMOpIxShfHZq/tftNAPX7x7Mka03b1cyy2L7ldJVpd1
 IALSqQFZkQwxQ5J1cKlCxj1VM8cPuMM74HnUak09tKKl5yN0Cvph7jo01HgB2Yd7BPEptKUdU
 HrpfuuFWNlyoLF5F6zvD0Wtv73xRFL2fliKHtvdnRPvWBfvb/AweVis0nOZAeNwrppCAGEpZn
 1JVpBRuxKMx8m0UgPzvDhnCtXaxGlTNci/GxLscLEpV6S5ENN/EerHjf3AswMR3z3LLR2QCOL
 VbJ9JB8GdqJOcF2QdtHsgPEfJV3HQDTy0uzPGeaC0NUFtVGd6t2SITm24hQAC0ypyMG804wMh
 a8U4s/c8Wxteb9uBy2yGp2yikvfv3YaObSu4Y0iFZN3y3wWuvEKT8AxA9W3jHCCdYhWfWZx/a
 2Z+cpOE7xxirllJiI4/XmXM1iEKbp698kAaBIP6LTrRsLyTuX2YVM2cinJ7EKhUZlpB9SkrFn
 r107IsWc4FLFioQ8YANsAiFZyq0ygo3mdnPtFlVy3IfElYRTrLIYY5Z0xcgT30pgK/P9GLLm6
 VnzZkjB/ZX0AJ5OE5KPl5ojbbC/ZXlrWJ1rhJIinyVaBp6VCc+IK24=

On 3/20/26 9:55 AM, Johannes Schindelin wrote:
> Me again, sorry,
>=20
> On Fri, 20 Mar 2026, Johannes Schindelin wrote:
>=20
>> On Fri, 20 Mar 2026, Johannes Schindelin wrote:
>>
>>> On Fri, 20 Mar 2026, Junio C Hamano wrote:
>>>
>>>> The build seems to have started failing on macos-14 CI jobs at
>>>> GitHub, however, as apparently not all the macOS platforms have this
>>>> flag defined.
>>
>> [... I need to ...] recommend something like this in the `Darwin` claus=
e
>> in `config.mak.uname`:
>>
>> -- snipsnap --
>> diff --git a/config.mak.uname b/config.mak.uname
>> index f9ffefa67a4f..572f8967bc36 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -172,6 +172,10 @@ ifeq ($(uname_S),Darwin)
>>  		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
>>          endif
>> =20
>> +	ifeq ($(CC),clang)
>> +		NO_REGEX =3D HomebrewsClangSeemsToBeMissingEnhancedRegexSupportAsOfM=
arch2026
>> +	endif
>> +
>>  	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both requir=
e
>>  	# Unix domain sockets and PThreads.
>>          ifndef NO_PTHREADS
>=20
> Turns out that my analysis was not _quite_ complete yet. With Claude Opu=
s'
> assistance, I was able to find the exact turn of events that led to the =
CI
> failure. Here is my proposal for an alternative to your patch, Junio (th=
e
> https://github.com/git-for-windows/git/actions/runs/23335584918 shows th=
at
> the build completed successfully this time; the tests are still running =
as
> of time of writing, of course):
>=20
> -- snipsnap --
> From f65b3b657c36e9132624ea223c90047527edea59 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 20 Mar 2026 09:09:10 +0100
> Subject: [PATCH] osx-clang: work around Homebrew's clang lacking REG_ENH=
ANCED
>=20
> The `osx-clang` and `osx-reftable` CI jobs on macOS started failing
> with:
>=20
>     compat/regcomp_enhanced.c:7:13: error: use of undeclared identifier
>     'REG_ENHANCED'
>=20
> The failure coincides with the GitHub Actions `macos-14-arm64` runner
> image being updated from `20260302.0147` to `20260317.0174`.  The key
> change in that image update is the Homebrew version bump from 5.0.15 to
> 5.1.0.
>=20
> Homebrew 5.1.0 introduced automatic linking for versioned keg-only
> formulae when the unversioned sibling is absent (see
> https://github.com/Homebrew/brew/pull/21676, announced at
> https://brew.sh/2026/03/10/homebrew-5.1.0/).  The runner image installs
> `llvm@15` (keg-only) but not unversioned `llvm`.  Under Homebrew 5.0.x
> that formula stayed in its keg and its `clang` binary only lived at
> `$(brew --prefix llvm@15)/bin/clang`.  Under 5.1.0, because unversioned
> `llvm` is absent, `llvm@15` is now auto-linked into
> `/opt/homebrew/bin/`, which sits earlier in PATH than `/usr/bin`.
>=20
> The net effect is that `CC=3Dclang` in CI now silently resolves to
> Homebrew's LLVM 15.0.7 clang instead of Apple's system clang (Apple
> clang 15.0.0, bundled with Xcode 15.4).  The runner image README
> confirms this: the reported "Clang/LLVM" version flipped from 15.0.0 to
> 15.0.7 between image releases, matching the Homebrew LLVM version
> exactly.

Good find!

> Homebrew's LLVM clang uses different include paths from Apple's clang.
> In particular, the `regex.h` it sees does not define `REG_ENHANCED`,
> which is an Apple-specific extension present in the macOS SDK headers
> since at least macOS 10.12.  The Makefile unconditionally sets
> `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` for all Darwin builds via
> `config.mak.uname`, which pulls in `compat/regcomp_enhanced.c`, which
> references `REG_ENHANCED`, hence the build failure.

I suspect it uses the same regex.h.  The definition of REG_ENHANCED is
gated by a __MAC_OS_X_VERSION_MIN_REQUIRED check, though, and that fails
because __MAC_OS_X_VERSION_MIN_REQUIRED is defined as
__ENVIRONMENT_OS_VERSION_MIN_REQUIRED__ and that one in turn is not
defined by the Homebrew version of clang in the runner.

I can't reproduce this locally, by the way.
/opt/homebrew/Cellar/llvm/22.1.1/bin/clang is not linked to
/opt/homebrew/bin on my machine and also provides a sensible definition
of __MAC_OS_X_VERSION_MIN_REQUIRED.

> The `osx-gcc` job (CC=3Dgcc-13) is unaffected because Homebrew GCC is
> configured to use Apple's SDK sysroot, so it still picks up Apple's
> `regex.h` which defines `REG_ENHANCED`.  The `osx-meson` job is
> unaffected because Meson does a compile-time test for `REG_ENHANCED`
> (via `compiler.get_define`) and simply skips the feature when it is
> absent.
>=20
> Work around this by setting `NO_REGEX` when `CC=3Dclang` on Darwin, whic=
h
> makes the build use Git's bundled regex implementation instead of the
> system one.  This sidesteps the missing `REG_ENHANCED` define entirely.

Or how about using /usr/bin/clang explicitly on macOS instead of any old
clang from $PATH?  That would avoid user-visible changes.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/config.mak.uname b/config.mak.uname
> index e6efd0f30913..c437accbcc50 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -162,6 +162,17 @@ ifeq ($(uname_S),Darwin)
>  		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
>          endif
> =20
> +	# Homebrew's LLVM clang ships a regex.h that lacks REG_ENHANCED,
> +	# which is needed for USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS above.
> +	# Use our bundled regex instead.  This became a practical problem
> +	# when Homebrew 5.1.0 started auto-linking versioned keg-only
> +	# formulae (like llvm@15) into $(HOMEBREW_PREFIX)/bin/, causing
> +	# CC=3Dclang in CI to silently pick up Homebrew's clang instead of
> +	# Apple's /usr/bin/clang.
> +	ifeq ($(CC),clang)
> +		NO_REGEX =3D HomebrewsClangUsesARegexThatLacksREG_ENHANCED
> +	endif
> +
>  	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
>  	# Unix domain sockets and PThreads.
>          ifndef NO_PTHREADS

