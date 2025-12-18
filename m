Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B233A013
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086391; cv=none; b=rE84y3hqM6hn8VxkeOf4t0VkTqfQP7pCz73T+RGTrh+CSnvXPKmtDmB1GieTilvsClmhjp5F2N8fnZe9bE/m1i7ACj21HcQ+WMh7FQ1FAm3TtXeNgNRzJgV506xDbteu+HG08HIjfhOpc+5hDY7k3Pglc5w3nhJIFuaBsgFz/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086391; c=relaxed/simple;
	bh=QvwpcKDuoMgEZ3e7gjxCYqGCMDYT4DQjHeyys9iqhNQ=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg2iHcIM/arJXtU1vjRKG9rjxqy/qOWD42PM6kTD4khnqdNouBrpe2YaqXXoaX8KVbCtMW7WqNJy4UfSkG20eu1uTNAbZSRKm5sFwiKcENtWrxXtcwbdL7wu6hL0MLW9JrtvpORTYOggAnvbEZ6ujc2y46DcV7rZyHKgaP1GTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyDbXtt0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyDbXtt0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b713c7096f9so171486366b.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766086383; x=1766691183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGPb0IlomtvRmxT8ovdH/W1fCPywhVA+0+KjNszbn9E=;
        b=XyDbXtt0wgPiK97hzOF83cfCZ5crfJf0+HvuQ4PKpxPANUL2xTJzyFDpXO1osqi5IC
         pefV18Mpj8cVpgopFBy1PaE6dMyJBYX6zmMdQl2YJ8ZPokJayo34JV0xttspOAfAdQ9o
         P8HiMegY7au+V8rDuwh0udMiGakUDyYcKdTAwyyymaH0OAXT72TCaSNrNo7j2FxCv6eC
         QZs7z7K1uSDfi6/Rrg1gv/CgqloPuahfOwnPYSv8vUFi4pQMxgmacJvmMQW8zqe38Umv
         +bydGxwbmDw09BWl25US2Im0zQWL8Y8/VlE1VLce/kBlKP9lKR25ZVPImZirOXCtIm6G
         k9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766086383; x=1766691183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGPb0IlomtvRmxT8ovdH/W1fCPywhVA+0+KjNszbn9E=;
        b=ZwVFUvtzw+3lfINY7GYiNgtVnrnd+zj2JWrchVdoHy8lgvGpZPdBaxI6Bv+hLYo6vf
         QO9NgCuGv/00Uvhm4vroIJ8jZ8aIUs98DsoDUizYSn0+g8KERdT6U6Txyqo5qcWOkH2z
         ttudHO93HyAJK8Wlzq0H81jshU0rWYjjiE2ulmNalrmhYt006lvu/v7JnXiiGHzu2snc
         RXlS6WQOyN5bmhTzmytg+b85fevSXrsZP9GIAdHCICTPaCvUjYni45W+KKIzrpxr/s0u
         fHaeDjJILr69NvpeCzsByiSL7A4JXl2ZK7w8uGl4e/s3rsumx8M2WeVfRVygDvcxSDq2
         ceKg==
X-Gm-Message-State: AOJu0YxgNELupdilA9/X0IB0UNEGT32fge6zfcVH96ldRO4wp4eHRwIg
	tUv+rfOYoWARaohPcD6+OKZ5fQSMcXOD5REEdDlx8AQyk2hGPuOy/yRsZp3kyQ==
X-Gm-Gg: AY/fxX6kmVS3MjJtefE848YYyQqmLICCbQjI6Km5JueQCZAM29nERdmjR7nF1JEqky5
	JmHBAzlIqMOl/OGW/pOM4MsyzvcevrMRk57LSpLeOyGJKZXqFKbSVnNRdZ3aB3a1hrjNT5CsTMV
	bfG3FlkudLXe7iieZ1yMphPUkgaCwfef5swMowgDoaSjGNUkrubVe9zrixL1Di8C13pYqvdPpam
	P4xI37YZHwGGTgWlslSW62xomr0NnssGJYcauf4wEQnGGy4iem75+sE8jlYgqPRnNlSsriAEXhB
	eZrGXNUUNZr6c9sZ9LaZsyBQj7rrfZ51TxQDeD5uVb8G4RoubTXZgAmkZKiPoYoDtaf686iKbuo
	WB0paNTuYqWg8MbUDPFAvZ537kBPT60a2co/TAEWhGpRYYcLLQ3j3pVNs+OblxGEB/LdoPNnU0g
	3uUqjAWbiC/GNyjco3KD823pkHr81Y7dLUGwd1+QtU+UwhTGuHwUxhe5ogIi8lURgkmFzo1yTgs
	gCETwjzdNXZjFY=
X-Google-Smtp-Source: AGHT+IGwD+I+EVLcR2kyrW9+lMcn9+BVFiMNiUkoUJKeq8614pohWgvq18wv7WA2sRSOfNzPfxnIsQ==
X-Received: by 2002:a17:907:7e84:b0:b79:fc57:b598 with SMTP id a640c23a62f3a-b8037153443mr45379766b.36.1766086383273;
        Thu, 18 Dec 2025 11:33:03 -0800 (PST)
Received: from [192.168.1.95] (dynamic-077-012-137-033.77.12.pool.telefonica.de. [77.12.137.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad83dasm23515066b.25.2025.12.18.11.33.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 11:33:02 -0800 (PST)
Message-ID: <77e768b2-6693-454f-9e11-fb0acdec703c@gmail.com>
Date: Thu, 18 Dec 2025 20:33:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Support symbolic links on Windows
Cc: git@vger.kernel.org
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
 <19030791-dafa-4a63-985b-9cdf423bfd1b@kdbg.org>
From: Karsten Blees <karsten.blees@gmail.com>
In-Reply-To: <19030791-dafa-4a63-985b-9cdf423bfd1b@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 18.12.2025 um 19:51 schrieb Johannes Sixt:
> I notice that Karsten's emails bounce. Would it be appropriate to
> redirect authorship and sign-off to the other email that is registered
> in .mailmap?
>
> -- Hannes

Hi,

indeed, the @dcon.de address that I used to sign my patches no longer 
works, as I'm no longer working for that company. Feel free to change to 
my current address.

Cheers,

Karsten

