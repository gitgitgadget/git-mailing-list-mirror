Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE98BEE
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144909; cv=none; b=TBGwv/GrySt9YaBcn8PC03FWll4LI8SJaACs7ZHQTwgxnc/zlBEaXmF1xPHkr0b1Xfper4ooPFSqrK0ggqZ1QOcDtBCAbvRVd6sSM6KjYmAk/6WOLZ8n2cTVVow5zFJcrUqO84Sf3W1CiYBmpZm+sSfksbwD30T2w2b/0vXlYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144909; c=relaxed/simple;
	bh=NH0GueOxiiUvSJ2clMK3eSQWIYLUWjf0PzCJOB8a2dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXGpVU0ebeZ8ByhNrEd/ivLUewvKke8WsRJ58hotUuSuE9TENdRiCnyizmuglwPxVn+tnwcQkuRrkbgiKo+2L8yFfMzWvo4CEMZYxgHPBfAmyS1HyS24K1D6IHSEpwS3gkUW5ybE3qmQuKuocslkLGO/SAfRDRgy0YGspxGgUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqz5MUuP; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqz5MUuP"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8876de33c86so29419939f.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758144906; x=1758749706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDPI+GiG2dgm0odq/3PNkLLNkE9Os1HzzzS2vGUkWMM=;
        b=Tqz5MUuPGvxMny/PPZkx32SgASLZlVgN205syIp60F2YLp1cbh0XH5/CMjtAUDbE9h
         yKEE2I5vJzhlSvcF6fMjrZqPPyQ+Reu7jEpPhubUyxzSaQOAS5yMq6uR5WtDBDnZ2E3R
         AGUoQ2EpIBdC1NeNSciaC+RGbFdVxVmnKTw+6a9RDQqI+oUkLXbNZnkVFvu7OSAwOoCr
         OcwYQtCIUGhGeeaih9CSyHJWitgLqUZR5Yy7yUpuFy6Yibx7Oq5aviwc2/eFu8MH7fXX
         Byspo9surLzZvvoW6lYONUh7KefhG5ODI0YHq4eCxQLLUigudSZQc2h8ZqIzFpid/lGN
         LVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144906; x=1758749706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDPI+GiG2dgm0odq/3PNkLLNkE9Os1HzzzS2vGUkWMM=;
        b=SH6a4YgF39fvZYf/IdBuVnXuI4e7g0xv0PKOJO12UKmlniKYdUkZK9PPXbgTYSAvyV
         9KbYCyTNUAOgQ7yXuQzETacIqeuIGYXIAnhW/yL04vyA0TMGeiRN2p4wlcr2fok+p7UM
         RNnsXF6rW8aKwSJy71jG483A5nOdZVM7OYnC0b8vTLKn/kUYLeWGoNPxgMgyEoz+JWe1
         82k6LVo/s/rN5tV3vPH4m0dniJ6ba+TUfCGB5UjMlIpYnNgfdS5VT939ddbqzya83JLR
         Mw1lfoeqKJnNVw4D5fbNOPP0xac/fYaZZvVqzqQY1kTd/3fGvCbylWxsuKVnw3aBCfwY
         WvNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wqYUUVLH8A0cxrbEL+Yr6aULoEOF1szfSRbtPN9T10CH2w1/mFwCDRpVMMPxzj6Qnws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECNqB9gQCxpqkA6hLInJCTDHq1cM/lJ6exrvR4qlwxonxY325
	XvGdKSAANcwhHvVsIQMXpH3cp32+L9lX/ZbGs6uIY1Xb3uI6CkjwgR38my9DWT4Nv524iVBbQgX
	YtePQHSn3q1+RXZ5nwq2ZL18T3dnASU0=
