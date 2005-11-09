From: Junio C Hamano <junkio@cox.net>
Subject: Re: Regarding: git-lost+found
Date: Wed, 09 Nov 2005 15:23:41 -0800
Message-ID: <7vwtjh8kxu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvez1bjjv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511091759520.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:26:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzIM-0006o8-Dn
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVKIXXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVKIXXn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:23:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59593 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750837AbVKIXXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:23:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109232319.OJRI1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 18:23:19 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511091759520.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 9 Nov 2005 18:06:04 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11438>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Why have git-lost+found write to files at all? It seems to me easiest to 
> have the list go to standard out, and you could do "gitk `git-lost+found 
> -t commit`" to see lost commits, and reconnect them as desired. (Making up 
> command line syntax for listing only the commits.)

That is certainly cleaner.  The only downside is fsck-objects
that lost+found uses tends to be expensive operation, and what
you would want to do with the information may be more than just
use it on the command line of gitk.  But in any case the user
could store git-lost+found output in a file to do whatever she
wants, so it may not matter.
