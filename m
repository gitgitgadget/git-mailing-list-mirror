From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 15:45:33 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111534300.23787@xanadu.home>
References: <20080909194354.GA13634@cuci.nl>
 <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org>
 <20080909235848.GE7459@cuci.nl>
 <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <20080910054244.GB15715@cuci.nl>
 <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org>
 <20080910230906.GD22739@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl>
 <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
 <20080911192356.GC1451@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:48:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kds7s-0004DK-4g
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 21:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYIKTpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 15:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbYIKTpl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 15:45:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8595 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbYIKTpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 15:45:41 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7100BKQQVXJQZ7@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 15:45:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911192356.GC1451@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95632>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> The origin field will *not* be created on regular cherry-picks, this
> *would* create garbage.  The origin field is not meant to be generated
> when doing things with temporary branches.  The origin field is meant to
> be filled *ONLY* when cherry-picking from one permanent branch to
> another permanent branch.  This is a *rare* operation.

... and therefore you might as well just have a separate file (which 
might or might not be tracked by git like the .gitignore files are) 
to keep that information?  Since this is a rare operation, modifying the 
core database structure for this doesn't appear that appealing to most 
so far.

And, while recording this origin link is optional, you are likely to 
make mistakes like forgotting to record it, or you might even wish to 
fix it with better links after the facts.  Having it versionned also 
means that older git versions will be able to carry that information 
even if they won't make any use of it, and that also solves the 
cryptographic issue since that data is part of the top commit SHA1.


Nicolas
