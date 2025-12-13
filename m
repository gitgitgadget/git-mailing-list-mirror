Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C52C11CF
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765615799; cv=none; b=fG+iZXviVc+TMrJc8160RJFOgDkFYGbaLtGlFId3ulvBA5VVVDB6QuEZ4Z2tYNalUnhzSvZLjhIJ+npWlmVm9Jlrrg2Zebr75583t5SAbtJUEpr7WP79wIk1ixuf9AxzhT/FY3l91mtASdB2SM+4344eZaJqmiv8lUyDl/dhUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765615799; c=relaxed/simple;
	bh=T7KY5ZA1Cn8iwwY/eVzIbbTmc33xrr0gYOcvDyKVIlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlkjMlgNNmxXxvA45BTykGEyvlcHB4Xr3BKuHGm21qrtbdUtgXtq75uPTUZo0Fg77vkH8+FhhmBxSGYEA8q1sTf3d7jSjpyNGsLfEovplRO1POcABrUDZZIxWWY+j1XUbzfHMnU0htGEIGrrKLEUChvGzlsHXiRP7tYgo8W0Ejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Fl6LgNC3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Fl6LgNC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765615792; x=1766220592; i=l.s.r@web.de;
	bh=8Xzes6FmQkjuhnpv27szYPasQrL7AuoZgddHFx3sbNs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fl6LgNC3YrL/3NNxsUa5mSZl+K1NwQO8tNdjyzaGgfrkhAR/FIN+eEGLl0x6u1nm
	 WROWF187YIysBrx7GpNVgeshNel0OvUWFFq/pRe91xTfHtOJe65Rq1veot5V66ZVT
	 FkPQCoqrCh7vfvAVsIZ/vrskJd7O7WVYNPYwDL0bd0KsqBWBuQ8sFm+wAYrcXJ1Bx
	 HEMeB4iRUZE1wPpEe8i70oePP2/Ho/eU3BwclNViPXbOlTD7YoY+eLpLcxGlrDgQT
	 M5OV4Dc7X2TsWJDOL0d4lsrWVNrrtRNDo3vtJlvuycMNPLdpoTCOv2UCEfBaDxRVf
	 wMvParb+ExbJI5p4SA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6O7-1voWyZ1EV9-00dGR8; Sat, 13
 Dec 2025 09:49:52 +0100
Message-ID: <1259f5a3-472c-4805-a6d2-8fb871de8922@web.de>
Date: Sat, 13 Dec 2025 09:49:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t4014: support Git version strings with spaces
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <eb0e6533-44ef-4b85-b1aa-f43f6d4174a4@web.de>
 <xmqqsedeai33.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsedeai33.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jl0d2LGobu1N8VR9czdAWYUKLfr9hbcq0xWgmYzc3G7t2abyJsw
 alqM4wG/oPEGGwLry7grjPIwdU3j83YY5I9eGsJlhSEnGuctR2lBLcCp5jS5FoBT0nIdMYe
 Xr5eNI+OKp0J6QjH2tC0HssjIuCS672LaTOOMDBPyUgmX3olDdC8XwkH9BwH3FVvb/z6apm
 9yjS0pNtq0LGhGspE+b9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WdvcqBdiPy0=;Oq6JOsj7OtaSUBDguTwAibnJj66
 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
 WPOCSLsJfM6tEVHkB7/CJg6P4eQjT3QEHfhE+V

On 12/13/25 9:42 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> git --version reports its version with the prefix "git version ".
>> Remove precisely this string instead of everything up to and including
>> the first space to avoid butchering version strings that contain spaces=
.
>=20
> "everything up to and including the last (rightmost) space"?

Ugh, yes, did that before.  Perhaps a variant of left-right confusion? :-|

Ren=C3=A9

