Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01666EB5C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459660; cv=none; b=rsY/QSahgKZOGBDETGn2FSBfnY2euvVL/xbReEceJyoOdUijOE8t9alBaq+PPAm9GIaOTCk9G3oXgK+WLPplHKpnSyslXmtREJjJBMiuh/DKB9ZBoL5Q39eNfgI/X2kl/BBTdPlhQTOCiu77dQHXdOBZCIQN3LYSsoH1gUpr/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459660; c=relaxed/simple;
	bh=KA1l6VOn4OiBV4KjxZT3qTHO1CNre280gGBVN19/dV4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUsgMgU/uPuFF2aDwtftqxKgpxcY6krAYczBDLtC2DYQBLw4/h0qVwXZFBISwJbvMD7ma/ulLTmiWWb5PF0hWGuYntUYSauyN3k1RISi0VF7JriiShVmZGsg7u43JxW698kZU5pGLO2C6Sv7Mj4HhzAWSrIRW2wOe9KhqvYzCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46VKwPJc3318670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 20:58:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emily Shaffer'" <nasamuffin@google.com>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20240730175448.1727373-1-emilyshaffer@google.com> <xmqq7cd2bs0q.fsf@gitster.g> <CAJoAoZn57LMCz9dmU3u+2HS1urOcoY1HQA6axh0cWoGchS_KFA@mail.gmail.com> <xmqqttg6a7zj.fsf@gitster.g> <000001dae2d1$85ce8f40$916badc0$@nexbridge.com> <CAJoAoZnw_vmGpShXc-tcC03JSsxwy+S1cD-p+Ja2J09trkR4Kw@mail.gmail.com>
In-Reply-To: <CAJoAoZnw_vmGpShXc-tcC03JSsxwy+S1cD-p+Ja2J09trkR4Kw@mail.gmail.com>
Subject: RE: [PATCH v4] Documentation: add platform support policy
Date: Wed, 31 Jul 2024 16:58:19 -0400
Organization: Nexbridge Inc.
Message-ID: <00bb01dae38c$62e89ff0$28b9dfd0$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQI5Js9r9iVOCp5l2xZx/NcDi+YSZAMJj/R0ASQc/PcB/BckggHtmGWwAcOfK9exBeTi0A==

