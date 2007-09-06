From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] basic threaded delta search
Date: Thu, 06 Sep 2007 02:23:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709060220520.21186@xanadu.home>
References: <11890591912193-git-send-email-nico@cam.org>
 <11890591923123-git-send-email-nico@cam.org>
 <11890591923270-git-send-email-nico@cam.org>
 <1189059193250-git-send-email-nico@cam.org> <85ps0wfh8h.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAmG-0003gV-NT
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbXIFGXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbXIFGXj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:23:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48434 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbXIFGXi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:23:38 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00B2YOFE7900@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 02:23:38 -0400 (EDT)
In-reply-to: <85ps0wfh8h.fsf@lola.goethe.zz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57832>

On Thu, 6 Sep 2007, David Kastrup wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > this is still rough, hence it is disabled by default.  You need to compile
> > with "make THREADED_DELTA_SEARCH=1 ..." at the moment.
> >
> > Threading is done on different portions of the object list to be
> > deltified. This is currently done by spliting the list into n parts and
> > then a thread is spawned for each of them.  A better method would consist
> > of spliting the list into more smaller parts and have the n threads
> > pick the next part available.
> 
> In my experience, the worst performance hit happens when the real
> memory is exhausted and things start paging.  Threading on different
> portions of the object list is going to exacerbate the problem in the
> areas where it hits worst.

Just don't use it if you don't have 1) a SMP machine and 2) enough ram.
Threading will be enabled with a command line argument at some point.


Nicolas
