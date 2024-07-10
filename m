Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65431381AA
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606569; cv=none; b=rv5eUaJvkeRisyFJqLbhXoE3TDRUt8GIlboE+GSh4eWpC9VeOGA6tYe0mwUKkT1+95Jod1WrDGGWbgeADLS7m9dp7EhNl5zMdyI63PopRELadYPFfJiKw+dw/SGeU03pHUFZbFxRrQMzgBQnop3nJnx4PUMR3SXWgqJ3laOZ7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606569; c=relaxed/simple;
	bh=kBrXx8CVx4J9Kn35lG2cTLXwZhAkc4uJcukTKkPP/4s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYsdOqrs8IeeiYVlOfCvu+Ip4hdC53xpGyLyBgje7JrW+11BCog3hPL2yf6AY1pa5QTlQGdGB8LQla5FnqfgoIaugQqT9mIGcYCoDR7u3r4fg8QF7waL7PaDfYOkjl+LX4ccksj5q4kAvGsgQDcjLunldIScpMwvf4hqhuYTn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKHGIL3G; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKHGIL3G"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e24900a82so3232049fac.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720606567; x=1721211367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBrXx8CVx4J9Kn35lG2cTLXwZhAkc4uJcukTKkPP/4s=;
        b=UKHGIL3G6qHWbVASzywrshx/Fh0jawg6+X8fmJmBjy8lr4ZSwq3x7eyoToAIN3Ne4Z
         UApK/P94zDq04s/bjRnOM3Qm5FC5fdYDWiRVJoRYl4z9KIbodz3xx/3UnLpvV7LRqlWQ
         CpaEJrlEClK0nBp4PELwTcOHgHvkxdZKSKxh2epwIXE1rv6PGBWdwGEqR14t3iJqNZaf
         teeGaEJBqjjLJwiglJpEQUIqMV67iW/4b2wt8QKJ5wIg5tGxyEnJk6Q+syNqjlgDhvy2
         E4m+xaF05EFB9K2xIqrFUPnNf8NiVsrlbAqFN0B71BjYGBF6wJCww304vyH7s/FMO6Af
         eCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720606567; x=1721211367;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBrXx8CVx4J9Kn35lG2cTLXwZhAkc4uJcukTKkPP/4s=;
        b=GHb3UGWXP3i2TKyXnYx6NwD5fFeQsQs7g6HXLZj3W9Xb6k1wGy930OGgBtpk0DkZee
         dlsT+j0yGmrAugv4V74x4plP9d5GwyaP01f7mk31yhTRZ4eJGXtWFpxdlNjeIEdszJgB
         l7STY0zi9ecSjjbEQXTdRbCbCIiX4YI/E6vbof38QeZKEMvkt84vZzgeOv8FrWHYIf7+
         iozb4Bn2IZLT9NB27Yiv2XfjTEnM/ySfqNZjtoxRzBsPzPYSuP6kcfi1Bax+iuLVIyPY
         LUHY+ehR8WqnK/PznerQwRhj91Ss/YTBhdWEH/BHDUj0JezNJcAvr4SjSHd1MgILtfAP
         zgbg==
X-Forwarded-Encrypted: i=1; AJvYcCWasnpgTM6ZZ0ywUewJbOklcrnkVoRan4zPXYFoYH0NFyl5Hn4oQ9aXuDNVxOrzVAYXR6rt9vu5x9JpXEQDInwAEmdu
X-Gm-Message-State: AOJu0YwAz4NyV3IcSNPz0B0TFpAKzlmkXOwt+YMS+IkemD9XbyGaLZ9+
	t0NG9YRK/bBMz2fsULqBb3aVTvOImFtQYa/K8AH2FWBJT0rpzffBNba9YDgUeg9oehm4+TcSZcm
	HOD+GBHl5vSYhDDWL9DlDZ00Pqk0vxLR/
X-Google-Smtp-Source: AGHT+IFGYT84gDV/ElHNx5YfsJ9ekuW4wEYUCy/NhMfVbaX46iUAiZvtHzzvVdxs+lbrgbcU/o9z1V1UKAOYtnTSh8M=
X-Received: by 2002:a05:6870:41d0:b0:25e:bd3d:624a with SMTP id
 586e51a60fabf-25ebd3d6256mr2802213fac.7.1720606567179; Wed, 10 Jul 2024
 03:16:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 06:16:06 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628190503.67389-6-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com> <20240628190503.67389-6-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 06:16:06 -0400
Message-ID: <CAOLa=ZRH7=Uj77Wd4WQW=KR8ppKw6nXZRH7pNZpHBPz4HhX8MQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] cat-file: add declaration of variable i inside its
 for loop
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003c54de061ce1ef14"

--0000000000003c54de061ce1ef14
Content-Type: text/plain; charset="UTF-8"

Eric Ju <eric.peijian@gmail.com> writes:

> Some code declares variable i and only uses it
> in a for loop, not in any other logic outside the loop.
>
> Change the declaration of i to be inside the for loop for readability.
>

If we're doing this anyways, we could replace the 'int' with 'size_t'
too.

[snip]

--0000000000003c54de061ce1ef14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 29d5edeab93f781d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT1gyVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0dTQy80bzRLY3pRUGVlbGQ2aytVOU1paFo2V1dFVApPTTY0cG9lOHQx
L3hhd3JlSndmaW1nKzhuTmRKcjhDbHFhWStHTkR5UEdEQXVIQXN2V2d4dWlOVnJNaU11V24zClJo
YUVmR0NEdGNFWUxHYlZxVzVYUmsya3Y4Tmg2UDdKdWVHeVpNWEVHNDBuZ0VWRlpBazBEcUlyK3ho
WTBYVlAKaWRpSWh1d25ucm9OdlNnd1RkSnhLWndwNllGMzhTdkRVeWJXNWdkRFRKK1hXbExZVC9x
elM2MER1Vk5BWlJBRApuTWN0YjV0cysxUm96NHpQTkw5M1ViY2dSSGl5NituVUVub0Vua0J3YTRx
MUgyZS9ZQkRwMG90ZjhWZ0Z6L3BMCjdXN0NJZVJZQy9EdkRHS2kyd3FJcFpFTk5EUnBJbUxZa0JS
SHZ3NnduQm9CRWVtRGlkTlRLMEtnd0pNYUNsTlYKWWQyTHhVQkVsRkVDaklwMk9jSEpSZjdNUHkr
ZTZwWnZ2alFLVk1LUHI3QUpvYmhDSTN2K2ExbmdyTWlGRXd0TgowR2RtUzVoaWlLUTQ4UW9ncHUr
WW9mM0R6d3ZITnppU3Z5ZkdFeWlIaW5iVzJDK1dyZi94UnphVGJVdWN5eHFBCnJLU1pBODRNUSs2
SnlYOWhpV3F0U3JqMW5SeVpybDJESFY3TEtTaz0KPXpZVEgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003c54de061ce1ef14--
