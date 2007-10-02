From: Jeff King <peff@peff.net>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Tue, 2 Oct 2007 15:17:37 -0400
Message-ID: <20071002191737.GB7901@coredump.intra.peff.net>
References: <47029414.3080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnFc-0004Ua-KS
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbXJBTRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbXJBTRk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:17:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1380 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbXJBTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:17:39 -0400
Received: (qmail 6515 invoked by uid 111); 2 Oct 2007 19:17:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 15:17:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 15:17:37 -0400
Content-Disposition: inline
In-Reply-To: <47029414.3080100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59715>

On Tue, Oct 02, 2007 at 01:55:16PM -0500, Dan Zwell wrote:

> A small personal git repository has started lying to me about changed files. 
> git-diff sometimes tells me that the index has no changes from HEAD, while 
> other commands (git-status, at least) seem to tell the truth. It is the same 

Perhaps you are confused by the fact that "git-diff" with no options
shows the difference between the index and the working tree? Did you try
"git-diff --cached"?

> after I commit the new changes--at that point, "git-diff-tree HEAD^ HEAD -p" 
> spits out a nice patch, but "git-diff HEAD^ HEAD" gives nothing.

That doesn't seem right. Can you reproduce this, or at least show us the
command you used?

> $ git status
> # On branch bak_linear-checks3
> nothing to commit (working directory clean)
> $ echo "test" >> Makefile
> $ git status
> # On branch bak_linear-checks3
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   Makefile
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git diff
> $

OK, that does seem wrong. If you run git-diff-files, does it produce the
expected output?

-Peff
