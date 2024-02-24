Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D1E560
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810958; cv=none; b=W3OxRxCT8Dy9qA3ieDjW5rJTOBmya3DuTk6Ps4UOwuscqBxnngpe/AMzXvUqA51vzA0nbuGs7diyFdoy6iOZa7Nf1a5SFs1/7tbWxAZW1oMImCi9nPeCU1BMN37Wzq1YkBOEKL4KEpLYJhUUMd1zwztRHLzIj8VbrY47YvCDqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810958; c=relaxed/simple;
	bh=KpR47w3gy7QhZRjU6o5aB3e3c8gyyxIj4ZEVTUkKung=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Q5wjEotR5D1O2rogAt/C7GqcoX1poZrwlCK9g/rKckBfgiypwHGErAd07ZIRnQHmuYTAg/Qj1x8YajHozaZ2S8Pd0WR9oxvnisDG2nowi2Wa4EXBDW8I3q7jAtJ80x+GzpkiBjUC+38quUuhCV5CB+82ehCvcHUWHHOQBY4wn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=H3Awfz8Y; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="H3Awfz8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810947; x=1709415747; i=l.s.r@web.de;
	bh=KpR47w3gy7QhZRjU6o5aB3e3c8gyyxIj4ZEVTUkKung=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=H3Awfz8YffA8OVhgTbF6S1UBEidmLLiauMUHxb4SEojNGAnPYQfNHgAn+MJCz2qj
	 1KqRE2BGR/MzFusGF0gSJFsnaUhnBCPr52LkbwqRe1uIoL/MAcrM9Tf2S3Jyy9vrs
	 UiqifdpYSw+fYCU8AFCSLqg818UpqQP2BSwmo1GjVLeeRTlGlTBIFhbMKX8JuDdlu
	 BiqkkA8ixg3h95OJSQgKWXyvmxVJRelAoB/dRAvJYQAp5FPpI/lwiPDqtRpshT3AL
	 cf5U1a+wPH2B11TMSNqHWU7IEM2h128pf5V9BtYqWytSoLt9FaxvwJyy+tHr0tW9d
	 oL8qQBDh+LpwwSSUbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1qibmS3LyF-00vkRE for
 <git@vger.kernel.org>; Sat, 24 Feb 2024 22:42:27 +0100
Message-ID: <c3982abd-58ca-42e9-b34e-48b03b8f8caa@web.de>
Date: Sat, 24 Feb 2024 22:42:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] parse-options: long option parsing fixes and cleanup
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
Content-Language: en-US
In-Reply-To: <20240224212953.44026-1-l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RtwVTwEHHdY/4/Au+41IP383rQQrEo/BCf+pV9dzItTqcS466Q0
 fsHqBZtAkfa7psRlu7k5ouCWVo2h4PnxWl0HUOOcaIZKVDmhU00YQfI98//Z7rZ70Vd0VOu
 UD7MoaGalrr+eqV5m7BYyvZlKFnheZR1cpZRDlvgn1Ufzq2+txza6vq4v9wKD992xc1WRYr
 tKo+3yu3nhR8ldV6xrUsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3YpNPLgDS3E=;kJQFRBGYh+yyOnb7aBQ57rqn40u
 I0uAHbuzePs/zA6Pnzplvd3jXBuoEvYJe+Z+Uw/yhgiLRQuM2mxegjNkr66p4kh4GnqgK2sHK
 MeEKW8Q31uwwzjQx0Vc63ItaPCqv7UTUI20YVuHX4RZP/XLWis9FMrBQdrbe0SMyEz1lF3JFP
 3QurW2/5xp2Y0rXdOHBw6Li5NoOF0/dLlqmCUqnWDe06oh4dsFYqW2AvKJ9oWjcK4HXAjMhzF
 3v/PXdWelr0z+3Xq47UHHksln/WVOBoStOPCqDC4KnPbfL+PaxLt8muXDqLqlz4KX2KuNvPDn
 stlt+5bK07+glPES0qQGT1slPiaXaRftJIOPr8ODix+hn3b4SCorDuG2TUxkz5wG9WYjv8FT2
 SF/bM1m6FD1cNdAfv2j97C9hKVmAw1yZkgGtx+GYd8BZKH1M5DOwliua5dpg4NDwjyojkbfW0
 yHo9c0SF1sflDZRMZ1hwIiOmn1vX4rSvelj46bRN0kTyzZLh/3qOoLDodiGEfn/lvQ/0xOyRe
 svd8kHT9rW8L1LVCKRBRI/KwPOBo6ayn0nj2xgrSg46XHQSDFhodbAzwbz4INIMtkAiwjWaSN
 2Vqnlf70HHU3vWUg9I/YObpGcQ6Bi0lhnAQWLL0N+lLtDO2I5StbWMzdzk+e/YGeas5/DK66Z
 8fKO1iNoX97aRVXNINAXZL2NGzbWIjXyxBInvTEGEQwkLRVhT2gISHDDcWfW1UMP8F6/esixl
 x4kfhq73yBJhjC2/bvBJQkSuySHGBAp5hmNfiNzknVIcQG5LNI8XjWTRQdOHrKSOBWeAgRGD3
 hYveCFdzdLqlYk3eD5jYx1JamRkaT3X/bYxap9+x+rS2k=

Am 24.02.24 um 22:29 schrieb Ren=C3=A9 Scharfe:
> Fix two corner cases in patches 1 and 4, refactor the code in patches 2
> and 3 to prepare the second fix, bonus patches 5 and 6 simplify the code
> and improve readability.

Forgot to sign-off, d'oh!  Will wait for feedback and sign-off in v2..

>
>   parse-options: recognize abbreviated negated option with arg
>   parse-options: set arg of abbreviated option lazily
>   parse-options: factor out register_abbrev() and struct parsed_option
>   parse-options: detect ambiguous self-negation
>   parse-options: normalize arg and long_name before comparison
>   parse-options: rearrange long_name matching code
>
>  parse-options.c               | 137 ++++++++++++++++++----------------
>  t/t0040-parse-options.sh      |  16 ++++
>  t/t1502-rev-parse-parseopt.sh |  11 +++
>  3 files changed, 100 insertions(+), 64 deletions(-)
>
> --
> 2.44.0
>
