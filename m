From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 12:47:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902101226580.19665@iabervon.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwjP-0007m2-Ol
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbZBJRrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbZBJRrn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:47:43 -0500
Received: from iabervon.org ([66.92.72.58]:35309 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZBJRrm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:47:42 -0500
Received: (qmail 22350 invoked by uid 1000); 10 Feb 2009 17:47:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 17:47:40 -0000
In-Reply-To: <20090210172212.GR30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109283>

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > 
> > Is there some way to see if the pack it was writing is actually corrupt 
> > (beyond not having the hash set)?
> 
> Hmm.  If you have the pack fragment, its going to take some editing
> to get it through the existing validation tools.

Actually, I went for the other end; I made close_pack_windows() not mind 
the open windows (hey, it's dying anyway in my case, nobody's going to 
write more), and the results passed verification and "git fsck --full" 
with just a few dangling blobs and a dangling commit. So it seems to me 
that it has to be wrong information in memory.

	-Daniel
*This .sig left intentionally blank*
