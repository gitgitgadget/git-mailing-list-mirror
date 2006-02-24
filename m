From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 13:57:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 19:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCi8E-0001Nv-FY
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 19:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBXS5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 13:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBXS5b
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 13:57:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15766 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932151AbWBXS5a
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 13:57:30 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV700JVUGNKN3F0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 13:57:20 -0500 (EST)
In-reply-to: <20060224183554.GA31247@hpsvcnb.fc.hp.com>
X-X-Sender: nico@localhost.localdomain
To: Carl Baldwin <cnb@fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16726>

On Fri, 24 Feb 2006, Carl Baldwin wrote:

> My version is 1.2.1.  I have not been following your work.  When was
> pack data reuse introduced?

Try out version 1.2.3.

> From where can I obtain your delta patches?

Forget them for now -- they won't help you.

> There is really no opportunity for pack-data reuse in this case.  The
> repository had never been packed or cloned in the first place.  As I
> said, I do not intend to pack these binary files at all since there is
> no benefit in this case.

Yes there is, as long as you have version 1.2.3.  The clone logic will 
simply reuse already packed data without attempting to recompute it.

> The delta patches may help but I can't say for sure since I don't know
> anything about them.

They (actually the last one) might help reduce the size of resulting 
packs but it currently has performance problems with some patological 
data sets.

I think you really should try git version 1.2.3 with a packed 
repository.  It might handle your special case just fine.


Nicolas
