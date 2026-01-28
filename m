Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25340222565
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595221; cv=pass; b=Tz0hxi79F/ecZ2PAZIE8SVuAfTMe39SdHFSp9y5hKrkFL2LjTrUn8q71OMdHK0D7zwgFz53HoVU9y+DF/2V3IAvCZ+rpGSaCQ11h7ra1CFHs56q0NpsdQyd+TT9sMDOINoys3M0+G6E6nneS8UPjEuy/Na9jO/9EOgyeVQW/NhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595221; c=relaxed/simple;
	bh=CnKRXmKJjHA/kcaz0sC1w335PQuxIYfKYRPk2yQLpDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e/pdruY8MvDuY01WaMd7bwejmmTA9D0thHcHoJbrP/LMSyQdX+x6jfFltlD+rb88xRCENL5JKJ64R2oQ8asbSAJjxNkFa1agROcYB5hXELpFeRaix9UZXBAboEi6XKCeFNQNK6q8RDK6wIkaLr1/v/a7ynkPA+9BprbStyxbK/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eoq1Ctes; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eoq1Ctes"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11f36012fb2so9482161c88.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 02:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769595218; cv=none;
        d=google.com; s=arc-20240605;
        b=N+TMQYtVnYJg6QYDi0NDyFb+cEdQSNXR3WW2HTOjXHNbqkl6BGRMBvns/coRyPiYWo
         8atyyGbFYUMph4lo+2oxUwjiSAPAg2jCS2PqmlxP9stJvke/0XlKuuT35o47P7F6reC7
         Wz3gRpi5oI2aOevS3FZxL9+IzXH69JvDczlpY2EjpJe2CIzA+UIj9gOYkYBG+q1K7Xe0
         l+jAWmzW72uqnPshu7fQ3/HCHXmHo+WXxGAe/MuWUFymt86rfT/1HJdnkW8/gAWZxvt6
         +6H82eP1KyFId8HZ4cK0W4k81+Y6GsoMRrjL3jd43EuQzn491Wq7E/YuAYOVwE7GDyYF
         cG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yJdEcAkDULDjj2gPapU4gB3CB7IQvdAVmmkpRylK5qs=;
        fh=FGaIFl0zvdCMtXroej/QF/qabdC2HfiBCE2vcv/Dh/U=;
        b=kY5njLtZDk2MrqqECfPDVK1FOuANTvgXKOqrQswQUNIm3sBc0YhMy+xewNiOEGYReL
         QMJQ1tT3BJTgn2MAKcWk2eIVEKqEqofWltLmBzqDMM7nWuUA1nLb2i92lY3xMsBycFK5
         iAxi5ZFKtST6sLB80ZKBxL8ehHNx3ihFVC2/gJqSmj3hHkretjMjk6cIjsEfEWL9zfJ6
         ZH6L6tvN6KT+8Q6wnfjCzj2EKR2P+fQf14bQggphZU20AZVC2vcHTLa9AvHq12nz/AJ9
         +VDPcfLlaEDKvwkL4V2hu8mQAcGONlVTydghjD5CsaevFsxwnrDhnAhuZxaMFiZEjF0H
         ZJGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769595218; x=1770200018; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJdEcAkDULDjj2gPapU4gB3CB7IQvdAVmmkpRylK5qs=;
        b=Eoq1CtesEwDmZssL6UyNM+u7rSYakQUBAcebiJrDqQdTnFeKjMIzSLGZwPpcO//kRt
         b/kjXMgfYjUNEUmnH655HGscYtiEUofJUljn/2l6RTmfFyWKsD+9OJUrJGVXqhWzruQp
         t5ieOxevbS3Aq0ugqSdXvT2qywA7NJJPkjUhkBhGb5vurSzcb6zdjYsNrySxsBfQMOQU
         w2gnGzlJAUk/D5Wu5Yb2EEMx5uBNgipsMITMIkCKV4aEjKISYYPFeGODNb6Pfvtrlftc
         MFGz5InN0Ne+kdn5u3n40lOXq/Vwcoimv5LjCGy7KyjEJT1bBtrNEmDbpOwv+fvwpROZ
         ff0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769595218; x=1770200018;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJdEcAkDULDjj2gPapU4gB3CB7IQvdAVmmkpRylK5qs=;
        b=X8LwGdFkFWWmY7dXYOE9BsaAT0G+vG5qWDvVFLFz2GaViwjU19SGUuWvkOp5arits0
         riaNuNaK5yerEeg/+RABB6vYigz65kOuRcH0ZwUdflF5Sd3KohmkaeJQH3E53FJRH2an
         V+NgsMuqqN5MWSv/FpxmxiyJupbC8QK3RiIbHP76FpbSUiSU+VGeH0/dCBsU22Td+YGs
         r1IgxJIcSDt8bKoqC59V1za69+3SWL0OP7wO3hyQZFoGEmGt2T1zTMq5xR7XXw+1uI+u
         T/R9YcghO975FDAvEPynOTY+lWhKmYfCJ4H8/R/MiZHi2jAbekgDPj76oi9jCguYaUE9
         3zfw==
