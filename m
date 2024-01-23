Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402191292E7
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968707; cv=none; b=A+Gk7Fzpw+cGUmlGzpuSw0wjU+h5bes2b1USwHIvNryCJkQxc2zQOM62U26nlltaj/t9J5CNbZpOfpnTIacsSEhoulrnUFKC342giWprbiHVo/3/eeCl87v8epciYDpHJDWuKn8bvCauO2YdmG0n1TWlCXKQDCs365CwbSUy4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968707; c=relaxed/simple;
	bh=4gfsIOojUdzUkztDh9XGE5OLr3qb1qCwB81kyd1Jfho=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dul9gSyWkT6hmPmZrLb6fkFwtOTR6bAfrFjcv1ZfWocnXdg1DRGHg0AQlG+5Em0YsdBwSPwUHy5D+6M92liRiTKbPmmAN726cF4QMkOPHIRq9vNqAq/utI7FTwPEV+6vPUxAAhLxR2qCT+uzVoQlSJ5xyHX1BAcF+s+kWOtKdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40N07NiT3879277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 00:07:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emily Shaffer'" <nasamuffin@google.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Git List'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org> <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com> <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com> <CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
In-Reply-To: <CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
Subject: RE: Defining a platform support policy (Was: [DISCUSS] Introducing Rust into the Git project)
Date: Mon, 22 Jan 2024 19:11:15 -0500
Organization: Nexbridge Inc.
Message-ID: <038701da4d90$b1bfb010$153f1030$@nexbridge.com>
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
Thread-Index: AQNL0k5wzhXZATyUnQ76Vxjn4eCV+QKEQ1wBALH7sDwDPprtZwK9Rr3fAtB2bewClWBgfq2OtDUg
Content-Language: en-ca

On Monday, January 22, 2024 6:18 PM, Emily Shaffer wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: Taylor Blau <me@ttaylorr.com>; Junio C Hamano <gitster@pobox.com>; =
Dragan
>Simic <dsimic@manjaro.org>; Git List <git@vger.kernel.org>; Johannes =
Schindelin
><Johannes.Schindelin@gmx.de>
>Subject: Defining a platform support policy (Was: [DISCUSS] Introducing =
Rust into
>the Git project)
>
>On Wed, Jan 10, 2024 at 3:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> On Wednesday, January 10, 2024 5:26 PM, Taylor Blau wrote:
>> >On Wed, Jan 10, 2024 at 05:15:53PM -0500, rsbecker@nexbridge.com =
wrote:
>> >> Just a brief concern: Rust is not broadly portable. Adding another
>> >> dependency to git will remove many existing platforms from future =
releases.
>> >> Please consider this carefully before going down this path.
>> >
>> >I was hoping to hear from you as one of the few (only?) folks who
>> >participate on the list and represent HPE NonStop users.
>> >
>> >I'm curious which if any of the compiler frontends that I listed in
>> >my earlier email would work for you.
>>
>> Unfortunately, none of the compiler frontends listed previously can =
be built for
>NonStop. These appear to all require gcc either directly or =
transitively, which cannot
>be ported to NonStop. I do not expect this to change any time soon - =
and is outside
>of my control anyway. An attempt was made to port Rust but it did not =
succeed
>primarily because of that dependency. Similarly, Golang is also not =
portable to
>NonStop because of architecture assumptions made by the Go team that =
cannot be
>satisfied on NonStop at this time. If some of the memory/pointer issues =
are the
>primary concern, c11 might be something acceptable with smart pointers. =
C17 will
>eventually be deployable, but is not available on most currently =
supported OS
>versions on the platform.
>
>I hope y'all don't mind me hijacking this part of the thread ;)

I'm happy you did this. The topic is crucial - if nowhere else but to my =
ability to sleep at night. Preserving Emily's comments without snipping =
as these are important questions and comments.

