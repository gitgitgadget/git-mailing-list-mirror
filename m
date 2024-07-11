Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B34F1E2
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739752; cv=none; b=MVb9sqdr/YzT/DJTL8AkkEEzUV1Swggm4Pt7xj03v3pOYN9SKAPiJOsbznyIGY6GpVTmfayfqBr2gVix/OJobw9lrdqsrt3X2xxIzLKQhAosfgPUj9IPlH932gHEYruI7DO+fyql9q65hKpEiqR6R1f2FcLcixrl7tpS/G5N6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739752; c=relaxed/simple;
	bh=7WsuhAo8fMmFJUrrXNOVHkt4Dqx+aea5hFCD0Zm8tdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JudGeivJJ6OvBkfj2qMJYJa5MhTW5o1JGxEnjv8dvb6xK1p3ADmSd0qM1booD5l0FigPyBBkl/KNaVqzrtbbvy+vnUgOjpHnFiCpUQpC3OQ+LcrBm2utw8Kn6iCOjR5OckALdeZuxwFPQNwK5NpdS09M6SOvw/toh3NczU2b4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3I0lPPT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3I0lPPT"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44a8b140a1bso111771cf.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720739749; x=1721344549; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeevlQXVq1lfiv/C1gpygGjfTyO2sjcs/30p2Y2iVr8=;
        b=W3I0lPPTnyWzPVDVHZaGN2s2nw2D4FmM/rLWyhrlYwzBgMYl5tnxRIFOJgy111mTJ/
         z8OI0bdwSnNwIHx1SuBBCDuecHwjseS4W6I5CW0JItuJlkJXDOkp3LOqau1RpLr3TwBY
         fCfNIQ01wv9B2q2xUKAMAvicWxJgAHwsOPKv6stemvsHiSQIYfKRLpbdLVar4zjQ8iKA
         k2lpqQ5BlUmqfCCJRAGJcEV1+JO5y7XFKS4VT2Xoo1Gl6Fe8Qq/Fa1hFgAASTOdUvYwe
         0DXiy1kmg8Smpq5zwoZQz+Y+wWRk0mzkJ90xUW2ni7D7qeds2dGjXN4cmU3cOWvtmxgX
         vqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739749; x=1721344549;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeevlQXVq1lfiv/C1gpygGjfTyO2sjcs/30p2Y2iVr8=;
        b=M8TZsYjPbR8uZMhoPDcEU8MTR3MSFuqcAPlx73eIQ7jJsff5AOYdWOIm4Emi2g/ets
         KrS0322lHNsIR3cq3g9Aq4qXEkrpmPS0xxG9xPLgZxaiLQqpzOZttNYFWWi6Uhn2LsTs
         VnOShgoS5PEsg7I/A5YAdksGh4B3Wcl6/+cExMCeUppDojzzqQc9qbC27nwMXDjSptpl
         2FqlsPB52rP5D+2E5bPHQDfkEvmYcYSgTxvBessir7skXTWpbSh0bu19ctyjZTwqsh1U
         Yu8gTBJj0pomcwlTo1rrR3xVl4m3ORCkkJB+ITQfXSmw94V5a+7QNDzlCORG0GAecQCK
         CIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRYpsdRoBBQsKb7EaKAvsVgk37RIREGJDGqGmRbJgRBErSVRTOQBzkpN8WzUOZO4S+Jxxvv0lP6Zppp9DIVHuwGoqA
X-Gm-Message-State: AOJu0Yx8ZxsGNWW4KPOvj23HQcGBQl19WytHGiQHQ6EUsKQW0oX4+CsI
	xgXczq4RXcQwLlOmYYMJI+36LN3zT9GeDLPGiD5iM5+7YHtV1y5tT0GwafGRzFFkwGDMtJmpGSE
	J7sxtGerVBDMknCH+r5gT9aO/Hytw8yIPfU5N
