Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA003F8709
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791023038; cv=none; b=CK5QJ9idJCKYl91Fw5EtEgoBnVEKPd4Pl55kYuSRotCn2FChj7/+Tz4wqQSQYTqLkasvrFFL0egjwWrlQpab3pJiAPXxnzOkPBxLApW4qhdDXl7NBrN8dLCvw/Fzv2vgNGdW4YKhJWjPLtys2zrI81pgFUKjAIMjc2fVhpjdgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791023038; c=relaxed/simple;
	bh=9Elehz+nDCmChM1gsHDAD2eyD20EIaqmdUBKf6RcU7A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L5Z4LJfn+PqphzV7kHCzrewkISUmigdO5PInCh2u9FkSRRbP2o0VWYtzcNsP2EPHET8XsPKWFRdMRrD6kAkzJUBmaXGuaOa2YlqU/mRd2ufzOJ+KB9M+2UjU/1wDDh/9pWjpzZyjjBNjhPFYunoyMGJssIkBTYRNZVmt7pUT184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BdnMB0dK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BdnMB0dK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791023034; x=1791627834;
	i=johannes.schindelin@gmx.de;
	bh=bl7mToUUe+MDxFXhtaV1+rKADF2Jf5tZo2TvSGVDvb4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BdnMB0dKW6NcRim8PJ0b0dlfdzdj4CtbJKBs+2oQqet8KxEY34Wp3kh2ujpIwpV0
	 v0HVj6M7MCU2Eb/bzZlXbjTqHV88gVKkErcehIN0xUdvzcxho4TcO9gdUC6OdugSN
	 wZo5qkAx773TBFFbM6LZQWtZ7VsbjhpxQ5akDT2qpS/CB51nI7Fn5JanhQewWUaB4
	 FXb6PgF17ZIE8pjm+N3CCY6p6hMC5Jj+6C/71bowUQUXC5EE3ajN0VvUcUaxpA9lk
	 Giu8KO6LWk8j1KQ2vY1W9EVvcwvFvuD/DqWPbdKGr0P5E6iUGsu4uJCrnyK9wdh//
	 n9Zq+HjxaVAh20AgtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1xFQoN0aMb-003Icg; Sat, 03
 Oct 2026 12:23:54 +0200
Date: Sat, 3 Oct 2026 12:23:52 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/4] Add a compile-time option to use the new, very fast
 sha1dc Rust crate
In-Reply-To: <xmqqa4p0jz0d.fsf@gitster.g>
Message-ID: <09b76ee1-2bac-4c33-b09d-d414717d3ced@gmx.de>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com> <xmqqa4p0jz0d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:DHG4Chbl2njKm9r6fT6VF/eHToF3GHqWwvXQvLV+W0Z1adRZjcN
 DhuXPalKwbTeI+iMY0uLDyKPGU8IxzvfJoOcNEW5Sg3Yh0GQXh6LkbReatPITmwlGIWR1HA
 3f6RLzuCX3yO0mjzrWmue6a+gpk+Mj8mZGBHtQQ4DYsdD7nIrdmG/vNRtdd7wXsGkjHXhIx
 q50oTijSlqY1gzCURN5Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NWn4rzLHEcg=;03PaNy117wASulyFoA2+HIe8+Rj
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 29 Sep 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > I stumbled across this new Rust crate last week. Its performance
> > numbers are quite impressive. Naturally, I want to make use of this
> > and get for Windows, which is used on many monorepos where this makes
> > a real difference: In a pretty fast and loose test, I verified that a
> > git index-pack runs roughly three times faster solely due to using
> > those SIMD-based optimizations!
> >
> > As a safety precaution, because this sha1dc crate is quite new, I
> > wanted to introduce an escape hatch: core.sha1dcBackend=3Dc, but turn =
it
> > on by default, which is the reason for the three additional patches.
> > Should these patches be undesirable for the Git project? I would not
> > be mad at all if they were simply dropped.
> >
> > Johannes Schindelin (4):
> >   libgitcore: add `sha1dc` as an optional feature
> >   sha1dc: allow selecting the C backend without rebuilding
> >   pthread: provide `pthread_once()` shims for Windows and for
> >     NO_PTHREADS
> >   sha1dc: make `sha1dc_init()` thread-safe
>=20
> The feature sha1dc_choose() means that you can between Rust and C
> implementations of sha1dc pick at runtime and I was confused by the
> "compile-time" in the topic title, which is misleading.

Right. I was almost certain that you'd reject the runtime flag, which is
really only interesting for binary-first distribution vectors such as Git
for Windows but not source-code-only releases such as core Git's.

> From the end-user's point of view, being able to choose between the two
> at runtime gives them a lot bigger value, even though from the point of
> view of the developer who added the feature to allow users to do so,
> that feature being a compile-time choice might matter more.
>=20
> How close are these two implementations?  Do they implement the same
> idea but the details may differ?  Do they both faithfully implement
> what the same paper wrote and given the same fudged input they will
> always detect the attempted attack the same way?

Those two implementations are quite different. As the author of the Rust
crate detailed in https://sam.dev/blog/faster-sha1-collision-detection,
they first tried to accelerate the quite faithful Rust port of the library
that is used by Git, and while there were some gains to be made, a more
fundamental approach proved to offer way bigger wins.

While I would have _loved_ to have the time to dig into this myself, armed
with pencil and paper only, and doing maths again for once, I simply could
not afford the time to assess the validity of the Rust `sha1dc`
implementation without AI assistance. With that disclaimer out of the way
(which should actually _increase_ your confidence, because I haven't been
in the math business in a very, very long time, so the double-teaming with
GPT-5.5 Sol and Opus 5.5 probably increased the soundness of my analysis),
here are my findings:

- The Rust implementation chooses a different approach from the C
  implementation. The idea is the same, though: to dismiss as quickly as
  possible as many of the DV vectors (each check can cover several of
  those at once). It's just that with SIMD, the technique differs, and
  that informs about the order and the grouping of those checks.

  (In more technical terms: The UBC filter is different, not the overall
  collision-detection algorithm. Both Rust and C implementation cover the
  same per-DV affine solution space over GF(2), albeit with different
  equations).

- While the approach is different, exploiting SIMD-specific advantages to
  great speed-wise effects, the covered DV vectors are exactly the same,
  and the filtering and recompression checks are equivalent; therefore
  both C and Rust implementation detect the very same class of collisions
  under the paper's assumptions.

- The Rust implementation is robust and correct. I performed a light
  (well, for me, not so much for the AI models) static analysis, and then
  I ran some substantial tests. My plan was to exercise Git's entire test
  suite (with a patched-in mode that would exercise both C and Rust and
  validate that they compute the same SHA-1), but I haven't managed to
  kick off _those_ particular AI-assisted sessions yet (I would want to
  exercise both x86_64 and aarch64, of course).

- The reason why I posted this before I finished _all_ the tests? To allow
  other Git contributors an early look, and to inspire (see e.g. Scott's
  alternative), to invite collaboration on this patch series.

Ciao,
Johannes
