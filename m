From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 21:34:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910182122100.21739@xanadu.home>
References: <20091018144158.GA9789@gandalf.dynalias.org>
 <alpine.LNX.2.00.0910181727130.32515@iabervon.org>
 <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Mon Oct 19 03:39:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzhDF-0006NW-Vt
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 03:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZJSBiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 21:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbZJSBiy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 21:38:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60775 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZJSBiy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 21:38:54 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRQ00D2HN0OZH90@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 18 Oct 2009 21:34:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130636>

On Mon, 19 Oct 2009, Norbert Preining wrote:

> Now my follow-up questions:
> - how would one access this "sequence" number on the server

you can count how many commits the server has: git rev-list HEAD | wc -l

> - is there a way to determine at which of this "sequence" numbers a specific
>   file has been changed last?

You can do: git log <path/filename>.  That would give you a list of 
commits that touched that file.  But to find out which commit "number" 
it is you could do:

	git rev-list $(git rev-list -1 HEAD <path/file>) | wc -l

Again, that is true for a particular repository only and may give a 
different result in another repository with a different state even for 
the same commit.

However, given what you want to do is really to stick to the SVN way of 
doing things, then why don't you simply stay with SVN?  Git works in a 
fundamentally different way than SVN, and if you aren't willing/able to 
change your workflow away from the SVN way then there is really not much 
for you to gain by switching to Git.


Nicolas
