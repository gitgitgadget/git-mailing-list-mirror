Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0E11F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbcJENg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:36:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:57761 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbcJENg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:36:57 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brmNQ-0001Jk-Bg; Wed, 05 Oct 2016 15:36:52 +0200
Date:   Wed, 5 Oct 2016 15:36:50 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Thomas =?iso-8859-1?Q?B=E9tous?= <th.betous@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report: "git submodule deinit" fails right after a clone
Message-ID: <20161005133650.GB30930@book.hvoigt.net>
References: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
 <20160914202907.GD7613@sandbox>
 <CAPOqYV+xsrLk7y1hJYHZFY8OfkxVRwPcZBdqhdgrhThqdZysQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPOqYV+xsrLk7y1hJYHZFY8OfkxVRwPcZBdqhdgrhThqdZysQA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

please do not top-post the conversation will otherwise get hard to
follow. Thank you.

On Tue, Oct 04, 2016 at 05:46:45PM +0200, Thomas Bétous wrote:
> Thank you for your answer and sorry for the delay (I was on vacation...).
> 
> I am using git 2.9.0.windows.1 (run on Windows 7 via git bash).

My initial reaction is that this might be a problem with line endings. Did you
check whether you get any diff when you do a 'git diff' after the clone?

Maybe the variable 'core.autocrlf' is set to 'input' ? Have a look at 'git help
config'

> I tested it on this repo:
> https://github.com/githubtraining/example-dependency.git
> The same problem occurs.
> Here a small script to reproduce the error on my PC:
> #!/bin/bash
> git clone https://github.com/githubtraining/example-dependency.git
> cd example-dependency
> git submodule deinit js
> 
> It ends with this error:
> fatal: Please stage your changes to .gitmodules or stash them to proceed
> Submodule work tree 'js' contains local modifications; use '-f' to discard them

Here I get

$ git submodule deinit js
Cleared directory 'js'

So all seems fine.

> Is the script working on your PC?

Yes. I am on Mac OS X though.

Cheers Heiko
