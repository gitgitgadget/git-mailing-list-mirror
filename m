From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Mon, 10 Nov 2008 20:58:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcoB-0006gl-Hy
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYKJTvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYKJTvE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:51:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:59442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751211AbYKJTvC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:51:02 -0500
Received: (qmail invoked by alias); 10 Nov 2008 19:50:53 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 10 Nov 2008 20:50:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+HD0f4LI+fBKoD00HKX8UlW6dSnODU7zKk0bT3w
	j/eVeBhtc9fKCi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081109102528.GA5463@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100553>

Hi,

On Sun, 9 Nov 2008, Alex Riesen wrote:

> Linus Torvalds, Fri, Nov 07, 2008 19:08:36 +0100:
> > On Fri, 7 Nov 2008, Alex Riesen wrote:
> > > 
> > > Does not work if there are ranges given :-/
> > > It'd be very nice to have: git show #c1..$c2 $c3 $c4 $c5..$c6
> > 
> > Yeah, we've very fundamentally never supported that. Not for show, but 
> > also not for anything else (ie "gitk a..b c..d" does _not_ give you 
> > two ranges).
> > 
> > It's easy to see why once you understand what 'a..b' really means (ie 
> > it just expands to '^a' and 'b'), and how it's not really a "range" 
> > operation as much as a set operation that interacts with all the other 
> > arguments too. But unless you're very aware of that, it can be 
> > surprising.
> > 
> 
> Oh, I am. But it is just so convenient to have range support for 
> commands which just show commits. Besides, git-show just errors out, 
> instead of producing the commits like git-log does.

Have fun implementing the support, and then explaining to users why this 
shows only one commit:

	git show HEAD^..HEAD HEAD~10

Ciao,
Dscho
