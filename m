Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3939401492
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995381; cv=pass; b=QWqg3O8621vjpZiuaVPQddIE93O//UI0cSIP7PUn9GfXyoCRVuLy94E4haG3f61pwYJmy05A03yQtIh9pVHfokixhwBvoQLjsmgZ089rHMsPHTweVb+qHf7DFqY75+opKGx4DYv+WHfr6owbDhWNmXGyoOx0clsfwOAh6xC7H/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995381; c=relaxed/simple;
	bh=YNX0Gwlsx9klbVAz4cXfPyl+VZKOXIPuiJvDg3zF0eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pfnz0X3wwlHgLez+YCJ2Gfjc2c08VFmRJVxiNuxEMXHwlwhCZZX9/J6drXftjsRXMFaxtNzc2nPRE4pM2c17Mp02rbOhRc7BiNAu4Qgsj96cPdxwdQkWvHsDLAocU7zKGa2qsXXXvLxVTyCITJ4REYV5lKYzDtEv3tC/zGcwg0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjeEZ/jt; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjeEZ/jt"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso2006369a12.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791995379; cv=none;
        d=google.com; s=arc-20260327;
        b=phoLJIEcdNpAVWFgRhm9daO1LVDXNv7iogF7AkgEHOxf+73Yzw3+JjVxozSpjoKL6D
         Afj4CVwwP55jHCEylN9v9LOxxNfoSNbGhTSr1X9NFKdZ4jtpw1LwgI+Qs0Lb4l06CtJm
         tF2B7HICaUvOPZDKBiyM5yM6RnriIRK2yU9IK/r365ByalwHRZ+cTGNEy+B7H7onLw/6
         zVu1mGV9N9FzY+TczDM0rnCUADdnWoT91l/KJXlz5ZW6gRNIdV21ho0cU+5S+cQlKxWJ
         CEBawCLNpnSlNBYYbe7JFsG5FtFqmxkLjYCQjFhv2u82lGmkAGt8T13ykSMg4SqR9n1L
         +68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mXUdgWLh5MlBMydtDiUVgMLWjNZdio9Ts1j8UFduXnk=;
        fh=jggxNzvs03UpP22LdvmhORJIS2ZFiA0ctW4Y7zdeQiM=;
        b=fcB/u1+BiKnpJXSa2KoOLTp9ydyoaPrPhTHjAbCDR9nPyFzFBojbfX2giNaiKEwymM
         K8pJj171iZVv0dNiwLCQGtgE3FPhV4P8z+bBdRIcbtSh08Jt3WPQ426KyTLB5Zsx/ftW
         3xNoTW2tG056J2d+awYbXaPbvghsXxfKrkessLFEXO/7IbwNqMCHYwvJbTI+0Y+Va3PG
         gIL4LqvQRetqQBwaqAOelonVD+2ujWPHWMHr8DPXlirBtk7QCONPZPa27CP9YQSTZUvp
         LGGx9C/2P0+8rQXAMqxvVQ+1dkMhubCHbXscf4r/sRXnlVhuoW+XtGk2omqKTCm3J5Sn
         pt3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995379; x=1792600179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mXUdgWLh5MlBMydtDiUVgMLWjNZdio9Ts1j8UFduXnk=;
        b=jjeEZ/jtlEpx0tOmi635nv+/cKk7g/izrTIjW0wOhE0HmqlQb21AbNCPXMn8wHUvyS
         66oqDS/tjqtbt+A+Or1KL6FEsMSK/RY/uU8AeCQrAKnRTrSXWZYVSVLGRo3od9HkHgst
         BPm8Ja9P/HA3IUsmILDmzinLgNWM32l8dmdDTXV/5BDx3KjVHdppFa7mzcQwxROEy2IE
         kvfUpRriLybbrXCja78jNDj9Z+B+RVETz/x8DMJ1B8psqoGcEIBW6dSQc4ji/ls43YaZ
         ks04LttCjhApdg2DjvqeYJgZDtZ8KWxR/PJSwcBd3t6wElenLJAHa6m0U1h7dzzmCHfF
         0iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995379; x=1792600179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mXUdgWLh5MlBMydtDiUVgMLWjNZdio9Ts1j8UFduXnk=;
        b=jfwsfCEhGpueYkzQURsI5r3jVUtGD9DrofjypUGvDvypOZOjxgfd+edMh1meb9NCUq
         INjuL3rr8cm0AHksi1hZj1YWYaQmzhE4/LEMP0WgSOpOMqCd1lKrg9Fd02DFwC6blR2d
         v2cSh3OlNEXBmNFRsH8xAgifSzRo0EBSb18MWRGccqvJyG7uvUwc/61UP06AdoXceLhT
         WXkNR5TcPJxftZ83igzUFYmZVhrMMigEdMzVbIU6/CiDsmg0rlONE7NEo/QcRdgz+IVe
         cfJCgpefKayXQ3V3e8hN2u72KM5yU0xUp53Sei1Ezn4uMDJdWgYd+VYMoL2qPo1MaYjf
         j/2g==
X-Gm-Message-State: AFq9FYIDx9nzydDhq/id2NueqBFCw9p3yHQ6lNxuKBtBfFvQZjlFPQiF
	C2crplBHdyjXDx76NctUKJ8HGjaL5ZaiEPQG/wd3iztq4QV8Ek1buc29H6snARIm8AsQgAU+KhU
	yPruYwTrxlcnPRwEJhcvTD1qxrp6Cfiw=
