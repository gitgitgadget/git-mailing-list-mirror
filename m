Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F85221F2A
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687217; cv=none; b=f4UTVmDsujLUq5WrlCLgXkwNjWSh4tc4vxxajElcB/f7x7sedXVgcIq2lX3z4ALEBksTdCa0gIPV32z31eIcEqpPYRFz0wYV0VFhz3NDvMzQ3t53knSezCNb0BhU+rTdYOSQOeTY+cTSvpJhSYTC2/pK2pZ49BJh8NUt3v95oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687217; c=relaxed/simple;
	bh=GkmDw7TRDMR9ueG/NLEc05Zfq67kN8QAahx+f1xr080=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nlJs0u8sINW/rosoUWekobtek0bxDZcVbMsqjTTqMl01I2TM8oQc4hesRDyDtqOybk5uCR+VDQbTafbaUmiemt5bLLPY2UBTtqlm4iKTP50dePIMV/frZnCCiYLitNyUyhT3s0S0S1cyNEg75gDdVKwwRpgk3Rk3BRRjP6p5DMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqdhRech; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqdhRech"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2243803b776so90311555ad.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741687215; x=1742292015; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKj1neXV7c8JbXk1zxnHM0WRGWEwUk2Mk4YvLDgfyQs=;
        b=FqdhRech3FoYMcW+HpXn9BtAc//aC+1Wumiu/bTNYDBTqKYufhejdqQkplWoKhI5JK
         wnNCVFv3NI8Rrwa4rKod+2ZybqSgUUdq1X2NQQOltoXTey6WXVx74W0f7X9ybUmvMXZB
         4Y1WuShcAQxVI25lPk/PuVc6HXDAZMlY1YNlhpsGi3DLkFJQusqiEsz+Gt6KdixTjtlP
         MzibGen6t/LTQCsMPlxZSSVAr5VlzV8KQ9nFDh0LUUmzUkWBe/Bl4GyBNZgmhU++p1wY
         ZroHNn6pDTtETOnF36gVT0RomuOEvs4YJy2Ad+v7bSBUphy/unOiwv6AvkVuV+XMvPb+
         osuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687215; x=1742292015;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKj1neXV7c8JbXk1zxnHM0WRGWEwUk2Mk4YvLDgfyQs=;
        b=LOiJKrtv5ULqEAJjMGtRfdcfWbIOEw5zHVGhJZL5KPShj2Fpx+92z/VlEZiKqEKUY6
         xN//Ahuml7NXEIhr1RKHGhZbfZlMRPST36e8hBoWVNkj9mYAPFz66/iZagb4YL/yd5pa
         q34s1kWJViKUXZ4Vp8nn85HQOcn+Il5tfIFqCDPsO0PFxmnTgTipv3lJLUMa+KISBmvQ
         z9Ea8u3p6dt8phBs8SoejrZEIglQAPZV/X39f+l2GDAUxXmFxZeTsbZjnTdWhQUJCaY4
         cFZWWC4y1XSNbwKOOC4uQz6Y9V4YMLdUl0flasuFqwOcFPiELgt3tT2jJaLgK6u6+TFM
         KqFg==
X-Gm-Message-State: AOJu0YyLCVP3k/DzS57EEwlWzZEa96Qun3T6X35sZc9Sw/V1cZRJHzho
	2CjeluUA6QWC3SSleKy2YFld2ALr0Morc16AN58iOHvqOUMiWjm1Sc6rFw==
X-Gm-Gg: ASbGncvNemrJ/RotRPqM0OIFfJ54y1J4sDSGniER4/JTb+JU6qijpDfLccayu5WoSTU
	3DTplSAc6P3fodzlOpbnjGU9VzgxeMardKU/mOE2HC3tOj6onUN7HI4PHnbeyOJvA18dLCTjN7u
	rL0WW9WFZJ9LYLwNk1rVV/BprDNCJJDirqAjLvBqJ4p6qJWWiij0o4RR5+TasLO94zH0zMItOLk
	x5jEknbCR1BAa1fINkaGlCIReNDd7oofAw5sNZrzgGxQvegBJ0GGP+4OdAWp42syU5Qgn5l6ooq
	dvHwbiEicgy6lOnxQw2LJhJQgvgIwzdh2omv95fRC9jCT0+zJAvjv2zjBYQ8JkAdKxJ6uzDd02O
	VOe/2bmqJS/7fn46q0bAXMPrX6zw=
X-Google-Smtp-Source: AGHT+IHkfDpLZBzv0leevbq+s4rJogAXdhgG8VCzbBm14iaRozw+CM/NivRbwhkEycckAaktgA2ruw==
X-Received: by 2002:a05:6a21:7103:b0:1f5:80a3:b008 with SMTP id adf61e73a8af0-1f580a3b158mr12226428637.32.1741687215233;
        Tue, 11 Mar 2025 03:00:15 -0700 (PDT)
Received: from ?IPV6:2402:3a80:4190:e364:c141:c68f:80d1:8af1? ([2402:3a80:4190:e364:c141:c68f:80d1:8af1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af54cfed6b9sm592145a12.52.2025.03.11.03.00.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:00:14 -0700 (PDT)
Message-ID: <629c3c21-ab11-42c1-8cb1-34698e736db6@gmail.com>
Date: Tue, 11 Mar 2025 15:30:12 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: Defining timestamp_t as intmax_t instead of uintmax_t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

timestamp_t is a data type defined in git-compat-util.h as uintmax_t since
28f4aee3fb (use uintmax_t for timestamps, 2017-04-26). It was introduced with
dddbad728c (timestamp_t: a new data type for timestamps, 2017-04-26) to replace
use of both time_t and unsigned long for time-related uses.

On Linux with glibc[1] and on Windows with MSVC[2], time_t is always a signed
type. I think this is also the case on MacOS and FreeBSD. Thus, any conversion
or comparison between the two types is one between a signed and an unsigned
type. This also means git cannot deal with time before 1970, though I can't
think of a scenario where it will have to. However, it does it to sign
compare warnings from the compiler.

I propose swapping uintmax_t with intmax_t to fix this problem. I do not think
that this will cause any problem unless any code sets the most significant bit
of the timestamp for some special purpose. However, the fix will take some
work, considering the number of references to timestamp_t. So I want to get
everyone's opinions on whether this should be done before starting work on it.

[1] https://www.gnu.org/software/libc/manual/html_node/Time-Types.html
[2] https://learn.microsoft.com/en-us/cpp/c-runtime-library/standard-types?view=msvc-170
-- 
Regards,
Arnav Bhate
(He/Him)

