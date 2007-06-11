From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] gitweb: 'commitdiff' view improvements
Date: Sun, 10 Jun 2007 17:36:06 -0700
Message-ID: <7vlker49ah.fsf@assigned-by-dhcp.cox.net>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXtD-0004fL-Jn
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760540AbXFKAgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763305AbXFKAgJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:36:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41030 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760540AbXFKAgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 20:36:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611003607.HQOG12207.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 20:36:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A0c71X0031kojtg0000000; Sun, 10 Jun 2007 20:36:07 -0400
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201> (Jakub Narebski's
	message of "Fri, 08 Jun 2007 13:24:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49806>

Overall it makes the view of merge commit much more pleasant.
Good job.

[1/6]
Jakub Narebski <jnareb@gmail.com> writes:

> To save space links are shown as "n", where "n" is number of a parent,
> and not as for example shortened (to 7 characters) sha1 of a parent
> commit.  To make it easier to discover what links is for, each link
> has 'title' attribute explaining the link.

Nice; this is a good way to give "diff $it^$n $it".  The 'title'
does not feel that useful but it does not add much to the weight
of the payload so it probably is Ok.

> Example output:
>                           1       2       3 
>   Makefile      patch | diff1 | diff2 | diff3 | blob | history
>   cache.h       patch | diff1 | diff2 | diff3 | blob | history

It is now tempting to change diff[1234...] for each path to
"diff", isn't it?

[3/6]
Jakub Narebski <jnareb@gmail.com> writes:

> This commit makes git_patchset_body easier to read, and reduces level of
> nesting and indent level. It adds more lines that it removes because of
> extra parameter passing in subroutines, and subroutine calls in
> git_patchset_body. Also because there are few added comments.

Very nice.  That gigantic loop in patchset_body has always been
an eyesore.  The main loop is much easier to follow now.
