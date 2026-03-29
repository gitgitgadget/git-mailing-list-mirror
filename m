Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180F2D73AD
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774778106; cv=pass; b=oF8PHIqK3kgAaw6iOYUEXSgz80WUkT/H4/FP/wN2JjhTAL7lAG4q2lAi6HXz1AqntbREImWrcxSj0ag2hCjHZVcib/GxRO8WIPPcMWhHCml4xgP5BIgKFLXrOG/kesgevVLamUtTVxvOFY2IM3EdD2F0LdP5k+jJDi0EwCyyD8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774778106; c=relaxed/simple;
	bh=0/gGonh3NQoA8iARcz52GrIrbPaaIi295ldJcIOiMMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZZBn3ETP7xH2T/euLfOx4YUwkRNi5+birnZvwkry0/ieMBwxVnqIWwmKW4hH5UzFOy7SA8yYEhygE5Jp9Nj0j2VhwtsmAocexRfeq+1JIttu4C/GCeAgbnCjzuGu870FS13Wtwsn1kHxPaRos+7yrpl3ADhsPcWWxiiarIoesM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXpWCanj; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXpWCanj"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b266413fbso30057101cf.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 02:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774778104; cv=none;
        d=google.com; s=arc-20240605;
        b=YOHlb5ohO1tMkY4klWjdFKGUgf6i49jZR5wl5WXxOsfL6tnSENfJQdIs6dVaesJJDQ
         kiSC9rou7j0b+oQkM9yd9hmm1HS7M+eMZUPPldWhr3Cx6Rf3SvJi45gUFtAmK4cEF1fL
         sojYd6RCRmLTP0iRKt9YTxLvjwqTk+Pp/4nF104NBsT/K/MU5EivHjXZViwoJPQ3qL40
         mWTBDrwMpFnoJDsViUUUfCZami30nm415KyFzcPffz1ehtgZsjW/KYNALrYFmLSHxvk9
         YSKI49KpvRYbvUeRRcbSk8d0TebBqfTNxtW13Xgy/LroQSq/u3DVMMrSYaxrheXHOzbf
         ChIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Nx+C+QbZAZ0vnA6OUzXJPxlUr4GYfNJxrDO0CH7wcQ=;
        fh=T3RqhkK6Dx6nDTDoAUbnq5WQEHSukdYBVXt/LlY49Uc=;
        b=AK0zAt3CF0rv8KmLcIWxIIDSHCaHqfvpEDFVZf4+WUuzIFSXyIzaz4BT9ftUFax7Cb
         d3czQ8EsHNdgH7Jf7s15yzHdat8P9S/fZCR0lEhlLQVtYy0sYwa0n/WVlTx+Ef0gGyTI
         9Vhakh7cR9iWtSlm9I2WrvkVtpfp5fcy18O/D8VOYqjU3q2b9fsKYEzM3GC+AfZb9XpW
         8cXMlbATIZ/Hp+yBjUXFpVXmh6KCEXKJkIiWHbCMSH5HVhM2SRybQDf//MfGxfszT3nm
         cMkRj10QgrjYKIzd5Ah8121IKbWpI7m2qdxgoOvzxkAzmO/2K0NyYLqtgx1jtQCcMnUQ
         kY5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774778104; x=1775382904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Nx+C+QbZAZ0vnA6OUzXJPxlUr4GYfNJxrDO0CH7wcQ=;
        b=hXpWCanjhi8RKw+g+fsjMD5+cAiMA1LFz5935xwPHtynva0my3RTqXxoxSU3kTJx6Q
         YS8V0EmozYPhdgJvxauIQ860+ZTDzP+1syuMLHkiHJEtfyEsafT5hiUGdAdXDO/rmoS5
         8uIk/zLpDwgZuqLrRxv97E/vK+VVkJ0lPeaBxS51AkMtM0bpxrIqzf+ctisByMfvKj51
         AbGSEg5fsBiIx0YPYKm+YqXGUIEUj7kvonlmEw28WtgT9GLypnYeArxWxtw3K3ZBUby/
         O+lQxiDlbUjO139rl/cvLGOMci15tE4MiR8V7q/Q5115gPZu2a2VvVcPas8UxFocICIF
         axwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774778104; x=1775382904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Nx+C+QbZAZ0vnA6OUzXJPxlUr4GYfNJxrDO0CH7wcQ=;
        b=LPtsgSVALtuP7zSHUajYDLGDCJGHKwq9q2+wDLToGQwaD6DBbGURVwH0UZtctHKRS5
         Ip+knIrqojEzs9gIHKmHvyIUvrb+8D2uzPdM5faXmPGEJ3vFMencYmMeLHuP2P+6tdGt
         kpDrI6LKifiGAkbXJ7KEaOuBCa3ksdh/EJBxpY3HoWvlxQWtpzGW6jbt6zvoeou4iIaW
         GkjhRArIYKieDWSHOK/Gd8RzUXpSHh+rB6M8KcCuJkaZemVjRjzxBbsacYKKvE/mQuEl
         32Qd45l2H//SOfrDOm19jxYSnbnCKh7a0XHHKiONu5vHXY0K9RHIfeiOefrCPQ3I44x8
         kFEg==
