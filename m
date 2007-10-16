From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 16 Oct 2007 12:16:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161209480.25221@racer.site>
References: <20071016060456.GC13801@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhkPm-0007DY-7I
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbXJPLQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 07:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbXJPLQg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:16:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:59853 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758132AbXJPLQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 07:16:35 -0400
Received: (qmail invoked by alias); 16 Oct 2007 11:16:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 16 Oct 2007 13:16:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Y+FFLGciY/NaGj5FtMFNkVcrH4Nd01fKX8A7c2u
	22A28plMdYlrgr
X-X-Sender: gene099@racer.site
In-Reply-To: <20071016060456.GC13801@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61147>

Hi,

first let me thank you for being the interim maintainer.  I know it is 
much work, and I frankly do not have the time, or nerve, to do it.  Out of 
curiousity: did you use the scripts in "todo" to send these emails?

On Tue, 16 Oct 2007, Shawn O. Pearce wrote:

> * lt/diff-rename (Tue Oct 2 19:28:19 2007 -0700) 1 commit
>  + optimize diffcore-delta by sorting hash entries.

AFAIR this was ready to go to master, with a 5-10% speedup or so, just 
needing a bit of testing.  Which it should have gotten by now.

> * kh/commit (Mon Sep 17 20:06:47 2007 -0400) 4 commits
>  + Export rerere() and launch_editor().
>  + Introduce entry point add_interactive and add_files_to_cache
>  + Enable wt-status to run against non-standard index file.
>  + Enable wt-status output to a given FILE pointer.

This is the beginning of the builtin-commit.  The option parser has to go 
in before that (it was split out from the builtin-commit series), and the 
(minimal) adjustments to builtin-commit.c for the now-changed option 
parser have to be done.

So I think this topic should stay in master until builtin-commit is there, 
too.

> * js/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
>  + rebase: allow starting from a dirty tree.
>  + stash: implement "stash create"

This needs more work in rebase-i, and Junio indicated that he's not 
completely happy with it.

It would serve to be able to rebase in a dirty tree, by first stashing 
away the changes, and then applying them on top of the rebased branch.

I think that this would avoid many "Huh?" effects, but it should try to 
"git stash apply --index" first, falling back to "git stash apply".

Something like that would be very nice for git-pull, too, I guess.

However, I have not thought through all implications.

Ciao,
Dscho
