Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECE0208EB
	for <e@80x24.org>; Thu, 19 Jul 2018 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbeGSRSe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:18:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:50191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731690AbeGSRSe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:18:34 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lurin-1g6l9v03O5-0102PV; Thu, 19
 Jul 2018 18:34:26 +0200
Date:   Thu, 19 Jul 2018 18:34:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
In-Reply-To: <20180718192128.GB7778@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807191833411.71@tvgsbejvaqbjf.bet>
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com> <20180716161821.GB18150@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1807181420250.71@tvgsbejvaqbjf.bet> <20180718192128.GB7778@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a/mWBG+FI/C9vrWG8jr1GSSXgxPKBHzi01SSwRJ6C4/XATPwfyU
 yA6/6PUXzOTrAt1kP1s1nuRzHbl8vcKU5QQOt9eqOjOHsw4pU99dGMNCZShZSIuooYLDtjc
 JJZLcvfdYSPWW3lRfkHEClqnhQeswMgr9c7j+pRl/DaPt6wU7MMY6xx7Kqohw7V/DF6CAsg
 C/PpnJ5dVZ4JXvVuePHfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HXBdXhhb+4M=:WyK6lwJ40TxquEHyOaEXhU
 JCG3zPbuyVO18keqIrNPn9niiwRIEq2H/B60PGvLrNhihwP/2yZY22FNNQ2nIOhDomRjNzFCG
 gBlTc/y2hBvr0v4RizpC5hZUkeLKYFEIK416H0p9oFKzDtKM7zpqJpCajJE3CboPDXRf9qdMp
 BJoPFdDa68vzHemBOD/u3MwR2LHZcBn63AwxjxkYcR9Yy4aY/hOiQA/ViA4vDT6hcdFjyIUy4
 TqwVWnjDqzRelUl6q9y9hbl/vCMiLXR8c+Wlej0f0Omkd4ZRLjvy7wzUsikKfKPruXW7nOMdB
 nMCsOPjbyYZNAdLQsPyee8Eb6KW17lB9IEetKcZrQ+bqVcePuTP2ILobuQjLUaCov3vknX3hs
 CUGuTXSrmHw3c/LdxnEYm/hjMWkGQGpbFSgtFbKtSw5HbF+CgYP/KyM4tpsKvobB1P/Tg5BA7
 7mxxeUHw1V45c7wGtbqQbqRiYoNb2mukkg06ycCwt/kee41kNDrDKrtjxoyXiPXlfraCjg3Wa
 T7rlSl2Ilw2Y9nMANCjXA3MhedDnnQWEIz3clO9EF4mrGghZPk3ledliHydWLzogMk2m9O0Q4
 qLf8hNaRvMLkMH2Vb1ANKWTjC9ZjPrN1yM33lU/5A/zKWCJ0J17hdpcjudU5huxIEHHXTWBa4
 aOPBfa8YXzzBHckj8gi3VW0aj6eL3b9fFavcqUgdL1kn+VEFAtUNjdKzqSHqqb5MFc1X3ElPT
 6RIyDieR44jxiqTw5gTXnW9nNABoyNR6fQnvikxuULuqNIhd0WFw6g32snARANrPnsXHdGnG3
 scHfwHT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 18 Jul 2018, Jeff King wrote:

> On Wed, Jul 18, 2018 at 02:23:11PM +0200, Johannes Schindelin wrote:
> 
> > > Yeah, they're out of order in mutt's threaded display. And the
> > > back-dating means there's a much higher chance of them getting blocked
> > > as spam (e.g., some of the dates are from weeks ago).
> > > 
> > > git-send-email uses the current time minus an offset, and then
> > > monotonically increases for each patch:
> > > 
> > >   $time = time - scalar $#files;
> > >   ...
> > >   my $date = format_2822_time($time++);
> > > 
> > > which seems to work pretty well in practice. It does mean the original
> > > dates are lost. The committer date is not interesting at all (there will
> > > be a new committer via "git am" anyway). The original author date is
> > > potentially of interest, but could be included as an in-body header.
> > > AFAIK send-email doesn't have such an option, though, and people are
> > > fine with date-of-sending becoming the new author date.
> > > 
> > > +cc Johannes as the GitGitGadget author
> > 
> > Thanks for dumping even more work on my shoulders.
> 
> Wow. Here's my perspective on what I wrote.
> 
> Somebody pointed out an issue in the tool. I tried to add an additional
> data point (how other clients react, and that I've seen spam-related
> problems). And I tried to point to an existing solution in another tool,
> in case that was helpful. I thought cc-ing you would be a favor, since
> you obviously have an interest in the tool, and it is easy to miss
> discussions buried deep in a thread.
> 
> So no, I didn't write the patch for you. But I tried to contribute
> positively to the process. And I got yelled at for it. That makes me a
> lot less inclined to try to help in the future.
> 
> > Next time, I will ask you to jump in, instead of putting the onus on me.
> >
> > I mean, seriously, what is this? "You can use *any* mail program to work
> > with the Git mailing list, *any* mailer. As long as it is mutt. And as
> > long as you spend hours and hours on tooling that oh BTW nobody else can
> > use."
> 
> The irony here is that I actually _did_ look at the GitGitGadget
> repository, and thought about making a patch to be helpful. But as it is
> written in a language I'm not all that familiar with, using tools that I
> don't normally use, I didn't want to spend hours and hours in order to
> make what was probably going to be a one-line patch in software that I
> don't use myself.

I understand that. The web is not based on shell scripting, so there is no
good way to implement a bot on GitHub using Bash scripts.

Ciao,
Dscho
