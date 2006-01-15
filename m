From: Junio C Hamano <junkio@cox.net>
Subject: Re: cvs-migration.txt
Date: Sun, 15 Jan 2006 13:11:37 -0800
Message-ID: <7vy81h2o3a.fsf@assigned-by-dhcp.cox.net>
References: <20060115195804.GD3985@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 22:11:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyFAI-0004JG-8c
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 22:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWAOVLl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 16:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWAOVLl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 16:11:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31991 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750802AbWAOVLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 16:11:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115210930.WXUL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 16:09:30 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060115195804.GD3985@fieldses.org> (J. Bruce Fields's message
	of "Sun, 15 Jan 2006 14:58:04 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14711>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I find the following sentence from cvs-migration.txt slightly confusing:
>
> 	"The cut-off is date-based, so don't change the branches that
> 	were imported from CVS."
>
> I assume the branches referrred to are the target git branches, not the
> source CVS branches?  (And are date-based cut-offs really the essential
> reason for this restriction?)

Sorry, I cannot answer this one immediately without researching
myself; I do not use cvsimport.

The way I read the code agrees with you.  The date from the
topmost commit from each git branch is read, and used to limit
the changes we read from CVS into them.  The code reads from
"author date", which is technically incorrect, but what we are
saying here is that you should never commit into these branches
yourself and let cvsimport be the only one that touch them, so
using commiter date and author date would not make a difference.
