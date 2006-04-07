From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Fri, 07 Apr 2006 10:11:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604071002530.2215@localhost.localdomain>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
 <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
 <7vhd55ls24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Apr 07 16:12:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRrgs-0008Tm-0O
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 16:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDGOLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWDGOLt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 10:11:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:2782 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932329AbWDGOLs
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 10:11:48 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXC00HIKVFELAC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Apr 2006 10:11:39 -0400 (EDT)
In-reply-to: <7vhd55ls24.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18498>

On Fri, 7 Apr 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Mon, 3 Apr 2006, Linus Torvalds wrote:
> >> 
> >> That said, I think git _does_ have problems with large pack-files. We have 
> >> some 32-bit issues etc
> >
> > I should clarify that. git _itself_ shouldn't have any 32-bit issues, but 
> > the packfile data structure does. The index has 32-bit offsets into 
> > individual pack-files. 
> >
> > That's not hugely fundamental,...
> 
> Linus _does_ understand what he means, but let me clarify and
> outline a possible future direction.
> 
[...]

For the record, the delta code also has 32-bit limitations of its own 
presently.  It cannot encode a delta against a buffer which is larger 
than 4GB.

I however made sure the byte 0 could be used as a prefix for future 
encoding extensions, like 64-bit file offsets for example.


Nicolas