X-Google-Smtp-Source: AGHT+IH2ptLF3b/2Ev3O0L266KZc25wfkyulgami83Bg3GbS6AT06yDmsO5Ysr1DdEKPHd1/jLppiRbzsgw5gy8fQks=
X-Received: by 2002:a05:622a:164a:b0:447:e76a:c04b with SMTP id
 d75a77b69052e-44e7341afe7mr1492301cf.10.1720739748997; Thu, 11 Jul 2024
 16:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
 <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net>
In-Reply-To: <ZpBbgXYQlpHZa3xR@tapette.crustytoothpaste.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 11 Jul 2024 16:15:35 -0700
Message-ID: <CAJoAoZn+R3qhoVA=av8NMcCAJyRHOe6QTXV=pyjs80JmV0mVzw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Emily Shaffer <nasamuffin@google.com>, 
	Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:24=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-07-11 at 18:14:36, Emily Shaffer wrote:
> > On Tue, Jul 9, 2024 at 4:16=E2=80=AFPM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > I think it's also worth discussing what we require from a platform we=
're
> > > willing to support.  For example, we might require that the platform
> > > pass the entire testsuite (ignoring irrelevant tests or tests for thi=
ngs
> > > that platform doesn't use, such as Perl) or be actively pursuing an
> > > attempt to do so.  We may also want to require that an OS be actively
> > > receiving security support so that we don't have people asking us to
> > > carry patches for actively obsolete OSes, such as CentOS 6.  Finally,
> > > some sort of time limit may be helpful, since some Linux vendors are =
now
> > > offering 15 years of support, and we really may not want to target
> > > really ancient versions of things like libcurl.
> >
> > I sort of wonder how much of this is taken care of by expressing
> > "fully supported" as "can run in GitHub Actions". Even if an LTS
> > distro is 12 years old and using ancient curl, will GitHub still be
> > able to run it in a VM/container? Maybe there's no such guarantee,
> > since you can hook up self-hosted runners (which sounds more appealing
> > if someone's got something weird enough it doesn't run well in a
> > container).
>
> Some older OSes require kernel features that aren't compiled in by
> default, so containers are out.  For example, CentOS 6 won't run on a
> modern kernel because it lacks whatever the predecessor to the vDSO was
> (which can be recompiled into the kernel, but nobody does that).

Is this hinting that we should mention a minimum kernel version for
Linux-kernel-based OSes?

>
> We also don't really want to be on the hook for trying to support OSes
> that get no security support.  We don't want to be running an OS
> connected to the Internet that has known root security holes, even in a
> CI environment, so I think _someone_ should be providing security
> support for it to their customers or the public free of charge.

Agreed - I added this to the minimum requirement section like you suggest.

>
> I also want to let us use new features from time to time that may not be
> able to be conditionally compiled in (such as new Perl features), so I
> think maybe setting a hard limit on a supported age of software might be
> a good idea.  If we want to have good support for LTS Linux distros, we
> could set it at 10 years initially.

Sure, I added this to the minimum requirements for now.

>
> Also, if we do decide to adopt Rust in the future, we'll need to
> consider a different lifetime policy for that.  I try to support an old
> Debian release for a year after the new one comes out, which is about
> three years for a compiler version, but anything older that that becomes
> a real bear to support because most dependencies won't support older
> versions.  Since we're not using Rust now, we don't have to consider
> that at the moment, but it's a thing to think about when we're
> discussing policy since different language communities have different
> expectations.  We might find that we need different policies for, say,
> Perl than we do for C.

Yes, definitely, the Rust bits will be a whole different conversation.
I do think it's gated behind this - is it ok for us to even add Rust,
given our current support story? - so I'm happy to punt on it for now,
frankly.

>
> > """
> > Minimum Requirements
> > ------
> >
> > Even if tests or CI runners are added to guarantee support, supported
> > platforms must:
> >
> > * Be compatible with C99
> > * Use curl vX.Y.Z or later
> > * Use zlib vA.B.C or later
> > ...
> > """
>
> I think to start off, we could say that it has to have C99 or C11, that
> dependencies must have been released upstream in the past 10 years, and
> that the platform and dependencies must have security support.
>
> I mention C99 or C11 because Windows _does_ have C11 but not C99; they
> are mostly compatible, but not entirely.  FreeBSD also _requires_ C11
> for its header files and won't compile with C99.  I think the difference
> is small enough that we can paper over it ourselves with little
> difficulty, though.

Added both for reroll. Thanks for the thoughtful suggestions :)

