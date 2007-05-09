From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] deprecate the new loose object header format
Date: Wed, 09 May 2007 16:42:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705091633590.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
 <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
 <alpine.LFD.0.99.0705091048120.24220@xanadu.home>
 <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.99.0705091422130.24220@xanadu.home>
 <56b7f5510705091316t78e31032k95815e190239717e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 22:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlszT-00035P-NE
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbXEIUmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbXEIUmX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:42:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32633 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXEIUmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:42:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHS009AUK6JMZF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 May 2007 16:42:20 -0400 (EDT)
In-reply-to: <56b7f5510705091316t78e31032k95815e190239717e@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46787>

On Wed, 9 May 2007, Dana How wrote:

> This doesn't just deprecate the format,
> it removes the ability to create it.
> So to me this patch goes too far.

Well, I disagree.  We cannot create it anymore, but we still can read 
it.  Older Git versions nay not even read it.  And since this format was 
off by default anyway, I doubt you've lost anything.

> Also, if we're interested in "simpler", wouldn't
> it be better for loose and in-pack objects to be
> the same?  I thought that was the point of
> !legacy_headers.

It is not simpler because:

 1) backward compatibility requires the legacy format, and

 2) the object SHA1 is always computed with the legacy header included.

So what is simpler is really to get rid of over 100 lines of code that 
didn't provide a real benefit.  The faster we remove the ability to 
write such objects the fewer they'll be in the field.


Nicolas