>But, Randall's remarks bring up something pretty compelling: I don't =
think Git has a
>clearly defined platform support policy. As far as I can tell, the =
support policy now is
>"if you run `make test` on it and breaks, and you let us know, we'll =
try to fix it" -
>without much in the way of additional caveats. If I look in =
CodingGuidelines I see a
>few "this doesn't work on platform X so don't do it" (like around %z in =
printf), but
>nowhere do I see "how to know if your platform is supported" or even =
"here are
>platforms we have heard Git works OK on".
>
>That causes a lot of confusion for the project - threads like this one =
(and presumably
>a similar one about C99 adoption) become a blend of "is this change =
good for the
>project or not?" and "will this change leave behind platform X?" that =
is difficult to
>pick apart.
>
>Does it make sense for us to formalize a support policy? For example, =
if we wanted
>to formalize the status quo, I could envision:
>
>"""
>Platform support: We make a best-effort attempt to solve any bugs =
reported to the
>list, regardless of platform. To prevent breakages in the first place, =
consider running
>Git's `make test` regularly on your platform and reporting the results =
to
>git@vger.kernel.org; or, better yet, consider adding your platform to =
the GitHub
>Actions CI (configured in `.github/`).
>"""
>
>Or, if we wanted to be able to move very nimbly, we could imagine =
something much
>more restrictive (note that I'm not endorsing it, just
>illustrating):
>
>"""
>Platform support: Git is guaranteed to work well on Linux platforms =
using a kernel
>version that is less than 1 year old. Support for all other platforms =
is best-effort;
>when reporting a bug on another platform, you may need to patch the =
issue and
>verify your fix yourself.
>"""
>
>I suspect there's a happy medium in here somewhere - trying to fix (or
>avoid) an issue on a platform which the average developer cannot run =
tests on is
>not a recipe for a happy developer, and a general policy of "patches =
welcome" for
>anything but latest Linux is not a recipe for happy users.
>
>I see a few axes we can play with:
> * which architectures/kernels/OS (do we care about more than the usual =
suspects
>of Linux/Mac/Windows // x86/amd/arm //
>POSIX-compliant?)
> * age of architectures/kernels (do we care to offer full support for a =
10 or 15 year
>old OS?)
> * new feature compatibility guarantees vs. core functionality/security =
fix
>guarantees (which do we really define "support" as?)
> * test provisioning (do we require a VM we can run CI on, or is a =
report generated
>from a nightly build and mailed to the list OK?)
> * test/breakage timing (should the above tests run on every commit to =
'next'?
>every merge to 'master'? every RC?)
> * who provides the support (is it the patch author's responsibility to =
fix late-
>breaking platform support bugs? is it the reporter's responsibility? =
and especially,
>how does this interplay with test provisioning and frequency above?)
>
>If we had clearer answers to these questions, it'd be much simpler to =
determine
>whether experimentation with Rust is possible or useful.
>Plus it would make developer lives easier, in general, to understand =
how much
>compatibility support work they're potentially signing up for when =
sending a change
>of any size.

I think we might want to add some considerations to the above list that =
go beyond what other projects use, OpenSSL as an example:

* Can support for exotic platforms be delegated to some "community" =
support concept. In NonStop's case, I currently do 99% of the =
verification that each release runs properly. If I am able to provide a =
fix, I will. We have been fortunate that most problems/solutions have =
been of general interest and impact, with my platforms being more of a =
"Canary in the Coalmine" situation where we just encounter it first =
because of edge conditions, but other platforms may be impacted. The =
problem here is time of how long a designated community support =
person(s) can keep supporting git and what happens when they (me) retire =
or get hit by a bus. Like all good NonStop people, I have a backup, so =
git does not need to worry about me specifically.

* What is the broad impact of dropping support for a platform that has a =
significant investment in git, where loss of support could have societal =
impact. There are platforms with 100 million to 1000 million lines of =
code managed by git today. This type of investment-related impact is =
specific to git compared to other Open-Source products. Leaving debit or =
credit card authorizers without a supported git would be, let's say, =
"bad".

* Could stakeholders be consulted before changing support levels? Yes, I =
get that commercial fee-based products hit this more than Open-Source. =
Looking at other products in the Open-Source space, there are fee-based =
support models that could be developed for long-term support (beyond the =
obvious LTS-type considerations - see OpenSSL's model for reference). A =
related question is: "If there is a bug detected in git, what version is =
the oldest supported git version to which a fix can be made?" 2.0.0? =
1.8.0 (looking at some Linux distro's RPM or APT repositories as being =
seriously guilty here). My MacOS server (just a couple of years ago) =
came with 1.8.0. I can't answer that question if asked by a customer. An =
alternative model, which seems to be informally embraced by git is =
"please upgrade to the latest - or a fix on the latest few releases". =
But this position puts pressure on the team to maintain platform =
compatibility for indefinite periods.

* What level of compatibility will be more appropriate to ensure git's =
reputation as the gold-standard version control platform? Without a =
board of directors, or at least an advisory board, this might not be =
answerable (or even decidable). That role has been taken up, by intent =
and/or because it has to be done, by our quite awesome committers.

This last two point put a serious amount of pressure for compatibility =
on both the customer and the git dev team to keep compatibility in the =
latest release with all platforms, especially the exotic platforms - =
mine included - although dropping those is not a good approach either. =
As an example (not intended as guidance) If we said something like git =
2.40.0 is LTS until September 2026, and security fixes (and critical =
functional ones) will be done going back to that version, and anything =
older requires an extended fee-based support contract, I think it would =
make some organizations more comfortable with the support model. This is =
not a panacea and there are some obviously difficult concerns here - =
causing git's support model to vary from some Linux distro models from =
the earliest inception of both products.

I don't have a good answer to any of this that would satisfy everyone. =
I'm not sure there is one.
--Randall

