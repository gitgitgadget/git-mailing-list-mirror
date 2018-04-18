Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CC21F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeDRVIB (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:08:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:54889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeDRVH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:07:58 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfW5D-1eoLAy3JsJ-00P3ne; Wed, 18
 Apr 2018 23:07:35 +0200
Date:   Wed, 18 Apr 2018 23:07:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kim Gybels <kgybels@infogroep.be>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
In-Reply-To: <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804182251070.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180412210757.7792-1-kgybels@infogroep.be> <20180412210757.7792-2-kgybels@infogroep.be> <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L+eDum6xJZg0MWFAsTZWPGpzAP+TZGqUhgw43+jMiuTqw6aAZLi
 96Lb1HU7xxEqd7lghOurWLej1dodtKRhFKDUW+cMxpOTjZGYM5ge2XGcOBxt89AONpz1+HD
 6Fg9twTxc2LHzXo6FZvwOsjGDGi32H70muDRL1SEX6pqugOPWsNjcw2KHeRHYd7qsIJgYnU
 G8mN09SkP57mEG2YD46Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O6wELi5Uoxk=:1MOdkI9a+x98wP1HVz3zMb
 tfp+fVvFd3Rwzn/mUeOvXqecXmfTPKCE1X0kfB9DZBOhrfFQ0N1C0qKWKWeBk3YjfKJ2slrpY
 tv7Vi+o/bKmpYXITSW6x+FAwcWSgBGN2dM/45imga6uDZNPXWUgxU5gw4+7RbBLtSCKSRdJIG
 mLBDGNjMISws22e2IBmwiILZnAd2Y66S3MfvnRsEg8EjzyXujxNyM+qnTh2dWpFc8hoD6AEFK
 p6/5320dqNr65ZhmmirAalZ5x2L8v1UQvdxN4I3f1TCaMHENJ87HSeJXovn1wNPARYxN15OLB
 pzrfDiXaaRQN3eTW4DoYclIQBNFahj9hJYE8/vj0YpDPQ7VGHlMpIeQU7STxMXSQ4LfPcxWw5
 euOduKTsrLuGIq5bIu9YWz5Aag1qfLgxYTLzYKCsKSZgUy6aOfT+lW4erG4o74CQnwdYXQQ7H
 pZdiuz108xfr9kIyNxvRVrnQLf56dR5L+7DX0Dhi574xbavWigbUFq+nhsT6DnmUHsw/gQIez
 kIhYCpG/CMMJBQ7+y9Im8Gq2D/+sWGAXGfMPKNgk4gjL1d6z1XeJiEiJwdlCFIuM1LlXLSOKL
 MyUtAJtjKK30+B9uMEaMM+/yDk7qaza3VoFbRe2wNkzvp1UJO3GXdd6q+K2fyNu4zh7fM7zTA
 4EfoeG4JML7TJKTQ4//yiBEgwBfa2wQtVTlwDoHeYuuJ0LvuwXnpHhyBfGGuZfAQ37VUmdKnU
 EUjtvHsmqA+qf6BxgQ5wEw04gWXtOADOZkkSaT2cVSELqIgF3IXf2zbynVPJR0biq4GMw0Je/
 k6392e6DEltEhYr4kAXZBSFxThSE6hw6UvCM94RtElzE52QcVY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Apr 2018, Junio C Hamano wrote:

> Kim Gybels <kgybels@infogroep.be> writes:
> 
> > The poll provided in compat/poll.c is not interrupted by receiving
> > SIGCHLD. Use a timeout for cleaning up dead children in a timely manner.
> 
> I think you identified the problem and diagnosed it correctly, but I
> find that the change proposed here introduces a severe layering
> violation.  The code is still calling what is called poll(), which
> should not have such a broken semantics.

While I have sympathy for your desire to apply pure POSIX functionality,
the reality is that we do not have this luxury. Not if we want to support
Git on the still most prevalent development platform: Windows. On Windows,
you simply do not have that poll() that you are looking for.

In particular, there is no signal handling of the type you seem to want to
require.

As to the layering violation you mention, first a HN quote, just to loosen
the mood, and to at least partially ease the blow delivered by your mail:

	There is no such thing as a layering violation. You should be
	immediately suspicious of anyone who claims that there are such
	things.

;-)

Seriously again. If you care to have a look at the patch, you will see
that the loop (which will now benefit from Kim's timeout on platforms
without POSIX signal handling) *already* contains that call to
reap_dead_children().

In other words, you scolded Kim for something that this patch did not
introduce, but which was already there.

Unless I am misunderstanding violently what you say, that is, in which
case I would like to ask for a clarification why this patch (which does
not change a thing unless NO_POLL is defined!) must be rejected, and while
at it, I would like to ask you how introducing a layer of indirection with
a full new function that is at least moderately misleading (as it would be
named xpoll() despite your desire that it should do things that poll()
does *not* do) would be preferable to this here patch that changes but a
few lines to introduce a regular heartbeat check for platforms that
require it?

Thank you,
Dscho
