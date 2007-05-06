From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sun, 06 May 2007 10:43:31 -0700
Message-ID: <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0705061851411.4015@racer.site>
	<vpqk5vlamav.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun May 06 19:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkkmE-0002E7-HC
	for gcvg-git@gmane.org; Sun, 06 May 2007 19:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbXEFRoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbXEFRn6
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 13:43:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35704 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbXEFRnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 13:43:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506174331.SRRJ13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 6 May 2007 13:43:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id vtjX1W0061kojtg0000000; Sun, 06 May 2007 13:43:31 -0400
In-Reply-To: <vpqk5vlamav.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun,
	06 May 2007 19:34:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46352>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> You don't necessarily see your error from the file list:
>
> % vi foo.c
> % git add foo.c
> % vi foo.c
> % git commit -m foo
> [...]
>  create mode 100644 foo.c
> %
>
> This commited the old content of foo.c, while I hardly see any
> scenario where this is the expected behavior.

One reason why is because you are using "-m foo" (a very
non-descriptive commit message that would not help anybody
including yourself in the future).  Try the above without giving
such a bogus error message with "-m" to commit, but instead let
it spawn your editor --- you would be doing that in real-life
when you are doing anything nontrivial.  Then notice what
appears on the file list of "Changed but not updated" section.

A single liner "-m" is handy for "Oops, typofix in foo.c" kind
of commit, but in such a case you literally would be changing
only the typofix and won't have "edit foo.c; git add foo.c; edit
foo.c; git commit" sequence anyway.

I think Linus explained quite well to correct your doubts in
your original message, and I do not have anything to add.
