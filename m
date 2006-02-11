From: Junio C Hamano <junkio@cox.net>
Subject: Re: Resetting paths
Date: Fri, 10 Feb 2006 21:18:23 -0800
Message-ID: <7vpslupj6o.fsf@assigned-by-dhcp.cox.net>
References: <7vlkwjzv0w.fsf@assigned-by-dhcp.cox.net>
	<43EC7CB0.5040804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 06:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7n9a-00046Q-4q
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 06:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWBKFSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 00:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWBKFSZ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 00:18:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9892 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750791AbWBKFSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 00:18:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211051558.HARZ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 00:15:58 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43EC7CB0.5040804@op5.se> (Andreas Ericsson's message of "Fri, 10
	Feb 2006 12:44:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15927>

Andreas Ericsson <ae@op5.se> writes:

> How about "git update-index --undo path...", possibly with "git reset
> path..." as a shorthand.

While "git reset path..." may make sense, "update-index --undo"
does not make any sense from the core point of view.  That
command is about interaction between index and working tree file
and does not know anything about "the last commit", "the current
head commit", nor tree objects in general, so it does not know
where to get the undo information from.

I'll find time to code a prototype for "git reset path..." up
unless somebody beats me to it.
