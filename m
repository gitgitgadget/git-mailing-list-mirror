Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368291F404
	for <e@80x24.org>; Mon, 26 Mar 2018 19:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCZTDq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 15:03:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:54123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZTDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 15:03:44 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbdiB-1eGnfK3Op9-00lBeW; Mon, 26
 Mar 2018 21:03:41 +0200
Date:   Mon, 26 Mar 2018 21:03:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
In-Reply-To: <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803262058490.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com> <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Hxr0eZqb4I5Jae2IM1yyO8FpyGBgYsbpd89Kb8oXQYIfM1R3lOv
 +P78CBOEqJJbW6xZQEfM1fB3Oar6HaSMyEwjEEcw4uRIlFcIgQ+Z0V2hHYW76jvhigJ5czH
 PIAmg+JbTnKPAssQFoE4jYYKUbO5GK5tx/hkKAk/9WuMe+5hYbXbgH1/EykKMLIesOVfx+Z
 lLuC+RAWn30Z8v0I9YUyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b562lcGJJDg=:v7CFNWEKxr2P++aR0+00BB
 ml/CwIH/ewdTlaSONli35WWMlJpC6lZD8nRsOl9bWJ7gImAk+Jr2sZqNar90fVNBILo+pEzXS
 iCiZ/sbCKhIpkIBw1ArNaYTJ2R7erF7ELLZ9it59YWtdKBBZrC9JkEWA+ACRs9BA3jXVJZ/nm
 6GUa2BExT0X7HpHKN9Xg5TkL1KVsLIQocC1lPBbYERc7VQ6KSlaqmU4OKRotStwXY9/3wNqwl
 wX1qXxtFD4tEU2foHKj9owno4CNrKF5UuHU8fwG9bRdMWRvVNF4fV86ILxVo58U+1NHl+VDvR
 EFcrF3fayaqXbGi2buElJOHqHg2ympFCd45ArZ5hhrh19plpz3Sl3yzopKwa2cBxUmFJepmWi
 NtrNusCmp0uiMWSQmNXHDNKjbJtLHTpvyftAWKemsu+QIHis1rS0BA2ha5pLow0JJbXY55LN5
 /njbxGcBoARrk+UEap3I3oooLC6dRid3oZ6RcSerG6dokiPn6PhCvuI63nOkPv31diuiqxc+R
 sIcYiD3OZD0jyKaCGD11l7NtbzXIDB7oW7bznXN8EyOwcFo7mtgfG3wtNmxPnCy4+RWDdrqPk
 7gnvyRDiupfBcX5Tzhs/yHWryWHZdpaoaVeyomiVKnb0cKdWlyt+f3oLbnycYWnHE21XSFcH4
 C3WKjNjt6kcTIe08eiGt56poN2cQSsXXnoy+27ynJHDbbyGALjgZLwbmB0sYy5E7oFHZN6nV6
 pJ7wHkQ51s1aI9USyQMXkL79attYUpLFrHRPZpAFx/CsH4E5G2loirIBHjDRq0TTrsdP3ohb5
 kXPlKIUGHUgOD/9zl0AYKmTsnRyrc1RmUfnjSE3hSYZBa2oX88MCj+oZsQEqGZZOldW0oAq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 25 Mar 2018, Eric Sunshine wrote:

> On Sat, Mar 24, 2018 at 2:23 PM, Paul-Sebastian Ungureanu
> <ungureanupaulsebastian@gmail.com> wrote:
> > Currently, because git stash is not fully converted to C, I
> > introduced a new helper that will hold the converted commands.
> > ---
> > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> > @@ -0,0 +1,52 @@
> > +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> > +{
> > +       int cmdmode = 0;
> > +
> > +       struct option options[] = {
> > +               OPT_CMDMODE(0, "list", &cmdmode,
> > +                        N_("list stash entries"), LIST_STASH),
> > +               OPT_END()
> > +       };
> 
> Is the intention that once git-stash--helper implements all 'stash'
> functionality, you will simply rename git-stash--helper to git-stash?
> If so, then I'd think that you'd want it to accept subcommand
> arguments as bare words ("apply", "drop") in order to be consistent
> with the existing git-stash command set, not in dashed form

Why not start with cmdmode, and then add a single patch that *also*
accepts argv[1] as a bare-word cmdmode?

This could even potentially be a patch to parse-options.[ch] that
introduces, say, PARSE_OPT_ALLOW_BARE_CMDMODE.

Ciao,
Dscho
