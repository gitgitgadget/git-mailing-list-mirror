Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749F477E21
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629484; cv=pass; b=mSqmmOOXNy3JfTka2j3k88PdYkgLfKewDcmS5VPgn+GUw7CqLrEso07KdspfI2m07AsfKIb1CQole+7UaRVQgrBjY9romBDbt5Eb/QuG1Y69dxRz//BZwsmixF7ks8tYX2VdTOV03N3+MP83AafyGAwVFs0MGf0/LTsA9DIJzNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629484; c=relaxed/simple;
	bh=X9L08voO5wJzoDA5+5Yz5FMQJFIOFPDmru5utUBdgww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUsMtvKUJ/NTeRdpWPagpXmtKW2kLJ20LnMe9a1PwfGIj4TSiv/2AoUeeh6VV40dP/HX+Zi4qKv3i+Jln1cyczVxGQ6UN1rePYFBaX8690mSYMWz9LlzPhVvus8A7pp4Jn2AyBBujCfdf0cQ2c+gl0eocd9BnIMsKthWHUMnYz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OasLLty+; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OasLLty+"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa612bf6efso4518743e87.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 10:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781629481; cv=none;
        d=google.com; s=arc-20240605;
        b=ig3zq2M5i1wnBak5coGe9CQztAWsBzyPMZdmIrXjpV485TjqXlHsjVqBsGBIElfdmY
         vTA1xu4vb4XZvXGwY7BUOLQYi5EtYDBCRuOVloYrM04RwvOL7X48Kk9oxHj/iEUfl9Hh
         K/ttuUkQ/7iQSAqGCJTDIAkSEp3CXULItnIhkhtpbsguTnqTTZy6HA7m1kcqVyrG+5ZG
         9nqcpL0FPUjukiTY3WksgGLCj7+IDK3KlHy7+82fogrZv3jlW6XHU+dOTrpCcXgqkxSH
         w76MOmu6naep0y/3MG/uqbzBNMZvMhSaPMMkCwbgtUYrGw9tgSahYGLz4LcMRluAW8XO
         UMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=47FmjIZiBojxfp3EXlGo83yKW2yheVN4+8VRuXNWGYs=;
        fh=eGypF2dcyQk/+4iDL6ZZ3Fg4Ns4uMV35Nh4/ll19jyU=;
        b=VaGTS6ruwIZVnLzQRr8kBA4Tgk0pTn+zT7m01sIt/JSyDn2yfiOhE+6CqxUqZGIIX9
         NPiH9GQUycEHprDm0KMHfAbQevAEYUO+bs0JVQTWa5+OHhR1QqSyUAE629fwnvoAktqX
         EUrTJjlY+lh15B4CCrYFkoJgJmDjJbK6vqpfxtBT7FeDIYMmHwFuTpBNY7BVx67dcgaE
         6CYCV61PpAJcnxy0FmNC3lTf6JCPfuJXsrR3DdYF72GyAdKgrDrGNuykLVRRbKT/L/hW
         9wgrH6xN+3OM9FGus27a0wZg/xkv+4yr+IPLyt7a8l0S9vHVn002/ZGXsdZU+8bSj8Vl
         VCcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781629481; x=1782234281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47FmjIZiBojxfp3EXlGo83yKW2yheVN4+8VRuXNWGYs=;
        b=OasLLty+7H1qGXpK6TpTMoV+PirWo0YxWueGgBXxc4tvoJjIJnlpiSl3cFZxN2pyCd
         Ro+bqmqKSQ9jAPPQW410j1eD8FG9yBXAN16yb8TzvPY8YFAm8LVE7soqRarCrrmGB59+
         qRuR1w4kwqNRDyI5kWB+Wx7pqjdNY12mBrhmf1JfQP0jpBZqDD8B78a5niyCAEEyyUXJ
         2SIW1oWMCVzI/jLXznV7WQ/wiF5tbx7bplB5Hd5qr9E4pNsJe2pkNvZzuazyBrihgaxf
         rKALL0/5M0sDjhY5qnk3rK4n4KAdpYHRow6oNEUSe+/MYEYW3+tUvXP/Vn5M6oOnwiuH
         lkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629481; x=1782234281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47FmjIZiBojxfp3EXlGo83yKW2yheVN4+8VRuXNWGYs=;
        b=hOgSsnNUb5v5OH/q3eqj9U2Cnuak3GZRVGd1CZJl8NvzCfypzem7xzyWCOwtvSrJvg
         wlgR6GX3Tt+8nlTbnE+Sb0NnnccYNqkYFQor07z6pqCtwcbPaVqHghOXOsexm75lkwX/
         +exCEaxaJBpiw23OKvSqGftbabwNBafKkAfSMQVdSh8RpAfqkM7tkYU5Ci4NUsT4Emrr
         E/ahQ8h5PwUMQDvEcnlrHymLI2mkX/QcQwIFJSK2QgggT5oLAMe2QIjrGeHV33LE/v8s
         PP72amr98/2etToEm2HyT+IoFknY1Ds4tndJTEn0+6sgBOq+ewLtQI1El8Rh9k4nv3OV
         F9dA==
