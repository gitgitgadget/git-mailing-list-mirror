From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Fri, 14 Dec 2007 17:34:49 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
 <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
 <m3fxy5qwbq.fsf@roke.D-201>
 <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
 <20071214215206.GB7300@mail.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 23:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3J8Y-0004TL-1w
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 23:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764852AbXLNWe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764966AbXLNWe5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 17:34:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32206 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934092AbXLNWeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 17:34:50 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT200EKV9E1CO80@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Dec 2007 17:34:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071214215206.GB7300@mail.oracle.com>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68357>

On Fri, 14 Dec 2007, Joel Becker wrote:

> On Fri, Dec 14, 2007 at 08:38:51AM -0500, Nicolas Pitre wrote:
> > On Fri, 14 Dec 2007, Jakub Narebski wrote:
> > > Which means what? Local clone with shortcut (hardlinking and remotes)?
> > > Dumb protocols (http, ftp, rsync)?
> > 
> > Right, or simply shared repo over NFS or the like.
> > 
> > The 1.5.5 release notes will contain a note reminding people to set the 
> > corresponding config variables if they wish to retain the legacy 
> > behaviors.
> 
> 	We've seen that release notes are a poor way to communicate
> this.  What will happen to a 1.4.4 user when they try to access the
> repository?  Corruption, cryptic error message, or clean "this repo is
> not compatible" message?

There won't be any corruption.

In the best case there will be a message along "x is not supported by 
this version of Git -- please consider upgrading".  In the worst case 
it'll say "x is bad".

But you know what? repositories with the change affecting 1.4.4 users 
are _already_ out there and no one complained recently.  Anyone pushing 
changes over the native Git protocol is already using deltabaseoffset as 
the native protocol negociate that capability in its handshake, and 
these days we keep packs as is on the receiving side when they're large 
enough.


Nicolas
