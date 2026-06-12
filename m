Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A5357CE0
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250218; cv=pass; b=h2yofwLb0nZpXBRKO2/Oc4lPhVjqzDhDlyfZrk/u+doALJ2b+6CqL83Eu+AEZZ+irbPtzELRMBT5WBl5WsG8seYogHJ+hv6FSRHVVZiLeKkJ/snp35fcg50PPpxD6AUbDY8wWOJNFFTo5sRSqyxGRn0SQ6AzIoIUSACXfNkYO1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250218; c=relaxed/simple;
	bh=HzU52MN/pY1hc3RC0svNeFXvEQ0dWCNsMBPcBGCBmes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDu2cGLLIt/G7UhHCV+QYn8a1HrZRFQCrj30caLvcrHosDs1dENW1Uag6XpunwmKHxzqc2GX3hRHq6BFidKmudK7CSi18aHKu7SyL5fmKzBi4DrF9cVDm5qeg0yBmWYdjLP/Da7N8iJjigRUKJN2F2Wa8Bv6UVTxduF1MCpqanQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAlvS/a5; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAlvS/a5"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137d464c47eso1033205c88.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 00:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250216; cv=none;
        d=google.com; s=arc-20240605;
        b=Uw8iu2/DeLYx0Eg7PHc+yF2QlXDZWsuvWQ75jgVykBuUeqA+w8lr8wb3hs1OmPXcro
         qfLIq56qwIORJYN76P/p5SQpGvRm9Rdx3WqnHUsXyfEweao9tCOR+zo+3+/40VeRjtrU
         irSx/OMltmzR9xIQP6lk3pt34FR4lVh2YPpBBkOAdFK0iZ2rwSy/u4fn2z51YzdBSSef
         j6jkqE1GnysRbv9BIEDvAWjRpETh5CDFyO4+CJHKpgkk7yLrqUBtcROUOjk+puimdZmv
         5gnK6JuTJmN9u1445AE6U99o0435h4PglnT3ATZRhqG0WpwekUZe7f5gEDp9qvDtmHl5
         3tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXu6IiezAhhxIXY1iD3BRua4J/0t2vinS4nst0Vt/NM=;
        fh=hEoqR+K+i2TKfZzeZdxHavFML4oufOJDrrtQSUwGObw=;
        b=SlP1k8IbKcZ/l7UNjrY47+RtXyCjDed53N2LuTGVfRagdijbd1Xp/p//ohSifp/ZTJ
         uH/CTQx6DuGHUz6OBnkhTicr52c8uGCeeCo1Csqrrt+8mX5vZoSPjyZF1F3vg4Dv3AXg
         LcB1x0iy5MITrJU8p3rUhOMXw+kM+RCSWBamKhGC+0kVr2nAv3v7Qfkg9ZMZYMFmOWEr
         eWchg8Rz2/MIKcMD00x0NcnDMz/ZxTzKdqRQ4f+rmXUqkZUyd2VpKBzmoarVnjLd3yzn
         muPCLSKEyLhthOW+EjAwXu/8b3Z0uU3naOD9HmE2gt/+lY2ZdkgpgG8M/681bnNfKYy4
         3K9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250216; x=1781855016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXu6IiezAhhxIXY1iD3BRua4J/0t2vinS4nst0Vt/NM=;
        b=XAlvS/a5DMYNPTHmhdyBzxb0VDjRkD3NIR1xXuyCCKzZe4EgzztIXjEi7ks5pEgw/h
         bVsXNUCnQSs3HK2s6qkm7WchVIS8qn8+TQNvfaiZTbSftrYi/sgJaOkb2W6kB7uvBuni
         vVtXP1hbFaQCM3Irzk6SsBwZFn5wZdHiNlzwn+FovHmQNy/zMh1V8eSKw99viEngU8qF
         Z95O29uQF90fbuTKN6U9NuBrAqkZ438vjE3rewJbf4sG9KOguLWgYr+pBwnYmaCP2vXV
         hN/SUwoncc1IUXeUdEE2sOVVfTw/w77BmmnNixTNlXWvdAiZLgwkKCgw8fxPidne8Jjz
         2udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250216; x=1781855016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VXu6IiezAhhxIXY1iD3BRua4J/0t2vinS4nst0Vt/NM=;
        b=dRRAYwMHwHOp6Bw605ICxMkWtLXRsKdPCm7IDmK8tmNXpRQfcUkSCn3asnD1tyglcu
         3uuv2z8igUOVKeXKZDLTBkHnOGqKzXtGOB7buzw5PW/WTtcVzbaJVQHa0ACNQFh1+Drc
         bS8gkqT+IPlbULHC0TocR5kvnXSt7gDwxeaGimTRDeHxTPmmW4zI1RzrIIEETHz66pcv
         cELJLYURlkaEzNHGKTQVhEUhLs2M0jekIIhBuHzLMLHwQvVy62ZI6L1ld6yYKzMpNQ3x
         VhGk0106Thk/FU8+Tt5D4J2o3hWCS86CUNMW0MoFvZsqFyMNzQ6INArp7a7sOvF0E5xK
         rAPg==
