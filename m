Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FE39B949
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293745; cv=pass; b=qeEOY5HNK1APfVW1eyS8/rnMxW3O5xV35aoVSj8aQFb3mA7gH2DSRaKbTWNvUa8sIcvCw0JbhTLZuZpyCysFCC4wjhdcpKrXu0dzax35nnMCkw6xlOVl6/y/bK/0ZsE7r9eVSLDmLv3o2KKxLfpUc0kQy2qaUKaOezSW5KIrahg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293745; c=relaxed/simple;
	bh=HeQBBevBOEpy7+Dxj/zYPsx1mGKvKWXnrAi65zJ90mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbWL01VIsd1cYkFi9dBMjNHbTHp7luqo21cNo94c00q1Ez6LCcE3CqwIGU5Qv0k7RI8b0U6KUCUO+J7ORc//wnXu04xPVfhRQKmpszhlCzaZkGSNeK5tkkU3MJSCMi4o7tFDvlAYDbb35tue+RKxW89iwCvKkQ4lf//4ItuK8OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtG9C/+1; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtG9C/+1"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso70245c88.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293743; cv=none;
        d=google.com; s=arc-20240605;
        b=Az72eMOs7Acaf9hsTeYVWQOcPrOTzwit/KqU3qMSwON6MEK9awbK9cutA7z5b0kBDA
         JPrRR0uiPOPaWaDpqy+tuKdSwkFprpXN08zUa5ETH3zyRfL0aRZvRnRrohJqPd84Csyx
         vkKgq0o7i2BOHlY/8Z4PuPjCN6VwqBHDI3ZATlO0oJsuDx8QHPJs4u+/qmwJHhDitJZw
         IE0R6W7XpyuKoGAjDhpJZKcWhNrei9v9/dDB2WwSwdgV6pGeJrQh7QdncwmrRch9IQwl
         moY0U4ZrNrSehv+OuMeXPCReC1MfhcMFIOmpUl/GgHCsy30GhGEdf6kgynGojOJTQc/V
         3tPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5U0Emk/DqAfIjuQ5FLMdCnDUAR5cs2OZcQ9ulFZy34=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=jew4or1eNVbwNkULyPZgRB4lwuhgQui4qySrCv0aqake1/lF6+HXxNU37Jgqsq9Egh
         wAqT5O/PjFqgQwhxg+9snjSYQIASWis1seeOywnh2kjBi0p+WI/K3/yoPEIhqzSq0xQP
         aPJOmEfN/ac97f8Kzhz3xrtThfryQVSWTkdpkUiaU6aNJcA8+N28pO9qPLlVkgmNF2jO
         re7b8huX8xzsv/RnKlTBeNX/Ufs05+sVTntKqHlwcd3ZkcKIziQAlWoW78AdOEvPs2ol
         gnDa0jA3pprS+AQP9TunWQKXmNLpfjYGKxhCXlI16Or/DhKyFKjvdNF4ZGg4mkDpBvyx
         gycg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293743; x=1777898543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5U0Emk/DqAfIjuQ5FLMdCnDUAR5cs2OZcQ9ulFZy34=;
        b=NtG9C/+1ArolK1SJMIMPnz2KEzpA2oOW1IUjVDUkv9ouMcUvO9GBdTiHUnsXbkH6SM
         DngOo53CrmPXjhyl9ZTHDH+BcAU5eD8HhleuNEtEwds6qAGa/o/I56d16FkFP111GrFu
         4ZvCYdU6V+G6sl6x9lZNFtJBMY4y2oNpN6FT49nO8weclK/bJAIivTQ1gIBfPZweQ86M
         SwpPrjtmj4YjdXPPBvc2+udsBoDTn5AowQp9aQm/JjRXcmPU0YE51vUC6vIvbeL79V/c
         ++udLPC/4jVmD+6lQOyFhrXJNJkZKMXcWPicxF2mX0y0ygrMa/kMjhf4Jf++CX+BXgtV
         SrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293743; x=1777898543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5U0Emk/DqAfIjuQ5FLMdCnDUAR5cs2OZcQ9ulFZy34=;
        b=XggmHT8b3Ax2BkZYhEYyk6nOYC9tXTa+FsP9m9LoAabMKQCgrh3+jKa/g/7jgyV3ou
         ggJc0eTBIl1dI/AFqGBNNOF1eaxKk360V7Q33vXZ3jaJG1bh3rgkdEezXX4Y4sXoZYev
         s+Xni3EL2oUW+2XrWeptTKtwQ6bhURZk6VXgFQR/jSdWvupNfah+uiv7B5Bs/JGliOw4
         Mu4tCj8mWpmalCCU2Vx7m1cNeMKGOaSzmOWXwFuKyEf6U54IgwJCUzKxcYzz2VVHI3cH
         RQ1JsAwzLgEyeVsJ7G8zThRpi9ZypJG45ql2ZmkxzB+t8vXp/TRoZEGOtF5kZ7hWJQqb
         6x0w==
