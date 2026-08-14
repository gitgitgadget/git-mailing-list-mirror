Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00C3EB7F4
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734472; cv=pass; b=Gt4fP0Ihjpq4MRkQWNugsMW/jkJUPSCTlc7xobiQa1T7FaO1lClAGmOdpYENsp6lha3Nxv89jqkBj9nLmsp9IfB9YCkUVJOsA4OHBmp3TwJ1/PQTQ7NwIx9W2FVzKorRHesEHzINxB+qo+g5BQffBi7NSRW0W3JKkGIXocEp3ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734472; c=relaxed/simple;
	bh=U3g7bPsq2RcSFa26qr2oqzlHPPvGf77B/zsejR6U+SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSPYzezGDC1DkPpK2GEIEqkXkR9nivARyc3DkvyOXsb70gdnKLJs5LzI84RT13k6PIJ8e5R4sJPaUpkoGHBlps9rsYRE9PwqJp7/C0POKEOCb6xsoc7yPVWVdJjM3XAxiXFnFlrdF0gAUezSqHvRLS7kQ90WBU1GAYtvL9wJBb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZZs3CkM; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZZs3CkM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d0407aedd6so17827305ad.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786734471; cv=none;
        d=google.com; s=arc-20260327;
        b=hWEdhbjpVM908q+SALNlakbLzzVfA+1+W032v5Q1PwsMEAmUH2mqrcNgLhVskg44B7
         EHyOZp4hqUxlDb7Ode7xAsT1vL79kNfefuuXA13JvGBKae7L/UGZPPSTXDQ1vQKqVNtY
         MS69s3YSpqb/xo0cMXYp+P/Mv7QcNSQxU7r9/ZKtASfGwnNCg9VWAJok1P+Y9e4mvrR/
         UXKA/Py0jR+X6IyXuPvkrqo+qhLyub+FvoP8rpAe74BVFo7Oi/AybNTSWhXdWDiNv4bK
         c5SW/Dun490lcvS+aG9TsaKMUA5jZHaMJKv+mFAxWNOyHifMdVEUipRvxPIbEi7HLOWQ
         sHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J+XY6mZq8OEU/YGPPzctBIi95FIn05GiF6S6NppvyQo=;
        fh=pdga0shfZOwETzJs5PSu+wgtpod8R/kvOftGT+m7x1Q=;
        b=JV2Io6o4xNwys4+w/HEejVpaBzOtluXeKb2hKFtm6IHGa8SSbTpFwx7i1OQ131mANU
         13RCPRHGgd84OBqhNTaK1c743U+Pnxs+KUDcY4LzXB4TMYtsd/yNZa4y8D/Stxsn620f
         0qUBXwC46x48E/INTwbx3j+EOdfVUQX6o7EL/WeySub2E32bkLvuJyj98h2VS7BhjqOt
         4oOCJqAwK0eAdRKTC370dQOR+iCguQg7fea4ZzWlT6v3PyMN13LSApDJH+walU/qOLph
         R+xMS4ICwwqz2WB7h3ilq9feBbjmCHBC5yc/cpWcoTjjxC3AnA1WuRRht/mmuFuncvVe
         BzQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734471; x=1787339271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+XY6mZq8OEU/YGPPzctBIi95FIn05GiF6S6NppvyQo=;
        b=RZZs3CkMmmGmiD/kE81nx5O5nOZ92s05tU/U6uwmnEuvye2665d3SdLzF06OWE5293
         s/fuU+pl9v1Yv6gtjyZF8Pa/7N9B56eXuJeQbolZoZYWwpJaaWKYtVXPcvatlxGctmvM
         AI8PCkGiGicWFZuMGUrkpmUHdP0JtWsWkvDbuELKLBPXiyiV6SdKxlb8OlAIH5kmUy00
         zfGOOEl4pjxS5KZccBJHG/hbKipSKiEjfHL9qw5K8bOIOTycUsuTvGf82WqFy0TZBOoX
         F5as+laA0m7OSamY3XGXoBW/j8lRNyao8NQc0aKG2/cAoIZ9Ot4n/Ey81aowqG/ZYnVl
         e+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734471; x=1787339271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+XY6mZq8OEU/YGPPzctBIi95FIn05GiF6S6NppvyQo=;
        b=FjQGM6M2/mF9BOqNWXkKjySyNYUaBu3FfEmAXrA6X6E6Ql+pftt18S6xCOUqSJbT8a
         paZeTgvDbyiT7eqiGOfd+xXVEfBPkhQ9DiT0GV5ukszXxV1PNZpnR9ZmvrktWlWJqnoB
         pxyAfDesSi5nyUZFR4QYmc0JoFi6wo5aspw2zrlzMfYRE6GrsUV3JfUsW5iWQOA5G25M
         bL2lFA1o27KXSFu30B+rBAhPCiM+JD+3dVQQA1WPhz52XQbeZbFIs8fC+fwdQdv7mkGs
         PLF3IjwdOGhNnbDCjaVA/TLASVG8IvkcVX20rRvRjYHHUbMVbAxb54mEqAzsoRXyIhry
         PQNw==
X-Forwarded-Encrypted: i=1; AHgh+RrToFaD+bT13+cIl59UoEqRZDgI5Dbk9rgqcJKVdaACjkOK4huvTNQJuALHgY+4Yed2oC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/thDu8TJ9l9CbAu53+Mzne1fF0Td2V4gqH/QkebdhO1RFWs+
	cdnOJzt/o06SbzAggEu89heFppS0vTNkUhaWBes8brgzbWDqbJuYjTJBPyGhZrWEFd3CjHCPFPT
	sojHsGe7nIAWXtnejdPcgoW5b/hfCeB89GLGCQsk=
