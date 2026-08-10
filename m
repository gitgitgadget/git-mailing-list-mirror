Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093E3B8944
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366271; cv=pass; b=VkWheaGwhO7CGvzvcTc0QPaj+y10DZdCRQ5DS1CmrHVx57jz57Z6ifXDYluLgXp5CTRkIvcwzi+3PECAhCNefTIiceTu/hcL2ce0DXewar8C7jlr0+2BdtohXg+t2tFRxrIdyeF1ERtv9+s14nCxL69swDvEwvQWpYtlSjpIsck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366271; c=relaxed/simple;
	bh=h8fGAxRX42tbo9ixBO0Lga6/NfMfMM+Rf440ZWXnI2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH6VncsCsRKRMZMhnnDcoCn6ZoVFWyet85mIEzE/4yEPPtmfqNuKPne+O2XlVu2XGfZa1LYYYEJq9PgSluotbBHJil6/NvUXerptUhpjeF5Dx8mL15MDo3QQ9zJaq+pVilwaW61k510wn423bsxBInAUxMU47fEoV1CWnJQJMJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhBlqKBC; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhBlqKBC"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso3043304a12.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366269; cv=none;
        d=google.com; s=arc-20260327;
        b=QMXFkx1vMKgunfPM+l8ofHyGf+NgVNa9OeUEvfkUVXqZLmCS4aYmOGQfNWGtUSX73H
         RHPlD67Pta+UDxOxLeFdmM6Tx3DmIcp+q3JUKYvxXwO1V+YKTVK8x7gCO+ZPGhJ5PGFE
         5QqrtxZOhvWFIPVUyA5wSPRP1BmQ4H8VVTodWHyWUBpJJgz+LFhaFNGOTtK6qMygTo1E
         WxLMx9C79XvQeGA9uUvNci37m9/9JJy5g8dNPQi4euWlN+K72FX7VIkv62BYgl8cxOby
         +T1af+yWdGeRbWAzXYF22LzxhJ4DRcoJqpLlEM1qowx94POXv1DLmyrXHpMbFrhhTgsF
         SYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qwga4SZuRPeHhTKVaJowFmIyPNcBlGHzSLHRgfJneEQ=;
        fh=H6lokUr+VJOb8K/s4/XQEDUqD1mgPN6Wv/mJsHIkuwU=;
        b=SR9lA2Mf5vbegKCMRi74tctO8v3rI4G04P1+/t/ZEApwo2bzJf8TOy8A9FoBOg3ebY
         o8qEQAvx22ta8c/NKPKw11T0pkAzgk0nRyG+D3Lzyb45b6Zjo5P8OQqCBsF/GBAA+vRf
         vwmXtBCCY0IUN9jACgjEXYWsoEACZk9N1v1wLpe2tIjUi0GMKc9iGSTjrUP7vhtRtyBC
         ENVHKKqiK51DgE6fO2uloJdC6x9zxZH/pjurwio4g3rP3Fn0rNMBJNoyMJ2Nx83nUvuk
         bDJrdTcfBvQQhZm1viaOR4qPv3wymoHX7BvMVo3iHMKONIEBbM6Tuyzy22gFocRidpoB
         PO+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366269; x=1786971069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwga4SZuRPeHhTKVaJowFmIyPNcBlGHzSLHRgfJneEQ=;
        b=IhBlqKBC2bVOx4/r1JCpq8UMgPpADXzOH/P+vHRttNQUg3gt1P2TC415OeTLmpjhya
         aKwLg8g+LS8UFPaBKmAkCuZz51pJ8Gy14O/myOcQIE9xVbKyoD/6NFFWV7WYGww3fx71
         zloUwB4LMeyJ+0anDfzspzCvRxPLu/1vYpxRSj+ylcK6UlhSF5d9EDA/dcusnNt05HLW
         w5CCelZMOICa6CH21ZYztc/Hr+cSyATNHuJ9D+1yYlA+jWX5Yqm8VtJ/7Er5LBwqz0cR
         GW/io0Dp+qP16+vu8RyeQubrSYdmo5k9CG1ueXeFjSbeTBw1nG0KdP5OStJNAlE57l5d
         uvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366269; x=1786971069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwga4SZuRPeHhTKVaJowFmIyPNcBlGHzSLHRgfJneEQ=;
        b=qs0Cae7axC7LzxKmfLa0ZuwHqqEhMVZbILZfkru0D5GBe56ITwVgChXFFORDiTBxL3
         La+fuysOcUAI2Vq+PExDuPz6Fo6leqh1F/NQW1Fr3NznQgILREhQSWG+wctCCoChl0Sv
         l9yo/mkoBFqJCznUYNRnzcPmEweDIrwirW2Xa2oQk6pBmq/RshQaoKvW6k9RoLtZLFQe
         cbPzLHBiFCy3CZVkTsxgGhGq27eV+Mko2kndEXoakoHvx0zfgofUIQV4M/b2QgXqyD6j
         0si8s/P/mCX311X5zUGixHIwbfQZ8ViYn4zHG+Za12rY8QjawGc1TXyV2DfQaoB1pZwX
         0DBw==
