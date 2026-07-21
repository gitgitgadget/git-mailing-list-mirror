Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9618314A9E
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638208; cv=pass; b=sPyy2kzxMH3ZeM0w4gTXBFWAVKxvesm9vFYQU8COnc8KuRujt2xo3P75nkywYSdgCfGxzPeKamhxwiM1zrXZ+E4QSPOQKrD60FuMr1ir1c8ChxazblcoyOJ6MYQ6Fep/5tKGuCX7gj3457dAAg9tXyrTK4AAC4X1BjArD44lMak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638208; c=relaxed/simple;
	bh=NUyPdHznv45fpropPH4oCKscMkzTO6TYArDdEYTFCKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYoQzGHdwF6IWloRBR7NgSivhWM8ik+q1fY6J/rOSka4Lhg8xulz3UB6KNvr+6pLx+RQD3mRVccXli8Q3aQx2H1YMBuMjJDSCWR0kp4+I96XMXkhl7Wqjxw8FEkjpbLpw9HuTocFolx6jsna1dP6E30frJW0E7Yy6Uca6Lvu68Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9+BXho5; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9+BXho5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce7d2adef4so112747845ad.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 05:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638206; cv=none;
        d=google.com; s=arc-20260327;
        b=bvXDHa9jvfxvjUy6/TDUsGPJM/V6ofS/NU+aPMq2cKDR5fn6BXrtkHgkk2ciurKkj4
         +9qU4RGZQJNi8kjZtpobeqVaDB62xIxnoH+J7JxlQdPQKcQAu6YkASQjE+N6dWbIVbaI
         FjdVUILurFw8DqnZHabW17jYLAIIbweK+oHvv48Bg6p6ohz1K5zkmbs8XTWC4bZMw7OZ
         R9tazNI59+faRl6Bcd+tZfeRQwU0EoeTKRHYUUEHYvByd9CJWJKCZq5510fTPHBFUwAy
         SasGVQjhvB+bgb5dsD9vvvn/VU5LxNgjlx9IOvdto3jih3OmoVtOS+SyRTep6GxmiEhg
         uLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YjA8dyW3V9TQXRNaPK3p5aPoMaPVP9WiqzB9CVA6kGY=;
        fh=1Q8qq0O4FDogQO4wLDdv2mAqkbETjEBWgr4Isfl+4wE=;
        b=WqDg8tNXzG1FNvKWRpvWo9Q6ihKvgy0I21Bk0fJaWipSVO/VGoQG5uauMLF8xB4mkW
         66Gqa5V84xNBrmq3hjYKeyTJ9TM94wj026BIxZwIh+avcna59ThR63YvJou0srx/0x7f
         o77ADftT+Wyn7pjxb/SGytJjdGkkUAhJukxBmRQdLPmMdq7f3XqN2yujyBh8RPaoB1FU
         M8PnWwPTKok9shLl8YcVFRxSV6h3oqdUAkKoudJd7hYi9z3mxWwFW+9bHDTLV5IU1MKZ
         riXOnIKYIdzmqFgaV11I47z3G1NF/Guutk3SfbvPcmPRm/bZ1JafYqF5bNfuyyYV/mfM
         eQ0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638206; x=1785243006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YjA8dyW3V9TQXRNaPK3p5aPoMaPVP9WiqzB9CVA6kGY=;
        b=M9+BXho5pp0xR3gvACgGPip0L0suUE+9jPwZDGSh925Ay5D8J797w86BofVofszv2t
         ULZ4Iyet11onrvpr/pfsjW3ommsvn/PfgMpVxZLAldxZFat+vthI/x/7fuInW7kVPnXv
         aHPWbSlSuiQKj9K7ivpX2lcIbAhlwa5F3dKyuwDiVMtAUDRmewEaSLM4ILOOi6F4hNGI
         xSuaAqK/NkqzQLZxQI+m3KDJs2LMfiZwmZxW5heAMrT38j6beraz2M+aBDQ8iEADV6u/
         dZqImDUu/mS7dehUg43wDYluFAMdDwHfAq+xfFKz+6I3EfDUf5CToEIDdlp1Uloj9dkP
         0pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638206; x=1785243006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjA8dyW3V9TQXRNaPK3p5aPoMaPVP9WiqzB9CVA6kGY=;
        b=gKPRfGGyMBuDuLpImGCGQ007OI1njFV7Fr0vmGeBTQN/qfcOUMUOy+AAtBfRD+VV4L
         AAjOWGOENib/vnDAH21O8i+cbbKNrh/YRGcrsWXIsYz3e+K8pwr3JL9lLuibXCnzDXyC
         E/sDWE+jV4loIChRGpk18pEl/EeLhLVSfyl+w67r6cOSba4ewcAQ0MClyt3oiWYF3fqh
         DkoT+AEg1cX4qtTgWjx8njsCZa8gy3rm93Bmn0wdQ+mNjlTWcKwMqGfU54MmJKyBzzhq
         BofR83FjgsODMWA5lIy/XsOa0fOWd+G5YAeh3OmhKNc97KFUrrLFGh43FPO/QS0vwBJh
         uJBw==
