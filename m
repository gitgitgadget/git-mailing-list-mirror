From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 04 Feb 2008 09:52:38 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802040945370.2732@xanadu.home>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gi mailing list <git@vger.kernel.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2hI-0005f2-Eo
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbYBDOwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbYBDOwv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:52:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40297 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYBDOwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:52:50 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVP0086ZYNQPSC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 04 Feb 2008 09:52:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72510>

On Mon, 4 Feb 2008, David Tweed wrote:

> In principle this is a really trivial patch, but I'm being cautious because I
> don't like the fact that I don't know (and AFAICS can't reliably check) that
> the files being deleting are definitely dead. An alternative would
> be to make prune just print out that the suspicious packs are
> there and let the user delete them manually. (My itch is that once
> a write-failure pack gets created, nothing in git operations tells the
> user that a generally multimegabyte file hidden in .git occupying space.)

The lifelessness of a temporary pack is the same as for loose objects, 
hence the same rule should apply in both cases.  Just asking the user to 
delete them manually isn't too nice either.  A prune operation is 
already said to be dangerous and should be performed only when no other 
activities are occurring in the same repository.  That should cover the 
case of dead temporary pack files just as well.


Nicolas
