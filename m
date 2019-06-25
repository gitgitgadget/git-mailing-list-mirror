Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BBC41F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfFYL1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:27:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:35613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfFYL1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561462024;
        bh=X6bz5ykURWn0uYudrk2B0i8CtTc9N3vWIREFcrpL5qc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HRblKKJArbZqAHS2MMKg1YFQrp+xBZwJZHCTi2h4B1v87SP9yag7iZ6tn+uRDg9Tt
         vocZnNOELlmLAZWsjzB0gENq6KiRjzR/6dXkZ7kKDvjgXm1lCuDP1e33c9ICQaJopd
         ZzCphFy2oe8NUre6yiFMqdY54GUi3VPbIvkmqTdI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4GRv-1iWSqZ1qfD-00rpbL; Tue, 25
 Jun 2019 13:27:04 +0200
Date:   Tue, 25 Jun 2019 13:27:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index
 in json
In-Reply-To: <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251311280.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet> <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1+uG7DTBr87R16+9O4ZR6zZPhOoJ8w8WkfIO2CUql0tCp6DfRMM
 iSjngQQSckHzbsg04VUOT+agAGMip5O0paqJpRy7jiwuYPI5MJx7Qx4f6etHJPXTdFJY9LP
 1gOQoV2Xqc0TAldSxmxMBKftdW0X23gOBMD8xAqO160LgMTVFfbZu1Fy6rtNlYXZjM/B9Oy
 pY3UZJwb0NnM4ej+wqo5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:khg1s01BXPk=:vh2tKpAYPaUJRGwWy8WAXy
 gSvnlmuKEd4T5p9Cu65IR7U3H26Mru9Cyll+zr0GiqIq7WLu9a66d+8mwgvFJBDbIdbyd0Asw
 q+equuGHQk/MasDkjFsvN+PIbts8pUhIF0R2uRszgmsI01kQhDCSuVQSqhpNwtdJAe83EdbSO
 XUv1WsgAqkLFle0oFd6NCa1GeACZyLjSBr6FJYIJkcIyTHP7sIcxYyglFqp5ur+rjb5r3HGqc
 7mnoJUcqXwMzyw5oQFoDdIZW1tu1+BFFUNB5CKxbaVcrvI2dOpe7945qlimmP50vpLepbIyUr
 MQUi9aWMPAZAL/tj31nHsv/LvpB8g592vPAH2cN3UcoU5GWqRBKa/1EqKKGer+uLe8hvxcRZE
 kn9O9R4TG4bsGWUdheeyQ0mCifNEo90WYMxo8pZhG+TGq/FcL2XIrI0YPKrAMr6gQ87iXdVc1
 Eb7JfAgEbckKt3B6U7nOmdvsAwtRuRpGj/wO8RgvIV6G29m4/cMywlgw9vUtlm1we4LCvrgbT
 IFRsAAdQAekL2dRomUavYyH7eoreXk4vZLHpojWtOCi7k9LJT97LcW7Q1tw8KYbKml52RX4GB
 M8iCMO23ei1hF6QlJT5Y6qtercdfuFe/nQnRjfEXMPRIQpifWWJtGYjSpJcRogZHp6azBqn8e
 jC/4wi46iVMWxGIwbzDos/8KkImPMyF+b6FvjVuAc1okdujUE5A/SAxVr8QasbAP1wS/7RVHj
 pWuw+7rObtSlBqbkR54HXoxwidfViBxKCweGxeX5XpJaH+e4sWFbIquZBUQiHL7Q1g3fcsyvL
 XVgFziSDRiJZXXKB2vO7PAzNzpmCj3S644yU17c3YZgmwqFIrTxXtQdrHr8q2HlX3147Mqt5S
 sxbxzkI/hxtK5h2whFs2EiueZOWP6nKHzP1hltQdU5KOVvxGtA+fhI3L37HoaVe+L6JT6oPLR
 gzcPfQz1GjAnCNHNILco7QTQTXNvUi7pA16AANqgVuGLVqxU5MgtJ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 25 Jun 2019, Duy Nguyen wrote:

