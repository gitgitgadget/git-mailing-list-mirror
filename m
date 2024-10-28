Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A21F80A8
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156388; cv=none; b=PwVVnlUVmR2hjhsgr53g8EV0gb4p3KyjOUpJuR9TTdlJsgRQDgPuHKHkgkV4u9Ns5fXDlKib51YhTJiV140pFO0K7HV5pduvPVyZyxkbE+hQL+aVP3nZBYKYqSR4XVMAyFM8Thbnu7ZLkswQ1G8wZIPxy1cOCgnhvUHueH0/u/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156388; c=relaxed/simple;
	bh=j0C9N3bgy6jdJJJaf8Agp3TDi7lqWrn4lsRU97mU9Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNM1DDjHD/LBrYVjDRYIuVk1TmAuGh5UCapYjwPsBs5XDRAhHWH2jLwNFUpYF0fYF6qfumOPQynALFyP0ffNmQU6v8z2WOoerHBNjd7aSYwY4/YObLj7/kX439Cf0F2XUQbWB90kfigAO0e2ZE6aVUuyz/+d2xNaFSNAggZzbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e600add5dcso2244721b6e.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 15:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156385; x=1730761185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pCWdFGhuGf1qlL5efqs22cZklwfQqSelPHZ4hAeoHo=;
        b=YYh14Ls9UhJDAmMgWtqC54fJE38/24k2fH8syNzDjRQJGY3LeFLGrd8IJXc+/QpGWp
         2lVYr4VetebXRmlLdGufG+zIsSLWNrrfwOYjvKq8Iq3Hsk2Vi652xR6QWKcjKXZ7fCs5
         O0QkLEbFOEjvUmiMNDfCGmzpchzjbLdk0AKSPiMkvh24kNEhfq3Gj2wIW0dC6k5mDuQX
         HH/AQwhqZMrR9UfrV6aNhFeqf321FS0e0IBX7YPEGnkPPC6TarStrwFwlTYOwEKT/EVQ
         0fzDbNCvhvrJQwR+Gx1kreRLcKSBbIdg7AYW5bdUmj+PZSFkRNuQL9lrTPcem2yZLpfu
         fjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI/67LhRAXFFhArAcJkr0g5V4Q2WrtE5xCrYS0vHmgc+6ea9ntgGKuYSfkZY/OXlDBCJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiawzcqFEAvnMVT1ergNGrA94RT9Fv98kk7I+BG1p1Lx1UzSi
	GmRm98WdRZ/Wh3Ox2SYPFVeHU3Y0aqVeDZgF/B8VQJUwn0AefBFZE4EDpQKvMD2mVRthZwVfsrO
	HSwHwmwG55JRsVYpGu8Hi7d1jw0Q=
X-Google-Smtp-Source: AGHT+IHwFSJVd2S32ERY+dD3zAalV7MZRoIm7suOsxB+VngrAj62uSrstP1Uk0eeC+kRsIG7OmZl8LiRMimJ2c8F9Io=
X-Received: by 2002:a05:6808:1a08:b0:3e6:951:8b3b with SMTP id
 5614622812f47-3e6384be77fmr8407959b6e.30.1730156384800; Mon, 28 Oct 2024
 15:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
 <Zx/TwhuG4Ni7mf6F@nand.local> <CABPp-BFB+eG7WVJFm3EBfgKzuspAYn9KpDHodpgKuFmWefARBw@mail.gmail.com>
 <d74232a4-126d-4bd8-8f60-a3fac80492d5@web.de>
In-Reply-To: <d74232a4-126d-4bd8-8f60-a3fac80492d5@web.de>
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 29 Oct 2024 07:59:28 +0900
Message-ID: <CAPc5daW+5=PPe3e=n3Erev4eNc7CGX1Pg5GXykua3FH9VuCVog@mail.gmail.com>
Subject: Re: Inconsistent handling of corrupt patches based on line endings
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Peregi_Tam=C3=A1s?= <petamas@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(On vacation, pardon GMail web client).

As POSIX.1 says
https://pubs.opengroup.org/onlinepubs/9799919799/utilities/diff.html#tag_20=
_34_10_07
"""It is implementation-defined whether an empty unaffected line is
written as an empty line or a line containing a single <space>
character.""", it might be unfair to call it "GNU's eccentricity".

But I found that the POSIX text is fairly clear that the OP's
CRLF-only line does not even qualify as an context line that is
totally empty.
So perhaps there is nothing to see here, and not just we and patch(1),
but GNU diff is doing the right thing?


