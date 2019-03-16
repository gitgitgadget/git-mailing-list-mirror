Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3748C20248
	for <e@80x24.org>; Sat, 16 Mar 2019 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCPT76 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 15:59:58 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:43055 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726376AbfCPT76 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Mar 2019 15:59:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5744F18224D8D;
        Sat, 16 Mar 2019 19:59:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: use73_39b5cfeb31635
X-Filterd-Recvd-Size: 2496
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Mar 2019 19:59:56 +0000 (UTC)
Message-ID: <fc14d671d5c3ff43fc43095930d4c762fe6f5002.camel@perches.com>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
From:   Joe Perches <joe@perches.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Sat, 16 Mar 2019 12:59:55 -0700
In-Reply-To: <87zhpuzjke.fsf@tarshish>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
         <8e28e622af4143b13a9bfa5c7a6df33d8baf1b5e.camel@perches.com>
         <87zhpuzjke.fsf@tarshish>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2019-03-16 at 21:49 +0200, Baruch Siach wrote:
> Hi Joe,
> 
> On Sat, Mar 16 2019, Joe Perches wrote:
> > On Sat, 2019-03-16 at 21:26 +0200, Baruch Siach wrote:
> > > Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
> > > -by trailers") in git version 2.20, git send-email adds to cc list
> > > addresses from all *-by lines. As a side effect a line with
> > > '-Signed-off-by' is now also added to cc. This makes send-email pick
> > > lines from patches that remove patch files from the git repo. This is
> > > common in the Buildroot project that often removes (and adds) patch
> > > files that have 'Signed-off-by' in their patch description part.
> > 
> > Why is such a line used and why shouldn't an author
> > of a to-be-removed patch be cc'd?
> 
> These lines are currently used because the '^([a-z-]*-by)' regexp
> matches.

That part I already understood.

I am not a buildroot user.

> Buildroot is a tool that build various software packages. The patches
> being removed are usually for packages that Buildroot patches to fix the
> build. These patches are often pulled from upstream git repo of
> respective package. When the package version updates, the patch is
> dropped.
> 
> We don't cc patch authors when we add the patch in the first place,
> because the regexp does not match '+Signed-off-by'. I see not reason to
> cc them when we remove the patch.

So buildroot uses '+Signed-off-by:' and '-Signed-off-by:' lines
for some internal purpose?

Why?

https://buildroot.org/downloads/manual/manual.html

doesn't mention it.


