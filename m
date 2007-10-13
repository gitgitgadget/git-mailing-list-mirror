From: Jeff King <peff@peff.net>
Subject: Re: Imports without Tariffs
Date: Fri, 12 Oct 2007 22:49:10 -0400
Message-ID: <20071013024910.GA26386@coredump.intra.peff.net>
References: <1C0D32ED-59F7-43D4-88B1-D7A9E754D639@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mfwitten@MIT.EDU
X-From: git-owner@vger.kernel.org Sat Oct 13 04:49:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgX4C-0003Le-8P
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 04:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbXJMCtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbXJMCtP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 22:49:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2561 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbXJMCtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 22:49:14 -0400
Received: (qmail 21458 invoked by uid 111); 13 Oct 2007 02:49:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 12 Oct 2007 22:49:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2007 22:49:10 -0400
Content-Disposition: inline
In-Reply-To: <1C0D32ED-59F7-43D4-88B1-D7A9E754D639@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60713>

On Fri, Oct 12, 2007 at 04:36:29PM -0400, mfwitten@MIT.EDU wrote:

> 		(4) Update my git working tree from CVS (at some later time).
> 			
> 			=> cd ../work
> 			=> git cvsimport -a -k -v -r cvs -C . module
> 		
> [PROBLEM]
> 	
> 	git-cvsimport creates new hash IDs for the same ol' commits.
>
> [...]
> 	Therefore, when the updated 'cvs' remote branches are merged into
> 	my local branches, git treats the commits I made with cvsexportcommit
> 	as separate history; thus, history is duplicated and merge commits
> 	appear where they shouldn't.

You are presumably doing a 'git-pull' on the cvsimport-ed commits. Try
doing a git-rebase, which will filter out commits which make the same
changes. Yes, it means throwing away your original commits, but the new
ones should be morally equivalent (and are now the "official" upstream
of the CVS repository).

-Peff
