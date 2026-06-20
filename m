Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00182184540
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781971062; cv=pass; b=IT+fbxh8+QaFsJNVMPprmm3K2dddjIzLm5VCEiGYDidBenYaXOI8hyYubXXbzFSpCNzYMcMd1BBn7KGBp0BCeQz8ChdzOJdrYJbL+6i99eecCht7x7jbj0g3EqDL1MKBUpTeUdU5ZjrC6J9QkEKJVxVZZsFqd82BQNeh62Dudek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781971062; c=relaxed/simple;
	bh=kGdsvyexQ4rokLkGVKN50Po6vXd3FBp9G3hS7eEtoPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EW0/2T5F0eCIyjXTcdxFx4/gQZn/ia4D4NljTA/NvEv+oCGtcU+LzHsM4a3MGk0KvyD0lfIczPlgN44ApIAXFXPdP/2DG3cQrczzmyqFFZNcQDMkOVIEcJnXqkc/Yb+l8POxP8jGpUt507PjaAF+T8HWZeobzeDvAutdjYrse/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7/4xbFj; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7/4xbFj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1241779a12.2
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 08:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781971060; cv=none;
        d=google.com; s=arc-20240605;
        b=JWFgqqfwMhEg0j8ABi7baFot47O8F6s8+LpQXRtMU0E4drXu4YLZUN1eO3TXdcdM/O
         8mOYtGzV/Unu16jqePoujVF0yQ7siiDODM/kklZyqg6Q9lSpK4TbxH5W5478NWjzJPUk
         CfuMmEYQrBk53lsmi9m7qLKiW5PW2vfCxLu6r5VmGHXBTD8vRJWAG2fsQsKpNhla5mwL
         CyYwf6sS83MBuGWSGsty2aYi/A2S52XYnPHz96SCt8gVtHtUlAZdKr4JVHjF8YgbFLtp
         jfoV6U9q6OkfF9bKfTMFX9RdpKS6Wujrl54qyKolfPgQthKbJLjQyR9B5IVnWbQURAAZ
         G35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqYan4V6JJp+h9TeqMluQgxKPMwfu0jaaD3a9YooMxI=;
        fh=JXEs40DwwsDIICretIR6AhTxI8iOgnQYnwvLmc7A5fs=;
        b=Iz6QHa/mUfKVFUxfaSsubXzCGmNplbibUIt5J5pZ2fDP0/jsec3qcxC+irjU5zKp4v
         uGk4AL/rjOOFQBdnUsz/9NUz7p4ep5z6y5KCeypqANGeFUGvcHpW4p5wCHpQQMagKrps
         mbLKQOIKHR6LMVDMibiWmR/hc8daBZjwhxFSGZ7nGk5bTp7p3rjn3mKQ2bsF3bCT2JfK
         yjVqjEcnjczTzLtg4JXd7+1JvF4fvtda1RXNx16oGWLcQ92McxD+MTSOrzMnQlkWnfH+
         wO0f/aujqMrqm2Xc9byi2SVFes4DORsaPMlIqI5aXDb7XGy7UDg+5HoIlo3WWqQEVbqM
         pciA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781971060; x=1782575860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqYan4V6JJp+h9TeqMluQgxKPMwfu0jaaD3a9YooMxI=;
        b=Q7/4xbFj94sFsOODIJEkSIvO6BXjw0nKRb32l4s1lLZK4pNqWwJjTFfj5ZlTA5QvZX
         EQmUh9N1vLMoEnL5k4k/n9Dr0ViStW4Rki2C0siHdRz91UApWR8y/nnGNo9KimuIarj9
         ej9KnuIKcVKwmwwOA046xEAckEflUzLKfIoTBz98eA6CiA27e5TbGGKuhlpH+RYvSEA+
         DjyuXcQC5suXGVTBiNIBz0OTM8moMQ3ZzSA8LIpmjjGHCkfdVP1otiquzvIK8TadSka9
         oSjJCj6uN66uGv5XIi4UrJ4PiRPPS4ymaa4ACQYkL6S0H104yeCPESrqyVGYSET7IAtk
         ANqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781971060; x=1782575860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqYan4V6JJp+h9TeqMluQgxKPMwfu0jaaD3a9YooMxI=;
        b=PsN8yxPxAuyA4EIrbxJUVeeYCr9p7nZZgFtP3AEj5qYp1aQy8jJ3yRBx5LUwF0PzzN
         T+g61+kondcqyHqasFUH9g4tUceWm6KqmfJQTld3rVS1BHLDbDef5S3PGu2+QEN+bMWv
         D3WRU0Ufl2jxMROuXkG5NmM3NBGhCyB3pR2bTGN/mrYgjbYaMlG9Ygc874ooHULW9Mj1
         5e+4c8ZkvsYWajuQODNPF/7X40ApIfQ0m0sGvvwp0WvsflfWIh0xzDVsWBaF3wXt80/l
         pw8bWzXV+bR1ogU7jQw/LOl1vTLsp8VvkSuckIVckD426MyxklHKo9Db/oIZ8zWZqt1t
         TlyA==
