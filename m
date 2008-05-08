From: Nicolas Pitre <nico@cam.org>
Subject: Re: git gc & deleted branches
Date: Thu, 08 May 2008 17:15:34 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805081712270.23581@xanadu.home>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de>
 <20080508183926.GA30613@sigill.intra.peff.net>
 <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de>
 <48235D99.2040407@nrlssc.navy.mil>
 <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de>
 <20080508210125.GC32762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDTb-0000v1-Iv
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbYEHVPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYEHVPn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:15:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61926 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYEHVPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:15:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0K00LZ4J1YS050@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 May 2008 17:15:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080508210125.GC32762@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81566>

On Thu, 8 May 2008, Jeff King wrote:

> On Thu, May 08, 2008 at 10:52:19PM +0200, Guido Ostkamp wrote:
> 
> >> And be assured that the objects referenced by a deleted branch will be  
> >> removed from the repository eventually as long as 'git gc --prune' is  
> >> run periodically.
> >
> > Ok. I did not know about the 'prune' option yet as it neither mentioned in 
> > the "Git Tutorial" nor "Everyday Git", there only 'git gc' is used with no 
> > options.
> 
> It is deprecated; see 25ee9731.
> 
> According to that commit message, prune is now a no-op. However, it
> looks like it is still used for trigger a "repack -a" rather than
> "repack -A". I don't know if it is worth making that behavior available
> through some more sane command line option (I would think people who
> really know that they want "repack -a" would just call it).

Well, actually this is a problem.

I think it is a good thing to deprecate gc --prune.  but if that means 
that repack -a is never used then unreferenced and expired objects will 
never be pruned if they're packed if one is always using 'git gc' as we 
are advocating.


Nicolas
