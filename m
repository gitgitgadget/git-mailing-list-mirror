Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962081F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfFMQef (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:34:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:56215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbfFMHvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560412264;
        bh=a90kFcDFfY6/4BtryBM1RjKHQcw7F4EnY8zls9oBSPI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R176FDS1hbLHIJoILQ+FowFqhHhBrc3/583h8MNLM6vD2hF7E2BBg86n5F15CkMIy
         9WCHS1nPtCQf2JS8mBzWxgZYTXOTZSiHdtVfaxXipifYCIkiVSdi4rxTJ8GUnATztn
         IqWT+33x7ppHoAnrOkjpbMNTd/YQys0R+CJqExDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gcI-1iV67q1pvy-00uuWp; Thu, 13
 Jun 2019 09:51:04 +0200
Date:   Thu, 13 Jun 2019 09:51:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Smith <paul@mad-scientist.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing git size by building libgit.so
In-Reply-To: <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
Message-ID: <nycvar.QRO.7.76.6.1906130914250.42@tvgsbejvaqbjf.bet>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>         <20190611234815.GB8616@genre.crustytoothpaste.net> <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rtoHixtVu/n7o5ufMbai6MUsm6FciRjE4JTWwJO0aVCHYFPsrI8
 HN7M8mkDC0tA/7bOGuluOqqSKaQ87jBloxAOiRk0pWkYB2rWHRXRLNysW6zLHGpJNxTvdmz
 ZLE4Z0MtyQJNsxrlCx+KBBDi0Cq48RXy11Qgyqh0Vjzrf2kOMwL9xd4IgtjcLtuQX9P5Ks1
 TgHcVDkYfto/M+fxPLZfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dWL8UOxpHYY=:aREWGA0TKk/Ut9t7xLclyM
 ISv4u0JQyxwKigSq0z2dOz/t0yQPS2ucMT+tQTfq2Q9FNf5nZnsRUZKPA+qMxDqoOc0ncOZ4x
 AA7qyhRuIUDUXtQsZcrtQtq0Ow1wJe3Qq9ibmkouQqXU2GUoeNnZPr1BJR/HljjKT9bBqrqIX
 Q5db0SUUuWYYtP6BywL6UqQ5HIrC1AyPa7y5JWnabNJhscStY7r+dN0c+vMZYqrWZm/RMVlVR
 Y5fR615gQQXKphEE8VCWGOF9qBHrLrJIHIBPiL5OuQ4xjGxIKswNzcEqQtsPiiNgFVZQfuOK2
 aqZZNvEO1FC/k3Lgh2hFHxHJ0l5V0qeNawyJe8EhHdmQbnxvxUEA/nqcfGRubpb23VwIIvBX4
 2SSsaUWvYzuHGcBp0xBi7sw3vn37GxgcpRBIotere+qBMUYdT3HdsoBw3B9YV+I7QfejHF2yJ
 FX9ufzLjggaByukRs+QdhzxAy5VD54bNaD8lvUeHk10BO5dMGq0lZbzoefSbUgMsu7ZxwxTE9
 TISlTn/7/kLZTyF1MR0w0kuDdIvIs/6SA4Nrl8RSPkh8pFP8og7duAmh36Mr2uG7kwbUJwVCv
 hbF18wK1RMMztWuzC1sHB4OVYCZw/juZBWHGPKlXrujyUZ9kpy21HPoXbAbMOdJelyDIW0F5l
 03+37Hh5DQJLErRfWDo/2i/MWRoIdDu7jJvikvR+GgqvzxjkGqXveNZ6xdk4tO8qWast+27Nh
 Hc0DIZY6c9JnWp/GbruSZYZFgStihrjTJRYhXE843SvkJx9wyCC6NHqgwtmHw9hAccrhsVwBI
 OjCKafsdMjBRHcjX9xzNcIY1edkdX21VnWXzvsYGcfiPSK27fqhySQcucn/JiCdkxnRWJzMtg
 ksjQdYdtZz1JeqKkuqHQuCgoCOUPfwYZ7YD6uQTqsWoZv7suZlHuHSBJFYJ4vOOYuJ2d8kQKw
 1L0+UN0mbFb4C2MZc87/0GbcXdhZKQlz1wUERy7quXI6q3PsozsCf8cAyQVWJ9KWHQWukIIPp
 fnv0/XAWJgTk1GQwO3oGen4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 12 Jun 2019, Paul Smith wrote:

> On Tue, 2019-06-11 at 23:48 +0000, brian m. carlson wrote:
> > Also, some people install Git into their home directories, and a
> > shared library means that they'll have to use LD_LIBRARY_PATH (or
> > equivalent) to run Git.
>
> I don't have strong feeling about .so's although obviously less disk
> space used is always a good thing, everything else being equal.
>
> However, the above concern isn't actually an issue.  You can install
> the .so in a known location relative to the binaries, then link the
> binaries with an RPATH setting using $ORIGIN (or the equivalent on
> MacOS which does exist but I forget the name).

