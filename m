Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066A4C9D
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044473; cv=none; b=XRrBQ9TilPwKh0CpByf8Xq8lT1T7GtXXfdfny3i1MjWswknadXjcJQVpxjFJilvgP4F8uP9pO1wrD2120Jc3DgDxiTQ6YJfSDKCQkSfHrvWw87iv+aaCO9Hw0oJJ50ThUbpy+SLc+6RpoYFE0ddNYxW1zK+9XHBl0Iyqtg9Yu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044473; c=relaxed/simple;
	bh=qAgzJcYOk9D64ZnvtMdS6mfNWLRIXQP1dWP/1g6Wkfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT3O+3z5u7UbZ7YqDAuY1f5q8aLWGcBoJkADoezCWTIMWQ0fNtRMZ0BL5PO5LsfdzxsTAaVsJs4eXb2uofxpgb4Dvv10M6e0qPfS0s10l1CjzEHXUBRb+APVt9PF6giraEZd6qFPhXe4QRPCaRXWX7nxtr78EzAuyJNZ2AQnHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZE9V7dC; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZE9V7dC"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3f663c571ffso18129055ab.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 20:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757044471; x=1757649271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QvBBwSvJnRw6UUB84hnpKPVwdOKfUhXFV+yUWtAiCg=;
        b=JZE9V7dCiDi1MziTOKSMFiw8SZocgIeWmJRWykH7Id/nWkOBPez6FrUVIlzgStvDHV
         RoBclHIFEEJdM4Z88Ae0fqqh7Bh+g79L6fowK4/P+W+OSzctwFZW4sUgJwKfF+XEoUfD
         HoT/G7dP/lrMVekIqQoSb4S82phQPXGKKUZ/lUpH1Y/wy1jfe1xepk32OTPsX/K5IOZT
         0EYJsveb9wkxdUASDxsAPqJbIsqvRfuFXahhqAXmI8nY+fhxgFbB5rP9sSIXAFZHLDaJ
         V0fEnHyQa13trmupA3peUq7nzB7MBGCYe9dlZ0iuN9uh1gIkdWdbyYFUcp7P7o3+zdLW
         Lauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757044471; x=1757649271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QvBBwSvJnRw6UUB84hnpKPVwdOKfUhXFV+yUWtAiCg=;
        b=qmIqPnOwM6drlEWOTBAHpurqRCdS7t+R6v2/pV1ejofvkbV5VQDOWqi9e2jON04Qjq
         HeIIaX4j3tx4+I/GDRj/f++ByILEgfqVa+ZniRDy5vm4z0l1bQo4JTdOIyQdUk5sh9xP
         qWWSQoESrR65/ozXAZNT7cxvCC0JdVcwfm+aUv0G9sZ2MzkXJNbWJfo5PyQDydRAmwDh
         ZQocwzBN2CR2Yo6sJYPzNHGYvtWMPxW1sg3pP2fmKutZ9XCjIvVRZi/O0EHqFxanxeiJ
         RC4FPCk+gCo2C8uVa9hvioSLHgXC7B4r/xDHvjOhm9jumypE6Wq8Pxi71glr3jHSnUhH
         uNWA==
X-Forwarded-Encrypted: i=1; AJvYcCXIWMYm5FmulTXiT4uzsByCpypoYTkpCxtgtYoLf9cMH6CynWKkD/lC0B+VT+LKQ59Oixc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAc6CUbtSQ683npEGBQVCAFyIbz8RRNm8D8pC/F2pT5FMA2G78
	YAAwnH0xScNvqrUVfSQ52Km+BluObu26+eyZKKVz44iP7ExpK0uH1+zLS7FmVT+jMOH2nY925lw
	oPlEDzteehaxmpgIJARKrFWpt+uQLNNg=
X-Gm-Gg: ASbGncvj6iNtpEWNROW0K6NU+kw1BJ0K73zR0qpGR3Q5llHkTyv6ONfWjAJu5oI47x+
	fI2mB3axrDY15NRPOooOs5tzUFYk4yJyRIsHElTuJdOzKomodMDYt7Z+BHfcxTm/aQ6EcsBfxMs
	VJJJqG1sTdOLHsAdc5qGpLdD6RoMYdB+eJf5gMkR0qF3vfSYg+/jPqUXpCfT/TqL/evdU1pQc0l
	/jWPEHjn/XipyGrp+c=
X-Google-Smtp-Source: AGHT+IFgk937xju1ePcEpcMsS/MvUEmlmIt3mD3Z1Q2ojTmB3A0kbjITKpUpuOUsmR596PpuG/0/uAzUAdVx+8FC9DQ=
X-Received: by 2002:a92:cdab:0:b0:3ed:69d5:f71 with SMTP id
 e9e14a558f8ab-3f3ffda3362mr392434675ab.6.1757044471254; Thu, 04 Sep 2025
 20:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local> <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im>
In-Reply-To: <aLl6iFXeAvL_hvqR@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Sep 2025 20:54:19 -0700
X-Gm-Features: Ac12FXzByTGGbMQLXrP7UoGrWpFDmGIGVJCg7luykI9HkUnqRu_nIA2pa5AwdQE
Message-ID: <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:40=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Thu, Sep 04, 2025 at 12:57:25AM +0000, brian m. carlson wrote:
> > On 2025-09-03 at 05:40:54, Patrick Steinhardt wrote:

