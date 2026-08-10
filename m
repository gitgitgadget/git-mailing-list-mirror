Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DA39CCE5
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366133; cv=pass; b=QhgkNmFTouq9ehNOdVBttxunXJJVRW3p7o86KykXG58zc1RDyaOEOcsrEdqkl1EmRp0R5mysSkft/eCTnFzzqQtRN5/KijaI1WO5R+9nV8bgl3aWak7YXVUpr9PjSp0pf9F5fqAjep6pwK7u+AcjD9Iil4AtqWexBZ4I8bxAYBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366133; c=relaxed/simple;
	bh=PYZongLqWvO5ZkLBYViGo/pvargWkpuX0XjF2XZSAcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gP73MvJNxFXQg5gKlSigAHhbGlNo2sVfLWMUJYtkIZgFZOD9053qQnAIJW7xKS99cKInuQlnQLpzpHyKJgi0H9W5NKncX6GnnVHp5ywtr4U4bKRriqWv65uv7bKLOgRLri37FMhSHgyenNv5JiFvPyfnRBojmo5lTTtXgRjA04Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO2eAxFO; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO2eAxFO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cad8076b01so19962725ad.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366131; cv=none;
        d=google.com; s=arc-20260327;
        b=QQOHyfTd7TXzTFLd3eKqHQU7WhXHhRvz9H5jZ3Sxd9DYYIlmlNX0HMiqec3tnuTgZo
         quNziV4fBLl/RmI6QHl7SfClsJVoEFng1xHB1M02G1X5NJ/kMURVYOA2TZKCcPoWKp8U
         Cnw3zyaEoHMeiToIaAY5C+2famyLnoQSc3WBOQgPHmeeGuu66ZsJR7HL1hInuMP4ZMaX
         66Hh8EfX9DvRlDtvY4kKZX/1YlkxFWtykytcCX3FWLajiq3JCWXN4ZmVxB5Xr8MZDONc
         6F5buykCkVsEnrXdnb0E6l6NQPF9HBR4kgVzG4i7E3uZZHGq7JVmfuQK79VGnNifkAIo
         09pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dr9g63ZmiBUQizmo+FGieL4TrCU/UDrBHJhbaDSLQc=;
        fh=H6lokUr+VJOb8K/s4/XQEDUqD1mgPN6Wv/mJsHIkuwU=;
        b=EigDa68vK6XUAvytt7uM+tLYBsHj1h5Gz4o8cyNQDvMkpbGDY/DIIgXnzVk/WaIH4q
         cqegKcdJ9mdUrXC4aUSDhA2OUCxaU2JzxFJgfoUP04a9Dd2YXopbhUEjdi09Do81FBje
         u4WvaJRbF1oMKnmsFoev4W88KKnOO2kDJQ+o2ZG25cT9enHtZC2GSj9aDIlS/a6MT3K1
         7E6NkfGezBYlbBjC2oAC73Pjl8Qehv4/X1ZMpjcN89EcVSKTdY//7fm7ziwipfx6Trgr
         LroH0pCjLRhRqUD7PPP9oaOq8mXMzS34fm/l8CfaHaIYBLrcyv3eMvp67raf8s1whFN3
         uAVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366131; x=1786970931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dr9g63ZmiBUQizmo+FGieL4TrCU/UDrBHJhbaDSLQc=;
        b=jO2eAxFOKs+4Wlm8UGGcl9edpiaFsbfkGo9J2vRdZSz62CFBQW1KQRPYKjsML0d7aS
         K/IQ7i9yokhrwcXAWjsEwIcCTfLhLwQXGXbbjIlED9Yrv6Ph8dysDgM00cXyqJgUvRVK
         O00q+MEGagT2O4tpypaKwTrOt1TXYyGRb6ESNFa3nBe/pPAuNfMxqT4F8GOM4Q3CMWu3
         OGCmYfXF6RhUosyQqBjU9KA361RjvbeRHXYxoopNkfXIzV+EomP44YWC91/ZCTgPOFAF
         k3Dq5tpE/JD4oHFSn1VkO9ipFj0z077RhD2drvVrxSiAM4hcnFkSc2PWxH8H1BpOH1CN
         hMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366131; x=1786970931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dr9g63ZmiBUQizmo+FGieL4TrCU/UDrBHJhbaDSLQc=;
        b=EpVsVG5t2/c24GDpLGoirFCAwfejbMnUy5+PmnlHi3+8r7NVyjsPChwhBU8hSZg7B0
         UU6xnZhW/dSLzjdkB9RO/hKgWZxL90yReJsn1RpmdW9lI5T4NnxhXSHU7888pgpFP+xU
         9Szj8VF4FD046yJZ/WuVnlk2PAtJNmt6f/jbTk6WQPiuCHe1LETGPcy03HBuzwkX/KEs
         SWhKzrsjvRAk+vha7fiqszhe9A9DpKLdX3aoG+5TrMQpssUeDHVZpDNgE5Xk/O5O/sg4
         SFRav4o7C+zUEUYW4kql+mm/ox9JRthImKhN3rs798oltY+Q2mUAJhEfd7fn/bzVWpDY
         Y80Q==
