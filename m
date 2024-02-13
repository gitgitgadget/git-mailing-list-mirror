Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6915EA2
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807359; cv=none; b=P4rQSc7xKBhgMmK5Znwx28tZgNHs8iZMnxXrYXFV3KW9U4l3xwjwL3Me+4yKHJZ68L1kq3/DYnGzwHiPxTo4R1e+xB04cCeeIb2j8RdL+tmIYnhxvoRW9OWP4sY3rraU49hNrG+sTHsxoHTVMjA8lI2XHJQEe7RhQF0tFc4xCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807359; c=relaxed/simple;
	bh=JCfs+cFzNFqiYJTfetj484MPb2k6GjUJ/v9RZjYngOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPbY5A4otFDTBXc5kcSixaXMEXld8he3hBPii8snc/UUig36BQydoEzPNbg42/sT6WPyTOFa0CUTstOvpSPoRRdQ+DxaNBqjDBIU0WXS/7OYc7PWJpwtdCImvt+Z2xApzu0K7in+qc7MU/gTv0fe6/1x6IWgkRY1TJFRG9Dkeno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coRgA0X/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coRgA0X/"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso4793305a12.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 22:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707807356; x=1708412156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOLV46Fj5Jw63G3vPfhCO7jbSuZ71KC8PM6rgA43xMY=;
        b=coRgA0X/vJUPny+S7NaJo7V66K8EKdEUPScvYZICpanrbUMyTYURk0BvXHO9Iv5a/N
         HPjpuY4XXatMVGVa9C6BbzTTdUtJ8/wYezlZ58eeTr5wOk0pXV8LL3CyxY6fkcUB4ta3
         EgEmErD4AXzRUBWOev63SFhMsfco0nCfHaWACB6P8bUrioOXiP1WiFXIvMLWKe+/Cikf
         jaXx7goIHZEIEy4/LCy2v0lrgvY3N2nMYLs7G9HIN/KBbyADIwqLYgud+ZaSGdyi3OHX
         ycifPtbHhSkq8pmJeUgKVmBk6/tiHZXHNkdSuzwqxEUdfOEIylQHgl8vYw/n7SVk5suP
         aTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807356; x=1708412156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOLV46Fj5Jw63G3vPfhCO7jbSuZ71KC8PM6rgA43xMY=;
        b=pNweDAiffMsjngjx7C0pIFdcaGhQaTasyr4Y8f59syrYzpBRVAPw2xIve51lZYzpGe
         kfdlVWRtMfDrppuBd+FFcetZnyv/vxtce6YjsNZ3G7YnD/lkYnECSXRdpM8dHrHUZzSD
         AV8SQ6sXREFheZA+Qvds5y+cx+TKw+ysDwBtLZ3yjvv7QeZCby2bREZ9np6urSvWuPPO
         ayRPch8p/O+LMyAco5Db+L336fITsTp2klRQQehff0THP9dFGVI/ZcP02hcBSfNW9HrK
         A32jPDDrDliMsg/b/PfW91/fksxu1Z2N9zRN6bw9k5L2pawxjSIDPPpkowW3syk91nzv
         1hUg==
X-Forwarded-Encrypted: i=1; AJvYcCUIeulHGQXW0TrCH7RnbWORsXeBxlCnlpZWgCjUNti1X0hAQAKyRz6Bh2XNseGP7FgqIu89ekr5w8DUicCR9qT1Jnoa
X-Gm-Message-State: AOJu0YyOJjaYQb6B3FVr59My6axM38FCUurxDCHs61pjdk6C5nfagtDj
	u5h4L5infVIf7+JylPW9n34qQxAqM/mkNx+nSYRpesmpiRqH25MzKF9g9Ydqof2epVmoYrgdChe
	XTqL4QOejdYsIZYhYePg6IZJBZV4=
X-Google-Smtp-Source: AGHT+IEVPgQ7XxnYSGP4ZpamyVhDOpZWaPo3Vj24OCDCYcHhyclTJkbHCaA7xDey23aMKauJPGszNAy9xHyr1rUOSqw=
X-Received: by 2002:a17:906:fa15:b0:a3c:a6de:aaa5 with SMTP id
 lo21-20020a170906fa1500b00a3ca6deaaa5mr2919907ejb.8.1707807356145; Mon, 12
 Feb 2024 22:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
 <xmqqjzn94404.fsf@gitster.g>
In-Reply-To: <xmqqjzn94404.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 07:55:44 +0100
Message-ID: <CAP8UFD0C37qdTUvCpRFe6_zAeAcssoySY6tobw+AO8hpA8iAfg@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> This patch series is the first 10 patches of a larger cleanup/bugfix s=
eries
> >> (henceforth "larger series") I've been working on.
> >
> > There are now 28 patches in this series.
> >
> > I took a look at all of them, and I think that this series should be
> > split into 4 or more series.
>
> I presume that [01-09/28] would be the first part, nothing
> controversial and consisting of obvious clean-ups?  I do not mind
> merging that part down to remove the future review load if everybody
> agrees.

Yeah, patches [01-09/28] look good to me. If we are merging them
without the rest, we might want to change a bit the last sentence in
09/28 which says:

"In the next patch, we'll change format_trailer_info() to use the
parsed trailer_item objects instead of the string array."

Maybe just: s/In the next patch/In a future patch/
