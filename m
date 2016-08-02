Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED94E1F955
	for <e@80x24.org>; Tue,  2 Aug 2016 08:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbcHBIK2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 04:10:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:63554 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754720AbcHBIKY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 04:10:24 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MPE7E-1bYsN023s0-004P0j; Tue, 02 Aug 2016 10:02:34
 +0200
Date:	Tue, 2 Aug 2016 10:02:26 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 05/16] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <xmqqpopsjpso.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608021001580.79248@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <d3c5678faf46391ce684aa79927a54cf15beea3f.1470051326.git.johannes.schindelin@gmx.de> <xmqqpopsjpso.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SqibeHsF1hLB4M/iMWvvi0rj3iOrsj0wuo9wPsFELo5BprkjRc9
 R+JbQ2P3NxytamFQ9AXcZDowfwc/rXZCHAJ+AARd2ueP4op5h36isCfZpo6CYwF0CQWz4dH
 awIfFUoTMVhRvxLX8iRnfxockRrBeEn+491BvNVqQlnTDDkVMmgwTuERD6mDCsdiD/OTvFj
 sfTHo6+XNBHjBT2Ihq6Pg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EGpXu6QWgwA=:vVscf/6p7PCc52v7xkjHNu
 sM82EvFVKCgvn3yJqwLn2IOikLD+EELJHm+nABM8wQ7TquKmfPUo5XfK4ORGNVKBwlodVZh09
 snEE6UwaR7pkVKXd84k6n6Wmo4pQgSM73tn0VUv5V4gay6Yk7vM5SMsxAlqsTZKB2BGUKpRYS
 68xXR4HxoFBRkEteNCDFM4obcMJI8PD0eCtTRR/hkXkiruWYKwzlFWA9s1wyQQktKuGw/vktk
 2TwBexoTtIh7tA0BcNjnMfJd948QQv5fXnZzsrekLAYy8JPyENXhUasP6enGVvowB16HQVkA2
 UXXcUjHnXP86zj7v6K0TC0lhN/0AzlGgVdV4OfKs33Cy7dHb/d/p8pJfctBUhNP5MCRR5Vtyo
 bwPpWfiZgJJ4HYVs3b7zzkooBBnix1jXVPTVG4qEk3tDUxvO2adbXmkgH/UxGjAGVUA55K/tx
 tQjAibivTYTZKGHxzXcM3/ObiNU0sCyXvITet/eeZzMQdl0DHRY8DXHrnwo1QOLDjAhmmOMqj
 1iWjVE4cpM0/8naDG5mlehX7VVmjdkJMfht5plTVN6LDNJAFCbfzXsVgkevJ0UpPVO+exrUa0
 8UdTV01uxitjTubw9COKmbTuDpMEcT8vPCqXKYS0RrjOYSdLFpigpn77uJhDG6sKpJNNT8iWP
 qSP1vreDkvaBGfeyDRqwJpLGmlo2ntmju9vkhmHodrCiVdNulsE7JDVIAwlczUVe9pSwdutiY
 HMBmRebWMYQ5hEHdwW8o316nM2MvpRRNUFKymWvQhoKpxseAKiovvXA4q8cMQBAvae04EnGkU
 X2QIlYR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Previously, callers of merge_trees() or merge_recursive() expected that
> > code to die() with an error message. This used to be okay because we
> > called those commands from scripts, and had a chance to print out a
> > message in case the command failed fatally (read: with exit code 128).
> >
> > As scripting incurs its own set of problems (portability, speed,
> > idiosynchracies of different shells, limited data structures leading to
> 
> I think I typofixed this when I queued the previous one on 'pu'
> already, but s/synch/sync/; 

Whoops. Fixed locally.

Ciao,
Dscho
