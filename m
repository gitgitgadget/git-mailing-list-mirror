From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 15:44:07 -0800
Message-ID: <7virro6qt4.fsf@assigned-by-dhcp.cox.net>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7LSQ-0008OG-20
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWBIXoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWBIXoL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:44:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10425 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750836AbWBIXoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 18:44:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209234102.LFGF17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 18:41:02 -0500
To: Tony Luck <tony.luck@intel.com>
In-Reply-To: <12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
	(Tony Luck's message of "Thu, 9 Feb 2006 15:14:59 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15840>

Tony Luck <tony.luck@intel.com> writes:

> So is there an easy way in git to take the series of commits
> from a topic branch, make a new branch with all those commits
> as just one commit ... with an open editor on the concatenated
> commit comments (If there were just typo fixes the comment
> from the first commit would apply, but sometimes the follow-on
> commits would have substantive changes).

I do not have a script to do so but my guess is that would be a
20-30 line shell script.  Use cherry to find which ones to pick,
run diff-tree on them to extract patches, run apply --index on
each of them in turn, and dump "git log master..topic" to your
editor and you are done.  The editor would have the commit log
to be edited while working tree and the index would have a
ready-to-commit tree with all the changes applied.
