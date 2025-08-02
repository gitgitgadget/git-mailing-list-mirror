Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B51F37D3
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754134299; cv=none; b=EdITIOEWvqIfJghOIlirqQ38C0NQAX5UcUV7Hr1Gp35I+Ar1K7pSHDSh5S5g2jQFMyvFSvSKQsRKpKzy1L7ZhmG3G5Vuk91y9rjRvWrrOZW6JwtTbTBbZcGnJQTcdjaDWAWUTTKOgJylQ1SAULq2BZlWHwc0jFsYTSvd4cHhjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754134299; c=relaxed/simple;
	bh=o2DVxczBIwnCPArOW09QLA8xETKmpW855F5b0fBx7MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMVMWyPLl1qyWNkYAU0VaI8XtdxU+S4Fgs+UUHbSytZSakyvTyN81eDS7upnVl0mDr/Bg8dmobV6tNq855ToHgPuYgW01TkLR3e/D8IEt12qQmU1apukOYzQx6CPXHHHgWeLi5oo6ZKwZ/j0hC/hKhHmFiM6R5bk9WGAwJA0gSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h86lSRQJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h86lSRQJ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af93bcaf678so150125466b.0
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754134294; x=1754739094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/kaeC9goz3oQJbX/aGh4nsqfYSF9KqREV7T1sycLvk=;
        b=h86lSRQJDnm8kKAxKMTGU05NtVzVcmy06T/nAZPTBj99pm7WQ6AkWm//4H/NENbLK6
         qFC4TpD3OvX2Q//ON7m4Sw22qjh6YSdf6gXBicutl56R7xBnNwHk4+aEPr0oaAwrByqW
         wCakE8PpZfzgdsxdgRakEtEB5xiXAaCfFSL9W8D3I3pCnspJyxwo+pnG6ANzDUeNAvkh
         ORLYDHZt7q1O5apGKxWKqLBLmnYrpZJWsGjxDdoH11D3pM+wRct1GVY+fj6bROCB+HoZ
         f8qSrl7u4kdOZ79+IcRLD+Bizbr6F4pc2am/4nIIgWE7tz1FnyPtphbSMQ7zhPgyNXHP
         hc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754134294; x=1754739094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/kaeC9goz3oQJbX/aGh4nsqfYSF9KqREV7T1sycLvk=;
        b=TXlA3DUx98a9rPGEoMczfSZJNx+YYHxbnnfIBFAbim7KLi/2mS5Myw4A3j7v9EpES6
         0yy/Dehcr4hNnE84aYMHQQfLSmseRxm7ZjGkouS1WGxxTmxw0qF6IIkbbbbliSpUH925
         6PykOqJanWPHOGHCsKzh5GWoiOWI/0FjugvwFGt8IBqKIUxvZo/kLLkq8BgTdhjcLULh
         OETdXldlHleZ8ftPjrE3EkXDLye8GblS541TN9Pa5QjVjwQcBZScgpAdbVOpb0fKvAUy
         x2Qm1v3oGOikPP2ZXf8tqrH2pVvWLm7k4yZgfb/OVSS0b/Uu7qkuKXuC3kjreB6RIxri
         d5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyQjfNjwbf3idSkI5QzauH7LRc6nJGJHI1Q9flulKD38J2mCbnvHMXwa0yj+bXyOB5zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12jgu3D28kV9PCxKdtDc0GFvmPe0ogS2ERupLSz3cPi1hOdqP
	dgjqyZUprJMGMxSK+6jY9tWgSfAN9t9czMaeP8kqKguB5lgxSaLUj8bXluBcJSsmEZIoKMTam7G
	AoWVCTrgKUXcyiFLqd2fWYZOS4mtEn18=
X-Gm-Gg: ASbGncscnCLI1fuQWLjwRe/iJqX30osoX56rKKJq5hDFg8Kx9IkA+rLYf+tF8+GzuMe
	6MdJzKPeyLCs1n2USXEdknOdZKOnGoPB3lcDUXUuPLGzU8ctRneynzBwsZ6LRGL9A6Vp9yioyr8
	7XK4I3nHMP4CcSNqurhIf53jRJIQjhJeZfyipmNxkZlwq+J/GmxlvrSgm5GNUBtPRfUc+5PV3nq
	2+7YL3Bag==
X-Google-Smtp-Source: AGHT+IFy5qkao1d36N0sEFBbguTfHlj3tpMEVGToWT53G29y5WMYrdhh38BwVWJn8rxY2WfmoS27BuNzW9jRALJKjqU=
X-Received: by 2002:a17:907:1ca2:b0:ae3:6028:e4d0 with SMTP id
 a640c23a62f3a-af93ffc12f1mr263374966b.7.1754134294290; Sat, 02 Aug 2025
 04:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716133206.1787549-1-toon@iotcl.com> <20250730175510.987383-2-toon@iotcl.com>
 <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
 <aIyVft9PdlorttzZ@pks.im> <xmqq7bznm0nk.fsf@gitster.g> <CAP8UFD3rV5CmHbbmg9vQodJ3U=WxfmWHnaio+7RcBAKz=2Ar-A@mail.gmail.com>
