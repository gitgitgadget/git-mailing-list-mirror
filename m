Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51152F6F
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645525; cv=none; b=jmlyY6skLrqo28+92CxHhqkApuqgSg5lR11dU5Ti2VIdz5TELTZdwluSPLFIQNU14AQIGlqaci0DWk8fusLh9cve/wFPSeHvrjdCZHaHBgRSxHZ+t1Tn5tBOHTglL2sCzCypYiyWtWRS4biC7q9KFVl7aQdMi7cRAeLFKJLX1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645525; c=relaxed/simple;
	bh=uot/gU11C/jeKNvFj7gKKEHaCwzArXHR1S1PTNpyzd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2kyDswczu08c31UPZqS+5ny5v9lAPt70vtR+YlTsxQ11E3wuGtUhp2FtR4mtLIMwt+IQ9qOOB7kJ/TRNBBmkRzfDxTm2j5P+PF4OG1UDsphiqvHGWWF46U8R9p3pr2wOnjrO4donOAUV27fZNBTN1kYB1mMpDF//dmTPxl7qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690fed6816fso5837526d6.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645521; x=1712250321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiZEEhNVwOodArOcc2ov0MHkXT7707tiRNrz16oXYSo=;
        b=PK4/3284uymkrKHXD4fBw+60k/Ho6M479R5LSnxm66YgGT7IjKxnaH0p0OOMLEWEHH
         TgtYVAITdnVphofpipk4PjPOQ4fA/b/oR5zgVs4fX4xC3FK+frumVHUDnV66xU4/aASx
         mWBlwqvaMdXzypU/Xshsmh+6CDY5UhvXzmQ8C5mHU+2hG14XI2jqX6KrwHRaVB4QbcWQ
         8ea3ftt/BdoY3XmB0uEaSmTP4nnZXyui/VduODSYDQex963+Sa60h066wv+HikAhzCRo
         2TbjIBuS1oqGXoN/fLDS+9NGYkdqyakGTLvUmcMuGxdprUTeSMdTmFZXheZ3nPpJQYlu
         In6g==
X-Forwarded-Encrypted: i=1; AJvYcCUCYhM98Ub6eo53dE30lRQ9W2YeirAdZK9agDsSQ99WTYtPOW9CvOWjFnOEQZGkYlVVT6UgCBTR44fZMGDmg9Nr1qTD
X-Gm-Message-State: AOJu0YyYkRyoxF7N2QSGkngr1twXN+AKaaKdGRWD4UAW707ZdrqE9huT
	9sq1uX64KyxqApO0t+2Cr8AsC+e+o9ydFiHqHl2RL0rzGgrhuBfeKFpPFjj3x4FDmUM2F4AnQLi
	sFRGljrz/CUi81sKtOQ5g5ENw+dw=
X-Google-Smtp-Source: AGHT+IE4uGNrisV/jJa9ltVdDA607FwbzAy8tUPKlfpBnHtYbgLsYvVj2OcAJccSWb1Dbq9Kg8DOunWTwnaVnJviky0=
X-Received: by 2002:a0c:e8c4:0:b0:696:9aba:67ff with SMTP id
 m4-20020a0ce8c4000000b006969aba67ffmr3199266qvo.0.1711645521461; Thu, 28 Mar
 2024 10:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g> <xmqqsf0bz5oj.fsf@gitster.g>
 <20240328103254.GA898963@coredump.intra.peff.net> <20240328114038.GA1394725@coredump.intra.peff.net>
In-Reply-To: <20240328114038.GA1394725@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Mar 2024 13:05:10 -0400
Message-ID: <CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
Subject: Re: [PATCH 0/1] quote: quote space
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Han Young <hanyang.tony@bytedance.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:40=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> It looks like making the directory works fine:
>
>   # mkdir "funny "
>   # ls -ld f*
>   drwxr-xr-x 1 runneradmin None 0 Mar 28 11:01 'funny '
>
> So I suspect this isn't a bug in Git so much as we are running afoul of
> OS limitations. And that is corroborated by these:
>
>   https://superuser.com/questions/1733673/how-to-determine-if-a-file-with=
-a-trailing-space-exists
>   https://stackoverflow.com/questions/48439697/trailing-whitespace-in-fil=
ename
>
> There's some Win32 API magic you can do by prepending "\\?\", but I
> couldn't get it to do anything useful.  Curiously, asking Git to
> traverse itself yields another failure mode:
>
>   # git add "funny "
>   error: open("funny /empty"): No such file or directory
>   error: unable to index file 'funny /empty'
>   fatal: adding files failed

This reminded me very much of [1] which exhibited the same failure
mode and was due to the same limitation(s) of the OS.

[1]: https://lore.kernel.org/git/20211209051115.52629-3-sunshine@sunshineco=
.com/
