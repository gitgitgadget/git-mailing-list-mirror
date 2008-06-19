From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Thu, 19 Jun 2008 18:09:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806191807120.6439@racer>
References: <alpine.LNX.1.00.0806182327090.19665@iabervon.org> <alpine.DEB.1.00.0806191510060.6439@racer> <alpine.LNX.1.00.0806191146210.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ng1-0007o0-Co
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759084AbYFSRKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYFSRKs
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:10:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:48727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759477AbYFSRKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 13:10:39 -0400
Received: (qmail invoked by alias); 19 Jun 2008 17:10:37 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp017) with SMTP; 19 Jun 2008 19:10:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kyMYGEKxkoH+yOFJok2WGxNbZ1UWoD2pqjxya4r
	CtANnU5N0RKVmi
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0806191146210.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85493>

Hi,

On Thu, 19 Jun 2008, Daniel Barkalow wrote:

> On Thu, 19 Jun 2008, Johannes Schindelin wrote:
> 
> > On Wed, 18 Jun 2008, Daniel Barkalow wrote:
> > 
> > > diff --git a/setup.c b/setup.c
> > > index d630e37..1643ee4 100644
> > > --- a/setup.c
> > > +++ b/setup.c
> > > @@ -292,7 +292,8 @@ void setup_work_tree(void)
> > >  	work_tree = get_git_work_tree();
> > >  	git_dir = get_git_dir();
> > >  	if (!is_absolute_path(git_dir))
> > 
> > I suspect it needs "work_tree &&" here.
> 
> I'm not clear on the semantics of !get_git_work_tree(); is a non-absolute 
> path for git_dir right then?

My reading was: if there is no work_tree, then a relative git_dir is just 
fine, since we are quite unlikely to jump around in the file system.

And your implementation of make_relative_path() is nice enough to a 
(work_tree ==) base == NULL, but would return the absolute path in that 
case.

Haven't had time to test anything, though.

Ciao,
Dscho
