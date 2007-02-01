From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Thu, 1 Feb 2007 13:48:00 +0100
Message-ID: <20070201124800.GA3863@moooo.ath.cx>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <87wt32ah2e.wl%cworth@cworth.org> <eprbaa$o0m$1@sea.gmane.org> <200702010844.34500.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 13:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCbMI-0005u5-B2
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 13:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbXBAMsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 07:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422844AbXBAMsG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 07:48:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:35962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422841AbXBAMsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 07:48:04 -0500
Received: (qmail invoked by alias); 01 Feb 2007 12:48:03 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp033) with SMTP; 01 Feb 2007 13:48:03 +0100
X-Authenticated: #5358227
Mail-Followup-To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200702010844.34500.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38348>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 2007 February 01 00:14, Jakub Narebski wrote:
> 
> > Although the fact that clone copies all branches and tags (I don't think
> > there is a way to clone only subset of branches), and that fetch is multi
> 
> There is, as long as you are willing to organise your branches in a consistent 
> way.  I keep all my branches with the prefix "ap/" then on another 
> development machine I just have
> 
>  pull = refs/heads/ap/*:refs/heads/up/ap/*
> 
> In my config.  This means I can make local branches that won't be grabbed 
> during the fetch, but still have branches automatically exported.
> 
> This actually highlights a weakness in the globbing.  There is no way, for 
> example, to grab only unprefixed branches because the glob is blind to path 
> dividers (as is usual).  What would be even better would be a two glob 
> symbols, one meaning "do cross separators", one meaning "don't".  I think 
> rsync solves it for it's include/exclude patterns with a double asterisk.  
> That is:
> 
>  rsync -av --exclude "foo/*/bar" src/ dest/
> 
> Would exclude anything called "bar" two levels under "foo/"; wheras
> 
>  rsync -av --exclude "foo/**/bar" src/ dest/
> 
> Would exclude anything called "bar" anywhere deeper than two levels 
> under "foo".
> 
> I haven't thought of a good way of applying this in git though, and I have a 
> feeling that it could just complicate things excessively.
fnmatch with FNM_PATHNAME disables * to match on / but it does not
support the ** syntax afaik.
