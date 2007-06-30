From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 13:08:10 -0700
Message-ID: <7vtzspb3yt.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	<7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706301231200.1172@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 22:08:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jEs-0005CY-NK
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbXF3UIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbXF3UIM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:08:12 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54161 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbXF3UIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:08:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630200811.UYAR3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 16:08:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Hw8A1X00V1kojtg0000000; Sat, 30 Jun 2007 16:08:11 -0400
In-Reply-To: <alpine.LFD.0.98.0706301231200.1172@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 30 Jun 2007 12:43:55 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51251>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Well, we have a more serious issue, that is related, but has nothing to do 
> with aliases.
>
> If you set an environment variable "diff.color=always", any script will 
> get that behaviour, and not work the way it might expect.
>
> My point being that this has nothing to do with "git-diff" vs "git diff", 
> and everything to do with default configurations. If you don't want people 
> to be able to change fixed behaviour, you'd need to have a way to disable 
> it.

That's exactly why we have told people to use plumbing in their
scripts, and git-diff-tree does not look at diff.color.

> Quite frankly, I think it's _easier_ to disable with "git xyzzy" than with 
> "git-xyzzy", but hey, not a big deal. With "git xyzzy", we could add a 
> generic flag like
>
> 	git - xyzzy
>
> to make the rule be that no configurations (_including_ aliases) are 
> allowed to override default behaviour, which is much harder with the 
> "git-xyzzy" format (since then it's invariably a per-command thing).

But that would break existing scripts wouldn't it?
