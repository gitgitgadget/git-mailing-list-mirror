Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0865C47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF7320735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qkrek66T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgEEPBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 11:01:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:35625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbgEEPBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 11:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588690875;
        bh=+d0bAuUN3CfgsQGnc9qePsYvElZxCspOcEeW43FublQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Qkrek66TiyovY9GqgI4rzrZo5906WQbO7BxbewJaWWxbwj2z+sSb3q6TV5FRP2hyv
         aHYFyTXWNhINfX63CZozW3GDE7VT0Zg7gsdTakn8xt/VqVAaEugCmWzMuC6kaeFxb6
         4Cxtx7wYV86U/qvkMm+fFlpeVa3uSM60bDHQikgs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.224.161] ([89.1.215.30]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1jRq4827nf-005L9G; Tue, 05
 May 2020 17:01:15 +0200
Date:   Tue, 5 May 2020 10:00:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] Minimal patch series to fix the CI runs of
 hn/reftable
In-Reply-To: <CAFQ2z_MR2JTAmxcLCzHiVJnufdHRzzbo02kM_wxM7b6agZKc1g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005050839410.56@tvgsbejvaqbjf.bet>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com> <CAFQ2z_MR2JTAmxcLCzHiVJnufdHRzzbo02kM_wxM7b6agZKc1g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BX8HczlNmVcD1CvJztDVJTKgzmCRb955Y3041RQ1hWkgCjknw4S
 xRbPwFnnPzlBJjRG7sxxlgB8oOk0MjOxAlwgf2h8IWxyUIlEs6t8NlSEZzyOykKfOMXOy+k
 mcZGImDTKGa5QucYZ6glvkDS1yTC2jsMP3CYl1cy4bmOpcMXbfOfJjkFsZzLneSXJ5YHNMw
 wGy4Lj5zFToiUVZc62n5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8AjFj6ghJ4g=:X/oe36kNam8pjGFIFMQSWx
 wysWYfyzF59s2LR5KYKu9l9/CVH980/YO22EziKiDTxojCzEaMYhIz8ju/PFZvZEnfPFxuH+p
 CIOIVjWhxqZOXSOuMSiSoG2qCZzUyZOMYCzuJcFSaPCko81e11eBC/ZJoGymeASiRf5ovwRdy
 4Pri6mW71cSnqG+InDw5GB1ZKJfw2kaduNhvm7jEfZFaeSxYhKrLmSOxNgFF2N8JwQLU34xIM
 aLKPVsyrRiC9xkT6pyckok2+79rT4jUA0jXqJGRZf9jKj8zTuCa90iFBT6L9JNzDoPzNntDj6
 Bi8QJvvgH1qSexbg3mxquaKlSIl227B+uW4MEAl9EROQLRSIeyzyl1lcaN4yHSWA5AIk8/XNk
 Uwdd+Y/qXKCk06sIoTlIIAsYe93jYVNWV1IvFLQVFcFbzUiCZloKS09A/M0RekZGUq9gBV0Dn
 ozdDCtuiEUviXWEZXQm6UONnBSRyai455+qWDK2kqvpLykb0imDPbWopG+yOFC5hQ9z1X/IR4
 4ZjIefgl23OwSbg3a1c4YANFqhOuBhZN6kwQHk4HqcMDDx9aVA3QGa7Dnyd/ZsDFUll+319eK
 7oO2m/w8w7mKPQrKPFLtte8rmkObfowkjo4BepwC2cyt+IQjli4jkuAVh/vvReMgu6WaZHkgz
 GHCuCVaNCajSCq8FD8gwKolZfW5hXt18EIh0WpcKpmubtpJWAIq21CTBQUtlJbOc7yC6XQnu3
 3+P3KJMzL97wVptMJV0m7qg9+5uhUDvPfu5v0ZyHz6TlLE/9d3ba5fhNrInkfxVZvqOblG9hI
 kq5v05l87K7Wb/rh1cG0uwifbD11KSDBxr3WHb4XmVNytre0fJB2PgZgVNHNhl0J07+JkMWe8
 KrI+zH1YJnzeVRH3VCadLZjIdQY+NFgekuv+IMGPPXh3a4OcZB3aOA2mwcx8vrHCkQIAj7sMV
 NS6uWx4Ce0WgPzkvBSFZqXrZRvjuMJl118EZe1Yqd/7Ilwox+sw78qvco7lZGfiTJGLr/fYzt
 vMQ915OadFxLw7h8i9Pnxsxq5Osj8YpTpoqiQMB+BgRtqEa+6pE6Iy8xGPmZ728zT3I/7bjGd
 KsIiqIVhjS9wKAvC1nFY6VbNOygNxLR6ij/7DhzWTSLLviatqo8ZF8F4QRqVtBJUF5Kl/NxT2
 6Zx5FfwgL2DTlnjjCg1L25m7SRwQSmSVHbMBZVu2izRMg19PwDSLXf8mms2KcuNoICUtQKbcB
 ASwSE4Kqvg315Dn9B
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Mon, 4 May 2020, Han-Wen Nienhuys wrote:

