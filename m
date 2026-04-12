Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B85243387
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023181; cv=none; b=HEBuJFCywWrnIvZfZ+MDCQlGuOO3wu9LucmQLPAzS3C6lNKVYahUBfKxtCnANCx3SqeARyon4b6JYgWXt4LfuAEYCdMr+aJ1La5l7INuU+dW4h3D4mN3+tiAY+rbV1N9EAU7ZDOnxRV0sYD4/nOdIMVKkzY+1ZSOvD61zQYg5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023181; c=relaxed/simple;
	bh=2HEF4m8H7RI8TjouQayU97WUCMq4lV7v3wz0fYOum14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njacnYPY0y6xeBnWhsNDFb92d8VNfodYdyaLSMlK437vx6R6/iMxgGTBIb9mhYgwBDWwfGwna6rhdwS8ch00ybI6tJq6a7f2bBL/GJ4ZdG+9GalT/Ms0zQmlOx+BLyK398hM7NAQStR4yE3n6jBBjkfl5cvy2m1PBk1mBKUiGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khJnK4aP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khJnK4aP"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a6cf8242so28071501cf.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776023179; x=1776627979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTBLZxDh0BK2sh+SVJc16Qg8UvLHHj9ntet1003zDGc=;
        b=khJnK4aP8zecdfPrsy5GpjJqjXLwjOYFyysXR8YU6WvNnTUnaISlh2qwDSlC0XTU5t
         NxibyWxBAYi1nPWMpviQgRmt92qierpyIeNHht1myT5FPjeyD94MVv/+HpAZ5LIyjI50
         UvF4Eag361t65gMCo0a+ikXT5Yztdqc1xO4EXfEiLzxlnE0k4KTK7p6lMUyoOkkoBlpx
         BYacMw+PuHY2MTYCBBTO9sYeSiIiDt8N600PflfZzfU2cf6d+HSG8BNRb4jkHE9afOPo
         tutvlIc67GqbZ1EtfyKk+DX55e+WzTVtp/E8qaLd5w2JimeR4EEulnL++UV1Hsx0+4qu
         jWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776023179; x=1776627979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTBLZxDh0BK2sh+SVJc16Qg8UvLHHj9ntet1003zDGc=;
        b=bpSwIZcfJprE+X0auqgAADOYhoV9iNcLxd7s9LYKTY/mtzVZdu1miNQtzv6xsvQxTF
         opllUa7b9UzjHmhE5lwSKPiEymLlFhHaehlDihggmaBMXhkA47ifJyTTBqfdDrHIedp1
         kIJy+tDhe/aDshIgG3SkXW/8cKanpIo5sJZ0ectRgcej41yDBTE+DdzYI8jb6EPNudxM
         q+Iu8z/WDiaA+TWR4d+UMY0ZOWhCs/0TNQ+OqrLbY9kkfBgYbDRGRd+EPB3vWICeEw1r
         gGZQlyi5YI74Cw/z+FlAecn6avshiPIR11W4PfBQRdzP/4+TczPXK0OCDMHNh0jSxGHx
         IZGg==
X-Gm-Message-State: AOJu0YwaGNx97N9rP3OLq7folu31F6q7jph0aoV557xyZwaqBFrgqXzA
	Zwxv8+W6/LYYfMj+Xt5GyxSsSXJfsChAJrdZTxf5Pv5u+PdYWAOvFffcyo8r+jBO
X-Gm-Gg: AeBDietaaq0u0d7152yqCcfH2jDhdy9V0XIFvYrQvj9JUSyFMCjORdX/JFTpvLzIPXO
	RTmDIGnYzBxDrtzDlgEnaq3L/PW3uDpcuReOHj9BhzZknWvFStq9y/midgTkguLaMXfikAr4Y8c
	57NEw5R7X6SAdMZLfS5o5trvpTaGptksazqSUvMbfY3puW/AbswLcmzB5hQZnImeRJN0L0RfCx9
	fZidEjgmC0Kq6k67JIUasElx6/5nlbTgowRIOJGHGBRRk/0Z+a/WKi4NpG2m3lz0cmtNl8332eu
	U+s/YsL8nkiIZF+GoU+rcF8weACliTB+qY6v57Hmmw5iE1jgaCWVGuSl5MoKp6ri+QzQxPDKToj
	FcCGBhVEvuB87kIUEfVzFpOQVcR9p3docqgSJ/jfnC1XHo6GjVte+OSjMoGcw7qgpbrhKaKN6E8
	bK0yuUudJCy2//aMlDrQPX0Y0uoR68oZP04jo7p448A+uD+ZN+5IBUtHvCIwYxy/JaVpHZNIS9J
	Qp+zucbJzRmpAVk4IAB2zdZm1ely3j83L4yNh/9/ANtDA==
X-Received: by 2002:a05:622a:2b06:b0:50d:714a:327a with SMTP id d75a77b69052e-50dd5aac203mr173726101cf.10.1776023179437;
        Sun, 12 Apr 2026 12:46:19 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:84d:e5ce:d94:dc76? ([2605:a601:9b88:8300:84d:e5ce:d94:dc76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5cde374sm75383941cf.17.2026.04.12.12.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 12:46:18 -0700 (PDT)
Message-ID: <d2cf741c-a381-42a6-9d26-e38481696adb@gmail.com>
Date: Sun, 12 Apr 2026 15:46:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] backfill: add --[no-]progress option
To: Trieu Huynh <vikingtc4@gmail.com>, gitster@pobox.com
Cc: git@vger.kernel.org
References: <20260412193659.26288-1-viking4@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260412193659.26288-1-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/26 3:36 PM, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> 'git backfill' does not show an overall progress bar across
> batches, giving no cross-batch feedback during potentially
> long-running operations on large repositories.  By contrast,
> 'git fetch', 'git gc', and 'git index-pack' all support
> --[no-]progress.
> 
> Add a --[no-]progress option that tracks the total number of
> missing blobs downloaded across all batches, defaulting to
> showing progress when stderr is a terminal (matching the
> behaviour of 'git fetch').
> 
> Add tests to verify that:
>   - progress is shown by default on a TTY
>   - --progress forces output regardless of TTY
>   - --no-progress suppresses output

I think the tests do show an improvement, but we're missing
the interaction with the underlying fetch's progress
indicators. I don't see any mention of how your backfill
progress indicators will work with or against the fetch's
progress from the remote and index-pack steps.

Further, if a user supplies 'git backfill --no-progress'
then they are probably saying "I don't want any progress
indicators" and that would signal also that the fetch should
be quiet. This is perhaps the key detail that makes your
current version unable to move forward. It creates an
implication that it doesn't follow-through on.

One way to go about this is to hide the 'git fetch' output
entirely by passing '--quiet' unconditionally from the
backfill command. But this may also be too much for users
who want to watch the download statistics from the remote.

Perhaps a way to have a robust set that allows all things
to interact is to do the following:

1. Add a --[no-]verbose option that is off by default. The
    implementation sends the --quiet flag to 'git fetch' if
    --verbose isn't provided from the user. This reduces the
    noise for the default user.

2. Add a --[no-]progress option as you've provided here.

The complexity at the end is about what happens when the
user provides both --verbose and --progress, which is the
situation that this patch is currently in. How do the
progress indicators mingle with the verbose fetch output?

Thanks,
-Stolee

