From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 08/13] Add support for "import" helper command
Date: Wed, 5 Aug 2009 17:50:07 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051747020.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050055550.2147@iabervon.org> <alpine.DEB.1.00.0908052254570.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051708060.2147@iabervon.org> <alpine.DEB.1.00.0908052321580.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoNG-0005wq-Kn
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZHEVuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZHEVuI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:50:08 -0400
Received: from iabervon.org ([66.92.72.58]:49343 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbZHEVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:50:07 -0400
Received: (qmail 22552 invoked by uid 1000); 5 Aug 2009 21:50:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 21:50:07 -0000
In-Reply-To: <alpine.DEB.1.00.0908052321580.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125001>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> 
> > On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> > 
> > > Hi,
> > > 
> > > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > > 
> > > > This command, supported if the "import" capability is advertized,
> > > > allows a helper to support fetching by outputting a git-fast-import
> > > > stream.
> > > 
> > >   If both the "import" and the "fetch" capability are advertised, the 
> > >   "import" capability is ignored.
> > 
> > The transport code notices that both are supported; it just doesn't use 
> > the less convenient one. It would be wrong for helpers to advertize both 
> > and depend on only "fetch" being used. (For example, there's no reason 
> > that hg couldn't use one of these helpers and use the "import" capability 
> > despite the "fetch" capability also being advertized, because "import" 
> > produces results which are portable across local vcses.)
> 
> My point was not to criticize the decision.  My point was to criticize the 
> absence of the comment from both commit message and documentation.

But it would be wrong for that documentation to say that "import" is 
ignored if "fetch" is available, because it's not necessarily true. I'll 
make the commit message say that git will prefer "fetch".

	-Daniel
*This .sig left intentionally blank*
