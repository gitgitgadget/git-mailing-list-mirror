From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Mon, 05 Feb 2007 22:37:42 -0800
Message-ID: <7vveifkczt.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<87y7nbdeaw.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 07:37:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEJxd-0006SM-2b
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 07:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbXBFGho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 01:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXBFGho
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 01:37:44 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:49230 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750698AbXBFGhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 01:37:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206063744.GQUN1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 01:37:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L6di1W00h1kojtg0000000; Tue, 06 Feb 2007 01:37:43 -0500
In-Reply-To: <87y7nbdeaw.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	05 Feb 2007 21:51:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38813>

Carl Worth <cworth@cworth.org> writes:

> So, could we fix this so that a remote branch name will resolve
> without the "origin/" prefix if it is not ambiguous?

I am fairly negative on this one, especially I do not think the
symptom deserves to be described with the word "fix".  DWIM is
good, but it has bounds, and this particular one feels it is
slightly on the other side of the boundary.  We currently only
DWIM out of a fixed set of patterns -- if you want to extend it,
it would now require readdir() to expand.

> I can imagine the resolution rules are already fairly complicated, (I
> don't even know what they all are already).

If you add another DWIM rule, then I suspect that you would have
harder time explaining why they get "hey, that is ambiguous"
error.
