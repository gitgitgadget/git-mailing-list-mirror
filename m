Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47991F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 13:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbdARNEf (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 08:04:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:52689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbdARNEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 08:04:32 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSMKx-1c0Jbj38cl-00TYeP; Wed, 18
 Jan 2017 14:04:04 +0100
Date:   Wed, 18 Jan 2017 14:04:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Max Kirillov <max@max630.net>
cc:     Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/RFC] Git Gui: GIT_DIR leaks to spawned Git Bash
In-Reply-To: <20170117184224.GA23841@jessie.local>
Message-ID: <alpine.DEB.2.20.1701181402210.3469@virtualbox>
References: <20170116224022.GA8539@jessie.local> <alpine.DEB.2.20.1701171145050.3469@virtualbox> <20170117184224.GA23841@jessie.local>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4YATtfliMc7v+s5RVExDzTqNupgNN5IdiyabK31PQ4Lx+L6IBk3
 d58+q+v6KbwiCTvzlkeMD26U0iEuC59wm58ppAAS3IL4g322LlEIE+38svnVcF6KUMTjHn9
 ZPHnDS+xUIGbwGpVhO46sAuWMriKSlae1YnTEwVl1RskPLIxMyl7Vm9F7q034NRzwUZw1Re
 ulP4XZ9pemQq7MKbJ4Qjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J1kOOoI91o0=:rx4wIO7a7zcaOEErTTaLJY
 5b77Y5dBozA+FiZ4yzY4IwX9a/BCmWkE+PnZAjesU1t2YDp72wJKThFwHQg5HMsBdlS6zr1QE
 cqSC+KsmHRcHxqzTQ8hXh2cyzsSL0kaX8PbDmhTVUNTQ71B3PCJRRmDYN3Gnph0ZXTdKcGQ8G
 aacA/fC1y5xGlH83Te3HLqjnq9hhfQueMp0r4YmofdlZeS/ED290LoIzrYFYzy1FZSiyHIxqe
 OZP6/P1YBJrlLzzbmJ9YtbeiMrwiCv2k6pGIM/VPdA5Nii3xg/D9Vuot1hcmU+XcxyxkwuQO6
 EOZTzCQYdbVEJhHePtGdG4pdGLop6xHj4NzvWDt9juvjXG4JVitnbf+ceDbHs2EkQ9+JYMVcD
 LqcuAjoLj2oeYrIW4eyznkbPGChCe9sEMrUaoDebn19KhRBMtxy+2YNXn5Dg8eLHf2RqAIxTx
 tSuuYtD+ItEL5YuZmAhlKpVE5D8VZgSFvlWqAcrJLBjL79oy+ZipGgpB4k/TsTI5itLMT2LWr
 W1Vofmne9uEKF1/AFpldAbvpkP7IMxfw5LNzgFqi8+giQMIhEpv5vXBRlB3xtogcbMn5fqQfm
 CimvdNqneL5+T2r9g6yJmZ72AwvJQv6I7TB/T6cUmQPkCzfzK8f3+NBfBQ3aUc2xLdK3Mgu4u
 gyxXIpdmjFR6PFRkiMvd+c3WXbMQ3EWqSKSeTId6z2mIudpjzb+nKnIBsJz9ZECk/aqlEm0ql
 5498Kkui7s2NmVT50uy2Uwv5v5bU8z7v1DL+PcFkNmgDmhVH4xGyK+BX44wCOeBGSC6pNlurI
 NHfODZf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

On Tue, 17 Jan 2017, Max Kirillov wrote:

> On Tue, Jan 17, 2017 at 11:52:29AM +0100, Johannes Schindelin wrote:
> 
> > And having said *that*, I have to admit that I was unable to reproduce
> 
> I have found exact way to reproduce it and actually the reason. Turns
> out to be obvious mistake in code. PR is in github:
> https://github.com/git-for-windows/git/pull/1032

As I pointed out in my review, I think that GIT_DIR is actually only set
for `gitk` in the non-submodule case. So I guess if I run Git GUI, spawn
gitk, and then Git Bash, it will have GIT_DIR set.

*clicketyclick*

Bingo. That reproduces the problem here.

Thanks,
Johannes