X-Gm-Gg: AYBFou2us0o8DjPCi0gowKOgmc2hZal1K/a0mlGnz7rtQFS/OvemfqZEA1HqhF4tU0u
	ojuCRAgV7JMGJ97IR1oYlggFwyCacdq29i0xIEBjf085dKdSzdrlLwepDntS2m2MCRF8JW9h8qA
	Y+0p+zfh7TiOtp0aiYCbUjyJpwrBffmrB0SXfLn3hKq8ovTXQw6MD1yPE6rxHBUMumEUtGzlc1e
	dEkR+ko7kd18YjzfQVNypRUHMjDsCeYI6f5CwpeBdWXngiTghHM2FGj6gXH9euLddh0RhbroiH3
	LSWR9gqemTSh4FlQAcyQz1jLjThN3RCwt5Lm8ACTlzCPk5cpxfbEmmeDCONHyV9641Eq7jnb4cw
	QGeFeUypTSOAwNuZllgM/z6i2RYdGbOgcD8NiidoHivD8jIfyVMrTDREy9FE9I6rQ20+4CaVE/a
	5OUq3WJjB/jXphqaNzTMeVSMoQy73aAA==
X-Received: by 2002:a05:6a20:d4b:b0:3de:7701:d221 with SMTP id
 adf61e73a8af0-3e16be44457mr13382654637.42.1791995379111; Wed, 14 Oct 2026
 09:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013172315.2997446-1-quark.zju@gmail.com> <20261013172315.2997446-2-quark.zju@gmail.com>
 <CALnO6CD8c+nZktineZjo6PkZbXXEQfKto-cvJvLW=_xjTPVCRA@mail.gmail.com> <20261014023812.2935165-1-quark.zju@gmail.com>
In-Reply-To: <20261014023812.2935165-1-quark.zju@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 14 Oct 2026 12:29:25 -0400
X-Gm-Features: AclHuK9RXkaGtorJpp_cgo-s3wFaVa_AhdWZ8Ja_ifn0XORW7dMSXj36QjMFET4
Message-ID: <CALnO6CA=rnFfgvokMUQ5M-2xO+aqowF5KB1SSTYXT8hNYKUq+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] repository: add core.indexLockTimeout
To: Jun Wu <quark.zju@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, ps@pks.im, 
	Jun Wu <quark@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:38=E2=80=AFPM Jun Wu <quark.zju@gmail.com> wrote=
:
>
> On Tue, 13 Oct 2026 17:40:01 -0400, D. Ben Knoble wrote:
> > Hi Jun,
>
> Hi Ben,
>
> Thanks for taking a look. This area is a bit tricky, so let me try to
> explain more clearly.
>
> > Interesting. That must be the slow down you mentioned in your cover
> > letter? I'm trying to make sense of this. I think you're saying that
> > not having the index lock means status would "lose" refreshed info:
> > we're not throwing away the *existing* stat info, just the ones we
> > recomputed for this "git --no-optional-locks status" invocation,
> > right?
>
> Yes. A file's stat info might be updated without content change (e.g.
> `touch`-ed) so the existing stat info can become outdated over time, and =
status
> cannot use the stat fast path to confirm a file is not changed, so status=
 falls
> back to slow content check. Note: if the user runs a command like `add` t=
hat
> writes the index, the performance can recover, but based on our experienc=
e,
> users might not run such recovery commands for a long time, so they suffe=
r from
> slow status.

Makes sense.

> > I suppose I don't see how that causes things to slow down continually,
> > but I bet I'm missing something :)
>
> To give some (hopefully useful) examples,

Sorry, I wonder if I wasn't clear: I read the cover letter as saying
that performance worsens over time, and I'm not sure how that's
implied. Maybe the idea is that more and more files need to be
content-hashed, though?

> > I applaud the effort for sensible defaults here, which I think will hel=
p.
> >
> > Anyway, maybe it's just me: if others are happy with this approach,
> > great. I think I would prefer to see us try to address the underlying
> > performance problems, though, if we can. (Maybe we can have some way
> > for git-status to not throw away all its work, or some other good way
> > to communicate to IDEs that want to poll?)

It does sound like others (Peff) think this is a fine approach, so
I'll bow out now :)

> By "address the underlying performance problems", do you mean:
>
> 1. Improve `status` performance so it takes index lock for a shorter dura=
tion.
>    It helps, but as long as `status` takes the lock, there is a chance it
>    conflicts with other commands. This series allows tools to drop
>    `--no-optional-locks`, which indirectly helps `status` performance.
> 2. Improve `--no-optional-locks status` performance so it's fast.
>    This sounds like "lock-free writes to the index", which might require
>    a complex file format change.
> 3. Switch IDEs from polling `git status` to fsmonitor-style `status` noti=
fication.
>    This helps. But similar to 1, reducing `status` frequency alone does n=
ot
>    address the root issue.

These all sound like great ideas! I actually didn't have a concrete
suggestion, other than trying to address the root cause rather than
(IMO) band-aiding the surface.

Looking a bit more at how my editor integration works (tpope's
fugitive for Vim), it seems to *not* use --no-optional-locks and
(presumably) avoids the issues you're seeing by limiting background
refreshes to specific events [1] and doing some kind of caching, but I
haven't really worked through it all and I'm not sure how easy it
would be to extract generic ideas for different editors :) It's also
possible I just haven't ever run into the situation where
--no-optional-locks would have helped, so might be a moot point.

[1]: https://github.com/tpope/vim-fugitive/tree/3b753cf8c6a4dcde6edee8827d4=
64ba9b8c4a6f0

--=20
D. Ben Knoble
