Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E29C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 11:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348800AbiHSLXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348802AbiHSLXX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 07:23:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306895FAB
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660908171;
        bh=q7F5REJcbN18pEzFR5lynph6Krr3B9+I31M68w0jQCE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=APw0sJF4xyPVl9cPIEoppDWfqCMhjVBaQo0M7yZCOYRJaNrL3gJzdHfHg90E4B2g0
         YyInud+LIjnAQ5FlizsfXigQgydvtLNE7q3qecbLoAqccFaOK/RTG2MN6d2eCQil0o
         Z8uLv0mOJ5eCesfqGsVgLmCIrzW5zPlVEsz9It+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1nQIKM1ynN-00yyov; Fri, 19
 Aug 2022 13:22:51 +0200
Date:   Fri, 19 Aug 2022 13:22:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: Coverity, was Re: What's cooking in git.git (Oct 2021, #02; Wed,
 6)
In-Reply-To: <Yvw87DJOOu+/jG6o@coredump.intra.peff.net>
Message-ID: <3896n74p-0r16-866o-r668-70q6pos078n9@tzk.qr>
References: <xmqqfstdr8b5.fsf@gitster.g> <YV5aaD418SyZqS/1@coredump.intra.peff.net> <YV5dmkkuCqAY2qqG@coredump.intra.peff.net> <YV5yi+AejPGO9qOi@nand.local> <YV/BMkZrj4xQyvUL@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
 <YWC49+xCh+zum8Ms@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet> <YXBALFsf305U8mJs@coredump.intra.peff.net> <2n33pn8n-7529-443q-rq7n-q12nrqrn8p27@tzk.qr> <Yvw87DJOOu+/jG6o@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1990683218-1660908180=:241"
X-Provags-ID: V03:K1:muJ5wYQ5flECwUVJkvj+rE/vMBFrJaPwlo0i15dsSrWunJOr8vM
 x62snbtdmVuKeEt2QKkWkq0VL/uJ4DYBqJCdAHo/1htRaI5rpvynGkPtNBO3lJl/WGtn2Os
 4x4dz+JO6PFMDwzB3iW9VXh+fCp6RMfJQjH0eEH40rrRXVGhT+Y/SA5qek5Stslh9Zsf7QT
 V+Sk4YrueHMEcs3yA0O4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QDXczAoErdg=:8sX1H6q8u5fCIai0Q3ayfu
 ICSWYXCA1iyxUKU7S5+/T4YxWJbLGuNDefzOuSfAS7qBbbR/+KAIe0yQiA7Lqf8QSQkgCCYrP
 eNc5jas07bRjSZv8slOnq5weYnVp1mU2lEU4TMOnrd+hn/cdqEsT/qdu7yKwekhyHZK6bmymc
 kpo5EtjL66q70AL0ahvgD2DveFJ4Tp0wB2H/8mfw4dBQbJG8kE8JLtdyfH8k3qxC6+SXN/ilB
 m2sxgNDAHTh51wB5ik6KERDLkAEApRSvXWGIovbcdDb0CbNz1E63ABSg2kNXZxoBB5u584BKP
 5FdG3gkf1vGHWWrXyYCWZJ/GMSsaNoxH4mBqw00+12NnB4BWRHhP0A/1D5T6FZu0wZ++MvXIe
 lRAr+WEEULb30PbHZuGq/8ftfS+LZ8lHA6ku5F4sufChtOG7IPpGZ8srpmBFbLTTRVKUAVrwD
 VH208S5rJod+iBQ4TWVi5hfm5j4jCJRt1VuQ4ab1vgxNhM+ptDzdwVLYAuOjZ+AGYoG5ldKIX
 jf9kbiRDpY1U1yunbXDVIN6jA8xMS2ZJwVA7gvtmnfdwm2/8KI7Piaj4gi9HttfoZnWmhNtBA
 dLHEToJqnp+dUK1CvWmtSxiYnwS3G0X67sgroWWKQr+2rraOau+YfizXG2oD/rxJyG9vuJKY6
 2gujbb0nnXYf7miaTlMy2t1pFNjW3Xjm9AYOy7Yt1Vr52cBSCJwKiR57ks4neegmahhLt8Cma
 C+ew4ePWjLkC/1FDYBfXhoZwceaA05yztbHmuU+4vVxNlzpFDtko3QtAgjBbjxiOlhKovWVRy
 lF/xqxHFJAE/MNxQumVo6wsdoNRNUgdddrvlBjV4JwZB2jUJcU0nWjsKE+4klTVjir/2EtKcG
 3Uf568LlK+DZ/cpIojxo5sSqsqfUD+ox3U9N5gm2Yxlv1/dUPalVm63XDIDhWzdz2maiWWpK+
 /dQl8IcEdMDvRMeuNEuYQZnLWqtAx742++/H3I0gZS7DPoyA3u4rtKn/QqQxn/9lKs1THKmku
 I+asJUoIFubQR5NWYiCpGUP/OFSBx539WXnY4HSs0Xfc+xZ1S0IX9UR2snyGNTe8gN9TL6JwE
 +W9Ugo9UwPzAKbdpomjljCSoz1Wa+PFxCFlpgKezbWTuByrM+idjxyN5Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1990683218-1660908180=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Tue, 16 Aug 2022, Jeff King wrote:

