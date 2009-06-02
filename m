From: Nicolas Pitre <nico@cam.org>
Subject: Re: git and multiple cores
Date: Tue, 02 Jun 2009 19:54:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906021949410.3906@xanadu.home>
References: <4A25AA4C.9070600@nortel.com>
 <eaa105840906021555w22e62341l61f250455cf8c23b@mail.gmail.com>
 <20090602230205.GL30527@spearce.org>
 <eaa105840906021612y5b9e4c25o1062d7f7aecfbd16@mail.gmail.com>
 <4A25B5C3.40409@nortel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Peter Harris <git@peter.is-a-geek.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBdog-0003Im-Ph
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbZFBXym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbZFBXym
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:54:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59723 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbZFBXyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 19:54:41 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKM00HKHYE3W350@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Jun 2009 19:54:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4A25B5C3.40409@nortel.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120563>

On Tue, 2 Jun 2009, Chris Friesen wrote:

> Peter Harris wrote:
> > On Tue, Jun 2, 2009 at 7:02 PM, Shawn O. Pearce wrote:
> > 
> >>True, but he was talking about initial clone, which on the client
> >>side is git-index-pack.  Which is not threaded.
> > 
> > 
> > Ah. I thought he was talking about the server side. My mistake.
> 
> Sorry, I wasn't clear.  I was talking about the client side, although
> the server side information is useful to have.
> 
> I have a 4-way machine as a client, and it just seemed odd that git
> could only use one core.

It can use them all when repacking or pushing.  But on a clone or fetch 
your client machine deals with incoming data using index-pack which is 
much more trickier to thread.


Nicolas
