From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-checkout: use struct lock_file correctly
Date: Thu, 14 Feb 2008 13:22:39 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802141319380.13593@iabervon.org>
References: <alpine.LNX.1.00.0802071137490.13593@iabervon.org> <alpine.LSU.1.00.0802141816120.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 19:23:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPik1-0003SH-Qh
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 19:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbYBNSWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 13:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYBNSWv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 13:22:51 -0500
Received: from iabervon.org ([66.92.72.58]:45021 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbYBNSWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 13:22:50 -0500
Received: (qmail 6112 invoked by uid 1000); 14 Feb 2008 18:22:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Feb 2008 18:22:39 -0000
In-Reply-To: <alpine.LSU.1.00.0802141816120.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73902>

On Thu, 14 Feb 2008, Johannes Schindelin wrote:

> A lock_file instance must not be cleaned up, since an atexit() handler
> will try to access even correctly committed lock_files, since it has
> to make sure that they were correctly committed.

I think the lock_file API changed between when I wrote this code (using 
other code as reference) and now; could you check that there aren't other 
things I have to change as well, since I think you were following the 
lock_file changes at the time, and I wasn't? I got the most obvious one 
(calling close() on the fd yourself is no longer right, but I didn't know 
about this one, and I don't know about any further ones, if there are 
any.)

	-Daniel
*This .sig left intentionally blank*
