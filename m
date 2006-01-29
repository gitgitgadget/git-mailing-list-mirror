From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] Remove more parsers
Date: Sun, 29 Jan 2006 17:05:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601291645060.25300@iabervon.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
 <7vk6ciixv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 23:03:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Kdy-0006Qg-21
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 23:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWA2WDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 17:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWA2WDK
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 17:03:10 -0500
Received: from iabervon.org ([66.92.72.58]:50701 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751196AbWA2WDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 17:03:09 -0500
Received: (qmail 20569 invoked by uid 1000); 29 Jan 2006 17:05:22 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2006 17:05:22 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ciixv0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15247>

On Sun, 29 Jan 2006, Junio C Hamano wrote:

> I do not have objections to git-tar-tree changes, but I am
> hesitant to use the tree parser in diff-tree due to its memory
> retention behaviour.  We already use the commit parser in
> diff-tree but I think we currently do not ask for the tree part
> of the object to be parsed.  I suspect this patch would badly
> interact with long-running "diff-tree --stdin", which is the
> workhorse of whatchanged.  I haven't benched it though, and I'd
> be happy to see the impact is proven to be negligible.

I'll look into discarding the struct trees after use (since we're not 
keeping flags on them, or storing references to them long-term), so we can 
use the same parser without worse memory behavior. It does seem to take a 
bunch more memory (and, oddly, be very slow) as I currently have it.

	-Daniel
*This .sig left intentionally blank*
