Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823623A0
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573028; cv=none; b=kSnTb9JU1MqwYR0vml3G7iwxwIIFeLKexEW869c2zr/BT4Si//AgFuXQwSXLWZDwVSCCFfiriFFdjr2o0F8gOrudePJBfkhSK/76bdEHYtb7IFMjguNP/M2ZLZReyVvky9y+OuG6InCZ7XefzcIEWmPpVA5gjk9I0SO1vpJC4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573028; c=relaxed/simple;
	bh=+Sedd5YH0RyIObE7S9sUtMV3+Mnbjx1SJTwy7epuXYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jaHw2W/ud6NGhHj34125ztWQmYL0fBoHFwJBWqTMBgju2j/7MUA7fEBjN52W/vlKHhQDdsH86K1LLsJD+EBsIijcf/Op/qPCw1WPeTM1Ts97f2DX15zd2pipmHYl23nsxYqfvxuwjJRZbXTZlpQ/BpN7KoFqfHFPKtemGzm0bvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uh+TJSDO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uh+TJSDO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BFA53D86C;
	Tue,  9 Jul 2024 20:57:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+Sedd5YH0RyIObE7S9sUtMV3+Mnbjx1SJTwy7e
	puXYY=; b=Uh+TJSDONIJX8/ltEFJLXXbhPpI08wzlwW8r3+ZuuU4a4bAK4N2lMP
	zX8VIQJauH9PjUozTg2elWKwkB8oqOzgQpZ/dnCAoWsHQCmhGFhYdd5CoSbxAUUX
	v7DExEHSUSZPN8a2mOmSnFjuvYEkoMuMzDOwCV0ZUJkR/GL6NDoeI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 622503D86B;
	Tue,  9 Jul 2024 20:57:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E07B33D86A;
	Tue,  9 Jul 2024 20:57:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] Documentation: add platform support policy
In-Reply-To: <20240709225042.2005233-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Tue, 9 Jul 2024 15:50:42 -0700")
References: <20240709225042.2005233-1-emilyshaffer@google.com>
Date: Tue, 09 Jul 2024 17:57:01 -0700
Message-ID: <xmqqfrsi9i8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 51ED37DA-3E57-11EF-8831-C38742FD603B-77302942!pb-smtp20.pobox.com

Emily Shaffer <emilyshaffer@google.com> writes:

> +Platform Support Policy
> +=======================
> +
> +Git has a history of providing broad "support" for exotic platforms and older
> +platforms, without an explicit commitment. This support becomes easier to
> +maintain (and possible to commit to) when Git developers are providing with

"providing"?  "provided"?

> +adequate tooling to test for compatibility. Variouis levels of tooling will

"Variouis"?

> +allow us to make more solid commitments around Git's compatibility with your
> +platform.
> +
> +Compatible by vN+1 release
> +--------------------------

I couldn't quite tell what you meant by vN+1 on the title.  If Git
v2.45.X were working fine on an un(der)maintained platform, and some
changes went into Git v2.46.0 were incompatible with it, then vN
would obviously be v2.46.0 but what is vN+1?  v2.47.0 or v2.46.1?

howto/maintain-git.txt calls v2.47.0 "the next feature release"
after v2.46.0, while v2.46.1 is "the first maintenance release".

> +To increase probability that compatibility issues introduced in a point release
> +will be fixed by the next point release:

So you meant "by v2.46.1 (or if you fail to notice breakage then it
might slip until v2.46.2)".  Is the procedure for the platform folks
any different if they target the next feature release?

I think what they need to do would not change all that much between
these two cases, so I'd suggest dropping a mention of "point
release".  I.e, "introduced in an earlier release will be fixed by a
future release".

A point release cannot introduce compatibility issues or any
breakages, but mistakes happen ;-) But for a receiver of a new bug,
it does not matter an iota if a point release or a major release
introduced an issue.

To recap, my suggestions for the above part are:

 - retitle to "Compatible by the next release"

 - "introduced in an earlier release will be fixed by a future
   release" without mentioning the nature of releases like point,
   feature, and maintenance.

> +* You should send a bug report as soon as you notice the breakage on your
> +platform. The sooner you notice, the better; it's better for you to watch `seen`
> +than to watch `master`.

