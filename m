From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 23:38:14 -0800
Message-ID: <7vfyav8ae1.fsf@assigned-by-dhcp.cox.net>
References: <20070101034825.GD15537@fieldses.org>
	<951491.40207.qm@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jan 01 08:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Hkc-0007vF-PJ
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 08:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbXAAHiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 02:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbXAAHiV
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 02:38:21 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39239 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928AbXAAHiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 02:38:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101073819.CHJB19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 02:38:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5jdX1W00C1kojtg0000000; Mon, 01 Jan 2007 02:37:33 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <951491.40207.qm@web31807.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Sun, 31 Dec 2006 21:13:49 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35729>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> ...
>> Could you explain a situation where this would be useful?
>
> I don't know how to respond to this question.
>
>>  A
>> "parent<-->child" relationship, where there's one upstream branch that
>> is always merged in, is easily handled;
>
> e is the base of natural logarithms.

You lost me here; I am guessing this is some sarcasm not worth
paying attention to, so I'd ignore this part for now.

>> just replace your "git pull parent" by a "git pull", right?
>
> Yes, but I don't want to just type "git-pull", I want to explicitly
> type "git-pull parent" and depending in which branch I'm at, "parent"
> would have identical meaning but would merge a different branch... because
> I'm in a different branch...
>
>> Am I misunderstanding the proposal?
>
> I did give an example of usage in my email to which you replied.

But what confuses me (and I think JBF shares the same confusion
with me) is that you had only one example "parent".

While I understand that it would make sense to define "parent"
for each branch in a downstream developer's workflow, (1) I do
not see the difference between your wording, "parent", and what
we traditionally have called "origin", and (2) I do not think of
relationship other than "parent" ("origin") that is applicable
commonly (in other words, "worth having your 'symbolic'
mechanism for, because it is so commonly applicable") to
branches offhand.  Hence, JBF's suggestion to use "git pull"
without using noiseword "parent" or "origin" feels very natural
to me --- if there can be only one valid thing to say, why do
you even have to say it?

Because I do not understand what you would want "parent" for and
why "git pull" is not sufficient, I cannot tell if this would
help solving what you are trying to solve in a different way,
but I suspect a useful thing to have might be a per-branch
alias.  For example, we could allow "git merge" without
parameters to alias to "git merge origin/next" when you are on
your 'next' and the same "git merge" could be aliased to "git
merge origin/master" when you are on your 'master'.
