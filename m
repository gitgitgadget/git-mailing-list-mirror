From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 15:46:41 -0700
Message-ID: <7vhbu2syi6.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
 <7vljjfuibr.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
 <20091013215751.GA12603@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxqA7-0005Yq-N0
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760912AbZJMWrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 18:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760514AbZJMWrs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 18:47:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZJMWrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 18:47:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62A9657285;
	Tue, 13 Oct 2009 18:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fC8zRvnrjKZyWwvzR/fNgp7Vu4g=; b=FyCQs9
	jDLXltMPwABn7OFvWg1W3TQev6kW/5lqRLUz+RYJBiGRhss4iay245zyqCw/SJTo
	DkicxSM90FKFwML4P3vptyT2JXOCWPEZwMPyGO1pfkdBWAEZb8lCjkQ1+uC8NCXb
	WGOCw7gjX9IXT4tag5hmKxD4KoA8bThAYusdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sRcdkodK35SQpWc3mrfHec1zdz/IKN/i
	ZzDlCOrrsZmLm4/9VY+yTShrjVGoglkkxHrf9Zy+7GyzmXbwdPD1hrzdZUaNcSwU
	0Qm67YD0LD++8B193zA5eajiXsTfPmTg2K8uF29bG7FqP/zB2wndEVOj5S9g8ACl
	sp5kUPGNY0M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D238F57280;
	Tue, 13 Oct 2009 18:46:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ABE45727C; Tue, 13 Oct
 2009 18:46:43 -0400 (EDT)
In-Reply-To: <20091013215751.GA12603@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 13 Oct 2009 17\:57\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E4A9A26-B84A-11DE-96F7-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130228>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 13, 2009 at 05:31:46PM -0400, Daniel Barkalow wrote:
>
>> I personally think that the real issue is that our "detached HEAD" message 
>> is still too scary, and what we really want is to issue the scary message 
>> when using "git commit" to move a detached HEAD from what was checked out 
>> to a new commit. So:
>
> This has been discussed before (I happen to agree with you, but you
> probably want to address other comments in the thread):
>
>   http://thread.gmane.org/gmane.comp.version-control.git/38201/focus=38213

I just re-read the discussion again (thanks for a useful pointers).  I
mostly agree with everything said in the thread and obviously agree with
its conclusion, but one thing I noticed that everybody (who _was_ a git
expert) in the thread was assuming bothered me somewhat.

In this sequence:

    1$ git checkout $commit_name_that_is_not_a_local_branch
    2$ git commit; hack; hack; hack;...
    3$ git checkout $branch_name

Step #1 is where the HEAD is detached.  It is correct to argue that
detached HEAD is a different state and we should inform unsuspecting
users, which we do.

Step #2 is where a commit that is not connected to any ref is made.

Step #3 is where the state built in the detached HEAD "branch" vanishes
into lost-found.

The experts argued that #3 is where it is dangerous, and while it is
technically correct, an unsuspecting non-expert would not even _know_ that
nothing dangerous is happening while in step #2.

If the commit name used in step #1 were "v1.0.0", and if the user while in
step #2 ran "gitk v1.0.0" (or "git log v1.0.0"), he will be confused by
not seeing the recent commits.  The distinction between "detached HEAD"
and being on a branch needs to be understood to appreciate this (and taken
advantage of, when running e.g. "git show-branch v1.0.0 HEAD").

Way before step #3, such a user, even though technically not in any danger
yet, would be confused and panic: "I wanted to fix something in the 1.0.0
release, but where did my fix go?"

The current message in step #1 reads like this:

    $ git checkout origin/next
    Note: moving to 'origin/next' which isn't a local branch
    If you want to create a new branch from this checkout, you may do so
    (now or later) by using -b with the checkout command again. Example:
      git checkout -b <new_branch_name>
    HEAD is now at 9ecb2a7... Merge branch 'maint'

And perhaps for people who do not understand the second point in the
four-point list [*1*] I showed earlier in the thread, "If you want to
create a new branch" may not be descriptive enough, as a sight-seer and an
occasional typofixer, the user does not know what branch is good for to
begin with, and would not be able to tell if s/he even "wants to create"
one.  Perhaps it would help more if we reworded three lines after "Note:"
with something like:

    To keep the history of commits you will build from now on in a branch,
    you may want to do "git checkout -b <new-branch-name>" now.

and customize the "in a branch" and <new-branch-name> part if the checkout
was given a remote tracking branch and the corresponding local branch does
not yet exist, e.g. in the above example:

    To keep the history of commits you will build from now on in 'next'
    branch, you may want to do "git checkout -b next" now.


[Footnote]

*1* The world model in which a git user works is:

 * You clone and get copies of where the other end has its branches;

 * You do all your work on your local branches;

 * You may incorporate what the other end further did by merging from the
   tracking branch from it;

 * You update the other end by pushing what you did on your local branches.

I do not think you can nor should hide them from the user [*2*].

*2* We had to repeat "don't hide but teach" many times until it finally
sank in for another essential thing in the git world model.  I hope we do
not have to do the same repeating for the above four points.  Luckily we
do not have to repeat "don't hide but teach" about the index anymore these
days.
