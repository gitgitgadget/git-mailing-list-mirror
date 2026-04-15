Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F732620DE
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261287; cv=none; b=Y08o9CXxjqYjJpCOqADdzNptswnTCKLAsk2S41zDbkgzckrIvFvMFxPX2tDDfQqOEeTgG2pNwA5/P+J8BZ4jjKH5bFVGgzFXZ8W+KwS2yXTHnr8ThkczVofDAIfbu/YRGEEZJWxr3WDf6WlzJ/NmDbs37WrRzVJgrX/B/AuaHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261287; c=relaxed/simple;
	bh=sPXF/pnHqXWKoBaP2RM0+8nZ3H+Zavf4loXo9DdNYg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7gy4pWakPVyg0T3Z2KdEIUSUT1Kc20fEiDXywC5ozCvgve1HFiKMMDfNhfSFjg8D2+2sU/e5auTNyzqeqO9JPVZzZOCg/GKJsSy6u+YtepLCscNrHoD29ZEb+I02vFTPIEsd4/tEd3t4gkAKF+8hpvzfa4ynunW7ffbN06+4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bek0wncw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bek0wncw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso69457205e9.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776261285; x=1776866085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PzM/iFnlBiv6/n/mUlFNazwFVytVx74+8xDfMFCp94I=;
        b=bek0wncwpeIa9UoROc5LJvWtpEwKkWEmr0c6ysV2PmnLogigvtdzy3/WWdR5Hvv7Us
         UXnvvKVI87Yv2qrzM5hkGLIbWQNCfgRdtRGCyzX3rsQj3L2XVZpggV0ivkVsJaguatix
         lWUBC1HzhTv0ZP4v2vZ9egquFuZSorEla2PmCAvGmKe4cpCKK6ObBsWQUsZR0vUu7VX+
         wOfeZhMLVhjU54UiYh2zs/WqTpwODmvpqi6NCDho3PHCe61d2zeY878gb5YghXMjvXIQ
         ure9A9y9IgyKtG1b6zSgMDhCETU4MYowm6+1/bzjOOXMCDOmyrmGUKnJICBgxbtjdzMy
         NfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261285; x=1776866085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzM/iFnlBiv6/n/mUlFNazwFVytVx74+8xDfMFCp94I=;
        b=PgpQ/DsitF9Z6YYY2r4myDq1CvcgQLNYDzbu9dqYPdEEvOIDBA2Ps62f3qaKqW3RTC
         79fdShsda23rzwCP4yA8Pm83COLKumRHWHaRCdPqURI20K8zo5yb/fBJRcoFy58eRwZv
         mkWCZ88A67yWUDeIKbJxmJaWoAY0HlR6rbqUIw4oL6u/w8Ec0nTtZV5S1MCTgr7qT7+t
         L6Zj7mu5ib4ivnhbjAlIKxnMfWqeAiX2yif33ep/p0x6nsR1wW9vQnNiO08s7hEin7LH
         pfHupOIzyCoVCCpnoTZhYoZ1EyDs4OBGWQ6W/QnBDGTJloP3s+m20jDtrhQQPklwzM5H
         y7rw==
X-Forwarded-Encrypted: i=1; AFNElJ99imFPZ1rQhm64bt42XmYbkY67j2VDRsbGw1TWb16rOQZy2/RwMJghIKOGDGar7mdirQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzroZ6qLdyU3fFDSyoN2inCXXuv/C5XtMrbIAylDbU7dlOXY3N
	UDj0xigdooI3j1vn148tVhfdy96V79fGGNMJgJ4XGZ9ScmS9Nv4ndNbp
X-Gm-Gg: AeBDievP5DS4VCsNHoIPOQPhQK//6mBZ94aVNMKYwyHbskE2cBoCuATN7Z4Q6CK7qKB
	v/9KxcNQdM1fTbrQuv1Egb1u0FzJYCAhjyH37PazLW9iv+wH3UImzEAbE2gZm7dbd3igvBteEfp
	pZj3Kn5HVv7tcMpeKrWF1/FUWG2u3La7fDJ/HD0H29HPlJZFiwFonk1P1GFUo7aqo7vH68ri2h1
	uBFevM/Ww0o+T3WRgIS7McGo/yJBXXLhVwb2Z6x7t9giSadgoX0AaVP9WCV/45zBMcFCNzCHN68
	vG8S4pAUcSmTj+VkFJHxgKoyE5nxkXuidX2z/eVXWgWptk+pGnuCJuAdykJkI6G4R40T616ZQN1
	ys5KvQFUAk1mrB1pE6sk7om5d425x9Ao4vHXPAecVMXOqQIkDOVOTffzpxvscCmM14cE+jM4GiX
	WF+Qpb/qspagldn0mU9ZLWATXHQ5g4e7BQ8ZOICZXzvuJJIylZCRcVmCvEXXak2er+ovpXiR/RP
	Qc=
X-Received: by 2002:a05:600c:154d:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-488d685b6ddmr290660395e9.6.1776261284939;
        Wed, 15 Apr 2026 06:54:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ed4c67sm20646455e9.33.2026.04.15.06.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 06:54:44 -0700 (PDT)
Message-ID: <50ea6e41-6b29-46ad-aa97-0eaa289db7cf@gmail.com>
Date: Wed, 15 Apr 2026 14:54:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/6] xdiff/xdl_cleanup_records: make limits more clear
To: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
 <32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com>
 <CAH=ZcbCX8FEs4ueU7+groQp8XhiaP0QPHMeGqT+Ap1FjeW9foQ@mail.gmail.com>
 <xmqqik9t89yt.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqik9t89yt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 23:15, Junio C Hamano wrote:
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
> 
>>>> +             mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
>>>> +             mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
>>>
>>> As Junio has pointed out we now evaluate xdl_bogosqrt() twice which is
>>> unfortunate. It would have been nice to mention that in the commit
>>> message and explain why it does not matter.
>>
>> It doesn't matter because xdl_bogosqrt() was being called twice before
>> and is being called twice now. There is no change in that regard.
>> That's why I split mlim into 2 variables to make it more clear.
>>
>> It looks like you and Junio have both missed that xdl_bogo_sqrt() is
>> being called on different values.
> 
> I think Phillip's point is that XDL_MIN(a, b) would evaluate (a)
> twice.

Exactly, thanks for clarifying

Phillip

> 
> 	#define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
> 
> So the code you have above
> 
> 	mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
> 
> actually is
> 
> 	mlim1 = ((xdl_bogosqrt(xdf1->nrec) < XDL_MAX_EQLIMIT)
> 		? xdl_bogosqrt(xdf1->nrec)
> 		: XDL_MAX_EQLIMIT);
> 
> If you are lucky and xdf1->nrec is so large, there is only one call
> to xdl_bogosqrt() before mlim1 gets assigned XDL_MAX_EQLIMIT, but
> usually you'll call it on the same xdf1->nrec twice before you
> assign the result to mlim1, no?
> 
> The original lost by the patch looked like this:
> 
>   	/*
>   	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>   	 */
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
> 
> which computed it once, assigned it to mlim, and then clamped.
> 

