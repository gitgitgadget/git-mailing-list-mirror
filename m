Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8941FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdJ3MrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:47:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:53002 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbdJ3MrB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:47:01 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mam2Q-1dtGEz1LOk-00KNQf; Mon, 30
 Oct 2017 13:46:43 +0100
Date:   Mon, 30 Oct 2017 13:46:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     phillip.wood@dunelm.org.uk
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
In-Reply-To: <7026e5be-bbf0-9d55-8901-f920a775879b@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1710301343000.6482@virtualbox>
References: <20171028000152.2760-1-jacob.e.keller@intel.com> <alpine.DEB.2.21.1.1710281740070.6482@virtualbox> <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net> <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com> <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com>
 <xmqqo9op71d8.fsf@gitster.mtv.corp.google.com> <CA+P7+xo5UgUPQCYU-LaXn+HZZ1qe++KOevTMh2C1sgnzK0SAQA@mail.gmail.com> <7026e5be-bbf0-9d55-8901-f920a775879b@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g8ORZn5tAYBBfJfQAbRpb3kJmcfeSGVrMeiHj/M5xkYpHvQ6STr
 c3NCRs8WYtvwjZRX59gyVSdoazaQ2I1rapk2EHrHdEHaVLUMu3pcfJnB/di4ENivZEOxR0J
 qFHtfX0LRLAhOptWy8Ghdv+z6UGx+4uoSGynX+3/N64VIS7CvIrQ0/eqGsnZKll/dCJOOii
 4nJ146q9uJIEioMQIprOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ei55GzmXv8o=:e8FnbHWnpNJWALGZaAEvgY
 Dzkod1JqKuAIwjgXlU7XSTA6LE41df1rZLbMiUe1SUVlNq1d9nqVmQTo9EnIY1KCNragBF53R
 ZLhnrCEofTzqvpI71PsCcMLJ15nEyNtuuKXPSpzbf6pvSsJVmmtN6cY/vR2V0Nx0Wf0kKSxpf
 jaO+jX9ifYZasyoNv2dkQsBOlrWsDguisQEMv2tBFnqJUjwRBmbctOKhHRiN1IzwuyR0IC/Nc
 tqXlYCsP6x0STAvULk90RMYJA3qUVyu0wNYc8Dc8p8sa4vTa8NwICr8ZHXjuYZBStPCkTU80J
 Y9ub3+OXGk2FPFYx461fsSlN9O8V68w/cUswvOPFdGp8Xgvn8tXEbW7ujFjuIvAoW6l5RwZ05
 NN0kfuneTrFQFOIv0v9fUHVqPjRwOt0DQ8OgjLuVQbx1B6d2AM9w/vvAbAw1OCQppPrt8cvMx
 MumkYDAfXNfTZN+barFc1U0YuKE6aXJSu+3N3lOInyHL1jLOoPkR/03UWnNKGfAURtMWsRres
 Zpt8BLpBunKZ6zMTeGctDP2pB93HvsZviMr67IBkm0qXDckkINQ5X9MStroXKxNy/eaNS1cEW
 iZ4yrEsHbTWU3b0n+nSbVpO1ZvhRCwLDm9jc/+ndExt2FP3aSzhSEz9erlphz/LYsXzKjQcto
 v3FDq4hT14yspxw6YLzWnB9BikUHZOjxVtKHnZNwrMyEkYkxtn3ZoKxTqSTV3IZkt8UczLqpK
 uIRqBJ3w6mYUeRKq31DDww+wOv6AhxpU/40G0SgN+RxdagK6lVGsv0J4n7HUCFdurxPATHnGu
 W8LzLKZOMpnThedepyu7xNcAXzejqG0F6rpQYFJATu22R74O3SoTa2YToUQDpnwGc4j95yO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 30 Oct 2017, Phillip Wood wrote:

> On 30/10/17 06:26, Jacob Keller wrote:
> > On Sun, Oct 29, 2017 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Jacob Keller <jacob.keller@gmail.com> writes:
> >>
> >>> I am pretty confident we can fix it....
> >>
> >> I am sure we can eventually, but 3 hours is not enough soak time.
> >>
> >> I am inclined to leave the fix for 2.15.1/2.16.0 instead of delaying
> >> the release by 10 more days.
> > 
> > That's fair. I'm not even sure it was introduced since the last
> > release (I tried 2.12, but not 2.13 or 2.14 manually). Thus, it likely
> > wasn't noticed for at least a release, meaning it's less important (to
> > me at least) that we provide a fix immediately, since it went
> > unnoticed this long, likely that means few people will be impacted.
> 
> It is in 2.14.3, I haven't bisected but I suspect it was introduced by
> 311af5266b sequencer (rebase -i): implement the 'exec' command
> 
> Running
> git rebase -x'perl -e '\''$,=$\="\n"; print  grep { /^GIT_/ } sort keys
> %ENV'\' @
> Shows that the rebase--helper version also sets GIT_PREFIX as well as
> GIT_DIR, I suspect the difference is coming from differences in the
> setup for builtin commands vs external commands. The shell version and
> the rebase--helper version set GIT_CHERRY_PICK_HELP, GIT_EDITOR,
> GIT_INTERNAL_GETTEXT_SH_SCHEME, GIT_REFLOG_ACTION

Indeed, when you look at git_dir_init in git-sh-setup, you will see that
Unix shell scripts explicitly get their GIT_DIR turned into an absolute
path.

So my suggested patch is wrong, and it should be more along the lines of

	struct strbuf buf = STRBUF_INIT;
	const char *child_env[] = { NULL, NULL };

	strbuf_addf(&buf, "GIT_DIR=%s", absolute_path(get_git_dir()));
	child_env[0] = buf.buf;

	...

	strbuf_release(&buf);

Jake, can I still take you up on taking it from here?

Ciao,
Dscho
