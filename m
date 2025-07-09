Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533F2853E9
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053477; cv=none; b=CHsUjznsElpT/eN7r4LtDfGu8LNcMCmLGPti3YDTV0hu7O1JhCmNzcgaNKzzIcrdLFWBlR/oOYIAIhLdqqNWnzf709GdTgMNNfdiV6UclIO/15HGm15Y89+kIbsCqo5Tp+74DE3v437hGL1IeCph7cKg25UWmxWwJnyAurHPt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053477; c=relaxed/simple;
	bh=CJgqo5xJrlkNYc6Pn8hqmzeQf5OOKaDjb5dDo3Wfc5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O7ijFoBKdZqNR3kGONRmiXw9rtpsOKUg5xm2jEF0dqtSihiP29+n8QgtVXLXCR4LOsgtoHWwzJGHvQiqsn9bWnxHbtORDG8Ih9szjYh8OkXBHwi/Rm5XuRcck3xpXYt4pb9xTZImc+jU1xt+xc/cSYKtITrP+/EUG4pVh2E58JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=k48CyzLi; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="k48CyzLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752053472; x=1752658272; i=l.s.r@web.de;
	bh=ExGxiyfw6Mp2O+iaMNLwKDsPuvLPdhtMnrfH3LeqNf8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k48CyzLijg7xwhDQD5EadTFaWDmfZQqLVXuKqz2at3k7zI3tDMYBfjU7A1Mo7TEG
	 8oOogENmTF8pd8ssuESyQnNADVP4l0auyz7Mu9ViHg7qsiB0N5MaUWUhKVkU3E8QZ
	 UUV1gKNsjJS370Ny7kwwrxD559l+hEctf9lDM4+RkEl/Vs1E/gmuYoilIvb5knrJy
	 zamLtVBFvAPHV8mhxOI2SfDJNOZV9No1AkRHnhrTkDsCRTIrWAuv6iosCKcLxxSuA
	 g5rTxkyJ9tgt1UyBfCDrLonU5qTWpsZO3I5b4PjhlKYdC8fVBnVsUIPIHLIhjVR8w
	 PeMPwBQMxN6q1iugCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1v8loR3N9E-00kfAc; Wed, 09
 Jul 2025 11:25:55 +0200
Message-ID: <861e6166-bda3-41c9-b259-2e46a77b6d84@web.de>
Date: Wed, 9 Jul 2025 11:25:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqplebzgm7.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqplebzgm7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/kquL0T6XWVjeRy9LZqbxOTFZREOSa8LKxNEGrZ/NuzjMK2LUcK
 yDLyqwjL1t2dkPtWy0vI6Uynw6166rqSII/ZHKKIknDoNd69XkUToPBffLFPo/Nw9RPS+5Q
 Bxel58STn1goSgREn0Lpb8byuZoeCE+a5nF+FiKViXYTMZno9R/bgH1zq2tEG03CCoQAO/U
 YQmfz5JDvGSO8a34txc3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3SimPJ55AtI=;8sLkD/zqVw6BW+Bw7OfHuZPvslh
 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

On 7/8/25 2:11 AM, Junio C Hamano wrote:
> * rs/parse-options-precision (2025-06-29) 6 commits
>  - parse-options: add precision handling for OPTION_COUNTUP
>  - parse-options: add precision handling for OPTION_BITOP
>  - parse-options: add precision handling for OPTION_NEGBIT
>  - parse-options: add precision handling for OPTION_BIT
>  - parse-options: add precision handling for OPTION_SET_INT
>  - parse-options: add precision handling for PARSE_OPT_CMDMODE
>=20
>  Define .precision to more canned parse-options type to avoid bugs
>  coming from using a variable with a wrong type to capture the
>  parsed values.
>=20
>  Will merge to 'next'?
>  source: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Will send v2 shortly.

Ren=C3=A9