X-Gm-Message-State: AOJu0YyPpmXkS74y4y95SpnLHaYVp7tqlnuTbATGdV9db+wEcHoeyWa3
	44yYjn05dshxY+dVRg4AwBg5qX/tiOXmhTqFyBA3zI5UiyOiTdyKXSyq6fXGn3GEZmiBQrtBgsL
	VCE+dGCYsfJ36NWWsx9kykUbuWcwrJbYQ8xV/kp8=
X-Gm-Gg: AR+sD101+uKh+U0kMv4Fe290n19lZhxbcuRKtlnf/FjUdBDdgrAvtBKWCwr9YVXaHWW
	5NBHQWXJ34j5RPtfQHRUN/tVWM3NBl+DJqyqKG9bcnKPyJV3MTFhaBNUTA+qKvzc5Gs3DRIj2Z2
	MCddXVH9La6UGH8niyqHkHojW9B0Q8dx/sHRjOCI6SJYioe2D856LMso0ztwGRq1zXaoZJ/dLyi
	WBpLT5eEcZ1Uwk6HbDwQuGgxhSykSenKdsMrmEteRpOFLhXSq/DBS5WUVZXWaGLPMlBtJJ/GgRg
	xqk/VMd07qiOvaZiCrrEXCDNdcw0Hp4JDwSReiOOLtWTQAzzB29WYHXwbexExG3ZsAeli0IZdDY
	WEdUYnHEozm+fUg6fRHuSs5naxwsKnNhE4sQLOR7heItrWlU+6v6PKU+VhlXy5NB8HWMfQ5vL4o
	Mx/B5hZZIHKCoXhkrZaoc=
X-Received: by 2002:a17:902:d54b:b0:2ca:caa5:9c04 with SMTP id
 d9443c01a7336-2d0caa0eaeemr538834035ad.23.1786366131326; Mon, 10 Aug 2026
 05:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org> <20260806-history_autocompletion-v2-2-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-2-7e60f52a1c20@kernel.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:48:39 -0400
X-Gm-Features: AUfX_mwssbvlEOUIhRVy1yq7mDVMQrvUwPMU9lMr8GS6xbVXZUfUlUVuTxRIHV8
Message-ID: <CALnO6CCCG0xcZtAKQdNsKxNJ2Nyq5HztLaz_7QXjfQsN-q-xgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] completion: complete 'git history --empty' values
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Comments on 1/4 apply here, too. I don't mind supporting both, but I
wonder if we should be consistent with gitcli(1) and just go with the
stuck form.

I can only find one hit for the pattern "--[[:alnum:]-]+[^=3D],?\*" (use
"git grep -E") in the completion code, and it's "--no-*)", so I'm not
sure if other commands support completing the unstuck form? For
example, "git commit --cleanup <tab>" doesn't complete the mode
argument, but "git commit --cleanup=3D<tab>" does.

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
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5ccb38c751..52a036a1ad 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -3126,7 +3126,10 @@ test_expect_success 'git history subcommand option=
s' '
>         test_completion "git history fixup --ree" "--reedit-message " &&
>         test_completion "git history split --upd" "--update-refs=3D" &&
>         test_completion "git history split main --dry" "--dry-run " &&
> -       test_completion "git history reword main -- --d" ""
> +       test_completion "git history reword main -- --d" "" &&
> +       test_completion "git history fixup --empty=3Dke" "keep " &&
> +       test_completion "git history drop --empty ab" "abort " &&
> +       test_completion "git history reword --empty=3Dke" ""
>  '
>
>  test_expect_success 'git history revisions' '
>
> --
> 2.54.0
>
>


--=20
D. Ben Knoble