X-Forwarded-Encrypted: i=1; AJvYcCVFOcKYkxTX+C8PdlMd4mNyyvxtHKBuQ61jUZOfWRTQbfVpaH84DHfN1MptAAHEkHnXK84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbL3GGdPkDu8wjH3evc/sdN+2sPeWRAozKh9BrV1E/F6xpSim
	rsUeFpFZ4cdOd7mWp4ZKRTfsDm0hX+IlZV/Lql+l1izP5fKa/fYnKKA4hNBkHkHnIU2qtruqXS/
	ClD63UJRQFWYPOtFC3KwJx6RzPpKtXBvFtlQQerU=
X-Gm-Gg: AZuq6aImPTLJh/Mkqi3CdzxHWMdZawdm9rGJWuEylu5Ae2NJUkJgGBMkJVX3x5E32hv
	nMJi9dS53FJKAPRwMvDHY10MuhmheoJMds8tIgpFhlJf6AhAGzP5F2Xzh3+SFl6MgTydu1jPV3o
	qsrmOLEI6d3RrPKGOAB6v12v7LCEsv6nLWHoeLK1eZup9Qlxqd6O5Sov7n1GDNpJVjP7c0fCoTn
	2DmPCatPuScysoQeaBus1HvHWjgMX/owyOBr43VTCZm/36BmO1gBB3JNG5czpivxVsS26MQgRvO
	u6pw
X-Received: by 2002:a05:7022:6b93:b0:11a:e610:ee32 with SMTP id
 a92af1059eb24-124a00bb11cmr3015951c88.25.1769595217466; Wed, 28 Jan 2026
 02:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+5Chmhwcz=gOQHW18_w+uYojshjFj8MCE+srUpJgEhbh8J09w@mail.gmail.com>
 <aXlw-RN82f3CquNH@fruit.crustytoothpaste.net>
In-Reply-To: <aXlw-RN82f3CquNH@fruit.crustytoothpaste.net>
From: ZH L <lzh2587379717@gmail.com>
Date: Wed, 28 Jan 2026 18:13:26 +0800
X-Gm-Features: AZwV_QjWGJoAMD3Tp5M4VwoR0nRwmD9xFcuEgBVqCZ3MZnfY6LVBfBOA3Yn-Ntk
Message-ID: <CA+5Chmiz32zVTao61JS2eR_6WBenYNcPj0JvmcAtZBep1Z5Z-Q@mail.gmail.com>
Subject: Re: Question: supporting multiple named ignore files (in addition to .gitignore)
To: "brian m. carlson" <sandals@crustytoothpaste.net>, ZH L <lzh2587379717@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your detailed and thorough explanation; it has been very
helpful in understanding the issue.

I completely agree with your point that editor-related ignore rules
should be handled by individuals, not included in the project
repository. Since each developer uses different editors, enforcing
editor-specific ignore rules at the project level would indeed
introduce unnecessary complexity.