> On Mon, May 4, 2020 at 3:31 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > These patches are not intended to be complete, not by any stretch of
> > imagination. They are just enough to get the CI run to pass, even in t=
he
> > Windows-specific parts.
>
> Thanks for the investigation. I had begun to setup a Windows
> installation, but you beat me to it.
>
> Here are the two fixes as I applied them.
>
>  https://github.com/google/reftable/commit/201f21aa39f993c970ef4d19122fe=
dd5b91e716d
>  https://github.com/google/reftable/commit/18b041472306b31813dbd6408f6a6=
1daaba60013

If you ever needed _any_ kind of proof that the current setup with that
monster patch and a totally separate "upstream" does simply _not_ work, it
is these two commits.

_Every_ bug fix originating from git.git would have to manually port the
fixes because of the vendor copy, just like you did, losing all provenance
apart from a meager "Thanks to" (which mentions just the bug report
forgetting about the actually-tested patch).

But I don't get the impression that my objections are heard, so I might
just as well stop talking about it. Please do not misinterpret my silence
about your patches as any indication that I am happy with `hn/reftable`: I
am not. Should Junio accept them without drastic changes (which I hope he
will not), I expect this to turn into a complete maintenance nightmare.

Besides, it is a bit disappointing to see only those two patches. I made
very clear in my patch series that I got the _distinct_ impression that
those two bug fixes were just the tip of the iceberg: there are most
likely a lot more bugs waiting to be discovered where a file is not closed
when it is no longer needed (or related: memory not being released as soon
as it can be released). I expect _many_ more similar issues to lurk in the
code base.

> > As I mentioned elsewhere, I would much prefer for hn/reftable to not
> > re-invent get_be*(), struct strbuf, struct string_list, struct lock_fi=
le
> > etc.
> >
> > However, in the context of the test failures, I do not think that this=
 would
