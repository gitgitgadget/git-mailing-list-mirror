Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81398C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527A320857
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QZUR2ZQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgEAWIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:08:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:35077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgEAWIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588370922;
        bh=agevN/6jYvJo/l/B4nMAmQZ8WaPtEmoUIPqITmBMSPE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QZUR2ZQuK/sTIzPlG0NBJm08DtvZu7abNIW1QtrFmc5g2I5YKLnrRDkzBtoCnkb3X
         0frWE1NZ1IIharn9M2CUEny/bQlqeIkQSaw2qwuA2TR8ZAFVIf9xwr8iWrI+pz4PaL
         oPpHH7lZ9TvZIB/jU7LO9pj4ILdVwyB+Hbt8q0QQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.255]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MbzyJ-1isoqL0BMF-00dZoK; Sat, 02 May 2020 00:08:42 +0200
Date:   Sat, 2 May 2020 00:08:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (April 30, 2020)
In-Reply-To: <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005012316350.18039@tvgsbejvaqbjf.bet>
References: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com> <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XQlXLfOZiXTnn4uQastp+6R+xUywrltYfNWOlPFcJDnoDOsXnTF
 7br1ghOfufVnSR3XV6xNO9Vbq/83fsYW6c8N5IRAJDNQLBoVvjiJJsP3sRgUEo6hEacWRyu
 +/M2PmHAtqIItshQ+9+gNcFy52Ta813Cv9Qt2LpGJSC4pbRLYYpWStjt7/sjIjpdP7C2m9f
 Ai0aHAVDf/eB5cP0G76Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xnZ+QJx6Zk8=:0IlbvNaUZQRwkj/FOKGChs
 4xt+45w7SbS7JFc6dJNh7z/+XLvHg10+q8Q6EsBLfdML3rmNFOs27ZsAT0MorE9PH9s23d8Iu
 UV5ZIAFDBPpuY1iGS07er9x/eSgxq4UglbHDgCA4Rd7NgiHILFkiB8SGGkIj0gI/6ybC4QeSM
 jkPsAyyCxk+FRLZTJvx2zHRRC8hHOVRWOQefXVmLt+0jNuuXxd0Ta1zM2rK0BdTZ/B5QuaU4E
 XJaEDTQGRGOrqtnuQEfOBIrRWWrVNgEq8wexjbxXsy1GB+kfYYO6Pc1RHWZntEX6TwwmVYYYv
 X6+Lyk1KCYX+vBqK3x5MIZ/o+jQZ3fCvzLoZmHXkC7zIwLPtCUSPcbmOPTEFz67L8tz+ezYWl
 Bwy+hZK27rI3xJ/iXVn+0kVMKFk+9ZPUzryJyOWKZg4uB/zgNklxKcJW+CYRWuV38ZPN0vxJJ
 vPOeKb6YwgoPKHcnDNclPhrpGvn9L6Tl1lOGnoBV82HI9X72K2GODAFKvu09FaosmFSw5qYk7
 qaBpgy4PfIA9DI9jRZjvqxIscJb3VaiznQE3EF8nuJ62qKeLo7WtRAFLnPWCHvXrpxyN39AuN
 BHBtQ3/a6CzncEbR+DjJWK/6utjL+yGH+HxS7ArqLNtrP2aNrmy/olZFRVE5jUlYljeyST+8C
 955YKyGtRM7m9jaBGqfCfqshVVlni0E6XkCCM3RF0Ib0Ku0jiRC5JW8V68HaLoHqPG2VQNbM4
 /zANcBCQfJt0d27uBP5CuRTs+XUktvIE5WfdrqXKijzjhFgS+/xGApifq5YGn20cF3tBJvh/N
 ZNB063dWmm1MpIKN/AeXxO+Q3dWZZWe/TK3QObkLioOGufCXQOYM/M76EimOiD9/MTtoF5t8S
 txvRz0Ku6UviJK8OEKwO05YblYDmp5Tj6AOHpgKCsz9H9AwstsxP39VFuHgdovuDYOkTs0v7D
 L4dISakxT1S8ATIKPXcrv0UoNtz/x0X0kruaFzoyYVxhFVfUdRyX9WAzCjwEyk6mUdYsbaW16
 maOaflHLkoySF9Y9iurRlSRvN0fbUDKDm+eJMSlcZHAGUNDezb05s3DIPfBQEgFiSbyihOUyk
 RNgc32enpIXbSHovdqyQNwKZk2TTzRGWmz9cuIuhtBOk4yaZkEIVqpXLM5ie1405PqDT1hC+z
 Gn2dvJoHTuUV8wn5DDiVZ6Yhlx79GoxzftmtuQXKF9IMZ6Gs0B5fLr1fMvermHH2ShdNPowoA
 wpr3qg0oWTBszyLiP
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Thu, 30 Apr 2020, Han-Wen Nienhuys wrote:

