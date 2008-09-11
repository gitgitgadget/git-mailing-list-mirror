From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 21:23:56 +0200
Message-ID: <20080911192356.GC1451@cuci.nl>
References: <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdrms-0003nR-Vb
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 21:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbYIKTX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 15:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbYIKTX6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 15:23:58 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:37265 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYIKTX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 15:23:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id C82665465; Thu, 11 Sep 2008 21:23:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95629>

Linus Torvalds wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> >delete of the origin branch will basically make them unreachable.

>> False.

>Stephen, here's a f*cking clue:
> - I know how git works.

I'd presume you do, but that doesn't mean you always accurately express
yourself.

>> If you fetch just branches A, B and C, but not D, the origin link from A
>> to D is dangling.  Once you have fetched D as well [..]

>So I just said we deleted beanch 'D', so there's no way to ever fetch it 
>again.

You did not state you deleted branch 'D' on the repository being fetched
*FROM*.  I assumed you meant you deleted branch 'D' on the repository
doing the fetching (after having fetched 'D' in the past).

>Get it?

"You stupid git".

>The fact is, a big part of git is temporary branches. It's one of the 
>*best* features of git. Throw-away stuff. Those throw-away branches are 
>often done for initial development, and then the final result is often a 
>cleaned-up version. Often using rebase or cherry-picking or any number of 
>things.

Indeed, features I value in git very much, and use every day, thanks.

[...portions of man git-cherry-pick stripped...]

>Can you not understand that? The "origin" field is _garbage_. It's garbage 
>for all normal cases. The original commit will not ever even EXIST in the 
>result, because it has long since been thrown away and will never exist 
>anywhere else.

The origin field will *not* be created on regular cherry-picks, this
*would* create garbage.  The origin field is not meant to be generated
when doing things with temporary branches.  The origin field is meant to
be filled *ONLY* when cherry-picking from one permanent branch to
another permanent branch.  This is a *rare* operation.

>Garbage should be _avoided_, not added.

Quite.

I do understand that "normal cases" in your case mean cherry-picks among
temporary branches.
Well, you are completely right that *your* normal cases should not (and
will not) generate an origin field.
The origin field is intended for the *abnormal* cases, which means
cherry-picking between permanent branches (which, apparently, you rarely
do, if ever), this is something that (depending on your workflow) can be
a more frequent event.  For *those* cases, the origin field will not
contain garbage.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
