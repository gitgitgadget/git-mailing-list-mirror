From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] format-patch stuff
Date: Sat, 12 May 2007 13:24:25 -0700
Message-ID: <7vy7jtx01y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705121109520.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 12 22:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmy8m-0003sx-KF
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbXELUY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755009AbXELUY1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:24:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33908 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbXELUY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:24:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512202426.QHXK6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 16:24:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yLQR1W00A1kojtg0000000; Sat, 12 May 2007 16:24:25 -0400
In-Reply-To: <Pine.LNX.4.64.0705121109520.18541@iabervon.org> (Daniel
	Barkalow's message of "Sat, 12 May 2007 11:36:54 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47090>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It would be nice if git-format-patch would generate a [PATCH 0/n] message 
> at the start of the series if some option were given. This would, of 
> course, have to be editted afterwards to include actual information, but 
> it would at least be pre-generated in series and with the configured 
> headers and such.

It would be helpful for git-send-email users.  I've done that by
hand by copying 0001-*.txt to 0000-*.txt and editing as needed
by hand.

> Shouldn't the format.headers configuration automatically apply the correct 
> line termination? Currently, you need to know to put in \r\n at the end of 
> each one, and the example isn't even right (only puts \n).

Sorry, I do not follow.  Where does that "\r\n" come from?  If
you are talking about RFC 2822 line ending conventions, I think
that is a job for MUA (including git-send-email).  Remember,
MUA's are not the only consumer of format-patch output.

Although "2.3. Body" says "CR and LF MUST only occur together as
CRLF", the body of the text we output from format-patch is a
straight text with LF termination and let the MUA handle that
SMTP specific conversion.  I do not think there is reason to
treat the header part any differently.
