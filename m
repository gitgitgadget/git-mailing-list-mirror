Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED31E50A
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376969; cv=none; b=lVpQ6SBNJsKgTpnZHY3554NKoQpRgQQp/1ELf9LL4IeYdgwbVY1+ApaA/8OuLAZMM6W4UdV+g13z8MBZ4SXXQjOL+tAlwTixwvMV9la0X8oK8xkCVPHS9THsk7NVeFlZwjXpHjlUZYHzgpkJ7ABOVVcUVJ8CUiZfjTo5nbHPl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376969; c=relaxed/simple;
	bh=5B1J/SMvNut3LfRt8DslHaOwMpYffSAF7xk0i2fcsiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ruqf4dkB0kV+DqM2nEvNBf3+Aok2cIHqon2llkIdTD7YAb43z9iemuXRwlj2YWa73TBOqiIzqmzlAdZIVkMyOEdqtByFa7CoRNPSzDXe9wh5F4QabDcNYiNbUUIa+VNjxLLJZ1NwZ9KHjEcP3ktN37sx3YXdXHyUsMBo0VKBpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3eIDXRR; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3eIDXRR"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b277e17e15so1159083eaf.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715376967; x=1715981767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qVyfKzmF8frRcAcaDX5DHeJk6kYaFKCsL9+p5oJe68=;
        b=p3eIDXRRQHLhsc8gwPmaDARoJE5Tt48c1AP1GawNe7und/olwYlxQXlZducb+pkjgy
         RXJgssCxDDotYa5Uf1tpwlwUme6MPUWMegWDoH6EMHoEzSFAFzmWdqGTfqpN3ICkqnXp
         FO++GnpMEFT2b7Sp1GpCnzKCU8BP3X694nQ2TSUFrMsfyQQW73GeBX2CF1QVfMtd21K/
         RByRes02InIcCQpIhjEzRwxuhXY/oWnz3NWxOqGuGTl9sj1xTh+Yot9exCSVKFUCNqWc
         5EN++abAEYF1oG5WWXLL3H+iU+g/YY/jUpaH72PeWkzHpl4p00M1C1lk5448tRmPJUNy
         6FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376967; x=1715981767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qVyfKzmF8frRcAcaDX5DHeJk6kYaFKCsL9+p5oJe68=;
        b=hImQ91YCuqeVe3RJp1evxXF+ndc2YJDEyeLSFoSo9WNXHeU5YF7OOajk1cZ1QoYuit
         s/mtDBWRLDv8fAVoRHzsyJscCrw/Ty/E2pDh0a4/87rL73UnpWaRL6eTD3kxomnHGuYO
         2aDiFkarhI6p3eg1A34/tqzqRVoiIN/rTt+eO87IsX+0QTQ6azj1LnggEM7aQPVhEZaT
         SgWyqUDUUaRcMYbMjpbedsX4EmkQC0lXs3yWSJD1v0tp18QDy0bqtyMmfiS5DMqOSZ0t
         BVzJw2qm3R8LSrgSGyDYaYXSU7DTCFctCcd+w8KDQy7hTLsCwbsclGj1Mh+GBC7mVyu1
         j8bw==
X-Forwarded-Encrypted: i=1; AJvYcCVKeCy0BgmA2Dj84gOtVeohOw8fkjS7H4huT49Wh0ppRG+mxvTCVvw55tqQVeseFxZpJTIr/Y3c2BZ3IPHjQFKyW4N2
X-Gm-Message-State: AOJu0Yy5xuGw9ENphZrwDyFbmU8SVSe7W7QnYEaxuRw9zcxlNzvmoPEN
	nss5U39j/aMhCbhjhGN02UIyaER0VupcnCYKGEDBlW9IyKmEoP30b0dU0cDtSHusF99fiKF+1oH
	PXSXHjZ0tyT+NBbEdDIRoD2sAZmR+NtP4NYUJ0E7FR8vbwFN0XxFk
X-Google-Smtp-Source: AGHT+IF8QxqORHC0BKGsJhBoMpaF856oewB/n+F+DpxWEX2IP/FCU6UYzPDzOM9yp1+829zgew0q8FzskKUyqGtH8q0=
X-Received: by 2002:a05:6870:5b89:b0:22e:d258:bc43 with SMTP id
 586e51a60fabf-24172f510a2mr4106930fac.42.1715376966672; Fri, 10 May 2024
 14:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <20240422162617.308366-1-calvinwan@google.com> <CAO_smVg_RmL2_ERXG0uZ+CgEHZBm34PvmNucbSTdsEDLjU-fhA@mail.gmail.com>
 <12a4cd37-1cef-45a0-9b96-36a978e52dba@gmail.com>
In-Reply-To: <12a4cd37-1cef-45a0-9b96-36a978e52dba@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 10 May 2024 14:35:52 -0700
Message-ID: <CAO_smVgEkLN=rFDEDM-JV9mXQK4CCx0u5W1d+YXse0Qy3QMnsA@mail.gmail.com>
Subject: Re: [RFD] Libification proposal: separate internal and external interfaces
To: phillip.wood@dunelm.org.uk
Cc: Calvin Wan <calvinwan@google.com>, Git Mailing List <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, rsbecker@nexbridge.com, 
	Josh Steadmon <steadmon@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Enrico Mrass <emrass@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:52=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Kyle
