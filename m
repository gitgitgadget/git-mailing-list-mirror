Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B425F963
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833848; cv=none; b=gq5MNcf609nJE2TLIMlDH4d40xN/JrGPc5unpQVv/tdTftdOxcJ9iHoJD+9Fi3TdAl+J5Laod/UEO8JysBNDcWNOS2diEcQrVM/i2ZtKKy/uh2+Q33v+gmUEw73MEUUuQL1huoNGeQIiDPLR82f527uSwcN/Ur4QA7p/+DHNlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833848; c=relaxed/simple;
	bh=XsIac6AClw776QBMJopqn15hCRnBUmqkMyOjYxieoZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS1AT9XYEEOGEbEne9EcAqkawnaxFmm3zp2BfqAMPGFKl/vu8C13y+1/H6JbTAw+IBHeyTbD6zPVqTo1NK4M3/hWDbnznO5qzosdz9W2xb5MLLMHfaIDE9U/pRqwXq1S9w5EEfySwfdOjuIoJCj6ICBaaqFAUMvMsAvmVjqEew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2GBR77s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2GBR77s"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601ed5e97e9so6061083a12.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747833844; x=1748438644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/haAzLalLv6tEpGHojFvzGkGIkihBl+u0dooXaUTYBA=;
        b=B2GBR77sAB6MPqyAWr+ggVZDSX4xDvwOfeiQzVsNQpvlU8eX5dL8HjHmpoNIlFNlB7
         G8LxalXlXQMpj+XY83dKgLmXs5KTiIrkH9Gurt+pOS7abkc/+mp2PaYS3hFOavMyX/5c
         9B5SnuniKun8LfIKkl3PJwxHxXwbJCOlu4nK2TsaWZdDV3hIu0bz/y+eOeONTS1peCDg
         Bkv2IvRNV2CLTpBaNelrFWXer4hJVeyCyPNTBD0940qqL8C5Jf54eyo6gdyEbpvYh+ZF
         t/9ssTGEt4G6Kx08VF0MCrzn+0fsPv9oZLpHTZ6epJA6xDCzpbfkPY3l5RV7B3v7wZQ6
         2ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833844; x=1748438644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/haAzLalLv6tEpGHojFvzGkGIkihBl+u0dooXaUTYBA=;
        b=wSN/eGgDv+w5ESw9ZUWwZIWaAqzh78oY1aeAx5TVLngpDxWhEu6+lvSvEZuehl9xnM
         H439aXL24qh6xkW7cuKoLXRaYmcCPOqyAMAV9POEjcTDq6IJPL+AXvj24JLD4DcJCV9t
         Gt9fQmnGZRGfjnqytHX/AQ8nKidVw5pKOwLWCklzdzpH/3IE9oagcXezEuM+X7eUCy2z
         qlDl3gevqK8E9IrLqk832fBrVTQPKN4D3UCCFTx/efVLlSvvflNSXNZwHOQk0UaxZJkV
         IrCZo8m/sfr/8/Rko4BMZ5ztnFK2/DxIowtcKKluma4yeJ1Wri5vYF6mzD6qgT7Zieww
         gmDw==
X-Gm-Message-State: AOJu0Yz6ukTsNJfx/EDIXZSMmVy8HKAzx++UNULNH1y8rHgtGdckxNrW
	colxJISGTdfe+mwDFqvTRX6pVjs+hVjQGsTiJpbUMXrDXxywzWftROxajsaUZ4/1h/P2RId11LG
	n9hn1hxPyXOnJIOXFS5WQMQje1iP1eNy3vnF4
X-Gm-Gg: ASbGncu4rdVrsO25phbMTF0d+gOnwkBnNzJmH9JKn0mC2GT5YmHxD//7j4FQXB49grl
	5neXWXoJQpMXpvsYo28EMSL/4w+KVV/7yI521BaLS2x9Dm9UuJ1g93jFPTXdNf421A7+n8DyegZ
	Ds03SYmqpeIKXU4/jLsJmTc+2VSU2bjG8C/pKS8sKrPIqJ3bhpbvVVjKoGVkxYhDGA+Pg=
