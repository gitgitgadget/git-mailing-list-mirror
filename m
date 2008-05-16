From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 15:24:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161521510.30431@racer>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>  <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>  <alpine.DEB.1.00.0805161457250.30431@racer> <32541b130805160712m24f24c6aw59b54a0f0ace6269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "skillzero@gmail.com" <skillzero@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 16:25:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0rq-000157-7j
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbYEPOYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbYEPOYO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:24:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:60026 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbYEPOYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:24:13 -0400
Received: (qmail invoked by alias); 16 May 2008 14:24:11 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp016) with SMTP; 16 May 2008 16:24:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EWt4YpnAEZtKeBwWjzwpKT/VEGtbBvWXRC7o8t7
	09LpvS0j+4HMIg
X-X-Sender: gene099@racer
In-Reply-To: <32541b130805160712m24f24c6aw59b54a0f0ace6269@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82295>

Hi,

On Fri, 16 May 2008, Avery Pennarun wrote:

> Think of it this way: I can commit, or not commit, my dirty Makefile at 
> the same time as everything else (in a single project) with a single 
> "git commit" line, depending on what I want to do.  Things like "git 
> commit -a" and "git add -u" speed up the common case where I just want 
> to commit everything.  But with submodules, that common case looks more 
> like this:
> 
>    cd sub
>    git checkout -b manual_branchname_because_there_was_no_default
>    git commit -a
>    git push etc.
>    cd ..
>    git commit -a
>    git push etc.

Funny, for me it looks completely different:

$ cd sub
# work, work, work
# from time to time commit
# from time to time rebase -i to clean up some things
# test, test, test
# sometimes push

And then, every once in a while, it is

$ cd ..
$ git add submodule
$ git commit -s submodule
$ git push

> That's *really* tedious, and the number of commands multiplies when you 
> have more than one submodule going at once.

But hey, if you find that tedious, why did I not see a patch from you yet, 
implementing "git submodule commit-n-push"?

Ciao,
Dscho
