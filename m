Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1582D69
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642882; cv=none; b=ewGWmkQ/VKdFrnsz8R3r9rr1pLmP2ouBcLse6s9dRC43bJumtrpUcbQF34rF9FWQLvrawYOyM9JtLfXnjiaPTIeEfub66GOjHRYuvMx3ePRGV+EK0MAGzg0glyLm49fYYi2V+4rTxkU5j60FMuoMgaGtSV0pwpwPeOOG93rb3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642882; c=relaxed/simple;
	bh=mcnihyrvF23xIsY9jhwKY31oImnf0Qpm0FfZKRGiym8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLQKgzS3BatIKB/FJE7CWczLC8AmfASEFRhFo+NUyOu50TPmufBMDY0mGO2WgnrLS4xFSZ4rEt/LGFM9XLSbI5/78GImqnnWnnOaC+1voUIj+3iUFlQj1rqryLOAcov9g+xyt85gCLldewNrAioEWPGYD9hs4RWd+gfKVzkCwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46AKL6XJ3715183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 20:21:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emily Shaffer'" <nasamuffin@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com> <xmqqfrsi9i8y.fsf@gitster.g> <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
In-Reply-To: <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
Subject: RE: [PATCH] Documentation: add platform support policy
Date: Wed, 10 Jul 2024 16:20:59 -0400
Organization: Nexbridge Inc.
Message-ID: <007a01dad306$b12caad0$13860070$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLOJF488y2+/PGZbbSRsjvDFvsFqgF8FxGtAe/+URWv7mKd4A==
Content-Language: en-ca

