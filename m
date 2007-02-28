From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 18:45:41 -0800
Message-ID: <7vr6sb2e5m.fsf@assigned-by-dhcp.cox.net>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
	<Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227154241.GA8228@thunk.org>
	<Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
	<7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
	<7vejob9l70.fsf@assigned-by-dhcp.cox.net>
	<20070228023208.GC2178@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 28 03:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMEpD-0000na-6M
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 03:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXB1Cps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 21:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXB1Cps
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 21:45:48 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35615 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXB1Cpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 21:45:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228024548.KHGF1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 21:45:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uqlm1W00n1kojtg0000000; Tue, 27 Feb 2007 21:45:47 -0500
In-Reply-To: <20070228023208.GC2178@thunk.org> (Theodore Tso's message of
	"Tue, 27 Feb 2007 21:32:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40877>

Theodore Tso <tytso@mit.edu> writes:

> Well, the other design alternative is to make git-show take a list of
> objects, so that
>
> 	git show v1.5.0..v1.5.0.1
>
> ends up displaying the same thing as
>
> 	git show `git-rev-list v1.5.0..v1.5.0.1`
>
> ... but I'm not really convinced that's really all that useful.  

I think we are better off doing "git show v1.5.0..v1.5.0.1" for
that, but we do take multiple objects.

> Note the use of singular.  That would imply that it takes a single
> object, and not a range of objects.  Of course, if the above behavior
> were actually shown to be useful, man pages can always be easily
> changed.  :-)

I find myself running "git show --stat v1.X.Y v1.X.Y+1" every
time I tag a new release Y+2 to find out things like:

	* Should I say "Git v1.5.1" or "GIT 1.5.1"?
	* Ah, I have to update GIT-VERSION-GEN, which I did, good.
