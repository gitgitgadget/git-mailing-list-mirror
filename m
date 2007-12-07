From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 23:21:32 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712062315000.555@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
 <20071205.202047.58135920.davem@davemloft.net>
 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
 <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
 <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
 <1196995353.22471.20.camel@brick>
 <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org>
 <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 05:21:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Uip-0003vd-3s
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 05:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbXLGEVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 23:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbXLGEVe
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 23:21:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57336 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbXLGEVd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 23:21:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSN00HHAW3WT9K0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 23:21:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67376>

On Thu, 6 Dec 2007, Jon Smirl wrote:

> I have a 4.8GB git process with 4GB of physical memory. Everything
> started slowing down a lot when the process got that big. Does git
> really need 4.8GB to repack? I could only keep 3.4GB resident. Luckily
> this happen at 95% completion. With 8GB of memory you should be able
> to do this repack in under 20 minutes.

Probably you have too many cached delta results.  By default, every 
delta smaller than 1000 bytes is kept in memory until the write phase.  
Try using pack.deltacachesize = 256M or lower, or try disabling this 
caching entirely with pack.deltacachelimit = 0.


Nicolas
