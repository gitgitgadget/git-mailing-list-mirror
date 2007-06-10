From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 00:35:33 -0700
Message-ID: <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	<46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:35:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHxa-0005s3-H0
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760758AbXFJHff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761307AbXFJHff
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:35:35 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50171 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759806AbXFJHfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:35:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610073532.QTRD18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 03:35:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9jbZ1X0081kojtg0000000; Sun, 10 Jun 2007 03:35:33 -0400
In-Reply-To: <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 10 Jun 2007 18:59:13 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49661>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 6/10/07, Pierre Habouzit <madcoder@debian.org> wrote:
>>   FWIW I've begun to work on this (for real). I've called the tool
>> "grit". You can follow the developpement on:
>>
>>   * gitweb: http://git.madism.org/?p=grit.git;a=summary
>>   * git:    git://git.madism.org/grit.git/
>
> Call me a fool, but writing a <new> bugtracker looks like a
> boil-the-oceans scheme.
>
> Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
> what is going to make the difference. Most of those have already the
> ability to "link" to one or more commits -- after the commits are done
> and in GIT.

You are a brave person to say this (no sarcasm --- I wish I
were, too).

On one hand, I very much applaud and appreciate your comment for
injecting sanity to the discussion.  On the other hand, if Linus
had such an attitude, we might not be hacking on git right now.

After looking at the above existing alternatives, some brave
soul might decide and say, "Hey, I can write something better in
2 weeks" ;-).

> So you can tell your bugtracker
> - which commit fixed it -- usually auto-linked if you include the
> bugnumber in the commit message
> - which commit added the test -- auto linked as above
> - which commit introduced the bug -- if such thing exists and someone
> digs it up

All of your examples are going from a single bug to commits, but
from a release person's point of view, you are never interested
in a single bug, just like a top-level maintainer is never
interested in a single file.  A release person would want to go
in the reverse direction: from a commit range to a set of bugs.
What bugs were fixed and what regressions were introduced during
this release cycle.  While embedded ticket numbers in commit log
messages would certainly help, a change made to fix a particular
bug may fix another as its side effect, and the develeoper who
did the change may not know about the latter when the commit log
message is written.

> If the bugtracker can also auto-link things that look committish in
> text entered by users (someone might write "bisect sez that f345e is
> to blame"), with tooltips indicating in which heads those commits
> resides (like gitk does), then it's just gorgeous.
>
> But I would _never_ try to describe all the possible relations in the
> schema -- existing trackers use a liberal mix of regexes and cache
> tables with some free form text fields for this kind of stuff.

These are indeed very good points.
