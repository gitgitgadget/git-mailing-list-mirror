Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DC6F31C
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637763; cv=none; b=O9rL5sBXYf6zUW9pxNQnI9Gv0yx5uT78GxJPT/QmyWhSqpBUPiKrKePu7GRv4sYHh/CflEh8HALLMMtSMBh6JZ0tmNXmn3uKOSpLGB95bGB19fXaeZHZOUiU8Y8m60vgVii01ehFALQTpuTUg++nnmE2+3pCYguIy4FHorWxDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637763; c=relaxed/simple;
	bh=41fM41En7Fr5NQFlKYd41G0JYims/0OIQNAHjFzNXII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4YqqeBbsG5suhetaY83r9SyIrERZTl4Xm7toGlW/h0KkxJk8BPsD2vvUEEQ4SO++J32S3d9ThNHBS886U36loOTF3sjLR+THkDJqCoQqSwaizYYiXuP00eXgsocn4RgTUVyotyrjuRKsLl1e/RbJPhL1efEIKeKjR+96+qXCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpRzlwVk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpRzlwVk"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44664ad946eso36591cf.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720637760; x=1721242560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6MaZfocuqsa4AfAWjXdblZ1CxVLlgPZhnThCkBh/bY=;
        b=DpRzlwVk0YLUCfi+WUUDC6oC4k+GuONeHWNy16s2P8jFvYG1/u428Zw59vAbHfhCfZ
         0yxEf+9CrtvOK9Zggsq8eteo+flUHzyGGKhsnffTQ8anJSP5iWfl7CbMMBFqwLDA62NY
         mgXiNTOQUdzBWMI2LSOsekPB163lzpwEebmXY3eF55Od4LKbDYQjKtkn/6aYnqZflum7
         ynmG2OpqSsu/ZmFeKMUzbaP6aKehPFUs/ydivfHS87ZHUSRHuv9CdFCPA/GwYzlQ4Yev
         CssIayzhN/QLe4oWPq6EYNzObh8bqt7vsdSzt9T6QiKlV4jxgcgO5akChHZt+JpkVe1d
         4jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637760; x=1721242560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6MaZfocuqsa4AfAWjXdblZ1CxVLlgPZhnThCkBh/bY=;
        b=v7G6apaoky9UTYpYYzEOZoqLLOdqLgELjaYPuI01RN/cxFar3pH5TE2bdRQMbeXjlv
         Fl4n/WAGt5aAfoYqsRczPjkBBXQLHBuvUtMiHgxkK0kOfk5BphLrV+451x3XgkZlk733
         eoVnk18nYaTS7pE7k2QwhhdzkoglIurUEm90PAGg/4WhMhrsASQFozKaLeoereglyZMv
         WK2WEaY4p/kJ3GX6KfKOok/G8wu7J7CXB15JOJflDHXSw5gKqBpdSULtIrjR58lXnfxM
         x2ZKT9l28S5JZl/55gz7UJRfc48kLcogWmJdqS5q1aznmKkCXAZatZ5K5nZObcEnCi0N
         jY1Q==
X-Gm-Message-State: AOJu0Yygkn1UuXb6CPQLrdWY+wE8AtUuTsCVmWKQ91TATI28Y53ywZdC
	VJHZXrxvBF88cXLsU0za9/M/sZu2bfzixsu9iSztN3Lo2a0MQ8JvIeSL0Ym0Hkm9g4gT30dm8Qq
	yTPSiXj9keckw0CTlujCyn60zrAQVM7+3Av4QkpWJW91R3EENV+E6
X-Google-Smtp-Source: AGHT+IEY45a5bag4olcdBET/c/ZR1qJ57JoGfQwiX8Feg1Hgh99LTCOJkut3endi2dBSjEFHvRMj5vyhORkRBEWgC80=
X-Received: by 2002:a05:622a:44c5:b0:447:e393:fed1 with SMTP id
 d75a77b69052e-44d118931afmr317401cf.7.1720637759706; Wed, 10 Jul 2024
 11:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com> <xmqqfrsi9i8y.fsf@gitster.g>
In-Reply-To: <xmqqfrsi9i8y.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 10 Jul 2024 11:55:45 -0700
Message-ID: <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > +Platform Support Policy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Git has a history of providing broad "support" for exotic platforms an=
d older
> > +platforms, without an explicit commitment. This support becomes easier=
 to
> > +maintain (and possible to commit to) when Git developers are providing=
 with
