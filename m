Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D121F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeC3Sx7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:53:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:45013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeC3Sx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:53:58 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbfnB-1fIp5R25gL-00J0Jm; Fri, 30
 Mar 2018 20:53:44 +0200
Date:   Fri, 30 Mar 2018 20:53:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
In-Reply-To: <CACsJy8DPof1jFe_cOS5+5dRHehU+_Y9y86P+5f3s_C0u85BXBw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803302046550.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <CACsJy8DPof1jFe_cOS5+5dRHehU+_Y9y86P+5f3s_C0u85BXBw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RctULOtgoZ8cZRiNr2gspRmqrnYaJvlkOFIdYoRhYW3D1LGtKqU
 1cc+fHTwUJ96Md1YhgCTSd5mU/aF9HxSmq0ollh4DjhCnolcuLJBtYPEl6u8tPRXAo0+78b
 J9UbRmKRNt8DCaf3XHL4fJKBLobCj6g+Had0MFHymxOUgo0DXHDo7TO2F2keQBaY6iL3CZd
 lQtkeZZ91ZU+2ImyGZJPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oS1/tzM8VUs=:PVFbi+oj0//8VnVt5EnaE+
 1JNY1YhqZaTatLE1sQ31DIuaoEL2luKYKPv8HCAfzQOQFaQs5aT+DcePj5W0++tCRLMnnXT7u
 rNhJbMczq91KfdfEu4RyLYCyXKOld5Ihkg437C4CJsBYDEEOJhat8H/0FWytIKNQYvM1oMNv3
 9mZgvPCheMFRv0uQtFw7EjieSqt/4olkEUQ+02+7YdrXegBILk8cYIVmjrcCc9mlLTiYLBkJb
 2llpkzXHm7FvaRjmEUNE+goqMQ9t2yX++dhegnYYTrrtdVL6b7/YbgoQN5gfJEFtSHj2PxMMa
 KkzdcRuY27OKR3SDHYqDF3EjyCLbc+uM+n4HTHPFzD815J6TuziyLGg9jPZpDwNLLjVZOi9EE
 1380wsWypRwRwIdeMt2W3ZPN8/0PKWVDJYFoweGzMO3f0n1p6R4mi+iGvbmOQPMjqcoBsrN23
 nzmiO+3VB31xHRLyvVZu/DXg3vfIyWY7Y4yyFpFxoxpadjOYZPQAXGTbGUiUu6w1HqGT0AwF0
 iJBLvvPDdb5Pu0mYAORZgb3SFocyNmLWedSLJa2OoBkQQS6JurxbjB47MffqfQwUJSJB3s1ka
 uwRsbQVogaF7sekdpBi79VJJgBBSUXrJidKYRxxZMEXq/VZmWostr/Dow79uyuIn/blbB9Qt8
 G8AXNjbkIIsMJLueUEfhod61EtRhD4pIpP4mVnEtcCK4x/kwKou8uHpvOeVbLBtUAI6k91QHp
 0MbJYW36wvOzoeSSVnWtRDHFvMKhsNxpUlGexvc0ckMyMseYS54ZxqriRh78qYhpLB868WqdC
 LFcSFANzgBlj55INPzfcEfEAeKmTWu2HbAevk6oEuSdPVSijQG0dHOW7fmmKYg48jR3oZaJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 30 Mar 2018, Duy Nguyen wrote:

> On Fri, Mar 30, 2018 at 2:32 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 29 Mar 2018, Jeff King wrote:
> >
> >> On Thu, Mar 29, 2018 at 11:15:33AM -0700, Stefan Beller wrote:
> >>
> >> > > When calling `git config --unset abc.a` on this file, it leaves this
> >> > > (invalid) config behind:
> >> > >
> >> > >         [
> >> > >         [xyz]
> >> > >                 key = value
> >> > >
> >> > > The reason is that we try to search for the beginning of the line (or
> >> > > for the end of the preceding section header on the same line) that
> >> > > defines abc.a, but as an optimization, we subtract 2 from the offset
> >> > > pointing just after the definition before we call
> >> > > find_beginning_of_line(). That function, however, *also* performs that
> >> > > optimization and promptly fails to find the section header correctly.
> >> >
> >> > This commit message would be more convincing if we had it in test form.
> >>
> >> I agree a test might be nice. But I don't find the commit message
> >> unconvincing at all. It explains pretty clearly why the bug occurs, and
> >> you can verify it by looking at find_beginning_of_line.
> >>
> >> >     [abc]a
> >> >
> >> > is not written by Git, but would be written from an outside tool or person
> >> > and we barely cope with it?
> >>
> >> Yes, I don't think git would ever write onto the same line. But clearly
> >> we should handle anything that's syntactically valid.
> >
> > I was tempted to add the test case, because it is easy to test it.
> >
> > But I then decided *not* to add it. Why? Testing is a balance between "can
> > do" and "need to do".
> >
> > Can you imagine that I did *not* run the entire test suite before
> > submitting this patch series, because it takes an incredible *90 minutes*
> > to run *on a fast Windows machine*?
> 
> What's wrong with firing up a new worktree, run the test suite there
> and go back to do something else so you won't waste time just waiting
> for test results and submit? Sure there is a mental overhead for
> switching tasks, but at 90 minutes, I think it's worth doing.

Of course it is worth doing. That's why I often test the end result on
Windows (waiting those 90 minutes, but I do not fire up a new worktree, I
use my cloud privilege and let Azure/Visual Studio Team Services do the
work for me, without slowing down my laptop).

What I would love to do, however, would be to test all intermediate
patches, too, as that often shows a problem with my frequent reorderings
via interactive rebases. And 90 minutes times 9 is... 13 hours and 30
minutes. That's a really long time.

I think the best course of action would be to incrementally do away with
the shell scripted test framework, in the way you outlined earlier this
year. This would *also* buy us a wealth of other benefits, such as better
control over the parallelization, resource usage, etc.

It would also finally make it easier to introduce something like "smart
testing" where code coverage could be computed (this works only for C
code, of course, not for the many scripted parts of core Git), and a diff
could be inspected to discover which tests *really* need to be run,
skipping the tests that would only touch unchanged code.

Ciao,
Dscho
