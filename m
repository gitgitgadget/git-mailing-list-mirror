Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793974222;
	b=TDgbslWKuCSzD6qHnBxXBNDMA9IoA7UxPoaJzXrRt1IdYnWRrkoF3kU5mo8W6eIbTUKS
	 MAUck5EXqFHo8FjwbkrEb1iFdT2cPCig3QmX4gqYXNIrFnwsHsqVs1a0R0NY0t0Dz9Oc0
	 4rsald82UXIguA/F/YfNkBTNkLmnnVvzfBTF+BhBAuFXquji3RdytrLEscLQSrs1EFDx9
	 6A0Yok3KOOW/3geoHh7IU4/K2gGcUSHPBETIkJLJYmkmrEy2jkDNL1NxCBaxFht+YCKV+
	 YQUWoW8se3bix3D3I6pn9OG0M06lQuEPv610diNwlC03esPqR+C294vzzRY05dYxR2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rwvQpZE//s68T2deLP2tUfxPt4vvS1julXwF8ASoHys=;
	b=lFgt58RbLqIC4GYuUWbYAct2BQ5L4+Z6I/v7OwTlr4GOfJJU8JrMbCxud9xtsF8ohg5o
	 712lCsay36j0sYJuWBi0YEJXpODnyd8u1lV5bf/W8UtTUVp3tzaHOwz7CF/5rvtdjYCmv
	 /gqcAZqj1P97Y13s6/aZ4BRF+nXQAx5W4BKe4YEJYB72Lwi5DDBvhoop7ZyN82OM7NwsV
	 9GFuGIGj9kIlDGhMWtRjA2IML9IrxqAXJiTaQd6z4jhK1ApXjoVbPnsnwObWewDp65Vt7
	 odNLmLuCUJ5821nAzN+tPXOkteW55b+/BS/+bporcX1nrR4pMCTmRacz0MfA+lei35Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHNGek0V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BE606A333
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 225BE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHNGek0V
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so371558a91.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:10:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974221; cv=none;
        d=google.com; s=arc-20260327;
        b=UAamj7kD0cKlxjvrV8Cf5dxLtqc7bexBaHBW/4NfBygIUtdlZed6RXV+ZJ4lHZWQah
         tHYUxLgfhhfjcanOOpm6jNa+NGcHhhyJK+Ifn6xw/aNZidNA/Nc7gijQgvWjUCNPJJKG
         CTQOQDpv6tw+ueHIcq8+0/RCR8EEBpvg7RIl/7oq9oy4QHLcMUeX3FhQ1S2R30PFF+OC
         KhnqMfvxl2JAPuqidpazoJNRjITvuvDpYl6MPVnHzFhcQYG3w3jAisbaTJjFU5kRRgyT
         7VqbYhr0ytuq1Cy1G7R7O3q2ExXt6MIR1EnB7qtAnx+2Ix/qx49pjEFA1UY+nXf41vzc
         CNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rwvQpZE//s68T2deLP2tUfxPt4vvS1julXwF8ASoHys=;
        fh=n0T5mVNiSMPFXOx/OzDZRcS9wvCoNc2GJTcT4SuD2QE=;
        b=H4fpI8ebqe1eKq0hFQgtNoUtT9Ep/cKte2apcM7KVriQu2KlcqY+iMW8JBz96SftPp
         DRv+aVOyx6HDrQkvvieu7nzl/9Oe06JNTjbTNakrpwMixQKMDNeecAI2BrkwXtMOzUA3
         Fe/eVXqlxhLoHErkFq4Gh11DKU4fuNOykRjztZoHMqB4dRZe/GgQVs2zEK+cWZBarsET
         nNGNJdZPsAm1s+aDYYJnOLKXPNQzJ0MYzlV3gtxYfhaIwnX31mEaVfkt2KQp1bfZJT/C
         loll2fTFReO0jU/eTKqxqpd4XI+QhjR+UgVefHwkAWLu/dUG/2q4hhFqTwYpirXrAz5J
         1wbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793974221; x=1794579021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rwvQpZE//s68T2deLP2tUfxPt4vvS1julXwF8ASoHys=;
        b=sHNGek0VEV/ENgEVHKlclOXcCQ5lS8Eedv1P9Pcn4nP35YdctUuBnjlPcFn8mvci34
         mNU71iijtCT+FFmkjtvRAUlNZCO4Qs5exzkmflm4jArYM12lDRSqIbvuaqwkz37wLdnO
         94vmsuUmKc6yu21eIhpiAEExvP8W/8CDVB33usE8hVZY/O0F0qtNalrtzsPjUiRcxE5J
         scNTwiFr+ABXB3MjB3L8mj2It/eRx9faWCY2HC95exTQJ0cN235Zkur77xZ3Vg5Gl8hS
         Qis5CTv7KmExQFZ8U1QhgLwJsDkRb1Ox6l/UT77swbfgICchHxmy4poz3+SdtyIv/I0M
         kI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793974221; x=1794579021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwvQpZE//s68T2deLP2tUfxPt4vvS1julXwF8ASoHys=;
        b=yKyEtAGERc4j8WTNE4Aj+qrVrLk8RwcAAEuWMAEinvKbg9+2FMx+rXMC283WZ+exdB
         yZ9FZdlCbZ0ik3ua9Pr8pGTLHBvJgeVJeCkfpPcF2l84xPIKVytXqPN+JHH8brP016rC
         //KPdxt7WUTSgUsHLiwcKCljj8pqswvYukkX4vuUqABLuuIwJWllqeWVxJZmGvt88UjX
         L/gW4GyrFZn0Jh/QFgqkYVFauEQkN08AAfVSSYWHPzmbwkHacPxrYmbMT6AAan666NXb
         Fd/F7+I3sosXWB/NalZiXM5x+kEuuBH3l1mOR/R0p6Hzd39oHB1rPq+sdV9sRIgbthLJ
         RDNQ==