[snip]

> > Also, the approach of making it an optional component directly
> > contradicts the proposed policy I wrote up.  That's a recipe for
> > additional burdensome work maintaining two implementations, when we
> > actually want to make it easier for people to contribute functionality.
> > It also doesn't provide any of the memory safety benefits or address an=
y
> > of the concerns from governments, security professionals, and other
> > parties about the real and substantial risks of continuing to develop i=
n
> > C.
>
> The only reason why we want to have it as an optional component is to
> make the transitioning period easier for downstream distributors. And
> the intent is not to convert major components -- it should be trivial
> components that we can use as test balloons, similar to how we did it
> for all of our C99 test balloons.
>
> We cannot just pull the rug away under their feet without advance notice
> that this is going to happen.

I find this statement a bit problematic for four reasons:

(1) "without advance notice" was already pointed out to be inaccurate
in this thread, including in the exact email you are responding to;
you could argue that there hasn't been _sufficient_ advance notice,
but then there should be more details about what is and isn't
sufficient.  Merely repeating this claim which brian just barely
pointed out to you as false almost feels dishonest.

(2) "pull the rug away" seems hyperbolic.  I would have liked some
explanation as to how a transition period is expected to help, and how
the existing transition period has been insufficient.  You do hint a
little at the former, which I'll discuss more in point 4, but you
neglect the latter to the point of pretending it didn't exist.   In
short, why is a further transition period needed, and how will it
differ from the existing one we've already had?  It's not clear to me
why distributors must immediately update to the latest git version.
Taylor discussed this aspect in detail in this thread; you even
responded briefly (and tangentially?), but still as far as I can tell
presume the latest and greatest is mandatory for them to adopt without
stating why.  Maybe they do need to adopt the latest and greatest, but
I haven't seen folks state why that's the case.  Did I miss it?

It also feels like Rust support is being lumped in with "breaking
changes", which to me feels misleading.  Historically, we have talked
about breaking changes and deprecation periods and such so that users
could adjust scripts or their command lines such that they would work
across multiple versions of Git.  The Rust case is somewhat different
in that we're not discussing behavioral changes of git, merely
implementation differences.  If someone has both a C-only version of
git and a newer version of git that was built with both Rust and C,
any commands they run should behave the same as far as the C-vs-Rust
goes (unless we have our normal discussions about specific behavior
and any deprecations we want to do related to it, of course).

I do agree that reduced platform support is a negative change (though
Rust brings other advantages that may offset this downside depending
on your viewpoint), but I don't see why it's a breaking change and
especially not a "pull the rug away under their feet" change.

(3) the use of "cannot" presupposes the policy stance which we are
having a discussion about, which, whether intended or not, feels like
an unfair way to attempt to shut down the conversation.

(4) you suggest that adding Rust as an optional component should avoid
the problem, yet we've already had Rust as an optional component for
the last three releases, going back to 2.49.0.  (libgit-rs and
libgit-sys).  In this case, you helpfully provided some details
distinguishing the type of optional component you want -- the
reference to a test balloon suggests you want an optional component
that is turned on by default (but which users can easily turn off).
Am I correct that this is your intention?  If that's the case, then
that's a useful distinction, but I think that distinction needs to be
made a bit more clearly (and as a side effect, acknowledge that Rust
has already been optionally shipped in some form, and was even
specifically highlighted by GitHub's and GitLab's blog posts about the
v2.49.0 release, among other places)

> > For example, there is zero chance I will implement any of the
> > SHA-1/SHA-256 compatibility code twice.  I'm already doing that in my
> > free time without any compensation at all and it's unreasonable to
> > expect me to do it twice or even to #ifdef out all the places it would
> > need to go.  I am happy to let someone else take responsibility for the
> > project instead, however, if they would like to do those things.
>
> And that's totally fair. From my point of view, this compatibility code
> is a _new_ feature that we are adding to Git. And as I mentioned, I
> think it is reasonable to say that new features may be implemented in
> Rust now already, as platforms that aren't yet ready wouldn't lose any
> existing functionality.

Am I correct to understand that you're suggesting a policy where brian
cannot modify any existing code to be written in Rust, and can only
add new Rust code?  Perhaps the SHA-1/SHA-256 compatibility code is
just new code, or can be done with minimal changes to existing C code
while adding new code.  If so, maybe this is a workable solution for
him.

But if it can't be done with minimal changes to existing C code and
this policy would impair brian's ability to deliver the compatibility
code, then I think this policy would be unworkable.  I really don't
want to hamstring brian's ability to implement the compatibility code.
It has sat dormant for years with no one else stepping up to the
plate, it's a really important project, and brian has time and energy
now.  I don't want any chicken-and-egg problems introduced for him
with the 3.0 release.  Even though I've been working with Ezekiel on
xdiff, and I'm obviously a bit biased in that area, I find the
sha1-sha256 compatibility work to be more critical and something we
should do everything possible to facilitate.

> I think most or even all of the contributors are on board. But we never
> really talked about timelines, or how we want to introduce Rust, so
> that's a discussion we need to have now.

Agreed.
