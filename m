From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow fetching references from any namespace
Date: Fri, 11 May 2007 13:54:47 -0700
Message-ID: <7vlkfv9j3c.fsf@assigned-by-dhcp.cox.net>
References: <20070511203522.GA2741@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 22:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmc8o-0000hr-4n
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759630AbXEKUyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759696AbXEKUyu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:54:50 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51630 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759027AbXEKUyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:54:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511205448.YYEC2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 16:54:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xwun1W00m1kojtg0000000; Fri, 11 May 2007 16:54:48 -0400
In-Reply-To: <20070511203522.GA2741@steel.home> (Alex Riesen's message of
	"Fri, 11 May 2007 22:35:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46985>

Alex Riesen <raa.lkml@gmail.com> writes:

> not only from the three defined: heads, tags and remotes.
>
> Noticed when I tried to fetch the references created by git-p4-import.bat:
> they are placed into separate namespace (refs/p4import/, to avoid showing
> them in git-branch output). As canon_refs_list_for_fetch always prepended
> refs/heads/ it was impossible, and annoying: it worked before. Normally,
> the p4import references are useless anywhere but in the directory managed
> by perforce, but in this special case the cloned directory was supposed
> to be a backup, including the p4import branch: it keeps information about
> where the imported perforce state came from.

Have no objection to the patch itself, but mind pointing out
where we broke it (I suspect it is around 1.5.0)?