X-Gm-Message-State: APuU4Z/mtrF6Iok6JzSz3rewnYN2UvBlOTyrgv6fS1KMbxUr3bhQwgT2
	8vwgIIl3h91a7ELrCh7nIsAEoLarnuHO65b+VgbsUn3b2XyLy03I39zePwARQPx+zdo5KnUSgW0
	9xze8VEB4s0y1f1Ebm125e97wqx3Yhcp0Jw==
X-Gm-Gg: AYBFou15qsrcZNdp/Gd8UHrlvZCIxN5wPY44wedQ9fEIoLx1QS1Hqy6hncY8+L1ObEC
	bD+8gdWTkEc/Id8qBEfTHN2mKxTefxG/3YZXszAcVPTcJDDmd1Sc+BteiddBR6MPF+tyRNUEjkn
	hgP5SaUGzLUhBFmtZ/XaOK6mMSSQbhb+WMAzAUAaE+uMV9c/Y1F/i35x1PDAaYKM9TD9w6Ftpt0
	GsAV8WoP8NK2WDA6QxKzmKQRkrt1C3j6d+TfN3QAahnn0hHcXuenivWB7s9tUPHocPfCVgxEaiK
	HMefxMlraKWIGcnFq6olRj6+qH/n3d9ze/uzkWZC36/FpJBnFZC6ExXi/3a0SWcxrWZsVwzEqdQ
	ihVocpO0f2zVSSKPWsXa+pIzGunALwXDAJhsGQZRZbHOhxv+37VHPr2PV3U2FUo6YrCZLsVLhab
	/kstqV7jQjwGHBKOjiGqepEk0ybu4KGmtV98iBStcaqZ6e3EMFCMc+IK6KGr35JTd8idPZlh0oA
	4v7mbko1ktufrc=
X-Received: by 2002:a17:90b:58e3:b0:3a8:211b:6c6f with SMTP id
 98e67ed59e1d1-3b0db7282afmr2727681a91.67.1793974221332; Fri, 06 Nov 2026
 06:10:21 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
 <20260822-vv-branch-recurse-no-start-ref-v1-2-46dc140acaa8@zitro.id>
In-Reply-To: <20260822-vv-branch-recurse-no-start-ref-v1-2-46dc140acaa8@zitro.id>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 6 Nov 2026 09:10:10 -0500
X-Gm-Features: AclHuK9P71NOty9E6RcUFZISikcShBe0cocU5kG5S7LNuMJNksR-uFljKl6AnAQ
Message-ID: <CALnO6CDqtVuUqm0xW7Cd=MVbDSaa0Q+T6D9rx_CL7jjUbeb=DQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] branch: allow recursion with no tracking name
To: Volodymyr Vriukalo <0@zitro.id>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Glen Choo <glencbz@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 7:04=E2=80=AFPM Volodymyr Vriukalo <0@zitro.id> wro=
te:
>
> Creating a branch across submodules from a commit that no ref points
>   at fails, with the helper's usage text reprinted as an error:
>
>     submodule 'sub': usage: git submodule--helper create-branch [...]
>     fatal: submodule 'sub': cannot create branch 'branch-a'
>
> `submodule_create_branch()` runs the helper in a child process because
>   `install_branch_config_multiple_remotes()` cannot write config into a
>   submodule, and passes the branch name, the start oid and the tracking
>   name as three positionals.
> `dwim_branch_start()` leaves the tracking name NULL where the start
>   point named no ref, and `strvec_pushl()` stops at the first NULL, so
>   the child receives two positionals.
> `module_create_branch()` requires exactly three and prints its usage.
>
> Make the third positional optional, since a start point that named no
>   ref has no tracking name to give and the recursion has nothing to
>   track in the submodule either.
> Push it separately in the caller too: relying on `strvec_pushl()` to
>   stop early leaves the argument dropped by accident rather than by
>   intent, and a reader has to know where the terminator falls to see
>   that it can go missing at all.
>
> 961b130d20 (branch: add --recurse-submodules option for branch
>   creation, 2022-01-28) introduced both sides.
>
> This is the same NULL tracking name as the previous patch, reached one
>   step earlier: the dry-run pass over the submodules runs before the
>   superproject's own `setup_tracking()` call, so with a submodule
>   present this failure hides the abort that patch removes.
> The new test therefore needs that patch under it.

