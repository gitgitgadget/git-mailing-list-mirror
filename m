From: Nicolas Pitre <nico@cam.org>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 21:25:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703272114300.3041@xanadu.home>
References: <17929.37382.984339.742025@lisa.zopyra.com>
 <20070327233552.GA7186@coredump.intra.peff.net>
 <17929.45060.6228.797279@lisa.zopyra.com>
 <20070328000149.GA12808@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 03:26:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWMvC-0003xs-4B
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 03:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965583AbXC1BZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 21:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965584AbXC1BZv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 21:25:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41686 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965583AbXC1BZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 21:25:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFL00ES1AN1MRB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Mar 2007 21:25:49 -0400 (EDT)
In-reply-to: <20070328000149.GA12808@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43339>

On Tue, 27 Mar 2007, Jeff King wrote:

> On Tue, Mar 27, 2007 at 06:00:04PM -0600, Bill Lear wrote:
> 
> > Ok, thank you.  I will try this out and keep this in mind as I test
> > out the patch Johannes posted.
> 
> This is, btw, completely different than what Johannes posted. His patch
> shows you the date of the _tip_ of each of the branches. My script shows
> the _oldest_ reflog for the branch. So it depends on whether you want
> them in order of "last worked on" or "created" (you said "created", but
> I wonder if "last worked on" is actually more useful).

I think "last worked on" is the only thing that makes sense.  Anything 
else is completely ambigous, especially in the presence of forks and 
merges.  And eventually all reflogs will have about the same age when 
they extend past the expiration period, at which point the "oldest 
reflog" is not meaningful anymore.

However Johannes' patch uses the author date for sorting.  I think 
branches 
really should be sorted by committer's date though.  The committer's 
date is a much better indicator of when a given branch has been updated 
while the author's date might be any time in the past.


Nicolas
