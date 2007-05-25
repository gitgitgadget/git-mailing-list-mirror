From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Enhance unpack-objects for extracting large objects
Date: Fri, 25 May 2007 16:05:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705251605090.3366@xanadu.home>
References: <46569C37.5000201@gmail.com>
 <7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705251249u74b754f1y4f8cafd5f5c35f19@mail.gmail.com>
 <7viragr7xb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 22:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrg2r-0004JU-El
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbXEYUFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbXEYUFr
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:05:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39697 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbXEYUFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:05:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIM00BUE55DUL00@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 16:05:38 -0400 (EDT)
In-reply-to: <7viragr7xb.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48406>

On Fri, 25 May 2007, Junio C Hamano wrote:

> "Dana How" <danahow@gmail.com> writes:
> 
> >>  * You already have the size here, so if min_blob_size is set
> >>    and the size is larger, you do not even have to call
> >>    write_sha1_file() at all.
> > The way I read the code,  it looks like unpack-objects needs
> > the last argument always to be initialized with the SHA-1 computed
> > from the object contents.  Therefore I always need to call
> > write_sha1_file(),  even if I don't want it to write anything.
> 
> Ah, that is what I missed.
> 
> There is a separate function to only hash, named (surprisingly)
> "hash_sha1_file().  Maybe you can teach the caller's "don't
> write it out" codepath to call it.

That would be clearer indeed.


Nicolas