Right, with the previous patch, we get a little further and then still fail=
.

I think we should also simplify this message quite a bit: creating a
submodule branch may not always have tracking information, and we
should omit it when there is none. An exercise for the reader to
rewrite the message ;)

(Nit, we don't typically use hanging indents in our messages.)

> Assisted-by: An LLM.
> Signed-off-by: Volodymyr Vriukalo <0@zitro.id>
> ---
>  branch.c                    | 10 +++++++++-
>  builtin/submodule--helper.c |  7 ++++---
>  t/t3207-branch-submodule.sh | 13 +++++++++++++
>  3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 182fc4a3dd..2dab1f1e35 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -726,7 +726,15 @@ static int submodule_create_branch(struct repository=
 *r,
>                 break;
>         }
>
> -       strvec_pushl(&child.args, name, start_oid, tracking_name, NULL);
> +       /*
> +        * The tracking name is absent when the start point named no ref.
> +        * Push it separately: strvec_pushl() stops at the first NULL, so
> +        * passing it inline would drop the argument by accident rather
> +        * than by intent.
> +        */

Strictly speaking, this comment is covered by the log message. I agree
it's better to be clear about what we mean here rather than punning on
tracking_name=3D=3DNULL, but I don't think future readers of the code will
much care how it could have / used to look (and if they do, that's
what blame is for).

> +       strvec_pushl(&child.args, name, start_oid, NULL);
> +       if (tracking_name)
> +               strvec_push(&child.args, tracking_name);
>
>         if ((ret =3D start_command(&child)))
>                 return ret;
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1cc82a134d..6895216712 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3335,7 +3335,7 @@ static int module_create_branch(int argc, const cha=
r **argv, const char *prefix,
>                 OPT_END()
>         };
>         const char *const usage[] =3D {
> -               N_("git submodule--helper create-branch [-f|--force] [--c=
reate-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <=
start-name>"),
> +               N_("git submodule--helper create-branch [-f|--force] [--c=
reate-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> [=
<start-name>]"),
>                 NULL
>         };
>         struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> @@ -3344,13 +3344,14 @@ static int module_create_branch(int argc, const c=
har **argv, const char *prefix,
>         track =3D cfg->branch_track;
>         argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>
> -       if (argc !=3D 3)
> +       if (argc < 2 || argc > 3)
>                 usage_with_options(usage, options);
>
>         if (!quiet && !dry_run)
>                 printf_ln(_("creating branch '%s'"), argv[0]);
>
> -       create_branches_recursively(the_repository, argv[0], argv[1], arg=
v[2],
> +       create_branches_recursively(the_repository, argv[0], argv[1],
> +                                   argc > 2 ? argv[2] : NULL,
>                                     force, reflog, quiet, track, dry_run)=
;

This is of course the function whose tracking_name being NULL we just
made more sense out of, good.

>         return 0;
>  }
> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
> index 54f7caeb2f..c56cea31cb 100755
> --- a/t/t3207-branch-submodule.sh
> +++ b/t/t3207-branch-submodule.sh
> @@ -115,6 +115,19 @@ test_expect_success 'should move a branch to a start=
 point that names no ref' '
>         )
>  '
>
> +test_expect_success 'should recurse into submodules from a start point t=
hat names no ref' '
> +       test_when_finished "reset_test" &&
> +       (
> +               cd super &&
> +               oid=3D$(git rev-parse HEAD) &&
> +               git branch --recurse-submodules branch-a "$oid" &&
> +               git rev-parse branch-a &&
> +               git -C sub rev-parse branch-a &&
> +               git -C sub/sub-sub rev-parse branch-a &&
> +               git -C second/sub rev-parse branch-a
> +       )

This test contains no assertions, although the rev-parse's will fail
if the branch wasn't created=E2=80=A6 so I suppose that works. Was a bit
jarring at first!

> +'
> +
>  test_expect_success 'should ignore submodule.recurse when not creating b=
ranches' '
>         test_when_finished "reset_test" &&
>         (
>
> --
> 2.55.0.2.g927b4b9963
>
>


--=20
D. Ben Knoble