On Wednesday, July 10, 2024 2:56 PM, Emily Shaffer wrote:
>On Tue, Jul 9, 2024 at 5:57=E2=80=AFPM Junio C Hamano =
<gitster@pobox.com> wrote:
>>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>> > +Platform Support Policy
>> > =
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +Git has a history of providing broad "support" for exotic =
platforms
>> > +and older platforms, without an explicit commitment. This support
>> > +becomes easier to maintain (and possible to commit to) when Git
>> > +developers are providing with
>>
>> "providing"?  "provided"?
>>
>> > +adequate tooling to test for compatibility. Variouis levels of
>> > +tooling will
>>
>> "Variouis"?
>
>Thanks, fixed both for next time there's a reroll ready.
>
>>
>> > +allow us to make more solid commitments around Git's compatibility
>> > +with your platform.
>> > +
>> > +Compatible by vN+1 release
>> > +--------------------------
>>
>> I couldn't quite tell what you meant by vN+1 on the title.  If Git
>> v2.45.X were working fine on an un(der)maintained platform, and some
>> changes went into Git v2.46.0 were incompatible with it, then vN =
would
>> obviously be v2.46.0 but what is vN+1?  v2.47.0 or v2.46.1?
>>
>> howto/maintain-git.txt calls v2.47.0 "the next feature release"
>> after v2.46.0, while v2.46.1 is "the first maintenance release".
>>
>> > +To increase probability that compatibility issues introduced in a
>> > +point release will be fixed by the next point release:
>>
>> So you meant "by v2.46.1 (or if you fail to notice breakage then it
>> might slip until v2.46.2)".  Is the procedure for the platform folks
>> any different if they target the next feature release?
>>
>> I think what they need to do would not change all that much between
>> these two cases, so I'd suggest dropping a mention of "point =
release".
>> I.e, "introduced in an earlier release will be fixed by a future
>> release".
>>
>> A point release cannot introduce compatibility issues or any
>> breakages, but mistakes happen ;-) But for a receiver of a new bug, =
it
>> does not matter an iota if a point release or a major release
>> introduced an issue.
>>
>> To recap, my suggestions for the above part are:
>>
>>  - retitle to "Compatible by the next release"
>>
>>  - "introduced in an earlier release will be fixed by a future
>>    release" without mentioning the nature of releases like point,
>>    feature, and maintenance.
>
>Thanks for the thorough clarification, I hadn't thought in as much =
detail as this :)
>Will make those edits.
>
>>
>> > +* You should send a bug report as soon as you notice the breakage
>> > +on your platform. The sooner you notice, the better; it's better
>> > +for you to watch `seen` than to watch `master`.
>>
>> Let's clarify what goal they want to achieve by "watching".
>
>Fixed for next reroll.
>
>>
>>     ... for you to watch `seen` to prevent changes that break your
>>     platform from getting merged into `next`, than to watch `master`.
>>
>> > See linkgit:gitworkflows[7] under "Graduation" for an
>> > +overview of which branches are used in git.git, and how.
>>
>> Or "The Policy" section of howto/maintain-git.txt where the use of
>> each branch makes it a bit more clear what 'next' is for, and why
>> 'seen' may be worth looking at by these people.
>
>Thanks, yeah, changed the link to point there instead.
>
>>
>>
>> > +Compatible on `master` and point releases
>> > +-----------------------------------------
>> > +
>> > +To guarantee that `master` and all point releases work for your
>> > +platform the first time:
>>
>> OK, as most of the changes go to `master` before getting merged down
>> to `maint` to become part of the next maintenance release, actively
>> protecting `master` from bugs is worthwhile.  What about changes that
>> do not come via the `master` branch?  Should they also join the
>> security list and have an early access to the cabal material?
>
>Good question, I actually am not sure of the answer. Does that make it =
too easy for
>anybody to claim they maintain some random platform and therefore =
they'd like to
>see all the RCE howtos weeks before they are fixed? I guess that we =
already have
>distro packagers in security list/cabal, so it may not be worse =
exposure than that.
>
>>
>> > +* You should run nightly tests against the `next` branch and
>> > +publish breakage reports to the mailing list immediately when they =
happen.
>> > +* It may make sense to automate these; if you do, make sure they
>> > +are not noisy (you don't need to send a report when everything
>> > +works, only when something breaks).
>> > +* Breakage reports should be actionable - include clear error
>> > +messages that can help developers who may not have access to test =
directly on
>your platform.
>> > +* You should use git-bisect and determine which commit introduced
>> > +the breakage; if you can't do this with automation, you should do
>> > +this yourself manually as soon as you notice a breakage report was =
sent.
>>
>> All of the above are actually applicable to any active contributors =
on
>> any platforms.  If your group feeds custom builds of Git out of
>> "master" to your $CORP customers, you want to ensure you catch =
badness
>> while it is still in "next" (or better yet, before it hits "next").
>> If your internal builds are based on "next", you'd want to ensure =
that
>> "next" stays clean, which means you'd need to watch "seen" (or better
>> yet, patches floating on the list before they hit "seen").  Your =
group
>> may build with unusual toolchain internal to your $CORP and may link
>> with specialized libraries, etc., in which case maintaining such a
>> build is almost like maintaining an exotic platform.
>
>Hits close to home ;)

I hear that. Sometimes having an exotic platform and specialized =
libraries are overlapping. I am still stuck with 32-bit git because some =
of the available DLLs on NonStop are still only 32-bit - I'm working =
hard on changing that but it's not under my budget control.

On that subject, I think it is important to have known or designated =
platform maintainers for the exotics. The downside is that some people =
expect miracles from us - I just had one request to permanently preserve =
timestamps of files as they were at commit time. We're into weeks of =
explanations on why this is a bad idea. Nonetheless, there is a certain =
amount of responsibility that comes with maintaining a platform, and =
knowing whom to ask when there are issues. The platform maintainers also =
can provide needed (preemptive) feedback on dependency changes. I'm not =
sure how to encode that in a compatible policy, however.


