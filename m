From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-checkout: Move `--detach` flag in synopsis to correct command
Date: Wed, 11 Sep 2013 10:05:17 -0700
Message-ID: <xmqq1u4vuw4y.fsf@gitster.dls.corp.google.com>
References: <CA+DWcQah8Uy41oZXGhP-i+H7JAU_bOWPVt3i79fDnW==FeTJGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Bergman <ben@benbergman.ca>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJnr8-0004TQ-LD
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab3IKRFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:05:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950Ab3IKRFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:05:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A33F405D8;
	Wed, 11 Sep 2013 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UbKgUFS+gN02NO3BrMk01ZE6f+Y=; b=wRVu2u
	R9d2dKuCCnVx+sbkLaZR7r6WiCN4DO+LnuMmpR2HQHDaLsgLGTXoBveikFgCqA14
	utK3P5BCMl34KCLyCTUxs6TWcI+xEW1vLe5l0AGiTXPqwb8FkCRcdOxEvWUhrOC4
	aR3ez2OVGzFtH1W/A5Cpni/g38jZpBRkgwc9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I1UKb0eSDzjdZJoiG7O//AdDLos4YcXZ
	nkmuPBVs2C4tweJQbQRDGDWdiXAY1+tD5sybeR9URCOwG4ZfINB0GcrrcQi9L5/E
	9IaLuoDcUWGK75IkE29njGpaFO77h+qRwCPrE5xyiaMmXHB63/Av0hnDko7lBf8R
	PTriVhzrzZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA5D3405D7;
	Wed, 11 Sep 2013 17:05:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1B05405D1;
	Wed, 11 Sep 2013 17:05:19 +0000 (UTC)
In-Reply-To: <CA+DWcQah8Uy41oZXGhP-i+H7JAU_bOWPVt3i79fDnW==FeTJGw@mail.gmail.com>
	(Benjamin Bergman's message of "Tue, 10 Sep 2013 21:37:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56A34378-1B04-11E3-A2B4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234580>

Benjamin Bergman <ben@benbergman.ca> writes:

> From a33659535cb0eac92bed42d5e494dbb8f5d9ab20 Mon Sep 17 00:00:00 2001
> From: Benjamin Bergman <ben@benbergman.ca>
> Date: Tue, 10 Sep 2013 16:00:29 -0500
> Subject: [PATCH] Documentation/git-checkout: Move `--detach` flag in synopsis
>  to correct command

These (except the first one that is a separator in the format-patch output)
go to your e-mail headers, not to the body of the message.

>
> Detailed description of `--detach` states that it is default for
> `<commit>` but needs to be specified for `<branch>`. The old man page
> synopsis showed the reverse.
> ---

Please sign-off your patch.

> -'git checkout' [-q] [-f] [-m] [<branch>]
> -'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
> +'git checkout' [-q] [-f] [-m] [--detach] [<branch>]
> +'git checkout' [-q] [-f] [-m] [<commit>]

I am actually on the fence on this change.

The original shows two operations that do different things (one goes
to a named branch, the other goes to the state in which the HEAD is
detached at the named commit).

With the updated synopsis, even with the first form, if the user
uses --detach, the end result is like the second one. I personally
find the synopsis with the patch a bit more confusing, not less.

Can we update the second form (without touching the one that shows
"how to check out a named branch" at all) in a different way to
clarify?  E.g.

        'git checkout' [-q] [-f] [-m] [<commit> | --detach <branch>]

might be one way.  If you want to detach at a named commit, you can
directly give the commit object name; a branch name usually can be
used as a commit object name, but that use conflicts with the more
usual "check out that branch" usage, so you need to give --detach
explicitly if you use a branch name to name that commit you want to
detach at.  One drawback this has is that it does not capture that
you could say --detach (even though you do not have to) when using a
form that is _not_ a branch name to name your commit, e.g.

	git checkout --detach master^0

... thinks a bit more ...

Or we can split the "detaching" usage into two, which is how the
DESCRIPTION section does.  I.e.

    'git checkout' [-q] [-f] [-m] [<branch>]
   -'git checkout' [-q] [-f] [-m] --detach [<commit>]
   +'git checkout' [-q] [-f] [-m] --detach [<branch>]
   +'git checkout' [-q] [-f] [-m] <commit>
    'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<st...

This would tell the reader that:

    - You can give "--detach" and no branch name---you would detach
      at the tip of your current branch;

    - You can give "--detach" and a branch name;

    - You can give a commit object name.

We could also throw in "[--detach]" in front of the <commit> to say
that it is accepted (even though it is not necessary.

>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>]
> [<tree-ish>] [--] <paths>...

Your MUA or editor line-wrapped the patch; please do not let them.

>  'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]


How about doing it this way?

-- >8 --
Subject: checkout: update synopsys and documentation on detaching HEAD

In the synopsis, the second form to detach HEAD at the named commit
labelled the argument as '<commit>'.  While this is technically more
correct, because the feature to detach is not limited to the tip of
a named branch, it was found confusing and did not express the fact
that you have to give `--detach` if you are naming the commit you
want to detach HEAD at with a branch name.

Separate this case into two syntactical forms, mimicking the way how
the DESCRIPTION section shows this usage.  Also update the text that
explains the syntax to name the commit to detach HEAD at to clarify.

Suggested-by: Benjamin Bergman <ben@benbergman.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-checkout.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca118ac..01d9b85 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
+'git checkout' [-q] [-f] [-m] --detach [<branch>]
+'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
@@ -62,7 +63,7 @@ that is to say, the branch is not reset/created unless "git checkout" is
 successful.
 
 'git checkout' --detach [<branch>]::
-'git checkout' <commit>::
+'git checkout' [--detach] <commit>::
 
 	Prepare to work on top of <commit>, by detaching HEAD at it
 	(see "DETACHED HEAD" section), and updating the index and the
@@ -71,10 +72,13 @@ successful.
 	tree will be the state recorded in the commit plus the local
 	modifications.
 +
-Passing `--detach` forces this behavior in the case of a <branch> (without
-the option, giving a branch name to the command would check out the branch,
-instead of detaching HEAD at it), or the current commit,
-if no <branch> is specified.
+Even though a branch name can be used to name a commit, you have to
+explicitly say `git checkout --detach <branch>` when you want to
+detach HEAD at the tip of the branch (`git checkout <branch>` will
+check out that branch without detaching HEAD).  Omitting <branch>,
+i.e. `git checkout --detach` detaches HEAD at the tip of the current
+branch.  When naming the commit in a form other than just a branch
+name, e.g. `master^0`, `HEAD~4`, `c2f3bf071e`, you can omit --detach.
 
 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
