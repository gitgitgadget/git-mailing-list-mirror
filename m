From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 21:50:51 -0700
Message-ID: <7v3badkj4k.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
	<BAYC1-PASMTP0819E6B1CBE028BD171598AE1A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthew L Foster <mfoster167@yahoo.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 27 06:51:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSRNo-0000uh-WA
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 06:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWI0Euy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 00:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWI0Euy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 00:50:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45501 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965133AbWI0Eux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 00:50:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927045052.CJGK18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 00:50:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TGqp1V0051kojtg0000000
	Wed, 27 Sep 2006 00:50:49 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0819E6B1CBE028BD171598AE1A0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 26 Sep 2006 23:43:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27869>

Sean <seanlkml@sympatico.ca> writes:

> On Tue, 26 Sep 2006 23:34:59 -0400
> Jeff King <peff@peff.net> wrote:
>
>> Right. So you really want to know not "when did this commit enter this
>> repo" but rather "when did this head/branch first contain this commit"
>> (since there may be multiple branches within a repo).
>
> Even though it's being a bit pedantic, I have to disagree with you here.
> The question the user is asking is exactly, "When did this commit enter
> _this_ repo?".
>
> Because of the design of git, such a question must be converted into a
> question regarding reflogs and head/branch values etc...  But the user
> doesn't care anything about all that.  They're just interested in the
> date/time the commit was published in the repository in question, not
> the date time the commit was originally created in some distant
> repo.

I disagree.

For somebody who is tracking my "master" branch, it does not
matter when some critical fix appeared on my "next" branch.  The
user will be vulnerable until that fix makes its way to the
"master" branch.  The user _can_ switch to track my "next"
branch, but that is like arguing that the user can apply the
same patch to his local copy that tracks my "master".

I may try-pull from Paul to get updates from gitk, but usually I
do that with "git fetch", not "git pull".  So my repository may
contain commits and blobs for the latest and greatest gitk, but
until I merge it and push the result out nobody would benefit
from it through my repository.

See?  Having a commit somewhere in the repository does not make
any difference unless that commit is on some branches you care
about.
