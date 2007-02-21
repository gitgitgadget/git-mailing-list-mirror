From: Nicolas Pitre <nico@cam.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 13:52:40 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702211345350.31945@xanadu.home>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <20070221183028.GA9088@ginosko.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:53:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwaW-0000xm-8q
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbXBUSwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbXBUSwn
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:52:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28629 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422801AbXBUSwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:52:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDT00J10TRSBVO0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Feb 2007 13:52:41 -0500 (EST)
In-reply-to: <20070221183028.GA9088@ginosko.local>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40318>

On Wed, 21 Feb 2007, Michael Hendricks wrote:

> What's a decent way to make a branch into a new repository?  My first
> inclination is to "cp -a" the existing repository, checkout the branch,
> delete all other branches and repack.  That seems to have worked in my
> quick test, but is there a better way?

Like Shawn said the better way is simply to fetch that branch into a new 
repo.

If you do a cp -a and delete unwanted branches it'll work as well of 
course, but repacking won't get rid of all the data from the believed to 
be deleted branches since some reflog, the HEAD reflog in particular, 
will most probably have references to commits from the removed branches. 
Therefore the pack will still contain that data, at least untill the 
reflog entries expire and get pruned.

Of course if you want to publish just the wanted branch and perform a 
push to a public place then only those objects for that branch will be 
sent like for the fetch case.


Nicolas
