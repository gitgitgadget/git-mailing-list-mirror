Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02D25EE6A
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333996; cv=none; b=MCYLIACTGnNcvnqwuhS+m25qbu99GFbDKOSVSO6Ef6k/6NXrkCg87rxA4qtsr0rzrlHDDnG1cNkPaXH8lXxHGZ8xJHygr5sqnRYBzWLOHzVjfxG9FI8riIeNOR0YbhIt2cQrHZvzy5pO4q9rBe0J9MK6vrHR1/AZIQs+xagHSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333996; c=relaxed/simple;
	bh=kcE7y8UYRf2F2vx9EoNmP6t6vltimgxLYnb/OCCxDdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1nV0tOw30/jVeNaber0qq2WPdnUGQiW6EQYc9dMXAnwrumVkscYjvRhHC8kz8viM9HtMPvKoyTfUOPp3PlF4IxUbVRWhcCpjlTgbTlI1o0qiAXvP7S/lC7YscCdTdombBUzFKFsbAPin81Scu4ssuWUOYjSBd4ZjXwzE8Pf7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59fb0b5b47eso1133288eaf.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 14:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709333994; x=1709938794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7YLpu520FNOGdLdIAs9hVkWuTu16YZlALf/T+Mm8CQ=;
        b=kjrXaj6R3xOjT2G2eqLsQZas7QkVTvZ6mgUQHXplup/+TgPIF3hz/j0DyFcCCZTMf+
         zXoFIapDlaAowaJyEpxzOYpPjxinuM+3ekbaFt0ljIe0t+uINFXTMEm73ac8xh4aDMKT
         UWvHYTtaS/1kKot0kDrcGL6p0xleVH9ZOEIQ8fDtMY7+vV5Bz7OcyFDhZSbCmNvi5R7s
         N5/JIqft0tWdjhTtx0vYloDiCX64POm0WlcFPC2a/NtKduWnMxEe5HYFIngCsOV0w7M1
         Idhshl2Vs7bHW9BGO98Ns1m8rk+ZHq5pkD0tmHXdwImLwfkBRAJ+pW1M99+iyj+h3Twm
         uxDw==
X-Forwarded-Encrypted: i=1; AJvYcCWX3nAYYN/XIIKUnYdJibhMyrqq0W0tSPLAHnYj7gTTHfPdaCeYhEf5TKuv0iTJKAHCVKFm5E+kW67C0U1s1qHp/Kb8
X-Gm-Message-State: AOJu0YyTjKz3oOg9kvgGFMFLhjMRJfCHcgtKXlEhMREszZAF1NQC2373
	5e8if0Pez7mstHJJPyg0beDMNs0CuSerRReroVtqzuc2ddwglsEUuNmgTIK0HicRbf/wMfHB50y
	SRFnIV2WZh/4sgeF4Auu8RlX2cS0=
X-Google-Smtp-Source: AGHT+IEEfZw9J0/zS3joZ/htb2z+W0WCORPUbpj9zJb1vjWOtLwPU010qgzA+mJkYpudt0U5FhToIuaYOt8tt+DOUko=
X-Received: by 2002:a05:6358:d59b:b0:17b:f0c3:a592 with SMTP id
 ms27-20020a056358d59b00b0017bf0c3a592mr2591905rwb.32.1709333993789; Fri, 01
 Mar 2024 14:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301204922.40304-1-ericsunshine@charter.net> <xmqqsf194n7a.fsf@gitster.g>
In-Reply-To: <xmqqsf194n7a.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 1 Mar 2024 17:59:42 -0500
Message-ID: <CAPig+cSt4Q0e+DioFiy7yjBgn5+gWNqQOYc0eCAgdYrZUp8VBQ@mail.gmail.com>
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Aryan Gupta <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Eric Sunshine <ericsunshine@charter.net> writes:
> > A more accurate message might be "'foo' is empty but
> > should not be (or doesn't exist)", but that's unnecessarily long-winded
> > and adds little information that the test author couldn't discover by
> > noticing the file's absence.
>
> The "adds little information" version may be
>
>                 echo "'$1' is either missing or empty, but should not be"
>
> And avoiding "X is Y, but should  be ~Y" construct, perhaps
>
>                 echo "'$1' should be a file with non-empty contents"
>
> would work better?  I dunno.

I find "'$1' is either missing or empty, but should not be" suggestion
clear and easily understood. I'll reroll with that.