>
> "providing"?  "provided"?
>
> > +adequate tooling to test for compatibility. Variouis levels of tooling=
 will
>
> "Variouis"?

Thanks, fixed both for next time there's a reroll ready.

>
> > +allow us to make more solid commitments around Git's compatibility wit=
h your
> > +platform.
> > +
> > +Compatible by vN+1 release
> > +--------------------------
>
> I couldn't quite tell what you meant by vN+1 on the title.  If Git
> v2.45.X were working fine on an un(der)maintained platform, and some
> changes went into Git v2.46.0 were incompatible with it, then vN
> would obviously be v2.46.0 but what is vN+1?  v2.47.0 or v2.46.1?
>
> howto/maintain-git.txt calls v2.47.0 "the next feature release"
> after v2.46.0, while v2.46.1 is "the first maintenance release".
>
> > +To increase probability that compatibility issues introduced in a poin=
t release
> > +will be fixed by the next point release:
>
> So you meant "by v2.46.1 (or if you fail to notice breakage then it
> might slip until v2.46.2)".  Is the procedure for the platform folks
> any different if they target the next feature release?
>
> I think what they need to do would not change all that much between
> these two cases, so I'd suggest dropping a mention of "point
> release".  I.e, "introduced in an earlier release will be fixed by a
> future release".
>
> A point release cannot introduce compatibility issues or any
> breakages, but mistakes happen ;-) But for a receiver of a new bug,
> it does not matter an iota if a point release or a major release
> introduced an issue.
>
> To recap, my suggestions for the above part are:
>
>  - retitle to "Compatible by the next release"
>
>  - "introduced in an earlier release will be fixed by a future
>    release" without mentioning the nature of releases like point,
>    feature, and maintenance.

Thanks for the thorough clarification, I hadn't thought in as much
detail as this :) Will make those edits.

>
> > +* You should send a bug report as soon as you notice the breakage on y=
our
> > +platform. The sooner you notice, the better; it's better for you to wa=
tch `seen`
> > +than to watch `master`.
>
> Let's clarify what goal they want to achieve by "watching".

Fixed for next reroll.

>
>     ... for you to watch `seen` to prevent changes that break your
>     platform from getting merged into `next`, than to watch `master`.
>
> > See linkgit:gitworkflows[7] under "Graduation" for an
> > +overview of which branches are used in git.git, and how.
>
> Or "The Policy" section of howto/maintain-git.txt where the use of
> each branch makes it a bit more clear what 'next' is for, and why
> 'seen' may be worth looking at by these people.

Thanks, yeah, changed the link to point there instead.

>
>
> > +Compatible on `master` and point releases
> > +-----------------------------------------
> > +
> > +To guarantee that `master` and all point releases work for your platfo=
rm the
> > +first time:
>
> OK, as most of the changes go to `master` before getting merged down
> to `maint` to become part of the next maintenance release, actively
> protecting `master` from bugs is worthwhile.  What about changes
> that do not come via the `master` branch?  Should they also join the
> security list and have an early access to the cabal material?

Good question, I actually am not sure of the answer. Does that make it
too easy for anybody to claim they maintain some random platform and
therefore they'd like to see all the RCE howtos weeks before they are
fixed? I guess that we already have distro packagers in security
list/cabal, so it may not be worse exposure than that.

>
> > +* You should run nightly tests against the `next` branch and publish b=
reakage
> > +reports to the mailing list immediately when they happen.
> > +* It may make sense to automate these; if you do, make sure they are n=
ot noisy
> > +(you don't need to send a report when everything works, only when some=
thing
> > +breaks).
> > +* Breakage reports should be actionable - include clear error messages=
 that can
> > +help developers who may not have access to test directly on your platf=
orm.
> > +* You should use git-bisect and determine which commit introduced the =
breakage;
> > +if you can't do this with automation, you should do this yourself manu=
ally as
> > +soon as you notice a breakage report was sent.
>
> All of the above are actually applicable to any active contributors
> on any platforms.  If your group feeds custom builds of Git out of
> "master" to your $CORP customers, you want to ensure you catch
> badness while it is still in "next" (or better yet, before it hits
> "next").  If your internal builds are based on "next", you'd want to
> ensure that "next" stays clean, which means you'd need to watch
> "seen" (or better yet, patches floating on the list before they hit
> "seen").  Your group may build with unusual toolchain internal to
> your $CORP and may link with specialized libraries, etc., in which
> case maintaining such a build is almost like maintaining an exotic
> platform.

Hits close to home ;)

