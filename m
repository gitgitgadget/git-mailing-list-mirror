From: Nicolas Pitre <nico@cam.org>
Subject: Re: Instructions concerning detached head lead to lost local changes
Date: Thu, 01 Feb 2007 21:49:27 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702012135550.3021@xanadu.home>
References: <87mz3xa3vr.wl%cworth@cworth.org>
 <7v1wl9mj48.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 03:50:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCoV3-0000Tt-VZ
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 03:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423083AbXBBCtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 21:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423087AbXBBCtb
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 21:49:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19404 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423084AbXBBCta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 21:49:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCT00G8QEIFPXV0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 21:49:27 -0500 (EST)
In-reply-to: <7v1wl9mj48.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38452>

On Thu, 1 Feb 2007, Junio C Hamano wrote:

> Alternatively we could add yet another suggestion that let's you
> discard the detached HEAD but still keep your local changes.
> Either --drop by Linus renamed to some sensible name, or "the
> obscure but useful trick".
> 
> I dunno.

I have a feeling that proper reflog for HEAD would make the issue so 
much simpler.

But in the mean time I tend to agree with Ted about the fact that simply 
losing the detached position is not _that_ important.  If you go to 
HEAD^ and want to come back to master I think it should just work (with 
a display of what the last position was as Carl mentioned).

It might be some work to get to a given position with a detached head 
and this very position might be valuable information, but if you then do 
"checkout HEAD^" you will still be detached but your previous position 
is lost just like it would be if you moved to master.  Yet you're not 
prevented from going to HEAD^ but you are prevented from going to 
master.

Same issue if you perform a commit on top of a detached head.  Nothing 
prevents you from doing "checkout HEAD^" which will leave your head 
detached but it will also silently drop your last commit dangling.

In short I think there is no magic solution other than proper reflog for 
HEAD.


Nicolas
