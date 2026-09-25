Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C648A8AC
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330020; cv=none; b=gj3lX4HM3v2PjYpMHoTua9FkjV5j1zbWl0pdmZX49uPe5yR3/aUTeZ+asrJ6FTJn+I9sv9d/8U0z0CVKw8z/Wt+mFceY0y/1DJ6DGKZbUgVBB7r6TM3CzjhuKMmYmlTdG24PgeZniQRRYAuoxNHju1jPy7TCNV+6Irj2GYWRQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330020; c=relaxed/simple;
	bh=QzvXiQ9VlUaRtq8wgxnTmuqK54mTfrxuqGju0vGzLQk=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=QKgEwHRVefi9gFDKD9TvyWLrK9p/0ELP/LVmFleIZ8VtpfRKJXMVUv23V5k9mhcfXcZBz5hgS/NYsl7R+gI2lAEojq0YNAiOX5JRI3KTvn6d3fFhBom6Px8AHeQGpqa96Jiv+oqJY2RkFykPM/gUAndVCs0PJYAyMVC3doDzBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4KdZ/Xw; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4KdZ/Xw"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485ac898fa4so540425f8f.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790330012; x=1790934812; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzDo3pinM9PH4AQb/2gj9vvI8Hax//OlgNxNZfK0INE=;
        b=E4KdZ/Xwqc9dpezudadfBYaUO2vNpcj1ImHTNnGn8e3szl9MO+st36dQuV6m68MEpR
         qYrDIlxcvBBprBUOu+tzlaALXAlp9mCo03uCcEgXUuTWgsPWtmOAowObc3Hn5t+poIXe
         a83FjPIpl21siFb5zCNm7l411ZTjwOQbidZ0dKcbgvcVqYmQ+43zqN1lLUJ0QqxV/3O6
         THN/7eJ1DVSYpTW0VB1cVkSSpoZvuZFbgu7EXldVK/mxKCewUj/xO5FRQ0WX+owBQsWW
         PHHw8dXD9WsAF+l4s1VvuyCQgvclVIpBVqK7y8ZOGBEchml8g0umWBo8GtAmVs0fBhWt
         4X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790330012; x=1790934812;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzDo3pinM9PH4AQb/2gj9vvI8Hax//OlgNxNZfK0INE=;
        b=tawNJFYDzWiwsF8dZdYPS+QiUh1UGVUHr22jg3gZeFUyvyyOHsbPSQIsJVQsL0r7Kt
         tJHWRVaHNXBPNASAgnm2JZ8xdv0zyW3sVL1gvD/1j65q7SogOOO9WYP2v/MARdcsE4G1
         jdNaQlbSWMt6uhfIvzZv10VZ4Qr4XrTe7/2Xqle0HSA6+veR8T0zxHSTkcm9jDEDz6GA
         f65MpHnhaKd8h2xmsAfFcPimYidYQt0RQ+R61bNxm/V81xzAC4i3DkIUTtsOwI45/slC
         nIEf5FLKZg14R1sTBzat/VBle/1mpR722VKXNJn6WDEBimz0X4BbrNua/vKIBtioEoyI
         EwsA==
X-Gm-Message-State: AFuF++l2X7S+20WBgdGSRWUzx8NUJ/qzwkDXbqahzI0+kvcF+serskJX
	YCKEnYz6pas8fnhFhm4dYJE8OwAn9+CjaCY9PPxB9+8lW9C0RHcf31o+lx7U9w5I