> On Tue, Jun 25, 2019 at 1:00 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > > - extension location is printed, in case you need to decode the
> > >   extension by yourself (previously only the size is printed)
> > > - all extensions are printed in the same order they appear in the fi=
le
> > >   (previously eoie and ieot are printed first because that's how we
> > >   parse)
> > > - resolve undo extension is reorganized a bit to be easier to read
> > > - tests added. Example json files are in t/t3011
> >
> > It might actually make sense to optionally disable showing extensions.
> >
> > You also forgot to mention that you explicitly disable handling
> > `<pathspec>`, which I find a bit odd, personally, as that would probab=
ly
> > come in real handy at times,
>
> No. I mentioned the land of high level languages before. Filtering in
> any Python, Ruby, Scheme, JavaScript, Java is a piece of cake and much
> more flexible than pathspec.

I heard that type of argument before. I was working on the initial Windows
port of Git, uh, of course I was working on a big refactoring of a big C++
application backed by a database. A colleague suggested that filtering
could be done much better in C++, on the desktop, than in SQL. And so they
changed the paradigm to "simplify" the SQL query, and instead dropped the
unwanted data after it had hit the RAM of the client machine.

Turns out it was a bad idea. A _really_ bad idea. Because it required
downloading 30MB of data for about several dozens computers in parallel,
at the start of every shift.

This change was reverted in one big hurry, and the colleague was tasked to
learn them some SQL.

Why am I telling you this story? Because you fall into the exact same trap
as my colleague.

In this instance, it may not be so much network bandwidth, but it is still
quite a suboptimal idea to render JSON for possibly tens of thousands of
files, then parse the same JSON on the receiving side, the spend even more
time to drop all but a dozen files.

And this is _even more_ relevant when you want to debug things.

In short: I am quite puzzled why this is even debated here. There is a
reason, a good reason, why `git ls-files` accepts pathspecs. I would not
want to ignore the lessons of history as willfully here.

> Even with shell scripts, jq could do a much better job than pathspec. If
> you filter by pathspec, good luck trying that on extensions.

You keep harping on extensions, but the reality of the matter is that they
are rarely interesting. I would even wager a bet that we will end up
excluding them from the JSON output by default.

Most of the times when I had to decode the index file manually in the
past, it was about the regular file entries.

There was *one* week in which I had to decode the untracked cache a bit,
to the point where I patched the test helper locally to help me with that.

If my experience in debugging these things is any indicator, extensions do
not matter even 10% of the non-extension data.

And that's not even taking into account the third-party software that
could definitely benefit from having this JSON format as query result.

In my work as Git for Windows maintainer, I do hear about the needs of
third-party software developers quite a bit, so I would claim that I know
a bit about what they need, why the NUL-terminated format is not a good
match, and how much a JSON-based API would help.

So while that is not your pet, it will be the most useful part of the
outcome of your work.

> It's the same reason why I will not provide a flexible way to disable
> extensions. I'm not starting a JSON API for Git. I provide an index
> file in JSON format. You do what you want with it. You have a format
> easy enough to import to native data structures of your favorite
> language.

I understand that you don't care.

Your patch series is just too good a start on something truly useful to
pass up on the opportunity.

> > especially when we offer this as a better way for 3rd-party
> > applications to interact with Git (which I think will be the use case
> > for this feature that will be _far_ more common than using it for
> > debugging).
>
> We may have conflicting goals. For me, first priority is the debug
> tool for Git developers. 3rd-party support is a stretch. I could move
> all this back to test-tool, then you can provide a 3rd-party API if
> you want. Or I'll withdraw this series and go back to my original
> plan.

You don't need JSON if you want to debug things. That would be a lot of
love lost, if debugging was your goal.

I guess I'll wait until your patch series hits `next`, and then try to
find some time to work on that feature.

Ciao,
Johannes
