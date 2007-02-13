From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 18:02:27 -0800
Message-ID: <7vodny4xxo.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 03:02:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGn04-00053W-QW
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 03:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbXBMCC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 21:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965470AbXBMCC3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 21:02:29 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55239 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933032AbXBMCC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 21:02:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213020228.YDNK21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 21:02:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nq2T1W00f1kojtg0000000; Mon, 12 Feb 2007 21:02:28 -0500
In-Reply-To: <45CFA30C.6030202@verizon.net> (Mark Levedahl's message of "Sun,
	11 Feb 2007 18:13:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39480>

Mark Levedahl <mlevedahl@verizon.net> writes:

> I am NOT intending to start a flamewar O:-) , so please don't turn
> this into one.

Heh, a lofty goal.  And I am glad to see that a thread full of
constructive suggestion is already going on.

So now I do not have to fear starting a flamewar; I can safely
vent.

> The recent threads on a mingw git port are explicit in the intent to
> provide a Windows native git. I believe there is a fundamental
> conflict here with the position, clearly stated by Linus, that git
> does not alter content in any way. Windows suffers the curse of DOS
> line endings (\r\n vs \n), and a true port to Windows *must* allow for
> \r\n and \n to be semantically the same thing as most large projects
> end up with a mixture of such files and/or are targeting
> cross-platform capabilities. The major competing solutions git seeks
> to supplant (cvs, cvsnt, svn, hg) have capability to recognize "text"
> files and transparently replace \r\n with \n on input, the reverse on
> output, and ignore all such differences on diff operations. To be
> relevant on native Windows, git must do the same. Otherwise, git will
> be deemed "too wierd" and dismissed in favor of a tool "that works."
> 
> There is no use to debating the technical merits of \r\n vs \n vs \r
> vs whatever, nor of not converting. Really. Just accept that there is
> a fundamental requirement that any version control tool on Windows be
> able to silently convert between \r\n and \n. To believe otherwise is
> to expect that the conversion be pushed elsewhere into the tool chain
> in use, and that won't happen as the competition already provide this
> conversion capability.

I think there is a fundamental misconception in the above.  I do
not know about others, but to me personally, I do not see any
"seeking to supplant", nor "competition".  It's not like I or
people who raised git into the current shape are begging to
windows users to consider using git and bending backwards to
please them.  You should hone your diplomacy.

Current git may or may not match what they need, and if it does
not match what they need, making it match what they need is
primarily the responsibility of them.  If Windows users find
something in git that is interesting and useful, but if they
find something else lacking in it to be truly useful for them,
they can submit patches, or if they cannot implement the changes
themselves but only have wishlist items, then _they_ can do the
begging.

People in git community are certainly friendly and helpful
bunch, and some (including me) are unfortunate enough that
sometimes they have to touch Windows, so some degree of need is
felt to support Windows better even within the community, but it
has never been high priority.  Making it higher priority by
bringing in better ideas and starting the fire must come from
people who care more about Windows than me and Linus.

> So, I think the git project needs to come to an explicit position on
> this, basically being:
>
> 1) git is a POSIX only tool (i.e., there will be no \r\n munging), or
> 2) a Windows port of git will handle and mung \r\n and \n line endings.

I do not think git project needs to do any such thing.  The
project evolves reflecting the needs of its users, and the
design is not decided upfront without doing any feasibility
study.  I would certainly not say our position is (1), IOW, I
would not say we will rule out Windows support.  If it can be
reasonably done without harming the code, why not?

Depending on how cleanly a change Windows users want is done
without negatively affecting the existing users, it may or may
not be judged acceptable.  We will know only when we see at
least the design and preferably the code.  I feel no need to
decide between (1) and (2) upfront before that happens.

> If the answer is 1, the mingw port is a waste of time as it simply
> won't be usable by its target audience. If the answer is 2, then I
> think a very careful design of this capability is in order.
>
> Comments?

This is not just you, and fortunately it does not happen very
often in git community, but I find it _very_ irritating when
somebody says: "here is a patch, I'll do the doc, test, and
tidying up if this patch is accepted".  I usually pretend to be
a nice person and accept the patch when it is obviously good,
or pretend that I was too busy and did not notice such a
message, but I feel _very_ tempted to say: "if you care deeply
enough that what you did is useful, I expect you'd perfect it
whether or not I apply your patch to my tree right now.  If even
the original author, you, do not find it worth perfecting, then
I am not interested at all."

Even if all existing git community members felt (1) above and
were unwilling to accept line-end conversions (which by now you
already know is not the case -- and that is why I waited until
now to address this as a separate "attitude" issue), if somebody
who works on Windows is motivated enough to make git work better
for him, he can fork (and forking is very easy with git).  If
the forked git works well both on Windows and on non Windows,
people who initially felt (1) will realize that they were wrong
and then the codebase can be merged back together (and merging
the forked projects is very easy with git).

It's open source.  People shouldn't worry too much about what
they have done "wasted".  You are not even talking about what
you've already done -- you are talking about what you _might_
do.

And your saying "If 2, then we need to think carefully" was VERY
good.  My point is that you did not have to say "Is it 1, or is
it 2, and if 2 then" part.