Hassles aside, you mentioned Linux and macOS. What about literally *all*
the other platforms we support? Like AIX, NonStop, HP/UX, etc?

Sure, you can hunt down all of them, and maybe even come up with a
workaround for platforms that do not have a $ORIGIN equivalent. You can
pile workaround on workaround all you want.

In the end, it seems to be a clear indicator that this is a complicator's
glove, and the only reasonably simple way forward would be to either leave
things as-are, or have an *opt-in* to build a shared libgit.

But.

And this is a really big but.

While you can try to document _all you want_ how libgit.so is not supposed
to be used as a library, how its API is not an API or at least not a
stable one, if you have _some_ experience with software development you
will know that it won't matter one bit. It _will_ be used, people _will_
complain, and it will turn out to simply not have been a good idea in the
first place.

> On Windows, DLLs are installed in the same directory as the binary,
> typically.
>
> Allowing relocatable binaries with .so dependencies without requiring
> LD_LIBRARY_PATH settings is a solved problem, to the best of my
> understanding.

You're probably right, as long as you restrict your view to mainstream
Operating Systems.

To put things into perspective, you might be interested in reading up on
https://github.com/git/git/commit/0f50c8e32c87 (Makefile: remove the
NO_R_TO_GCC_LINKER flag, 2019-05-17) and related commit history.

Sure, you could still argue that it is a "solved" problem. Where "solved"
is a different term than "desirable".

> One thing to think about is that runtime loading a .so can take some
> time if it has lots of public symbols.  If someone really wanted to do
> this, the ideal thing would be to make all symbols hidden except those
> needed by the binary front-ends and have those be very small shells
> that just had a very limited number of entry points into the .so.

That would fall squarely into the "pile on workaround on workaround"
category I mentioned above.

> Maybe for git this doesn't matter but for some projects I've worked on
> the time to dlopen() a library was a blocking issue that the above
> procedure solved nicely.

Sure, sometimes you cannot control whether it is an ill-designed `.so` you
need to consume.

As far as Git is concerned, this is not the case. At least when you look
at libgit.

When you look at libcurl, it is a different matter. But then, we do not
need to play RPATH games there: we expect it to be in the system's
preferred location.

BTW Duy hinted at problems with libcurl that made us split apart
`git-remote-https` from the main `git` executable. The full story is here:

1. The Linus complained about some "crazy" shared library loading behavior
   five months before Christmas 2009:

   https://public-inbox.org/git/alpine.LFD.2.01.0907241349390.3960@localho=
st.localdomain/

2. Daniel Barkalow was working on some "foreign VCS" support and thought
   that HTTPS/HTTP support could be handled via the same route, to avoid
   having to load libcurl for every Git operation no matter what:

   https://public-inbox.org/git/alpine.LNX.2.00.0907242242310.2147@iabervo=
n.org/

3. Daniel then sent a patch series about two weeks later:

   https://public-inbox.org/git/alpine.LNX.2.00.0908050052390.2147@iabervo=
n.org/

4. Those patches were accepted via cd03eebbfdae (Merge branch
   'db/vcs-helper', 2009-09-13)

So yes, I think that a patch or patch series to turn libgit.a into
libgit.so would need to be crafted *very* carefully, and _in the least_
offer a sound performance analysis in the commit messages.

It would obviously need to be proven beyond doubt that the startup time
does not deteriorate noticeably, otherwise the patch (series) would likely
be rejected.

Ciao,
Johannes
