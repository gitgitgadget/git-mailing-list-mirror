Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4ECA208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 09:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeHFLod (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 07:44:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:53249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbeHFLod (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 07:44:33 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxdfb-1fyfLh0wCh-017A9z; Mon, 06
 Aug 2018 11:36:14 +0200
Date:   Mon, 6 Aug 2018 11:36:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase --exec: make it work with --rebase-merges
In-Reply-To: <xmqqa7q3w61q.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808061134320.71@tvgsbejvaqbjf.bet>
References: <pull.13.git.gitgitgadget@gmail.com> <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com> <xmqqa7q3w61q.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:40dPxisuMPmHB5jATWvnREMt3LHKWXubSYugUXRX0tHHV6OKiqw
 N/Li1jIbwgWOQOwdpGMgO25VEXDml7Z+H+Ge7kvv7U2ZTnP+yBmaTY3EB/yE1JOELQHbg/0
 IyDGB6YF8nNCkNh9U/md5FQIEiUDdkzQ9FRD2/kakv2aWEDrL9W96w2yDl2ZpHUyoq27myN
 Gshgn1h4oyS8Ko0Al5aKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Qzcd18+Df8=:1LAKMlkJBBFgs7uuhx/nmf
 F/XqXStc9ajLsqs6EltpWeNeunuk3S5JFH3mhEY2ufeSwhxvF/ykqNUj7m+wTrjxXotQkYX60
 gVPwPUJRsfFZD3NXFKSdFG57xRQjY+ZUnqCDPPaMofTyP+48odhXwYI0kYs0414SXt/bo5g9s
 M1SBPzqybsgYAwDONYMuCFFaT9uZThndRbfZ+Gn/wojVqXYdm4g+dyafdlgPMtLcParf1L7jK
 jwea1W8b7kYoo/xhs9208cggeJcoSF0R8oZMfO2lDxSraIJzSuL2s8TMxzgAhcwa/EQ7IzvEq
 SsEc1GjIfkb+vfm4GWG6rrZYKYRdblj20oloAEMvdgQxp3Qgt23MvVuEBBunRb1c8+VIIiXYh
 lkIdOaAWJzzQ15dZSI2HsKlfQWrAxxvD+sVzB7bMe3Dw9Bi/wf5sYhvq8vk78RT6M3+EfSpK5
 MnUbP6XY1HiL0O8Ca4Qh4T40IbBtI4jigNKSBVbM+jVd8nBoejFpdekd3bm8Q3j4K8L51Pmi7
 49jPhzRvHTBz3UU3gO/wYUX8WcqdNQHbCTFx85jFGz1EqFli85NFyyKTwDd8uPxt8f/MT9H0F
 mw1teBL7w2hZ27zVk7F4/97dk8OqBlJMNwOi+OL7mB6hMVAd70qgjg2a63WUXGfvXAbrdsuHI
 gaxqRQZtFx1X0UPGWearfjq3/HYk0cDvk3kYbf77h4Y9eKQawThOCapF+Ykk8YnAVZ7hP7qwy
 0AsRQIpbFZCKn+kqcv5M5b/HMGHRWk8bXTZiyMqr2mumePbWNB2OWdNZOfqvlqygM74cGKI6p
 CUnYHJZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > +	/*
> > +	 * Insert <commands> after every pick. Here, fixup/squash chains
> > +	 * are considered part of the pick, so we insert the commands *after*
> > +	 * those chains if there are any.
> > +	 */
> > +	insert_final_commands = 1;
> > +	for (i = 0; i < todo_list.nr; ) {
> > +		enum todo_command command = todo_list.items[i].command;
> > +		int j = 0;
> > + ...
> > +		/* skip fixup/squash chain, if any */
> > +		for (i++; i < todo_list.nr; i++, j = 0) {
> 
> Does 'j' need to be reset to 0 in each iteration?  Nobody looks at
> 'j' after exiting this inner loop, and every referernce to 'j'
> inside this inner loop happens _after_ it gets assigned "i+1" at the
> beginning of "skip comment" loop.
> 
> For that matter, I wonder if 'j' can be a variable local to this
> inner loop, not the outer loop that iterates over todo_list.items[].

I rewrote this code, and the `j` variable is not even there anymore.

Ciao,
Dscho

> 
> > +			command = todo_list.items[i].command;
> > +
> > +			if (is_fixup(command))
> > +				continue;
> > +
> > +			if (command != TODO_COMMENT)
> > +				break;
> > +
> > +			/* skip comment if followed by any fixup/squash */
> > +			for (j = i + 1; j < todo_list.nr; j++)
> > +				if (todo_list.items[j].command != TODO_COMMENT)
> > +					break;
> > +			if (j < todo_list.nr &&
> > +			    is_fixup(todo_list.items[j].command)) {
> > +				i = j;
> > +				continue;
> > +			}
> > +			break;
> >  		}
> 
