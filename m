Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF014F121
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728376; cv=none; b=HGdcseJjOt+JOM0KEasopNo1eR0Qfj00cVCMF1hbk5N7PyOsQ/pW8OrSsfWYpAE/EZ3VKcrkZ37w+0j/+OqAFy58kEm250DpYWlLyzAMu+7tU7NPpXSIv3T4htUBAw90Ea24gNx1no3LUa/9B5j/hSCfxpZk7w49x/nEnZ1MnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728376; c=relaxed/simple;
	bh=pFhsAGYWMtNJV+sntMSn4ts7dDorG1EHXyt1p1/EUbw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RohyfZe7X65MM6rF4H6vAtChdNUL6RJM0K/u3STWPcH72fngZqnENyxwst7EtGfkMhKKvUGlORiV71EyF0za2IGQ5A7bUp/biCwBh9fTvNJFMuzoWG5mKgbNz+72h9Jv2FYvmU11BKrs75yJ+80R9yzfkDhuVrow1CsQVJyOfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=e6VWnXNK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="e6VWnXNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714728366; x=1715333166;
	i=johannes.schindelin@gmx.de;
	bh=hYk5/J0Ds1On8znC+qx3Zzb1T+s1cQhTNf+59MtGltM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e6VWnXNKoJWTS/l/xSAogQIa4/nKm9/M8CMt3RcWmOWCIXw1Xu91HJTzBtyraTsW
	 YcCKAp0slGhIxrm6NxceYYNO3WucJzDrG8uxU5NJ+Y1vmulQuFmPtCkb5+LLrUfg2
	 ytb3hlHWT2KBbAgQ/aMBuCB/00qZv1aREzcWbkYzetSWS5iGjCs852gKLJV3tgIFe
	 MT8GymaTUH2yPoA4Uwc7Z36ffIyxFSAXTFqPJJmFqSdsSLLW9fWibSd9cpu+NV6dP
	 NGMXU5aEyb212jeRPXuTipqbgnDdP/LHUyG04+L18f5r8gfat/D6B2yv0svnbF8E2
	 ns9VRoUPKLEypiqhhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1skRKr1Oy7-011n0m; Fri, 03
 May 2024 11:26:06 +0200
Date: Fri, 3 May 2024 11:26:04 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mike Hommey <mh@glandium.org>
cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Win32: Fix building with NO_UNIX_SOCKETS
In-Reply-To: <20240503091427.2808390-1-mh@glandium.org>
Message-ID: <47580fe5-6934-9a76-f927-d66c6c338143@gmx.de>
References: <20240503091427.2808390-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cBrCOQz6ikxaTXpUU7em80STjBCQ33sYajtvnJj8TZqFnv045j2
 bG3d8k2fi1BnBDqiVJdJtirhga0VtTceeBU8+e19uG59+eBkNa+qAJElB1cL04OblHAC9eK
 vGkbTFSCWHipxBlCcJDC1aURBra2UvQD4saO2oAFJ6C6fByInHfUjorbmDHC/g1vOOziBVS
 eCoT1oMxQ0Vxh8g32/GRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OF7X+FRVLao=;wqR+iAPzDllSeU0M9L3+NHdAXHU
 It60L1zRp03HcoCy9mxHTFurfaONKj0DYjNs2Xot4UpmXxJFRyV0YNsVS3L/gFKgd+aNAavI9
 UBLyJ0BLCwzQiujG0e7ZqpdirAzH+6Op0TY0iOQMyhkcIrQxQfGH9ZCCpo42SltgTMvE/PVr8
 FnytZftKdmHh7erPle18r0xPCouEiGuVwhMxDvEQVx/M1LrPmnloU4oEEBeR8ZwXOavMNpPa7
 ndUKDhd850txu5yRtqQ4SHNZjKgDkLMlwnEHh+Ms+fCZuGtYGZbU46n+PKev0w7bv+12iRFhU
 uUwrqKLH8Vxq6E2ZwyWEsOppRPmopD9s7Et1HE+g498WOvko2MHa1mA1VsvZGAH4BHyYE06yL
 PzrEXDtVHDuJldYlmGog9SYHhInR2rgqkL1cquQRfqrpbcISLOUmJ1tLzW1N5f9oMp82W5aG3
 Wm02uQrnTl7O6I0wRva/0FRRVDbmNqp2pqbATNwxb/ah89GMaU38Wh2931a8ZOY/9+SUo6eEI
 cMhHDl0rur0X76qTA6CvgBEgV1PzuTKGzR0enr9kFUngnuuIN2xzy53qcguazEEwLSRFYM8nc
 /NBAPt97eXjeE3K2fZYuV+SZLL0fpCGBqVknZ6dZ6iq0sdffb8SxEAhYzk4tSPhlq2E+a0PuD
 bVU8677noEFFmvpHD0DVmcse2QLiECuhuLNVpcTdPdeOSRdozJveQWhElhe/7CMsyAyp4LyMa
 sxmddP8AvAwrLKZWki9Ey54pMEIQNTviApLaRsBnBv3XimTMBdjKCRHjKnySuZwhEl7YNevMJ
 W8q/0FDiPtjS0/MXVEGb0VlYIfwy2wvk/lSJcZADgN/vA=
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Fri, 3 May 2024, Mike Hommey wrote:

> After 2406bf5fc5 it fails with:
>
> compat/mingw.c:4160:5: error: no previous prototype for function 'mingw_=
have_unix_sockets' [-Werror,-Wmissing-prototypes]
>    4160 | int mingw_have_unix_sockets(void)
>         |     ^
>
> because the prototype is behind `ifndef NO_UNIX_SOCKETS`

Good catch!

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Johannes

>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  compat/mingw.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 4876344b5b..6b06ea540f 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -3159,6 +3159,7 @@ int uname(struct utsname *buf)
>  	return 0;
>  }
>
> +#ifndef NO_UNIX_SOCKETS
>  int mingw_have_unix_sockets(void)
>  {
>  	SC_HANDLE scm, srvc;
> @@ -3177,3 +3178,4 @@ int mingw_have_unix_sockets(void)
>  	}
>  	return ret;
>  }
> +#endif
> --
> 2.45.0.1.ge6f3e402ce
>
>
