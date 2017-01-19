Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DB720A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbdASUEc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:04:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:56006 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbdASUEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:04:31 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1c0jML2yVo-00es5Z; Thu, 19
 Jan 2017 21:04:25 +0100
Date:   Thu, 19 Jan 2017 21:04:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The design of refs backends, linked worktrees and submodules
In-Reply-To: <341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu>
Message-ID: <alpine.DEB.2.20.1701192057530.3469@virtualbox>
References: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com> <341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Bt5eNvkXIzpJh+d9gXg6B0r7J2pLhgVpHaiv7kiJSFxqRamzEuk
 zw+zghhRFX1FBzCmZSNu0RdMVV/OuLKWXZrmroLcKGg8fFF+ggCtl1PShurET7KgrgvpIpN
 M7iPe+srYlse2HMCCJ2p8lA6kbvSSSdPjWHXxm8kymz+C9ihaL0GvZw+3jXa+ofi0T5NNQA
 kVA2R78Hdcf8XMh+vffQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m0Q/zZ8YVus=:TNS6qg8IpSlonJy9LyJY7a
 TXsXqO+8Nbid+kWgR+QXOEr54vgvmf73TI6hehutIybEknzRCQz1UdyfL9Sw3iPCEaeoO1sQd
 TVQGRGJuN4K1/SotDq+e9XIZ2wEn6kRii0LuVCbNumBsLC/dsJ2x6t4bdPTPTZw9sFILts091
 B/VGw6ObMWHSOK29FYXIZAiWjwz+cn+B2HxWtO0JaIuHmmAhIMSvxLsvZLbjacNABvRKM0TZh
 Uvw/HcpqAn1cClvoEfPGPtcPPMK/d+qvPggSXDLU22ygRsUtKH2SZmb6l5hJV6qtFVDTA9kdz
 9WhfkDAsjuIhwjvBR9360giIwvYnUS2TYpMbALcL5Top8wBgAa2NuWArBd7gio9JSz13NFeYe
 mpTbqCF7XR9PIRirwimbyx78m/dvSoGDkDUwr5LtMc3xF7sp+1ZeZ7qbjILNCIwNf8tPW6NI0
 nBe+Hj3Etj+MumnDEorgNusxMHZIlaglLsdt2jNhD7mzFKcfrkunmONgLClDECz1VtpWaF8cD
 rQYWFmU9oCYqbKyeDeuM4IiBQFGAUJbYfewSEgVj34o2PCmNbLBYG2VjAnzeBM4S8Gvi2f4mq
 nvKaT6UrHTCyJ8+sl93rPi1O27RAgxkvxIpEp7+Y6myQKLpIXjQFBvVbcWDwdPG+ta1TE12U7
 +Uj0uAPZbVACCBKwo46LPKh3YYYCqkcasIa5K97an9Wog0CvX3nFiaHoaBz+Yt3CcRL5wBmhC
 x0nTGOqeu5QaAipRDyHwRBEdaa76M72vjlcjYSBncm0pPczIRYqXJNlgNylODMm3T8Cw3hYrr
 8BlARiS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 19 Jan 2017, Michael Haggerty wrote:

> On 01/19/2017 12:55 PM, Duy Nguyen wrote:
> > I've started working on fixing the "git gc" issue with multiple
> > worktrees, which brings me back to this. Just some thoughts. Comments
> > are really appreciated.
> > 
> > In the current code, files backend has special cases for both
> > submodules (explicitly) and linked worktrees (hidden behind git_path).
> 
> There is another terrible hack also needed to implement linked
> worktrees, namely that the `refs/bisect/` hierarchy is manually inserted
> into the `ref_cache`, because otherwise it wouldn't be noticed when
> iterating over loose references via `readdir()`.
> 
> Other similar hacks would be required if other reference subtrees are
> declared to be per-worktree.
> 
> > But if a backend has to handle this stuff, all future backends have to
> > too. Which does not sound great. Imagine we have "something" in
> > addition to worktrees and submodules in future, then all backends have
> > to learn about it.
> 
> Agreed, the status quo is not pretty.
> 
> I kindof think that it would have been a better design to store the
> references for all linked worktrees in the main repository's ref-store.
> For example, the "bisect" refs for a worktree named "<name>" could have
> been stored under "refs/worktrees/<name>/bisect/*".

That strikes me as a good design, indeed. It addresses very explicitly the
root cause of the worktree problems: Git's source code was developed for
years with the assumption that there is a 1:1 mapping between ref names
and SHA-1s in each repository, and the way worktrees were implemented
broke that assumption.

So introducing a new refs/ namespace -- that is visible to all other
worktrees -- would have addressed that problem.

This, BTW, is related to my concerns about introducing a "shadow" config
layer for worktrees: I still think it would be a bad idea, and very likely
to cause regressions in surprising ways, to allow such config "overlays"
per-worktree, as Git's current code's assumption is that there is only one
config per repository, and that it can, say, set one config setting to
match another (which in the per-worktree case would possibly hold true in
only one worktree only). Instead, introducing a new "namespace" in the
(single) config similar to refs/worktrees/<name> could address that
problem preemptively.

Ciao,
Johannes