Does this mean that this part of the document should go somewhere else
and we should just use a pointer here? Is there a guide handy for "how
to soft-fork Git"?

>
> > +* You should either:
> > +** Provide VM access on-demand to a trusted developer working to fix t=
he issue,
> > +so they can test their fix, OR
> > +** Work closely with the developer fixing the issue - testing turnarou=
nd to
> > +check whether the fix works for your platform should not be longer tha=
n a
> > +business day.
>
> These are very specific, especially for minority platform folks.  I
> agree with the direction, but "not be longer than" might be too
> strong.  Longer turnaround time will certainly make the issue
> resolution slower, but if the platform maintainer can stand it, that
> is their choice.  Finding some volunteers among our developers who
> are familiar with the code to help their problem with more patience
> and can wait for more than a business day is also up to them.

Maybe something like this is better?

"Work closely with the developer fixing the issue; the turnaround to
check that a proposed fix works for your platform should be fast
enough that it doesn't hinder the developer working on that fix. If
the turnaround is too slow, fixing the issue may miss the next release
or the developer may lose interest in working on the fix at all."

This last bit seems harsh but might be a good reminder - in this
situation, the developer is a volunteer, and if that volunteer work is
artificially annoying, they can decide to stop doing it. Open to
rephrasing.

>
> > +Compatible on `next`
> > +--------------------
> > +
> > +To guarantee that `next` will work for your platform, avoiding reactiv=
e
> > +debugging and fixing:
> > +
> > +* You should add a runner for your platform to the GitHub Actions CI s=
uite.
> > +This suite is run when any Git developer proposes a new patch, and hav=
ing a
> > +runner for your platform/configuration means every developer will know=
 if they
> > +break you, immediately.
>
> This would be nice even if the platform maintainer do not care about
> `next` occasionally breaking (i.e. keep `master` working, in the
> previous section, or even find breakages on `master` before the next
> feature release, in the section before that).

I agree that it would be nice for any scenario :)

I was trying to link lower quality of service with lower investment;
it would be nice to have things from the "higher investment" tier, but
it's not really necessary for Git to be providing that worse quality
of service.

Would it be worth mentioning at the very beginning of the doc that
"it's OK if you pick and choose between different tiers, and we
appreciate anything that takes a higher investment, but these lists
should give you an impression of what you'll get from the level of
effort you want to provide yourself"? Probably not with that exact
phrasing, but to try and get that concept across, at least.

>
> > +* If you rely on Git avoiding a specific pattern that doesn't work wel=
l with
> > +your platform (like a certain malloc pattern), if possible, add a cocc=
icheck
> > +rule to ensure that pattern is not used.
>
> Sorry, but I do not quite follow you here.
>
> In general, it is a bad idea to promise that we are willing to tie
> our hands with coccicheck to satisfy needs by exotic platforms,
> without first having a chance to see and evaluate such needs.
>
> "if possible, add" -> "sometimes it may turn out to be a good idea
> to add", perhaps?

Maybe it is better to ask them to discuss it with us on-list, and that
the result of that discussion may be that they should add some such
test? Or, do we want to firmly say, no coccicheck restrictions based
on platform, give us a CI runner or bust? I don't feel super strongly
either way - writing this section I was trying to come up with any way
to get on-demand ~instant (<1hr) feedback to any contributor, and this
seemed like one someone could do. That doesn't mean we have to let
them, if we don't like this way.

>
> > +* If you rely on some configuration or behavior, add a test for it. Yo=
u may
> > +find it easier to add a unit test ensuring the behavior you need than =
to add an
> > +integration test; either one works. Untested behavior is subject to br=
eakage at
> > +any time.
>
> A unit test may be easier to add than an end-to-end test, but given
> that end-users and platform maintainers want to see Git work as a
> whole (e.g., if you prepare two repositories and do "git push there
> :refs/heads/foo" then it removes the 'foo' branch), an end-to-end
> test would probably be more useful and robust way to ensure that a
> feature you care about will keep working.
>
> In any case, I am not sure the sentence that ends with "either one
> works" is worth existing here in this document.  Two important points
> to stress here are (1) add test to protect what you care about and (2)
> otherwise you can keep both halves.
>

Thanks, will do.


I've got a couple of changes locally but I'll hold off on the reroll
til the open phrasing questions get resolved, and I get through
brian's review as well, and maybe another day to see if Randall makes
a response, since I cc'd him too. Will aim to send out v2 Friday
latest (barring any combustion events at $dayjob). Thanks much for the
quick and thorough reply.

 - Emily
