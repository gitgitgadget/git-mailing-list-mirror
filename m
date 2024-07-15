Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF74C7C
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031053; cv=none; b=mUrniSq4mh/s3alioToMDm/Q6eX9A3XJf8TUgkyY/ghG3nkMd2AyaTgmztCPhk0XD6a0GqONOqkBxqjW/Vb2Q6nJ2Kw2favj8I2iQZ6CTm+5DnYD0VsNZ7zrUwHPRghcAAvZLP5b3IozvLuaWwzLprVnWQGzEI01DT10B1/YRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031053; c=relaxed/simple;
	bh=0yq/d3to7z7aMrTKFYyKhcGp1gXLBEBslN4WJ351GOY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQMr1EgrQyjqKRh/EFXrTuNOYt50Uu/7k0GUtFdMhbt3sLeIsPskwuDlH5X3MPA6EiFOszqQD0IvseakEquatvJ6MB8AQ+xo6NdZ19wotbMBQAriO+xe5LBp1Vxuu+2uUXaqligBqa/y6taD9VZAGpzAPuUi7TbjMGT5x4DpTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hawiSqZ7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hawiSqZ7"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e150603a6so2019250fac.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721031051; x=1721635851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnP7UxWF76se76XaJ1Ae2jsmSTCD++OomQKacYiPq0=;
        b=hawiSqZ7d4MgmwC0UTwxGU8RgKeWEYdqChUD02q3X04/Kb1dLR55mCA9zDjrF+OQUA
         8phb6n1JL7Nw3Esr/6K87Ifwxtlufyb8348p4yYO2iKX93PWRYW3c5/uIQmxWfAgmUw3
         5shvGMwLJEhc51Fcf9v7xMAlsYYG3iv3ZiL1+RsFV6sWkQMXj8WKz+Wgu7LoOp8q0iz+
         8tbI3/agLrKzJc0RgSjYH0hQ5vMshth54wr8kAeX3rrm/5XSsA4oUOesw4qRENMna9/X
         aiYzlV2j5kejsxceMug16+Hv+t7ILEhkw+BgrFK43eWPvDBbDwDogr7RBlk1PFfbj7qi
         k3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031051; x=1721635851;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnP7UxWF76se76XaJ1Ae2jsmSTCD++OomQKacYiPq0=;
        b=bMkk7oN/MKe2izzDzGZCl3z4S9PgBExltKHDb+Be6tQCp8JakduwneGWA2Y7/4nljL
         E2WjC9/1Ux6vjUw8e5wpo3Ee0nRNONcln9giwOz8ox7Hs4Lf29fQvmneAhlPxWYy+2Zl
         xRREF7jc+2duXLKMMn22rNFtuiyJ0vOh1oAez1Op68/jJ3Tj6SDqewjXdWROmrwTotwU
         YXeYqDBMbOIKhImxB2MllXhs59sFmKQ0yTuMeXE/S0+EaObKEuRcHItmUHPxTdhZYBOY
         AzqHyUrRjHiExmjApQ3I5oyj5izZr0u9W95u5qMV1sgdQt7N/TzOO9OePEuRylf928gs
         WOUg==
X-Forwarded-Encrypted: i=1; AJvYcCUUmeSLaZu03GUY3NVCBx8+cbqPJuU8VRbh6Yo34hBomXhoyTGe8u88VAaAe/Qh8RMpAiD8e1aftvf7/o8N7/l+PZPh
X-Gm-Message-State: AOJu0YwP9a+afkMZDt8U+7lcuY1NqyBLOwZiNEbJC40GpWVH1X817e6k
	rVHXyCLeXLzZB9mjJwveIsGAUeHyYW/QZF0PlIo/0Ewx2HvE3ZYYAIsI8tFCHM+4e5/qJ0HW4oH
	i/GCJ5nhvyr3C7wK8TjrEpPOIOC4=
X-Google-Smtp-Source: AGHT+IFF0W3nox3ft+R/mP7ZPJirfQhtjK3eddPAb4d8rSDm9e99AiWYEibhaT18zlagjVJDcWp643zH9g0FmgXfRkM=
X-Received: by 2002:a05:6870:f71d:b0:25d:ef22:980a with SMTP id
 586e51a60fabf-25eaec16b8dmr15993199fac.43.1721031051266; Mon, 15 Jul 2024
 01:10:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 04:10:49 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com> <20240713134518.773053-9-karthik.188@gmail.com>
 <xmqqa5ilcngi.fsf@gitster.g> <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
 <cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jul 2024 04:10:49 -0400
