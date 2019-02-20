Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC401F453
	for <e@80x24.org>; Wed, 20 Feb 2019 21:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfBTVKX (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 16:10:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:35165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTVKX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 16:10:23 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y47-1hAwic2zzb-00v7Bx; Wed, 20
 Feb 2019 22:10:17 +0100
Date:   Wed, 20 Feb 2019 22:10:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
In-Reply-To: <xmqqmumrvzwk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902202205470.41@tvgsbejvaqbjf.bet>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com> <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com> <20190208113059.GV10587@szeder.dev> <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev> <20190212231837.GI6085@hank.intra.tgummerer.com> <20190219002336.GN1622@szeder.dev> <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190219235913.GM6085@hank.intra.tgummerer.com>
 <xmqqmumrvzwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7nJpQj5jLLHkYXWbV49fpaFuapFcMWJkGU5OGn72V3upl/tGcdj
 00OVnq87155oXEFykhCtg3xL+yYWJWOdHrqYw82LDrnJ7/NeX/C1eUlz7jow6KGF9XVheVD
 g3DuWRjF89Q5UhZwx35ImPRZzwhXpYUaxRa0Xpmf5HWyABxOdj1v8HdnsEuMgRqCNjq93rG
 rCRlx32exz9a0SAZdTRMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJhdZ/SbIXY=:gWrSz6pKpd3VaEI40m/HsC
 TcLFHWA1lb7tYcWBdbhDHAWzbrE68ezCzocx88wTf17pnywZNukP2Z0vRo4g62UmBzYs5IxE5
 JsQ1LXgCUx1mO9xGSEW6Qa6d5IEQUgLzPCRMDslmO1Lm8yn9x4ZvOa6C57TP7QQjX7j0dOxOm
 D5lD5SIqwfQ2VIn6uyMQMtN9cfHkPBYmPolr9oA/0oZ2qZWX2/PljpK1swpvqAJehyabdbNZG
 laeRu8UQHLc+56ObRl8/vxV1189pMb3at8JrSyZ0jxduVXOMST9LueYM9qyJxOngINLfVtc0L
 7yAdle/zH/EPsDQIlFz0ybEPkLjkRD2bPTtroZvUoF+GkR1kwiMpP5gyjeGXGuWczTk4DDZ9F
 AfBSN9A5161+1JfAoNtyx7+Xf+A+n/7+1TnVmw7Yr4GHameVxzzlpF3wCA+MItNR8sQFisvNt
 60ljkHLVpO1fRDe8t/tuTRAqV+bMR3/UqOgxrem9fIGpicjKIYA9kXrdJYSroJeETs9YD/yIj
 uq/NUkETrmdXbUHodWdV/JiZ1sDYLxNBPrtc/XqsFUCXf1KPTFkuV6ToU5nh6q2Qpi2clNE7j
 iF+PF+3gDhl262xGU1TFozkOdPPmnd5AUIJbmHrRRws1CUuTqAbQIyev+8ArBOHc26GUX5VlB
 4c+GvgudktWc66T+Mnwta9j9Sdn+PhiXMZnJhSUaG8UrM0ZQtqhJJmoTsesey7lIK1HRdB36/
 OF6M4hv/62DS3WP8V3SaQloKzyOLWTBtyMsM3igzwoJX1oDmbxZPw8tYUziPuV3rhS7JIsCUt
 7oMMdNLJDjoCm4WbQPIcawnNDrhn8JVQKTDJUs4+5s/9kXPm5gbv0mQATEG81pctODtCRry0N
 v8Be5yfxIBLOu2xvjnYpsFy/VGaAU24UfVoUoZ/cCapgmJThlGMaCLNpt/bjxsrrGvxBWzouv
 4IUmnDFhMAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 19 Feb 2019, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> Now, I seriously believe that we missed the best time to move
> >> ps/stash-in-c into `next` for cooking. The best time would have been just
> >> ...
> >> Anyway, that's my plan for now.
> >
> > I must say I am not very happy about this plan.  The series has been
> > marked as "Will merge to 'next'" in previous iterations, but then we
> > found some issues that prevented that.  However I thought we were fine
> > fixing those on top at this point, rather than starting with a new
> > iteration again.
> 
> First before going into anything else, let me thank, and let me
> invite readers of this thread to join me thanking, Paul (Sebi) for
> sticking with this topic for this long.  It is above and beyond what
> GSoC calls for.

Indeed. He put in quite a few dozen hours of work *after* GSoC.

> Having said that.
> 
> I too was somehow led to believe that the topic was in a good enough
> shape, with some room for clean-up by reordering the patches to make
> them into a more logical progression and squashing an existing and
> recently figured out "oops, that was wrong" fixes into the patches
> where the breakages originate.
> 
> And that was where the "Will merge to" originally came from.  Thanks
> to tools like range-diff, a topic that goes through such reordering
> and squashing of patches should not have to "waste" a lot of review
> cycles out of those who have seen the previous round.
> 
> It however is a totally different matter if the topic was so
> unsalvageable that it needs a total rewrite---that would need
> another round of careful review, of course, and it would be
> irresponsive to merge a topic in such a messy state to 'next'.  But
> my impression was that the topic was not _that_ bad, so Dscho's
> message and the plan were something that was totally unexpected to
> me, too..

My throwing hands into the air and giving up on advancing it in the
current form to `next` was based on its rotting away in `pu`...

If it had been in `next` while Hannes, others and I found and fixed bugs,
then it would truly be cooking, but in `pu`? It kind of stopped pretty
much all the development around it.

And that's the only reason why I came up with that plan (that will require
at least 50 hours from my side, I know that): because I thought that your
not advancing the patches to `next` meant that this extra work was exactly
what you were expecting.