X-Gm-Message-State: AOJu0YxBLw42THWgvhpvFRwsl5JlsMsRoH8Ocdawf7GUm3i+PiUOmWud
	+b9Aay9irTtVbnaUFkl84iNHds9MoitwWzLv/HvJYCKyOK9rOuTUmxwHVNiAK+0fzuThL5Oz2gm
	H8wKaEYcjTb1oZWnJ+cI1FdA0/+vbTbx2vsdAkuo=
X-Gm-Gg: AfdE7cnUM6KMBSWHJ1hEmffObK638q7X2IWQb+mi19vKNipIdph89s7CC+QCMfiy1WD
	tYFbGy9dMLCT2DyI48Yd8Fo4iR58yg3awDChzS9yZl4LNicV+3K+E/onQ8dDPEAEjLDsGKe1KN/
	mt4dgxG4yX1AqE5OftT0skp6T26WqMpojrw7RTf30bWtImyaRvXbBjCrhJfra1G4WyxDbn+MEoT
	p+Kl/jQCGq4fVszUuB7cappoJgK5fx4C/EutF+MqpHNBI0F71xSvMaj8FPKN5ni2adBRF/VrnUS
	dtWICrGrhK9m3Yrc9OCh/KvBZJ+BIz6Xb2DJCckLXN4aGBIQbpaBepfu+QWN3SFawTcrPg==
X-Received: by 2002:a05:6a20:d045:b0:3bb:2200:f67b with SMTP id
 adf61e73a8af0-3bb6c6704a7mr8707218637.40.1781971060106; Sat, 20 Jun 2026
 08:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net> <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
In-Reply-To: <20260611085526.GL2191159@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 20 Jun 2026 11:57:29 -0400
X-Gm-Features: AVVi8CcaPXvZ549bCXojPZkP1jiCsxr4OhG6rbaWRU_MBNFyY_T_rRha4ewHvIQ
Message-ID: <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
To: Jeff King <peff@peff.net>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Coming back to index refreshing=E2=80=A6

On Thu, Jun 11, 2026 at 4:55=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jun 09, 2026 at 01:15:11PM -0400, D. Ben Knoble wrote:
>
> > > Which implies that the entries are stat dirty. And indeed, if I run:
> > >
> > >   git -C linux update-index --refresh
> > >
> > > now they both take ~20ms.
> >
> > Ah, TIL about --refresh. I suppose it could be nice if "git diff"
> > updated the index in this way, but that sounds like a band-aid. Maybe
> > creating a fresh worktree should do the equivalent to make sure it's
> > considered "fresh"?
>
> I think "git diff" _does_ refresh the index internally (that's what
> takes so long!). I thought we then wrote out the result, but maybe we
> don't notice that it needs an update for some reason?
>
> I'm pretty sure "git status" does something similar, though running it
> in a slow working tree _does_ seem to make things faster. Maybe it's
> more aggressive about doing the update.

Thanks for the status pointer:

- cmd_status calls refresh_index and repo_updated_index_if_able
- those same calls are wrapped in refresh_index_quietly in builtin/diff.c

But the refresh_index_quietly call is guarded by (effectively; the
actual code uses rev.diffopt.skip_stat_unmatch)

    1 < !!diff_auto_refresh_index

which dates to aecbf914c4 (git-diff: resurrect the traditional empty
"diff --git" behaviour, 2007-08-31). On my system that comparison is
false because the double-negation produces 1
(diff_auto_refresh_index=3D1 or the result of git_config_bool). Or at
least, I don't see it get written to elsewhere (maybe that's supposed
to happen in diff.c:diffcore_skip_stat_unmatch in this case and isn't?
Idk. (Even dirtying the worktree as a hypothesis that only when a diff
is found does the counter get bumped doesn't seem to work.)

So=E2=80=A6 has that conditional been quietly dead all this time? I can't
imagine that's right, but=E2=80=A6

> > > I'd have thought USE_NSEC was the default these days, but looks like =
it
> > > isn't? Try building with that and I'll bet it goes away entirely.
> >
> > Thanks, I'll take a look.
> >
> > I can see on my Macbook that at least Meson does automatically set
> > either USE_ST_TIMESPEC or NO_NSEC automatically, but has no option to
> > enabled USE_NSEC and try that. I can probably write that patch (which
> > I'll do to test), and I can send it along with the "worktree add
> > should refresh the index" if you think that's an appropriate thing to
> > do.
>
> I think NO_NSEC is about not looking at the nsec fields of stat structs
> (since they might not exist). But we don't actually use them for stat
> matching unless USE_NSEC is set.
>
> I guess the distinction goes back to c06ff4908b (Record ns-timestamps if
> possible, but do not use it without USE_NSEC, 2009-03-04), which details
> some reasons you might not want USE_NSEC. Feels like it ought to be a
> run-time config, though, and maybe even something that gets auto-probed
> by git-init.
>
> Definitely not an area I have looked at much, though, nor thought hard
> about. So there might be gotchas. :)
>
> -Peff

Looks like adding USE_NSEC to my build did make the issue go away (the
patch is short, and I'll send it anyway for folks to have the knob),
but that now seems like a band-aid to me based on my confusion above.

--=20
D. Ben Knoble
