From: Joel Dice <dicej@mailsnare.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 17:07:59 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609191659350.9752@joeldicepc.ecovate.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <eeppkl$rm9$2@sea.gmane.org> <eepq7l$dc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 01:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPohA-0006XG-Ho
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 01:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWISXIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 19:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbWISXIA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 19:08:00 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:4999 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1751345AbWISXIA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 19:08:00 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id 66F092C0D0;
	Tue, 19 Sep 2006 23:07:58 +0000 (UTC)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eepq7l$dc$1@sea.gmane.org>
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27312>

On Wed, 20 Sep 2006, Jakub Narebski wrote:

> Jakub Narebski wrote:
>
>> Joel Dice wrote:
>>
>>> I'm considering adopting Git for a medium-sized project which is currently
>>> managed using Subversion.  I've used Git for a few smaller projects
>>> already, and the thing I've missed most from Subversion is the convenience
>>> of incrementing revision numbers.  The following is a proposal to add this
>>> feature to Git.
>>>
>>>
>>> Rationale:
>>>
>>> Incrementing revision numbers (IRNs - an acronym I just made up) are
>>> useful in that they can be treated as auto-generated tags which are easier
>>> to remember and communicate than SHA hashes, yet do not require extra
>>> effort to create like real tags.  Also, they have the advantage of being
>>> chronologically ordered, so if I assert that a bug was fixed in revision
>>> 42 of a shared repository, everyone may assume that revision 45 has that
>>> fix as well.
>>
>> That is true _only_ if you have linear history. If you have multiple
>> concurrent branches, revision 42 can be in branch 'next', revision '45' in
>> topic branch 'xx/topic' which forked before revision 42, and do not have
>> the fix.
>
> Additionally, what does _chronological_ mean? Time the commit is recorded?

Yes.

> Remember that in distributed development commits can be fetched from other
> repository, or arrive via email and applied using git-am. In git you can
> also rebase branch. Git records merges, and said merges are sometimes
> just fast-forward. All those difficulties have to be solved for IRNs.

All of these boil down to pointing the head of a branch to a new commit 
object, right?  I'm simply proposing that every time this happens, that 
new commit object (which may not really be *new*), should be appended to 
the IRN history file, along with any commits attached to it (as in the 
cases of fetch, etc.).

  - Joel