X-Gm-Message-State: AOJu0YyOyVt8of5M6P46+e7+67OgPJtzolndW+T3KdvpV2evdaLwXhpq
	Y7LDEwCJUJ07VkLPg5Pg0sJTr8/GCYcNVZ5A51vkkLx59knn+FID63EJo7MOz0wWwFpOP3wieF1
	u07n6NQFvB+HVyVWZDLeua2SSn9cdhcpWGNCtaJ8=
X-Gm-Gg: AR+sD10Z4ZTWhqlekSmTUa9azD5qo2Zz7m4CSUjL9V7Gh5wQMXXswkE1+MLHWmQfq7X
	dhu+Z+cXjYo+ePusUTwW4LQKOVphYzhGG7gYZgrF02g7S4NhxykH/bK1mpdwfN/j0OVuYq2L/te
	M4NRL1zjyQBTEC3GfNJZZDhGpQs0Nf+k9PwPU9B5DWbNqc9mN1UNjqWIwXCHMw9nJX0B7K7MOer
	iAsi0pNKbkgQRE0a3oh0UV7jg3kvJu2PzNj3qgkaNZqKAkt3PZewJLmL2YkKcopG4j0dfa0BwQ8
	+WIVB6yLH4p/jaHxRbZbqiay44oqdi0QX2RHsG2+rTv1V8JEL5hWkMY2yeaZ85lmRHMMm2Sd8S3
	GLhcSz6mttbJTRFa2RkT6WMdRulQaZiGf4FHSSX/HU+uMolQ9VMmqtDEl/iaXzg8XOTzyjYJ03U
	D2Jx8v3BohCPp1vjW0oN4=
X-Received: by 2002:a05:6a20:da17:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3cbd388aa24mr21174610637.5.1786366269167; Mon, 10 Aug 2026
 05:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org> <20260806-history_autocompletion-v2-2-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-2-7e60f52a1c20@kernel.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:50:58 -0400
X-Gm-Features: AUfX_mxV3mQJCDhWsrJ2VakTcbapvdtfNXv3osszD-sWbr2VgD5DcyuytPm03QU
Message-ID: <CALnO6CAssyDe7uOK+G8eZPzu1S6iyn8EiSQGqUHtWgdPcD65xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] completion: complete 'git history --empty' values
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One other thing, sorry

On Thu, Aug 6, 2026 at 4:36=E2=80=AFPM Vincent Mailhol <mailhol@kernel.org>=
 wrote:
>
> The "--empty" option accepts "drop", "keep", or "abort" for the "drop"
> and "fixup" subcommands. Complete these values.
>
> Although the synopsis only documents the:
>
>   --empty=3D<value>
>
> form, parse-options also accepts the value as a separate argument:
>
>   --empty <value>
>
> Support both forms to follow the parser.
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changes in v2:
>
>   - New patch.
> ---
>  contrib/completion/git-completion.bash | 13 +++++++++++--
>  t/t9902-completion.sh                  |  5 ++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 7372e2919b..fe5223b8ec 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2171,8 +2171,17 @@ _git_history ()
>         fi
>
>         if ! __git_has_doubledash; then
> -               case "$cur" in
> -               --*)
> +               case "$prev,$cur" in
> +               --empty,*|*,--empty=3D*)
> +                       case "$subcommand" in
> +                       drop|fixup)

This feels a bit "inside out" to me, especially when reading the other
completions. I think the usual pattern is to check the subcommand
first and dispatch if necessary. Thoughts?

> +                               __gitcomp "drop keep abort" "" \
> +                                       "${cur##--empty=3D}"
> +                               return
> +                               ;;
> +                       esac
> +                       ;;
> +               *,--*)
>                         __gitcomp_builtin "history_$subcommand"
>                         return
>                         ;;
[snip]



--=20
D. Ben Knoble
