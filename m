From: Nicolas Pitre <nico@cam.org>
Subject: Re: "git pull" throws away dirty state
Date: Sun, 16 Mar 2008 14:37:34 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803161434450.2947@xanadu.home>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 19:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaxkN-0006Mm-P8
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 19:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYCPShg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYCPShg
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 14:37:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64840 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYCPShf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 14:37:35 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXU00A236ECFSQ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 16 Mar 2008 14:37:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77371>

On Sun, 16 Mar 2008, Linus Torvalds wrote:

> 
> 
> On Sun, 16 Mar 2008, Linus Torvalds wrote:
> > 
> > Ok, this is distressing, and I suspect it's another bug of mine due to 
> > unpack-trees changes, but before I delve into it deeper I thought I'd 
> > report it here and see if others see it too, and maybe it's due to 
> > something else..
> 
> Nope, I bisected it down to
> 
> 	34110cd4e394e3f92c01a4709689b384c34645d8 is first bad commit
> 
> 	Make 'unpack_trees()' have a separate source and destination index
> 
> and I'm trying to figure out what part of that triggered this bug.

We really should have more tests to cover all those bugs that were 
introduced and fixed lately.

Given that Git should work fine in some cases even with a dirty work 
tree by design, I'm a bit surprised that we don't have any test case 
covering that.


Nicolas
