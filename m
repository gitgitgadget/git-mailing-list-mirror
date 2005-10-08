From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Create object subdirectories on demand
Date: Fri, 7 Oct 2005 21:45:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510072124290.23242@iabervon.org>
References: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 03:41:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO3hg-0004sd-RH
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 03:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVJHBkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 21:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVJHBkp
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 21:40:45 -0400
Received: from iabervon.org ([66.92.72.58]:6414 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932108AbVJHBkp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 21:40:45 -0400
Received: (qmail 8881 invoked by uid 1000); 7 Oct 2005 21:45:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Oct 2005 21:45:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9834>

On Thu, 6 Oct 2005, Linus Torvalds wrote:

> This patch also tries to fix up "write_sha1_from_fd()" to use the new 
> common infrastructure for creating the object files, closing a hole where 
> we might otherwise leave half-written objects in the object database.

This looks right to me, but it would be nice to also split out and 
share the temp file creation. Also, http-fetch.c writes object files and 
needs at least move_temp_to_file() if it's going to do special stuff.

	-Daniel
*This .sig left intentionally blank*
