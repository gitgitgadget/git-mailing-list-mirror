From: Eric Wong <normalperson@yhbt.net>
Subject: Re: how to skip branches on git svn clone/fetch when there are
	errors
Date: Sat, 5 Sep 2009 18:48:38 -0700
Message-ID: <20090906014837.GD28829@dcvr.yhbt.net>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com> <20090905061657.GC22272@dcvr.yhbt.net> <1252140904.8992.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 03:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mk6sQ-0003j4-QH
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 03:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbZIFBsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 21:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbZIFBsg
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 21:48:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33219 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbZIFBsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 21:48:35 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147681F794;
	Sun,  6 Sep 2009 01:48:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1252140904.8992.6.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127831>

Daniele Segato <daniele.bilug@gmail.com> wrote:
> Il giorno ven, 04/09/2009 alle 23.16 -0700, Eric Wong ha scritto:
> > It's unfortunate, but there's not yet an exclude/ignore directive
> > when globbing.  You'll have to change your $GIT_CONFIG to only
> > have a list of branches you want, something like this:
> > 
> > [svn-remote "svn"]
> > 	url = svn://svn.mydomain.com
> > 	fetch = path/to/repo/HEAD/root:refs/remotes/svn/trunk
> > 
> > 	; have one "fetch" line for every branch except the one you want
> > 	fetch = path/to/repo/BRANCHES/a/root:refs/remotes/svn/a
> > 	fetch = path/to/repo/BRANCHES/b/root:refs/remotes/svn/b
> > 	fetch = path/to/repo/BRANCHES/c/root:refs/remotes/svn/c
> > 
> > 	; you can do the same for tags if you have the same problem
> > 	tags = path/to/repo/TAGS/*/root:refs/remotes/svn/tags/*
> > 
> > But you shouldn't have to worry about having "fetch" entries for
> > stale/old branches/tags you've already imported.
> 
> I see...
> That means that then I'll have to manually add new created branches,
> right?

Yes.

-- 
Eric Wong
