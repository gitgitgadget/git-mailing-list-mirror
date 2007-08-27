From: Junio C Hamano <gitster@pobox.com>
Subject: Re: new to git
Date: Mon, 27 Aug 2007 13:39:03 -0700
Message-ID: <7vabsczp94.fsf@gitster.siamese.dyndns.org>
References: <46D32973.8030104@krose.org> <46D33290.20405@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Rose <krose@krose.org>, git mailing list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPlMl-0001Ho-7F
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390AbXH0UjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758113AbXH0UjN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:39:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355AbXH0UjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:39:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1749A129236;
	Mon, 27 Aug 2007 16:39:26 -0400 (EDT)
In-Reply-To: <46D33290.20405@op5.se> (Andreas Ericsson's message of "Mon, 27
	Aug 2007 22:22:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56881>

Andreas Ericsson <ae@op5.se> writes:

> git pull = git fetch + git merge. The notation you use above is obsoleted
> and no longer works in git 1.5.3. Instead you'd have to replace
>
> 	git pull . foo
>
> with
>
> 	git merge foo
>
> which will most likely clear up some confusion.

Huh?  "git pull . foo" has always been the same as "git merge
foo", I thought...  Have we broken anything?

>> (2) Any way to disable this warning:
>>
>> Warning: No merge candidate found because value of config option
>>          "branch.local.merge" does not match any remote branch fetched.
>>
>
> Yes. Edit your .git/config file to add a merge candidate for your local
> branch.

Or, say what branch you get from the remote you want to merge
explicitly.  You may not always merge the same branch from the
remote.  E.g.

	$ git pull origin experimental
	$ git pull origin master

>> (4) I'm still not clear on when a dst should and should not be used in a
>> refspec.  It appears that one can only do non-fast forward updates to
>> the branch that is checked out (which makes sense, since you may need to
>> resolve), but other than that, what is the difference between
>>
>> git checkout foo
>> git pull . master
>>
>> and
>>
>> git checkout master
>> git push . master:foo
>>
>> ?
>>
>
> Here I'm clueless, except that this matches old syntax which is no longer
> valid.

Huh again about "no longer valid" part.

In any case, the former says "I am on foo branch, and I want to
merge 'master' from _MY_ local repository".  The latter says "I
want to update the local branch 'foo' with what is in my
'master' branch, both local".  They are totally different.

Please do _not_ spread backward incompatibility FUD.
