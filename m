Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793790135;
	b=XlZXWPm0OA/UmJlMrW/7EVuHloeHr8da174WxRvgeJbKwJs/EzC6eH9tli4x2OOHU8S4
	 tM6k2c5AjY7sM/hR06WI+d7hk5gnBgCXHd0rzwKm9Q//Vhi7vSIwty+WZpChyS2V8Uh3f
	 sSejMAwy/GvX4RMAFOoOBG1s2gHSeXYorEv6Cl9MwJvYnPLdlMCBp8k2CK6Nh7KXUfIRe
	 C1FBYoFtpJXfUO35fRy2fuXRvRR5aUDW0mrhwJzhfe02eM/F5jkl9Ay2OmMjkUaf2neiW
	 AnV8Iplw2jSf1REExqw3gZL6ajQo4fxfuVllE0Ge4gLnnM1aKuq5UdGc3LrfkRTNDYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=cgtYzTtvOQqkOZGMBiu7HHbF+elKruQJQj5KCZVOPZ8=;
	b=i7kLkaR/PWVHmtvY16/RGuZs3p4GuBxSKy4Wiw7V7d6IH6VJIXna4ycI7Dh8u2oXUWE0
	 lymnmmxA7DI6ehkP2VoWRDzkngMCB+N8eqaZO9JL6wHkerYca3aOWR6heM3+ww79XnGap
	 PdZhqp2LWSebDmozB4Vk5DjqQfO9pvZSaxLJ5SP7GEF+yWVKJtERgjm8CZs1hWsgF9mvF
	 r3pjivifM8FHA0/iwC/WIoXgKyBmtXcb0pbuMrSKOPIEw40WgMlSuctMnmL2MpDB2PwRQ
	 /OW63oFsNJ0ZGgOvhFkfUNLVArbwsJljhRaUjPU1N47OyHecl3KIwNRJBAN7lvUsGew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=At9z6UPx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF2606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 11:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=At9z6UPx
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso81805866b.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 03:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793790133; cv=none;
        d=google.com; s=arc-20260327;
        b=Ms6mV3TiCr6D9aBe5DvkNfhyM4ad3/Mf6V2cNAMSKFH40/wbimiKH7/FUiGYBj8lrZ
         HIGHDXa4ZTiEeB6qIbXZvLKBWTYPcjqdl+ym3Uodnl2N8vCRTxZc5FNmHovdbLP+snYZ
         AuFBVK04lNjmU9ObAEY1DTI/rXKkdA3GN9cGitSCXPQVG/cAtF30UUIFsYrTMP1p4hlN
         2Mo6ug0R0ZfoOETct2lda3Yb8lTPU1HweRS61x0uJSV8HKBz4e9RrPayiehLbc/xyVkT
         clom8TeU62APfUK+B1UTHCBnIVLYrPT1YjBjd5cPlkiV0Q2h150S+1ww1WZuL2UZJr6A
         /+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cgtYzTtvOQqkOZGMBiu7HHbF+elKruQJQj5KCZVOPZ8=;
        fh=XFXdqdUIo3+pA2Q2YhulAXrnnNhVRPb+Yy9g9cVlqVM=;
        b=Rh3Z92A8sZI0zYu5jHaDi81Q+0F+nbvBCUMH+6cW0oDvpqI+679LNYP3JKrT19wpu9
         tnPQQ0U1EXtcXSm8+hiPeOwQnSkqUQMItmwT5kyvM/a4ojxbRKrqXtaFTj2zdHPLgKbi
         tF+e6Z/5gzJ+LDGGXgQH8TrcKKBWcqhq9pACcsR6CL6c04Axm8IDQOGlbrThwjmz/GeM
         SjfRDhGIFyStM+16I+W9mD8wfkQkPDUGVHrkI0w8tizSkulUqalL3S2lMWeAMt+7pWIa
         Gs4hklr4/0ODGA7TloOPnpldhnunxRpLd5bsW7Oql6kIU5ETlhAQXfRWdJXzESoSuwLb
         kx6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793790133; x=1794394933; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgtYzTtvOQqkOZGMBiu7HHbF+elKruQJQj5KCZVOPZ8=;
        b=At9z6UPxppV9Ze14XHlN8B9JIjZ0UqKKBHl/AJbRMezjl/JBCRDQAJqcB+p5Hki3o4
         dtMhp6ER0/G4/oHdxbC4GqVNK3y9QWU7uS6g3K3Q4IQzuhW4VwtBSE69175hQ4VhgJXd
         44s3WBWb8yz96SYwu0vyIE1/tbE2WLlHFRFBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790133; x=1794394933;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cgtYzTtvOQqkOZGMBiu7HHbF+elKruQJQj5KCZVOPZ8=;
        b=qVMg8AzCAcQkS8FYgYkTp17JQpjtYMhUCxVYh08QlDkqcWliOVCCQfEYFD9le7E4JW
         +sFYIevOopUeTf4CKdNkj4XY4ZRbnoo6YMT/EyVhmmWRX/Nx9xjjXKiuBiD081OOle5d
         rkwpS7Sd+F81niuImhZEZjs0+xrgvBgyOo4w5wo6NmpvM1jX592HcdCYYGAg6+CvduFK
         FdzgCh8ncwP5ocxt+9jpyVUckLQRpPR4CpTEfLUJPhk5YmAtC7CK3F5grauFcKd1OEnf
         2QGGnKhkLj43YL45uzUmR3hw5RzyB2wyo6i4c2kUQFAy2F/QerIW9AERSvaRjGPBk0i7
         6NFA==
