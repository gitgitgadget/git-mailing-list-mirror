Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E7801
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757218243; cv=none; b=FcM2/Qnbs5v0qOMDxGNcPzodTdhVWwfmCgpFV8DYuin3QMm/0M+TWKXhaTct6HlFxiBIffw9GHkTzoy28qPnP8U8NMrnWqK7cIVjtjVkebrl8PBhLLzGl0mWAcoacuhONP63sK9kViOMY6LB1wbvkEgSKyxoTPpLTOXIP9F3m2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757218243; c=relaxed/simple;
	bh=cxuSsUcv0RUnRNszVIvL3yMKxjjCCIB5dFRaWrB4FUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVUKrbyziJW2NbugkU0OlfXwU301I+lBIRS4Tu8N9KYs/kBBNL/X+cC7yuVLe8FGoalK7DqMryaFkM4bXuIuJyIY+oJQBRmOkhDg/GnQuZrgAEEe1QhAYMQf53nfWLkm3SSX/Vo5DPA4pBoLJjD6MvKkFvNGqK2LkFLy8N7Z1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKRHm7Ep; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKRHm7Ep"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ffe6666f8dso3044795ab.2
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 21:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757218240; x=1757823040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3bdIN1o6zRgorB5KOO++vN6dGRWFERJge9a0l2u7A4=;
        b=ZKRHm7EpDh6KX76AxFJm5v7mNmRAZfRpoiKnT+cCiOnL4R3J04thxeAOoKXS3pR/3w
         AEVZXZmDNXliS4mQzpXhbo+PdXD9XPNxpRcrf44szWk7kPflzXXk9Rm+SlGZmCEJaCMG
         q6BBnf/K0Tm/D4QWfLqKDID0ommGf+aaLrs6mQCyNtPjDiTH1GmP047lFzaRSfEYLHb5
         zp/kvBkKw0rUEDDKc5dmF1hj+I9NTK6YMVEC9NYo91fFkyoL0e8z3Lp2IRSrp3sA7wlg
         0CmE0uoN2p1ozNVIkfmdbODTktNXyucFv7CP2bHIdfhXoF7EGNtTICxPp2ySEyWsSZzD
         W2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757218240; x=1757823040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3bdIN1o6zRgorB5KOO++vN6dGRWFERJge9a0l2u7A4=;
        b=dQpiTS7L9ipZXZnoF1M/oQq2JulEm7K15HsbVMm19BxS4MBo37Vr/O4mh+XgSU0QiG
         am5jQZckr/acXpG4OG7yINXwUp1TgUCzMcZ2I75MxBOzV0pxs3LPcHB/Il9t0jUnlhQR
         29omDNUrm/NBs/NeWrEesVXn14rUqjfNNL5jYYchm2PR8dzTQ1MPITuhIFfmTQ2AWnZ5
         3izIGELGROhTJiCkxHiArltCcgHXhE5u6LVBdFDv/swiN7brxYc6p4WcbJeFgNv91+cx
         +k1n40QYlmTNM0w4xnKJMJiBbNDDXidsLxQ6a+WKSBf1eJ/QjNcNJV+adClQMPy8wGjq
         8I/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWb57/zt72zQV85520eCJPPYkQt+mcVpF4sEYaW1MFkhLH41QbPoVFa8GxHtzau0Sxlar0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLcuynAoHcernN5Eird47KsfKUjRTQOS07ewOLr+49x5Ai0dC
	KNQ0uP8vfNr53KuYqKKv6CTVHk/VIXvwKywdrtMNyemlvSXViOqAun66qkr2Ty8dADmRdg1uNbK
	8f+H+3GKvPI7qs0Onr5rMLHGycF2XcCk=
X-Gm-Gg: ASbGnct6JOsELguk9+de1FHQnZfyDLPHSrU7Z1mkD0VahFgu2bFUliWrrQhXAgnjqkl
	qwtDOfpKCREAk/DA99ScB1+e8j1TRL5/xfZP6mE1BrLhj59VC//bOs+b9o7eT0vZLdRp8luaKCK
	nIXoqZOBNyB8VLqtNNlz1x9rKmf7o2bQSmSmRZruo5kvbkz/d8RWa+Yt00g1mizxkYpJI5bdASF
	ibNCYY+
X-Google-Smtp-Source: AGHT+IGOXaMiQhIIsWouHccx8w3WVXBNEu/5Dto0wqlAwTg17A+Lx/gZdf0lqhBJqWo/81xYsPwCCZiSsx9T8TzAgO8=
X-Received: by 2002:a05:6e02:12cd:b0:401:c91c:2f6c with SMTP id
 e9e14a558f8ab-401c91c3304mr28219165ab.7.1757218240220; Sat, 06 Sep 2025
 21:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <aLqIHCdlbwF5X6Cm@pks.im>
In-Reply-To: <aLqIHCdlbwF5X6Cm@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 21:10:28 -0700
X-Gm-Features: Ac12FXzzSMolL9qdNObp1J1Wg8FnNNQYrEaMxYZuA2rXZjJ5iQyE7fv0rvvrSNE
Message-ID: <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
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

