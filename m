Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8E21F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeC3MdI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:33:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:42683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3MdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:33:07 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8ZtH-1efq301xGF-00wEM2; Fri, 30
 Mar 2018 14:32:49 +0200
Date:   Fri, 30 Mar 2018 14:32:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
In-Reply-To: <20180329194159.GB2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sH9/4dXY4goxay4nb0ideVj+GrBxKvi1cz01PHNe+hSsAIBttoB
 HcQ7XU61QUW51dAKWBoWqc9cUpiVnAUNQ201wDLajum4o1W5f1P3RdUQEqif/CchbCJHmIr
 o0cRkqpQM+hyUH61Flqkdg4n/VxNm0AG/9s3tCG+pp7cHvYCYpuaQGScLDW8S7Vwfgd3twU
 2emZhiSDbjCT8C1qVFDiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3cQ+JfPgcnI=:n7rwvo69gCUtuqxxT0zPcY
 Gp3efqJYXkePg6N8dAGYdrf+EB2iMD+7/t65pk1OqhjJn/+GSswF3lnNWqxw/tbTtXOrd28fQ
 tDwWRSGmWMJ2/KP+tB3a2Wvxp2iFf19WQ4qpxfzSPAl0apcbGDLBWLQAorBsOq5Uz061RZz+j
 yD2ZeG3ZCklx1RYFR3SHJKYE5uXz9bzm/nlyjAm6QzMwIuq02UlZ6ebPxwMptsyOEdyFy/syB
 s+2mWg+hh0VB3qZDHB9VZzM6+gbgDmKbX3WHiSVQnf6LXxiPGgU/RLnT2XrJ1OPQ8hkAAAyjI
 glGk4K+o4f/d5CEBCqRNQsGx/4GpKrRmrZFK4idtvrgJ8+8aPNM+1ngMKNtKx2qu9nNufriyh
 MEqinKGwA+ao0oCX6XHk2aSXUA/DhNj3l5t0kmOZsEQu6XUAC2vleiwzBfu2kmCRpGK5Dogc5
 RLhWJTOMf+bL1ZBpmauMnliGhhoMFvVz1dfWsq6w7R7/Q8aETg3eS3xO+1EXcxIWll/dd3/gh
 Vktv1mQsFXjJexoj6v6agsy7PCtKwjucyo63M/s4E5T3gs32u2FGfciZ6RWjik17yScMzSMWK
 VKCt9690xK93Su2AEisRH14dOIzGhFbm2Orqd7Hi3xjAGEEw5ocwDIT3JxrnVNieSW/9h+qPI
 hWM5wZzgxQmis3YJbyF9/qL9obEP5Qu0hmRUiBhz82cuxayvZn/bGhccLcUuiORBjScHTfdi+
 USJm/IPtXW/8QARodU8oxdGH5BhshoXpJS6UPhUyJvDFfTMo6Vc4jayEZrprf4XaSanXoMXUc
 7DpKDmDA3CYfJ4pdJmpnLEj5I8c3jaXCFZfZAAAqZkYRoYYHY2Mg30kTz/Eaj/9TCfYJ1x6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 11:15:33AM -0700, Stefan Beller wrote:
> 
> > > When calling `git config --unset abc.a` on this file, it leaves this
> > > (invalid) config behind:
> > >
> > >         [
> > >         [xyz]
> > >                 key = value
> > >
> > > The reason is that we try to search for the beginning of the line (or
> > > for the end of the preceding section header on the same line) that
> > > defines abc.a, but as an optimization, we subtract 2 from the offset
> > > pointing just after the definition before we call
> > > find_beginning_of_line(). That function, however, *also* performs that
> > > optimization and promptly fails to find the section header correctly.
> > 
> > This commit message would be more convincing if we had it in test form.
> 
> I agree a test might be nice. But I don't find the commit message
> unconvincing at all. It explains pretty clearly why the bug occurs, and
> you can verify it by looking at find_beginning_of_line.
> 
> >     [abc]a
> > 
> > is not written by Git, but would be written from an outside tool or person
> > and we barely cope with it?
> 
> Yes, I don't think git would ever write onto the same line. But clearly
> we should handle anything that's syntactically valid.

I was tempted to add the test case, because it is easy to test it.

But I then decided *not* to add it. Why? Testing is a balance between "can
do" and "need to do".

Can you imagine that I did *not* run the entire test suite before
submitting this patch series, because it takes an incredible *90 minutes*
to run *on a fast Windows machine*?

Seriously, this is hurting me. I do not complain about this due to some
mental illness forcing me to do it. I complain about this so often
*because it slows me down*, you gentle people. And you don't seem to care,
at least the test suite gets noticably worse by the month. I frankly do
not know what to do about this, as you keep adding and adding and it gets
less and less feasible for me to run the full test suite. I seem to be
totally unable to get through to you with the message that this is a real
problem with a real need to get fixed.

So with this in mind, I do not want to add a test case for a concocted
example that won't affect anybody except users who *want* to trigger this
bug.

I hope you agree,
Dscho

P.S.: Of course I ran the entire test suite. Not on Windows, but in a
Linux VM, because Linux is what Git is fine-tuned for, most obviously so.
An alien digging up ancient Earth history in the far future might be
tempted to assume that Git was developed to develop Linux which was
developed to develop Git, and then ask herself why humans bothered at all.

I actually ran the entire test suite on Linux on every single patch, via
`git rebase -x "make -j15 DEVELOPER=1 test" @{u}`, as I usually do before
submitting a patch series.

And it *did* find an obscure bug in an earlier iteration, where
t5512-ls-remote.sh demonstrated that looking at only one entry at a time
is not enough: `git config --unset-all uploadpack.hiderefs` *also* needs
to remove the now-empty section, because we might end up with the empty
sections in the wrong order, and the order of [transfer] and [uploadpack]
*matters* if the transfer.hiderefs setting is negative and the
uploadpack.hiderefs setting is positive, as is the case in 'overrides work
between mixed transfer/upload-pack hideRefs'. (Side-note: this looks like
a pretty obvious design bug to me, as there is *no tooling* to switch
around the order of these settings. Even worse: if somebody gets
instructions to add those settings, and there is already a [transfer]
section in the config: you're out of luck! You will have to *know* that
the order matters, *and add a second [transfer] section manually*!)
