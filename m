Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354F37B406
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822440; cv=pass; b=EFAuruDyw9G7wG7ST/te5rrZ101+8VPP7rm1QqTUCK+W4r+DIZUh3ZQV5wukWOx6KLHxr7CVwH6w5s6xL7MXAACoCKvXuuGBJwawVrC1xoYH/9wMf1Mo9f8nJrbp3JA2tqgqbNEkHomHHTMcms+RdAuLrGp1jyO/a1Wa7voAAP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822440; c=relaxed/simple;
	bh=fIaCaT5ey9JSilVl3URPCKQyBkyrKowjM5g6MpThqr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr3ZTiOE1GVhNpmftrrDSDG7JVyH9XLzmR4jhmgxybQEY3tkdcGW8qvAgRbcbiBK9KpcmW4wI0omzeLrCboNwwvpqoUYKrr4C9dPScPn7wQy2B5R7fmGkHOh8q7tK9CTJ/km9UpgjRdAbgHJTHKO0nt7CPqCOVuRW+BhIUwaJd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0ZdE0D7; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0ZdE0D7"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso6303771e0c.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 01:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773822438; cv=none;
        d=google.com; s=arc-20240605;
        b=OS5ux3mQc0PeZrSaB4jvbr6Wc2yth6b/XeLHvD5ANKO5nWDBmPzSVDAxUDFb1l8fOJ
         w67FZWrw+Q20Yl9oXG5hXh4QGg79oK9KPdbGWVn0O9FgK0AmJTcRFEDTv4eGh/n6kz+8
         WYUEL5je9pOLzbVAHs6/erwAq9k/7GYMoJjvvFxRFXQ60OgffK/uG5IGvDsibdg0G8eI
         dEXPtvcqjU9g9OFHexLFBFmGOcSJ6uV1ePAkK2rd7GrQlSa2pWBWj+waSEjWWt3oHaY4
         l7DckcwxNdq7JLJxdAI/mJJiy15taomXQxt9vfj2RLztV38kQRYVjrMo5KRsl0MDArp1
         93LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MXrxh9G8PyZ7va0namTxpEplEGB6Fa1SjFTLnUkLMYw=;
        fh=ZLbtRHG9wnbVyrKyPiYAE4GtK+1fPdiLi2gTHDJPeZI=;
        b=hh+GBs/0A/pqp/8qdcintWa/iB4NVzPWvcWQGXvObw1gpJc6ivYNKbjaJDq9oJJjqg
         dgxp+mNdBNqNgmCMhuPCeGDsHxqfFaP56xXwaLAZTDdBa8hKgZU2UlsOznaXGUsveiFP
         0zfJY0DEB7mDwizqXJu8HopfUKqXILFLuLB/3O1TFL2JPqTfBDLc1CmLxfSBvHitshoK
         20S5CU9LchJGH6pGxbHtyGcntRIEu/tt9IIuU1ZnVyOTb2dSGRpR4szFNl+Ui5l9YQvp
         r/TlKfDm/z0ml60DPu8UQRNMRppYaChAocveJFB2PwojAn5UW2+5Mlss1/7+JJYb/lyE
         ce9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773822438; x=1774427238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXrxh9G8PyZ7va0namTxpEplEGB6Fa1SjFTLnUkLMYw=;
        b=l0ZdE0D7GQ7BN8Qds7U/F4sryVjGkb78WR8NBnV0OBv4NGpueTv7VpCg1TfRqJsq9R
         lvaDB5Nyehp/eHu6HsfKfpaMJEKzKrFe5HYBC30PEN3f9FedEgTZowVlTzrf0al97UuM
         L6JmpX2cj9FDLJ3tc9PhFzpmPns0oqs4VWRRy2NjpyQNkFqs2kn+a5gy/VkJom0+nx/V
         MT/9Iqx7VwQbP5Ir1lXKTTj2BN45DyuUSlsatKlPkQIY90NB2PwHADJXDErDDp22KTwS
         G/I5+TKe25Ps1YmHx0/lesX1EiAhFjEas18Hk2KJg/N+VT//G0aIe+Q/5CF2wHCMQzQp
         5PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773822438; x=1774427238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXrxh9G8PyZ7va0namTxpEplEGB6Fa1SjFTLnUkLMYw=;
        b=kB/kT/uyPG3+oQ8RXy5/igQryODDOmuQmqheNzMOs1s5BpagyyV72Gx2qItET6hx7F
         /T0HJlpTF7UO6iCI6eM2mbbP4u9wptlMwSLA9ePfgO1O9hGovXi+05s0gm5uKBds0mmB
         0rnsZ9GRXZKZKgnsYjdJHVyI3Er8FCYbgL0H3eKGwzJQzumOnDgHGu4WxWcRcPAitpvM
         8oMWWdJxwerD1VZ6P9dRckIpCmDIilNWBouDuUIgMn7DumOwMo4pfdy7TvazqKkTsc7r
         BW9VtYFKeGfZxae6zDX7EbdRBNSef1xexIJAEvRqtP8pfVUy29bdD7QM5f1gy68aUyWj
         21bg==
