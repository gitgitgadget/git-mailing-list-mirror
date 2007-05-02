From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Create pack-write.c for common pack writing code
Date: Wed, 02 May 2007 12:29:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0705021226010.6574@xanadu.home>
References: <46378656.9080109@gmail.com> <20070502161648.GK5942@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 02 18:30:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHik-00013v-3Y
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993492AbXEBQ3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993497AbXEBQ3u
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:29:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993493AbXEBQ3p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:29:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHF00IQ59TIIB30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 02 May 2007 12:29:42 -0400 (EDT)
In-reply-to: <20070502161648.GK5942@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46034>

On Wed, 2 May 2007, Shawn O. Pearce wrote:

> Dana How <danahow@gmail.com> wrote:
> > 
> > Include a generalized fixup_header_footer() in this new file.
> > Needed by git-repack --max-pack-size feature in a later patchset.
> 
> Thanks.  I'm applying this to my fastimport.git tree, but I changed
> the name to fixup_pack_header_footer().  I'm also refactoring the
> same code out of index-pack, to call your version.
> 
> I'll ask Junio to pull your patch, and my index-pack cleanup soon.
> As soon as I'm sure everything still passes the tests.  ;-)

BTW I think the common function should _not_ close the file descriptor 
it is being handed.   It is more flexible to let the caller close the 
file, or possibly do whatever other operations like fchmod().


Nicolas
