From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 12:55:28 -0800
Message-ID: <7vll05e9j3.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 21:57:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXm7c-0007dn-52
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 21:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVKCUzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 15:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVKCUzb
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 15:55:31 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2761 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932569AbVKCUza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 15:55:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103205445.GUMO776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 15:54:45 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EXTw5-00063o-Gt@jdl.com> (Jon Loeliger's message of "Wed, 02
	Nov 2005 19:30:37 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11095>

Jon Loeliger <jdl@freescale.com> writes:

> Finally, a procedure or style question.  Should this
> write-up be in the form of a structured FAQ?  A stand-alone
> expository document?

Earlier I suggested bunch of unconnected Documentation/howto
pages, but I'd like to take it back at least partially.  I have
two alternatives; I do not know which one I prefer more...

A table-of-contents (FAQ-list) with task-oriented categorization
would help guide the users facing "Now What?" situation.  It
might start like this:

	It broke after you tried to ...

	* pull from remote
	  breakage #1 --> see this...
	  breakage #2 --> see that...
	  ...

        * checkout a branch
	  breakage #1 --> see this...
	  breakage #2 --> see that...
	  ...

and each breakage and solution would be a separate document.

If we go with this separate FAQ-list approach, I'd love to keep
the result under Documentation/ hierarchy we ship as part of the
source, but I suspect that building-up this kind of thing might
be better suited to Wiki.  I wonder if there is a Wiki whose
document storage format is in asciidoc, and uses git as its
revision control backend.  Then we could let people update Wiki,
and occasionally merge from there.  We also should be able to
push things back to Wiki, essentially treating Wiki as one of
the repositories from the git side.  Hmm...


The other alternative is to add "NOW WHAT" section to each man
page.  The idea is that "if the last command you ran was this
command and if it did not do what you wanted it to do, here are
its common failure modes and how you would recover from them".
So the materials we covered during the failed pull/merge
discussion would go to "NOW WHAT" section of git-pull(1), with
perhaps git-merge(1) saying "See also".

We would want "EXAMPLES" section for all the major commands as
suggested by Linus anyway, and going this way we _may_ be able
to get away without coming up with the higher level problem
categorization; the user would at least know what the last
command he tried to use was already.
