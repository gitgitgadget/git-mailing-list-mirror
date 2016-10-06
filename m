Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9332720986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966463AbcJFJUs (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:20:48 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:34984 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966445AbcJFJUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:20:46 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bs4r4-0004Ny-G9; Thu, 06 Oct 2016 11:20:42 +0200
Date:   Thu, 6 Oct 2016 11:20:41 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Thomas =?iso-8859-1?Q?B=E9tous?= <th.betous@gmail.com>
Cc:     git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
Subject: Re: Bug Report: "git submodule deinit" fails right after a clone
Message-ID: <20161006092040.GA38550@book.hvoigt.net>
References: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
 <20160914202907.GD7613@sandbox>
 <CAPOqYV+xsrLk7y1hJYHZFY8OfkxVRwPcZBdqhdgrhThqdZysQA@mail.gmail.com>
 <20161005133650.GB30930@book.hvoigt.net>
 <CAPOqYV+SR8=E24HR18ygJ-J-rV7=FedU+gGpq9mp+a7Mfk2LiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPOqYV+SR8=E24HR18ygJ-J-rV7=FedU+gGpq9mp+a7Mfk2LiQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

please also keep the mailinglist in the CC so everyone can read this.

On Thu, Oct 06, 2016 at 09:11:05AM +0200, Thomas Bétous wrote:
> On Wed, Oct 5, 2016 at 3:36 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> 
> >
> > My initial reaction is that this might be a problem with line endings. Did
> > you
> > check whether you get any diff when you do a 'git diff' after the clone?
> >
> > Maybe the variable 'core.autocrlf' is set to 'input' ? Have a look at 'git
> > help
> > config'
> 
> 
> When I do a 'git diff' right after the clone, nothing appears.
> Moreover my global setting for core.autocrlf is true. (This was configured
> on purpose as I work on Windows whereas the repositories are hosted on an
> UNIX server.)

So I guess the same applies to 'git status'?

> Nevertheless when I change core.autocrlf to 'input', the error disappears
> and I got the expected behavior for git submodule deinit...
> So I guess it is just a configuration problem but I do not understand why
> core.autocrlf should be set to 'input' to remove this error. Do you have
> any idea?

This is indeed strange. That's why I asked whether 'git diff' shows
anything. I was suspecting that the .gitmodules is somehow checked out
in UNIX format. And the fact that setting core.autocrlf to
'input' seems to fix it supports that.

I currently do not have access to a windows machine as the moment to
test this. Copying the windows mailing list maybe someone over there
can reproduce and help with the issue[1].

Cheers Heiko

[1] http://public-inbox.org/git/%3CCAPOqYV+xsrLk7y1hJYHZFY8OfkxVRwPcZBdqhdgrhThqdZysQA@mail.gmail.com%3E/
