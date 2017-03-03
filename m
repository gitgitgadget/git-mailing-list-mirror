Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBAB20133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdCCPNc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:13:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:52487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbdCCPN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:13:28 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaooK-1bzWkR02Aq-00kMId; Fri, 03
 Mar 2017 16:11:43 +0100
Date:   Fri, 3 Mar 2017 16:11:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/9] read_early_config(): special-case builtins that
 create a repository
In-Reply-To: <20170303045101.om7qtbcmtuw6kzvr@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031606130.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <33e692918c8d41507de5ec2b2e2d55982678408e.1488506615.git.johannes.schindelin@gmx.de> <20170303045101.om7qtbcmtuw6kzvr@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2c2tUDL6/Uhba2xrTLMkfa8uyvyn+pW6n83nGKwrvKkxkhEfdoB
 hi48urhojr637Ru1Z/OLG+RaUez4n+B2v104u9fEobC5B8m9hHKx9kapIThbpQd91MujOZi
 ImyBrN6BBSR/+zl7Ys7VnG67BTTo6cmwuJC5Bg4UdVk1FfUAFKzF4Dh/J6hop4zB+jLaC7A
 RswIG6nwdIQV8buHUuhfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dbZLY/aFG0g=:JZLXrZAX+b5hwBEdB3a2lj
 KQwpmhW3t0F6LT2MJp4arv50lj7y8h5ZP/tvbm6S60fdPu6UfA+DV2aXzdpxG+fcSBIrqq3Wj
 dO3GpQ7QQdnbC4Mqd+fA+PhipkU+8YQQVCcuFKGyFYRxaA/7hSRYRUiLYpllhh6kXmzqvRL18
 sbjJGMur3ES56d80mZOB1Pd0e9KbPW1xRWUpZIDBe9iUZe6VcMnmPph6gU5ZKCNxXPxtDG7zG
 49FsotT9LFCIMvm067fb0Qg5pCCwlUZIEY+dskAuWEwFVNoBqP2K1xJgD+yantsfJ5l7IfnfW
 6QPNQnx1C0fLAZOZdNLf88KiyOYYrHgiVIe0Uk34tI+6rHyU176npKUyLV53tbnAUUmpuxG6r
 j2imqERe4d1Sas/tdIqZgHWiJch2Ib9cxIqfruDCjos/3fC53AH+5Vp+SEQP8ngruhr2agS4A
 i75Ga+dW10uDkDQ4GdqXI7h7hyAXSYwBLC6NtZmOCX4ECwt7UtW9nq1o6/WokdU/v9htZPl68
 HGubBxbdTVEXMxV0rUAHIYHmyg0KumtD04QKkd/NGJg6E++vFkOg5l3eIJH+EYJ2qpYM63fIj
 +x85RwQsiKxCG0RqDEUPrcEgDUsqli0y9g4f/LJ5DTGc8A9rA3dD/rgI3+0iLelDxN3BgSBDX
 fA6nT7vHWC3ixq0ovEaDRQOFlisT0pJXQxHGG24tTBEv8mn6vFVVzK4e8I63aMppb1jD6illf
 DffRTyK2j5/bYofTEq80DGLI2xDbjb53ACEPsIYGMCOk4rbHQ8XPp+/1XlAeaEy6tG1qYk366
 clcqsz2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 2 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:24AM +0100, Johannes Schindelin wrote:
> 
> > When the command we are about to execute wants to create a repository
> > (i.e. the command is `init` or `clone`), we *must not* look for a
> > repository config.
> 
> Hmm. I'm not sure if this one is worth the hackery here.

I guess you're right. Let me think about this for a while in the back of
my head while I work on other parts of the patch series.

Ciao,
Dscho
