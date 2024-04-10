Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B769947A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720250; cv=none; b=uYZty63aYov7UiHohTjSU/z9aVuwsTIzr1pnuFpmpIgSYn25thvly1VRHXlMvjHpMOstqJ2jfFaOGJukrI0IXRss4M7yOjxmS+5fNPwhn1yIRWJo5PmIgywdKwyo3fBeARlGwWu5uSvFYSje7ZjLPtGaJXSYdj2KmV908Yu4/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720250; c=relaxed/simple;
	bh=LYy2tIxMGvHyZbphjZW09vMHkK4nkJiLQB5LX0KS+QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHV/yGVSv0xqL1edJugtYY3z2use1aWXuRsXaH9Khz3aYNyhJIAAUBAZdlMSmh+eHMCIfXIsicXTb84DvIwhP+ZJaHYtR/QIJw3MZXKSHd8rqR1URUr0Z/BrnVKAvqO1cZqgPxg5K1C5ca0RdYicVXNTMjmLp7f9pUFikz1DOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6963c0c507eso63415966d6.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 20:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712720247; x=1713325047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38UnRdunSzfmKnJSEZFrycacH0r6XfxdaP0Fbx9v8Po=;
        b=pybVCHiZQw6Sfi8IqmkDPVk9hyH5J1SutQvpce2Ocs/Tqo3PhXaItAQY4jt8AocaHj
         odhnPk1cw8YjOTDAoeN7HfmpPYEPgy5/mVHZLJ3l6cCLQCYpe4J5za765FAlJFRiriut
         pimhvNhgKsHPpNjXxk06r8zCBN6bpLnvKCXtHrAwvNjGKDNAwoFki1jgG/12Dk9R1VYr
         0+r7cUkPaM+sB/HSYo1jDM3fhj3Qv7MIPAdhWo7Tpv53f36jp8q0WJUzkv4qXyYok8+o
         XRc05sNL3pXhENOXeIiexNf/MWsBHVISsmlz7rx6Mm/Scinhii6RXEixeoqKM/DbLf3Z
         mTaQ==
X-Gm-Message-State: AOJu0YyEgBtAoEkAEMvI3WzuFWGjH406Ed5dG3NDua/ceHKTrzGPK/ll
	eV66GqABXYrPrwCP6tqdyfohcIcWK+E5RBl5kmkftajwhYpOAR9EEeF9WdDrXmmxqAz/xUmP+p4
	wru1rGtWk79Xl++D5kLQam31UcQo=
X-Google-Smtp-Source: AGHT+IEOc5xH6pk1IavmsgJN1fqQwAF9B3X/546bIQjPu7CF07WbqFv+3uu3hAO4/MV6VxvRp1MChfWsfjsnbwDtc8M=
X-Received: by 2002:a0c:f70c:0:b0:69b:1f52:249c with SMTP id
 w12-20020a0cf70c000000b0069b1f52249cmr6443775qvn.25.1712720247489; Tue, 09
 Apr 2024 20:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <20240410032812.30476-1-congdanhqx@gmail.com>
In-Reply-To: <20240410032812.30476-1-congdanhqx@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Apr 2024 23:37:16 -0400
Message-ID: <CAPig+cQ5MWXxwOvTWYthKXbzPa_SVZX6uXZ2ASQkz6Ec8-pitg@mail.gmail.com>
Subject: Re: [PATCH v2] t9604: Fix test for musl libc and new Debian
To: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:28=E2=80=AFPM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4=
ng Danh
<congdanhqx@gmail.com> wrote:
> CST6CDT and the like are POSIX timezone, with no rule for transition.
> And POSIX doesn't enforce how to interpret the rule if it's omited.
> Some libc (e.g. glibc) resorted back to IANA (formerly Olson) db rules
> for those timezones.  Some libc (e.g. FreeBSD) uses a fixed rule.
> Other libc (e.g. musl) interpret that as no transition at all [1].
>
> In addition, distributions (notoriously Debian-derived, which uses IANA
> db for CST6CDT and the like) started to split "legacy" timezones
> like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
> by default [2].
>
> In those cases, t9604 will run into failure.
>
> Let's switch to POSIX timezone with rules to change timezone.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
> diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestam=
ps.sh
> @@ -3,11 +3,28 @@
> +test_expect_success PERL,POSIX_TIMEZONE 'check timestamps are UTC' '
>
> -       TZ=3DCST6CDT git cvsimport -p"-x" -C module-1 module &&
> +       TZ=3DCST6CDT,M4.1.0,M10.5.0 \
> +       git cvsimport -p"-x" -C module-1 module &&
>         git cvsimport -p"-x" -C module-1 module &&

Is this duplicated `git cvsimport` invocation intentional?