Message-ID: <CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000756c58061d44c419"

--000000000000756c58061d44c419
Content-Type: text/plain; charset="UTF-8"

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 13/07/2024 17:46, Karthik Nayak wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
> [snip]
>
>>> I unfortunately couldn't find an option to "git clang-format" to
>>> tell it to read from an extra file in addition to the usual
>>> ".clang-format" file---if such an option existed, we obviously could
>>> use an untracked/ignored file to prepare the custom format file and
>>> use it without making the working tree dirty.
>>>
>>
>> This was also something I looked for, but couldn't find. I should have
>> added that to the commit message. Will do so in the reroll.
>>
>
> I had a need recently to try applying the git '.clang-format' file to a
> different project:
>
>   $ pwd
>   /home/ramsay/sparse
>   $ clang-format --style=file:/home/ramsay/git/.clang-format sparse.c >xxx.c
>   $ meld sparse.c xxx.c # oh my lord :)
>
> Note that I had to specify '/home/ramsay/' rather than just '~', since it
> does not get recognized/expanded in that position:
>
>   $ clang-format --style=file:~/git/.clang-format sparse.c >xxx.c
>   Error reading ~/git/.clang-format: No such file or directory
>   $ rm xxx.c
>
> Also, as you can see, this was 'clang-format' not 'git-clang-format' (which
> is what would actually be used in this situation), but the '--help' text
> claims that:
>
>   $ git-clang-format --help | grep style
>     clangFormat.style
>     --style STYLE         passed to clang-format
>   $
>
> .. so it should work (but I have not actually tried it, so YMMV ;) ).
>
> [So, munging the .clang-format file with sed (say) to a temp file and
> using the --style=file:tmp-file syntax should (hopefully) work]
>
> ATB,
> Ramsay Jones
>
>

Hello,

Providing a path does work indeed. But we were discussing the option to
provide an additional path apart from the default '.clang-format'. The
option you mentioned `--style=<file path>` will set the config to the
contents of <file path>, but we want to add on top of that. So that we
could hypothetically do something like

  $ git clang-format --style file --style-append '.ci-clang-format'
--diff --extensions c,h

But seems like this is currently not possible.

--000000000000756c58061d44c419
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7904089b465890f9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hVTJZUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0E3Qy8wY0hpZVhNcW9wUGNJT3BIWVJVQUZhb0FSMQppU0hlRkFkZjcw
VCsycHRLM2ZMZjFRZ1NmWm5URFJiRlBEU3Bvc0NKSXhFSmFBVVNsM2JWMEtXYSt1V1FOVS8wCmFQ
blVyRVdoMWk3WnlYSzNONXB0ekJpTjZLN0YwcTB2ZzFDaXk4Umxuc3NuMUt3ZTlRU1NhZ1BvWGRB
OVJ0cDUKZE0rbFNJa004RkVqNGduYTd0NnlCWFFZb21RenBQS0hWcElLU0pQejMzYUVYdlhLYmtH
YlRkQkhwY0R4TTl2NAo4V1kxeXVvWUQ4V255OE1NL3JCbldrNWxwTXNiU0pWQ2dnakJybXF5TTNI
Sk5qWjFpK0RWY0dZR0lJY1IxbTBkCjQzZnFkKzFwcEdwVWFnYi9EVlN6UWZwMmxzSDE5YUJEVWtt
MHVGaks5ajAwc2xHS3o2azFtQmc2M3JzVW0zcmEKTncwaDNuZ2FjQTJaUTBMMnlaY0luUG45OFFj
a0I1UzBvWXB2cmhmc0Y0Znd2eUpwalhxcGhVMlpKZkY4VjA4bApmVDJ4T0dWTVVscHZrYUh1MXo5
VTJpZnlIS1U5N1VteDJnM2ZDZHJiUllISmxjNEY0aVo2UytTVjVaeFZ4Q3YxCm1vY29JcFJPcmNH
aHl1cWZQMHg3YzdQcG5JOXhXZ0M2UWRvODhkST0KPVJqM2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000756c58061d44c419--