X-Gm-Message-State: AOJu0YymlFvZRr9Y2rg7GoyKbvCs6z+HshzjTk7ohGo+qu4ntgb9wI3N
	qvO14LgxxXJCRfith2AAfHTsVXIh1zlwIclcQOr0SRAjkF/npFMy6Ms4/LULkGM4IE9dB/E3jDM
	HW2gvaG/2DdPfTHMy/39TyeHDt2kQYD0=
X-Gm-Gg: ATEYQzxyNdAtQWcRaPg/cH3ZnIRVozOrzhL+YFKdegn4YU35pmn2lj1L16w+a2LHY/2
	HVfrGEjtsdTcU/zmeSwZtflmnJqc93gDIsppy8Jns3DXNwjP2SxSv9t4to3RjpXMqRPxwVROavd
	MhFOtDX+aVC6oQXbOdUAhZ5JfD8UmDEGqMnTSCrn7fDxK+dcwIG3sZyVuTNSTozaL83Q+WIvFsU
	4UE0wISXtM2uDqUbNpYd6q+fKFtj1oc9GBdAZq6JXHVsQJo0TOEwiDdVXhreJsXQkjnNXe519jH
	H6LPGCl1Zpt6IcHmORUNLP7FFHM/z8gzX6wu7RtWVg==
X-Received: by 2002:a05:622a:1dcc:b0:50b:4f07:315a with SMTP id
 d75a77b69052e-50ba3976a41mr122159441cf.53.1774778104353; Sun, 29 Mar 2026
 02:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-6-shreyanshpaliwalcmsmn@gmail.com> <b2c143af-22c0-4266-b641-5ccdeb221251@gmail.com>
In-Reply-To: <b2c143af-22c0-4266-b641-5ccdeb221251@gmail.com>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Sun, 29 Mar 2026 15:24:53 +0530
X-Gm-Features: AQROBzAsTNEeZx3m9Z0fJOntcPhFpr3exMest8reOhUb73UC00cCoS2nt3z0B6Y
Message-ID: <CAPYXD64CoBYAhJwzZxU_i3qL+a-gXKNAg2kBVz_u=mGysOKTcw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] refs/packed-backend: use ref_store->repo instead
 of the_repository
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 10:38=E2=80=AFPM Tian Yuchen <a3205153416@gmail.com=
> wrote:
>
> On 3/28/26 22:09, Shreyansh Paliwal wrote:
> > In refs/packed-backend.c, repo_config_get_int() is called using the glo=
bal
> > the_repository, even though a repository instance is available via stru=
ct
> > ref_store.
> >
> > Replace the use of the_repository with ref_store->repo to make the code
> > explicitly repository-aware. With no remaining users of the_repository =
in
> > this file, drop the USE_THE_REPOSITORY_VARIABLE macro.
> >
> > Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> > ---
> >   refs/packed-backend.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 23ed62984b..ebc10dab4d 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1,4 +1,3 @@
> > -#define USE_THE_REPOSITORY_VARIABLE
> >   #define DISABLE_SIGN_COMPARE_WARNINGS
> >
> >   #include "../git-compat-util.h"
> > @@ -1223,7 +1222,7 @@ int packed_refs_lock(struct ref_store *ref_store,=
 int flags, struct strbuf *err)
> >       static int timeout_value =3D 1000;
>
> Burak already pointed out the issue with the static keyword in patch 3
> of v1. Notice that it's here as well.

Hi Yuchen,

I have acknowledged this in a previous reply to Burak. As stated there,
this is a valid issue and would require moving the config into
repo-settings struct.
In this patch, I focused on removing the dependency on
'the_repository' while preserving existing behavior. Global state
removal and multi-repo correctness is an incremental process,
so I would prefer to handle this in a follow-up change.
I'll also update the patch title in the next version to better reflect
the scope of the change.
Btw, I forgot to cc the other recipients previously, so it might have ended
in your inbox twice :)

Thanks,
Shreyansh