Let's clarify what goal they want to achieve by "watching".

    ... for you to watch `seen` to prevent changes that break your
    platform from getting merged into `next`, than to watch `master`.

> See linkgit:gitworkflows[7] under "Graduation" for an
> +overview of which branches are used in git.git, and how.

Or "The Policy" section of howto/maintain-git.txt where the use of
each branch makes it a bit more clear what 'next' is for, and why
'seen' may be worth looking at by these people.


> +Compatible on `master` and point releases
> +-----------------------------------------
> +
> +To guarantee that `master` and all point releases work for your platform the
> +first time:

OK, as most of the changes go to `master` before getting merged down
to `maint` to become part of the next maintenance release, actively
protecting `master` from bugs is worthwhile.  What about changes
that do not come via the `master` branch?  Should they also join the
security list and have an early access to the cabal material?

> +* You should run nightly tests against the `next` branch and publish breakage
> +reports to the mailing list immediately when they happen.
> +* It may make sense to automate these; if you do, make sure they are not noisy
> +(you don't need to send a report when everything works, only when something
> +breaks).
> +* Breakage reports should be actionable - include clear error messages that can
> +help developers who may not have access to test directly on your platform.
> +* You should use git-bisect and determine which commit introduced the breakage;
> +if you can't do this with automation, you should do this yourself manually as
> +soon as you notice a breakage report was sent.

All of the above are actually applicable to any active contributors
on any platforms.  If your group feeds custom builds of Git out of
"master" to your $CORP customers, you want to ensure you catch
badness while it is still in "next" (or better yet, before it hits
"next").  If your internal builds are based on "next", you'd want to
ensure that "next" stays clean, which means you'd need to watch
"seen" (or better yet, patches floating on the list before they hit
"seen").  Your group may build with unusual toolchain internal to
your $CORP and may link with specialized libraries, etc., in which
case maintaining such a build is almost like maintaining an exotic
platform.

> +* You should either:
> +** Provide VM access on-demand to a trusted developer working to fix the issue,
> +so they can test their fix, OR
> +** Work closely with the developer fixing the issue - testing turnaround to
> +check whether the fix works for your platform should not be longer than a
> +business day.

These are very specific, especially for minority platform folks.  I
agree with the direction, but "not be longer than" might be too
strong.  Longer turnaround time will certainly make the issue
resolution slower, but if the platform maintainer can stand it, that
is their choice.  Finding some volunteers among our developers who
are familiar with the code to help their problem with more patience
and can wait for more than a business day is also up to them.

> +Compatible on `next`
> +--------------------
> +
> +To guarantee that `next` will work for your platform, avoiding reactive
> +debugging and fixing:
> +
> +* You should add a runner for your platform to the GitHub Actions CI suite.
> +This suite is run when any Git developer proposes a new patch, and having a
> +runner for your platform/configuration means every developer will know if they
> +break you, immediately.

This would be nice even if the platform maintainer do not care about
`next` occasionally breaking (i.e. keep `master` working, in the
previous section, or even find breakages on `master` before the next
feature release, in the section before that).

> +* If you rely on Git avoiding a specific pattern that doesn't work well with
> +your platform (like a certain malloc pattern), if possible, add a coccicheck
> +rule to ensure that pattern is not used.

Sorry, but I do not quite follow you here.

In general, it is a bad idea to promise that we are willing to tie
our hands with coccicheck to satisfy needs by exotic platforms,
without first having a chance to see and evaluate such needs.

"if possible, add" -> "sometimes it may turn out to be a good idea
to add", perhaps?

> +* If you rely on some configuration or behavior, add a test for it. You may
> +find it easier to add a unit test ensuring the behavior you need than to add an
> +integration test; either one works. Untested behavior is subject to breakage at
> +any time.

A unit test may be easier to add than an end-to-end test, but given
that end-users and platform maintainers want to see Git work as a
whole (e.g., if you prepare two repositories and do "git push there
:refs/heads/foo" then it removes the 'foo' branch), an end-to-end
test would probably be more useful and robust way to ensure that a
feature you care about will keep working.

In any case, I am not sure the sentence that ends with "either one
works" is worth existing here in this document.  Two important points
to stress here are (1) add test to protect what you care about and (2)
otherwise you can keep both halves.

