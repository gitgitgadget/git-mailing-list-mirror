From: Nicolas Pitre <nico@cam.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 03 Apr 2007 15:34:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031529300.28181@xanadu.home>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
 <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
 <86bqi6kae7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
 <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com>
 <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com>
 <20070403172123.GD27706@spearce.org>
 <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
 <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYole-0003xL-5Z
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966119AbXDCTeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966120AbXDCTeG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:34:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38374 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966119AbXDCTeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:34:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00C86T0QOJB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 15:34:02 -0400 (EDT)
In-reply-to: <7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43642>

On Tue, 3 Apr 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Yeah, the short SHA1 form is obviously always going to be risky. But in 
> > practice, since people almost always use it just for commits, it's 
> > probably good enough in practice, and even if you get a collision in 8 
> > nibbles, most of the time it will probably be trivial to figure out which 
> > one was meant, so it's not like it's a disaster if somebody ends up 
> > reporting a bug with a non-unique abbreviation.
> 
> Are you hinting to update sha1_name.c::get_sha1() so that we do
> not accept abbreviated non-commit object names?

NO, I hope not.

Instead (and if the concern is real) we should error out when the 
abbreviated name is ambigous and impose no restriction otherwise.


Nicolas
