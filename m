From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 22:54:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703252252500.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr>
 <20070325203901.GB12376@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Eric Lesh <eclesh@ucla.edu>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZjO-0004qp-Mk
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXCYUyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXCYUyY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:54:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:33359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752694AbXCYUyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:54:23 -0400
Received: (qmail invoked by alias); 25 Mar 2007 20:54:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 25 Mar 2007 22:54:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CtQ1VQGGC0fEr/jADTgV60vktIyzF8aCB1emiUz
	clNPOyfp8IkHN/
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070325203901.GB12376@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43073>

Hi,

On Sun, 25 Mar 2007, Shawn O. Pearce wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > Eric Lesh <eclesh@ucla.edu> writes:
> > 
> > > .gitlink is for a lightweight checkout of a branch into a separate
> > > directory on the local filesystem.
> > 
> > I think it's a pitty to restrict yourself to _local_ filesystem. There
> > are tons of cases where you have a fast, non-NFS, access to a machine
> > and would like to host your repository there.
> > 
> > That said, I suppose removing this restriction moves the solution from
> > the category "quick and efficient hack" to something much harder.
> 
> Yes.  But there's another project on the ideas list that addresses
> that (``Lazy Clone'').  It is quite a bit more difficult than the
> .gitlink idea as the implementation requires a network protocol
> client implemented somewhere near the read_sha1_file interface.

Not only that. You'd have to change the way read_sha1_file() is called to 
allow fetching more than one object at a time. Otherwise this will be so 
slow as to be unusable.

That's basically the reason why I changed my mind, and preferred shallow 
clones over lazy clones.

Ciao,
Dscho
