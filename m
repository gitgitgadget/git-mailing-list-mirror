From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Thu, 15 May 2008 02:09:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805150204440.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer> <alpine.DEB.1.00.0805141803240.30431@racer> <7vbq38oi3j.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141940460.30431@racer> <7vy76cn1aq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805142308400.30431@racer>
 <7vod78k022.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 03:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwRz2-0002tn-78
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 03:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbYEOBJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 21:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYEOBJW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 21:09:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:49922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751478AbYEOBJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 21:09:22 -0400
Received: (qmail invoked by alias); 15 May 2008 01:09:20 -0000
Received: from R2b68.r.pppool.de (EHLO racer.local) [89.54.43.104]
  by mail.gmx.net (mp025) with SMTP; 15 May 2008 03:09:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KxUxxHwbKoTWHBvPRibhgZC+YODUaMmreIvvEIX
	4u3NLoI7DISAFr
X-X-Sender: gene099@racer
In-Reply-To: <7vod78k022.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82163>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 14 May 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > The point is: for the sake of a script (which wants to ignore 
> >> > submodules) asking if there is a diff, I think it makes sense to 
> >> > not ignore those changes.  IOW I think my patch is enough for the 
> >> > purpose of getting stash/rebase to behave.
> >> 
> >> But the patch is not about stash/rebase but affects all diff users, 
> >> doesn't it?
> >
> > Does it?  I thought I hid all that special handling behind the 
> > --ignore-submodules options.
> 
> That's exactly the point.  The option reads "ignore submodules", not 
> "special option for use only by stash and rebase".

But it also does not read "ignore submodules and those blobs/trees that 
happen to replace (or be replaced by) submodules".

I think it is not a bad thing to call it "ignore submodules", but show the 
submodules when something else than a submodule is involved, too.

I see where you are heading with the "split diff into removal of submodule 
/ addition of a blob", but I think that would be overly clever, and not 
helpful.  I know that I would want to have that marked as a problem when 
rebasing.

Ciao,
Dscho