Sorry for the delay; life outside of work is challenging at the moment...

On Thu, Sep 4, 2025 at 11:50=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Sep 04, 2025 at 08:54:19PM -0700, Elijah Newren wrote:
> > On Thu, Sep 4, 2025 at 4:40=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > >
> > > On Thu, Sep 04, 2025 at 12:57:25AM +0000, brian m. carlson wrote:
> > > > On 2025-09-03 at 05:40:54, Patrick Steinhardt wrote:
> > > > Also, the approach of making it an optional component directly
> > > > contradicts the proposed policy I wrote up.  That's a recipe for
> > > > additional burdensome work maintaining two implementations, when we
> > > > actually want to make it easier for people to contribute functional=
ity.
> > > > It also doesn't provide any of the memory safety benefits or addres=
s any
> > > > of the concerns from governments, security professionals, and other
> > > > parties about the real and substantial risks of continuing to devel=
op in
> > > > C.
> > >
> > > The only reason why we want to have it as an optional component is to
> > > make the transitioning period easier for downstream distributors. And
> > > the intent is not to convert major components -- it should be trivial
> > > components that we can use as test balloons, similar to how we did it
> > > for all of our C99 test balloons.
> > >
> > > We cannot just pull the rug away under their feet without advance not=
ice
> > > that this is going to happen.
> >
> > I find this statement a bit problematic for four reasons:
> >
> > (1) "without advance notice" was already pointed out to be inaccurate
> > in this thread, including in the exact email you are responding to;
> > you could argue that there hasn't been _sufficient_ advance notice,
> > but then there should be more details about what is and isn't
> > sufficient.  Merely repeating this claim which brian just barely
> > pointed out to you as false almost feels dishonest.
>
> I think there is a difference between communication that happens on the
> mailing list/contributors summit and communication that is intended for
> the broader ecosystem:
>
>   - The former is basically us developers discussing potential futures
>     and reviewing patches. It would be _nice_ if distro maintainers of
>     Git were to read these, but given the large volume of traffic in
>     general I think it unlikely that majority of maintainers is keeping
>     up with that traffic.
>
>   - The latter is in the form of e.g. our release notes as well as our
>     BreakingChanges document. These _are_ intended to be reviewed by
>     maintainers, and the blame is on them if they don't do so.
>
> We have never communicated either via release notes or via any kind of
> committed document that Rust is going to become mandatory. There have
> been lots of large threads discussing it, true. But navigating these
> threads and estimating consensus isn't easy even for us developers, so
> it's going to be even harder for outsiders to the community.

I like this framing; this is useful.

