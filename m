From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working directory managment
Date: Wed, 28 Mar 2012 08:41:31 -0700
Message-ID: <7v398sybpw.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
 <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
 <BLU0-SMTP479C08A291DA7BEA81F1875B14B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCv0F-0006zp-TL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab2C1Plf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:41:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab2C1Ple (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:41:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF4F6194;
	Wed, 28 Mar 2012 11:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CKjI/3iXvnjl/MrfV8/Zieq5RS0=; b=te63TV
	GB848FFg8sB65DLBVw/lxUAMpm82L/CA1trdOqkOlk7oapJFLDs+xPqowW+x8JNb
	Ab5Nf3X01LmhTpZjwxXGjBCeN9kX2jHk0GuF4R9bJ2PQC9JMilXB1pEp/cO8ri9+
	bBXg71gK0LH1b+UQh9gA62zPAoPe1tZgnkiU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=It1Uw/Gmth2wvSVXe9hE3UEZ88DhfJ+R
	zVHtB3UqldJ0lxB/XIt4XLmlxHBtGTz1RRW3nMGUfYdcsM9Tm8tEOWmCOjdenwbD
	n3Hbp4ZXKojTv+79l0oxfA02+eJ98AEealRq9DuXSEjyXaKOhsOGZl3R/ShZ9GzK
	94SiTCzI3hw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B64396193;
	Wed, 28 Mar 2012 11:41:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24A656192; Wed, 28 Mar 2012
 11:41:33 -0400 (EDT)
In-Reply-To: <BLU0-SMTP479C08A291DA7BEA81F1875B14B0@phx.gbl> (Anjib
 Mulepati's message of "Wed, 28 Mar 2012 10:10:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EBABB2C-78EC-11E1-8DAB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194133>

Anjib Mulepati <anjibcs@hotmail.com> writes:

> I was reading Git Community Book and came across following definition
> for working directory
>
> The Working Directory
>
> The Git 'working directory' is the directory that holds the current
> checkout of the files you are working on. Files in this directory are
> often removed or replaced by Git as you switch branches - this is
> normal. All your history is stored in the Git Directory; the working
> directory is simply a temporary checkout place where you can modify
> the files until your next commit.
>
> What does it mean by this " Files in this directory are often removed
> or replaced by Git as you switch branches"?
>
>> I think the common terminology for the concept the above describes is "the
>> working tree".
>>
>>> And does working directory is just a directory we get with $pwd ?
>> After you clone, you have one directory that contains all the files from
>> one specific version in it.  The files may be organized into directory
>> hierarchy, but there is a single top-level directory.
>>
>> That is the "working tree".  When we want to be absolutely clear, we may
>> even say "the top of the working tree", even though it may be redundant.
>>
>> If you are at such a directory, $(pwd) may match it.  If you chdir to a
>> subdirectory from there, e.g. "cd Documentation", $(pwd) and the top of
>> the working tree will of course disagree.
>>
>> The files checked out in the working tree represent the contents of the
>> version that was checked out, plus modifications you make locally.  When
>> you check out a different branch (people coming from svn background may
>> say "switch branch", but it is the same thing), the working tree will need
>> to represent the contents of the version at the tip of that different
>> branch.  If you have a file in the current branch but not in that
>> different branch you are checking out, that file has to go away.  If you
>> do not have a file in the current branch but not in that different branch
>> you are checking out, that file needs to be created in the working tree.
>> If the contents of a file is different between your current branch and the
>> branch you are checking out, the file in the working tree needs to be
>> updated to match that of the branch you are checking out. That is what the
>> "... are often removed or replaced" part is talking about.
>
> So these removed or replaced is done automatically or as I understood
> we do merge and and see conflict and do changes as per necessary?

Ahhh.

Here is one lesson for you to learn first: "Do not top post".  Your
top-posting made me miss the new questions on these two lines.  In the
above quote, I rearranged them to be the bottom.

By default, we do not attempt the content level merges, as that can let
you screw up your merge and allow you to lose your work in progress, when
you check out another branch.  We do however run tree level merges, so
you will carry your local uncommitted changes in the working tree with you
when you check out a different branch.

When you are just starting, make it a habit to commit the work-in-progress
changes you made for the current branch, even if they are not complete,
before checking out another branch. You do not have to worry about what
would happen to the uncommitted changes that way. When you check out the
branch you left again, you "reset HEAD^" to drop the WIP commit and come
back to the state you had.  E.g.

	$ git checkout -b xyzzy master
        $ edit xyzzy.py ;# new file
        $ git add xyzzy.py
        $ git commit -m 'start working on xyzzy feature'
        $ edit xyzzy.py ;# work more
        ... you got bored and want to work on something else ...
        $ git commit -a -m 'WIP'

        $ git checkout -b frotz master
	... at this point, xyzzy.py is removed from the working tree,
        ... as it did not exist in 'master' hence not in 'frotz'.
	$ edit ... ;# do whatever
        $ git commit -a -m 'done with frotz feature'

        $ git checkout xyzzy ;# back on xyzzy branch
	... working tree matches what is in the WIP commit
	$ git reset HEAD^
        ... working tree remains the same, no more WIP commit
	$ edit xyzzy.py ;# continue from where you left off

Try this while you have "gitk" open and see what is happening by observing
its history display (you would have to refresh it) after "git commit",
"git checkout", and "git reset".
