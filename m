Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FF181B85
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228323; cv=none; b=jvgTLfDOWFxHu82/9/vXHYVSrA5K5CoWdPIyB6affbdDG9xLSnNTACp25/koIMxbj4afNhZ8MJP/K3sPOOuslc1rcs4H45xztOMMDfNQ92MwDdRd772W4lW9uyZp8MFg+rRo5F4KRoCK+b6fgn3sOyKR4sxYHBp/UNg6BX3iF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228323; c=relaxed/simple;
	bh=/r3LUb7RTdkVJBKt9t++emxt55sJABBksvVokNmS9t0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WsWgsl/lsJGEGM1XNQJMBHGPQHNFcA8P/ocinCOlHdrtv2qLJiXCzI7maM2JIz0tYov3Jg6I0UcBFgyiZlrsuTFFNmtTZuR5lt2VwYrCds7kuOyB2t/JH0bMcpqV1YlwBUQh/UpCSWNH2v1CBVIucWIg5Ck5f5p+Jo45iS5/o9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvOooA2J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvOooA2J"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso48710385e9.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228320; x=1721833120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6/FpcNnfMBUaqQTnDDldMHDm9pHSI/uJOULvuR6mB4=;
        b=CvOooA2JhLeBPbF1CGDVa1nh3o7umEkpIDhWzqpXP16iZveVH/sI9iYLNmM9capO44
         vsAilg3joMPw5EuZB7fKvVxuhzSSPWM1i4ILIMTxJaW1R2ztkcDcIugvaNSWnG+FGAh7
         /h9e1zvePj4Lb2V71reLh2i0YfJ/gkoULthZT260ZeZIx8vmIqj5X78dUiw8i6l4o+Q/
         GKLgDFm7Z7DMWcDmbvWUCHepvv9UeUI/gAikyQ755YqDJyDNritB63T7JmOQ6s5Kahbx
         34adnMUL55JtwjxYP0bh7Spaa+NCvZErzrozRKHXbOkDQD3kw2Qe9nuYm43kGGRoP9B5
         tZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228320; x=1721833120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6/FpcNnfMBUaqQTnDDldMHDm9pHSI/uJOULvuR6mB4=;
        b=cc4zQEJuVRiQnde4rjYEV+m4ELyMivZwIhRdr2i81JMBg0F7foL883lxxB9vYv1YkG
         zhA8K+DAiZuYGL0bz8JbXiwqxZoEMBShsFm/P9uxzpmRr5IN427dP6B7GtFngT6pc9LD
         QARbYpqU9uOVKx90jbAJyoudvYMGxcjY+QlzzLygT8lLKpmv+9x0RWGpOK14f9dC33vL
         W6CaQSjvuNQYlyHJTjyjQxKrO+qCDp9bkf600Wwi/NL8Y6GRXLsx5zrgkvWaI+ca5Pqv
         1zb4lXFgbqccm4MAesNaMwacZk3uit6qG05Z3gc3aNSgL+yqkSqW7w54ASf53uARuAL9
         392A==
X-Forwarded-Encrypted: i=1; AJvYcCXc+ZxjW7ht6gzOxjRZZzTfOLPWFobBVRseohlBVhff3x8UwnJO9g+RDXbc0dkXsFQIGkhmGNmWczEmvkCaD+NHU/Jo
X-Gm-Message-State: AOJu0Ywx4r71vl18iOpln/MQ0gEzy3TW0biT0GZ1rCIQOuHBOaGtZUwc
	tJ3bmo3azebyKlgcEKitEBs4N0LHE1XnkYYZmhK2vbj5Eyqi3YdbxdpXJTtI
X-Google-Smtp-Source: AGHT+IGdeJlQAXL32MQzTH6BIPR463L/Qz6Pwl25HgOCZCozZ78zAGZtwWemx0OAMEiBbsRoUNiehQ==
X-Received: by 2002:a05:600c:1e1e:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-427c2d11bd5mr14423635e9.32.1721228320189;
        Wed, 17 Jul 2024 07:58:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7803d27sm994745e9.34.2024.07.17.07.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:58:40 -0700 (PDT)
Message-ID: <cf999478-b1fd-4c93-a11b-1b34d51767d3@gmail.com>
Date: Wed, 17 Jul 2024 15:58:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/4] pager: introduce wait_for_pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <f48ac176-9938-4677-a956-350fb50dbc0f@gmail.com>
 <384f0147-d611-493b-a3d4-d83c65bd1114@gmail.com>
 <1e38a2f0-623c-46cf-b5c5-9e3a4b153cac@gmail.com>
Content-Language: en-US
In-Reply-To: <1e38a2f0-623c-46cf-b5c5-9e3a4b153cac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 15/07/2024 21:04, Rubén Justo wrote:
> On Mon, Jul 15, 2024 at 03:13:09PM +0100, Phillip Wood wrote:
> For reference, these are the points you indicated:
> 
>>   - We ignore any errors when duplicating fds,
>>     "git grep '[^a-z_]dup2\{0,1\}(' shows that's not unusual in our
>>     code base, though if we cannot redirect the output to the pager or
>>     restore stdout when the pager exits that's a problem for "git add -p"
>>
>>   - We should perhaps be marking old_fd[12] with O_CLOEXEC to stop them
>>     being passed to the pager.
> 
> Both points are interesting and improve resilience to unexpected
> situations.  I remember that the first point was already suggested in
> the previous thread.
> 
> IMHO both points should be considered with a more global perspective
> than the scope of this series.

I'm not sure what you mean by this. It is true that we were ignoring 
dup2() errors in this function before but this patch the O_CLOEXEC issue 
is new.

> As I said in the first message of this thread, I have left out
> interesting points that may deserve to be addressed in future series,
> with the intention of not prolonging the discussion of the current
> changes too much.

I think there is a difference between adding new features which I agree 
should be left and getting the implementation details of this helper 
function right. Having said that ignoring the dup() errors isn't making 
anything worse than it was and the extra fds are for the terminal which 
the pager is accessing anyway.

> Sorry for not responding sooner.

No worries, thanks for your reply

Phillip
