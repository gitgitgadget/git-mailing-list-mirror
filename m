Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63118AE3
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785631794; cv=pass; b=Nb3ssSsOHfaqmtkGyKnqaWn5/G0PvwYWTALKWvm2Qr9QrR2nieKOK62K+k1shrLRje4BVsnc2/TI0smh1wrW6E7tBSIIJNgfZhk48igOX6Duwgib9Nixnp+DrwMUbsXE4FE+UVLzQBU1cPZP9atIOBX6/5yb4LeQraVD797uA+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785631794; c=relaxed/simple;
	bh=ib3okr9nW78wgySu1p+qWbdh8/0VeAJ8mhzU6JYsyhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuoCci986wGnGJTllcSQlTtYUIB69gwWKjdO5kTTpbsFJi0FBkRzB/gQyjJYEcR2uqzKdWjKneX7mwDzfopcK1hCukgfCEga4AGKkZvWW7sw7uFA2hf0Yhmp1nONPmHgzhhQCEUZvCrZ6Tf0IA1hSX/txsrLJ36bkUPiVQ7eVrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGL338wW; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGL338wW"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a427e628a9so845912b6e.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 17:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785631792; cv=none;
        d=google.com; s=arc-20260327;
        b=J0U9MvUJjUUVf13BtD8JSXb5SGNtTSvysKkZtnym9YTZO1cEzUYgxOlktBLmvBz5aT
         FPb73gyNGi2wnjxndmocEmUxX2ZV4bWFvXNQs7Mwil8myKauViTf/TodlTxMCoc7kIfI
         q6VL74GXphygV+8gp1nvHwmrunkl3em84thhWX+GyK2EWm76tD/vQjRo3WZyIELp0NEz
         BTLQsp4QTSGDvB+bmVSKi8WnuriEreSTD1UXQOUBbhduP2aKtpl+G8NCEULdNAHTJsKq
         7TjXNcybyAswUUzBI2lWuB64q/JsNBgQ6mqAbjlYfBvMRKc1QzZWu5P8AK/2VzRkzLd4
         lfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zKdy6WgfoI0ibkWzPZ/LYPjoy6tl5ilXPLrH70p+eTE=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=eBq17AjHUaBvfkKgE5Qi6R/B8zeAg6Ml/HjQMdmvvihmXRnx2ExMWYOlpT4LAgmOqN
         MhRXXH8Ag1p5M5VA7L0x2eQ+cuyAj/maJuT99Z93sQGP1+ZGBrOIrFqS9yqOL0AfgMtU
         ObkHXpvIFKt3gEsh5PLGJr/AYLujc++L2IQ0FwMTYDYEtdwjjYx6VO0u/hEchGnwEcLa
         /Hcq61CI8BJa1Szq/OMe3c4dds2BF7y/KTRYMVndaIq2a6S+Au+xFQAwRJpfJjwEDopX
         OgTQexP+QNDOSYkKcPdEN5UKyhG3kJwpfQlSUYcqgpO8i6hNh0Mc7zyn9IRVJmRC/LxV
         sNkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785631792; x=1786236592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zKdy6WgfoI0ibkWzPZ/LYPjoy6tl5ilXPLrH70p+eTE=;
        b=SGL338wWktO6eZQvJJKxqaYqc8KwVkUBtfVEJjSD25+1fMxYySmGYuSHQvuDnG/hAj
         9i2Sbs3fPJyfQykoiUvdHJm2IxlbruZgEJ4pBQjPZ09lQ4Hz5MRL3qPmRjNEpWpf4Y/v
         KzcAFxaQENbK6VfdvvrEStfc5EH9MuKW3/QsWsjwLsbvVkoyz2sXYw2eWUlKWd6AL++X
         3I6ymuy5B5/pTXClgPb9VicOJZCZA/YPvzcUZhgAOu4obNZRftAYOU4we5t5DLC3k5cO
         I9VLeeh7wHuweUhVgPssG/B9pysLKBIOmKfrD5ATcf1awFkq/C61EphMV6l0QlFs+oXt
         o4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785631792; x=1786236592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKdy6WgfoI0ibkWzPZ/LYPjoy6tl5ilXPLrH70p+eTE=;
        b=Ksj/FGCpp+Yu5xPF57kZPjmv4Nf70vcPrOKhQ1Zcla+QoI4cChaaUyuEdut2NaN9iB
         13tSA5rX2l+x56x3drPx5s06dYqUhp2uaJtwm+NcRJbhXQ+oG8OEM1Wd4TIZYhTlFnZP
         A5FRr7KaZhDgW6P8J4BpwqaUwKidDPd498qqwIG3vbECzvBHY8DoK+hXxRVSG5mugo40
         CFup4a/RsaVOqmaU7vrIGXY8YS8daWvbN6LaN5/dcMjluo5txlbJVmRFRANxYUHVrNT6
         YnodIfS6Sa4phAxShlcQr8TtT+7TNg58sMWX+I9OjFK1fEHg6ttfeEtl07pd0F4Nzmeq
         j0Hg==