> On Thu, Apr 30, 2020 at 1:22 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > Hello,
> >
> > Here is today's test coverage report.
> >
> > It appears that _all_ of the reftable code shows up in this report as
> > untested. Perhaps that is the state of the world right now, or perhaps
> > I need to initialize a GIT_TEST_ environment variable to ensure it run=
s?
>
> > In either way, do we have any test coverage of that massive contributi=
on?
> > Please take a look at the online report [1] for that part of the repor=
t,
> > as I snipped it out of this email.
>
> (again in plain text)
>
> The reftable code is currently exercised in a small way by
> t0031-reftable.sh

Very small, and yet even the simple change I made had uncovered
a segmentation fault that the unit tests you refer to below had not.

Which makes me think even more than I already thought that it would have
made a lot more sense to develop the reftable library inside of git.git
instead of completely separate from it.

That would also have staved off the many, many style issues that make this
thing hard to review, not to mention the sheer size that threatens to dull
any mind pouring over the diff.

It is probably not a secret by now that these issues keep me from
reviewing the code.

I mean, I want the reftables feature to finally address the problem on
Windows where branch names are sometimes treated as case sensitive, but
then all of a sudden they are not (because of the file system backend). So
there is motivation on my side to help the patches along. Yet, the way the
patches are presented does not invite me to do so.

In a private conversation I had recently, the situation was likened to
having a neat home that you really like and take care of because you,
well, care, and therefore you ask guests to take off their shoes, but one
of the guests just ignores the local customs and walks in with their muddy
shoes, right over your white carpet.

It is a bit of a crass picture that was painted there because the
situation is not _all_ that bad. Yet... it _is_ very unenticing to have
the coding style stepped all over, as well as the convention to "tell a
story with your patches and commit messages" not exactly followed even to
the letter "d" (let alone "t").

I understand that it seemed easier to first implement a library in a
familiar language (Go) and then "port" it (where the "port" part shows by
using constructs that are uncommon in C).

However, when I think about the potential users, there really are only
two: Git and libgit2. And since libgit2 is relatively similar in origin to
Git, I don't think it was the best idea to start with an abstraction layer
over data types. It would have been a lot easier to build the code in
git.git first, test the heck out of it, and then abstract it _just_ enough
to let libgit2 essentially use a copy (just like it does with the libxdiff
code).

Speaking of testing: there is no doubt in my mind that _iff_ these patches
make it into git.git, then the vast majority of bug fixes will flow _from_
git.git. And if that is indeed the case, it makes it very, very awkward to
ask every contributor to go to _another_ project to get those fixes in
there first, and only then have them trickle back to the actual user.

In light of this, I wonder whether there is anything you could do to
change the way you develop this patch series that would make it more in
line with the code contributions the Git project enjoys? Or at least to
tell a much more elegant story arc in the patch series and abide by the
coding conventions?

I could imagine that just throwing away all that data type abstraction and
reusing what is in git.git, including all the helper functions, would go a
long way of not only simplifying the structure of the patch series to
allow for a meaningful review (in the current form, I don't think that
_any_ human could possibly verify the correctness, as the complexity and
the size is just too daunting and too overwhelming), but it would also
avoid implementing redundant functionality, which would not only reduce
the size, but would also let us rely on tried-and-tested implementation in
git.git.

Just to name an example, pretty much the entire `basics.c` could go away.

To give you a concrete data point for tried-and-tested function: the
`string_list_split()` function has a short and sweet implementation that
has not had to be fixed in more than seven years. That is quite a track
record. Using this function instead of `parse_names()` would give us the
instant benefit of relying on something we do _not_ have to review for
correctness. And there is the distinct possibility that using a
`string_list` with an explicit length (instead of throwing it away in
`parse_names()` and then painstakingly re-calculating it in
`names_length()`) might actually improve performance, too.

I firmly believe that this patch series, in particular the huge patch, can
be transformed into something that looks a lot more like git.git code, is
a lot smaller, and is a _lot_ easier to review. Without the confidence
such a reviewable shape provides, I would actually not trust it enough to
put it into the hands of end-users.

> The upstream library has unittests, see
> https://cs.bazel.build/search?q=3Dr%3Areftable+f%3A_test.c&num=3D0, but =
I
> believe Git doesn't do unittests?

That is a misconception.

We usually implement some test helper in `t/helper/` (or a new subcommand
in one test helper) and run that as part of the test suite.

And to repeat my point above: I don't think that I would have found a
segfault _immediately_ after modifying t0031 in a rather trivial way if
this library was developed _inside_ git.git rather than outside of it,
with an incremental story accompanied by unit tests.

At the end of the day, it matters more that the reftable works in Git than
it matters that it passes the unit tests when compiled somewhere else.

> I'll try to generate a coverage report for them.
>
> You can set GIT_TEST_REFTABLE to see coverage for reftable, but I'm
> not sure how useful it is given that ~15% of the tests fail.

15%? That's a lot... I hope that that's mostly test cases that incorrectly
assume that they can access refs directly on disk, in loose format.

Ciao,
Dscho