In-Reply-To: <CAP8UFD3rV5CmHbbmg9vQodJ3U=WxfmWHnaio+7RcBAKz=2Ar-A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 Aug 2025 13:31:21 +0200
X-Gm-Features: Ac12FXyc_hhyvfuGufq2tnIHUOZ-5PiCSGjOxVKXi7Tz7yIxW5vI3LJPqbBl4sg
Message-ID: <CAP8UFD1hdykpEaFrs1VoHbU1f-vT7xL2R6uvFWzjPQKRp0eoEw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 10:18=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Aug 1, 2025 at 7:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> > Given that even a long-time contributor gets confused (including me,
> > who needed to see where we documented this for our developers),
> > perhaps a clarification patch is in order?
> >
> > --- >8 ---
> > Subject: CodingGuidelines: clarify that S_release() does not reinitiali=
ze
> >
> > In the section for naming various API functions, the fact that
> > S_release() only releases the resources without preparing the
> > structure for immediate reuse becomes only apparent when you
> > readentries for S_release() and S_clear().
> >
> > Clarify the description of S_release() a bit to make the entry self
> > sufficient.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  Documentation/CodingGuidelines | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuide=
lines
> > index c1046abfb7..76ec6268f2 100644
> > --- c/Documentation/CodingGuidelines
> > +++ w/Documentation/CodingGuidelines
> > @@ -610,8 +610,9 @@ For C programs:
> >      - `S_init()` initializes a structure without allocating the
> >        structure itself.
> >
> > -    - `S_release()` releases a structure's contents without freeing th=
e
> > -      structure.
> > +    - `S_release()` releases a structure's contents without reinitiali=
zing
> > +      the structure for immediate reuse, and without freeing the struc=
ture
> > +      itself.
> >
> >      - `S_clear()` is equivalent to `S_release()` followed by `S_init()=
`
> >        such that the structure is directly usable after clearing it. Wh=
en
>
> Yeah, I think that could help. Thanks!

For information, I have asked ChatGPT o3-pro (which can analyse a
whole repo) about this and here is what it says:

---------------------------

Q: In the source code of the Git SCM software are there standard ways
of naming functions that release memory from a struct or clear a
struct? Are they consistently named using "clear" or "release" or
"free" or "clear_and_free" or other things like that depending on what
they actually do?

A:

What the names mean in Git=E2=80=99s C code=E2=80=AF=E2=80=93 quick rules o=
f thumb

- *_clear():

  effect: Free only the heap=E2=80=91memory owned by the struct (arrays,
strings, hash=E2=80=91table buckets, etc.) and reset its fields to an
initial/empty state.

  reuse possible: Yes =E2=80=93 the variable itself remains valid and can b=
e
filled again.

- *_release():

  effect: Historical synonym for the same thing as *_clear(), kept for
backward compatibility in a few low=E2=80=91level APIs.

  reuse possible: Yes =E2=80=93 same as above.

- free_*() or *_free():

  effect: Free the struct itself (it was malloc=E2=80=91ed) and everything =
it
points at. After the call the pointer becomes dangling and must not be
reused.

  reuse possible: No =E2=80=93 the storage is gone.

- *_clear_and_free():

  effect: Convenience wrapper that first calls the type=E2=80=99s *_clear()=
 on
each contained element and then frees those elements themselves.
Mainly used for containers implemented as macros.

  reuse possible: Not applicable =E2=80=93 it is meant to be the last
operation on the container.


How consistent is the convention?

- Within each mini=E2=80=91API the convention is very strict
  The strbuf API always pairs strbuf_init()=E2=80=AF/=E2=80=AFstrbuf_releas=
e(), the
strvec API always pairs strvec_init()=E2=80=AF/=E2=80=AFstrvec_clear(), etc=
.

- Across the whole Git code=E2=80=91base the spelling is mostly consistent =
but
not 100=E2=80=AF% uniform
  Very early core helpers (pre=E2=80=911.6): usually *_release()
  Code written in the last decade: *_clear() for =E2=80=9Cempty in=E2=80=91=
place=E2=80=9D,
free_*() for =E2=80=9Cdestroy=E2=80=9D

- No =E2=80=9Cmixed=E2=80=91semantics=E2=80=9D functions
  You will not find a helper that sometimes frees the struct and
sometimes only clears it depending on flags. The name alone tells you
which category it belongs to.

[...]

Bottom line

Git uses two distinct verbs to convey intent:

- clear / release =E2=80=93 light=E2=80=91weight reset, keep the container =
alive

- free =E2=80=93 heavy=E2=80=91weight destruction of the container itself

The rule is consistent enough that you can rely on it when reading or
writing Git=E2=80=99s C code; the rare exceptions are historical, not
ambiguous.