On Wednesday, July 31, 2024 1:20 PM, Emily Shaffer wrote:
>On Tue, Jul 30, 2024 at 3:40=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> On Tuesday, July 30, 2024 5:25 PM, Junio C Hamano wrote:
>> >Emily Shaffer <nasamuffin@google.com> writes:
>> >
>> >>> > +Note that this document is about maintaining existing support
>> >>> > +for a platform that has generally worked in the past; for
>> >>> > +adding support to a platform which doesn't generally work with
>> >>> > +Git, the stakeholders for that platform are expected to do the
>> >>> > +bulk of that work themselves. We will consider such patches if
>> >>> > +they don't make life harder for other supported platforms, and
>> >>> > +you may well find a contributor interested in working on that
>> >>> > +support, but the Git community as a
>> >whole doesn't feel an obligation to perform such work.
>> >>>
>> >>> The part after "... and you may well find" reads a bit muddy.  I
>> >>> couldn't tell if it is talking about the initial port, or
>> >>> continued support, or both.
>> >>> ...
>> >> I like that message, but what I was trying to say with that
>> >> sentence was "if you get lucky, some volunteer might want to help
>> >> you with the initial port".
>> >
>> >FWIW, I do not quite like that message; I agree that it would be =
good
>> >to tell them that they may not entirely be on their own, if they ask =
nicely, but no
>promises ;-).
>> >
>> >> It seems worth at least pointing out that that would be the
>> >> exception, not the rule, but I probably already do that well =
enough
>> >> with the previous sentence ("the platform stakeholders are =
expected
>> >> to do the bulk of the work"). Let me reword the last sentence, =
then:
>> >>
>> >> "We will consider patches that port a new platform if they don't
>> >> make life harder for other support platforms or for Git
>> >> contributors. Some Git contributors may volunteer to help with the
>> >> initial or continued support, but that is not a given. Support =
work
>> >> which is too intrusive or difficult for the project to maintain =
may still not be
>accepted."
>> >
>> >OK, at least that clarifies the point I was puzzled about.
>>
>> Pulling in a paragraph from earlier on:
>>
>> > >This is hard to understand and I wonder if we can clarify.  I get
>> > >what you want to
>> > >say: suppose we rely on library X that is getting regular feature
>> > >and security updates in reasonable cadence, say every 6 months
>> > >there is an upstream release of library X, but a niche platform =
has
>> > >ported the library only once long time ago, and hasn't updated it
>> > >ever since.  Now the Git project may consider helping a port to
>> > >such a platform if the initial port of library X was 8 years ago, =
but will not if it
>was 12 years ago.
>>
>> This is a tough one. If a library is actively maintained and subject
>> to security fixes, OS providers like the NonStop team will, as a
>> general practice, provide security fixes. It might not be as frequent
>> as I would personally like, but a 12 year old library with security
>> holes would not really survive to be a problem. Others, where
>> stability is well established, let's say iconv (a bad example, I
>> know), will not get the attention to have it fixed until there is a =
customer reported
>issue (or me stomping up and down a lot). I think that the 8 vs. 12 =
year difference is
>fairly arbitrary and might not be appropriate.
>>
>> In some situations, if functionality is provided by an existing
>> library, and is augmented, the platform maintainer could provide =
another
>compatibility component to supply the capabilities.
>> It would be a strain, and in some cases impractical, but might be =
possible.
>>
>> I think a bigger issue is where there are dependencies introduced =
that
>> are either not generally portable or depend on infrastructure that is
>> also not portable. There is a long list of projects that are all
>> interrelated and specific to the Linux space - all of which scare me
>> as adding any of those would exclude git from platforms where those
>> are not possible to port. Rust and GO, which have difficult-to-port
>> code generators are two (Rust itself is problematic as one needs
>> consent from the Rust maintainers to even add a platform, if you read
>> deeply enough into the "porting" documentation). Products that must
>> use gcc or clang with unavoidable syntax features that are not
>> supported by ANSI C compilers and libraries are also things that keep =
me up at
>night because there really is no way to work around those. In some =
cases, some
>JSON and YAML libraries ended up having to be forked and are now (not =
happily
>but) maintained by my team - not a git issue.
>>
>> Ultimately, my goal as a platform maintainer is to be able to sleep =
at
>> night without worrying that git support will be completely turned off
>> by a feature that uses some incompatible library as part of the git
>> core. Git LFS has had to be put aside because of the GO dependency,
>> but because LFS is not core git, it is survivable. I think that if
>> such incompatibilities are introduced, there should be a mechanism to =
isolate
>them, and exclude them from the git core.
>>
>> Please remember that git is now a central component to a vast number
>> of organizations that depend on it for serving features to customers.
>> To be blunt, it is not 2007 anymore, and git exists almost everywhere
>> of significance. That point needs to be stressed. The pervasiveness =
of
>> git has dramatically increased over the past 5 years, more than I =
think most people
>realized. On NonStop, 5 years ago, there was perhaps <10% =
participation.
>> If you look now, the number has gone up, probably to somewhere around
>> 60-70%. We cannot ignore that - I sincerely hope not anyway. There =
are
>> even companies that will look at your GitHub footprint exclusively as
>> your definitive resume for hiring purposes - I actually think that is
>> really interesting and do not want to put that at risk either =
(although admittedly
>entirely beside the point of this thread).
>
>I can understand the need for something that speaks the Git protocol =
and enables
>developers to develop. However, I guess I don't understand the need for =
that to be
>the latest version of Git, or even the C Git client to begin with. The =
protocol changes
>from time to time, but we're very careful - even compared to how =
careful we are
>about scripting compatibility on the C Git CLI - to provide backwards =
support for
>clients speaking older Git protocol. Why does it matter to NonStop, =
then, which
>client is being used or if it's sparkling brand new?
>
>Git is a central component to lots of things, you're right - at Google =
it's incredibly
>important, and our serving infrastructure is based around JGit, not C =
Git. It's
>integrated into lots of development tools like IDEs and notebooks and =
design
>software, and most of those use JGit or EGit or libgit2 or something.
>
>My point isn't "just fork Git" or "just use a different library", my =
point is "are you
>sure it's correct to worry about the Git client more than you worry =
about the Git
>protocol?"
>
>Anyway, I think we've gone pretty far afield. Let me resummarize my =
understanding
>of your thoughts on this patch so far:
>
>* Given the constraints that currently apply to NonStop, based on this =
doc, you are
>planning to run daily (or at least more frequent than
>weekly) tests against `next`, write detailed reports to the list as =
soon as you discover
>a problem (that is, before the problem series hits `master`, in most =
cases), and
>provide fixes yourself or work closely to test fixes others write in =
response to those
>reports.
>* Also given the constraints that currently apply to NonStop, a hard =
age limit on
>library dependencies would disqualify NonStop from explicit support =
assistance.
>
>v4 of this series drops the hard age limit on library dependencies. As =
written
>currently, is it still objectionable to you?

Staying on the latest git is not a requirement, although highly =
desirable. Any CVEs that impact
git would have to be addressed in whatever fork is done, if that becomes =
necessary,
which I assume we have to plan for. This is a bit of a regression, as we =
had a fork back
in 2016 when the NonStop code was not fully integrated into C git - =
changing that was my
primary contribution, with help from Jojo on our team. I would not be =
happy about
reverting to the old manual process of applying patches by hand - git =
merge was not
usually sufficient in those days - plus having to add separate tests =
that we had
difficulty certifying. We also then have to publish the changes as part =
of GPL v2.0,
which we did, and finally stopped having to do sharing the standard code =
base.

As far as JGit, it is much less functional and does not build or run on =
NonStop due to
dependencies that are also problematic (I may be wrong but I think it =
requires Java 17
for that, which is not yet available, nor will ever be on ia64). We used =
to recommend
using JGit while the C git code was not fully reconciled with our =
variances, but JGit stopped
working correctly around 2022 and I was unable to get any support to =
change that, at least
at that time. That and the user community really likes having "git help" =
- no such animal
is in JGit, and some of our base does not have direct Internet access =
where git is used
(high security environments). The reason we went with C git is because =
it actually builds
and tests correctly (with minor irrelevant exceptions in t9001 that no =
one on the boxes
care about). It is the only CLI client that works properly, so losing it =
permanently (as in
being stuck at an old version) would be undesirable. There is no GUI on =
NonStop, so
no options there.

To the actual question: I am actually fine (and happy) with dropping the =
age limit - to me
this is arbitrary without an official LTS designation and does not =
address the fundamental
compatibility issues that are unrelated to time. As above, the highest =
priority requirement
for me is being able to continue to apply CVE-related patches to =
whatever code is ported
and maintained. My own nightmare scenario is a git CVE (high) coming out =
that is only
fixed in a version of git that I cannot build/deploy. That would result =
in the community
having to drop git on a mandatory basis (serious concern). Compliance =
rules are typically
to apply High CVE patches within a fixed timeframe, typically 30 days.

--Randall


