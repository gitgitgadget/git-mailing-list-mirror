Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9762027C
	for <e@80x24.org>; Tue, 30 May 2017 15:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbdE3PJE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:09:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:57822 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbdE3PJD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 11:09:03 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX16a-1dRwbr3VKu-00VyLC; Tue, 30
 May 2017 17:08:47 +0200
Date:   Tue, 30 May 2017 17:08:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: revision API design, was Re: [PATCH v4 02/10] rebase -i: generate
 the script via rebase--helper
In-Reply-To: <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705301700440.3610@virtualbox>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de> <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de> <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1705291252080.3610@virtualbox> <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ntTKEr8DcGDdWzaAKR2hR70ii3UQMs7Xx0pXipuBZpKNRI1KsHd
 E3TdwB4irSzmVJ0GO+bWJAhNzo/fkrKSe8q/JVWVoCZ9Gp0u1d3jBoAZDfFKCUAE2DL0k5f
 VAgZmkK7S2ndjaQa/6DndMYE16C20SguW+oVCguwgX0L4/Zn8w/mO/INkt/V+HYRWCxQTZy
 V8hRK1YpE31lrwvWUd0Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X4NmRDjOMZA=:eh7jAYWptA8WHisJZNaU9a
 jBiWOhzOyKChBikVEkHAPA1PEBckOabhW9EomzsRz/b6xjjyLVNinGhW9JQxDmjCTktSSZqwr
 U0Emd7YYl4jWC5i4IRqiCWk30TWZ8tqL6BLU0tB2jOtLqX0lN2DINtc3P9IoINGfp6NEDBw24
 E7vh1lHrH4Ynh2wUePWkm0pUvN5FkchcWp5KtRDv1M1vYgXygmYkCnwiXiMh6g3C47HcYJB6L
 R1+D9L8277cbmrK9ViD7f/2xUeccV2WJLsTA93vOvT9j12Jokq7vl4Tui9/Cl9kNmhkOEUHgL
 Xm0zsMT591PRN1jayiQTMS098NZ1S2MydTeXcVSoXEIebWQB76MQU8Fo6xi5/djHuTn+/za8U
 cxKvj654T5esvKYOAph+kJlTNPxXJL7PyI+vIuuKo/u79ZycufsBo2kd6hwpEq3tQcRzOLL+B
 XIoSqpY88yWXm/3pAp83t3Qq20Y6UrCSlaAw74tLEpKizSWv3zc2R1ICdd8HQ6zxjg+70Y28S
 Rj7K1Ls46lSRajkSiJ29ZT5H78Itl0yHaoeAB668iCGa9vxfRIS9nYfXL13qFrO9IRhx7AFI9
 LG5+gl1lQkzAyWe7l5OXzeVbYa4Rr6nCz7fAHOK8uSdX4FD0ZzKdrKR3TBzdOv4hjXfNZ3+bK
 BVcjKxpqXXQ9LUuhrOIbN8YRPe0Q6VM5zkxD3SAAfyrQzDv55eAUTVrxMlGM6yLPCpSnIFhCR
 nMnwwvmCMW0vgl12cPVoGAHg1lMdtBDFvtMP41sPnK8MonlnPgiSWHbhwDNB+KqDFbcuIFMG/
 qB8oyEm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 May 2017, Junio C Hamano wrote:

> We do not want these [revision API] implementation details to code that
> does not implement command line parsing.  This one is not parsing
> anybody's set of options and should not be mucking with the low level
> implementation details.

Just to make sure we are on the same level: you want the argc & argv to be
the free-form API of setup_revisions(), rather than code setting fields
in struct rev_info whose names can be verified at compile time, and whose
names also suggest their intended use.

I am still flabberghasted that any seasoned software developer sincerely
would suggest this.

> See 66b2ed09 ("Fix "log" family not to be too agressive about
> showing notes", 2010-01-20) and poinder.  Back then, nobody outside
> builtin/log.c and revision.c (these are the two primary things that
> implement command line parsing; "log.c" needs access to the low
> level details because it wants to establish custom default that is
> applied before it reads options given by the end-user) mucked
> directly with verbose_header, which allowed the addition of
> "pretty_given" to be limited only to these places that actually do
> the parsing.  If the above patch to sequencer.c existed before
> 66b2ed09, it would have required unnecessary change to tweak
> "pretty_given" in there too when 66b2ed09 was done.  That is forcing
> a totally unnecesary work.  And there is no reason to expect that
> the kind of change 66b2ed09 made to the general command line parsing
> will not happen in the future.  Adding more code like the above that
> knows the implementation detail is unwarranted, when you can just
> ask the existing command line parser to set them for you.

This is a very eloquent description of a problem with the API.

The correct suggestion would be to fix the API, of course. Not to declare
an interface intended for command-line parsing the internal API.

Maybe the introduction of `pretty_given` was a strong hint at a design
flaw to begin with, pointing to the fact that user_format is a singleton
(yes, really, you can't have two different user_formats in the same Git
process, what were we thinking)?

Ciao,
Dscho