X-Gm-Gg: ASbGncu5t6QLMYojDZjPggozVMbGHC8+R3EZz4D71soEnZyJM15Y3fC3Za8aFxvDjZp
	3HJytDRHXhxc8urVxIZqUWgiGT0HaDWLT/RIUkUrk8Dge7HS+5DKDHVBTygVwHdu4ExuMpVeL6H
	2kxsyeeWkW5T6lD9bRIWMGa0/Xod3dkbPgcMv3iA11qZJnqDOy2UI9gI/v9JWSesO4fPPpNdrG7
	j08io8YApR4ssCnZnP+0H6QQleiN3No+rOxiSCR9uKLCg9swq0yay8Knfa1dMgqZux8gQ==
X-Google-Smtp-Source: AGHT+IH2qoa0+pVTRsfljFkVSRde5m7hT9NCT7qSXgsyR58/HGp9hL/JSjn9k22G4UieFZtSe0X5xooQd5MiSqCRM+k=
X-Received: by 2002:a05:6602:3412:b0:890:1f62:492c with SMTP id
 ca18e2360f4ac-89d1bfab247mr539367039f.8.1758144906260; Wed, 17 Sep 2025
 14:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <xmqqcy7pc8ix.fsf@gitster.g>
In-Reply-To: <xmqqcy7pc8ix.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 17 Sep 2025 14:34:55 -0700
X-Gm-Features: AS18NWCOaLDdAC_IwsEZ8fBLFa8VMVV7uYObzS0koCjr2-p3SbnPaRn_W4G8_K8
Message-ID: <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:07=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This is a continuation of
> > https://lore.kernel.org/git/pull.1980.v3.git.git.1755921356.gitgitgadge=
t@gmail.com/,
> > but I am removing the RFC label.
>
> Continuation meaning that these patches build on top of that earlier
> 15-patch series?

No, continuation just meaning "this is v4, even if not labelled as
such by gitgitgadget".  "Replacement for" would have been clearer.

> > Suggestions on changes that I could make to this series is appreciated.
> >
> > Changes in v2: High level overview:
> >
> >  * patch 1: cleanup: rename variables that collide with Rust primitive =
type
> >    names
> >  * patches 2-4: Makefile now produces libgit.a correctly
> >  * patches 5,6: Documentation from Brian and Patrick
> >  * patches 7,8: Introduce Rust
> >  * patches 9-11: github workflows
> >  * patches 12-14: introduce crates build-helper, and cbindgen
> >  * patches 15-18: varint test balloon
> >
> > I would like feed back in two categories: big changes, and little chang=
es.
>
> This seems to also mix in some patches from Patrick's series that
> are already in flight.  What's the intention of the inclusion?  Do
> you expect us to discard Patrick's series and replace with this,
> which would lose some from them and then add more from here?  Your
> "pull request" may target my "master/main" branch, but it needs to
> play well together with other topics in flight that are cooking in
> 'next' and also with other topics that are aspiring to be in 'next'.

The lack of context in the cover letter is a good point; I apologize
for not having been available to advise and avoid that problem;
Ezekiel's been doing the best he can on his own for a while now with
only very sporadic comments from me, due to my daughter's recent
medical emergency (and then me being multiple weeks behind on
everything else because of that).

> So I can figure out that these patches are designed to apply cleanly
> on top of Git v2.51.0, I am somewhat lost what you want to do with
> the resulting branch.  Having duplicate commits that happen to do
> the same thing in multiple branches "git" the tool can handle just
> fine, but that certainly is a bad communication among developers
> that we do not want to particularly encourage.
>
> Before talking about "big" and "little" changes, do we need to talk
> about the series organization and working well among multiple
> developers?

I think that would be helpful, including some guidance on next steps
because even I don't know what to advise at this point.  The
background so far:

* Ezekiel contributed a series to introduce Rust[1].  Someone
contributed a competing series and Ezekiel was asked to target
somewhere else[2].
* I made a suggestion for that somewhere else, you agreed that it
sounded reasonable[3], and Ezekiel complied and redid the series
accordingly.
* Patrick wanted the introduction to be different, which is fair.
However, instead of providing feedback or suggesting doing things an
alternative way, Patrick submitted a competing series that redid the
Rust introduction without incorporating any of Ezekiel's work[3], that
was far less complete (e.g. no Makefile support, not running on all CI
platforms) and saying he'd personally add that stuff later[5], and the
series had a few things that both brian and Ezekiel objected to (e.g.
cargo delegation, ambiguous types, minimum version which Ezekiel
already demonstrated was insufficient).  I think the thought here on
Patrick's side may have been that Ezekiel's focus was solely on xdiff,
rather than having a dual focus on xdiff and Rust, but Patrick left no
guidance for Ezekiel on how he could move forward with the other Rust
parts Ezekiel did or even whether he was welcome to make contributions
in the area.
* With no feedback on how to move forward, Ezekiel wanted to try to
merge the relevant parts of the two series, including playing nice by
incorporating some of Patrick's changes -- and commented on Patrick's
series to that effect[6].  Linking that email (or even incorporating
it) into the cover letter would have been helpful, but he's new and
missed that.

(Personally, I think it would have been much better for Patrick to
send in a series with _just_ the BreakingChanges stuff, and then send
patches to Ezekiel with the help & varint stuff, similar to what Dscho
did with git-for-windows & Rust[7], and ask Ezekiel to make a test
balloon for introducing Rust.  Allowing new contributors to get some
credit for their work instead of replacing/discarding it tends to go
over better.  And, to be fully blunt, I think introducing a competing
or replacement series to something actively being worked ought to be
more of a last resort whether or not the other contributor is new; but
I'll stop there since otherwise folks might dig up my blow up -- that
I'm not too proud of -- from some years ago when someone did this to
me.)

[1] https://lore.kernel.org/git/pull.1980.git.git.1752784344.gitgitgadget@g=
mail.com/
[2] https://lore.kernel.org/git/xmqqldnggt2v.fsf@gitster.g/
[3] https://lore.kernel.org/git/xmqqzfbvfxs6.fsf@gitster.g/
[4] https://lore.kernel.org/git/20250910-b4-pks-rust-breaking-change-v4-0-4=
a63fc69278d@pks.im/
[5] https://lore.kernel.org/git/aME1ETcGAbhoO49n@pks.im/
[6] https://lore.kernel.org/git/CAH=3DZcbB0Qv=3Db-hdB2EVW-D-dob4NnzyWDYGETh=
YZm94S0V7OGg@mail.gmail.com/
[7] https://lore.kernel.org/git/ac871bc4-df93-31f4-55f2-d6fc538a422d@gmx.de=
/

So, how to move forward?

A) Modify Patrick's series to just take patch 7 of his v5.  Patrick
did say that the roadmap was  "the more important discussion compared
to the technical discussion", and merging that patch would achieve his
goal of getting an initial roadmap.  Then Ezekiel could grab other
pieces from Patrick's series (e.g. the help and varint stuff) and
incorporate it into an "introduce rust" series.[*]

B) Merge Patrick's series and tell Ezekiel to rebase, while noting to
Ezekiel that the roadmap is the important bit from Patrick's series[*]
and he can suggest changes to any of the other bits.

C) Create a consolidated "introduce Rust" series with bits of both --
what I think Ezekiel was trying to do with this series.

D) Something else?


I think Ezekiel's willing to be flexible here, but was doing the best
he could as a new contributor with no guidance.  What would you like
to see, Junio?



[*] Either of these routes are slightly funny, though because Patrick
introduced a one-quarter delay on notification to end users of the
upcoming change due to the incompleteness of his series.  With
Ezekiel's changes to build on all platforms in CI, that delay would
serve no purpose (that I see) and only harm users by giving them less
notice of an upcoming change; so Ezekiel would likely want to tweak
the BreakingChanges document in either of these cases to note that
we'll give earlier notification to users.