X-Gm-Gg: AR+sD10i1YmDDsKWWd8mAH3Wsge+dl2O4XRcIzOmPJfQbqbUJLq3lz+mqZ1fOXZsocr
	Vyk2GGl5lOrJ/+bbm0d6SkMIfdyEwQVTftFqMsiN3xbhl+lUGE63qhqkbf1b3rcPipivRYwSqbb
	Byp11TD9bAtmk09ClLLffC3USkh+MJImSq/SMRnvmjALG8zoJrmCl1anMwj/40nEz8T+jjFO7W+
	olXSmuTcX2xiGw5rDPcON6pWp1BTRcjIOEsTxUh2yBtMBWgERa1gvUBpClGZeqGeeotmEefcNtR
	SbAMd5ktzynOOsmfoPPShf5aj3TZSydFNTtMt/kf7VsJjDWjKaErfcLJPlaS8M5rISjzNMK+wJ6
	Ar08iWouDJ3ycUXS0olOvJAzLB+oTlvmKXbsCzkrjeW56CAvMMobwdTFx1toXKCYMAYOwGYdo
X-Received: by 2002:a17:903:1b4f:b0:2d0:cc92:f7b8 with SMTP id
 d9443c01a7336-2d3b0cdb79bmr105898685ad.2.1786734470588; Fri, 14 Aug 2026
 12:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
 <an9W4XwY8X4ZFHpA@wyuan.org> <CABB4Jh1fUXKNn483FjD2S6U4cYVMEP6z+fjWMi8XRT+NQdNnYw@mail.gmail.com>
In-Reply-To: <CABB4Jh1fUXKNn483FjD2S6U4cYVMEP6z+fjWMi8XRT+NQdNnYw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 14 Aug 2026 15:07:39 -0400
X-Gm-Features: AUfX_mwmapiSLlrX5I_LjKALFifEakawMUHqb2qRPMXFpbqBI4kAsu16dy-9hlQ
Message-ID: <CALnO6CCDQBWS7dP7CZSbKE3f8rw4x=NAJhGyE7HCJRjJq_2dEA@mail.gmail.com>
Subject: Re: [GSoC PATCH] submodule: warn on valueless active config
To: Tilak Raaz <raaztilak07@gmail.com>
Cc: Weijie Yuan <wy@wyuan.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 2:05=E2=80=AFPM Tilak Raaz <raaztilak07@gmail.com> =
wrote:
>
> On Fri, Aug 14, 2026 Weijie Yuan <wy@wyuan.org> wrote:
> > Thanks!
> >
> > However, my suggestion is that it would be better to place your patch i=
n
> > the main body of the email text rather than in the attachment.
> > Please take a look at Documentation/SubmittingPatches
> >
> > And it also seems that the automated program 'b4' is unable to recogniz=
e
> > your patch, which may make the development process less convenient for
> > the developers and the maintainer.
>
> Hi Weijie,
>
> Thank you for the quick feedback and for pointing me to the documentation=
!
> I apologize for using an attachment; I am still getting my mailing list w=
orkflow
> configured.
>
> Here is the patch provided inline as plain text so that `b4` can parse
> it correctly:
>
> From 08a2f244efab6e4cf21638d87a721ca664ed9433 Mon Sep 17 00:00:00 2001
> From: tilak-raaz <raaztilak07@gmail.com>
> Date: Fri, 14 Aug 2026 22:50:11 +0530
> Subject: [GSoC PATCH] submodule: warn on valueless active config
>
> The config parser previously threw a hard error if 'submodule.active'
> was provided without a value, causing commands to abort.
>
> Swap repo_config_get_string_multi() to repo_config_get_value_multi()
> to parse valueless keys safely, and emit a warning to the user rather
> than crashing.
>
> This resolves a NEEDSWORK comment in submodule.c.
>
> Signed-off-by: tilak-raaz <raaztilak07@gmail.com>
> ---
>  submodule.c                | 16 ++++++++--------
>  t/t7400-submodule-basic.sh | 11 +++++++++++
>  2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 5c92575888..b709c429ba 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -231,11 +231,7 @@ int
> option_parse_recurse_submodules_worktree_updater(const struct option
> *opt,
>  /*
>   * Determine if a submodule has been initialized at a given 'path'
>   */
> -/*
> - * NEEDSWORK: Emit a warning if submodule.active exists, but is valueles=
s,
> - * ie, the config looks like: "[submodule] active\n".
> - * Since that is an invalid pathspec, we should inform the user.
> - */
> +
>  int is_tree_submodule_active(struct repository *repo,
>       const struct object_id *treeish_name,
>       const char *path)
> @@ -261,14 +257,18 @@ int is_tree_submodule_active(struct repository *rep=
o,
>   free(key);
>
>   /* submodule.active is set */
> - if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
> + if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
>   struct pathspec ps;
>   struct strvec args =3D STRVEC_INIT;
>   const struct string_list_item *item;
>
>   for_each_string_list_item(item, sl) {
> - strvec_push(&args, item->string);
> - }

It's hard to tell, but I think (depending on _how_ you sent this patch
with GMail) the indentation has become corrupted, and the patch won't
apply.

Give the tips in git-send-email.io a try; especially with GMail, I've
found the safest way to send patches is with git-send-email. (I reply
to conversations from just about any mail client, though.)