X-Gm-Message-State: AOJu0YxRoxZP2Tqr00AFQsy8ENQ4dAMhw9Eexhpzfu8xOnuKZMYsXPIs
	fKYDelZc+PSsyMZXE4XpL2kRuIkC/uwCrQw8FAqZVtBNyjgq0bsKsVw45E1kHKAj1j7AUadH3Be
	kICd2afo94UOvTooe8fcxcW2J+TYrtc8=
X-Gm-Gg: Acq92OETse3U+boFZ/QnKs3Zrl+DjR64wL3ItPf09oSlo8wKYeOS6Fxb82kTUMAv+JG
	GT/hkeVuB19kkOH7fwiycOu8YqB89b9zt89LUMk54mLfChyhnPCILWykICVSvuAh2Vix2FhF/L+
	xZwCpu1QZKPf1bJRYHsnrrcgMZNsBR310b76AqJsSD2Gs2jjY9PYNPBLrYZ1iJuuly43mv9zctg
	p1gK4QsKdlwdyZFgSnyNyOYFD8QRSjgvB/VdnbbRTbjwK3z8It0j3kJB+A+47iBo7AoBXnkzGA7
	fY+TNa21dItpBbMdDhfp10l1YlqQV2usA7kAOZFp909rt0H5g+Atc3imA7jKuT711Xl/
X-Received: by 2002:a05:7022:21e:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-1384b39a5a8mr947899c88.4.1781250216194; Fri, 12 Jun 2026
 00:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160520.77859-1-cat@malon.dev> <20260610093635.139719-1-cat@malon.dev>
 <20260610093635.139719-3-cat@malon.dev>
In-Reply-To: <20260610093635.139719-3-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Jun 2026 09:43:23 +0200
X-Gm-Features: AVVi8Ceqr-iAOvhi4Do567wio9R1RWnsYJ88eQlD_pOOcHy2V2eXGNWJ2-TwRBw
Message-ID: <CAP8UFD2Y+JO06MLcpk5tXU_MMcPeAxvuiys=ytoqY5vkB1t0xQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:37=E2=80=AFAM Tian Yuchen <cat@malon.dev> wrote:
>
> The ce_mode_from_stat() function is declared as a static inline function
> in 'read-cache.h'. As we want to migrate configuration variables, this
> helper function will need access to corresponding repository-specific
> configuration logic. Move the implementation to 'read-cache.c' to
> cleanly encapsulate its dependencies.
>
> Note that the 'extern int trust_executable_bit, has_symlinks;' line is
> discarded because it's not necessary when the function lives in
> "read-cache.c".
>
> At present, this change has no visible impact, but it is crucial
> for our future plans to pass in the repo context. Comment
> has been added whilst we are at it.

We prefer it when comments like the one below are added in front of
the declaration of the function into the header file ("read-cache.h"
here), rather than the *.c file.

And yeah, I know that "read-cache.h" is a bad example right now
because no function has such a comment there yet.

> +/*
> + * Determine the appropriate index mode for a file based on its stat()
> + * information and the existing cache entry (if any).
> + *
> + * This function handles degradation for filesystems that lack
> + * symlink support or reliable executable bits.
> + */
> +unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned in=
t mode)
> +{
> +       if (!has_symlinks && S_ISREG(mode) &&
> +           ce && S_ISLNK(ce->ce_mode))
> +               return ce->ce_mode;
> +       if (!trust_executable_bit && S_ISREG(mode)) {
> +               if (ce && S_ISREG(ce->ce_mode))
> +                       return ce->ce_mode;
> +               return create_ce_mode(0666);
> +       }
> +       return create_ce_mode(mode);
> +}
