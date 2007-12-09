From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn branch naming question
Date: Sat, 8 Dec 2007 18:26:24 -0800
Message-ID: <20071209022624.GA31033@soma>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org> <20071209020510.GM3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1BsU-0005K1-QG
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXLIC00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbXLIC0Z
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:26:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50218 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbXLIC0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:26:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A5FD27DC025;
	Sat,  8 Dec 2007 18:26:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071209020510.GM3199@genesis.frugalware.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67588>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Dec 09, 2007 at 12:52:48AM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> > >   [svn-remote "svn"]
> > >         url = https://url/to/your/svn/repo
> > >         fetch = trunk:refs/heads/trunk
> > >         branches = branches/*:refs/heads/*
> > >         tags = tags/*:refs/heads/tags/*
> > > 
> > > but I advice you to not do this. refs/remotes has a special meaning in git,
> > > e.g.  you can't commit directly to it (which makes sense, because it only
> > > tracks the state of the remote repo. On the other hand remote branches won't
> > > get cloned per default.)
> > 
> > yes, that's exactly what i want to do - in case the target is to convert
> > an svn repo to a git one (and i need git-svn since git-svnimport is to
> > be removed in 1.5.4)
> 
> hm, this seem to be not-working for me.
> 
> after "git svn init -s url" i edited the config:
> 
> $ cat .git/config
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [svn-remote "svn"]
>         url = svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build
>         fetch = trunk:refs/master
>         branches = branches/*:refs/*
>         tags = tags/*:refs/tags/*
> 
> and wanted to fetch the revisions, but actually
> 
> $ git svn fetch
> 
> does not fetch any revisions. (yes, it does once i put back the
> "remotes" prefix). is this a bug? :)

I'm not sure if it's considered a "bug", but that's just the
way it is at the moment.  I can't remember why, but I did
make git-svn force the presence of the "remotes/" prefix
in all refs it writes to...

-- 
Eric Wong
