From: Nicolas Pitre <nico@cam.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 16:04:59 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802101558200.2732@xanadu.home>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802100110450.11591@racer.site>
 <alpine.LFD.1.00.0802092016540.2732@xanadu.home>
 <alpine.LSU.1.00.0802100130090.11591@racer.site>
 <m3myq8fwdx.fsf@localhost.localdomain>
 <alpine.LFD.1.00.0802101241590.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJN1-00036a-0O
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbYBJVFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 16:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbYBJVFA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:05:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13301 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbYBJVE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 16:04:59 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW100MPKJWBG090@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 16:04:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0802101241590.2896@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73415>

On Sun, 10 Feb 2008, Linus Torvalds wrote:

> At the same time, I'm still not really convinced we need to add the 
> redundant info. I do think I *should* have designed it that way to start 
> with (and I thought so two years ago - blaah), so the strongest reason for 
> "we should add generation numbers" at least for me is that I actually 
> think it's a GoodThing(tm) to have.
> 
> But adding it is a pretty invasive thing, and would force people to 
> upgrade (it really isn't backwards compatible - old versions of git would 
> immediately refuse to touch archives with even just a single top commit 
> that has a generation number in it, unless we'd hide it at the end of the 
> buffer and just uglify things in general).

Repeating myself: for one, I'm rather against any such generation 
headers in the commit object, and so is Dscho.

Why?  Because it doesn't have to live in the commit object at all.

Just like we have a locally managed pack index file, we can have a 
locally managed "index of generations" file just fine.


Nicolas
