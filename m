Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D3F1FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965187AbcLVR7V (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:59:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:57526 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965052AbcLVR7V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:59:21 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsD9n-1ciIIR1ynf-013zGN; Thu, 22
 Dec 2016 18:59:12 +0100
Date:   Thu, 22 Dec 2016 18:59:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/3] Really fix the isatty() problem on Windows
In-Reply-To: <xmqqd1gjhn0u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612221852320.155951@virtualbox>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>        <cover.1482426497.git.johannes.schindelin@gmx.de> <xmqqd1gjhn0u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JWg8ZBrno86YfTC1Flrue9KoB5sxQQRg7Z43ovdBHw9deKFEzwN
 DHQ3puj5idHbl5x65WQoDriTI4/Z+02/23jkL5JYh3ojTHaqiDBH3GQINEpMnnICdHybG0t
 sxAQMq9uWznFzIKws3SrstWElDmqgmBweQGL4z4oELrkgw9itfHxmjQbaUMq07L/2aj5E9/
 Xxww+eQZ9U+tImq7XdP3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SLcXZV7L/DU=:jSEOsYfYvQQbzossruCKxy
 LmBrYDrsRmB2blPANnwFa34n3EmT5zEj4n0tzxrtE14nyqgPHGYg8PiJdA2s2iPnGbYQuvOEK
 AroTyihm9SOeNoHFZiXLwX58TXMs59VOrzdeFGZGT22dZnCLcDDomVrW+yFdHWCIglMfPjFU3
 Jxktp90e1iGWCYRvhCGnZGTj+ybMXBQcewH4+3P91MCTd+A6XveyCuqHpdn4F+6j/4lfYYhtv
 PHtQ737yOAjP6PkgPfohsHgRrfMvm2c2+7cEJaxjs651SYcda1oGOb9czby7R2uzRAyjEol3I
 aVqlFRC8/00M3bfbzBepC4HzE6YP0wFh0hKa1vKpa2HFdDdNnMJunO/9KAfLUD78RV7HMGKd0
 DmZn5RZJa/CQTlnilJXkI2Y0/fi2Z1rbMYZLAPgjjBWwAP9Nnvj+T/y6kvnm3yvlHWhx2L7eF
 pF5Egx/T8avUfvvcNwE9XeW8uBYKfjN7W1L0tj4eEzEOLPGAchw8eGAzg478sPdKKGrIq7xhC
 Cs2iRnixd9LfMNQfP1dvYEoQuUNPFlQ+iFLirwEQPLFAILdIrV3oL0Hun46mMsr3KpXSqSqoJ
 El0RuYqE60Y7dyNkhBoZ6zBZ5HpMWJ9wsjIvvheBy86Z8ZXpK/v3f5VGM0KR6kTAWPK5se7Kk
 7J6sA22zsnA+VaaN7+cDXEIAr9Rl6QYZIU7BI/eLNIpwN75BbykoRZ2b3KLKATReOXg5mHA7o
 miWQaviHSl7h+H4+463N9cpubkM+q6TiPpxViwK7U0VtxR6+jFHuSlffJyu3C4lDi9T9FtAxC
 YOANv8/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 22 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > - unsquashed 2/3 which was improperly snuck in before,
> 
> As Windows specific changes, I didn't notice these two were independent.

Yeah, sorry, I only realized today that I had snuck that one in when
re-reviewing the changes.

> > - fixed the confusing commit message by using Junio's suggested
> >   replacement
> 
> Sorry, but I didn't mean to "suggest replacement".  I was just
> testing my understanding by attempt to rephrase the gist of it.

I did like your phrasing, though.

> There was one thing I still wasn't clear in my "summary of my
> understanding".  Is the "replacement originally done for compiling
> with VC++" a solution that still peeks into MSVC runtime internals
> but is usable with both old and more recent one?  Or is it a more
> kosher approach that does not play with the internals to make it
> unlikely that it would have to change again in the future?

Oh, it is kosher. There is no more messing with internals.

> Your "use this opportunity to actually clean up" above suggests that
> the answer is the latter, but if you took my "summary of my
> understanding", it is likely that that fact is not captured in the
> resulting log message.

Right... I tried to make that clear by saying that this change replaces
the hack.

> The interdiff obviously looks good.  Let's move this series forward.
> I'll see if it can be merged down to 'maint', too, but it probably
> would not matter that much.

I will have to release a new Git for Windows version Real Soon Now [*1*],
so I will have to take those patches kind of there (as Git for Windows
will be based on upstream/maint for a while now).

My thinking is that I will publish a prerelease either tonight or
tomorrow, then go offline until next year, and then immediately publish
Git for Windows v2.11.0(2) (or v2.11.1 if you publish a bugfix version in
the meantime).

Ciao,
Dscho

Footnote *1*: There is a new cURL version with some security fixes,
although I do not think they are super-critical, then there is the fix for
the double slashes in //server/share/directory, the fix for the empty
credentials and I should probably also try to update the MSYS2 runtime to
the newest version of Cygwin's runtime. Lots of stuff.
