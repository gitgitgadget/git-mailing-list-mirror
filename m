Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660815687D
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771103859; cv=none; b=rKrXXO/ksm9EmUirsn4lcjH8t+sAjfS5i0te6IpOmG3pCJjZ/eHd+UhkZYoJljLutw8k21ds0OV30Ab+7hZ6QdYBwZ4sDrEul+JaJnxz0Jh2RSydfXZiWcfOzZ9UlE2UAw1lts60E+z4+d06fI2cix3IT/R2wo/b9sR2dNQQ9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771103859; c=relaxed/simple;
	bh=nANIFEN9OD8uqRa8mGDvS/1WPUBEsFpoJuuxt6UxQUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dDK9E1MLzRZ2wM+cNTPCn4KBpP32x6Ecks0Tmh7uVya4ZV77qb7QdkUVTPvnhhdIWeAbprXQnqakESAmkMH7JGjOPMYuuqXk9V35DSbtTthBqMH6/Y/qmrm9t3n3IDLcfI494m7QgpnrykTmdCrAn0N6N9+lYA8Ji5+smNwIKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8SCoaKX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8SCoaKX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb513e860cso48831085a.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 13:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771103858; x=1771708658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w38m6ruT3k0IcxlfTrODU6LZvxwvVvK+Ho2n5vx4DDg=;
        b=d8SCoaKXJN00T2jp93reMTEVfjiX7tqj+MvgJkh0Ro9r3zWJFDqbN1U4e0ITJwX6Aq
         cRD2LgutHcCFC6Xe5Qh6SvqTcOk8waUqaRXqPDVv02zZchjeLoKvFMMkt8rCFyKfVAim
         wcg88mt/jpRzEMUhd/8iohKdjRpfB+RIT+TMfZ9nH/sGMbDCfCIdMygbRQIDDuvWFZr/
         HLiP5qfLQgncnLqzYEbClUzRdwUof8y+9gxArIH+z6AqBsooMo5mDGS+E98L6skGn+Bc
         dD3y94u98c/tr/j4aDUqv/lIVDQC3gDWEVC4Qbrknd8EineML/hg5yn2mtQu9jZAGcbS
         5Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771103858; x=1771708658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w38m6ruT3k0IcxlfTrODU6LZvxwvVvK+Ho2n5vx4DDg=;
        b=gWEmstFVfFzHUaiLdUiz6ULEreoP09sxxNbw3Dap8ChE3XL2mwOtmA5KH3+UwMfD9v
         O2Oz1UJQANEYw2udkJWbsM9i+lDdw0FY2ofLW1WCgHEZ0RcSlzrr74dLqZ5QiQ9W33LM
         ieBK9WLpH4AAvkvkNXspEi9B8k6VOLwk5MvmuP+qpXqoYo9smAlfBV8n929CVS/R6guP
         D8EXLwrqgLjXaQfn+fjMqQ87XvKRmbi9ehqrBz4C8wXnuLcJvLQakstj+N3ld2f65Beg
         vXMeO7rdMgHC5tJSzyWdvizpRCN7aycc1bmjXUoscujmM12yTIFSVfeihpAemEpOY6bQ
         qr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYmjqUyzZXcmjK626pna2/U/4sjmzkhj5GdOI+jFTVtRn9wS6mYTn1ZTyIA+J569cmQ7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdAIMEj2qOF+cDZRdBU/QTLPK8Dn6XMUtT5ZBDsgD5PhhvHZ2
	Dk1w6t/GucC4VccCgteXgv5ih2ujGiXylqhoJWMgiXMWhZmQIZbgSJGv
X-Gm-Gg: AZuq6aJu8ioz3bbfq+BN+HsDuhy6Js7Zs3HG5X/k+MYnWcV/lbqoxe1x5osxVDvkFKX
	X5UkvBf/AiQBNlz3dzDWu5OOhOb+kjZ13d1SB5CKStlkU6mXIS9glSYAENvE0RHDZfyledbaQCZ
	gEArlqKMpYeMYZ1HixmDu/idd5PXSUo48Rf8X4nsWqS2yB4YccC65dfDpVvo/rE5SGyfNjmcFns
	a6uRxJ7V1ksVqyWDT9XGLuAoe1yUw89oVI8yBRmPO96EkBCuUCP3c9nFEUTh/oZScLBWiKG3tjX
	mIX4dDf6k5uBY7Ic+4VItkspwzCoJCdUuZvKRNnNZluGGxhYYNnvf6na1TPrfKeyPRYoTOvMKH0
	xAEj62QH8zdbcmF1hBhCNQskxIr3MZgjjsmReERT03YJIX1mJ0JljVdiWha90hRCD6VDt0PBQS+
	FnYwA+Xqt1I+dUpT9z4bzKW5PTOzyobwyEjvuYysG9fqIq9X/i/1d9t0piQF1PaHPUCY0W718H4
	IbkHieCxM7DHV2QZyTg/C+sMaMHo8WqtVeFWCnrC23aKUsGvZQ3emyq1ig=
X-Received: by 2002:a05:620a:468b:b0:8c7:c25:9e69 with SMTP id af79cd13be357-8cb42485e6cmr750578785a.66.1771103857764;
        Sat, 14 Feb 2026 13:17:37 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:a0da:45e0:2a32:903? ([2605:a601:a6b4:9c00:a0da:45e0:2a32:903])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8ca6esm93425246d6.33.2026.02.14.13.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 13:17:37 -0800 (PST)
Message-ID: <966fe2a3-1565-4bc6-ab4e-433fd4ff517f@gmail.com>
Date: Sat, 14 Feb 2026 16:17:36 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/revision-maximal-only (was Re: What's cooking in git.git (Feb
 2026, #05))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4inkhymy.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4inkhymy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/26 9:01 PM, Junio C Hamano wrote:

> * ds/revision-maximal-only (2026-01-22) 1 commit
>   - revision: add --maximal-only option
> 
>   "git rev-list" and friends learn "--maximal-only" to show only the
>   commits that are not reachable by other commits.
> 
>   Will merge to 'next'?
>   source: <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>

This has been stable for a few weeks, so I think it's ready for
'next'.

Thanks,
-Stolee


