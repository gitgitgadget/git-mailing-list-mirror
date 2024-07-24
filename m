Received: from sonic320-24.consmr.mail.bf2.yahoo.com (sonic320-24.consmr.mail.bf2.yahoo.com [74.6.128.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809FF4FB
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788908; cv=none; b=HWBZZuTPdwjv2+XMclV4MiNg6lDYPQkOEA77qFs9gTqGZautsfo0g89W4050VpYEfF03Q1v/XsF5x3dPjpSJr3GfgoESGouc2lOEfXYb1slZ1rfRyywFxmmDsm7LS5BbqpttaQxBEYyYkNuh7cX0jBcZFQIqjQSrtJskJpWERH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788908; c=relaxed/simple;
	bh=+SG6cP/zRXNGXzY1sbaBAOhZucARl3PuVkhJ8Czxl7E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EnJ6f1+Gud/pOntrU1fJF+CfhK5iloByUN90GFNIHYw4MDcUV625m4rYgncRdVIeS+i4sNu1bvOhy4w/CtBDkG7+GDpF1nQZI3QKL/wJR2RnZnvgBcuAn/tOkOYq327Nh3I5Xdi58GTX4u0DE0gnQ10f7rFQcgrUt0DR3DZoaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rV6skujy; arc=none smtp.client-ip=74.6.128.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rV6skujy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721788905; bh=+SG6cP/zRXNGXzY1sbaBAOhZucARl3PuVkhJ8Czxl7E=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=rV6skujyKXOk9cP16JHhr66kR+UJZ+P95DpnSl2kocZ8oJfQS6B6bt2AQmo/ZQBzOANlF4k4ukEWHZFTyOHbmIN0NcPiOHq5JwurlXR8cQyAGpsUTJ90NvBOybTmEN1PX7acb1CthOrOvCseG6pq0yyOqZ4/j02X8el5hVHF+FziexH3yDM/2iXzpEi7wxdcY9MhvsvUX4gA2t9Z+wZA3PlXThLKNdkTmVYI9E0vn8VJpmH79TqfROnhWMrARHQ1Yt+O0lFhkUua/7Yx6cPMEXDG42AiKIqEUnhznTS/pv6wSlCL8pxH1w0QO06l8YPuF8IhKvlNlbE2m025k+uxWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721788905; bh=JEBXHp5HCT7hXtZanZahVXXn28+0ILaj0x0ucklkUfU=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=j/2EewJa7KKdyRo4hJ67prIMaqPifZvj9hnYT84bCQQfYOqg9wDfE3PEUZUqs2VxqdG3SScqRPFbkQqfvAFhivAYl1zRq/ZGkwALpMwhl2rsLhKcHtW6KkxUw0fOiJg0MNldh0b4h9DFmWvD44n/GfbMcLQnTQVDfgmeC9Z2DUKFHpZj50TcaG2qaZBTfEGYmqBbTZ/kdrufjGdKuYReiUb+uGnr+c1/k6C8JOEkhhR24R2/ebMiH6s/BBGZakcAYDk/ujxegPakKlF2FRW0Swhu/GSBSiSOiSJKogFnoOKlJc01vNTSeFTB/MBpm0nhALIBGEfhR8QO1Pg7S6lpvA==
X-YMail-OSG: ZVBiwv8VM1nSkLS1yDOrGISONrJwrA_QAmwQ1yb6Rn_7lPZPlqy.0d29H5xBC3f
 LNuGwnONLOuCRNFiCeeaL_8C.BJq0D3qezbgu.U_ysvsYTQFyDIZmo488n72krm8_iCZksRHQHmQ
 O9SOdEUswkAIWmgNeJtb75i3Mxh10dnl6JAvl2zgwmxAR4C9V2mb31BGqZSGGYW3j54hoD3QtdhN
 kga6iJLsXEYcMB.j1NsAy1fdHWPf5fS8viqRsbt0lEN9nn39xscniRj23t1wBF4uVbdg6B3vml0I
 CM34vxiloZsI6Q5Yj7.WFSMkGJ0UyQMX2tt91.Ike0dAHZ7pfJ5vxWgUG0wnR_ay0cIkzWUqHJ1W
 X4tcqJCBJ2gHmveDu1BZfZc_wh8bHpaqem1J8NwVpfbOdXlFvWvh6LYs_DPDMx0nh_kMh3bn.mAg
 GOUMjp8ZNcBEWB4kCkuyVdIv3Fsbn5U0z0XCt2SLf5JpmdTJZ6iigT8Gv0K1f2RGzB4ee4jbEBlx
 Ph.ugvd3fZhASp1igC3EffC9V9dhDups5N29u.VlsPpgnkcuaSoDWDN5XkiF2gECz66KbI9U043j
 NMLgk5YlvbAMGHLq07WMJKuvxWno_9G7SqakJ4CGpIDaSzIq1KyxS5D4taSYBqhNzAbbL2UzbEMB
 jyPItXUdAAdWlnQlKPZrENPXI.vAbCTDbKbiDve4oimcfNQrzHWohywQb62a0LLbiJrER7W5VyD6
 jJjcWxIdkqwetxa0_ok0.CEwdvv0kdM4dHwKDh1yYJNzw.zXO_MTApPo9.1rOwNFFCImo9RBq7LK
 60HWFSx2_kOxeJwAUml9qaz069eM03AvMC559xYz1cNqI3pQac696d51QMZZh5YWl7D1Tz.EIpPo
 DjzCT10cJIIHRT60Hyxa_qXffJFWrOzW9WGGjsRxW1hh5vvvWHsTzeP9gloQkPkBqPxzfT7b96xM
 3WFnqwGIxveYeyi2EPHZeEgPB7vZ22tyAJ6lLANZoezTbEzqzV1IZQj9EkDTFUTu9iPkCvFSXKOu
 Q3sWOW4UILQJC8rB9CBLEsbNe5RxgUlxvf89rl990XrpN_g5rFzNrDdN0Vt0ZpqcjRm1AAf7rv6f
 orIINEmtq8rQIYNKd.EDGJpfF45VDRArS3mV0A1xVhs_1f6PG_VSOgjvkmq4Mzb4pOrboSEOCgNs
 ET2pse99o5oy845eTJ5S4qHd5FzX1281HqrNohsuBW_tn9XMW5sRRHxkrUQvTvsVm8iPzFCoQVxQ
 HoRd.7reZZEgKsij4ce1ICAP8wl0PyvLhPLBy0H9TIVI0zzxRIcEorXD6jASoCT_ayNFX0rMA.LF
 yQ8tRamZpf59NrKQpGyh1vt_eHGpLh6sS7P8Ml9j6uFfJn9UGVSQUYrEPCNOCXN1atpGYyDtq8ZU
 uI_hWVEvyUO9Ffyc._P.tC_rmB3EILf1zDG8NpauAJgGbaqVQUboHyFdpOY9UDNwrB9AsdwqFeJ0
 1HhI8g963BG8ogUx.46_iY6ymlkqkKDJKkMKt45kA5eV5GU0io29RLdLz69PDtMiwp3fABHMMycZ
 .J_VCVVa1MLNLJPpphWFFVAh9sp8aE8tSIP6bWkbmOUjPM.PUwN3l4eP3eCIKYSq3JEjvJ47SWP.
 2IXkah.MIjNXJ3HLE2MamND2tm5ukIFIlcbxnBngYVEFNf0edZN8_jTwHTdYOr_7zNwGr7C10IX1
 JaKH5sS4IYao4YCPyv4aOuME_x4C5FzUYOFZnPXWKyCkXcQL.PBJ0deY5M3t4KOwNzgSTff_kvc3
 b_bTnB2gvxGdTJtBnh0E0tkMmeaf7JqzFrxJ06yXaTiagaZytduGapA55RENGEZOejSOuiNya_Aw
 vEkjDI5AjpjeVTJLStYM_ZEtMiA5byPQ8EwIrVOuhvqJmTwEfHJCYoL2KuVywuWWtk_Eijt2yWRm
 SQPVeiju2O0T7NQjjW.VV7aR6mSOUMuOFukivnE3RWqV9SwX6RGzOjCmi1YA0QuK2MjGB5_gk7qz
 bynQZi5aFiuLNzMPPYwFRB6v8vaYquPcW8dqKQWJHdoreAvc_syMb39abPeCxAlZgd6wVy1.jSIJ
 uTe3lglAZ4nlDBuo.J5L9Br_h4k_JVQYeGOhahVmhsrluGJQ5p6QnzfYgbXZBWs3uW4a67McmXXe
 Fu4D0lMYfdFObeuRIAX8ULbjPOAkrHIHKgxaPSO.bV8jt1THMGow7JaTkeQ8qPS.9NKl03h6Ub.s
 82Lhg8l6avMVLuQ--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: be54da8b-188b-43ea-8aa4-1734dea40d0d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic320.consmr.mail.bf2.yahoo.com with HTTP; Wed, 24 Jul 2024 02:41:45 +0000
Date: Wed, 24 Jul 2024 02:41:42 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <992128710.1986532.1721788902932@mail.yahoo.com>
In-Reply-To: <ZqAzpYuTrK6L-uyN@tapette.crustytoothpaste.net>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <ZqAzpYuTrK6L-uyN@tapette.crustytoothpaste.net>
Subject: Re: [PATCH 0/8] git-prompt: support more shells
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin

 On Wednesday, July 24, 2024 at 01:50:16 AM GMT+3, brian m. carlson <sandal=
s@crustytoothpaste.net> wrote:

> We explicitly allow `local` in our coding guidelines.

Yeah. I missed the guidelines initially, but I got to the same
conclusion with git-prompt.sh - to allow only "local" exception.

> As a side note,
> Debian requires it of all shells that can be used as `/bin/sh`.

I wasn't aware of that, but it does makes sense to me.
=C2=A0
> ksh93u+m is planning on adding local in a future revision.

That's nice. I did try to check whether it's planned, and request if
it wasn't, but I didn't find the future plans (but also didn't try
too hard). Though I think they're still doing bug fixes for the
forseeable future, which is also great. Looking forward to it.

However, while they do have typeset (in non-posix 'function foo()...),
it has syntactic scope and not dynamic like with "local", so it
wouldn't be a trivial mapping to an existing functionality.

"local" is so useful, and with minimal application restrictions it's
already effectively portable with very few exceptions, but ksh93[u+m]
is indeed one of the notable ones.

I think was a missed opportinity that POSIX 2024 didn't include "local"
(I know it was discussed).

It is possible to implement the functionality compliantly and even
with reasonable syntax, no tricks, and very good performance, but it's
not the same as being officially supported.