> On Tue, Aug 16, 2022 at 11:05:48AM +0200, Johannes Schindelin wrote:
>
> > > It sounds like Taylor is volunteering to set up the Coverity side fo=
r
> > > git.git, and I can help him with getting those COVERITY_* variables =
into
> > > the GitHub environment.
> >
> > Given the challenges with Coverity (false positives, lack of support o=
n
> > Synopsys' side, severely limited access to the reports), and given the
> > renewed efforts by OSTIF that focus not on Coverity but on CodeQL, I a=
m
> > in favor of abandoning the idea to integrate Coverity in our GitHub
> > workflow.
> >
> > Regarding CodeQL, I am still uncertain what level of integration we wi=
ll
> > end up with, and the contacts I am working with are currently all on
> > vacation, but I am confident that we will have an easier time going
> > forward with static analysis using CodeQL instead of Coverity.
>
> OK. I haven't been that impressed with CodeQL for C so far, but it may
> be getting better.

If your lack of being impressed stems from CodeQL's default suite catching
very, very few issues, I agree with you.

The reason why I am more hopeful about CodeQL than about Coverity is that
I now have a contact to work with (although they are currently on
vacation, so I get to work on other things for now, including `merge-ort`
and trying to integrate `mimalloc` in Git for Windows). And that is one
more contact who is willing to work with me than I ever had on the
Coverity side of things.

And apparently CodeQL's default settings optimize for reducing false
positives in an attempt to avoid scaring potential users away.

But I have credible assurances that CodeQL has many more checks in store
that simply need to be enabled in order to catch way more issues, at the
expense of risking more false positives.

> I certainly would be happier with a system that made it easier to
> display and share reports.
>
> Coverity does have a lot of false positives, but I've at least been able
> to pick useful fixes out of them (especially because it is good about
> saying "here are 5 new things to look at"). I've been continuing to
> build my private branch with it, so we'll see if it turns up anything
> useful. I do agree that inflicting it on ordinary users may be
> counter-productive (I often have to stare really hard to understand why
> its false positives are false, and that is not something I would wish
> on, say, a GGG user).

Don't get me wrong, I do not plan on dropping the Coverity builds of the
Git for Windows project's `main` branch at
https://dev.azure.com/git-for-windows/git/_build?definitionId=3D35.

As you probably recall, I specifically looked through the Coverity report
in advance of v2.37.0 and tried to address some of the issues in
https://lore.kernel.org/git/pull.1264.git.1655336146.gitgitgadget@gmail.co=
m/,
with mixed results (mainly because of some time constraints on my side,
combined with your willingness to help fix some issues with my patches, as
well as Ren=C3=A9's, Taylor's and Junio's excellent assistance).

However, the sheer amount of false positives, with intentional issues
being a close second (in test helpers, we are not all that strict about
releasing memory, for example), makes it a tough sell to ask more than
just a few very dedicated contributors to have a look at the reports.

With CodeQL, I am optimistic that we can get it to a point where the
burden can be carried by a larger group of people, with the help of
enthusiastic CodeQL experts, which also means that the reports have a
bigger chance at making Git safer.

Ciao,
Dscho

--8323328-1990683218-1660908180=:241--
