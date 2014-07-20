From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v1] rebase --root: sentinel commit cloaks empty commits
Date: Sun, 20 Jul 2014 21:52:06 +0100
Message-ID: <291ABB60-4B66-4211-A561-048F10089B82@arachsys.com>
References: <53A18198.7070301@gmail.com> <8d5cf2e1ff45e2e60072bf6c6e05371e4b265709.1405539123.git.bafain@gmail.com> <871tti50l8.fsf@thomasrast.ch>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Fabian Ruch <bafain@gmail.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Jul 20 22:52:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8y5n-0007og-2o
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 22:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbaGTUwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 16:52:19 -0400
Received: from cdw.me.uk ([91.203.57.136]:45849 "EHLO cdw.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbaGTUwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 16:52:19 -0400
Received: from [81.2.114.212] (helo=chris.lan)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1X8y5f-0004x5-0q; Sun, 20 Jul 2014 21:52:15 +0100
In-Reply-To: <871tti50l8.fsf@thomasrast.ch>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253936>

Thomas Rast <tr@thomasrast.ch> wrote:

>> Please take a closer look at the last two test cases that specify the
>> expected behaviour of rebasing a branch that tracks the empty tree.
>> At this point they expect the "Nothing to do" error (aborts with
>> untouched history). This is consistent with rebasing only empty
>> commits without `--root`, which also doesn't just delete them from
>> the history. Furthermore, I think the two alternatives adding a note
>> that all commits in the range were empty, and removing the empty
>> commits (thus making the branch empty) are better discussed in a
>> separate bug report.
> 
> Makes sense to me, though I have never thought much about rebasing empty
> commits.  Maybe Chris has a more informed opinion?

I definitely agree with you both that --root should be (and isn't)
consistent with normal interactive rebasing. The difference isn't deliberate
on my part.

On a personal note, I've always disliked the way interactive rebase stops
when you pick an existing empty commit or empty log message rather than
preserving it. Jumping through a few hoops is perhaps sensible when you
create that kind of strange commit, but just annoying when picking an
existing empty/logless commit as part of a series. But as you say, that's
a separate issue than --root behaving differently to non --root.

Cheers,

Chris.
