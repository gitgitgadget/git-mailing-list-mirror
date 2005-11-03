From: Junio C Hamano <junkio@cox.net>
Subject: Re: New ASCII Art
Date: Thu, 03 Nov 2005 12:30:28 -0800
Message-ID: <7vhdatfp97.fsf@assigned-by-dhcp.cox.net>
References: <E1EXSDW-0005aC-RG@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 21:32:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXljJ-0003nM-Rn
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 21:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVKCUac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 15:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVKCUac
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 15:30:32 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59294 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030467AbVKCUab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 15:30:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103202950.GQBQ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 15:29:50 -0500
To: jdl@freescale.com
In-Reply-To: <E1EXSDW-0005aC-RG@jdl.com> (jdl@freescale.com's message of "Wed,
	02 Nov 2005 17:40:30 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11093>

jdl@freescale.com writes:

> So, I have updated drawings for consideration.  See if you buy
> these.  And if so, let's ponder where they might go.  Then
> I'll patch 'em in...

Thanks for doing this.  You have a sale.

> Fundamental Git Index Operations

README (which is included as git(7) Discussion section) might be
a good document to decorate with this.  Probably after "The
Workflow; 5) Tying it all together".

> Git Merge Operations
> ====================
>
>                     +-----------+
>                     | Object DB |
>                     |  Backing  |
>                     |   Store   | -------+
>                     +-----------+        |
>                                          |
>                            read-tree -m  |
>   +-----+                  tree obj      |
>   |patch|                                |
>   +-----+           +-----------+        |
>      |              |   Index   | <- - - +
>      +------------->|  "cache"  | - - - >+
>  git-apply --index  +-----------+        |
>                                          |
>                                          |
>                          read-tree -m -u |
>  +-----+                        tree obj |
>  |patch|                                 |
>  +-----+            +-----------+        |
>     |               |  Working  |<-------+
>     +-------------->| Directory |
>   git-apply         +-----------+

Note that apply --index updates both index and working tree.
Note that read-tree -m -u takes information from both odb and
index, and updates both index and working tree.

Logically this belongs to "Merging two branches" in the Tutorial
document.  The Tutorial introduction claims the document intends
to show how the core level operates to implement higher level
scripts, but currently we lack the lower-level details in the
text that would go well together with this illustration.  Please
remind me that I should write something up at the very end of
that section soonish ;-).

> Git Diff Types

Maybe as a side note to "Inspecing Changes" section in the
Tutorial.

> Commit DAG Revision Naming

As an illustration to "SPECIFYING REVISIONS" section of
git-rev-parse(1).
