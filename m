Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392522689C
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157110; cv=pass; b=pk3Wp8xac9gf9MLtolLSxHC7E1Q4xe3hgQ8Q16pEDD8TNvP8AGtXFZS/lNV4Nmgj/F0UPei/MHBhNx6dhcX/dTzEzQ9NkdbIWORsBGVT5eonZBDC+egq7Ns7I+zmrMzqFJl/S5hvqVQbYYNKbWOjnbVe2tP7SLc8pskWTrp66qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157110; c=relaxed/simple;
	bh=IVvHLfWGHz4lmijPQzv5U8Fn3SPX3vDs8/8qQdgWn3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pG2EtwMhkQgxvlGO3Xc1XOXpH4X77/47fn3LJED5d2OopdaKTmSr47RgKBUh4ghBdzw8hayhiqWGvYUzUCKj0Wd8xARw9jKFfhIV8lIQPDa01nP6lWFucsuyqDiJA8Up/7lW25p5FSFY01NQeyULHLNdHtYfUQX+1Zex+cfpk14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a2ad3a456so1581356d6.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:11:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766157108; cv=none;
        d=google.com; s=arc-20240605;
        b=QXJs6/HhSAtr2RNgvE2CqANaulesSvMvskC8Ks4xO0rA4xSU78X887mBJprfK5hkHI
         aQhvc1Nwl2Q8KZUkwB0y9y77FJcRUOC0gdeW9AIhCRV3VJHcqIaO9ERmCFEIvubfyg5G
         ToyDJ7FwM+nywfYBvPVsKRHmsk0oJ/UPMu/umy5fFCzkGdBQtc2ciBD0qvKhnEA17xME
         naZyubzwBq1DDYEJ4n7rtEppb1RdMe0+IQUKbx0M7F6CPWmr5s91HDGIMJeUnnfzsi3+
         h+M/9gjGqjZ2FChllPOMsDvfauzaWFrf9os2h2fBe8hKHTMVN5H0ItHTk2dvXm/7X/K2
         j3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Lz152JZP53qpzMavEfqhq+rvsPZUtmZ+Ge53Z0uAT5w=;
        fh=D6OvNID0dZHG2kn7+Sht5RAr72s3bxcZr0mI+UFw7rQ=;
        b=OEleSjgjKTf47oTzDtrfGXKZ2dQAF+JhdTCeFc5945zA7N+kshXapEdV38jOIPvQrj
         N47x5Lpvh+84KXSYcsAz8cUaEVGTqId1kTJLNye0wztcOAPLkdaeuEUKQD6rRoqgIdfl
         g4yyGtD4C8Tus3Kji4Wrr3I25t88mLVyJZf+QoKCpU9LohDglE3SAPJwPHTbacTMWTYF
         ALLXinM1XW37DlomaBIZNt1Uk+Pch91bXBtFrt7he0LHndecEX48bStsuOFD5TW8KV2V
         oe3NGBN3h6BI6bc45USLSQ7u3F1BjqANSZCsphiFyVtFFKoahDFbGCITfxN7kXyMwdaa
         ztLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157108; x=1766761908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lz152JZP53qpzMavEfqhq+rvsPZUtmZ+Ge53Z0uAT5w=;
        b=hCNIUk483KkqACOI3Z83mc7VDaJfKLgdUHsgG5hgUgSC35c4mEcL3rkIJNRCm3+wVE
         KH6P/VHg8T7+mne7f9fg3Ks9kXLQ18d9x257AwZDc65UP3o8KTJ54hZE4eQ6wjtGUFLy
         7IhXGY6iiOUoiDK/IqS4SUkDQZsj6Xw+Bsa9m4TH322LTTx9KR8QTCVB6M1ZD0J3ey27
         +YqwBZOSG5HDcCjpfV5WYA9YGU1NlkcldJM/1RNZ5MPiBTbprfRrwIsf/bcwnntTA4zn
         zknM6JKAbc7h/2hOMaWlb+vdAygECj2O0Pw6fFuMQLAlbBeSY3MDtMz5+tuZeFBLEFDg
         kDPg==
