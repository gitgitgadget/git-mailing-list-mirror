Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E5376466
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886432; cv=pass; b=jumWkptoRaTvuYxyOYA3wxFKKRrb+KvwGNO64QiqVfcW4g9TDcU9A91R1Z9xbCxsTs3ELh7NLBDDY+8tXNJNUdxEqqOJKBrmOUNBFj/1KTybjI9yAb62IqyZ/yn2Kzrz6Ct4FPA4AQXb/6Oqz8X+fWOhiBiyO52Rk1P8+1KTrK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886432; c=relaxed/simple;
	bh=7SdSkBkBYw0q9Y6Y9ZiQsc7jOavotoNu1/cE7LoPPKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5RwBACgbsugf92wdcFLApjQOgFaZAs+Jt1p3okyEE8+Nmrmvjuvs3P2NNBpZpmCvs0vWxWzZrWA1J83BYPJH5SCID9oaoQhFEpQca6xJADQKCheesskuAiL3vRm0qOgVMqgfl3Akl6whsG2WDMOxO2qE+I3b/My+f5iNcf9BcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr5gH/HU; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr5gH/HU"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d556c1a79eso4777346a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774886429; cv=none;
        d=google.com; s=arc-20240605;
        b=dlsh/4svSdvdjWyS9NJ3guq29q3n95YMkA6Ej0oTPgLcAQ+LYdE8fFF/HIkdVcEWp1
         trxa2zEvjgF+fANR0HchFkxDc/UuyKu5l+imPxbkwisZMOHJQWb18zf0UKtExEJ9pxnA
         5ILHiMOJFVDVx8jAlE2FCL7KwSHcYInYZ39CtGTZ8mMRtV8NqmIYVmv0D4M1NzkcEEjt
         YaBzn36lk9RllDdwm/pDN3h1wNyr14IsybitYK/hz2UmpKqWvX1GI1rp5LOIHumoT1T1
         /aKn0wBB3eSb8WwO4+tsGDQ1MKfmGr5txAlaSRZKXlRbdKFZ3grXhtRL3VqYC/7tqOTv
         HLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGEFDwbGPDZY2pDwHgZf+HnA1jfxQO6IBNiXZ5I4afY=;
        fh=F0F5gU4Z/4p17fM2qLSNnsWrEUMuzFi01YUWEN7CQEc=;
        b=LbsLPs/GeECgsNI2UyXbp7Lf1xAC4rBpyJhNR2N6Mu1quNsyd+E0ZlLI5jChPFc/yt
         2H/z688llTm/VjcHTWQMKxasB3USB8qAymiVFxxNTkfjDW18CcsC9MIs0XuRcjQcRNH8
         fgX/xKIZA3qFyJuppnM0tyOvaHhNPyqpnGmzyHu9UTqzY/a7X5zIudJjbr6wum4aoFVs
         lTZ26hjjemf+2maPCC6cCzkYO2dinKYTzpCrTtDqF/9e1f+vS+mYloG9wXnV1auVsebk
         utOCf9uUZ8Se0J72Afh+rZJKhDj1yMawI7hQoMhxRsGZgNEnFN0w1QKSVvsfPNN9Z3Jr
         pOWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774886429; x=1775491229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGEFDwbGPDZY2pDwHgZf+HnA1jfxQO6IBNiXZ5I4afY=;
        b=Lr5gH/HUCHYwuwu3Wcf6r55ruoMvJDoYgamv9yoZm8ijgtEoBW1e2dQ8Kv9lA5QB4g
         nwQ+iBjHB6w3pb+siVoKBSUfcoOyG4y5IguNIBhuqwRVrepmsLk92GwU7snfJyYAe1ta
         QnXrXxqIpgkjQ4dd3f8c494Qs8VrGpHKSwG5Z/tVHDibIwumfk0GDuCUqlJEpO9ZWLBI
         lKwEDayUvl0ClklhfTJ1ncVGxbKhhtyqgpAo2f4Jgt+Sc9K6HDfmuBzTNWPfBCATtkRx
         9zC/eR0B40TPd99xOComrXl5YlFaGYqcVO3dlw3e+0vYVd7AFyFIUWPj2jGIhvUMEV5Q
         m/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774886429; x=1775491229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGEFDwbGPDZY2pDwHgZf+HnA1jfxQO6IBNiXZ5I4afY=;
        b=ORg0rf9g4bkzv6226kvpyWGisgqX+4I6Toi2y09ggGlpoKuR530jSD2MeaGVvFQwXh
         UvJA5JGhQn03DP6OyFp5NCyn6Ak8FVtmwY6SXM/S9+wmTY+tO6/v6LeW1Yib+zDDHujx
         Xay6O0cV47iNIOrVWkDQ7zhRyaSa5TFzNj3fmPKotcJ8FA8gMu/xQQZ6R06fghCgYvwv
         t8ZhuOskiXM/YmJLNK+7wpBl8X7kThanSsHOAzWXZBxa0TIJggQx1qiN8WYDl+b8PgK1
         XAVjFrS4fPzUdTWTwMxg9d0vqDiOj2x6LOAZHK2DjntniqsaFhOPhPSlebN4rGzkO7Hz
         B6dw==
