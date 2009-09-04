From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 4 Sep 2009 18:18:55 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909041750390.28290@iabervon.org>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>  <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>  <alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>  <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0909041429540.28290@iabervon.org> <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com> <alpine.DEB.1.00.0909042305390.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-101114757-1252102735=:28290"
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjh7Y-0001WI-EZ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 00:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934367AbZIDWSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 18:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934364AbZIDWSx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 18:18:53 -0400
Received: from iabervon.org ([66.92.72.58]:50306 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934350AbZIDWSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 18:18:53 -0400
Received: (qmail 29492 invoked by uid 1000); 4 Sep 2009 22:18:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 22:18:55 -0000
In-Reply-To: <alpine.DEB.1.00.0909042305390.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127770>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-101114757-1252102735=:28290
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 4 Sep 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 4 Sep 2009, Sverre Rabbelier wrote:
> 
> > On Fri, Sep 4, 2009 at 21:05, Daniel Barkalow<barkalow@iabervon.org> 
> > wrote:
> > > Some foreign vcses, including the only one I ever personally use, do 
> > > not have URLs, and require a bunch of options and paths to specify a 
> > > repository. I don't want to have to use:
> > >
> > >        url = p4://rsh:ssh+-q+-a+-x+-l+p4ssh+-q+-x+perforce+%2Fbin%2Ftrue//projects/foo/bar-1.0/...,//projects/foo/bar-1.1/...
> > 
> > Btw, doesn't p4 have these config files that you can download that 
> > contain the configuration? In that case 
> > 'p4://example.org/p4/main-development.configfile' would be very 
> > convenient.
> 
> If that's how p4 users initialize their working directories, then that is 
> the way to go.
> 
> And I cannot start to believe that the complicated way you described is 
> the common way to initialize p4 working directories, as that would tempt 
> the intelligence/enthusiasm of the average programmer.

Perforce is probably the single most popular system for git to import from 
because it is such a monumental pain to use for anything at all that it's 
easier to learn git, write a git importer, and use your git importer than 
it is to actually use Perforce directly.

Of course, it's not really beyond the average programmer to get a p4 
working directory, because whoever is running the server will have 
provided a file to copy and instructions on setting an environment 
variable. They don't know what the magic formula means; they just use it. 
And they only work on one branch until that branch is done with,
and then they throw away that working directory, get a new working 
directory, and never look at the other branch's history again (and 
certainly never track anything across branches). Also, they have p4 
experts who deal with merging branches so that stuff doesn't get lost when 
moving to a new branch. And the experts have scripts built into the 
release process that attempt to insure that things don't get lost. The 
reason that my helper can't have a single location for a repository is 
that the branches of a single project are strewn randomly about the 
namespace, and a proper git import needs to know what to stitch into a 
single repository.

For the matter of where the server is, Perforce supports just having a 
"server:port" value, but if the organization uses this, there's no 
authentication of users possible. Instead, organizations set up an ad hoc 
collection of ssh proxies and give people a string which is the command to 
go through those proxies, because Perforce only knows how to use rsh or a 
command you provide that acts like rsh.

	-Daniel
*This .sig left intentionally blank*
--1547844168-101114757-1252102735=:28290--