X-Forwarded-Encrypted: i=1; AKwUvBwuZqjsOAmdQg3J0uDrShHpIrCbgFkAYkHahOTKon9EcVxzZ8I/HJ2J4TtjtsPonP9bRHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+IDFaIpFljPeXP8YhyW4dXJXYcZqDTjZwxunAZCcuT+fH6Y9/
	xBMqzaXX6CnwgIz4AT4t8IsGdlbPgRqDsNzro+/2dvYqKpDaMFXHujsymqRDUoRCDSj3oVpdhVf
	Oj+PnjUztVW0P0WQdE08jRfxF8KFcmmgDcK0+zETyR/72PNm2lqpt7O9Y8w==
X-Gm-Gg: AYBFou3ITZqNmAbi1KqBr5gMC17adYvDLxOcvK9dvYFA4dvV2/RLrtFkEeO6aCwd08Y
	ShlP8yjjkgPunwwnrHU9rOvlgNhwAjIDvuUyd8V6UMFXSZUc+Bx96RdQu2m5aKfwB+fPcIhIVsX
	NC9SIuNXX8D7JivI4Xk+Eu3TxFES/Q+1CpJQQ8UrdrjSEUSo1Ts3iW1ADuksueuoABNZep3OPsL
	J4hIVLWvF2JGJf1vI1Em7FAzan0xAKUVfsRYnVo3vENrj7M3MxIE2T1DDIkOoAGNcHS0BgyK+xw
	frTU62fmx977zlx7+uFYDNKM4qLzDCslQDfrzf/yShRRdhOda5RD4x7m5SBPS0SU+nwkElyI1tC
	JAZUUNPscZxcHiHbmzcJqWOlHxZ0SgpgTrg0jdQxDcIpiHDGelzWqI8tI96E=
X-Received: by 2002:a17:907:6d21:b0:c2a:fcb7:62f2 with SMTP id
 a640c23a62f3a-c4ca7a4e848mr1542878966b.19.1793790132656; Wed, 04 Nov 2026
 03:02:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031065525.19883-2-torvalds@kernel.org> <auiGP4XhObUzC9vD@pks.im>
 <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
 <aumKXUS7_x0i7ZU1@pks.im> <xmqq5wyd4epv.fsf@gitster.g>
In-Reply-To: <xmqq5wyd4epv.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 4 Nov 2026 12:01:58 +0100
X-Gm-Features: AclHuK8zaPhOD7pa_U3aQaeHejzwsxXCiMhLBtKtEM5D4WyA7uSz_8P0D3FUk4A
Message-ID: <CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 01:34, Junio C Hamano <gitster@pobox.com> wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > An alternative that might be worth considering here is to instead make
> > users opt-out with "--no-exact", and then make that discoverable by
> > emitting a warning in the case where we don't have a commit graph in the
> > repository.
>
> That would work as an escape hatch.  Sounds like a good plan.
>

Sorry for being a bit late to this thread; I have been playing
around with a local prototype for this problem, and I wonder if it
would be possible to make the escape hatch largely unnecessary, by
making the depth exact (or very close to it) without generation
numbers, at roughly today's cost.

The problem today is that the walk eagerly increments a tag's depth
for every commit it visits that does not carry the tag's bit yet,
but if the bit reaches that commit later via another path, the
depth is never decremented.  My prototype instead keeps one counter
of all visited commits, and per tag a counter of visited commits
that carry its bit.  The depth is then the difference of the two,
whatever the order in which commits were visited.  When an already
visited commit gains a bit late, that tag's counter is bumped and
the commit is enqueued again, so that the bit keeps propagating.
As bits are only ever added, that happens at most once per commit
and tag.

What remains is knowing when to stop.  With the queue ordered by
generation number, as in Linus's patch, that is exact for commits in
the commit-graph.  For commits outside of it, it is exact as long as
no commit is dated more than some epsilon before one of its own
ancestors.  That is a sufficient condition, not a necessary one: on
linux.git the worst such case since v6.0 is about 60 days, but a
miscount also needs the skew to be right where the walk stops, and
an epsilon of a week gave exact depths for every commit I tried,
including the ones right around the skewed spots, at no measurable
cost.

A nice property is that this also works well with a partial
commit-graph.  The commits outside of it are visited first, and only
those rely on the epsilon; once the walk reaches the commits in it,
it can stop as soon as the depths are final.  So the commit-graph
does not need to be fully up to date to help, much like with other
walks that use generation numbers.

For 2a500a04d6f9 it gives v7.3-19059 with and without a
commit-graph, in about the same time as master, and it matches
"rev-list --count" on the ~450 commits of the last merge window.
Both expected failures in t6120 pass with it, with and without
GIT_TEST_COMMIT_GRAPH.  The change is about 120 lines added and 60
removed in builtin/describe.c.

Would this be worth pursuing, either instead of or on top of
Linus's patch?  If so, I would be happy to clean it up and send it.

Thanks,
Kristofer
