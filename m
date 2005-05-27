From: Nicolas Pitre <nico@cam.org>
Subject: BEWARE: mkdelta is broken
Date: Thu, 26 May 2005 21:32:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505262125050.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 27 03:42:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbTrI-0006vn-LW
	for gcvg-git@gmane.org; Fri, 27 May 2005 03:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVE0BnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 21:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVE0Bfm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 21:35:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43332 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261407AbVE0BcU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 21:32:20 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IH400BASK9VZI@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 26 May 2005 21:32:19 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Please don't use mkdelta on a valuable repository for the time being.

The current delta loop detection logic is broken.  So if you have 
multiple merged branches or you have a changeset that revert things then 
you might end up with a delta loop and fsck-cache will effectively 
complain about unresolved deltas and assorted dangling/broken object 
links.

I'm working on a fix right now.


Nicolas
