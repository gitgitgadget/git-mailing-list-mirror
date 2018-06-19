Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2961F403
	for <e@80x24.org>; Tue, 19 Jun 2018 10:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937364AbeFSKgI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 06:36:08 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:46886 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757202AbeFSKgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 06:36:07 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fVDzZ-0007Jc-2t; Tue, 19 Jun 2018 12:36:05 +0200
Date:   Tue, 19 Jun 2018 12:36:32 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Message-ID: <20180619103632.GC10085@book.hvoigt.net>
References: <20180618111919.GA10085@book.hvoigt.net>
 <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
 <20180618181215.GB73085@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618181215.GB73085@google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 11:12:15AM -0700, Brandon Williams wrote:
> On 06/18, Duy Nguyen wrote:
> > This sounds like the submodule specific code in pathspec.c, which has
> > been replaced with something else in bw/pathspec-sans-the-index. If
> > you have time, try a version without those changes (e.g. v2.13 or
> > before) to see if it's a possible culprit.
> 
> I just tested this with v2.13 and saw the same issue.  I don't actually
> think this ever worked in the way you want it to Heiko.  Maybe git add
> needs to be taught to be more intelligent when trying to add a submodule
> which doesn't exist in the index.

That was also my guess, since my feeling is that this is a quite rare
use case. Adding submodules alone is not a daily thing, let alone
selecting different changes after 'git submodule add'.

I also think git could be more intelligent here.

Cheers Heiko
