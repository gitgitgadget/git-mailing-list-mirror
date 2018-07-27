Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1371F597
	for <e@80x24.org>; Fri, 27 Jul 2018 15:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeG0RLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:11:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:33493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbeG0RLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:11:31 -0400
Received: from [192.168.0.129] ([37.201.193.59]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lcjgd-1gRRsc3nrb-00k7FT; Fri, 27
 Jul 2018 17:48:57 +0200
Date:   Fri, 27 Jul 2018 17:48:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
In-Reply-To: <20180726191609.176343-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1807271737470.10478@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1807261233300.71@tvgsbejvaqbjf.bet> <20180726191609.176343-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YJESwaOzbFk3cLD28wd04xc7C57LeqnM2MSi9LxcM61RG0QvkR8
 dYbjJjNYhRhKqy79KY8eWUDawosUUZgiUrSD/XHXIxivrEObfjcfw5Sk1G9x555tGhidarB
 Wy4yibhRgE6HYN1S3pYvM8t1m/Ix2VMcCWojWNz7+cc5YbH62jKtz5cwZ0EkjIfYEhf4Q32
 ylUcOWxvHneJlW3QGnI+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:svsLdxEhYmE=:ovQLVNdCk0lztG30BSV/e6
 cIXLmMIwxGM0AlIP+3+U0p3gPoRJ4AhhAGA+aEFGtZXAWH8CaBtNjUASOMZsSspwMBsBPWW7Z
 YNKunguRY7jN280G23L2iGAZyE98+FNA48nSNY+88VTaM2TUqR1UDxi+fxFYQTqQU7+9WJ6Xp
 PCyYzUKNxRpJmfYNmhKSnK/+FbVylb94Mxi7msAi67DZ0iyU/2+0BoZ8puWg2nU43P0mZWQax
 cYe0YqxaIMGqzOE5Z/SVZd7L5mmaT3yuIydQvjHacGzYGsrsZKy8xBb9+SaPFmT/3QgxVxsUX
 i7D0P34PrOla2ytldZ2Anw9NZ9NpTzGKz+RBTjb4l62QR0Kcy41T9HVNBuRjqJmLavOVwJ7ZB
 T7k1EEk13ETirzfbjdx7ZJcD3wQgr1Keb1UOFdCGYjQ1tRBnvGPEfJAr4FJyz3SEs4W+daXhB
 DsuX/GJYN8zMWkTuu5KKzWhDYj1Q4Dyha3Mab/T4IUX/9TIvR1sjIRvfn3Z46WnNVIT0jwjqd
 q13sXcc/Hhyms7qzAVzLoMGHdBss2eQ/tbsGDt++Bp8TJgIoPA2KBDFCsOR0MnB8/1Mf5O4ao
 5Zv2QUFP6kQzwJeHuRBneeMSyUOC3/UDt9dV6dHiW62rfOM/pu68c7yHYkEX5pA3Ib5aetL7u
 UianbNzldYxz12X/rFHeaRL/otLhakOrZMKPuzFNDTxYHtV9u7dtxp90J783aN5eJGM2n8t13
 5+k0G9/chEk/ey+lS42ica1EPLdaHipIGWADF58GqSwr1ftNTI7gr5+IXn6zMBBRrFFJ7Oh6U
 E9WeWpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 26 Jul 2018, Jonathan Tan wrote:

> > On Mon, 16 Jul 2018, Jonathan Tan wrote:
> > 
> > >  t/t5552-skipping-fetch-negotiator.sh | 179 +++++++++++++++++++
> > 
> > This test seems to be failing consistently in the recent `pu` builds:
> > 
> > https://git-for-windows.visualstudio.com/git/_build/results?buildId=14337&view=logs
> > 
> > Could you have a look, please?
> 
> Hmm...on my Linux computer, this test passes on both pu (as of the time
> of writing) and 838143aa5c ("Merge branch 'ab/newhash-is-sha256' into
> pu", 2018-07-25) (pu at the time of that build, according to the website
> you linked above). If you could rerun that test with additional code,
> could you add a "cat trace" and show me what the client sends?

I can give you something even better: a playground. Just open a PR at
https://github.com/gitgitgadget/git (all of the branches on gitster/git ar
mirrored, including yours, I am sure, so you can target that branch
specifically).

Once you open a Pull Request, it will automatically build and run the test
suite on Windows, macOS and Linux. You will see it in the "checks" section
on the bottom. Example for my range-diff series:

https://git-for-windows.visualstudio.com/git/_build/results?buildId=14279

For a quicker turnaround, you could add a commit that forces the `all`
target in `t/Makefile` to run only your test.

> When I do that, the relevant parts are:
> 
>   packet:        fetch> have 9ab46928dc282aa09f4dbf96893a252e058e7e8e
>   packet:        fetch> have dc824fafb05f3229aedf1f320bbe572e35364dfe
>   packet:        fetch> have caef059de69917b9119176a11b88afcef769331d
>   packet:        fetch> have 41bd8dc092ee110ba80e350a346ec507ab2e42a0
>   packet:        fetch> have e9a2c092a8e911567a377c881a7f6031e7f892ea
>   packet:        fetch> done
> 
> which is exactly as I (and the test) expect.
> 
> Two possible reasons for the discrepancy that I can think of offhand are
> that (1) my computer generates different commits from your test system,
> and (2) the priority queue pops commits in a different order. For (1),
> that's not possible because the SHA-1s are the same (as can be seen by
> comparing your link and the "have" lines I quoted above), and for (2),
> the code seems OK:
> 
>   static int compare(const void *a_, const void *b_, void *unused)
>   {
>   	const struct entry *a = a_;
>   	const struct entry *b = b_;
>   	return compare_commits_by_commit_date(a->commit, b->commit, NULL);
>   }
> 
> Let me know if you can observe the output of "cat trace" or if you have
> any other ideas.

Like I said, you can use those "CI" builds, I think that would be more
effective than if you waited for me to react, I am quite overwhelmed these
days.

Ciao,
Dscho