X-Gm-Message-State: AOJu0Yy7HnIIFaq2pL996PPLAbY3efCYQ5VwgF7xRvYJIrv8HMDInQyO
	WM97TJFBESfosLsGUuT2vsh1rOEjibjQuoxhxvgE9xX5UCQ8KlqHyKkIfBvGTS65u2zEsdTUUPh
	yeevqcA7B9npguUvSz3SQqUqZtVIVeLM=
X-Gm-Gg: ATEYQzx9QtjDc1VT9BqnTUf8PMtUCdp5uCjAS/BFcey12kq4rurJPGAMDCLC/HRZMTt
	rMl7W3vIRxyzoLtKQNkGApl9P3exNBSux9H/k9L5esJ+QqruJPQSvEvtOZfdngSRlZVw8bvvda7
	nUQJQi02HIK1REmPQtME42pzQRRrGNcpuKMq42TtkCPjSVjcB7A9DSXEzRvBtnTi0plVO9Q3/Vj
	e5ZFmwDsbs/mrR2x67oh2Z+2+0UZEvgT0nbPjlUZy7EVZjWJelGaZYEUrkHtYVJmUSIEQihAQmD
	U8uI/yNtHVcwrkrLWh3hrzOjhDBQRGYdx8TRN7w=
X-Received: by 2002:a05:6122:1811:b0:56b:982f:1267 with SMTP id
 71dfb90a1353d-56ba71b70c2mr1623996e0c.13.1773822437864; Wed, 18 Mar 2026
 01:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com> <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
In-Reply-To: <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
From: Orgad Shaneh <orgads@gmail.com>
Date: Wed, 18 Mar 2026 10:27:06 +0200
X-Gm-Features: AaiRm50MAhQM9sLMG-N4FgGbzom9nKUuVHFSdf3lfAh3hzds1OKXG3cZNJZxNIA
Message-ID: <CAGHpTB+qbtrBQd23hobQqJjG1+nwkHqBP1fcYjSPvrJhWcD21g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
To: Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Orgad Shaneh <orgad.shaneh@audiocodes.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 10:23=E2=80=AFPM Orgad Shaneh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Orgad Shaneh <orgad.shaneh@audiocodes.com>
>
> This was documented but not implemented.
>
> In the flag description:
> prune local tags no longer on remote *and clobber changed tags*
>
> In the documentation:
> ... to prune local tags that don't exist on the remote, *and
> force-update those tags that differ*.
>
> Signed-off-by: Orgad Shaneh <orgad.shaneh@audiocodes.com>
> ---
>  builtin/fetch.c       |  2 +-
>  t/t5516-fetch-push.sh | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a3bc7e9380..c212f50b86 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -981,7 +981,7 @@ static int update_local_ref(struct ref *ref,
>             starts_with(ref->name, "refs/tags/")) {
>                 struct ref_update_display_info *info;
>
> -               if (force || ref->force) {
> +               if (force || ref->force || prune_tags) {
>                         int r;
>
>                         r =3D s_update_ref("updating tag", ref, transacti=
on, 0);
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 31df7faf56..4d29043baf 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1092,7 +1092,7 @@ test_force_fetch_tag () {
>         tag_type_description=3D$1
>         tag_args=3D$2
>
> -       test_expect_success "fetch will not clobber an existing $tag_type=
_description without --force" "
> +       test_expect_success "fetch will not clobber an existing $tag_type=
_description without --force or --prune-tags" "
>                 mk_test testrepo heads/main &&
>                 mk_child testrepo child1 &&
>                 mk_child testrepo child2 &&
> @@ -1108,7 +1108,13 @@ test_force_fetch_tag () {
>                         git -C ../child1 fetch origin '+refs/tags/*:refs/=
tags/*' &&
>                         git tag $tag_args testTag HEAD^ &&
>                         test_must_fail git -C ../child1 fetch origin tag =
testTag &&
> -                       git -C ../child1 fetch --force origin tag testTag
> +                       git -C ../child1 fetch --force origin tag testTag=
 &&
> +                       git tag $tag_args testTag HEAD &&
> +                       test_must_fail git -C ../child1 fetch origin tag =
testTag &&
> +                       git -C ../child1 fetch --prune-tags origin tag te=
stTag &&
> +                       git tag $tag_args testTag HEAD^ &&
> +                       test_must_fail git -C ../child1 fetch origin tag =
testTag &&
> +                       git -C ../child1 -c fetch.prunetags=3Dtrue fetch =
origin tag testTag
>                 )
>         "
>  }
> --
> gitgitgadget

Gently pinging this thread. I submitted this patch about a month ago
and would appreciate any feedback once someone finds a moment to
review it.

Thanks!
