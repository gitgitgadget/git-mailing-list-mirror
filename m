Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC523D9043
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541886; cv=pass; b=AAHSUi//DlJHzX6HpfVUefsnY5gMQj7JKgCzlEVu40D+L2hZ0Mt7j7l2rCgfPNY4MCoSqYyptHiasAoUMV4kaeSllFizREXe5KM3qGgmYWWMJ8sc2qgxewqd43ThMqDOaU/94/2TDcm3iGfCDp+2GpqRupDpF4r9t8AxeBBRMTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541886; c=relaxed/simple;
	bh=K6SXWll/rsL+8QuGeWP0GkJ7I3pqXuosSPBvOpNqxWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE1pd+tbNvddT/uCqLAvahFJUg8wBCaC/dwgsteJsGy8sWwb0KputiGFMRKOgnu51lhNmnkQCPB6QzCygbvTKJsORBn3s+Mi0v05dkSxmj09AaP58wdyVscw4hk3XjBFWnZfKFhGKVQ8UzbbphB+6fkleG6P9B7yE0tcN31B0jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au9gEYDA; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au9gEYDA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so734425a91.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 09:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774541878; cv=none;
        d=google.com; s=arc-20240605;
        b=cM8QbJfwM6uCpNqzPTUaH2rb6I3svr43x57h0dEOpN5z6z/g+vn09u7Vi58Obt2Ze7
         VX1BNZe0jqe37HhEAu2TLnu58TpXZoaneMr1rv6oXNF+hP4zHW7/kGWUDKahiIARV9KV
         oKbjz9C2doe/N2DlFSuoKjd86vFUZqrxfZdGb3V1qtCQNJ1jjP85DNcZLonTyY5cjtxN
         5FlW8iq8IoJ+EhWC1QIfGyScgACvBNtH/f9+znD8VO+t9YOQtpD5mIT/xDchd1lL8ZDg
         kvVoljyIbkwR58GEb7B66KXNtWLm3XUTXnpRvpdk9sJmUO4GNZLvH4KYWsF32uHJpt/y
         L5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B+0Jwh6w/mOYLJXa4PZbHctpjLX+iPTH5OwcsbVxRjM=;
        fh=2CrkveMS4iUlvhG9nyaBzKPYMZe64OEl6bHNaUedAlk=;
        b=WX+Lz3OTuIAIsgIuO4j84kHBR5D2Jfei9QZdmCWRKzI8tirs6s/pUg7vpBnW1NiMtj
         lFTblMYhg83SbqCuBoCqVjuvNFjumyGXWsR4VWEyB7PpW2hDDw/jNlREqthpxfU8A6y6
         zuVZAfyOtxMMqvBW2OiKh8n+KeX7HfQQOc/18PpuIdOn3nlI975ISe6O7J6EwJEoBvx3
         FQFwVHP7GcRrS/hhf4kSVavknqCZuJM7jT/cjJSV7qCwMsqnIlMz0XhNO3+wiTp6tfJa
         tPU8+KZPpWbQ3H+M9fc7ylY6tjvsXR8MfRV2MvUkZIMVBSKQ04oJDjP1f46iuYHXUkcE
         oETw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774541878; x=1775146678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+0Jwh6w/mOYLJXa4PZbHctpjLX+iPTH5OwcsbVxRjM=;
        b=au9gEYDADMFzVwiH9fm7l/T9WG2uQ8gFitdNJMJvVgmRHOWzR8F3bJ/kk4pan5Ire8
         ND0E2U2+u0yuW0L9+VigdOyrokWj9z+SBewZAp1Poz1gvNfn3Noe1OkAYzRrLVfwDlOh
         4ZhIVKQgUDWHr8x+kKwrtm0NHlQeOC/6jH35VR5Nrra9nbqfxcvBbeq5It9ExPYGQltj
         TkMNgadfZmJe8S+AOvGpK0HoyJSzqaDv2wf1kXHQJW10hqCx8HeIZFbimYYmaIkXwEhu
         TYT/Pg6SGSX8io20tqCi2n/0LnoObM287q7qCeOvoM5qAv7HRvrtopeqVzzILxof9it0
         krnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541878; x=1775146678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+0Jwh6w/mOYLJXa4PZbHctpjLX+iPTH5OwcsbVxRjM=;
        b=XiF+v71oNX3pG/ZFf8U60HJqPEKEqRy9FghYjeCfe/YuK43rlkD54T7rdR3beuLmhI
         ld1VLeajUhaCo2beMMwE0q6SOttSAV3r2QdVSrKmLtLuyV4c38Xtumlo+AY7blLheY8V
         9q/7D+tzJDdomPBZjbkAT95MpqZ7khrnsW6j/JIn2BJZ8yC27xkFxXH9S2YsCen7VtMk
         bvYaLAz2LcOqUYEOBvfOxewOBFSvCUXJk05uoqcTMofbOBXa4/eyqHimMwOGdjP6O3sQ
         sIJukY0lh+LuFBntbYKT2tpR0ugMEOWY4shq3jFNBqeP0fkUdKFsJJ/04ZhiMx3NJKBP
         PQYg==
