From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Create a debugging tool "jgit rebuild-commitgraph"
Date: Fri, 13 Mar 2009 07:52:51 -0700
Message-ID: <20090313145250.GD22920@spearce.org>
References: <1236954901-30990-1-git-send-email-spearce@spearce.org> <alpine.DEB.1.00.0903131549200.6288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 15:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li8mD-0004Lw-NH
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 15:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbZCMOwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbZCMOwx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 10:52:53 -0400
Received: from george.spearce.org ([209.20.77.23]:33609 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbZCMOww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 10:52:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1948938211; Fri, 13 Mar 2009 14:52:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903131549200.6288@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113194>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 13 Mar 2009, Shawn O. Pearce wrote:
> 
> > This is a command line tool which can be used to import only
> > the commit graph of another Git repository, to help debug a
> > topology related bug, without actually needing a clone of the
> > problematic repository.
> > 
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> > 
> >  I used this yesterday to obtain a DAG from someone's private
> >  repository and recreate the same structure on my own system,
> >  to debug why RevWalk was busted in their case.
> 
> Heh:
> 
> http://repo.or.cz/w/git/dscho.git?a=blob;f=my-fake-history.sh;h=e108ce99a5ebd75230c3cfc56b88d9769fec8bc1;hb=master

Heh.  I knew both you and Nico have written something like this in
the past, but I couldn't find it.

Your script is almost what I needed.  But I also needed to force
GIT_COMMITTER_DATE to match the timestamp, as I suspected the commit
times had something to do with the problem I was seeing.

I also whack the entire ref space to match the source repository,
which mattered because I was trying to debug:

  git rev-list $insha1 --not --all

in JGit...

-- 
Shawn.