X-Gm-Message-State: AOJu0YyJ8t1aaffNT+Nfkktp0XfXfP3L4DyfepTrWVgsPBjAi2JUdcYU
	lnpPYaOlg5Nz1kn4QDLUwBDqHPTwz1KP1Q5N8RVij4uX46Yc8nMgnB3H03+E/GlF/4rOdV+S3dq
	zeWiHlV8N0pMf8M3G8r77gAex/eO9Y7I=
X-Gm-Gg: AR+sD12x7lIbAJFygPpn3oBifW+tO068/NmQtqtdgrNFTNy8mq8p9/tosQHUpB+h+3i
	XzrFFRrA++8DLJacA0asNpjkTFmUpKR0B9I3Ni6MsbXX6hFjnl2Pk6AnHMy16ShuC9zMHzNq8AC
	5myqCPkyMM/55L2B2uYjyD4suowEQPd9YDTnBOl5jxXyvOKmKJWqDP14mHh4AEdFaP6UpBrE08c
	nUpvWySnOCRBfJ7rXLubYoYsUbCY+p71TdpFyfrDaWzNH4aSGKVW+x4ppF+IFuIA+mvgDi1leWT
	/qOjfkpwo3E7uQ3k8SSbDAg4NFm0bAyBuchrkWHPzJr61mxbTbzAY6VBBPduXkI7wtH11UJ7MiU
	BlJMxoJZgVMMqy3AQzNBsMxOa3vFIumgG1J8cKVdNYtNonYQ=
X-Received: by 2002:a17:903:3807:b0:2ce:9439:59a5 with SMTP id
 d9443c01a7336-2cf349a15c6mr189346805ad.36.1784638205902; Tue, 21 Jul 2026
 05:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719134447.381835-1-yury.norov@gmail.com>
In-Reply-To: <20260719134447.381835-1-yury.norov@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Jul 2026 08:49:54 -0400
X-Gm-Features: AUfX_mwGr9invbljWdpSBBWZlMbOK6etwwvkVgdXSr3CrVI3D6A3Gj7umzD8yNY
Message-ID: <CALnO6CAuitGp_xLYkXpkQYV9oiXsNNfsXZ_OqzkW7_6ND49=LA@mail.gmail.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: git@vger.kernel.org, Thiago Perrotta <tbperrotta@gmail.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Yury Norov <ynorov@nvidia.com>, linux-kernel@vger.kernel.org, Codex <codex@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 9:45=E2=80=AFAM Yury Norov (NVIDIA)
<yury.norov@gmail.com> wrote:
>
> From: Yury Norov <ynorov@nvidia.com>
>
> git send-email accepts either revisions or paths to patch files, but its
> Bash completion only offers revisions. This prevents patch files from
> being completed. It can also make a prefix such as "0" expand to an
> unrelated hexadecimal ref even when matching 0001-*.patch files exist.
>
> In my Linux tree, an attempt to autocomplete the standard-named patch
> brings a random hashtag:

It is unusual to call this a "hashtag." Perhaps "hash" or "object
name" (or id) based on the glossary and datamodel docs?