X-Gm-Message-State: AOJu0Yw08f8kyKkv8ao7StmgGgOX9Kt3J8mh+asuIBhE/FX58BDMryfu
	PVfqarjRBasesWj6xKWiW5dTntsuNuW7YPVRmAJ+TL2XUy7MSkWbSydDr+/28PWUrcoK8qsGuVL
	v5EQxm7e7vLZUD96olHhVj0/dkfbjC0dHXDSf
X-Gm-Gg: ATEYQzxQVMhv6Kvycqiz0iEQ1TLJqprHIlU12mexkJgwrnszUCUWWbwQHNzk4Ujm+Um
	F+n7Rn4Yq1693MfYS6e/709xiJBw0LZckQA9xR0/6HTdH/wbBk1cDPp6fgAg/Fcna7wxkFKcBCi
	hE9I2vsZVVzJ/PmtG0H43dndwbTbVD+eoCx6o1C/Nq+Ffsnq0Iqt//Me2KYqMuEi0Ln1UZfSJE0
	wtp1eeiSK1AIORek5rbK9kHOU+E823x+B04+MYv/zsE89IXBVK0Rz+5XSwZnX8SQW1iC8SIuSNB
	F8KnJnPBIM8bPnE+VSf9I4xCH0txth/p8fvSzqS6Am8yB8BBuzHu120skdRDX+rE8DFWfwPEEHD
	GGl7F
X-Received: by 2002:a17:90b:1b10:b0:35c:d98:d66f with SMTP id
 98e67ed59e1d1-35c0dd6b014mr7721328a91.21.1774541877984; Thu, 26 Mar 2026
 09:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
In-Reply-To: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 26 Mar 2026 12:17:46 -0400
X-Gm-Features: AQROBzD2Xh9gmKK0kZs3BYohBAS8qjFxHAcIVZJGEJAtG2U2_yPjPPrWkrc9tQE
Message-ID: <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
Subject: Re: [PATCH] docs: fix git stash grammar
To: Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Quentin Bernet <quentin.bernet@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:46=E2=80=AFAM Quentin Bernet via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Quentin Bernet <quentin.bernet@bluewin.ch>
>
> Grammar incorrectly did not include `git stash -m`
> and other valid `git stash push` flags

Typically commits for Git describe
- the current situation (present tense)
- commands to make the code better

In this case, something like

    The grammar for "git stash" is incorrectly bracketed; fix it.

?

>
> Signed-off-by: Quentin Bernet <quentin.bernet@bluewin.ch>
> ---
>     Fix git stash grammar
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-225=
5%2FSporarum%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2255/S=
porarum/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/2255
>
>  Documentation/git-stash.adoc | 4 ++--
>  builtin/stash.c              | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index 235d57ddd8..41086c21a4 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -14,10 +14,10 @@ git stash drop [-q | --quiet] [<stash>]
>  git stash pop [--index] [-q | --quiet] [<stash>]
>  git stash apply [--index] [-q | --quiet] [<stash>]
>  git stash branch <branchname> [<stash>]
> -git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] =
[-q | --quiet]
> +git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index]=
 [-q | --quiet]
>              [-u | --include-untracked] [-a | --all] [(-m | --message) <m=
essage>]
>              [--pathspec-from-file=3D<file> [--pathspec-file-nul]]
> -            [--] [<pathspec>...]]
> +            [--] [<pathspec>...]
>  git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [=
-q | --quiet]
>             [-u | --include-untracked] [-a | --all] [<message>]
>  git stash clear
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 95c5005b0b..0d27b2fb1f 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -50,10 +50,10 @@
>  #define BUILTIN_STASH_STORE_USAGE \
>         N_("git stash store [(-m | --message) <message>] [-q | --quiet] <=
commit>")
>  #define BUILTIN_STASH_PUSH_USAGE \
> -       N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]k=
eep-index] [-q | --quiet]\n" \
> +       N_("git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]=
keep-index] [-q | --quiet]\n" \
>            "          [-u | --include-untracked] [-a | --all] [(-m | --me=
ssage) <message>]\n" \
>            "          [--pathspec-from-file=3D<file> [--pathspec-file-nul=
]]\n" \
> -          "          [--] [<pathspec>...]]")
> +          "          [--] [<pathspec>...]")
>  #define BUILTIN_STASH_SAVE_USAGE \
>         N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]ke=
ep-index] [-q | --quiet]\n" \
>            "          [-u | --include-untracked] [-a | --all] [<message>]=
")
>
> base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
> --
> gitgitgadget

Now, _is_ the grammar bracketed wrong? "git help stash" says

           For quickly making a snapshot, you can omit "push". In this mode=
,
           non-option arguments are not allowed to prevent a misspelled
           subcommand from making an unwanted stash entry. The two exceptio=
ns
           to this are stash -p which acts as alias for stash push -p and
           pathspec elements, which are allowed after a double hyphen -- fo=
r
           disambiguation.

So _if_ you want to provide options (other than "-p"), the "push" is
required. I think the existing brackets indicate that.

--=20
D. Ben Knoble