>
> > > At the same time, we do have people actively building Git on a variet=
y
> > > of platforms and a huge number of architectures, including most Linux
> > > distros and the BSDs, and we will want to be cognizant that we should
> > > avoid breaking those environments when possible, even though, say, th=
e
> > > porters for some of those OSes or architectures may not actively foll=
ow
> > > the list (due to limited porters and lots of porting work).  I imagin=
e
> > > we might say that released architectures on certain distros (Debian
> > > comes to mind as a very portable option) might be implicitly supporte=
d.
> >
> > Are they implicitly supported, or are they explicitly supported via
> > the GH runners? Or indirectly supported? For example, the Actions
> > suite tests on Ubuntu; at least once upon a time Ubuntu was derived
> > from Debian (is it still? I don't play with distros much anymore); so
> > would that mean that running tests in Ubuntu also implies they will
> > pass in Debian?
>
> Ubuntu is still derived from Debian.  It is likely that things which
> work in one will work in another, but not guaranteed.
>
> I mention Debian is because it has a large variety of supported
> architectures.  I absolutely don't want to say, "Oh, you have MIPS
> hardware, too bad if Git doesn't work for you."  (I assure you the
> distro maintainers will be displeased if we break Git on less common
> architectures, as will I.)  In fact, MIPS is an architecture that
> requires natural alignment and can be big-endian, so it's very useful in
> helping us find places we wrote invalid or unportable C.
>
> The reason I'm very hesitant to require that we run everything in GitHub
> Actions because it only supports two architectures.  ARM64 and RISC-V
> are really popular, and I can tell you that running even a Linux
> container in emulation is really quite slow.  I do it for my projects,
> but Git LFS only builds one set of non-x86 packages (the latest Debian)
> because emulation is far too slow to build the normal suite of five or
> six packages.

Does that restriction apply to just GitHub-hosted runners, though?
Would it be possible for an interested party to set up self-hosted
runners (configured via GH Actions) that are using AMD or POWER or
whatever? (For example, I think it would be quite feasible for Google
to donate some compute for this, though no promises).

The appeal is not "because GitHub Actions are great!" for me - the
appeal is "because most Git developers run the CI this way if they
remember to or use GGG, and Junio runs it on `seen` all the time". If
there's some other recommendation for self-service CI runs that don't
need some careful reminding or secret knowledge to run, I'm happy with
that too. (For example, if someone wants to set up some bot that looks
for new [PATCH]-shaped emails, applies, builds, runs tests, and mails
test results to the author after run, that would fit into the spirit
of this point, although that sounds like a lot of setup to me.)

>
> And it's actually much easier to run Linux binaries in emulation in a
> container because QEMU supports that natively.  Most other OSes must run
> a full OS in emulation, which is slower.  There also aren't usually
> pre-made images for that; I tend to use Vagrant, which has pre-built
> images for x86-64, but I don't really want to be bootstrapping OS images
> other architectures in CI.
>
> So I'd say that we might want to consider supporting all release
> architectures on specific OSes.  I think Debian is one of the more
> portable Linux distros (more portable than Ubuntu).  Debian has also
> abandoned some architectures that you can't buy anymore, like Itanium,
> so that might be a reasonable limit on how far we're willing to go.

Sounds neat - I wonder if this is something I should start asking
around about within Google and find out if we can contribute. It might
be feasible.

Based on this mail, I'll try to reword the bit about "add a GitHub
runner" to make it a little less GitHub-prescriptive.

Should have a reroll in the next 30min, it was ready to go and then I
got this mail :)

Thanks!
 - Emily
