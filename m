From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:58:48 +0200
Message-ID: <20080909235848.GE7459@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdD7k-0002Ez-KX
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYIIX6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbYIIX6t
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:58:49 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42112 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYIIX6t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:58:49 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 434715465; Wed, 10 Sep 2008 01:58:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95468>

Linus Torvalds wrote:
>On Tue, 9 Sep 2008, Stephen R. van den Berg wrote:
>> Jakub Narebski wrote:
>> >I understand that multiple origin fields occur if you do a squash
>> >merge, or if you cherry-pick multiple commits into single commit.
>> >For example:
>> > $ git cherry-pick -n <a1>
>> > $ git cherry-pick    <a2>
>> > $ git commit --amend        #; to correct commit message

>> Correct.

>All those operations are commonly used (along with "git rebase -i") to 
>clean up history in order to show a nicer version.

Actually, I'd suggest that cherry-pick takes an -o flag which turns on
the origin link.  This needs to be a concious decision because one deems
the history relevant.  This typically is a Good Thing when the
development has several long-term-stable branches which never get merged
with each other, yet they receive frequent backports (using cherry-pick)
between them.

>The whole point of "origin" seems to be to _destroy_ that.

Only in the case where the committer thinks the history is of interest,
and even then, since the origin link is in the header, displaying it or
not suddenly is under the control of git.
Had it been in the free-form textarea, there'd be no way suppress the
display of it.

>I would refuse to ever touch anything that had an "origin" pointer, so if 
>git were to add that feature, it would be a huge disappointment to me. I'd 
>have to have a version that makes sure that anything it pulls hasn't been 
>crapped on by somebody who added a stupid link to some dirty history that 
>I'm not at all interested in seeing.

As you might have noticed, the actual process of pulling/fetching
explicitly does *not* pull in the objects being pointed to.
That, in turn, will cause the origin link output to be automatically
suppressed.  I.e. you'll never know the difference.

OTOH, if someone adds a free-form link to the commit message, you
essentially cannot hide that and are just suffering the clutter without
having any use for it.

>IOW, I'm seeing a _lot_ of downsides, and not any actual upsides. What are 
>the upsides again? 

The upsides are:
- If your repository contains the proper branches, it will show a richer
  content.
- If your repository lacks the proper branches, it will show a *reduced*
  clutter content (because actual free-text references in the commit
  messages will decrease).

I see a lot of upsides, what were the downsides again?
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