>  $ ls 0*
>  0001-bitmap-drop-bitmap_next_set_region.patch
>  $ git send-email 0<Tab>
>  $ git send-email 05c69d298c96703741cac9a5cbbf6c53bd55a6e2
>
> Introduce an append variant of __gitcomp_file() and use it to add
> filesystem candidates after the existing revision candidates.  Keep the
> latter because revisions remain valid send-email arguments.
>
> Add a regression test covering patch files alongside a 40-hex ref.
>
> Assisted-by: Codex <codex@openai.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  contrib/completion/git-completion.bash | 29 +++++++++++++++++++-------
>  t/t9902-completion.sh                  | 12 ++++++++++-
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index e87578771..b7017488d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -579,21 +579,18 @@ __gitcomp_file_direct ()
>  }
>
>  # Generates completion reply with compgen from newline-separated possibl=
e
> -# completion filenames.
> +# completion filenames by appending them to the existing list of complet=
ion
> +# candidates, COMPREPLY.
>  # It accepts 1 to 3 arguments:
>  # 1: List of possible completion filenames, separated by a single newlin=
e.
>  # 2: A directory prefix to be added to each possible completion filename
>  #    (optional).
>  # 3: Generate possible completion matches for this word (optional).
> -__gitcomp_file ()
> +__gitcomp_file_append ()
>  {
>         local IFS=3D$'\n'
>
> -       # XXX does not work when the directory prefix contains a tilde,
> -       # since tilde expansion is not applied.
> -       # This means that COMPREPLY will be empty and Bash default
> -       # completion will be used.
> -       __gitcompadd "$1" "${2-}" "${3-$cur}" ""
> +       __gitcompappend "$1" "${2-}" "${3-$cur}" ""
>
>         # use a hack to enable file mode in bash < 4
>         compopt -o filenames +o nospace 2>/dev/null ||
> @@ -601,6 +598,23 @@ __gitcomp_file ()
>         true
>  }
>
> +# Generates completion reply with compgen from newline-separated possibl=
e
> +# completion filenames.
> +# It accepts 1 to 3 arguments:
> +# 1: List of possible completion filenames, separated by a single newlin=
e.
> +# 2: A directory prefix to be added to each possible completion filename
> +#    (optional).
> +# 3: Generate possible completion matches for this word (optional).
> +__gitcomp_file ()
> +{
> +       # XXX does not work when the directory prefix contains a tilde,
> +       # since tilde expansion is not applied.
> +       # This means that COMPREPLY will be empty and Bash default
> +       # completion will be used.
> +       COMPREPLY=3D()
> +       __gitcomp_file_append "$@"
> +}
> +

Curious; the diff itself is much more readable for me when applied
locally (it shows the addition of __gitcomp_file_append and the
replacement of a few lines in __gitcomp_file).

Nonetheless, this follows the pattern established by __gitcompadd and
__gitcompappend, so that part at least looks like it functions as
expected. (I can't comment too much on the code that existed there
already.)

>  # Find the current subcommand for commands that follow the syntax:
>  #
>  #    git <command> <subcommand>
> @@ -2634,6 +2648,7 @@ _git_send_email ()
>                 ;;
>         esac
>         __git_complete_revlist
> +       __gitcomp_file_append "$(compgen -f -- "$cur")"

At least with Bash with compgen, this looks to me like it does append
file names to the COMPREPLY.

But, with the "hack" comment in the modified function, do we also need
to account for older bash? It looks like that comes from 3ffa4df4b2
(completion: add hack to enable file mode in bash < 4, 2013-04-27).
After studying a bit more, that hack is to make Bash do the right
thing during file completion, not to workaround different methods of
generating filenames (unlike Zsh, which has a newer and an older
completion system, Bash's seems relatively stable?).

So, I think this looks good.

>  }
>
>  _git_stage ()
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 55dc9eabf..e87827f21 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2777,7 +2777,17 @@ test_expect_success PERL 'send-email' '
>         test_completion "git send-email --val" <<-\EOF &&
>         --validate Z
>         EOF
> -       test_completion "git send-email ma" "main "
> +       test_completion "git send-email ma" "main " &&
> +
> +       git tag 05c69d298c96703741cac9a5cbbf6c53bd55a6e2 &&
> +       test_when_finished "git tag -d 05c69d298c96703741cac9a5cbbf6c53bd=
55a6e2 &&
> +               rm -f 0001-example.patch 0002-example.patch" &&
> +       touch 0001-example.patch 0002-example.patch &&
> +       test_completion "git send-email 0" <<-\EOF
> +       0001-example.patch
> +       0002-example.patch
> +       05c69d298c96703741cac9a5cbbf6c53bd55a6e2 Z
> +       EOF
>  '
>
>  test_expect_success 'complete files' '
> --
> 2.53.0

Junio commented on the test, so I'll stop here.

Pending a commit message tweak for "hashtag," I'm satisfied enough for

Reviewed-by: D. Ben Knoble <ben.knoble@gmail.com>

(Or feel free to use "Acked-by" if this is not a strong enough review
for you/the project!)

--=20
D. Ben Knoble
