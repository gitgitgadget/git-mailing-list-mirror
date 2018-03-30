Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6591F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbeC3K3p (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:29:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:38293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeC3K3n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:29:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMEG-1ena531tDw-00EIuJ; Fri, 30
 Mar 2018 12:29:41 +0200
Date:   Fri, 30 Mar 2018 12:29:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
In-Reply-To: <20180326205831.GG10909@hank>
Message-ID: <nycvar.QRO.7.76.6.1803301228230.5026@qfpub.tvgsbejvaqbjf.bet>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com> <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com> <nycvar.QRO.7.76.6.1803262058490.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180326205831.GG10909@hank>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:71xK6iH7ywBkkH/j7RTgoBu88paZxQHYCduXQLoFZJ2AdUrqRBy
 WuHtVGwFOlkpEI4pkSrE7Ca7fzc9lDRWD3eiEUj4e5NDFsCT58PVHwNiJV+dz+dHgtgwJLb
 XQzZ2/2F4LNX0ZAhlWj2281xbpTtnhp1CaGt5wfFxG7JxG9s0+qt5KE/lUpdj7GANKM876t
 OCPM3cZt0BaqPdH8HALpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8pkhHeRIuUY=:jtMdvXmyD95nnU1Dy8bktA
 Px/bPzXVoMhOx0sC2qUMrWC8tzkos3l4klqZS9JORR/cVAiSwiU75slKlPaFBG0Ybvd8xUgdG
 gN8w/RVQWDQkIugyBXZzrpAwOJ65CGSDy0keaI3gZ3QkzjwYRO391UO2jLDIeYwjdNhS90MoO
 mbzh3rugJ5zeiCBnJ/yPfmd44jpNbzDQoI4V95np7vQg5791xM4pb4xPFR3JXDI1kZOCALTlx
 5xCgEMLG+ZYWaXXvh/bKgL/XbOIvQsii4r1xsGuozIAdY7XPil7znNO+3+CXIxnrBSwm1+Od9
 oB/X+dYnM679ZfKz2gNbfpNsV93XKjVtGRHUmk4Z2QfeMRgLOTH9KWor3SGH8iy0hPT54dZ28
 sIp1zrPc+qAve97EM2jyPIJXcqL1SedqlLUnSXMVLVq9OgyjBrduM1QKgzDruA89vPeG0M+Oi
 BE5tzPG1TDwUENBnLn3p/NQI1AQmOlVMXAQjHHEa1AHclB7qb++Zn5xhU6BAQjoQOPmCDMhnB
 hF3ksiyDFx08Rss29KmQUKdCB9anXr4H78xZr54mwq2CeL7XkaTbhw9PbM0Z1fJU2lPtZe+DN
 Euo/K7UKjzyvykM6KBaGXI7bkUYle62vRyNxDyXOgw3aNelT9b26oAwKPqEXEHaT0gQrZpmy2
 dtMM7+qlVxHztYMXbQxUfi3jyf4KbKYeLBjW3QeikB4ymR8HEbYX/36SYu0QJZQb7WGcMPBQC
 zb+7wheT9LNb+NSExsF6MvP8wTpCWEr/4CZONugcass1w+SWQtw8e3rZ5avxjNmWfZ6Jz9SLw
 idxINMXk6Uem5S5yUrcfsWC12ivUMWHY4B/UT+xXb/+/A0DXrtfkDZnbNPBFeku1vM/t6h3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 26 Mar 2018, Thomas Gummerer wrote:

> On 03/26, Johannes Schindelin wrote:
> > 
> > On Sun, 25 Mar 2018, Eric Sunshine wrote:
> > 
> > > On Sat, Mar 24, 2018 at 2:23 PM, Paul-Sebastian Ungureanu
> > > <ungureanupaulsebastian@gmail.com> wrote:
> > > > Currently, because git stash is not fully converted to C, I
> > > > introduced a new helper that will hold the converted commands.
> > > > ---
> > > > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> > > > @@ -0,0 +1,52 @@
> > > > +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> > > > +{
> > > > +       int cmdmode = 0;
> > > > +
> > > > +       struct option options[] = {
> > > > +               OPT_CMDMODE(0, "list", &cmdmode,
> > > > +                        N_("list stash entries"), LIST_STASH),
> > > > +               OPT_END()
> > > > +       };
> > > 
> > > Is the intention that once git-stash--helper implements all 'stash'
> > > functionality, you will simply rename git-stash--helper to git-stash?
> > > If so, then I'd think that you'd want it to accept subcommand
> > > arguments as bare words ("apply", "drop") in order to be consistent
> > > with the existing git-stash command set, not in dashed form
> > 
> > Why not start with cmdmode, and then add a single patch that *also*
> > accepts argv[1] as a bare-word cmdmode?
> 
> I don't think we should accept the dashed form of the commands for
> 'git stash'.  The main reason being that we also have 'git stash'
> without any arguments, which acts as 'git stash push'.  So if we would
> ever come up with an argument to 'git stash push', that matches one of
> the current verbs, or if we come up with a new verb that matches one
> of the options to 'git stash push', that would not work.
> 
> In that case we could obviously go for a different word, but I think
> the rules when 'git stash' is going to be 'git stash push' and when it
> is not are already complicated enough, and allowing the verbs as
> dashed options would only make the interface more complicated.
> 
> > This could even potentially be a patch to parse-options.[ch] that
> > introduces, say, PARSE_OPT_ALLOW_BARE_CMDMODE.
> 
> Now if we'd take that one step further and make it
> PARSE_OPT_BARE_CMDMODE, which would only allow the non-dashed options,
> I think we could use that in other places in git as well (for example
> in 'git worktree').

But the valid options change with the subcommands, too. So my idea, even
with your adjustment to disallow dashed cmdmode, simply does not work.

Thanks for setting my head straight,
Dscho