>Does this mean that this part of the document should go somewhere else =
and we
>should just use a pointer here? Is there a guide handy for "how to =
soft-fork Git"?
>
>>
>> > +* You should either:
>> > +** Provide VM access on-demand to a trusted developer working to
>> > +fix the issue, so they can test their fix, OR
>> > +** Work closely with the developer fixing the issue - testing
>> > +turnaround to check whether the fix works for your platform should
>> > +not be longer than a business day.
>>
>> These are very specific, especially for minority platform folks.  I
>> agree with the direction, but "not be longer than" might be too
>> strong.  Longer turnaround time will certainly make the issue
>> resolution slower, but if the platform maintainer can stand it, that
>> is their choice.  Finding some volunteers among our developers who =
are
>> familiar with the code to help their problem with more patience and
>> can wait for more than a business day is also up to them.
>
>Maybe something like this is better?
>
>"Work closely with the developer fixing the issue; the turnaround to =
check that a
>proposed fix works for your platform should be fast enough that it =
doesn't hinder
>the developer working on that fix. If the turnaround is too slow, =
fixing the issue may
>miss the next release or the developer may lose interest in working on =
the fix at all."
>
>This last bit seems harsh but might be a good reminder - in this =
situation, the
>developer is a volunteer, and if that volunteer work is artificially =
annoying, they can
>decide to stop doing it. Open to rephrasing.
>
>>
>> > +Compatible on `next`
>> > +--------------------
>> > +
>> > +To guarantee that `next` will work for your platform, avoiding
>> > +reactive debugging and fixing:
>> > +
>> > +* You should add a runner for your platform to the GitHub Actions =
CI suite.
>> > +This suite is run when any Git developer proposes a new patch, and
>> > +having a runner for your platform/configuration means every
>> > +developer will know if they break you, immediately.
>>
>> This would be nice even if the platform maintainer do not care about
>> `next` occasionally breaking (i.e. keep `master` working, in the
>> previous section, or even find breakages on `master` before the next
>> feature release, in the section before that).
>
>I agree that it would be nice for any scenario :)
>
>I was trying to link lower quality of service with lower investment; it =
would be nice
>to have things from the "higher investment" tier, but it's not really =
necessary for Git
>to be providing that worse quality of service.
>
>Would it be worth mentioning at the very beginning of the doc that =
"it's OK if you
>pick and choose between different tiers, and we appreciate anything =
that takes a
>higher investment, but these lists should give you an impression of =
what you'll get
>from the level of effort you want to provide yourself"? Probably not =
with that exact
>phrasing, but to try and get that concept across, at least.
>
>>
>> > +* If you rely on Git avoiding a specific pattern that doesn't work
>> > +well with your platform (like a certain malloc pattern), if
>> > +possible, add a coccicheck rule to ensure that pattern is not =
used.
>>
>> Sorry, but I do not quite follow you here.
>>
>> In general, it is a bad idea to promise that we are willing to tie =
our
>> hands with coccicheck to satisfy needs by exotic platforms, without
>> first having a chance to see and evaluate such needs.
>>
>> "if possible, add" -> "sometimes it may turn out to be a good idea to
>> add", perhaps?
>
>Maybe it is better to ask them to discuss it with us on-list, and that =
the result of that
>discussion may be that they should add some such test? Or, do we want =
to firmly
>say, no coccicheck restrictions based on platform, give us a CI runner =
or bust? I
>don't feel super strongly either way - writing this section I was =
trying to come up
>with any way to get on-demand ~instant (<1hr) feedback to any =
contributor, and
>this seemed like one someone could do. That doesn't mean we have to let =
them, if
>we don't like this way.
>
>>
>> > +* If you rely on some configuration or behavior, add a test for =
it.
>> > +You may find it easier to add a unit test ensuring the behavior =
you
>> > +need than to add an integration test; either one works. Untested
>> > +behavior is subject to breakage at any time.
>>
>> A unit test may be easier to add than an end-to-end test, but given
>> that end-users and platform maintainers want to see Git work as a
>> whole (e.g., if you prepare two repositories and do "git push there
>> :refs/heads/foo" then it removes the 'foo' branch), an end-to-end =
test
>> would probably be more useful and robust way to ensure that a feature
>> you care about will keep working.
>>
>> In any case, I am not sure the sentence that ends with "either one
>> works" is worth existing here in this document.  Two important points
>> to stress here are (1) add test to protect what you care about and =
(2)
>> otherwise you can keep both halves.
>>
>
>Thanks, will do.
>
>
>I've got a couple of changes locally but I'll hold off on the reroll =
til the open phrasing
>questions get resolved, and I get through brian's review as well, and =
maybe another
>day to see if Randall makes a response, since I cc'd him too. Will aim =
to send out v2
>Friday latest (barring any combustion events at $dayjob). Thanks much =
for the
>quick and thorough reply.

--Randall

