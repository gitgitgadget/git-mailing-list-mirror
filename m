Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A061FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 13:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbdA3MvZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 07:51:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:64240 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753504AbdA3MvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 07:51:12 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1cZpCd36jq-007BXb; Mon, 30
 Jan 2017 13:44:09 +0100
Date:   Mon, 30 Jan 2017 13:44:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
In-Reply-To: <xmqqd1f8z6lt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701301341020.3469@virtualbox>
References: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de> <xmqqd1f8z6lt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+/AFqZNQBKvfKg6NLonY+ktc/yAXTmlHB/GKTILvKZdzD0zlEQg
 irNt0h91kWjnhqMEdBXK2GwuGlWL0iLVuyiIhNgkXYCC0L5r3AjV2n1VzerIUFIu8fcNvst
 1HERwbkMZuZTcKesN4/jglfEZ5qVBXdfJ0BKY+QYmEXmU1Gm//Yig7l5tROYk62eoYUoQb/
 upKfHsGBI0YH7OKIJWtbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6XRaIyT7ZVM=:xUL1IziMgxCHFipD20tH0+
 eRrjo20C3M9r5Ff6pSudV5T82cws6JsxA6SCTV0dRI919qT29OF86N/eod0r4O8YvK4KzPTBw
 JTMziksfH4B1jgLF0je3cgYDjYOv7QKC4RQAHNWatNY0Wmn36yDOqeym4gJ8LLLi9e77WMOSZ
 Fg38nrO59gKKuvF1SuOnf910d6HFyAfKWLN9M/2g56xRM62c/J1v63sWkpeojjQEtSxR/ZOWW
 oGg9PhVjAQr1eTDLL0cZHWcT5TcdSJG0/+SJrZEGzx8EZCzHMFUmOdh6N0ifGMg8rFCqhvKPg
 qtDcdWdoZZO7qiZTic43wcK1z01iFGGIyP4glWMyq1bZNUqwejQuy113xgTW4+tR6lcVAl9l6
 aiDQTSogMEpgK56WDNI8GpQ0E6PbPcEfoTDmLL2xHotm+rL15tX7xU6AUSt2dFupXNgQI/sTa
 4oVz3er7xEm07LVvFXtjBa0bjQSLUOswv9WnUcToJskBUHC6TMjeCkHUgmhvhN0/pLhdOg7AE
 9b9vslZZ2l2FSs+MADJKaAD9Xc0Bw6eG3mxdHudCoTPeLr0qe7xiV1z+cDLJIauNLvmdIXMc/
 fzmZdjTZdIz9zd8J3AYXSs7qiwOOD3Lb1yqSLGRerbN+pEG7ykF9EFVpIgUVqVndPMuwYtU2g
 SOqiN2Abqwp2HyI7c0DBjlxpXzB2tdPJrEB/3/mgLmRE9ZW2c7IqNyB8+nEW3ifErYRIfEIuE
 Noizbuknio+1PtbjqqTO/xTeLNlXA+OZ4ZPjn23ZzsHFnetKqgOs7Lb1PsavTZ1VGNjEvPTir
 00j2WbJxjy9u/wkxjNuw1pn6VhvFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 27 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > From: Heiko Voigt <hvoigt@hvoigt.net>
> >
> > The previous implementation said that the filesystem information on
> > Windows is not reliable to determine whether a file is executable. To
> > gather this information it was peeking into the first two bytes of a
> > file to see whether it looks executable.
> >
> > Apart from the fact that on Windows executables are defined as such by
> > their extension (and Git has special code to support "executing"
> > scripts when they have a she-bang line) it leads to serious
> > performance problems: not only do we have to open many files now, it
> > gets even slower when a virus scanner is running.
> 
> Heiko, around here (before going into the details of how severe the
> problem is and how wonderful the result applying of this change is) is
> the best place to summarize the solution.  E.g.
> 
> 	Because the definition of "executable" on Windows is based
> 	on the file extension, update the function to declare that a
> 	file with ".exe" extension without opening and reading the
> 	early bytes from it.  This avoids serious performance issues.
> 
> I paraphrased the rest only so that the description of the solution
> (i.e. "instead of opening and peeking, we trust .exe suffix") fits well
> in the surrounding text; the important part is to say what the change
> does clearly.

I adjusted the commit message. It was tweaked a little differently from
what you suggested, as I preferred to condense the information a bit more.

> I agree with the reasoning and the execution of the patch, except
> that 
> 
>  - "correct behaviour" in the title makes it appear that this is a
>    correctness thing, but this is primarily a performance fix.

Primarily. But not only. The magic `MZ` without the file extension `.exe`
is pretty useless, as the file could not be executed, still.

To avoid further turnaround, though, I also edited the contentious
"correct" to read "improve" now.

>  - It is a bit strange that "MZ" is dropped in the same patch
>    without any mention.

I fixed that in the commit message.

Ciao,
Johannes