I agree that we haven't communicated that it'll be mandatory, though
we have communicated beyond the list that Rust was likely coming:
  * The contributor summit notes on Rust (posted at
https://lore.kernel.org/git/Zu2D%2Fb1ZJbTlC1ml@nand.local/) were
widely picked up at other sites (e.g.
https://lwn.net/Articles/998115/,
https://www.reddit.com/r/linux/comments/1hcsvk5/nonstop_discussion_around_a=
dding_rust_to_git/)
  * The release notes mention initial Rust inclusion
(https://lore.kernel.org/git/xmqqfrjfilc8.fsf@gitster.g/, "Foreign
language interface for Rust into our code base has been added.")
  * The GitHub blog on highlights from 2.49.0 (widely linked at news
sites even in preference to the release notes) adds more detail: "This
release marks a major milestone in the Git project with the first
pieces of Rust code being checked in"
(https://github.blog/open-source/git/highlights-from-git-2-49/)

Now, I can fully get behind that this may be _inadequate_ notice, and
I really like the idea of a test balloon.  I'm just noting that I very
much disagree with the characterization that there has been no notice
beyond the mailing list about Rust likely coming at some point, and
want us to make sure that if we delay, we use the time to meaningfully
provide more notice than we have already.  Another optional Rust
component that doesn't build by default, for example, fails that test.

> > (2) "pull the rug away" seems hyperbolic.  I would have liked some
> > explanation as to how a transition period is expected to help, and how
> > the existing transition period has been insufficient.  You do hint a
> > little at the former, which I'll discuss more in point 4, but you
> > neglect the latter to the point of pretending it didn't exist.   In
> > short, why is a further transition period needed, and how will it
> > differ from the existing one we've already had?  It's not clear to me
> > why distributors must immediately update to the latest git version.
> > Taylor discussed this aspect in detail in this thread; you even
> > responded briefly (and tangentially?), but still as far as I can tell
> > presume the latest and greatest is mandatory for them to adopt without
> > stating why.  Maybe they do need to adopt the latest and greatest, but
> > I haven't seen folks state why that's the case.  Did I miss it?
>
> The problem here is that we don't have a story to tell yet. I agree that
> not everyone always needs the latest and greatest, which is also why I
> mentioned that I think it's fine for _new_ features to be developed in
> Rust right away.
>
> But the story is altogether different for bug and security fixes.
>
>   - We of course backport security fixes, but would that also be the
>     case if we had ported the subsystem to Rust already and now had to
>     implement the security fix twice?
>
>   - What happens if only the old C version has a security bug? Do we
>     still fix it?
>
>   - Likewise, what happens with important bug fixes? We tend to backport
>     those that are easy-ish to backport, but if people are potentially
>     stuck with an older Git version for years it will become harder for
>     us to do so.
>
> I think without us having a proper answer to these questions we _are_
> pulling the rug away. Distros may be stuck with an old version of Git
> for a significant time, and from my point of view we have to do a couple
> of compromises there.

These are good questions...but they are ones to which I suspect
delaying will not provide the answer.  In fact, I don't think we'll
_ever_ have the answer to these questions, no matter how much we delay
or discuss.  Traditionally, if an issue was more severe, it has been
backported to more versions, even if the backport wasn't trivial.
There's a cost/benefit tradeoff to be had for each vulnerability, and
changes to the area making backports either be easy or hard always
need to be weighed against the severity of the vulnerability.  I don't
see that changing, and overpromising hurts in the long run probably
more than having no guidance.  I just don't see us coming up with
"proper answers" (which I'm guessing means fully spelled out answers?)
to these questions ahead of time.  The answer to all of them is
probably "we'll weigh the severity of the issue and the cost to
backport and give the last C-only version significant extra weight in
our considerations".  I doubt we'll ever be able to promise any more
detail than that until we get concrete cases; I'm not even sure that
this statement is acceptable to everyone on the list from the
overpromising angle despite being as incomplete as it is.

> > It also feels like Rust support is being lumped in with "breaking
> > changes", which to me feels misleading.  Historically, we have talked
> > about breaking changes and deprecation periods and such so that users
> > could adjust scripts or their command lines such that they would work
> > across multiple versions of Git.  The Rust case is somewhat different
> > in that we're not discussing behavioral changes of git, merely
> > implementation differences.  If someone has both a C-only version of
> > git and a newer version of git that was built with both Rust and C,
> > any commands they run should behave the same as far as the C-vs-Rust
> > goes (unless we have our normal discussions about specific behavior
> > and any deprecations we want to do related to it, of course).
> >
> > I do agree that reduced platform support is a negative change (though
> > Rust brings other advantages that may offset this downside depending
> > on your viewpoint), but I don't see why it's a breaking change and
> > especially not a "pull the rug away under their feet" change.
>
> I honestly don't quite understand this perspective. How isn't it
> breaking that you cannot use that Git version at all anymore?

Users might often face cases where they have to use different versions
of git -- at home, at work, on different work machines, etc.  As such,
when something forces workflow changes, we have to be cognizant of
that and provide deprecation periods, release announcement notices,
etc.  That's the point of our care around breaking changes.

If _distributors_ can't build a new version of git, users can still
use older versions.  They don't have to change their workflows.  When
distributors eventually figure out how to build a newer version
(because they work around pthreads not existing on their platform, or
they add stdbool to their compiler, or they port Rust to their system
or whatever), then when the new version becomes available, users can
use it without changes to their workflow.  The _users_ weren't broken.

I still don't see why distributors _must_ ship the latest version of
Git and why folks on some platforms are considered broken if they are
using a slightly older version.  Let me ask again: has anyone answered
why this is considered mandatory?  If they have, I've missed it, but
I've asked multiple times.  Even if you want to lump "distributors
cannot build a newer version" under the umbrella of "breaking
changes", I argue it's a much different kind of break and one which
merits different timelines for handling than e.g. lumping it in with
3.0.

> > (3) the use of "cannot" presupposes the policy stance which we are
> > having a discussion about, which, whether intended or not, feels like
> > an unfair way to attempt to shut down the conversation.
>
> Sorry, that's not my intent.

Thanks, and I appreciate you patiently explaining your point of view
in more detail.

> > (4) you suggest that adding Rust as an optional component should avoid
> > the problem, yet we've already had Rust as an optional component for
> > the last three releases, going back to 2.49.0.  (libgit-rs and
> > libgit-sys).
>
> I don't really think that either libgit-rs or libgit-sys help in any
> way. These are part of "contrib/", not built by default, and neither are
> they consumed by anyone out there. So there is no reason for anyone to
> build that library to the best of my knowledge.

I'm fully willing to accept they are inadequate notice (and perhaps
even barely helpful), but disagree with the characterization that they
don't help at all:
  * they were consumed in the past by Google
  * they recently received patches from someone outside Google
(https://lore.kernel.org/git/20250826233525.2635432-1-davvid@gmail.com/)
  * they were mentioned in the release notes highlighting at a minimum
that Rust is being added to Git.
  * they were highlighted in blog posts from both GitLab and GitHub as
being noteworthy new things in the v2.49.0 release

I agree with you there is certainly more we can do, and I like your
idea of a test ballon.  Let's just avoid repeating the problem of
adding an optional component that no one will try to build except for
those for whom we know can build it; doing that would provide no more
notice and thus provide no incremental benefit over libgit-rs and
libgit-sys.
