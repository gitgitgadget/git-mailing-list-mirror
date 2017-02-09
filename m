Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E651FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbdBIWSn (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:18:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:53516 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753690AbdBIWSl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:18:41 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1cm4EO1m6n-00PclM; Thu, 09
 Feb 2017 23:11:29 +0100
Date:   Thu, 9 Feb 2017 23:11:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a
 subdirectory
In-Reply-To: <xmqqshnnnj6q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702092304250.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com> <xmqqshnnnj6q.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UtEOTF2Tql3mobygbOX/5yHJSGmMFkZBwVGtVxct98Ez/GuFUKR
 xDPxWyuZMiPv0gZ5LNhSIlX/0ABnVNC4oaGZA+S7Kns+LOYh1TR7NemiHfckFabVE+kd4qc
 a4Aeo0JGnHZltkRI3e3A1JfSVBMdhrk6jxS4sR7BlrXKQM+EMdG3/HWhzyPMkZQTj75OaTN
 X3282yQ9seV0pfOiffhrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/1X2h0Vth3I=:WgYDg3qoFaHkjuKfV1gl3A
 pGT6nk/h94EMlzEbZ9xS3W7kG5dGk+jGYPropp3caV/P8+j0s1IYSMOWufDWjirsUy/n05sM6
 ZJ4TpAjD3EIEMeVcXjarqgxf5+y/4aLFzCZOQjgTdvzkj5WxKHrbzy5kVCq2IxxWKhIRUzkWq
 eCGDaGbLGEcGwc5LkSi37fWUwRQUpJfrGPva1pUIvnrQ2vrUdG4GK6egR5JRDQ1gzs596oBuo
 PrcbVxYGJNgATTSO2rrBCA1rnWImdDxJDBHovMTrQoArMLzEkS8bL6uzCDlppDgDHl9kfVm/O
 QyC1cLbyEqSZ0YFo99o+Mm6HSIOX6bM6GYzqhIFtb5de5molvC9vkZDvb1aXDcW+9gNbGRkB2
 rfX4HZF6OpGlZkGflA0416cV49fLz8/y5AERyl78WMn7UFyp2un/cYfks0pxAuZs6ILDV0nlL
 DtpLfXfNERzxZ22z5oMIRhiKnLkTiH/Neq5caaBQyhY+cIAz8c76hXYvathgQdnSEg+bKait6
 A+opevD+03FKoUfxHmzS2fEafL0UVEPhf+3GppCZltltfFT/qUCLVrshwxE0OgtEy7pfWdj8i
 TljLQOFfRcA5PRrjjCFiQEZdPTPlnS2htJ7QZjeQJnk0BskfjcmDOTk4tJ9/YT5WyChdYwD6b
 7Ad4DqJPVy5D5+BtkOy9NyQcT2GYY0tO/zcr5Vfv/98VHyx7DHy7hqmgtK+oRwojkar/1Q5OY
 uXokW+HPaDTcV2S+ExqPncXlWKcEf1cRaw62kTtpY/KWOllCsUjgOhtRFlioA2K+W7nHMTqPd
 EeD+QtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Feb 2017, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Relevant thread in the past [1] which fixes both --git-path and
> > --git-common-dir. I think the author dropped it somehow (or forgot
> > about it, I know I did). Sorry can't comment on that thread, or this
> > patch, yet.
> >
> > [1] http://public-inbox.org/git/1464261556-89722-1-git-send-email-rappazzo@gmail.com/
> 
> Thanks for a pointer.  I see Mike responded to this message (I
> haven't had a chance to read and think about it yet), so I trust
> that you three can figure out if these are the same issues and what
> the final solution in the longer term should be.  
> 
> I have no strong opinion for or against a "longer term" solution
> that makes "rev-parse --git-path" behave differently from how it
> behaves today, but I am not yet convinced that we can reach that
> longer term goal without a transition period, as I suspect there are
> existing users that know and came to expect how it behaves, based on
> its today's behaviour.  Other than that I do not have suggestion on
> this topic at the moment.

Given that

- the output is incorrect, not some output that could maybe be improved,

- warnings in a script execution are most likely to be missed,

- --git-path gives incorrect output in subdirectories, except inside
  worktrees, therefore scripts relying on the current behavior are highly
  likely to misbehave in worktrees anyway,

- leaving this bug unfixed even when we know about it for 3 major releases
  reflects really badly on Git as a project, and

- the longer we wait to fix this bug, the more developers will simply stay
  away from --git-path (of course, only *after* they were bitten by the
  bug, like I was),

it should be safe to assume that a transitional period is more likely to
do more harm to our users than bring benefit.

Ciao,
Johannes
