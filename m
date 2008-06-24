From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] clone: create intermediate directories of destination
 repo
Date: Tue, 24 Jun 2008 11:20:07 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806241113360.19665@iabervon.org>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org> <20080623203835.GA8105@sigill.intra.peff.net> <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil>
 <20080624055022.GC19224@sigill.intra.peff.net> <7v3an3e0xv.fsf@gitster.siamese.dyndns.org> <20080624080437.GA2581@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, zuh@iki.fi,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBAKT-0007mo-RW
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 17:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbYFXPUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 11:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757791AbYFXPUN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 11:20:13 -0400
Received: from iabervon.org ([66.92.72.58]:47922 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886AbYFXPUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 11:20:11 -0400
Received: (qmail 7988 invoked by uid 1000); 24 Jun 2008 15:20:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2008 15:20:07 -0000
In-Reply-To: <20080624080437.GA2581@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86071>

On Tue, 24 Jun 2008, Jeff King wrote:

> On Tue, Jun 24, 2008 at 12:39:40AM -0700, Junio C Hamano wrote:
> 
> > > The shell version used to use "mkdir -p" to create the repo path, but
> > > the C version just calls "mkdir". Let's replicate the old behavior. In
> > > this case we can simply create the directories leading up to the git
> > > dir. If it's a bare repo, then that is everything that init_db wants
> > > ahead of time. If it isn't bare, then the worktree contains the git dir,
> > > so we create the worktree.
> > 
> > Clever ;-)
> 
> I am worried that it is too clever. I didn't see an obvious way for
> work_tree and git_dir to not have that property, but I think it is still
> worth somebody double-checking.

I think you can specify git_dir and work_tree on the command line, and set 
them to whatever you want, although I now don't remember whether they're 
actually both followed for clone (I tried to match the shell version, 
whose behavior didn't make too much sense to me).

	-Daniel
*This .sig left intentionally blank*
