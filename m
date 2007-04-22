From: Nicolas Pitre <nico@cam.org>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 14:25:14 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704221422250.28339@xanadu.home>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
 <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
 <7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
 <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfgkT-0002Sn-SK
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbXDVSZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbXDVSZR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:25:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54532 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbXDVSZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:25:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGW00IJ0WI25GC0@VL-MO-MR002.ip.videotron.ca>; Sun,
 22 Apr 2007 14:25:14 -0400 (EDT)
In-reply-to: <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45260>

On Sun, 22 Apr 2007, Junio C Hamano wrote:

> With recent glibc, mkstemp() creates 0400 file.  Updated
> pack-objects uses it in pack/idx writing without fixing this,
> hence this problem.

Oops.  I guess I'm guilty for this.  I didn't bother looking at the 
permission on the pack for git-pack-objects since git-repack seemed to 
take care of that.  But it only _remove_ write permissions.


Nicolas
