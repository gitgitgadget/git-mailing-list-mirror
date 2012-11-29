From: Daniel Shahaf <danielsh@elego.de>
Subject: Re: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 15:42:03 +0200
Message-ID: <20121129134203.GJ3424@lp-shahaf.local>
References: <20121129055946.2D7B84065F@snark.thyrsus.com> <20121129075829.GE3424@lp-shahaf.local> <20121129114637.GB9264@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 14:43:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te4OS-0006WR-W0
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 14:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab2K2Nmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 08:42:53 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:51925 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab2K2Nmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 08:42:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 0774BDE065;
	Thu, 29 Nov 2012 14:42:36 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hyZQyuGEjzh; Thu, 29 Nov 2012 14:42:35 +0100 (CET)
Received: from lp-shahaf.local (bzq-109-65-228-49.red.bezeqint.net [109.65.228.49])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 81CB6DE063;
	Thu, 29 Nov 2012 14:42:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121129114637.GB9264@thyrsus.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210831>

(note, other half of the thread is on dev@svn only..)

Eric S. Raymond wrote on Thu, Nov 29, 2012 at 06:46:37 -0500:
> Daniel Shahaf <danielsh@elego.de>:
> > You might also seek community consensus to reserve an svn:foo name for
> > the "original author" property --- perhaps svn:original-author --- so
> > that reposurgeon and other git->svn tools can interoperate in the way
> > they transfer the "original author" information.
> 
> OK.  But I like the idea of letting the users set their own author
> content string better.  Instead of another layer of kluges, why

I don't see the kludge here --- git has a "author" != "committer"
distinction, svn doesn't, so if you want to grow that distinction the
most natural way is a new property.  Storing additional information in
svn:author is a separate issue.

> > >   Subversion has a concept of "flows"; that is, named segments of
> > >   history corresponding to files or directories that are created when
> > >   the path is added, cloned when the path is copied, and deleted when
> > >   the path is deleted. This information is not preserved in import
> > >   streams or the internal representation that reposurgeon uses.  Thus,
> > >   after editing, the flow boundaries of a Subversion history may be
> > >   arbitrarily changed.
> > > 
> > > This is me being obsessive about documenting the details.  I think it
> > > is doubtful that most Subversion users even know flows exist.
> > 
> > I think you're saying that adds might turn into copies, and vice-versa.
> > That is something users would notice --- it is certainly exposed in the
> > UI --- even though node-id's are not exposed to clients.
> 
> I'm saying nobody thinks of flows when they do branch copies.  It's
> not just that users don't see node IDs, it's that no part of most users'
> mental model of how Subversion works resembles them.

I'm still not sure what you have in mind.  I note that 'svn log' and
'svn blame' cross both file copies and branch creation --- that's one
effect of "'svn cp foo bar; svn ci' causes bar to be related to foo".

> -- 
> 		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
