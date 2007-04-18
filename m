From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: don't allow globs to match regular files
Date: Wed, 18 Apr 2007 00:53:54 -0700
Message-ID: <20070418075353.GA2758@hand.yhbt.net>
References: <20070418071733.GA10627@muzzle> <7v3b2yjfcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He4zG-00055W-HG
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 09:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbXDRHxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 03:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932985AbXDRHxz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 03:53:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55362 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975AbXDRHxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 03:53:54 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 3CC332DC01A; Wed, 18 Apr 2007 00:53:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v3b2yjfcw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44870>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > git only tracks the histories of full directories, not
> > that of individual files.  Sometimes, SVN users will
> > place[1] a regular file in the directory designated
> > for subdirectories of branches or tags.
> >
> > Thanks to jrockway on #git for pointing this out.
> >
> > [1] mistakenly or otherwise, such as a README
> 
> It is not clear what this "glob" means to me.  Enlightenment?

Basically I can define an [svn-remote] in the config much in the same
way that a native git [remote] is defined:

[svn-remote "svn"]
	url = svn://svn.debian.org/svn/pkg-glibc
	branches = glibc-package/branches/*:refs/remotes/*
	tags = glibc-package/tags/*:refs/remotes/tags/*

> My cursory reading of the code is that you are grabbing things
> under branches/ and tags/, expecting each of what you would find
> there is the whole-tree of a revision, and do not want to see
> any regular file immediately underneath branches/ and tags/.
> 
> Is that what is happening here?

Yes. 

-- 
Eric Wong
