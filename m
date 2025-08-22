Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C652C0303
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888359; cv=none; b=GgaokVKX0dVCq8x4diHFDdSdOGcN0V8Rvt2ggoUgjdV7rExkjkvqh+gO//bqqbB3nN/5H2Q3TrzsHRIP2/ouudET5nMqxAfEf+SkfBsxZMUUiqlufOwZ20CM4CtyZQ/zqbjOu9k9EF+QlhkK5G7eObE/agQuE94oUe396O/jK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888359; c=relaxed/simple;
	bh=jmDmjJTDuvkLc+FyVeTRGzL+ZzYWxTPmOSkNb1dee4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B53J2GqrGoR+6WI8Ch7B3x7hKRpzCERM313yc/JDAFnfc2lPv9gOs7dNPHTCNMt5sbVK4W09NEEV+4wWFaSRVWaHnZhhAav6HZ1YwjF34ZhCn+ZNFZdwgfbaUoXzjg6WvhfAONgwVQ3GhfgQH/pLdxa+ua+Ur0S6Cpah2rkfndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F52L+o4g; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F52L+o4g"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e94fc4de34so12188335ab.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755888357; x=1756493157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6r6Q3u6uhHXBWprKy6vtR6cwIRr+SQd3iBfm4dTYkE=;
        b=F52L+o4gXytyoCzzLoKkxgCpMBhMkHOxwYGANtU/YWzY2w69/6OSEnWGSgndii9G+0
         9CtDddzoTDGb9E6eH2/Oga5vfGwNZ5oTxWiOi1T0QhUDN2ghQ3OyEe9ozZwMnnP0EeXG
         ygQ+3H4pxgzkxGZMUOa8Og7ca7GPl43ZZiYxbRh+meJqTrfImXlxvja/TQ+qpfBz0jGn
         QBbWHm9BFbPeWEUE8msmWWjRKXhTv8523vDMB0ZCbxcVU+fFRgY7a5Plu5rtkCcHApFZ
         dccql13raWjWXvyrNwjMy5YFgKw2pBemwmldcAmoLxR5MVVxmwCrXgHsfU+Z6of/ITIj
         cSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888357; x=1756493157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6r6Q3u6uhHXBWprKy6vtR6cwIRr+SQd3iBfm4dTYkE=;
        b=sIoxmwcnVQL6VXoNLDFQBbyvP9miNgDbpAWZB4xcx44cYNNfeN85TEiHTsAXM28gLq
         oIHUHkxKfn/WQl2ro6fh9szZuZ6yyItfolEAPmvMaOck+i9W24eztiAQzJN+KxTc2rEc
         +KVayv7W6B6hPir/lDzl5s89KY1wo/4grHTFygg72Dh4PGn98Pj5JB2ryChiaRQanxPP
         y7/KsfWQGgfnd+JcizfU+vXvik3IBh5NWGHIomJGqDajx4diL0l7MM9mhOl+1g9hz6Rq
         2T7tkqhKYVOpRcGJAcMZJ3iE0iE/90WKzJ8OkbxSoX+z2jEccUkNvLsh/yjftwj54AB2
         PGbQ==
X-Gm-Message-State: AOJu0YxmFGGMWzxfMf/lpG1vIGVMsmldzTVCvOeA3btfnUV5IeBhqBjr
	tdtpYwOQAjCbzjBs1uWNNdOx8gMckI7XTflummi+lQcCvZ+6EPrJMxEXlJaCiAQCzgFEP5UFcj5
	lwXhu6FR84iSbCEWekjI/2LUGSsbyOPg=
X-Gm-Gg: ASbGncumixeNH7PSdaYWXQT5wEn8KKSMf3bPffvfDERbemtFxbVSjkvQb0RdjYtuSoR
	ZH15P9ZKs+msYbxpFjOEdDzPuTXyKbx8c+QshQV/qWZrzE0R6hmedkBi8WmgcPk6NrNWY25ufaA
	Afix3cx03cKQOdYqkQDszS149yc9sUOJ3QHnzdPnvQI5lEhSlhnNeaxXdLZSRrN52/e7Rni56zj
	2JXju3kI1Ahgie7Z25/I+fqqCKeTDEj6nni9U8195sZvTp1uGA=
