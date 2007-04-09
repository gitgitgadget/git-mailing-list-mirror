From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes
 'limit' arg
Date: Sun, 08 Apr 2007 22:28:56 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704082227580.28181@xanadu.home>
References: <46197994.70009@gmail.com>
 <7v4pnq8ld4.fsf@assigned-by-dhcp.cox.net>
 <7vr6qu768r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 04:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HajdB-0003Fy-9E
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 04:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbXDIC26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 22:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbXDIC26
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 22:28:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61582 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbXDIC25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 22:28:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG7002H3LK8FZG0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Apr 2007 22:28:56 -0400 (EDT)
In-reply-to: <7vr6qu768r.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44025>

On Sun, 8 Apr 2007, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Dana How <danahow@gmail.com> writes:
> >
> >> Accept new 'limit' argument and check against it
> >> before each group of writes.  Update delta usability rules
> >> for possibility of delta base being in a previously-
> >> written pack. Inline sha1write_compressed() so we know
> >> the exact size of the written data when it needs to be compressed.
> >>
> >> Signed-off-by: Dana How <how@deathvalley.cswitch.com>
> >
> > My first reaction of open-coding sha1write_compressed() was
> > "Ugh", but as you are removing the only user of that function,
> > maybe this is not as bad as it looks.
> 
> Having said that, I suspect that for other possible users of
> that function we might have later, it would be a better
> interface to add an optional 'limit' and 'prelude' to
> sha1write_compressed().  The function would write prelude
> followed by the compressed payload, only if they fit the limit.

I'd wait for those possible future users to show up before doing such 
thing though.


Nicolas
