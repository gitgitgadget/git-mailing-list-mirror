From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 04 May 2005 23:10:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505042259150.14033@localhost.localdomain>
References: <200505030657.38309.alonz@nolaviz.org>
 <200505041156.19499.mason@suse.com>
 <DE5D04E8-B182-45B1-AB9A-6AA178005FFD@adacore.com>
 <200505041834.19053.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 05:05:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTWfY-0002lv-Ak
	for gcvg-git@gmane.org; Thu, 05 May 2005 05:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVEEDLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 23:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEEDLO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 23:11:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13237 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262009AbVEEDKv
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 23:10:51 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFZ00D74Y5Z4P@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 May 2005 23:10:47 -0400 (EDT)
In-reply-to: <200505041834.19053.mason@suse.com>
X-X-Sender: nico@localhost.localdomain
To: Chris Mason <mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 4 May 2005, Chris Mason wrote:

> On Wednesday 04 May 2005 17:47, Geert Bosch wrote:
> >  From your tests it would seem that the zdelta version is the only one
> > to provide a uniform improvement over plain git. As it also seems the
> > simplest approach, I wonder why the consensus is that using xdiff
> > would be better?
> 
> zdelta seems to be a research project.  It does compress better than the xdiff 
> lib, but the speed improvements against xdiff(1) are probably because the 
> resulting tree is smaller.  I favor the xdiff code because it's so much 
> smaller, and seems easier for us to maintain.

Yep.  And compression can be improved without changing de decompressor 
since the decompressor is only a replay of what the compressor found to 
be redundent.  That redundency searching can probably be improved wrt to 
the current code.  And FRankly considering about 300 lines of code to 
create a delta and 60 lines to expand it is hard to beat maintenance 
wise.

> For performance, there's still quite a bit of tuning that can be done in terms 
> of when and how we delta.

Indeed.


Nicolas
