From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Mon, 12 Jan 2009 14:38:09 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901121413040.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org> <7vfxjpmhow.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0901120041260.19665@iabervon.org> <20090112154224.GD10179@spearce.org> <alpine.LNX.1.00.0901121246320.19665@iabervon.org>
 <alpine.DEB.1.00.0901122007070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:39:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSdM-0007pZ-SQ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 20:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZALTiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 14:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZALTiM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:38:12 -0500
Received: from iabervon.org ([66.92.72.58]:33071 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbZALTiL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 14:38:11 -0500
Received: (qmail 11771 invoked by uid 1000); 12 Jan 2009 19:38:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 19:38:09 -0000
In-Reply-To: <alpine.DEB.1.00.0901122007070.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105375>

On Mon, 12 Jan 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 12 Jan 2009, Daniel Barkalow wrote:
> 
> > Maybe fast-import should be able to run with a bi-directional connection 
> > to its input, so it can acknowledge checkpoints?
> 
> Whoa.
> 
> fast-import was first and foremost a very simple way to get stuff done.  
> Is it absolutely necessary to complicate that?
> 
> I mean, I don't know about git-svn, but shouldn't it be 
> relatively easy to use fast-import to import from Subversion once the 
> information is extracted from Subversion?

I assume that git-svn's problem is that it would need to store too much of 
the information (rather than being able to discard it) if it couldn't get 
the information back from the git object database.

Actually, I think it might be actually simplify programs using fast-import 
if they could ask it for data from before, and I think that would have to 
be necessary in order to have a reasonable non-git-specific incremental 
importer without duplicating the storage of a lot of information that 
previously went into fast-import.

I know I found it helpful in my p4 one to be able to pick up the 
incremental state by looking at what refs exist and the information in 
commits they point to, rather than trying to get the information from the 
perforce client state or custom storage.

	-Daniel
*This .sig left intentionally blank*