X-Google-Smtp-Source: AGHT+IHP1myGfGR+ONoXL++9prh1By0KGhVIQ4KXGm8194RTRIr38Fk/Vdlnum37Fjpmr5w4mWdPCb6NomTu3tAKlLE=
X-Received: by 2002:a17:907:3f17:b0:ad5:a116:ec19 with SMTP id
 a640c23a62f3a-ad5a116edb8mr415495966b.4.1747833843853; Wed, 21 May 2025
 06:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-2-ben.knoble+github@gmail.com> <aC2HI4sMF3t8K4Jv@pks.im>
In-Reply-To: <aC2HI4sMF3t8K4Jv@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 21 May 2025 09:23:48 -0400
X-Gm-Features: AX0GCFu3TTNu3Nl-eW607ZyOz60hreoy22rcaHdqsaZFMdf6j-jCEhbjcqVBoWM
Message-ID: <CALnO6CAer5sZM9qr4G6KsdCEmw6SVEZgp0pdipq72SHvfDsk4A@mail.gmail.com>
Subject: Re: [PATCH 1/4] t7005: sanitize test environment for subsequent tests
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, May 20, 2025 at 03:34:55PM -0400, D. Ben Knoble wrote:
> > Some of the editor tests manipulate the environment or config in ways
> > that affect future tests (because they test a sequence of overrides),
> > but those modifications are visible to future tests and create a footgu=
n
> > for them. Use test_config and undo environment modifications once
> > finished.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> >  t/t7005-editor.sh | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> > index 5fcf281dfb..06fa1ecd91 100755
> > --- a/t/t7005-editor.sh
> > +++ b/t/t7005-editor.sh
> > @@ -111,6 +111,8 @@
> >       '
> >  done
> >
> > +unset EDITOR VISUAL GIT_EDITOR
> > +git config --unset-all core.editor
> >  test_expect_success 'editor with a space' '
> >       echo "echo space >\"\$1\"" >"e space.sh" &&
> >       chmod a+x "e space.sh" &&
>
> Could we maybe adapt the tests that set those envvars to use a
> `test_when_finished`? Something like this (untested) patch:
>
> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index 5fcf281dfbf..a14ff4b38c4 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -93,17 +93,19 @@ unset EDITOR VISUAL GIT_EDITOR
>  git config --unset-all core.editor
>  for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>  do
> -       echo "Edited by $i" >expect
> -       case "$i" in
> -       core_editor)
> -               git config core.editor ./e-core_editor.sh
> -               ;;
> -       [A-Z]*)
> -               eval "$i=3D./e-$i.sh"
> -               export $i
> -               ;;
> -       esac
>         test_expect_success "Using $i (override)" '
> +               echo "Edited by $i" >expect &&
> +               case "$i" in
> +               core_editor)
> +                       test_config core.editor ./e-core_editor.sh
> +                       ;;
> +               [A-Z]*)
> +                       test_when_finished "unset $i" &&
> +                       eval "$i=3D./e-$i.sh" &&
> +                       export $i
> +                       ;;
> +               esac &&
> +
>                 git --exec-path=3D. commit --amend &&
>                 git show -s --pretty=3Doneline |
>                 sed -e "s/^[0-9a-f]* //" >actual &&

Thanks for the demo; I considered pushing the test inside the loop,
but I assumed (perhaps wrongly?) that the `export` needed to be
_outside_ the test script in order to correctly test the sequence of
overrides.

Thoughts?

>
>
> > @@ -119,13 +121,10 @@
> >
> >  '
> >
> > -unset GIT_EDITOR
> >  test_expect_success 'core.editor with a space' '
> > -
> > -     git config core.editor \"./e\ space.sh\" &&
> > +     test_config core.editor \"./e\ space.sh\" &&
> >       git commit --amend &&
> >       test space =3D "$(git show -s --pretty=3Dformat:%s)"
> > -
> >  '
>
> This hunk looks good to me.
>
> Patrick
