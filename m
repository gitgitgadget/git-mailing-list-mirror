Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2621F8723
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517272; cv=none; b=myiF6pYwpRBKb/Atta9ebPxCGyatJ/qjNAE0+LEA08a253YmWOH7PlrrmU2uvU8G14bcxJNwibugMC6hPtTMFj4Q+Uex0SJuRR3ukTSmXiFVPnSO5aIrp4j4HEvkaBnLtgPkfnxzekY0pLUWsw00Vszv3iLKPNdEKNTEffU9PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517272; c=relaxed/simple;
	bh=n782U9OBM0gGf01rUMYTgmB899zHFJNvYC88sY1n6bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bonSAZKucq0MeLwSfy4Qq143ODzuUTdyy1HyWwKHCUKWs1loUUZCshAE0QpB+WcdmdGcScQj+1K6RYsgl5zex3xS/Ngv+hwRwG+O2P8EyU5u5w8t0eBG7ouDHT/PLWpnLE3YNLSYy3v4gy7O63eVHCRb209LVQ6+rHusYXLaG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msA/sipw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msA/sipw"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so394949866b.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746517268; x=1747122068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1kvhWacjA5j9k+WgImd98YaWQcqLsLQqeXOHdu4b18=;
        b=msA/sipwCYFvPKcfmt/zRcehEsK7u3TK87+yndtYJMGwCXhGuCl9eBL0u+h6vG3PBs
         RMBffGR5UzaGRzUzilasX4DqvUEnHkr3O6HXa2/sAePxV9g+5kSLzo57JTUxNRfCYhYz
         PNvQc1YCCzoVj6oq/pBaLL1AuTqSQsVaMn+RlYeEuTdNZWz+TBtCf6C2mthdIhIhxRa1
         PpYDksvVKhSCGokiqm5BHUDHvNl/7ZDS/n/NXsyKv6E/rvwcwQmi3yNLHcrABCaG2gjH
         /32XQXoYpo8Oeesfaci+lkxRgHzWCGcWp0VwiveP8XujTsBq7mYr9UeU/8+exeVIXix1
         KFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517268; x=1747122068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1kvhWacjA5j9k+WgImd98YaWQcqLsLQqeXOHdu4b18=;
        b=FtaF+er4uNWJ5XLGqY9enPWBn8ZBq348X5BBMA5jgaQLvlOGHKaNwELSsi4VCdR9i3
         Dw1vQ6o4/0GW/I1XeXgBikfRJoVX8P2IpWkeahFy5NRoJAMTvhzDM24DFWsapS2Trp0k
         nUvg9pSbKWDlTrTxGa3PnBE85s26oSWkGMvIDhYWCi7T9yBKl1ej5aRELTpoEFyQOyYQ
         LCw+13yLfm0EghIcSzd/FYOUxgqxC2L3OXNOx2qdEFUuu2nDr54U/LzsQ1rgLhUZEm71
         N62Wp4RsWqOJ3bogGxTbHKSCVLfANlKVyWUOIBfU+if/EEZdNBi5MYqYVWFGVbE7CHcn
         4aIw==
X-Gm-Message-State: AOJu0Yx3L8gMzJv3zZn2czZpGwboqUKH2YlQhq35/HJIZATQQ7aa/nda
	vmbMKuym8sjNazIpnCY0sBOvDdiRmapoRH+CNcHPRwOsJ/l+qJqjNVZjLT1c2hCyf0YucNm/j6F
	ArLbKtqlMMTAUuT+8W3ENuJp++kY=
X-Gm-Gg: ASbGncsfH1t5zNAg6n1xLP81fxkSuNrXKFS93CKF8d8tBMq5w1K9uywHxMoH2SZO8K0
	/UFv0GS40BLAl5aqGc3LKFpsk9xjchHta2hDfF9sLgXN7BPNCYJCKvCZsIMwUxU4QUXyxev+n98
	X3S6BVFV/JRLQMXA29Uhj5GGEZVZ01m3khjg0XnMwiJ/lwmMiC9p7fDg==
X-Google-Smtp-Source: AGHT+IEnLO5bHBzP33wdfVOccrX73F7RpIroIvJsu+kJEEIglAYoApcZ6ErhoFC+xmhRawLZeTEkt4EXrMSeKIw7+94=
X-Received: by 2002:a17:907:944a:b0:ad1:8de4:358 with SMTP id
 a640c23a62f3a-ad1d35bfbdbmr195832766b.61.1746517268177; Tue, 06 May 2025
 00:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im> <20250505-pks-maintenance-missing-tasks-v4-5-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-5-141f4df906a1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 09:40:55 +0200
X-Gm-Features: ATxdqUFhsVXTmqgtSM1ilo-7Sm6uXfVIehdepu7UlWa6BgnhYN9WWVK27K6-BWw
Message-ID: <CAP8UFD2cuMxdpGFuBoKirw2mko6gt-djndqqZy92NypPiiFCYQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] builtin/maintenance: introduce "worktree-prune" task
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> +static int worktree_prune_condition(struct gc_config *cfg)
> +{
> +       struct strvec worktrees =3D STRVEC_INIT;
> +       struct strbuf reason =3D STRBUF_INIT;
> +       timestamp_t expiry_date;
> +       int should_prune =3D 0;
> +       int limit =3D 1;
> +
> +       git_config_get_int("maintenance.worktree-prune.auto", &limit);
> +       if (limit <=3D 0) {
> +               should_prune =3D limit < 0;
> +               goto out;
> +       }
> +
> +       if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) =
||
> +           get_worktree_names(the_repository, &worktrees) < 0)
> +               goto out;
> +
> +       for (size_t i =3D 0; i < worktrees.nr; i++) {
> +               char *wtpath;
> +
> +               strbuf_reset(&reason);
> +               if (should_prune_worktree(worktrees.v[i], &reason, &wtpat=
h, expiry_date)) {
> +                       limit--;
> +
> +                       if (!limit) {
> +                               should_prune =3D 1;
> +                               goto out;

Eric noticed in a previous round that wtpath is leaked in this `goto
out` path, and it seems to me that it's still the case.

> +                       }
> +               }
> +               free(wtpath);
> +       }
> +
> +out:
> +       strvec_clear(&worktrees);
> +       strbuf_release(&reason);
> +       return should_prune;
> +}
