From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 0/8] use "git diff" in the test suite
Date: Sun, 25 Feb 2007 15:11:29 -0800
Message-ID: <7vps7xrfxa.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702252329550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 00:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSWj-0002Of-OZ
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 00:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbXBYXLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbXBYXLb
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 18:11:31 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48560 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965196AbXBYXLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 18:11:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225231130.QWCO6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 18:11:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TzBV1W00M1kojtg0000000; Sun, 25 Feb 2007 18:11:30 -0500
In-Reply-To: <Pine.LNX.4.63.0702252329550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 25 Feb 2007 23:34:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40593>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now that --no-index is supported by git's diff, we can use much of the 
> test suite to do the job, instead of relying on GNU diff.
>
> This is a bit work-in-progress, since the handling of "-" as a filename is 
> not fleshed out yet, and we really should have the "--quiet" option. But I 
> got side-tracked by the edit-patch-series script, and did not want to hold 
> these patches off any longer.

As you said yourself [6/8], [7/8], and [8/8] are mechanical
conversions, and I do not think it is too much effort involved
on your side to "hold these patches off".

My preference is to apply [1/8] now, cook the result in 'next'
for a few days longer to see if anybody complains or finds
glitches in the diff-ni series so far, push it out to 'master'
and then apply [2/8] and [3/8] while on 'master'.  The remainder
would be forked into a topic branch and cooked in 'pu' and then
'next' as usual.

Also I do not think we would necessarily want [7/8] and [8/8].
It would help with tests on broken distributions whose 'cmp'
misbehaves when the output is redirected to /dev/null, but I do
not think it is a good enough reason to make the tests slower.