X-Gm-Message-State: AOJu0YwtsovumenOmOuDgsuGsaoMN4H2kZZNvLCeeLbhDBwrTqAOow3D
	OR9hevnoN2ZIr/SfnTbIRYpWfWIyqPOoFiyc3YUyJjnx2PKM3bTspMkejlON5SZQ4MRNIrPbrcL
	vAUp2OIcMDhkGAYuo+B7/dMKTCbauQkzgQg==
X-Gm-Gg: AR+sD12RuGtvhURs/N8wmQu5vvqjBFt82em4aEXMo1xJV2yKJb2kSkcWl+aK/QXJ1XC
	j5CKd9YuDZ6CqWYBTsR3QkZRMlp6YlPArAMMoBfftzzg8Gg83C/2M4ujVQpd7epGq+JY0s1n4iJ
	EQbW9icqDQ9vyvw5q98IksgOgFVLuZNfijY1acKcHoiejOVZn/3dAmM5WeHikdERHz4CQCOgIkj
	mSHAR/Df83WOwIgU7fl3S+kFa4/ZJ+fPPNZl1jBLQE32JMHlBpJq/9B+ELaCHXRgoaShn4tAYlM
	knbFESN0B46UUlGXtZrAUoRwJfz8TgRhJ5WQvH4GqRRRF/FJjoMW8xh8WXm6TMm7Di0qFw2ELwb
	5X6QrbHXwmDaMtxTKnaOzWQiXrrN0ESD5UERJlE299n/dRJVlAhw91AgPrqMn0wxw8D3p9Q8ieA
	==
X-Received: by 2002:a05:6808:2387:b0:4a4:856a:c622 with SMTP id
 5614622812f47-4af5e3a6b63mr8614850b6e.20.1785631791808; Sat, 01 Aug 2026
 17:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728215219.753678-1-gitster@pobox.com> <20260728215219.753678-4-gitster@pobox.com>
 <xmqqse51algy.fsf@gitster.g>
In-Reply-To: <xmqqse51algy.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 1 Aug 2026 17:49:40 -0700
X-Gm-Features: AUfX_mzBAghdOF4R1K2KHL1N9P8OGwL7U072Pt5IhF-GYM9Cbr4xv8jyTQ2g4XQ
Message-ID: <CAC2QwmJeohdnWhUbcP6Pc5w1X8yZf3jXvpR8JC=Hb9gqkFF6ig@mail.gmail.com>
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:17=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
>
> Left unchecked, this loop may end up scanning a large binary file to
> the end in vain.  We may squeeze in something like this to punt
> early.
>
>  merge-ll.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/merge-ll.c b/merge-ll.c
> index 5e5044b9e3..ef5287dee8 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -516,6 +516,9 @@ int has_conflict_markers(struct index_state *istate, =
const char *path)
>                         has_markers =3D 1;
>                         break;
>                 }
> +               if (buffer_is_binary(sb.buf,
> +                                    ULONG_MAX <=3D sb.len ? ULONG_MAX : =
sb.len))
> +                       break;
>         }

Should this check be before the conflict marker line check in case the firs=
t
iteration accidentally matches for a binary file and breaks with
has_markers =3D 1?