X-Gm-Message-State: AOJu0Yx8z4SXY7PHZAhllxTMTA5UgUHtfqRrG9VJgLjWojvEVHKnjupa
	JsjDxTN/54X2lNVH0iYUVURLy9brnpJE8mn1RNb8kYLvw28pip0bTlfQ2/ZsZIm1gzQFUvdRXdS
	5ybSAAsUdDUOr4Cu1cTdrjemUrf7WDo4=
X-Gm-Gg: AY/fxX7ajflyVAm6O6IeZPoF1I2HxlRq3HmYQeLVRDRa1o73/wzzusUqMc56/RPm1oe
	SDJ2m6+YK4kU9mn18lNqycCnqyce/wwUUu9LDyv+ZWAICPNiktkJxY3CY0aBejicB94MGJBPZGp
	WIrgz8qRl4/ye06dWHfzcvynt6zNO2tX0rx4uzZSgJcxE+9zc/cHcbiJa3TwXDbx8Bejl552EkZ
	rVa1B1WjW+1sUpnINEqfY6jE4ibSzdoKW0icHD7pnfcypiK2gt1ebjqiv0q6XtlW6H862FuZhWe
	D6MeEHQsfp+d7DeJgehrqGNJuVkX
X-Google-Smtp-Source: AGHT+IHLMyYJJCkM8suEW/SYUQEaeSX4khQp87U6pobIgVy6U0u+attEXsn8iAA108nlrptw6cXy+TeH7lNhqblPoJA=
X-Received: by 2002:a05:6214:20ab:b0:880:4f00:73ae with SMTP id
 6a1803df08f44-88d856d5f1bmr39116296d6.2.1766157107800; Fri, 19 Dec 2025
 07:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 19 Dec 2025 10:11:36 -0500
X-Gm-Features: AQt7F2ot877CmSxZyOK-X0hetU-OKfux4qYdnfUoUcjEDZ9jYibB_ZAUEaRrj8M
Message-ID: <CAPig+cTC8ROsf-cOhUcxovUOcQ47As496SAm7FcEFnzGChhLww@mail.gmail.com>
Subject: Re: [PATCH] worktree: clarify --expire applies to missing worktrees
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam Bostock <sam.bostock@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:01=E2=80=AFAM Sam Bostock via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The `--expire` option for `git worktree list` and `git worktree prune`
> only affects worktrees whose working directory path no longer exists.
> The help text did not make this clear, and the documentation
> inconsistently used "unused" for prune but "missing" for list.
>
> This updates the help text and documentation to consistently describe
> these as "missing worktrees".
>
> Signed-off-by: Sam Bostock <sam@sambostock.ca>
> ---

This change makes sense to me; it certainly helps clarify the meaning.
One or two comments (below)...

> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree=
.adoc
> @@ -271,7 +271,7 @@ mismatch, even if the links are correct.
>  `--expire <time>`::
> -       With `prune`, only expire unused worktrees older than _<time>_.
> +       With `prune`, only expire missing worktrees older than _<time>_.

Rather than saying that this "expires", I wonder if it would be even
clearer to say that it prunes or removes information about missing
worktrees. Something like:

    With `prune`, only prune missing worktrees if older than _<time>_.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -252,7 +252,7 @@ static int prune(int ac, const char **av, const char =
*prefix,
>                 OPT_EXPIRY_DATE(0, "expire", &expire,
> -                               N_("expire working trees older than <time=
>")),
> +                               N_("expire missing working trees older th=
an <time>")),

Same comment:

    N_("prune missing working trees older than <time>")),

> @@ -1070,7 +1070,7 @@ static int list(int ac, const char **av, const char=
 *prefix,
>                 OPT_EXPIRY_DATE(0, "expire", &expire,
> -                               N_("add 'prunable' annotation to worktree=
s older than <time>")),
> +                               N_("add 'prunable' annotation to missing =
worktrees older than <time>")),

This one is fine as-is (with your change applied).