X-Gm-Message-State: AOJu0YyybEzSLVEQGrhjW6zdcca4Vv1sIIc172nV7GxuHM4S+lo7RnPl
	wFDTU595yohR/VGIJPSMK6Tye3kwBwlRHyi5XiYr940U/Cg0imM/MRex1tc5psihJk4sZsy9Yj8
	FhhorvRY319oBe4e4ZayeMFSjZxMBI3E=
X-Gm-Gg: AeBDievhXtDcPvhm5mlef5KEpgiEtR9aXenDMJPBGLgIL7CVVoNVFo3LxHF+BVxg2mN
	fkftc+C5QluIcy468nxHaedBpw/Erbk7i4L9wkFZxjZ1j/4YbUwUD4sEqIMneApw0yOVvvG334M
	nr4QLmRufzYs1paz4LkB+MaGEyj9GzYgOh/71Tza+HMafifmRPenQPFjOuQj7JZksKcrQoDQetj
	xMCRxuSEda8pwTxRbWA9YQ88QKbGYUD5EJ0wFBQZb84Bgb6T4dCsKu9unCWMhmnYkVp4J76zcWl
	uf8YTEq2xu+Nngu4Cd2YTNO35zMdCkrc9rj+8LI3UDZ++1H75M31N3HmTQVo1/BD3tQSFNsq22X
	4MTA=
X-Received: by 2002:a05:7022:383:b0:12b:ebb9:1c18 with SMTP id
 a92af1059eb24-12c73fa739fmr24122277c88.31.1777293743157; Mon, 27 Apr 2026
 05:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-4-christian.couder@gmail.com> <acUkpJjHgYs0jqX4@pks.im>
In-Reply-To: <acUkpJjHgYs0jqX4@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Apr 2026 14:42:10 +0200
X-Gm-Features: AVHnY4IZrMJ7-pfEE8wfeLDCKdJCM8EkolWT9Aza6RxHHwBOawbDW3Nh6mEEAA8
Message-ID: <CAP8UFD2AwxJCNdgdL4KSRdRdeSdapTkAbFj6pzcy8w4gOczM2A@mail.gmail.com>
Subject: Re: [PATCH 03/16] urlmatch: add url_is_valid_pattern() helper
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:06AM +0100, Christian Couder wrote:

> > +bool url_is_valid_pattern(const char *url)
> > +{
> > +     char *normalized =3D url_normalize_1(url, NULL, true);
> > +
> > +     if (normalized) {
> > +             free(normalized);
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
>
> We could simplify this implementation to:
>
>         bool url_is_valid_pattern(const char *url)
>         {
>                 char *normalized =3D url_normalize_1(url, NULL, true);
>                 free(normalized);
>                 return !!normalized;
>         }

Thanks for the suggestion but this patch has been replaced by a patch
adding url_normalize_pattern() in the v2 I just sent.
