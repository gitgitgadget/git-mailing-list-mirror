Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A13207
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729314060; cv=none; b=YswQxPlsCeT0XQ/CAnYavG3w0pYT3GQB8Pz9j+XFqleV+eYfp512tBAhSqbGL+Z8xoDnxpzWutd08KqfWZxQGnHmTbknOXy9emkOPMfFW8QVnuqQ/oYBq+dkCuICyVwZ1RSOYhsEfdbJw4x1oTJBRAFdHo1N6Es7BqLObHDvCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729314060; c=relaxed/simple;
	bh=sZknpXWlE8vpuX4w4vWG6mhy7iSuGeEc5EKBdAh2yRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsBQX27URSb3gGpr/TsnQIzzlLK9jIywmjTO5xrllQkT7i7SSYUeu2u0Lthd6YimZ8avh2XCATwYJhfFSZlCkOe5IEuZ8IVjOafwwxC1WtwHm/xZGkvT6zouHCJ8c+ST/QHSHMr1+1ausoGChz1Lum2JMacgHb1eDHo+nFWJpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbf3f7272eso4752376d6.3
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 22:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729314057; x=1729918857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsMZA5Cv91FU88/Q6DR4Ubi5mOQ3AoX2L7oBJMfbYSw=;
        b=rl2c9++IBaVPAwTigVCOcARcEfezD7aCDZ2OdkPOuN9WBvzt0hisXDvpY8Ko15Q6AS
         UVL7e2/fPm49+IKg05O2bR0fqjOC3+waAdQ+dZiQ9ugk7xSHU44gvGwfZTGpI8sjC4v4
         cOlTOFrHCwyt0vM592x1pp6VrKGt97BItRJ6cdw7AtGlTYi3r+htoOIAS8h95TeYqB1k
         u5/aAf+e13XKjBQiRGO9NwZnOw/tpW/RuZFTNKBxRI1bpjz1Gd1ycIQJXLcKS8VPQs6D
         zCeoi3W3MyOgb3LuJUD8FUWh/PyoZ8fg4Qi4f6UjhiGO0FruNmdqQqAA13ddbl+jMOqs
         kpPw==
X-Gm-Message-State: AOJu0YxzpC+1pD8ispuEpzrVBrarK0DrboFOdgThzG9FPky5CsTM8Dkg
	4oHARfqrtR+6hZ7u72ZrDezw+IVEXF215wGtqJ7a2O++yHA35Gomq82AnABt8QRD1uSTOMFNDbB
	NAlVe5FfRbcdNxUh7ernuIjgJ74Y=
X-Google-Smtp-Source: AGHT+IGjFWF9vdSdTU1wELsk6DVPRxk4l6KoHon4XW0m7ykmz4tni+JtiMhjaTH5wtu9akOUDd/K94eXFUJPx4rZu9s=
X-Received: by 2002:a05:6214:4003:b0:6cb:4a88:8cf5 with SMTP id
 6a1803df08f44-6cde14f83d7mr29691606d6.2.1729314057166; Fri, 18 Oct 2024
 22:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im> <800fb080f45f48e248e1ed9c7b3e40cdfc526115.1729254070.git.ps@pks.im>
In-Reply-To: <800fb080f45f48e248e1ed9c7b3e40cdfc526115.1729254070.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 19 Oct 2024 01:00:46 -0400
Message-ID: <CAPig+cR2QXmgFEpaQrvsAF1jV8nZavFjYQkMXp5zaYVER2CiSg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/15] Makefile: use common template for GIT-BUILD-OPTIONS
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 8:23=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Introduce a new "GIT-BUILD-OPTIONS.in" template to address this issue.
> This has multiple advantages:
> [...]
>   - Some build systems complain when not all variables could be
>     substituted, alerting us of mismatches. Others don't, but if we
>     forgot to substitute such variables we now have a bogus string that
>     will likely cause our tests to fail, if they have any meaning in the
>     first place.

Regarding the above...

> +       @sed \
> +               -e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
> +               -e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
> +               [...]
> +               GIT-BUILD-OPTIONS.in >$@+
>         @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; f=
i
>         @if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi

... can't we `grep` whether any unsubstituted variables remain in $@+
and complain if they do?