X-Gm-Gg: AYBFou21AQpKDlYR+kS9bZQF330UgjpenBNR9EJYDPIEc6t4i/wbTtAKLHgHYEzYT98
	+ere8Dz6k4Xmm/gwui+VffKFGh4+REY1J5S4MguQBNxUudG5OVAC/PluVlwqHizr7fVLjZfGCAi
	R+2BZ3YWCWn9MBEddCPHtqpXTKn9x/cwOdy+6QVP24h+oDZ4u89jxgap5yz37DJa06vEF5mp/j1
	cA8arKUm2Umgce4wl54WN7F/u9kb2odEYVsTBzwBeV7vxlHGjFWN5w9RCGK0mzdSCBPGHyIVKcG
	w2GjX1Y8OidCutNkqZcvI2yD2DtGvqhxR11+ga9egTNGoE/TS6x0/BJH5zoyxcFfTi753u7z3za
	yjJYjPMN3sVKaQQCEBfaNGYWP5BhTUHTTF3Y8MVPKkQOcbetlfalc+cRfn4BnGqbsSW6LXT1MJi
	yLc4wLqlVT12MLpzkNKKs2WVqF9B1WB6nhYX0uaRht9zrnD5R52dJf0nIybxtJoh2rgzOuNJHtE
	A7EggTEaJSOcAQyv8ohi20VBc7a+d1oLuoU18t/Ojp+cshwwYN7tW1cemo5S7LROW+tEO8KF0yI
	DNs=
X-Received: by 2002:a05:6000:617:b0:488:654b:54d4 with SMTP id ffacd0b85a97d-488719776fdmr9592521f8f.50.1790330011746;
        Fri, 25 Sep 2026 02:53:31 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:c535:c317:abf8:cf27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm6497162f8f.17.2026.09.25.02.53.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:53:30 -0700 (PDT)
From: Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
Date: Fri, 25 Sep 2026 10:53:19 +0100
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
 <c12b9da1-b679-43e5-9485-2cedeb1dc613@gmail.com>
To: git@vger.kernel.org
In-Reply-To: <c12b9da1-b679-43e5-9485-2cedeb1dc613@gmail.com>
Message-Id: <0A5DE74C-053E-4732-B7F2-174EA198539F@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)

Thanks Johannes for the detailed summary,

See below some additions on the storage backend in JGit below.