> > I was always under the impression that once the problem that was
> > discovered here was fixed we'd advance the series to 'next' with the
> > patch that comes out of this discussion on top.  Whether it's in next
> > shortly before 2.21 or not doesn't seem to make much of a difference
> > to me, as this wasn't going to make the 2.21 release anyway.  My hope
> > was that we could get it into 'next' shortly after 2.21 is released to
> > get the series some further exposure (which may well turn up some
> > other issues that we are not aware of yet, but such is the life of
> > software).
> 
> I was hoping similar, but also was hoping that people would use the
> time wisely while waiting for the next cycle to polish the topic with
> reordering and squashing, so that it can hit 'next' early once the
> tree opens.
> 
> Anyway.
> 
> I actually have a different issue with this topic, though.  It is
> wonderful to see a GSoC student's continued involvement in the
> project, but it is not healthy that we need so much work on top of
> what was marked "done" at the end of the GSoC period.  Especially
> the impression I am getting for the post GSoC work of this topic is
> not "we are already done converting to built-in during GSoC, and now
> we are extending the command", but "we ran out of time during GSoC;
> here is what we would have seen at the end of GSoC in an ideal
> world."
> 
> I wonder if this is an unfortunate indication that our expectation
> is unrealistically high when we accept students' applications.

Yes, you are right. This is on me. Guilty as charged.

And I don't mean this flippantly. I thought long and hard about this, and
I've come to the conclusion that I will not offer to mentor this round of
GSoC as a consequence.

Ciao,
Dscho

> Being overly ambitious is *not* students' fault, but those of us on
> the list, especially those who mentor, have far deeper experience
> with how our code and project is structured than any students do.
> We should be able to, and should not hesitate to, say things like
> "that's overly ambitious---for such and such, you'd need to even
> invent an internal API---can we reduce the scope and still produce a
> useful end result?"
> 
> One suggestion I have is to have success criteria (e.g. "gets merged
> to 'master' before GSoC ends" [*1*]) clearly spelled out in the
> application.  Something like that would help managing the
> expectation and biting way too much for a summer, I'd hope.
> 
>     Side note *1*.  Of course, depending on the alignment of the
>     stars ^W our ~10-12 week development cycle and the end of GSoC,
>     getting merged to 'master' might become impossible if it
>     coincides with the pre-release freeze period.  But we on the
>     list and the mentors know how the project works, and can help
>     stating a more realistic success criterion if the development
>     cycle and other quirks specific to this project gets in the way.
> 
> Thanks.
> 
