Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B6231C96
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099805; cv=none; b=HYGUofRNFQhYsjSJzMcz5gsjryIrrkS9C1zXqAFGi1PBLbREzxuDsHcgXg61F4Sy3R9mJvbSsCfupVfmOXowjtZYXVDcmOZWQdpBmN+CEdln7OTXaGVuTZd+cB/b4mDqKjQq1UN7yFdASwrxTgoLf1b1DdZl8ej8sTZrVQaWLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099805; c=relaxed/simple;
	bh=y2LLih7hR0jUe32zE57e/nvK1KjUfcwr75afn5qxwEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+rRvjy5l3+qGvA33cLhlEfaRzJcoH26MYR9PANHXwRXHyetYU+6YCSDgzKmq5BHrrNMGnZcL3YSuT5FSCZNB9kVWzPkIO5AQr0MsAQou1HSjQ8ozzrEmrurUFThzGUyIiw112ILaZFnwZ5NWljyvqCBaTvafHgYwU3m/NXcIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb33996b79so2664046d6.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099802; x=1728704602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1o9CImCPzaV5TdV8Io4gHadR65mVQFyZeTygW7tpxg=;
        b=lvxiGhjDrt6AdHCkT/3xQAGhruJ/bc2ZNzPFJvrHkAUUeX3nLykp11dqUGoizlnzkc
         Pf0R5UasIaOTG1GTuobBSO7VEtyJrZ6AjdIBymNCSmRsZiO6+lfJTq6yUaMpXwt7atHF
         mWLnq6BiGC8d0yPRtIeYQnZUkBVjMlIyxtA7qPq9JBWW6Vh93YwUf9tYwA+BTmovSzIx
         WzwSzYV+8MCW4Q9//yoDbqt9a9y86jarkev1XV0X0+l7YkCSK4Gpb5gcJuuPs902J98T
         dOjI8pD+M/7zQ+fHNzIUSZZ336tkJW6Tj8a+QRHjyWxAfLyjI0NCrGSmk/4L1xP4X0i9
         44zg==
X-Gm-Message-State: AOJu0YxkNbMIwTn2l5sXse+49NckRPc1/SPMx/PU3CZhaF0xM18z1z4I
	h/8PF+kkP+ssdERzXiIdYNxJECeF1O8w+MX1vkKr+XMWeX7dZGUk0GXPpUSodOsKabJd95YtN8D
	l3oWtYxfQOd5C/Z8pffDAH6WM0n0=
X-Google-Smtp-Source: AGHT+IES+OcTb3m8aHwnzOCkzoZHn5DuTEp+lC5bUDsBG+vvn0KkE5ACM2exyl5CTVMKSeC6qJwZ8h4d4NSZIm/rwx0=
X-Received: by 2002:a05:6214:1d01:b0:6cb:4e9f:7370 with SMTP id
 6a1803df08f44-6cb9a4b82f9mr30754416d6.12.1728099802249; Fri, 04 Oct 2024
 20:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
 <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com> <6250a7f6d6c84654093b383744c59d3559de717b.1728084140.git.gitgitgadget@gmail.com>
In-Reply-To: <6250a7f6d6c84654093b383744c59d3559de717b.1728084140.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 4 Oct 2024 23:43:10 -0400
Message-ID: <CAPig+cRQsai41pYV8wjPKqHz5+bF7ZTEX+UQc9zw8CG-FWUTkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] load_branch_decorations: fix memory leak with
 non-static filters
To: Nicolas Guichard via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Nicolas Guichard <nicolas@guichard.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:22=E2=80=AFPM Nicolas Guichard via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> load_branch_decorations calls normalize_glob_ref on each string of filter=
's
> string_lists. This effectively replaces the potentially non-owning char* =
of
> those items with an owning char*.
>
> Set the strdup_string flag on those string_lists.
>
> This was not caught until now because:
> - when passing string_lists already with the strdup_string already set, t=
he
>   behaviour was correct
> - when passing static string_lists, the new char* remain reachable until
>   program exit
>
> Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>

Not a proper review; just a couple style nits below...

> diff --git a/log-tree.c b/log-tree.c
> @@ -232,6 +232,11 @@ void load_ref_decorations(struct decoration_filter *=
filter, int flags)
> +                       // normalize_glob_ref duplicates the strings
> +                       filter->exclude_ref_pattern->strdup_strings =3D t=
rue;
> +                       filter->include_ref_pattern->strdup_strings =3D t=
rue;
> +                       filter->exclude_ref_config_pattern->strdup_string=
s =3D true;

For the sake of older platforms and older compilers, we're still
avoiding certain modernisms on this project. Instead:

* use /* ... */ style comments instead of // style
* use 1 instead of `true` (and 0 instead of `false`)
