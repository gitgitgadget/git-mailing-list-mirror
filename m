Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C88E202BB
	for <e@80x24.org>; Sat, 16 Mar 2019 20:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCPUXe (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 16:23:34 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:53473 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbfCPUXe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Mar 2019 16:23:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 121EF180AA0DD;
        Sat, 16 Mar 2019 20:23:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: book19_7633de3b84c09
X-Filterd-Recvd-Size: 2207
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Mar 2019 20:23:32 +0000 (UTC)
Message-ID: <2220d599992885eca1709f316a3e862c671301ff.camel@perches.com>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
From:   Joe Perches <joe@perches.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Sat, 16 Mar 2019 13:23:30 -0700
In-Reply-To: <87y35eziel.fsf@tarshish>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
         <8e28e622af4143b13a9bfa5c7a6df33d8baf1b5e.camel@perches.com>
         <87zhpuzjke.fsf@tarshish>
         <fc14d671d5c3ff43fc43095930d4c762fe6f5002.camel@perches.com>
         <87y35eziel.fsf@tarshish>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2019-03-16 at 22:14 +0200, Baruch Siach wrote:
> Hi Joe,

Hello Baruch.

> On Sat, Mar 16 2019, Joe Perches wrote:
> > So buildroot uses '+Signed-off-by:' and '-Signed-off-by:' lines
> > for some internal purpose?
> > 
> > Why?
> > 
> > https://buildroot.org/downloads/manual/manual.html
> > 
> > doesn't mention it.
> 
> No. Patches to the Buildroot project often add or remove patch
> files. See this one for example:
> 
>   http://lists.busybox.net/pipermail/buildroot/2019-March/244762.html
> 
> In this case 'git send-email' added Peter Korsgaard to cc because a
> patch file with his sign-off is removed.
> 
> (mbox) Adding cc: Baruch Siach <baruch@tkos.co.il> from line 'From: Baruch Siach <baruch@tkos.co.il>'
> (body) Adding cc: Petr Vorel <petr.vorel@gmail.com> from line 'Cc: Petr Vorel <petr.vorel@gmail.com>'
> (body) Adding cc: Baruch Siach <baruch@tkos.co.il> from line 'Signed-off-by: Baruch Siach <baruch@tkos.co.il>'
> (body) Adding cc: Peter Korsgaard <peter@korsgaard.com> from line '-Signed-off-by: Peter Korsgaard <peter@korsgaard.com>'

I see.

IMO git send-email should not really be adding -by: lines from
actual patch content but only from lines before any '^---'.


