Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92AC91F404
	for <e@80x24.org>; Fri, 24 Aug 2018 12:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeHXPtL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 11:49:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:56795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeHXPtL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 11:49:11 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkiqm-1gR8E52d88-00aZ0O; Fri, 24
 Aug 2018 14:14:45 +0200
Date:   Fri, 24 Aug 2018 14:14:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Request for testing v2.19.0-rc0 *with builtin stash/rebase*
Message-ID: <nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:se8JugQkAI9gxb7EwCZcyHmR0p4pNshE+nwlNUgynkUkVwvVG8/
 gWIXNKc6ihDWwo2o/ZQ2jE5FN4xJgxw2LN7b8iKcay7mxFPeiF0bwc9ANrbIRpil2AWSB2D
 ExvOZYCc2yLj5/HR129034Z5ToSyqGhNLIQzOn9+jYs3KfYmaTFLeTEwIouZ8yPDHqTzbKw
 Ci0WhZ8eR1Ov3zBu4VPYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E3st2unq8wI=:tC2GSZd/Hz1mu9bGt0+uh4
 vgDLz3wEdenoeOgCy0VvdnrJobI4mjaLWfrRl0ZCarCRrf+TteLEodD+wrfxhfRHDe9FhEIch
 5AyvCwKQ+9O238mS/74jFyLEi7sPYqhtH1yuDQtvCq3imC9efPw+wO1f2/XZQW4QB14JfTQNh
 FbuweKmbepM38GG990AJ2WDftngCNEuOyhDEas8M/AaH7SqGps1819yto9BzQEjyu9IFOrqlC
 w1yroxnTBe0eTR3fkz3pNrUMLRWFb35GO9JO/HkSyGmt4fQ0PVyTsjlTQt0gFmY3vUNMzxvaL
 DdESu6mNGa4dINp2k+y/9I+7tQ73ld9aGX2qYzaMvBXvbyAXioQnxjzP/iCfpzriCD4QZ/Vm8
 DMbVd2niiDMbiab+YrAss9s6aRM0+ijNloWWD3GSpFzNo62632jEvbGMr4CzQqiamA4hIRW0n
 u39WL1yuggkLad1kWg4vAtL5SQbccV2DksU0X58SRcTjOEcChLBt/Eb70yO7BQpDFlbpvzNJR
 qqGa8T+6u7PtVhmMOgJ9bGxgKgJpYxTBvTh47mTfDiHSbqcMdCJGo/VcTkH1gLAmPRfyOTPot
 LmWJujJFPu7iVlnRhXBB29k82Dj2yGDZeiH2QDHDO/Iz+NISUraLDqH/h8zUfAIMMziaweBZj
 GF+hfQChqwAr86CiuVNTL2H5bB+Rr+G9bB3j/aT7Skp+/L/u2LAMuaZZKRNbSSCMtKp2RIkbV
 JyfQpUos7ijKClnz/bpRnzjz1NHxyKZWW0NAyqb8XH0AegRjgkF1s0ay1n30n4fAPYT56tvK2
 u6vLluF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

while this mail talks about Git for Windows, please keep in mind that we
try *very* hard to keep Git for Windows' master working correctly not only
on Windows but also on macOS and Linux.

I, for one, run Git built from Git for Windows' `master` branch in my
Linux VMs all the time.

As all of you know by now, the fact that Git was pretty much designed to
work well on Linux is not exactly helping Git for Windows. (Or for that
matter, macOS: Git is substantially slower on macOS than on Linux when
running on the same hardware.) The quickest pay-off comes from converting
Unix shell scripts (which are designed to spawn processes, whereas Windows
is more optimized for multi-threaded applications).

For that reason, I was delighted to see that our Google Summer of Code
pushed pretty hard in that direction. And I could not help myself so I had
to test how much faster things got. Here is the result of my first, really
quick and dirty test:

		without builtin stash/rebase	with builtin stash/rebase
t3400 (rebase)		1m27s				32s
t3404 (rebase -i)	13m15s				3m59s
t3903 (stash)		8m37s				1m18s

What can I say? Even if the numbers are off by as much as 10%, these are
impressive improvements: keep in mind that there is a lot of churn going
on in the test suite because it is itself implemented in Unix shell
scripts (and hence I won't even bother to try more correct performance
benchmarking because that is simply not possible when Unix shell scripts
are in the equation). So the speed improvements of the stash/rebase
commands are *even higher* than this.

So I really, really, really want those builtins in Git for Windows
v2.19.0. At *least* as an option.

Therefore, after creating a pre-release of Git for Windows corresponding
to Git v2.19.0-rc0, I created another one (note the .2 at the end), *with*
those new builtins:
https://github.com/git-for-windows/git/releases/tag/v2.19.0-rc0.windows.2

I would like to ask you for help in dog-fooding this. In particular if you
are a heavy stash/rebase user (like I am), it would be helpful to really
kick those tires.

Of course, those are only Windows binaries on that web page, but it should
be easy to compile from that tag on Linux and macOS. I could also build a
macOS installer and add it to that pre-release, is there interest in that?

Currently I am uncertain whether I should spend the time to reinstate the
old scripted `git stash` guarded by `stash.useBuiltin` and the old
scripted `git rebase -i` (guarded by the same `rebase.useBuiltin` that
guards the scripted `git rebase`), as a fall-back (or make the new
builtins opt-ins instead of opt-outs).

So far, I have not encountered any serious bug, but then, I did not really
have a chance to use it yet (I installed it, of course, but I have not
done any serious rebasing yet). So your help will be crucial in
determining where I need to spend time.

Thanks,
Johannes

