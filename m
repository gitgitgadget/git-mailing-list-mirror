Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2806720188
	for <e@80x24.org>; Tue,  9 May 2017 10:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdEIKYo (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 06:24:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:56419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbdEIKYn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 06:24:43 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOx4J-1d50Bb2ZEt-006KhE; Tue, 09
 May 2017 12:24:32 +0200
Date:   Tue, 9 May 2017 12:24:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] archive-tar: fix a sparse 'constant too large'
 warning
In-Reply-To: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.21.1.1705091223190.146734@virtualbox>
References: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cwq6dP8nohCR4M0FcCHGts+JspGNAgdhnI9V1r6oJ1rwWJnoXVM
 ScxMrrE/Hcu07iiYNy7iFLewLKa9WGAQj4U0yJ6x7yB1dyQ9TEcVWU6EK5bP0TLoqNgF6rb
 viWV7yZvuCKHRLvx3TVLYfRU8Ihz5OURYP93GXbUb0g/R8j3mKqqEjVppheqNtTxP3wVhee
 Cq2Xcv2YunzVWkKQxAFeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i+q7wgukhGI=:hAYBMVpmzTf21WTcB2Uo8d
 SE8vsx5QtOqSLm0RGLMC9viuXtBIxbGOo4acZklAwu8VKkm+1wQue6ob4EfieJT3Serj3i1eJ
 2EWavQrC5SidOuJ2wezW9Vog2cVvwK9gGA7j2uTlUT9VKfIUIqUHRLQgPSyiPJ9RthbHrTNA+
 UJII0fQOnRmaIf8ME7SDrv/uKAc9bWemdRJjhiApRBgAI4R5MswRh++j5fSmIBIZFWezZMkwB
 dfwbgwUd9zdNhRbMGnuf82pieob65vM6/ys2+SXVSHmOPjHjuocv8Z/FZQj7WWElVMc/pZqRm
 yObdctcoEk0bbNtOvwPcLe06ZfwsAnr7U4D2eG/WkWWl5BXCl0KBOMchlpPxYCxn5sx+46q0X
 qS9VoqfGk+ANKZ/vwXqbdk+Wk9KwSyV5qUNmeyFpNMbrRqDdb4V1aeBu1NB97tVa3Z/BKimsI
 Wgr9q8iMhvXzXs2AXh+QVhjMsr0Kpxfa/f8UtA8U6s5k4zjqCbxNxpmZKAjdM/YWdrROfo9/p
 uE5OtNhZFfG4FRiIndY11Er1KKu9HdMOzF5TthIZC1VnLQSBrXTNcnKVQdsQv+KcOoi2gh/jY
 dIve73lF6HP56mz3isR3T0fvdJirb5L7VnEySLCtY8qi3zBSE9lIN1zMSL5qw1PceXJsBBjva
 4/CjDYzyW9mjTQrv/4yTXlPVmkM5EcvtvxaC+zueNe7nQm9KnswQL++qcD2tx8rMadablC/Q8
 pgM50biUKpSLXo3zAew7dqKTlVJt+0djC7wuzzfocA7d6lZxkvCKWnys+rRY/Fytef32xMaC/
 OBds9no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Mon, 8 May 2017, Ramsay Jones wrote:

> Commit dddbad728c ("timestamp_t: a new data type for timestamps",
> 26-04-2017) introduced a new typedef 'timestamp_t', as a synonym for an
> unsigned long, which was used at the time to represent timestamps in
> git. A later commit 28f4aee3fb ("use uintmax_t for timestamps",
> 26-04-2017) changed the typedef to use an 'uintmax_t' for the timestamp
> representation type.
> 
> When building on a 32-bit Linux system, sparse complains that a constant
> (USTAR_MAX_MTIME) used to detect a 'far-future mtime' timestamp, is too
> large; 'warning: constant 077777777777UL is so big it is unsigned long
> long' on lines 335 and 338 of archive-tar.c. Note that both gcc and
> clang only issue a warning if this constant is used in a context that
> requires an 'unsigned long' (rather than an uintmax_t). (Since TIME_MAX
> is no longer equal to 0xFFFFFFFF, even on a 32-bit system, the macro
> USTAR_MAX_MTIME is set to 077777777777UL, which cannot be represented as
> an 'unsigned long' constant).
> 
> In order to suppress the warning, change the definition of the macro
> constant USTAR_MAX_MTIME to use an 'ULL' type suffix.
> 
> In a similar vein, on systems which use a 64-bit representation of the
> 'unsigned long' type, the USTAR_MAX_SIZE constant macro is defined with
> the value 077777777777ULL. Although this does not cause any warning
> messages to be issued, it would be more appropriate for this constant
> to use an 'UL' type suffix rather than 'ULL'.

	The reason for the current situation is that an earlier fix for
	the USTAR_MAX_MTIME constant was applied to the USTAR_MAX_SIZE
	constant by mistake.

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

With that addition to the commit message: ACK

Ciao,
Dscho