X-Google-Smtp-Source: AGHT+IHJJtEFRP0A3AqjqTd9M388NbbGTYKUa0DsncPLLIoXYXhDuelltktzY04jL61TkANiNy+JO28MKx/Akjpbzww=
X-Received: by 2002:a05:6e02:1c02:b0:3e5:58ba:d9ca with SMTP id
 e9e14a558f8ab-3e91fb2dd94mr68949695ab.3.1755888357205; Fri, 22 Aug 2025
 11:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
In-Reply-To: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 22 Aug 2025 11:45:46 -0700
X-Gm-Features: Ac12FXxCQ5AF8zYYOhdgH2SjGs8ugWRQZz5ECCeuGtpixq6OaSNSrm07hCl_9ZU
Message-ID: <CABPp-BEVzNDurd1h+Jw905RO9bg16eDacqg_Ee7GD66Muj0fSg@mail.gmail.com>
Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing
To: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Daniele Sassoli <danielesassoli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:14=E2=80=AFPM Daniele Sassoli via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> The docs mostly point to using git/git as one's remote, however, when it
> comes to Sending a PR to GitGitGadget section, the reader is told to use
> gitgitgadget/git, with no mention of git/git, potentially leading to
> some confusion.
>
> Clarify that both gitgitgadget/git and git/git can be used, albeit with
> some differences.
>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
> ---
>     doc:clarify which remotes can be used when contributing
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-203=
4%2FDanieleSassoli%2Fclarify-remote-to-use-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2034/D=
anieleSassoli/clarify-remote-to-use-v1
> Pull-Request: https://github.com/git/git/pull/2034
>
>  Documentation/MyFirstContribution.adoc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFir=
stContribution.adoc
> index aca7212cfe2..d014c5c36e1 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -908,10 +908,16 @@ Now you should be able to go and check out your new=
ly created branch on GitHub.
>  =3D=3D=3D Sending a PR to GitGitGadget
>
>  In order to have your code tested and formatted for review, you need to =
start by
> -opening a Pull Request against `gitgitgadget/git`. Head to
> +opening a Pull Request against either `gitgitgadget/git` or `git/git`, d=
epending
> +on which mirror you initially cloned from. Head to

I think mentioning that opening a PR in either project is fine is
helpful...especially since the UI sometimes changes the target to
git/git when I wanted to open against gitgitgadget/git, and I don't
notice and I open yet another PR in the wrong place.  However, having
it opened in the wrong place rarely makes any meaningful difference,
so it would probably be helpful to let new users know that it's okay
to open it in either place as you do here.

However, where you cloned from doesn't matter when you open the pull
request, so I'd strike the ", depending on which mirror you initially
cloned from." part of this change.

>  https://github.com/gitgitgadget/git and open a PR either with the "New p=
ull
>  request" button or the convenient "Compare & pull request" button that m=
ay
>  appear with the name of your newly pushed branch.
> +If you're using https://github.com/git/git as your remote, you will need=
 to
> +open the pull-request from your fork, selecting `git/git` as base.

...and I think we should strike these two sentences as well, or at
least reword them; your remote URL is immaterial.

(Not only have I opened up against both gitgitgadget/git and git/git
in the past, my clone URL wasn't necessarily either one of these.)

> +
> +The differences between using `gitgitgadget/git` and `git/git` as your b=
ase can
> +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadge=
t-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)

I like this call out.

>  Review the PR's title and description, as they're used by GitGitGadget
>  respectively as the subject and body of the cover letter for your change=
. Refer
>
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> --
> gitgitgadget

Thanks for sending the patch in.