X-Gm-Message-State: AOJu0YzCc1OhRsuUkm/18AZwJz4iGL2Bs0i2Por5yAclbwbxZoXH3PLL
	c/mWR5t8iu7bCKkqBATeToXdY4/wbbEJygJkRvLfDDK8KN5uSVnxOODi4y+54fhaU1CL2q0r2yi
	+sgYHDThW89ahyRUlGa4/FRWhE5biBbw=
X-Gm-Gg: Acq92OGCEForF7+KWmLYZ3zZF8RpL9C0eITFliigR93WcU+d9hxtq9K5xY63s1l5fc5
	926NAzs0j0pjC8t7H55VGNIjxPCWkw/2YNLM9tkjW3S2WjKLk2RefD4TysQuJy9YahlAQpQK/GF
	uEDZoazoCZrg4g8mai9A3h5pZu+nVmQOriTZ8GIHHYDNnD+OKzclUUxXmH925m9BZdK3c9aOMDt
	tauEZNBQAUARx+dfk6nwyfb0sasvNtmy3hP7XrF8hCanXEtGIZTeFE/9LsGt+/d7ObzdWApIFPC
	2Gy2Oik+I5rGnuEH7tqcEP8kRdJt6ya5YjScNPY7EYSsThFXlEoVtre6cFWSb8Bjy8Gz5lxELJ3
	hrkaUMVZWyGqk42/4bUwhXBPsiYi8GoM9Kzgz
X-Received: by 2002:ac2:5392:0:b0:5aa:70c6:4d0 with SMTP id
 2adb3069b0e04-5ad46fbc8a0mr74940e87.2.1781629480637; Tue, 16 Jun 2026
 10:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-3-jayatheerthkulkarni2005@gmail.com> <0077b1ae-3c85-4b34-a0ac-766395157c4f@gmail.com>
In-Reply-To: <0077b1ae-3c85-4b34-a0ac-766395157c4f@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 16 Jun 2026 22:34:28 +0530
X-Gm-Features: AVVi8CeOrvwBVxd6Jn68jnkvgEPkcH3cRYwdE27L6YmqRdhHuSqJ5YapucwOm-w
Message-ID: <CA+rGoLfhhRNrSReeJ1grhy+2K3BSrikTCNgGpCaGqc4fFp3Lfg@mail.gmail.com>
Subject: Re: [GSoC Patch v5 2/4] rev-parse: use append_formatted_path() for
 path formatting
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net, 
	kumarayushjha123@gmail.com, a3205153416@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,
Thanks for taking a look!

> On 16/06/2026 05:49, K Jayatheerth wrote:
> > The path-formatting logic in builtin/rev-parse.c is tightly coupled
> > to that command and writes directly to stdout, making it impossible
> > for other builtins to reuse.
> >
> > Extract the core algorithm into append_formatted_path() in path.c
> > and expose a path_format enum in path.h so that any builtin can
> > format paths consistently without duplicating logic.
>
> Sorry I haven't had time to look at this series recently, it is looking
> much nicer now that we have a single enum. It would be helpful to
> explain why we need PATH_FORMAT_DEFAULT that acts exactly like
> PATH_FORMAT_UNMODIFIED. Looking at the next patch it seems this is still
> a wart in the api due to rev-parse wanting needing to distinguish the
> unmodified case from the default case.
t);
> > +
> >   # ifdef USE_THE_REPOSITORY_VARIABLE
> >   #  include "strbuf.h"
> >   #  include "repository.h"
>


> >   int cmd_rev_parse(int argc,
> > @@ -717,7 +661,7 @@ int cmd_rev_parse(int argc,
> >       const char *name =3D NULL;
> >       struct strbuf buf =3D STRBUF_INIT;
> >       int seen_end_of_options =3D 0;
> > -     enum format_type format =3D FORMAT_DEFAULT;
> > +     enum path_format arg_path_format =3D PATH_FORMAT_DEFAULT;
>
> This is the source of the api wart I referred to in the previous patch.
> Could we keep the existing enums and convert them into the appropriate
> PATH_FORMAT_* flag in print_path() above? I think we already have the
> logic to do that in the existing code. That would mean that other users
> of append_formatted_path() don't have to worry about the extra flag.
>

That is a much more elegant solution than the current one.

For v6, I will clean this up by keeping the fallback logic
localized within builtin/rev-parse.c and removing
PATH_FORMAT_DEFAULT entirely from enum path_format in path.h.

Instead, I'll re-introduce a small local enum (e.g., enum
rev_parse_format) inside rev-parse.c to handle the
command-line parsing state (tracking whether the user
explicitly provided a flag or if we are still in a
neutral/default state).

As you said, most of the logic is already present. In
print_path(), we will check that local tracking enum. If it=E2=80=99s
set to the local default, we can map it directly to the
path-specific def_format before invoking append_formatted_path().
This ensures other users of the function don't have to worry
about the extra flag.

I will send out the v6 series with these fixes shortly.

Regards,
- K Jayatheerth
