X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 15:14:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 14:14:52 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4581573E.40803@op5.se>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34340>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GurMB-0001nj-O9 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 15:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932739AbWLNOOc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 09:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWLNOOc
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 09:14:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:38807 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932739AbWLNOOb
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 09:14:31 -0500
Received: (qmail invoked by alias); 14 Dec 2006 14:14:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 14 Dec 2006 15:14:30 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Andreas Ericsson wrote:

> Andy Parkins wrote:
> > Hello,
> > 
> > I've got a big repository.  I've got two computers.  One has the repository
> > up-to-date (164M after repack); one is behind (30M ish).
> > 
> > I used git-fetch to try and update; and the sync took HOURS.  I zipped the
> > .git directory and transferred that and it took about 15 minutes to
> > transfer.
> > 
> > Am I doing something wrong?  The git-fetch was done with a git+ssh:// URL.
> > The zip transfer with scp (so ssh shouldn't be a factor).
> > 
> 
> This seems to happen if your repository consists of many large binary files,
> especially many large binary files of several versions that do not deltify
> well against each other. Perhaps it's worth adding gzip compression detecion
> to git? I imagine more people than me are tracking gzipped/bzip2'ed content
> that pretty much never deltifies well against anything else.

Or we add something like the heuristics we discovered in another thread, 
where rename detection (which is related to delta candidate searching) is 
not started if the sizes differ drastically.

Ciao,
Dscho