> On 23 Sep 2026, at 12:55, Daniele Sassoli <danielesassoli@gmail.com> =
wrote:
>=20
> Hi Johannes,
>=20
> Thanks so much for this summary, I didn't participate at the =
contributor summit
> as I was leading one of the breakout sessions in the morning and had a =
plane to
> catch in the afternoon, so I'm very grateful of your summary.
>=20
> On 22/09/2026 19:44, Johannes Schindelin wrote:
>> Hi Junio,
>>=20
>> On Tue, 22 Sep 2026, Junio C Hamano wrote:
>>=20
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>=20
>>>> On Mon, 21 Sep 2026, Junio C Hamano wrote:
>>>>=20
>>>>> Git 2.56-rc1 has been tagged.  We may merge last-minute fixes =
before
>>>>> the final Git 2.56 release, but otherwise I do not expect any new
>>>>> feature topics to be ready before the final, so most of the
>>>>> in-flight topics will stay cooking in 'next' until then.  As
>>>>> discussed at the Git Contributors' Summit, the version after the
>>>>> upcoming Git 2.56 will be Git 2.98, scheduled near the end of this
>>>>> year.
>>>> Would you say that the following is an accurate characterization of =
the
>>>> timeline, so that people who need to plan dependent projects can =
rely on
>>>> it?
>>> My outline was deliberately limited up to end of this year as I am
>>> hesitant to say beyond that point before the meeting notes are made
>>> public.
>> I originally wrote this summary of the Git Contributor Summit only =
for my
>> own records, but since you hinted at wanting some meeting notes, =
figured
>> it might be interesting to other people, too. So here goes my =
distillation
>> of the breakout-sessions from this year's Contributors' Summit. Many =
of
>> these ideas still need discussion on the list; proposals below are =
not
>> project-wide decisions.
>>=20
>> Security mailing list and process
>>=20
>> The security list is seeing a large influx of outside reports, =
apparently
>> often AI-assisted or generated. Duplicates and reports outside Git's
>> security model consume triage time, while some patches have waited =
for
>> months. Waiting for an empty queue is not a workable release =
criterion: we
>> need to release the fixes we have, rather than hold them indefinitely
>> while more reports arrive. No fixed release cadence or guaranteed =
response
>> time was settled.
>>=20
>> Documenting Git's security model would save repeated explanations of =
what
>> does and does not constitute a vulnerability. (Personal note, not
>> discussed at the Summit: Stolee had tried to start a conversation =
about
>> Git's security boundary a long time ago, but nobody replied. Maybe =
the AI
>> onslaught will provide enough motivation to get that discussion =
going.)
>> Moving non-security bugs to the public list more readily was also
>> encouraged. A timeout after which public discussion would be presumed =
OK
>> was proposed, but not agreed.
>>=20
>> More company staffing would help, without turning this into an =
obligation
>> for volunteers. Paying for dedicated help was discussed, with =
onboarding
>> costs a concern. Using AI for triage or fixes raises confidentiality =
and
>> DCO questions of its own. (Personal note: There seemed to be some
>> sentiment in the room that contradicted the earlier agreed-on finding =
on
>> the mailing list that using AI for triaging and for investigating =
wasn't a
>> copyright concern and should therefore be considered permissible.)
>>=20
>> The release bottleneck is not really tag automation. Merging and
>> backporting fixes, preparing advisories, and handling CVEs take work, =
and
>> too much of that knowledge lives in people's heads. Peff volunteered =
to
>> start a public discussion of the process and dig up existing =
resources.
>> (Personal note: I have done that merging, backporting, etc plenty of
>> times, and I don't think that it is the bottleneck, and I was rather
>> surprised to hear that it is complicated. Sure, there are the =
expected
>> merge conflicts when merging `maint-*` branches, and running -- and
>> fixing! -- CI on all of the tags in a private repository should go =
without
>> saying, but that's all craft of the trade. Rather, the indecision and =
lack
>> of engagement on the git-security mailing list is what I see as the
>> blocker. I'd happily volunteer to juggle those branch thickets if =
that was
>> truly the make-or-break issue here.)
>>=20
>> Microsoft's release process reportedly needs about seven weeks. There =
were
>> no objections in the room to proceeding without waiting for that =
schedule.
>> (Personal note: That release process was misrepresented, which is
>> surprising, as I coordinated two or three Git for Windows security =
bugfix
>> releases _on the git-security list_ since the most recent Git =
security
>> bugfix release, it's always the same thing: release on a second =
Tuesday of
>> the month, three weeks before that the patches need to have settled,
>> everybody goes home with a dependable timeline. It's not really that =
big
>> of a deal. Testing patches, constructive feedback, these are the =
things
>> that are missing and therefore blocking the process. I sensed a lot =
of
>> finger-pointing in this discussion. I mean, I don't blame anybody for
>> avoiding security work: it is stressful and intense. The =
responsibility
>> for getting things wrong is enormous. I know that because I've done =
my
>> share of that, probably more than most in the Git project, and I will =
do
>> even more in the future. But when I don't have the time, or the =
energy, I
>> am aware that I, myself, am the bottleneck; I don't need to blame =
others.)
>>=20
>> Git v3.0
>>=20
>> The proposed target is spring 2027: v2.56 in September 2026, v2.98 in
>> December, then v2.99 and v3.0 next spring. The jump in version =
numbers is
>> intended to signal the approaching breaking changes. March and April =
were
>> both mentioned; the precise timing is not settled.
>>=20
>> There was agreement on releasing v2.99.1 and v3.0 together, differing =
only
>> in the BREAKING_CHANGES (v3.0 switches them on). That keeps the =
transition
>> separate from another round of feature development. Nobody in the =
room
>> objected to Rust becoming mandatory in v3.0. (Personal note: probably
>> because Randall wasn't there, to say that NonStop support would be a
>> blocker and that Git please wait.) A v2.x LTS remains an open =
question,
>> with Gentoo mentioned as an interested party. (Personal note: I am =
still
>> advocating for an in-tree Long Term Support branch, and since Junio
>> indicated that he's less than eager to take care of that, I would =
love for
>> Patrick Steinhardt to be the "LTS lieutenant", I vaguely remember =
that he
>> said he'd do it if asked, and I trust his judgement, so I'd ask.)
>>=20
>> SHA-256 support across the ecosystem had been a blocker. GitHub =
reported
>> experimental support, with general availability expected around =
November.
>> GitLab already had public, non-experimental support, and libgit2 =
supports
>> it, too. JGit remains a gap; Google was not planning to fund that =
work.
>>=20
>> The SHA-1/SHA-256 interoperability work, including historical tags, =
was
>> reported to be implemented but not yet sent to the list. (Personal =
note: I
>> think that the room seriously "mis-underestimated" the real-world =
impact
>> of this. The code is not even on the Git mailing list, and the
>> ramifications of not having a robust plan how to deal with partial =
clones
>> or submodules or even signed tags strikes me as a dealbreaker. I =
would not
>> be surprised if the decision to enforce SHA-256 as default would have =
to
>> be revisited before v3.0, and possibly overturned.)
>>=20
>> Documentation
>>=20
>> Julia's work highlights the gap between documentation written by =
people
>> who know Git inside out and users who do not yet know what objects, =
the
>> index, or upstream mean. We need approachable learning material as =
well as
>> reference documentation. Both need work; keeping manpages concise =
does not
>> mean they cannot have better explanations and examples. (Personal =
note: I
>> am beyond excited that Julia, whose work I have always admired, got
>> interested in improving Git's documentation, which is in dear need of
>> being improved, mainly because it does not cater to the majority of =
Git
>> users out there who are unlikely to wander onto the Git mailing list,
>> ever. I just hope that old-timers who really do not need the =
documentation
>> nor understand the need of those who do need it show enough =
appreciation
>> for the fresh views and for Julia's understanding of the target =
audience.)
>>=20
>> Discoverability matters, too. The website (https://git-scm.com/) =
needs
>> clearer entry points for learning Git, and existing guides are harder =
to
>> find than manpages. Missing subsection links are another improvement =
we
>> could make incrementally. (Personal note: Judging by the history of =
that
>> site, I do wonder whether the core Git contributors are interested in
>> helping this effort at all. For example, there are a growing number =
of PRs
>> suggesting to add new UIs to the growing list, but I gave up =
reviewing
>> them because I was the only one doing so.)
>>=20
>> There was support for replacing outdated material and for merging =
useful
>> improvements, then iterating, rather than trying to perfect =
everything
>> before it lands. Bringing user feedback to the list without flooding =
it
>> remains a challenge.
>>=20
>> The current funding covers only 100 hours split between two people.
>> Additional project and company funding was encouraged; brian, Emily, =
and
>> Mark offered to explore company support. (Personal note: I had tried, =
back
>> when GitHub still funded my team, to start something like that, =
without
>> any success. To the contrary, even Git for Windows and Git Credential
>> Manager got defunded.)
>>=20
>> On the tooling side, using only Asciidoctor instead of maintaining =
both
>> AsciiDoc and Asciidoctor support was proposed as a possible Git v3.0
>> change. Distribution support and rendering differences need checking, =
with
>> doc-diff suggested for comparing the outputs. Patrick filed an issue
>> during the discussion. (Personal note: AFAIU the AsciiDoc spec is now
>> maintained by Asciidoctor, and I am aware already of one change that =
was
>> made to the spec without adapting AsciiDoc accordingly. So the entire
>> discussion might be quite moot already.)
>>=20
>> Other ideas included richer diagrams for HTML while retaining text
>> versions for manpages, and privacy-respecting traffic measurements to =
help
>> prioritize documentation work. No diagram format was chosen, and =
caching
>> and AI scraping complicate getting useful traffic data. Mermaid was
>> proposed, and even GraphViz. (Personal note: I added support for =
Mermaid
>> diagrams to https://git-scm.com/, but it turned out to be too =
limited, so
>> I added GraphViz support. The support code for this is a bit of a =
beast,
>> having a wasm version of GraphViz for development, pre-rendering the
>> diagrams as SVG and as PDF during deployment of the site; it was =
quite a
>> bit of fun to implement all that.)
>>=20
>> Outreachy sponsoring
>>=20
>> The goal is to support three interns in the round starting in early
>> December, at $10,000 each. The corporate sponsorship previously =
provided
>> by GitLab and GitHub has dried up, leaving Git itself to pay. There =
are
>> company contacts to follow up with; Emily offered to ask Google's =
OSPO,
>> without high expectations. No new sponsorship commitments were made.
>> (Personal note: I don't think that these internships provide enough
>> publicity to give companies much of an incentive to fund this. Which =
I
>> find a bit of a shame, Outreachy in particular does a lot of =
important,
>> good work, and if I wasn't so constantly overworked, I would want to
>> mentor again; I always found it rewarding, even if I hold myself to a
>> quite high bar which is quite draining.)
>>=20
>> A related point for Git Merge 2027: announcing the location early =
would
>> help Outreachy and GSoC interns plan attendance. No location was =
selected.
>>=20
>> Pluggable object database
>>=20
>> Patrick's pluggable object database is working, but it is not =
complete:
>> commit-graph and multi-pack-index integration are still outstanding, =
and a
>> repository extension is planned. (Personal note: It might be =
interesting
>> to see whether implementing a storage backend is easier in core Git =
or in
>> another Git-compatible implementation. JGit should be a natural =
target,
>> having originated within BigTable-sized constraints, i.e. a different
>> storage system, but funding seems to have dried up, there's not even
>> SHA-256 support, so JGit might not be as hackable as it once was.)
> Pluggable backend implementations for JGit have been possible for =
quite some
> time, although, admittedly, I don't think any made it to production.


I'd like to provide some context here, as several pluggable JGit storage
implementations are actually running in highly demanding production
environments today.

First, the Git servers at Google (including gerrit.googlesource.com) are
powered by a custom, pluggable JGit storage backend built on top of =
Google's
internal data-center storage. While the backend implementation itself is
proprietary, it relies entirely on the exact same JGit classes and =
pluggable
interfaces available in the open-source project. It has been operating
smoothly at a massive scale for over a decade.

Second, there is a highly successful open-source implementation focusing =
on the
ref-db layer of Git storage. Developed by GerritForge over six years ago =
and
donated to the AOSP project (see the GitHub mirror at [3]), this backend =
is
used daily in several large, multi-site Gerrit deployments worldwide. It =
allows
for globally consistent updates of Git repository refs across =
distributed
remote sites.

Third, regarding the implementation mentioned by Dani [2]: while it =
captured
attention 10 years ago, without seeing immediate adoption, I suspect the =
timing simply
preceded the current appetite for AI-generated code. The demand is =
entirely
different now. The architectural foundation Google built into JGit over =
16
years ago is perfectly positioned to support these kinds of modern =
innovations.

It is genuinely exciting to see the core Git project moving in this same
direction with Patrick's work. Pluggability has always been a core =
strength of
JGit's design, and seeing the broader ecosystem embrace this abstraction =
is a
huge win for all of us.

[3] (github.com/GerritCodeReview/modules_global-refdb)

Luca

> Maybe at
> the time when this was introduced(16 years ago!!) by Shawn[1] in JGit =
it wasn't
> fashionable yet and so the project was never carried forward. I know =
Luca
> submitted a talk for the Gerrit User Summit to present a Cassandra =
back-end, for
> which I can see conversation started 10 years ago[2].
>=20
> Regarding JGit support's for SHA256, I know some corporations have had =
interest
> in sponsoring this work and have discussed potentially implementing =
together it
> with GerritForge, but, as far as I know, work isn't ongoing yet. JGit =
is still
> very much developed and kept up to date with great effort from the =
community, so
> I believe it to still be as hackable as it was, there just hasn't been =
enough
> interest for SHA-256 yet, which I agree is a shame, hopefully in the =
near future
> this gets remediated.
>=20
> [1] https://github.com/spearce/jgit_cassandra
> [2] https://groups.google.com/g/repo-discuss/c/IekVPmow0yE
>>=20
>> Content-defined chunking prompted an important distinction between
>> changing how objects are stored and changing the logical object =
model.
>> Starting at the storage layer would let us preserve existing blob =
OIDs
>> rather than require ecosystem-wide changes. A new pack/index format =
could
>> provide another representation of the same object, much as deltas do
>> today. No particular representation was agreed. (Personal note: It is
>> curious to me why nobody tought about inventing a "meta blob", i.e. =
an
>> object much like a tree object, except that it stitches together a =
larger
>> blob. This would allow for the content-defined chunking that `rsync`
>> already championed, way before Git was born! It would have allowed a =
Git
>> native large file support worth writing home about, and could have
>> replaced Git LFS. Xet (https://huggingface.co/docs/hub/xet/index) =
would
>> not have had to be invented, and it would have allowed game =
development to
>> move to Git. I can only imagine that the time it would cost to get =
even
>> the first patches of this into core Git would be seen as prohibitive =
by
>> any company who may have considered the effort.)
>>=20
>> There is also an API question: does a backend seeing only object =
content
>> have enough context to make good storage and delta choices, or should =
it
>> receive richer information? More searchable tree storage and a Git =
"commit
>> cloud" were other possibilities raised, not committed plans. =
(Personal
>> note: At a previous GitMerge, Facebook presented their work, see e.g.
>> =
https://github.com/facebook/sapling/blob/main/eden/mononoke/blobstore/pack=
blob/README.md,
>> which includes separating actual storage from transport. That is, =
already
>> at push time, derived metadata is computed in async jobs which =
provide
>> several potential deltas ready-to-go when a client clones or fetches. =
They
>> reported clones with regular Git clients that are twice as fast, just
>> because the server doesn't need to spend much compute on the data it
>> sends. So there is a lot to be learned out there already.)
>>=20
>> AI
>>=20
>> The current SubmittingPatches policy is rooted in DCO certification =
and
>> advice from SFC lawyers. The unresolved question is whether, and to =
what
>> extent, contributors can certify AI-generated code. There was =
substantial
>> disagreement about acceptable use, provenance and legal risks, =
community
>> trust, review burden, and whether the current caution excludes useful
>> tools. No policy change was agreed. (Personal note: You'd think that =
the
>> opinion of lawyers is taken at face value, but no, it seems that some =
core
>> Git contributors seem to disagree with the lawyers in favor of their =
own
>> opinion...)
>>=20
>> Several participants found language and proofreading assistance =
useful. A
>> particular concern was submissions where the human does little more =
than
>> relay agent output, leaving reviewers to deal with the consequences. =
The
>> influx of poor GSoC contributions was one example. Attribution such =
as
>> Assisted-by was suggested to make tool use clearer, but attribution =
alone
>> does not answer the quality or DCO questions. (Personal note: my =
precedent
>> of "Assisted-by" was called out as helpful, and I do think it is. I =
make a
>> difference between AI-generated and AI-assisted. I'm not a fast =
typer, so
>> I benefit a lot from being able to tell an LLM to please refactor out
>> these four lines with the appropriate signature. There's not much
>> creativity in there. I also like to let AI present me the call graphs =
for
>> certain code locations, because due to the choice of C, which thanks =
to
>> the C preprocessor is not easy to analyze statically, there are no
>> competent tools other than LLMs that I can use for the task. I was =
highly
>> surprised, though, to see how much enmity against AI in general was
>> voiced, not by many, but many, many times, and how that contrasts =
with the
>> Linux project which I hitherto had not considered to be as =
particularly
>> open to modern practices.)
>>=20
>> brian and Taylor agreed to put differing policy proposals on the =
list. The
>> suggested process is to have alternatives examined by SFC counsel, =
make
>> the risks clear, and then consider a vote. Emily volunteered to =
organize
>> the voting procedure. Eligibility and the details remain open; =
Junio's
>> authority as maintainer remains central. (Personal note: Since Taylor
>> works for OpenAI now, I was not surprised by his stance, but brian =
works
>> at GitHub, home of GitHub Copilot, and I am not sure how favorable =
their
>> employer would look at their semi-public utterings about AI...)
>>=20
>> Protocol v2 for pushes
>>=20
>> There are concrete use cases now: repositories with millions of refs,
>> including a reported 896 MB ref advertisement. Reftable improves ref
>> update throughput, but does not by itself solve the advertisement =
problem.
>> Nobody objected to push protocol v2, and the fetch-v2 infrastructure
>> already provides much of the foundation.
>>=20
>> The discussion covered advertising fewer refs, letting clients =
identify
>> useful branches, and replacing large advertisements with a few rounds =
of
>> push negotiation. Negotiation results could also help optimize the
>> server's connectivity checks. Some improvements might be possible in =
the
>> existing protocol before introducing v2.
>>=20
>> We need to measure the tradeoffs rather than assume fewer bytes means
>> faster pushes. One example involved a shallow push taking 35 seconds
>> instead of two because of work to minimize the transfer. Shallow
>> boundaries and unrelated histories complicate the proposed =
heuristics.
>>=20
>> SHA-256 interoperability is another reason to want push v2: the =
current
>> push protocol requires using the server's primary hash algorithm.
>> Negotiation could make that more flexible.
>>=20
>> Forge replication to thousands of mirrors would benefit from finding =
out
>> cheaply whether refs have changed, rather than downloading full
>> advertisements from every target. Checksums, ETag-like values, and
>> reftable generation numbers were discussed, with concurrent updates
>> complicating the picture.
>>=20
>> Compact or compressed advertisements are also worth exploring and
>> benchmarking, possibly reusing reftable's format. That does not mean
>> sending the server's actual reftable, including hidden refs. There =
are
>> several promising directions here, but no final design yet.
>>=20
>> Some breakout sessions were planned, but apparently had to be cut.
>>=20
>> Personal notes: I wasn't present for all of the sessions, in the =
afternoon
>> I had other commitments; Therefore these notes (which AI assisted me =
in
>> distilling) came partially from what I dictated and partially from =
the
>> shared Google Document in which a few volunteers gracefully wrote =
notes. I
>> found it challenging to connect as a remote participant. The link to =
the
>> Google Meet, as well as control over the lobby thereof, seems to have =
been
>> restricted to at most a few people, which might have contributed to =
the
>> long waiting time before I was allowed in, and it definitely =
contributed
>> to my comments not reaching the discussion in time to have an impact. =
I
>> would have loved for Junio or the other two brave souls who also
>> participated remotedly to have had more "air time". I am still a fan =
of
>> the idea to have more frequent, smaller, virtual Contributor Summits,
>> organized by a rotating cast. (Maybe I can get Emily to host the next
>> one.) I was very happy that Junio was participating, as he _is_ the
>> project lead, and in past Contributor Summits decisions were taken =
without
>> him, which I found odd. Timing was really challenging for him, =
though, it
>> was way past midnight for him. I'm all the more grateful that he
>> did participate.
>>=20
>> Final remark: This summary is obviously biased. I lightly edited it =
to
>> separate better between my personal views and a hopefully unbiased =
account
>> of what was discussed, and how, and by who. Nevertheless, I am but =
human.
>> As a consequence, I would be delighted if other participants would =
share
>> their summaries, so that my bias can be balanced out.
>>=20
>> Ciao,
>> Johannes
>=20