2024=E5=B9=B410=E6=9C=8829=E6=97=A5(=E7=81=AB) 7:07 Ren=C3=A9 Scharfe <l.s.=
r@web.de>:
>
> Am 28.10.24 um 19:39 schrieb Elijah Newren:
> > On Mon, Oct 28, 2024 at 11:11=E2=80=AFAM Taylor Blau <me@ttaylorr.com> =
wrote:
> >>
> >> On Mon, Oct 28, 2024 at 05:57:54PM +0100, Peregi Tam=C3=A1s wrote:
> >>> Hi all,
> >>>
> >>> I might've found an inconsistency in how git-apply treats corrupt pat=
ches
> >>> (representing empty context lines with completely empty lines instead=
 of
> >>> lines containing a single space - usually a result of a "trim trailin=
g
> >>> whitespace" editor setting) based on whether the patch file uses
> >>> Windows-style line endings (CRLF) or Unix-style line endings (LF only=
).
> >
> > I believe this behavior was caused by:
> >
> > $ git log -1 b507b465f7831612b9d9fc643e3e5218b64e5bfa
> > commit b507b465f7831612b9d9fc643e3e5218b64e5bfa
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Thu Oct 19 19:26:08 2006 -0700
> >
> >     git-apply: prepare for upcoming GNU diff -u format change.
> >
> >     The latest GNU diff from CVS emits an empty line to express
> >     an empty context line, instead of more traditional "single
> >     white space followed by a newline".  Do not get broken by it.
> >
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >     Signed-off-by: Junio C Hamano <junkio@cox.net>
> >
> > That code special-cased a line containing '\n' but not a line
> > containing only '\r\n'.
> >
> > As to whether that's correct, personally I'd rather only special case
> > workaround important existing clients.  Back in 2006, working with GNU
> > diff was incredibly important, and I'd say is still important today.
> > I can see Peregi's comment that this make line ending slightly
> > inconsistent, but I feel like the blank-line handling is a workaround
> > for an existing client we want to interoperate with and absent a
> > similar important client with mis-behaving '\r\n'-only lines, I
> > wouldn't be interested in adding support for it.  But that's just my
> > off-the-cuff feeling and I don't feel strongly about it.  Further, all
> > but one of my contributions above were mere header changes, so if
> > others have other opinions, they should probably be weighted more
> > heavily than mine on this topic.
>
> What would the patch(1) do?
>
> The first column is the exit code of the subsequent command (0: success,
> 1: one or more rejected lines, 2: failure):
>
> 0 patch                     -p1 --dry-run original-unix.txt <corrupt-unix=
.patch
> 0 patch                     -p1 --dry-run original-unix.txt <intact-unix.=
patch
> 0 patch                     -p1 --dry-run original-win.txt  <intact-win.p=
atch
> 0 patch --ignore-whitespace -p1 --dry-run original-unix.txt <corrupt-unix=
.patch
> 0 patch --ignore-whitespace -p1 --dry-run original-unix.txt <intact-unix.=
patch
> 0 patch --ignore-whitespace -p1 --dry-run original-unix.txt <intact-win.p=
atch
> 0 patch --ignore-whitespace -p1 --dry-run original-win.txt  <corrupt-unix=
.patch
> 0 patch --ignore-whitespace -p1 --dry-run original-win.txt  <intact-unix.=
patch
> 0 patch --ignore-whitespace -p1 --dry-run original-win.txt  <intact-win.p=
atch
> 1 patch                     -p1 --dry-run original-unix.txt <intact-win.p=
atch
> 1 patch                     -p1 --dry-run original-win.txt  <corrupt-unix=
.patch
> 1 patch                     -p1 --dry-run original-win.txt  <intact-unix.=
patch
> 2 patch                     -p1 --dry-run original-unix.txt <corrupt-win.=
patch
> 2 patch                     -p1 --dry-run original-win.txt  <corrupt-win.=
patch
> 2 patch --ignore-whitespace -p1 --dry-run original-unix.txt <corrupt-win.=
patch
> 2 patch --ignore-whitespace -p1 --dry-run original-win.txt  <corrupt-win.=
patch
>
> So basically the same as git apply?
>
>
> What does current GNU diff do?
>
> diff -u                        <(printf 'a\n\n') <(printf 'b\n\n') | tail=
 -1 | od -a
> 0000000   sp  nl
> 0000002
> diff -u --suppress-blank-empty <(printf 'a\n\n') <(printf 'b\n\n') | tail=
 -1 | od -a
> 0000000   nl
> 0000001
> diff -u                        <(printf 'a\r\n\r\n') <(printf 'b\r\n\r\n'=
) | tail -1 | od -a
> 0000000   sp  cr  nl
> 0000003
> diff -u --suppress-blank-empty <(printf 'a\r\n\r\n') <(printf 'b\r\n\r\n'=
) | tail -1 | od -a
> 0000000   sp  cr  nl
> 0000003
>
> So it omits the space only if --suppress-blank-empty is given and the
> blank line ends with \n, not with \r\n.
>
>
> Anyway, I agree with Elijah: The targeted support for GNU diff's
> eccentricity is fine, and we're in good company with that.  We could
> remove it, since it doesn't seem to be the default (anymore?), but I
> don't see much of a benefit.  We could add support for blank context
> lines that end in CRLF if there's a notable source of that kind of
> that deviation from the original format.
>
> Ren=C3=A9
>
>
