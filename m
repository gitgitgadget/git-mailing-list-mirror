Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC09202F89
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174990; cv=none; b=H3yB1K2TDhzoFV3ipzsRylj7hzM6oiz//9+0rB9VfAhxrlpz8OfVasDKJcY7yxXTkSi/xkVI6YuR46lMHR2L6pevmAdOGbr7wPsDylRsu81etTok55Zf1ntlYyrXRbw9ZzT+kUateOS6BuhLIOcRus6m6768WwXHff1u8ledbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174990; c=relaxed/simple;
	bh=AR7/fVqDSXWA+m+wkW44MYWGG2rD5Sb4Dx/OCIucT/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaXE8q2U2Hzz/qhoGOhM0j3+WwVURTX/u8o62qsf6QxQ3w/sPy2FVrf8GCw59ZBdKUKtAV3aDKacZO9ssXLFDV6Kw6MHFaP/alESTJ8HrcTfwUG2gMR/xn2Jqyq4AG2xdf0tJT2tCITZUciW4M7r+EFLn61Ml9WoljY7X0znZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWIf6foP; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWIf6foP"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so210027239f.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740174988; x=1740779788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xkb9gqktiGRck/REnzoa+zrMjeACsWxYBct9eGPY58=;
        b=PWIf6foPTSg84ZqrTgd4tMJEzZyvchK93vpfkghjBX3KFZNzZYwt31P3oziD29Jr1o
         u4bZ/Qf/sxn5XpdSYhJs7vLuXLHEQf6jpR9wLGbzr0B6cxbAi7hGMgpP9vSZEACZZwxz
         YRcVT9wfLL9oA+fq8jf062HfGlymxUwHnNrf5Tpp0lfiA3yI4aEqRRETf7SOwLxRMGwC
         Y0n5mEoC7VGa7iGo0Pki6DJ0Zp6Y40sOXU9bkWMyliTWw3cFhCgZNo9IgKqsLrrYvUIV
         9JK9dqWInm2px+qpyE7a3hxa9eQJxcF1fYwBIfgBbelSTK6AgY+UiSDkMaOusfQNCQgH
         R5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740174988; x=1740779788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xkb9gqktiGRck/REnzoa+zrMjeACsWxYBct9eGPY58=;
        b=U2FnfJuRfGFOEpk0J6+H5Tu+DKJPr8cvJGJeouETVLXmcZDyX2z4utArj2gjW9i8OI
         404pdGWaoZPqT2PhSiJy9KtgUynJRyWKo+T8Q8dH8dSdPwPH1uFM9WdZ+3T5Vf4dJ77S
         2CxIRhDh2DLVm4hEqrLuFIpXnNxM4Q0H3+tM+Cv/A5a2kX6NQbNpsHYu1zMbXPKV/3s3
         213jb+bd1W/NN+PvRgrYW5QhTH+312K8O2uN6SCiawd0g/84mKX93nVHgXux2wMz1hIR
         6gvJfeYpg8UvdtAHO6t/UeGTo4ii4FOu9vNndKS8+93o0+dhNqDRsCjGMs+aJ4RWOITG
         ayUQ==
X-Gm-Message-State: AOJu0Yx1ok9SRTOa1NTctrjSfYnNMxjJ30aR8mm9LHT8mwpDkDqnVcye
	itXe6rmCVczbIGsFLTQlyDO+5mObiu113KB+mjh9papXia6AkZeHAIz92cjUwhzOyK5BZPTtgdv
	XYvFkQUzoQWJaOlTSHOdemteH1MUijg==
X-Gm-Gg: ASbGnctYCn0eu8GdNbDpjOc3z7KrMlECrRI5ZK0zwhE5/uY1PI08NbwYgR7kJUISeeF
	RqvY0jJCxNbv1eowshx8xPigEl17iy1U0N9racQFJXH7hFKAyvTxHrOY8SnWVKyLbb47fWR/der
	9WWOHJwEgvzJotfdYM/WrBWi4qnS3QApjDGpK6HdUz
X-Google-Smtp-Source: AGHT+IHTSwsreNhanEoES9unOEj1kUckIkO15QL4W33HxAgkp6bFg7nRKf5P2JBqtOPU7Y9ylUvQahaJadkD9fI3aDE=
X-Received: by 2002:a05:6e02:1a4d:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d2caeeaed0mr59554385ab.18.1740174988055; Fri, 21 Feb 2025
 13:56:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 21 Feb 2025 13:56:17 -0800
X-Gm-Features: AWEUYZngfkFgDgAxz6u8jVTWBderlzqoHmF0Sd5-JJhpn3tC0t_JaHaVqMCaCQ4
Message-ID: <CABPp-BEDhJJW6+9SgRQKWmKGBANV8cmem1FXtrFKmYgmY7Ud8Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 20, 2025 at 7:12=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases (introduced in 68d03e4a6e44) on handling the conflict before
> yielding it to the user. From the merge-ort and merge-recursive sources:
>
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
>
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
>
> Add a small paragraph on merge-strategies.adoc describing this behavior.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> This v2 changes the documentation text to a clearer explanation (as
> suggested in the v1 review), and changes its location to
> merge-strategies.adoc instead of git-merge.adoc.
>
> This content is duplicated as this works for both `ort` and `recursive`
> strategies.
>
>  Documentation/merge-strategies.adoc | 15 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-st=
rategies.adoc
> index 5fc54ec060..a7fca249e2 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -21,6 +21,13 @@ ort::
>         ("Ostensibly Recursive's Twin") and came from the fact that it
>         was written as a replacement for the previous default
>         algorithm, `recursive`.
> +
> +        In the case where the path is a submodule, if the submodule comm=
it
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this c=
ase
> +        as a conflict, suggesting as a resolution a submodule commit tha=
t
> +        is descendant of the conflicting ones, if one exists.
>  +
>  The 'ort' strategy can take the following options:
>
> @@ -95,6 +102,13 @@ recursive::
>         renames.  It does not make use of detected copies.  This was
>         the default strategy for resolving two heads from Git v0.99.9k
>         until v2.33.0.
> +
> +        In the case where the path is a submodule, if the submodule comm=
it
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this c=
ase
> +        as a conflict, suggesting as a resolution a submodule commit tha=
t
> +        is descendant of the conflicting ones, if one exists.
>  +
>  The 'recursive' strategy takes the same options as 'ort'.  However,
>  there are three additional options that 'ort' ignores (not documented
> --
> 2.39.5 (Apple Git-154)

So, seeing it here, I note that these are meant a bit more as
high-level overviews of the algorithms.  I pushed you away from
including this in git-merge.adoc because while that manual page does
dive into merge resolution details, that manual page is specific to
merge.  The information here pertains to merge as well as cherry-pick,
rebase, revert, replay, merge-tree, etc.

We don't seem to have a place that is general for all
merge-machinery-using commands, and which also dives into details
about how merges are resolved.

I don't have a good solution.  I think it's probably fine to include
here in merge-strategies.adoc, even if it feels suboptimal and icky,
since any other current solution would be as well.  But I would be
interested in the opinions of other reviewers on this point and
whether they see a good solution (short of completely overhauling all
merge-related documentation for any merge-using-command, which might
be a viable strategy but shouldn't hold up a small patch like this).
