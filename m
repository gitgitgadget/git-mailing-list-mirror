From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:03:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:04:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZx2V-00067Q-DB
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWJQWD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWJQWD4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:03:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750799AbWJQWDz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 18:03:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HM3aaX004082
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 15:03:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HM3YJh007651;
	Tue, 17 Oct 2006 15:03:35 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45354AD0.1020107@utoronto.ca>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29123>



On Tue, 17 Oct 2006, Aaron Bentley wrote:
> 
> >>Interesting.  We don't do 'fast-forward' in that case.
> > 
> > Fast-forward is a really good idea. Perhaps you could implement it,
> > if it is not hidden under different name?
> 
> We support it as 'pull', but merge doesn't do it automatically, because
> we'd rather have merge behave the same all the time, and because 'pull'
> throws away your local commit ordering.

Excuse me? What does that "throws away your local commit ordering" mean?

A fast-forward does no such thing. It leaves the local commit ordering 
alone, it just appends other things on top of it. It's the only sane thing 
you can do, since the work you merged was already based on your top 
commit.

So generating an extra "merge" commit would be actively wrong, and adds 
"history" that is not history at all.

It also means that if people merge back and forth from each other, you get 
into an endless loop of useless merge commits. What's the point? They only 
clutter up the history, and they mean that you can never agree on a common 
state.

There's no reason _ever_ to not just fast-forward if one repository is a 
strict superset of the other.

You must be doing something wrong. Is it just that people want to pee in 
the snow and leave their mark?

		Linus
