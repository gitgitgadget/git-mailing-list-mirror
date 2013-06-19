From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] config doc: rewrite push.default section
Date: Wed, 19 Jun 2013 12:55:25 -0700
Message-ID: <7v7ghpzxhu.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 21:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpOTe-0007V5-HW
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 21:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935093Ab3FSTz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 15:55:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302Ab3FSTz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 15:55:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B78DC297F5;
	Wed, 19 Jun 2013 19:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x7Lu9a3auCGwx6IWGXd0tpWdabQ=; b=tVERBy
	sHBXRQVe+za8pkbh7UGNXe+oVu3C+Lt3WxEjwBX4MWP3NfrymU12oyrHj9ckyd0e
	tKr1qGmmS/LZOPFuXgegYyGKoO8+faGCYVUOWVZ/h5L7w3jxKXm00D1aupQpMdHQ
	OqUi5P0xcJShijcH6TMxcdwzCUkcYq6ChYNkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1rONYLqWOMyM6UFFToZkUd/YNGPacsf
	/vS+vfnNYDFyWrEdxOoQu0bN+y9lz42Qdzbt/h5ABk4G3IHLUyL0Q7bHpPC8muGz
	O+I4QVaJZHxQKu6shXVsLAhO2zgV3jCR5MLJbR7lCbsW0g/SC1M0emfl2hoKHTfC
	M+hyBzd7Luc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC17A297F3;
	Wed, 19 Jun 2013 19:55:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAC94297F0;
	Wed, 19 Jun 2013 19:55:26 +0000 (UTC)
In-Reply-To: <1371640304-26019-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 16:41:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FD996EC-D91A-11E2-9922-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228418>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  push.default::
> +	Defines the action `git push` should take if no refspec is
> +	explicitly given.  Different values are well-suited for
> +	specific workflows; for instance, in a purely central workflow
> +	(i.e. the fetch source is equal to the push destination),
> +	`upstream` is probably what you want.  Possible values are:
>  +
>  --
> -* `nothing` - do not push anything.
> -* `matching` - push all branches having the same name in both ends.
> -  This is for those who prepare all the branches into a publishable
> -  shape and then push them out with a single command.  It is not
> -  appropriate for pushing into a repository shared by multiple users,
> -  since locally stalled branches will attempt a non-fast forward push
> -  if other users updated the branch.
> -  +
> -  This is currently the default, but Git 2.0 will change the default
> -  to `simple`.
> -* `upstream` - push the current branch to its upstream branch
> -  (`tracking` is a deprecated synonym for this).
> -  With this, `git push` will update the same remote ref as the one which
> -  is merged by `git pull`, making `push` and `pull` symmetrical.
> -  See "branch.<name>.merge" for how to configure the upstream branch.
> +* `nothing` - do not push anything (error out) unless a refspec is
> +  explicitly given.  Very safe, but not very convenient.

Drop the last one, that does not add any value to the description.

> +
> +* `current` - push the current branch to update a branch with the same
> +  name on the receiving end.  Works in both central and non-central
> +  workflows.  Equivalent to pushing the refspec "$branch" ($branch is
> +  the name of the current branch).

I do not think this is a place to teach how various refspecs are
spelled, but if you want to, then giving a complete command line
would be more appropriate.  Otherwise I'd suggest dropping
everything after "Equivalent to...".

> +* `upstream` - push the current branch to a branch with the name
> +  branch.$branch.merge on the receiving end, and error out if the push
> +  destination is not the same as branch.$branch.remote.

While the above may be technically accurate, a mechanical definition
help readers who read this for the first time may not be very
helpful.  What does the operation mean?

	push the current branch back to the branch whose changes are
	usually integrated into the current branch with "git pull"
	(which is called @{upstream}).

	this mode only makes sense if you are pushing to the same
	repository you would normally "pull" from (i.e. central
	workflow).

>  * `simple` - like `upstream`, but refuses to push if the upstream
>    branch's name is different from the local one. This is the safest
>    option and is well-suited for beginners. It will become the default
>    in Git 2.0.

OK.

> +* `matching` - push all branches having the same name on both ends
> +  (essentially ignoring all newly created local branches).

That misses the 'essense' of 'matching' by a wide margin, as "newly
created" does not have anything to do with it.  Topic branches you
decided not to push long time ago and haven't pushed out so far will
not suddenly get pushed with "git push", either.

Think of it this way.  Among your local branches, there are classes
of branches that:

 (1) you would want to push now,
 (2) you would want to push when they are done, and
 (3) you would never want to push.

Other "push only single branch" modes make this distinction by
limiting the push to only the first class (those you would want to
push now), but it further limits that set to a single branch, which
is the current one.  It is up to you to differentiate class 2+3
(those you do not want to push now) from class 1 (the single one you
do want to push) and you indicate that choice by running 'git push'
only when you are on the branch you want to push out.

The 'matching' mode allows you to "configure" by having the other
side remember which ones are in the class 1 (i.e. those that you
will push out when you say 'git push').  Instead of keeping a list
of branches to be pushed in local configuration variable, you use
the set of branches your publishing point has.  It has a limitation
that you are not allowed to have the second category (i.e. at this
point of running 'git push' they are not ready to be pushed out),
though.

Perhaps

	... on both ends.  This makes the repository you are pushing
	to remember the set of branches that will be pushed out
	(e.g. if you always push 'maint' and 'master' there and no
	other branches, the repository you push to will have these
	two branches, and your local 'maint' and 'master' will be
	pushed there).

        To use this mode effectively, you have to make sure _all_
	the branches you would push out are ready to be pushed out
	before running 'git push', as the whole point of this mode
	is to allow you to push all of the branches in one go.  If
	you usually finish work on only one branch and push out the
	result, while other branches are unfinished, this mode is
	not for you.  Also this mode is not suitable for pushing
	into a shared central repository, as other people may add
	new branches there, or update the tip of existing branches
	outside your control.

or something like that.
