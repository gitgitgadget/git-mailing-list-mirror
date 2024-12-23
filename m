Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465C27735
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946268; cv=none; b=glxrFgWkGBAHACEJ5v07jX3zMDabrYlb6zcR47NlHMuv1uaGNLk2u2hN9QLC8XzYJMaTQFf/GEVKCQlvxHHUBwv6YrRaaQ4WZPv6RaLiZr/yKB8atgD1NyFki/xOzzWzdGkj4A+eeGfvCAtTeya8Mv9hSuUCZExLyk/2EbBiAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946268; c=relaxed/simple;
	bh=Ul++cDUrZh3nXwh48IgYMp3JdQsqawcPAZPux34TMqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcG4ECncT/8ddxO60yMvgMBqBQxFLRy8zq/C5zOQYMi10LbCPsGcnD/hKm+Ec7xRIcRIoamuaDxc4e6dQRuU0oCSVXUdDcgTLz3AyXoJwW3wXbUBUNmNdR3lguL0Mczmb7EXJMPhXCFI6JflCyYl2pq8itpCybQLALhnGPSUbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdh67GBP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdh67GBP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1736609a12.3
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734946266; x=1735551066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPsPbYCvPKmTd8K8rveNi3eSTlBMO/WdO4LAroLF9hA=;
        b=Hdh67GBPxZNrB85gsA9woRrlT5uel6w5bNybCoQjZROSh9ThhNHOscBwadIqOOQjv7
         bUxqQQVTCP6kUKGURs82RU7w2ef+DR/SQC8LPWN9AwHrs3fxCvxbgso2J188M3o5Ift+
         7Fym6fipM0FXJ/H1b3tU3BRFSNutJRC5fku5ER0LwfauvgBdpOHKEWRFlFDPDW+Yw5Mw
         cWiaN7qNBu9LilCW7rh0655QI+KSqReON6SuHlkNWTzVW2ihShToe/eCeeE7JobhQbcw
         jelXchMzRYpjdyQ1EJ3b44U53Tym/MzFz++ukNLj5B+Y1bYU7WDKZDWW+QzyNF3zENBu
         CKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946266; x=1735551066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPsPbYCvPKmTd8K8rveNi3eSTlBMO/WdO4LAroLF9hA=;
        b=Xvxl43gtAPlUubXy3cXLl7QTv1RSdS84o+tcIFJVT+M4UAHmV+LtakmxVVUZOs5gvJ
         r6W8n4mCXvuwmbXISZdJwUxAKlYssIaTZymfPUr30B4ApIlA1KS6tDWjTxxxRz5fJixp
         QzAM9B4m9HNrHM15uLYcuuVwIAb+mV5paXR/1vXvFeQdlMtgJ2eSPbV18bqvB1nJXTVp
         KhWURZx5se13o0q87g2I83Rgd3Ut43paW6pfBzx2LeozYl6lrZf3ofBve6FIBi1Y7pst
         t5tJOC8N2DxXhm6CmA/Izzn2/TvYhTevUmQeZ1iUiVbxbhr98vJnGjCZgZ/Mu86M4kSd
         cZNw==
X-Forwarded-Encrypted: i=1; AJvYcCXbRd/kv5llVULR2SuWpRVVkFer8RAaVKQqWeU9z0D3n91BubdG2fEVlYJrokh6kLEj4L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMzCOJQlUAP7yNJeYLPf70LHzQnuv8c9bMEZzbuYhOCWtiuws
	DvojelVQFqgx3vw0MrD99pPEaRcPyPmfsY9NHTTzbVwoz0hvxnILzvTFGiFwgDvpE3qiOcvKLpU
	gWSTk3SvBxxashiY/Y1GD43VkUmv9GQ==
X-Gm-Gg: ASbGncsk0Zf6Mc8UKoEvthVHzl6tZHLpd7QO0kZqwtthom3sTGeyJ2gIfCzT6lMBQwl
	YK7sveeMphi+HwGUQnZf9sp3CPhin/R9zB35vB+jdp4fHRUTFaPc/gA==
X-Google-Smtp-Source: AGHT+IGNSjNGTH0HgsoRq43Q6Gx2LvCs8R/DwMe2leEUVKb0aGPv73H78QSEPum6R5NsaQAkdy9HB+eNY61j3ti/FRs=
X-Received: by 2002:a17:90b:2e10:b0:2ee:fd53:2b03 with SMTP id
 98e67ed59e1d1-2f452ec6ec7mr16588365a91.25.1734946265919; Mon, 23 Dec 2024
 01:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
 <Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g> <CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
 <CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
 <xmqq7c7y13tc.fsf@gitster.g> <CAG=Um+0qGEf+pX0cjCA2Qti4NYwFeCb29zgS7k2Lu_0yfuEz-w@mail.gmail.com>
 <xmqq34iluhqy.fsf@gitster.g> <CAG=Um+2cdMcys2x492_i47-qdvx5aJ7k6r=xSH5a3JZtMZBEZw@mail.gmail.com>
 <xmqqwmfr112w.fsf@gitster.g>
In-Reply-To: <xmqqwmfr112w.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 23 Dec 2024 15:00:29 +0530
Message-ID: <CAG=Um+1wDY=3cxfXZxk_-vQcabogHgxGHaJ0utg+0NC2bmiXSA@mail.gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 9:51=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> as long as you promise that you never run "git fetch" without saying
> which exact refs to fetch.  I wonder if it helps to introduce a new
> configuration remote.*.fetchmap
>
>     [remote "origin"]
>         fetchmap =3D +refs/heads/*:refs/remotes/origin/*
>
> that only talks about how the mapping goes without saying what gets
> fetched by default, so that the lack of remote.origin.fetch would
> cause
>
>     $ git fetch origin
>     $ git fetch
>
> not to grab everything (like when you had the same specification as
> the value of remote.origin.fetch instead), but allows you to map
> whatever you grab from there when you did

This would be perfect really. Adding a new refmap every time you need
to pull in changes from someone else's branch is too cumbersome.
I'd be happy to attempt this as a follow up patch where
`remote.<remote>.fetchmap` if you think that's possible to add.

Also to keep things cleaner =E2=80=94 I'm going to re-submit this patch usi=
ng
gitgitgadget separately.

Thanks!
Shubham K
