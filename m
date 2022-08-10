Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D8BC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiHJJ31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiHJJ30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:29:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CF6B659
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660123755;
        bh=q4gCMbrQCqT/z1RUiEuA/ktNx6zcznBvLi2ZfoZiLBY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Iu438rY5pSJST3JAuIAdK/oS3iZq64MkGzVx/Zu+eEY1AVoDuu8uTfg9LQPb5RzXS
         xFx0ajVtG65YdnPQ4py6Rrb/R1TBy50bNNmgk5lq0v3ws1Zat6dPgk0wt0OnrhO7sV
         kO3sYo8wBQiHnvxTEWdwvsbZ33VDnq9mzLQfWmV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1nRviC1r4N-00yPn7; Wed, 10
 Aug 2022 11:29:15 +0200
Date:   Wed, 10 Aug 2022 11:29:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: include the Python parts in the build
In-Reply-To: <c9aec5b6-0a78-a580-3658-5189bd2075a6@kdbg.org>
Message-ID: <1587qsq1-3q77-054o-oqr7-24np360oqn21@tzk.qr>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com> <xmqqczdpcfhx.fsf@gitster.g> <0s3o2pr2-o0q3-q394-83n3-n117355o8o29@tzk.qr> <c9aec5b6-0a78-a580-3658-5189bd2075a6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TAEEVv4CZTyWT7KJYNqKmmEURGjAvxDo7Y8U+uuOJSlfO2E1s9D
 0pYtIeuLzA0liFoRaK6Sa4RzdN6kZiIJpiyCK1gtkRWF/QNlVlRgVmSugOcrY4lrxd5qyMU
 xOnGw/eceu1CfxpjZwjHSuewaAU/9gie7oZClGXPfHCfSBS/2WwJjPch++KDV/VaeNyHKNU
 EfReGFXoYo63rO2KdOYaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9V0u7jq8HzU=:tqeXVWIU0oJn6gmOO4LI3Z
 5x3LEOxPlJs9XqNE1iY4eByQqU6vVPJk7cEHNVacrhyS1pv4TswYkqaD4fiPLPh4crA5AIpe+
 yvDyeeAaD0UUE0o6oDqn9uRoE1hrZwQ4LZmZUThVLXJ1uVoG+D8wT0kXPli2MGXwrNenAkQtr
 m2BckBb/1aBniS93XhnapZS4XmOQCrqplzWDd7o7Ww4qmSMzFDWDs5GrAny+rK15m7aRhoORI
 7THoXhvZ12L6oCWiyI4pOjhS9sjqvvDnP3ds4jhdp/3i6Oca5AkHdriGSXRbrDKpY+4DMrNlh
 AJieCnQ3ta9HdG1HXgmomrZ8czzlnS17NqeyRduuztbPpOKKGA6e0+/HsuD7pN/Y5twdvqEYB
 Le1w6C4CYEyPkRspywlCssGKdjGu8DnWMybp5VVMfjRTZ5GxG3p6m5gP9TqGYOV4pb3w55vNU
 tqW/Z1wF4kwA0/4BBYU0nyxTBJVbWWLIDZCa7QhozIJrHgi0yCf7xc9rwn65x+gOxqVNFdzQh
 NoQ7gkhhQx8X3r5X95lqAthQhB5gPB4sjOP8A1Sd6qe6Jnlba8RupRUwHyrUQCCkwKlF3YkSG
 QkEkegcNb1cN1TXyuSxqUWsYwqmWUF1+70DL6bCTbHnxy0FLvWS/shAoGZ9lyw/alzcDJq+RP
 OXjdzOAfQoGIBbUesEJqrqBJu++uZcbCnPsM0rjFVjqWCXwM4e36fGIvXtrFBwHlw79PkVJDP
 9Vb4h3AOs9Y93jyr+Ul40yAy+V27Xs7qVnwDOohXj+xWbjbqWBM1X+hX9YnHzzLsFXYcqH1xO
 iZmAKbVbDRAbcVUfrsNfW4fm93tM9bPlQeNyBPQplshOEVSnPA9RJkcAeuWijxtZ1XdNURIsb
 wce/CtemiLXA+Ra0LXNPBV7Zf7Tji/e3/KGLcZxBpyiHE7aSBaH3BPyQW+c5B5btdj6gQ9oIW
 X3dw0+0l5enP3wjv1mQWyffJPUEtYGhQrkL9e5TCBXVn44NyyBuy+JxGNujKGg8NJAZrGT319
 lvi/EW4d8bvrtL5UaALul+bZDQwwiZwkxI39m5nQ85BKAicTIWbB0TU9DFVAk+j8RJPwUwsD7
 JO92VbtEHFJUIrumbmLB5JsFupnlKWMhCiXQScLno+j1JULmTxpmLnoqg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Fri, 29 Jul 2022, Johannes Sixt wrote:

> Am 29.07.22 um 16:29 schrieb Johannes Schindelin:
> > Now, I vaguely remember that j6t said that they switched to MSYS2 some
> > time ago, but all I found on the Git mailing list was
> > https://lore.kernel.org/git/6c2bbca7-7a8f-d3d8-04b6-31494a3e1b43@kdbg.=
org/
> > which says that in 2017, MSys1 was still used by the person who apart =
from
> > myself did the most crucial work to support Git on Windows (and that
> > counts a lot in my book, so in this instance I am willing to bear a bi=
t
> > more maintenance burden than I otherwise would for a single person, ev=
en
> > if the Windows-specific part of `config.mak.uname` is quite messy, I
> > admit).
> >
> > Hannes, do you still build with MSys1?
>
> Thank you for keeping me in the loop. No, I have long since switched to
> the Git for Windows tool set, i.e., MSYS2 + MinGW64. I don't know if
> anybody is still using MSys1 + MinGW. There's likely no reason to keep
> the MSys1 config section.

Excellent. I've added a #leftoverbits ticket here:
https://github.com/gitgitgadget/git/issues/1319

Ciao,
Dscho