Q: Some say that if the structure can be immediately reused afterwards
without requiring another reinit the function should be named using
"clear", otherwise if it only releases memory then it should be called
"release". Is it true?

A:

Short answer =E2=80=93 no.

In the Git source tree the verbs clear and release are not used to
distinguish =E2=80=9Ccan I reuse the struct afterwards?=E2=80=9D=E2=80=AFvs=
.=E2=80=AF=E2=80=9Cis this the
final teardown?=E2=80=9D. Both variants free all heap memory owned by the
structure and then reset the in=E2=80=91memory object to its pristine, empt=
y
state, so the variable can be used again without an extra call to the
corresponding =E2=80=A6_init() helper.

[...]

Why two different verbs exist

- Historical baggage =E2=80=93 the very early helper that everybody still
uses, strbuf, was written long before today=E2=80=99s =E2=80=9C*_clear()=E2=
=80=9D convention
emerged, so its lifecycle pair is strbuf_init() / strbuf_release().

- Later subsystems standardised on *_clear() when they were introduced
(string=E2=80=91list, strvec, oidset, hashmap, etc.).

- Because Git=E2=80=99s internal APIs are used by thousands of call=E2=80=
=91sites,
there has been no large=E2=80=91scale renaming; both spellings therefore
coexist.

[...]

Conclusion

The folk rule you quoted (=E2=80=9C*=E2=80=AFuse clear if the struct can be=
 reused,
release if not=E2=80=AF*=E2=80=9D) does not match what the Git code actuall=
y does:

strbuf_release() allows immediate reuse =E2=80=93 just like every *_clear()=
 helper does.

The difference in naming is historical, not semantic.

If you want to know whether the variable itself has been freed, look
for free_*()/*_free(), not for the presence or absence of the word
release.


Q: Do you have other examples than strbuf_release using "release"
where the function behaves like a "clear" function?

A:

Yes=E2=80=AF=E2=80=93 a handful of other helpers are spelled =E2=80=9C*_rel=
ease()=E2=80=9D, yet they
merely clear the inside of an on=E2=80=91stack/object=E2=80=91lifetime stru=
ct and
leave the container itself reusable

- Line reader: void line_buffer_release(struct line_buffer *buf);
  Closes the underlying file descriptor and frees its internal scratch
space; the struct line_buffer itself remains valid and can be
re=E2=80=91initialised with line_buffer_open() if desired.

- Packet=E2=80=91line writer: void packet_writer_release(struct packet_writ=
er *writer);
  Calls strbuf_release(&writer=E2=80=91>scratch_buf) and clears a few flags=
;
the struct packet_writer lives on so the caller may point it at
another FILE * later.

- FS=E2=80=91monitor IPC channel: void fsmonitor_ipc__release(struct
fsmonitor_ipc *ipc);
  Shuts down the socket, frees small temp buffers, and zeroes the
struct for re=E2=80=91use inside the long=E2=80=91running daemon.

All of these match the behaviour of strbuf_release() rather than that
of the many *_free() helpers which actually free()=E2=80=AFthe struct itsel=
f.

How many are there?

A quick git grep '_release(struct' over the Git 2.50 tree finds fewer
than a dozen hits, and every one of them follows this
=E2=80=9Cclear=E2=80=91but=E2=80=91don=E2=80=99t=E2=80=91free=E2=80=9D patt=
ern. In other words:

- *_release() in Git never deallocates the container itself.

- The form survives today only in subsystems that pre=E2=80=91date the late=
r
project=E2=80=91wide switch to *_clear() (or that wrap strbuf_release()
internally).

- Newer code consistently uses *_clear() for the same semantics.

Bottom line

strbuf_release() is not unique, but it is the template that the other
rare *_release() helpers copy: they wipe the contents and reset the
struct so you can keep using the variable. If you are looking at Git C
code and see =E2=80=9C_release=E2=80=9D in a function name, you can safely =
assume
=E2=80=9Cclear in place=E2=80=9D =E2=80=93 not =E2=80=9Cfree the object.=E2=
=80=9D

---------------------------

In short it looks like it doesn't think there should be a distinction
between *_release() and *_clear(), because in many cases the existing
*_release() functions (starting with strbuf_release()) leave the
struct ready for immediate reuse.

For the documentation update, it suggests:

  - `S_release()` releases a structure's contents without freeing the
    structure. In older subsystems (e.g. *strbuf*), the helper also
    resets the object to its initial, empty state; newer code should
    prefer `S_clear()` for that purpose.

But if our intention is to tend towards a clear distinction between
"clear" and "release" even if in practice there is not a clear
distinction right now (because of historical reasons), I think we
could compromise with something like:

- `S_release()` releases a structure's contents without reinitializing
  the structure for immediate reuse, and without freeing the structure
  itself. In older subsystems (e.g. *strbuf*), the helper also
  resets the object to its initial, empty state; newer code should
  prefer `S_clear()` for that purpose.
