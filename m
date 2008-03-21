From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 02:15:48 -0700
Message-ID: <7vzlssphdn.fsf@gitster.siamese.dyndns.org>
References: <47E37A63.9070209@glidos.net>
 <7v4pb0qw28.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 10:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcdMc-0007TX-Ei
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 10:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYCUJP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 05:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYCUJP5
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 05:15:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbYCUJP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 05:15:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A11232C62;
	Fri, 21 Mar 2008 05:15:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 096002C61; Fri, 21 Mar 2008 05:15:51 -0400 (EDT)
In-Reply-To: <7v4pb0qw28.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 21 Mar 2008 02:13:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77732>

Junio C Hamano <gitster@pobox.com> writes:

> Paul Gardiner <osronline@glidos.net> writes:
>
>> I need a command that will find the remote branch from which
>> the currently checked out branch was started. I don't know
>> git very well, and the only way I can think to do it so far
>> is to iterate over the remote branches and find the one
>> for which git-rev-list <branch>..HEAD gives the smallest
>> number of objects. I'm guessing there must be a better
>> way. Any ideas?
>
> There will be _no_ way.  It is simply impossible.
>
>     $ git checkout -b my-new-branch origin/somerandombranch~27^2^2~23
>
> is a perfectly valid way to create a new branch.
>
> You would probably want to re-think in a bigger picture, _why_
> you would want to find such information, in other words, how you would
> want to use the information (if such a thing were possible) to solve
> _what_ problem.  That true problem you did not mention (and assumed that
> "the remote branch the branch was branched from" would be a good tool to
> solve it) might have a better solution.

Having said that, have you tried:

	$ git reflog show that_local_branch

and looked for "branch: Created from blah"?