The backward compatibility concern you raised made me realize that
even if Git 3.0 introduces this feature, there would still be a risk
of mistakenly committing files due to different Git versions in use
across environments. This is definitely a practical issue that cannot
be overlooked.

The reason I raised this question wasn't to strongly push for the
introduction of multiple named ignore files, but to understand whether
this idea had already been considered and whether there are any
fundamental design objections. Your response has clarified that the
main concerns are compatibility risks and a lack of demand, rather
than technical feasibility.

I also agree that if Git were to evolve in this direction in the
future, an explicit include syntax or pragma configuration would be
easier to manage and would better ensure backward compatibility. Such
changes might only be feasible after Git 3.0.

Once again, thank you for your patient explanation and in-depth
analysis of this topic, which has provided me with valuable background
information.


On Wed, Jan 28, 2026 at 10:14=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-01-28 at 00:42:12, ZH L wrote:
> > Today Git only loads ignore rules from .gitignore (plus global and
> > info/exclude),
> > which works well but can become hard to maintain in large repositories =
where
> > editor, build, and miscellaneous rules are mixed into a single file.
>
> It's also possible to put `.gitignore` files into subdirectories if
> that's more convenient.  But yes, there's basically one per directory.
>
> I want to also point out that editor ignore rules belong in personal
> ignore files, not in projects.  I use Neovim, and if I had swap files
> enabled, it would be my personal responsibility to ignore those, just
> like any other editor files, so as not to leave or check in detritus to
> the repository[0].  Similarly, I'm confident that Junio, the maintainer,
> has Emacs backup files ignored or disabled.  A project cannot possibly
> account for all the possible editors one might use to contribute to it,
> so it's better for each contributor to be responsible for their own
> editor, which means that those rules only have to be set once, not per
> project.
>
> > Would the Git project consider supporting additional named ignore files
> > (for example editor.gitignore, build.gitignore) that are automatically =
merged
> > with .gitignore, with a well-defined and documented precedence order?
> >
> > This would allow semantic separation of ignore rules while keeping full=
 backward
> > compatibility, and could reduce the need for external scripts that curr=
ently
> > exist solely to generate .gitignore.
>
> This wouldn't actually be backwards compatible.  Say Git 3.0 added this
> support, but someone continued to use Git 2.50 (because they're on an
> LTS distribution).  Git 2.50 wouldn't honour those files, so it would be
> possible for users to check in files that were only ignored by the new
> rules.  I assure you that there are many people using very old versions
> of Git and that even in corporate environments, there are a wide variety
> of Git versions in use.
>
> That doesn't mean we couldn't implement this functionality, but I have
> not yet seen a project that needs it.  Many modern languages put all
> build products in one directory, and if the `.gitignore` file contains
> only the necessary rules (instead of combining multiple large template
> files), it can usually be pretty small[1].
>
> I'm of course interested in what other folks think about such a
> proposal.
>
> > I=E2=80=99m mainly interested in whether this idea has been considered =
before, and
> > whether the maintainers see fundamental design objections to it.
>
> I don't know whether this specific policy has been requested before, but
> we did recently see
> https://lore.kernel.org/git/LV8P220MB2017EA88974F2311DCFB7665F52AA@LV8P22=
0MB2017.NAMP220.PROD.OUTLOOK.COM/.
>
> Between the proposal requested here and the one I linked above, I would
> prefer an approach that provides for explicit inclusion syntax, since I
> would think that would be easier to reason about and more flexible, but
> doing so in the least backwards incompatible way would be difficult.
> Perhaps we could make the first line something that contains a special
> pragma (e.g., `#/gitignore pragma on`) to turn on a new syntax.
>
> Even if this were implemented, we'd probably want to do so in Git 3.0,
> which is coming up soon, and we'd need someone to do the design and
> implementation.
>
> [0] In my particular case, I have turned swap files off because I find
> the way they work and the detritus they leave behind annoying.
> [1] Go has 53 lines, Rust has 79, Neovim has 87, Git has 260, and Emacs
> has 383.  Git could have many fewer if we built our binaries into a
> build directory, though.  Emacs probably could as well.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
