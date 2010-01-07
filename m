From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: base85: Two tiny fixes
Date: Thu, 07 Jan 2010 12:58:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
References: <201001071558.30065.agruen@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwci-0002W4-GX
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab0AGR6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531Ab0AGR6F
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:58:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40761 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab0AGR6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:58:04 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KVW005EO1WPP6L0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 07 Jan 2010 12:58:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <201001071558.30065.agruen@suse.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136368>

On Thu, 7 Jan 2010, Andreas Gruenbacher wrote:

> While looking at the base85 code I found a bug in the debug code and an 
> unnecessary call.  You may want to have a look at the two fixes here:
> 
>   http://www.kernel.org/pub/scm/linux/kernel/git/agruen/git.git

ACK.  Please post them to this list.

> There is another little oddity in the way the de85 table is set up: 0 
> indicates an invalid entry; to avoid this from clashing with a valid entry, 
> valid entries are incremented by one and decremented again while decoding.  
> This leads to slightly worse code than using a negative number to indicate 
> invalid values (and avoiding to increment/decrement).

You can make a patch to modify that as well if you wish.  And in that 
case don't forget to make de85 explicitly signed as a char is unsigned 
by default on some platforms.


Nicolas
