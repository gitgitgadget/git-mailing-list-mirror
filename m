From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 12:17:10 -0700
Message-ID: <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 21:17:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4iRW-0006Fo-Jj
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbXF3TRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXF3TRM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 15:17:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39533 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXF3TRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 15:17:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630191711.ZIBD22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 15:17:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HvHA1X00B1kojtg0000000; Sat, 30 Jun 2007 15:17:10 -0400
In-Reply-To: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 30 Jun 2007 11:49:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51246>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Using "git xyzzy" also has some fundamental advantages, like the ability 
> to specify things like paging ("git -p xyzzy") and making the whole notion 
> of aliases act like other git commands (which they already do, but they do 
> *not* have a "git-xyzzy" form!)

In the longer run, we may want to allow "git foo" to alias to
"git foo --preferred-options", although we currently do not
allow such an alias.  Scripts, especially the ones we ship,
would not want to be confused by the user aliases when that
happens.

> Anyway, while actually removing the "git-xyzzy" things is not practical 
> right now, we can certainly start slowly to deprecate it internally inside 
> git itself - in the shell scripts we use, and the test vectors.

So I am somewhat negative on this, unless there is a way for
scripts to say "Even though I say 'git foo', I do mean 'git foo'
not whatever the user has aliased".
