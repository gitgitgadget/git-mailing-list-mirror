From: Nicolas Pitre <nico@cam.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Sun, 10 Aug 2008 21:43:40 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808102139050.22892@xanadu.home>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 03:44:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSMSp-00047F-Lm
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 03:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbYHKBnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 21:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbYHKBnt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 21:43:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22721 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYHKBns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 21:43:48 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5E009F3Y4SJO70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Aug 2008 21:43:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91908>


[ sorry for the delay -- I just returned from vacation ]

On Fri, 8 Aug 2008, Johannes Schindelin wrote:

> Hi,
> 
> my auto gc kicked in, and shows this:
> 
> fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> error: failed to run repack
> 
> Fortunately, I have the uncorrupted object somewhere else.  So I copy the 
> single object as a loose one, and all is fine.  Right?
> 
> Wrong.

Well, to be sure things are then right or wrong, just do a 

	git show 2c1e128aa51e3a64bd61556c0cd488628b423ccf

If you can't see the object before, and are able to see it once it has 
been copied over, then things are "right".

> Repack still picks up the corrupt object instead of the good one.  What's 
> the best way out?

How do you repack?  The only way to get rid of a corrupted object in 
that case is to 'git repack -a -f'.


Nicolas
