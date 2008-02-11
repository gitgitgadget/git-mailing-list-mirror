From: Nicolas Pitre <nico@cam.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 20:59:14 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802102053090.2732@xanadu.home>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
 <200802102353.40230.jnareb@gmail.com>
 <alpine.LFD.1.00.0802101507100.2896@woody.linux-foundation.org>
 <200802110224.48790.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:59:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONxa-0006Z2-HD
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYBKB7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYBKB7Q
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:59:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40916 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYBKB7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:59:15 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW100G5DXIQ2CV0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 20:59:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200802110224.48790.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73453>

On Mon, 11 Feb 2008, Jakub Narebski wrote:

> Linus Torvalds wrote:
> > On Sun, 10 Feb 2008, Jakub Narebski wrote:
> > > 
> > > Well, we could always add it as a local (per repository) "cache".
> > > With only generation numbers we could use pack-index-like format
> > > to store a mapping "commit sha-1 => generation number", just like
> > > now pack index stores mapping "object sha-1 => offset in pack".
> > 
> > Yes, and even embedding this in the pack-file (or perhaps, the index, as a 
> > new index extension) is probably a good idea.
> 
> Errr... index is per workarea (per checkout), and this information
> is per repository, so IMHO storing this info in an index (dircache)
> is a layering violation. Unless you were talking about pack-file-index.

The pack index isn't a good idea since one pack doesn't necessarily 
cover the whole of the repository.  A separate new file is the only 
sensible thing to do, if done at all.


Nicolas