>
> On 09/05/2024 02:00, Kyle Lippincott wrote:
> > // RENAMED from previous code block (no other changes)
> > // In a .c file that is "library internal".
> > // This translation unit can assume that we've done #include
> > "git-compat-util.h" and anything else it wants.
> > int strbuf_grow_impl(struct strbuf *sb, size_t extra)
> > {
> >          int new_buf =3D !sb->alloc;
> >          if (unsigned_add_overflows(extra, 1) ||
> >              unsigned_add_overflows(sb->len, extra + 1))
> >                  return -1;
> >          if (new_buf)
> >                  sb->buf =3D NULL;
> >          ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> >          if (new_buf)
> >                  sb->buf[0] =3D '\0';
> >          return 0;
> > }
> >
> > // In a .c file for the interface as used by other projects:
> > int gitlib_strbuf_grow(struct strbuf *sb, size_t extra)
> > {
> >          return strbuf_grow_impl(sb, extra);
> > }
> >
> > // NEW from previous code block
> > // In a .c file for the interface as used by the git project itself:
> > void strbuf_grow(struct strbuf *sb, size_t extra)
> > {
> >          if (strbuf_grow_impl(sb, extra))
> >                  die("you want to use way too much memory")
> > }
> >
> > I'm recommending this pattern primarily because of our platform
> > support concerns. If we can't elevate the entire project to assume
> > that C99 is available in a standards compliant way, we can't have
> > header files that look like this be part of building the `git` binary
> > itself (or any of the helper binaries):
> >
> > #include <stdint.h>  /* Our platform support policy doesn't allow this =
*/
> > int gitlib_strbuf_grow(struct strbuf *sb, size_t extra);
>
> We have had a test balloon [1] requiring C99 for two and a half years
> without any bug reports so I think we are probably safe to assume the
> test balloon has succeeded and that we can depend on on the presence of
> <stdint.h>.

In the past 5 months, I have been told that this isn't a valid
assumption to make yet. I will note that the test balloon just checks
for the compiler claiming it supports C99, not that it actually does
so properly. This is why stdbool is still in test balloon stage
(8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem} to
bool, 2023-12-16)).

If that's no longer the case, and we _can_ rely on functionality
specified by the C99 standard, such as stdint.h existing, then using
the same interfaces internally that we expose externally becomes a lot
easier.

> Note that the [u]intptr_t types are optional and so we'd
> need to make sure we avoid them in public interfaces.
>
> [1] 7bc341e21b5 (git-compat-util: add a test balloon for C99 support,
> 2021-12-01)
>
> > It's not just the #includes, though. As stated in the original
> > document, we run into problems with platform-defined types and
> > everything else that's tweaked in/provided by git-compat-util.h:
> > - This header file that's included in the non-git projects can't use
> > `off_t` or `struct stat`.
>
> In principle we could change the interfaces that currently use `off_t`
> to use `int64_t` and convert to `off_t` in the function body which would
> avoid having to have separate wrappers for the internal and external
> callers. I'm not sure how invasive that would be though. `struct stat`
> is trickier - where do we expose that in our interfaces?

I hadn't actually checked if we do expose `struct stat` in any
function declaration, it was just an example of something that changes
size/behavior due to the #defines. But we do use it in the following
places:

entry.h's `fstat_checkout_output` and `update_ce_after_write`
reftable/stack.h's `struct reftable_stack` has a `struct stat` member.
4 uses in git-compat-util.h
several uses in read-cache-ll.h (which sounds like it probably
wouldn't be exposed in an interface, being lowlevel :))
statinfo.h
object-file.h's `index_fd` and `index_path`
dir-iterator.h's `struct dir_iterator` has a `struct stat` member

I may have missed one or two .h files. Maybe all of these are internal
things that we won't be exposing in an "external" interface, and
that's great: no need to worry about it then.

>
> > - This header file can't assume that any types related to sockets are
> > available, because those come from <sys/socket.h> on Linux and from
> > winsock2.h on Windows.
> > - It can't assume that we have `NORETURN` (and it can't assume that we
> > don't need it), or `MAYBE_UNUSED`, or ...
>
> These problems and the _GNU_SOURCE on you mention below must be pretty
> common for cross-platform libraries - how do other projects handle them?
> On the face of it this seems like it would be fairly simple to solve by
> including a file that contains the subset of git-compat-util.h that
> defines these macros (with a suitable LIBGIT_ prefix) in libgit.h.

I think that either the library interface just #includes whatever they
need, and if that doesn't work, you held the library wrong and it's up
to you to fix it (by doing whatever #defines are necessary either on
the compiler commandline or before including the library's header), or
they wrap everything in a layer of indirection, so only the library's
code itself needs to be compiled with any special options/#defines.
I'm advocating for the second here.

>
> > Most of those issues _may_ be able to be resolved by having a
> > "gitlib-compat-util.h" file included at the top of the "external
> > project" .h file. But that's insufficient. Example:
> >
> > #include <unistd.h>
> > #include "git/gitlib.h"  // Oops, the `#define _GNU_SOURCE` in the
> > transitive "gitlib-compat-util.h" has no effect!
> >
> > Or the opposite:
> >
> > #include "git/gitlib.h"  // Oops, this set _FILE_OFFSET_BITS=3D64 when
> > the project wasn't expecting it!
> > #include <unistd.h>  // For this translation unit only, `off_t` might
> > be a different size than elsewhere in the project, I hope you like
> > debugging segfaults.
> >
> > The only ways I could come up with to solve these problems were to
> > hold the "external interface" to a different standard, that is
> > simultaneously both more permissive (it can assume C99), and
> > restrictive (it can't rely on things like off_t),
>  >
> > incompatible with these external interfaces being used by the git
> > project itself, which has a broader set of platforms it needs to
> > support. But the external interfaces must be very simple wrappers
> > around code that _is_ shared with the git executable.
>
> I agree we should minimize the amount of code in the wrappers for
> external callers.
>
> Best Wishes
>
> Phillip