> > have made a big difference. Apart from the unportable constructs, and =
from
> > the "delete/rename while there is still a handle on the file" issues, =
it
> > would appear that one big reason why it was so hard to debug and fix t=
he
> > test is the recursive complexity of the data structures.
> >
> > To elaborate on that: struct reftable_stack has an attribute called me=
rged
> > that has an array of struct reftable_reader * (confusingly called "sta=
ck").
> > Each of these readers has an attribute of type struct reftable_block_s=
ource
> > that uses a vtable and an opaque pointer to abstract three types of bl=
ock
> > sources: file, slice (which is apparently unused, i.e. it is apparentl=
y just
> > dead weight for now) and malloc.
>
> All of the unittests use slices to read and write single reftables
> in-memory.
>
>
> The malloc block source is used to swap out a block coming from the
> file directly, with zlib  uncompressed data (log blocks are zlib
> compressed). I think there should be a mmap block source too, at some
> point.

If that was intended to convince me that I am wrong in my assessment of
the unnecessary complexity of libreftable, I am afraid it did not.

Only code should be included in the patch adding libreftable to git.git
which is actually needed in git.git. Everything above that is just
unnecessary complexity.

> > I am not sure that this abstraction fest serves us well here.
> >
> > Quite honestly, I would have expected the packed_git data structure to=
 be
> > imitated more closely, as it strikes me as similar in purpose, and it =
has
> > seen a ton of testing over the past decade and a half. I could not rec=
ognize
> > that design in the reftable, though.
> >
> > It is quite obvious, of course, that the code tries to imitate the
> > object-oriented nature of the Go code, but it seems quite obvious from=
 my
> > difficulties to address the problem where stack_compact_range() would =
try to
> > delete stale reftable files (without even so much as a warning when th=
e
> > files could not be deleted!) without releasing all file handles to all
> > reftable files, even the ones that do not need to be deleted. To be sm=
arter
> > about this, the code has to know more about the nature of the block so=
urce
> > than the abstraction layer suggests. It has to know that a block sourc=
e
> > refers to a file, and that that file is marked for deletion. My heavy-=
handed
> > work-around, even if it works, is not really a good solution, but it i=
s a
> > testament that there is a lot of opportunity to simplify the code
> > drastically while at the same time simplifying the design, too.
>
> If the code tries to delete a file while it is open, that is a
> testament to the fact that I haven't written code for Windows for many
> years now. It is not a testament to any fundamental problems with the
> library design.

To the contrary. The library design neglects taking good care of
resources (such as closing file descriptors when they are clearly no
longer needed). C code _has_ to be careful with resources.

By the way, I am not really trying to convince you of this. That would be
the wrong direction: you have to convince _me_, the reviewer, that your
patches do the right thing, in the right way. So far, I am unconvinced.

Even worse: my debugging session two days ago convinced me that there _is_
unnecessary complexity, and unclear resource management. Based on how much
experience I have with debugging and developing in unfamiliar code bases,
this means quite a bit. I am not a junior intern who gets easily
overwhelmed by code they haven't seen before.

When I point out the unnecessary complexity of having a vtable for a mere
two "subclasses", of course, as an open source contributor you are free to
dismiss this without even so much as trying to refute it. Just like the
Git project is free to reject contributions when the reviewer comments are
not taken seriously.

> The library which you are complaining of weighs in at about 7500 lines
> of code (excluding tests), which compares pretty well to the original
> JGit code which is now ~6500 lines of code. I don't think there is
> room to simplify it further, and I say this as a person who has
> significant experience with this format.
>
> If you wish to prove me wrong, you can send me patch. Until then, I
> don't buy your arguments.

Again, it is not so much a question whether _you_ buy _my_ arguments (and
at the same time, it is somewhat shocking that you dismiss that it took me
two hours to figure out a single bug, just because the code and the data
structures are unnecessarily complex/abstract).

It is more a question whether you can convince the reviewers that your
code is correct.

In short: I am not selling anything here that you need to buy. You are
trying to sell me something, and I do not like the shape, and I like even
less how easily you seem to brush aside my explanations how this would nee=
d
to be improved to make it viable in Git's source code.

> > I know you have been putting a lot of effort into this library, so I f=
eel a
> > bit bad about saying the following: The hn/reftable patches will need
> > substantial work before we can merge it with confidence. Part of the r=
eason
> > why it is so hard to review the reftable patches is that they intentio=
nally
> > refuse to integrate well within Git's source code, such as (re-)implem=
enting
> > its own fundamental data structures, intentionally using a totally dif=
ferent
> > coding style, and it concerns me that the stated requirement for bug f=
ixes
> > is to treat Git's source code as a downstream of the actual project. I=
 am
> > not too bad a C developer and would consider myself competent in debug=
ging
> > issues, even hard ones, in Git, and yet... it was really hard to wade
> > through the layers of abstraction to figure out where the file handles
> > should be closed that were opened and prevented deleting/renaming file=
s.
> >
> > At this point, I don't feel that it makes sense to keep insisting on h=
aving
> > this in a separate library. The only other user of that library will b=
e
> > libgit2, and I really think that given libgit2's heritage, it won't be=
 a
> > problem to adapt the code after it stabilized in git.git (and since li=
bgit2
> > treats git.git as upstream for the libxdiff code, it won't be a proble=
m to
> > do the same for the reftable code, too). I believe that the best cours=
e of
> > action is to reuse the data structures libgit.a provides, and to delet=
e the
> > re-implementations in reftable/. Only then can we start working effect=
ively
> > on refactoring the code to simplify the data structures in order to cl=
arify
> > resource usage (which was the root cause for the bugs I fixed, althoug=
h I am
> > sure that there are way more lurking in there, hidden by the fact that=
 the
> > code is not covered thoroughly by our tests).
>
> I'm happy to change the library to use more common primitives that are
> shared between libgit2 and git.

I never talked about primitives that are shared between libgit2. I talked
about data structures and helpers that already exist in Git's source code.

And I said that I am fairly convinced that it won't be hard to adapt the
code to libgit2 after it enters git.git.

I am sorry if I did not make myself clear.

It is a bit unreasonable to reject a review on the basis that git.git
should accept cruft that _might_ be required to support libgit2 better. It
would be very unreasonable to accept a patch series that demands to
include code in git.git that it does not need just because a separate
project might need that code.

And if you truly care about libgit2 support, you will include the libgit2
developers in the development of the reftable support, not throw a
nominally finalized library at them that might, or might not integrate
well into libgit2.

> Could you point them out to me? Note that the basics that you are
> complaining of (put_be*, strbuf vs slice routines, etc.) constitute
> around 700 lines of code. It's not going to make an appreciable
> difference in complexity.

Was I unclear? This additional code _makes it harder to review the monster
patch_.

The complexity _will_ need to be reduced. In addition.

But that cannot be the first step: in order to integrate reasonably well
with Git's source code, it will _have_ to stop duplicating code. You
cannot possibly deny that you reimplemented your own string manipulation
library in libreftable. Such code adds to the maintenance burden, and in
this instance (and in other, similar instances) for no good reason at all
because libgit.a already has code for that.

Without integrating the code better in git.git, there is no sense to even
start reducing the complexity. Both will be necessary.

> Here is my counterpoint to your proposal:
>
> Reftable was developed outside of git-core.

That was your decision, not mine. I merely pointed out that it would have
been wiser to develop it within.

And I offered that it is undesirable to take `hn/reftable` as long as it
looks very much like it _wants_ to stay out of core Git. I mean, what's
the point of accepting code into our code base that does not really want
to live there?

> If you feel this series with its giant patch is too much to review, you
> can have a look at the incremental story of how it came to be, both in
> the history and code reviews of the JGit project, and in the commit
> history of
> https://github.com/google/reftable.

So now you want to place _even more_ of a burden on reviewers? Seriously?

> The idea to put the code into git-core, and especially your proposed
> (but unsubstantiated) plans to "simplify" its design, make me very
> worried about interoperability with the JGit reference implementation.

The JGit reference implementation is written in Java. In an
object-oriented language with its own idiosyncracies demanded by the
design of said language (the lengths to which Shawn had to go to make it
performant are recorded in the commit history).

It will be better to have a clean-room implementation in C that does not
suffer from transpiling artifacts.

About ways to simplify its design: I mentioned the layers of abstraction.
I mentioned the design of `struct packed_git`, which could (and should)
serve as an example to follow.

If those points weren't ignored, I would mention other suggestions, such
as how the code builds file contents via `slice_append_string()` only to
write them out in one go, when the contents could have been written much
more simply via `fprintf()` instead. And that is just _one_ more example
how complexity could be reduced, very, very easily. There's much more.
Would there be a point of me writing these up? So far, I don't get that
impression. All I get is "I don't buy this". That is unnecessarily
frustrating: code review is already thankless (as much as it is
necessary!) as it is.

> Could you explain to me how you would qualify a reftable-in-git
> library against the JGit implementation?

Of course: by a comprehensive set of unit/regression tests, including
pre-generated data that the implementation must read and parse correctly.

The fact that keeping the code close to its non-C origins resulted in
long-undetected segmentation faults makes me rather certain the idea of
keeping the code close to said reference implementation is overrated: it
does not build the confidence in the code that you think it does. Not
after discovering those segmentation faults, it doesn't.

At the end of the day, a comprehensive set of unit/regression tests will
be required for implementing reftable support in other projects, anyway,
in particular for projects that cannot, or do not want to, rely on your
libreftable implementation, such as isomorphic-git or Dulwich.

Ciao,
Johannes