X-Forwarded-Encrypted: i=1; AJvYcCW8kwGKgBSTNXydBjN4cg3ONaHe+qeffuKCKvXAg4ykoZvgyo/Dz/yxjaVLgL9RUHDLuGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTV8xDAzjgYKMrc6EClR/pEaH/kXIM/zAf/HV1x27zbPihi7kG
	MN0sDg47Htmb7O3fAU1cRt+EzNzUeIHtTGr4f+8cnmPJZY3XYSXHuF+zClZnL0QDTpwSaSCNGOC
	EOaR9PwpFrk+if7n6Ith6zUeSYiGia0G9OQ==
X-Gm-Gg: ATEYQzxZNTfMx2u7fm1cS7fu7bJx9SbHGK7E/hIqANfPFqadO1QZoraTdF5xxRomOBv
	Qgf06kUSo5zhXIhdSw5KQJOcW0BsEfSjaymTjnW+EFv0ZREO09gPBQQ64dWyfA4bODMAOGJr9V7
	bWmpuPDBkI1jsATOh+mJ0FPYB/iV/0sdrLlCHa8y3/w9IvYqedQTHTmtKz11kJSdKRy27cdRgGK
	jCKZ0gVU//9Adc+rP7OOokeBRYgA7yzN7u8r1FBtrI5x4vVWY3Q/+Zx4/kIsJoI4p4F2g4ZLG0g
	jpm/
X-Received: by 2002:a05:6820:210a:b0:67e:3960:4730 with SMTP id
 006d021491bc7-67e39605af4mr1004028eaf.13.1774886429429; Mon, 30 Mar 2026
 09:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
 <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com> <86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
 <xmqqy0jdhtd0.fsf@gitster.g> <xmqqcy0oj2s1.fsf@gitster.g>
In-Reply-To: <xmqqcy0oj2s1.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 30 Mar 2026 10:00:18 -0600
X-Gm-Features: AQROBzDJTsVUwGq1u0EfkF9Ld5BrosaMHBVuXgthMHI0pSYRSRhynhdKDaMHxJk
Message-ID: <CAH=ZcbAKwtq9jiv=XWi_P0ZD1hz7XEpEtMPONB9n=_EcOPPSRg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] xdiff/xdl_cleanup_records: make limits more clear
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Yee Cheng Chin <ychin.git@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 5:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Updated code, when nm is not zero, does something different.  if
> need_min is true, mlim1 is set to -1 and presumably nm is a count or
> length that is bounded on its lower end with 0, so it is larger than
> mlim1 (=3D=3D -1), and we always take INVESTIGATE and never KEEP.
>
> So the rewritten code is broken when need_min is true?
>
> I suspect the remainder of the patch is broken exactly the same way,
> so the remedy would be similar?

Your assessment is correct, PTRDIFF_MAX should be used instead of
SIZE_MAX. I realized my mistake a few hours after I pushed. This will
be fixed in the next version.
