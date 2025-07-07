Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC52E36E6
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881550; cv=none; b=M5Zdp0E2Gc/+cbREEiilnoG2gwFsr8cgdfRVjvtf/iDfyWCzMMI/qVF+4W6Q0LRttbr3LmrBbVmCLyZNmXwbzhEkWLnO+7uFpmZK7GOWvrTC+Y6C858sk7rg+Fs3IKOn5XahP5rjk4mFzFVmhxqb/K9PR5FGzLdVdYd0pBPU9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881550; c=relaxed/simple;
	bh=lMdLHcDME2B4BF0JjuI+YpOUcJDt5zH1WCqClNmD2Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcopCH+GBaO7r87XVi1md/EIptAi3OkHcTnL6WPQrqmy3ZLOFp/yGr00IdC+Hk4NCiudfCMZK+8pm5Oa917uSrDDoac8BEZuNBbkirGyLKjFEKgTGDtspkPfh3prtJlTnL5WBA369/nr6/38imNmCSGWdDCdlosnTqUVMSL9Gks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToMin6gm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToMin6gm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a510432236so1992468f8f.0
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751881546; x=1752486346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nnJ/sDwKTr3SOK0WHuTY3u+Lh9JCdhpvRdUbu/J2l0Q=;
        b=ToMin6gmR9EKBR9hkFG4oadg/5uteA6D63B3MPXvxTAxJD/9BEZE47gZBI7pN5qtfN
         4nXracwuqNRpq0r+3D/ZKycQFPAvW5JGCwrJW/X8avP6PFCCeUb8Cz2RGpd6i08Zd+En
         Uzb9CCfP5NBo4+Hg8gsamSJPqhEtG44fd3e+EpFk23lUlM9PCXxkbdgxnZ0Bbq3YecP1
         oFxI+IJpOB0ug+vgIpHf0og3cuI3ssVtst/WyzDhh6knVm62e8yC28sHqdbh6NerCO6o
         flg4NtIepSjDMlSROPX0PqofhYkbxZRQgdqpg3IhYfuxP1JXvV8+XpD6M2h5k/TGkypn
         MhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751881546; x=1752486346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnJ/sDwKTr3SOK0WHuTY3u+Lh9JCdhpvRdUbu/J2l0Q=;
        b=LBu/IznWRuguSV6/sU08Sz3dMKZS4jCpkvDADoigVmrqla0HOYtKg6lyT4qlcae+EL
         uob4z+HoMlIt96xIxjBJbjlGZtYBWI4mO9//5Z458g8Hc0WxNawtyF/d15LYl+Wdy6lf
         ZhrZDNL0IgH1Xrh2CkRGl1hTK05AxORFxtNkjztqaRtul80bdqEnMEW+rSYKfJZJaSlY
         Qoaw2b7+2d6nvEdCvqLTY850q08rw378XV4wR+5pVol6ijRzGZoAWLInA1y/lEmvtj/c
         v17Tlu3zE+41hg4VwRZjvuQryN21uA/FDlhztd3IKpWCWfyEHexjrlFsehWr0mRoCZWo
         okEg==
X-Forwarded-Encrypted: i=1; AJvYcCUsTHuawfi3mnaisSLAccktCUrSg1VdbLmifvmS623H5/Zd8RCNL+LBlHebywNTvHHoMl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/1m+b7dj/vSEUdT1u0waNFV0L1ADhr87SvUnR3fqbJrbg+SU
	LWrQHOcCYpdfLjR1OC2DXhFnNXXZJCysQFHrUwvzDzYLTI6Wsvl6Vy8I
X-Gm-Gg: ASbGncuQ01JS/hT0PE9yreR6URT4wcBcEAykHZ7aIIBQsjImsuWTpu2eAfVfTL4yCYj
	CEW/d1mGbdrhlIhDzwgJBBuW3EGWncHhhdU55IQ/Enu6MGYNZNxTv7V+Q2tHKolKa9N3qQ+4UAf
	fXHsRHYgfXJb54HC0bN/f2zzr4chFUB8AmeFD6LHpXkUScwfBoSvjBAfuZ44WM4auJ+r90R7RJu
	1bElYd/g7BvId4NZETfferZDTCBg8SsjE2tC4Pan9f7tAZrqkyf+grycf/qB4tXYSjrULWbZTuO
	yfm23Bga1vUHp/HxTTrvRmyhuXp9Nw72x28TCF6Kjc2pfrzQecIXZhlI0t3eMO92pArBPtPlBNa
	uGfQetXa4TXFEz66c2LvmKoAX8pT0yI3tf4+FBXirSAXDdzQR
X-Google-Smtp-Source: AGHT+IFZqixXRh1UoIbB4xHlzt3W9w2B4WRCNs1GUgNIbYo8ufXLpYqXEW/e3G1i8C89EeDunA5G+g==
X-Received: by 2002:a5d:6f0a:0:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b49703dd84mr9523465f8f.55.1751881546161;
        Mon, 07 Jul 2025 02:45:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b966cbsm9500155f8f.49.2025.07.07.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 02:45:45 -0700 (PDT)
Message-ID: <3d95d37c-7352-4e57-8d50-6fd4fcb77095@gmail.com>
Date: Mon, 7 Jul 2025 10:45:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org, ps@pks.im
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
 <87ms9kcbtq.fsf@igel.home>
 <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
 <xmqqa55jc3md.fsf@gitster.g>
 <CAOLa=ZTDcssjQcNcvDOA4-r-j2asp-XHCy2D_qoHEidz+KsKCQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZTDcssjQcNcvDOA4-r-j2asp-XHCy2D_qoHEidz+KsKCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2025 09:59, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Karthik Nayak <karthik.188@gmail.com> writes:
> I do agree, I was modelling this after what would be the best approach
> within the Git codebase. 

That was my fear when I asked about using a numeric offset. Patrick has 
made a principled argument for using a ref name rather than a numeric 
ofsset - I think you should build the motivation for this series around 
that and the documentation should explain the implications of references 
being added and deleted while paging them.

> With that I think '--start-after' sounds like the best option. I'll
> modify for the next version accordingly.
That sounds like a good name

Thanks

Phillip

