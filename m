From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 09:06:17 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702270858510.29426@xanadu.home>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
 <11725197633144-git-send-email-nico@cam.org>
 <11725197632516-git-send-email-nico@cam.org>
 <7vejobhor2.fsf@assigned-by-dhcp.cox.net>
 <7v8xejhnwd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 15:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2yF-0006px-2l
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 15:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXB0OGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 09:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbXB0OGS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 09:06:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63424 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXB0OGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 09:06:18 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE4000BSKIHI9G2@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 09:06:17 -0500 (EST)
In-reply-to: <7v8xejhnwd.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40736>

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Nicolas Pitre <nico@cam.org> writes:
> >
> >> We currently have two parallel notation for dealing with object types
> >> in the code: a string and a numerical value.  One of them is obviously
> >> redundent, and the most used one requires more stack space and a bunch
> >> of strcmp() all over the place.
> >>
> >> This is an initial step for the removal of the version using a char array
> >> found in object reading code paths.  The patch is unfortunately large but
> >> there is no sane way to split it in smaller parts without breaking the
> >> system.
> 
> Will your next step be to convert write_sha1_file() and friends?

Yes, eventually.

At least the write paths don't have those strcpy()/strcmp() everywhere 
and no temporary char arrays on the stack.  But for uniformity they have 
to be converted as well.


Nicolas
