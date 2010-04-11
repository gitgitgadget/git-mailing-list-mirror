From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull suggestion
Date: Sun, 11 Apr 2010 00:37:04 -0700
Message-ID: <7vaataphi7.fsf@alter.siamese.dyndns.org>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
 <201004081754.24954.trast@student.ethz.ch>
 <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
 <20100408231154.GB13704@vidovic>
 <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
 <20100409034911.GA4020@coredump.intra.peff.net>
 <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
 <20100410043535.GA22481@coredump.intra.peff.net>
 <m2v3abd05a91004102301i95bf7091ib2bd9da5e8a208c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 09:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0rjj-0005gI-5f
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 09:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab0DKHhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 03:37:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab0DKHhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 03:37:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF1A2AA928;
	Sun, 11 Apr 2010 03:37:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=X82phiAHboKu27s8jQR0YR/pwVA=; b=bDRr8t5ixVfycOdq75wwEO+
	GsEH2ALaYMV7nou/ksXChRUDaRidqM+jcwPjuQRsH/6Hs54yqy5iq08XC8BK+cbP
	K5ExmAMC6C9EQfHItUMi5sB6K1lySA9iyARjBLc+81Jv0gMeJUeIBOv16dv5g99s
	3pRlii1yIvspOtxQIEmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=r05S9CuUbpjPHOxibxno+ABCkVF2m9Qal7SfWfWumv3h3zlwv
	Sbq/gZhh2CMZuFdyEoSMrGfqpQxDbracaHoI8oZHE6nykPg8gK10Q8iGXAS0SIon
	ef/rDt4IHzkSlD1yY7iROHueWb/8lZshnoLsD4ZeysC0sHCvr7iZTnZbZ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DCF6AA925;
	Sun, 11 Apr 2010 03:37:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C209AA924; Sun, 11 Apr
 2010 03:37:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C017C40-453D-11DF-8A8D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144631>

Aghiles <aghilesk@gmail.com> writes:

> Although for people used to CVS/CVN the "stash" is yet another thing
> to learn. There is also a high probability for new users to see this message
> very early when using git and the question is always the same: why can't git
> just merge with my files and show me the conflict?

There actually are two answers to this question.

One is that it is not necessarily "can't", but rather "chooses not to".
If you are limiting yourself to CVS/SVN style of development, then we
certainly could do that.

Let's review what happens in CVS/SVN world when you "update" with dirty
working tree.  As you are familiar with CVS/SVN, you should be able to
follow this part quite easily.

You "updated" and were in sync with the central repository at some point,
let's call it O, and have some uncommitted changes in the work tree since
then.  In the meantime, other people worked on the project and made more
commits in the central repository.  The tip of the central repository is
at commit A.

         x
        / 
    ---O---X---X---X---A

You would want your "cvs update" to end up with a topology like this:

                         x'
                        / 
    ---O---X---X---X---A

where

        x' = merge-three-way(O, x, A)

That is, the files in the work tree are updated to contain whatever
was done by other people between O and A.

git does _not_ implement a handy Porcelain to do this, but we could script
it like this (I am only illustrating that it can be done, but I am leaving
the reason why git chooses not to to a later part of this message).

	#!/bin/sh
        # Usage: git-cvs-pull remote [refspec]

        # Fetch from the other
        git fetch "$@"
	# Figure out "A", i.e. the updated commit
	merge_head=$(sed -e '/	not-for-merge	/d' \
		-e 's/	.*//' .git/FETCH_HEAD | \
		tr '\012' ' ')
	# cvs/svn style pull will never have an octopus
        case "$merge_head" in
        ?*' '?*)	die "cannot merge more than one" ;;
        ?*)		;;
        *)		die "nothing to merge" ;;
        esac

	# Make sure it is cvs/svn-style pull.  That is, our commit must
        # be an ancestor of the updated commit
	test 0 = (git rev-list $merge_head..HEAD | wc -l) || die "you forked"

        # At this point, we know the topology is like this.
        #
        #         x
        #        / 
        #    ---O---X---X---X---A

	# Figure out the current branch
	branch=$(git symbolic-ref HEAD)

	# Checkout and detach to "A" while carrying the local changes.
        # This may leave conflicts but that is what the user is asking for.
        git checkout -m "$merge_head^0"

        # At this point, topology has become:
        #
        #                         x'
        #                        / 
        #    ---O---X---X---X---A
        #
        # We have detached HEAD at A but haven't updated the branch yet.

        case "$branch" in
        '')	;; # detached from the beginning
        ?*)	git update-ref -m "cvs-pull" "$branch" "$merge_head" ;;
	esac

Note that this was written in my MUA and is obviously untested ;-) but I
think you have also been around here long enough to understand the idea.

So that was one of the answers.  It's not "we can't do it", but is "in a
world with cvs/svn limitation, we could".

The other answer would initially appear a bit sad, but after you think
about it, it would turn into an enlightenment, especially for people whose
brains have rotten from years and years of CVS/SVN use.

If you are not limited to CVS/SVN style of development and have made
commits since you updated from the central repository the last time,
CVS/SVN style "update" is fundamentally impossible.

Again, you "updated" and were in sync with the central repository at some
point, let's call it O, and this time, made a few commits, ending with
commit B.  You further have some uncommitted changes in the work tree
since then.  In the meantime, other people worked on the project and made
more commits in the central repository.  Again, the tip of the central
repository is at commit A.

                   x
                  /
         Y---Y---B
        / 
    ---O---X---X---X---A

First, a simple question.

What kind of topology would you want to end up with?

Think.

	... you think for five minutes ...

	(page break)

	... and then you look at the answer ...

Yes, you want to have a merge between A and B, and then have your local
change relative to M in your working tree.  In other words, the topology
should look like this:

                           x'
                          /
         Y---Y---B-------M
        /               /  
    ---O---X---X---X---A

where

	M = merge-three-way(O, B, A)
        x' = merge-three-way(B, x, M)

Again, think.  How would you deal with conflicts while coming up with M?

You cannot leave files with conflict markers in the work tree and have the
user fix them up to record M.  Quite contrary to what you insinuated, your
working directory is not a second class citizen but is a very valuable
entity, and it already has important changes between B and x.  We cannot
afford to overwrite it with a half-merge result between A and B for the
purpose of conflict resolution between A and B.

Worse yet, even if we _could_ keep the changes between B and x in the same
file while showing conflicts between A and B (perhaps the changes you made
between B and x did not overlap the region conflicted between A and B), we
cannot still write such a thing out to the working tree.  Why?  Because
then you have to sift through the changes in that file and commit _only_
the parts that are relevant to the merge between A and B while finishing
the merge to produce M, while leaving the change between B and x (which is
going to become the difference between M and x' and left in the working
tree) alone.  And that is actually the best case.  What would you do if
the conflicted region between A and B were something that you changed in
the working tree between B and x?

So the "enlightenment" part is that once you have an ability to "fork" the
history, CVS/SVN style "edit, update, commit" cycle _fundamentally_ would
not work.  That is why "commit first and then merge" is the norm in DVCS
world.

Now how would one deal with this then?  The answer is actually quite
simple.  Let's go back to the first picture:

                   x
                  /
         Y---Y---B
        / 
    ---O---X---X---X---A

We want to come up with a merge between A and B first to produce M, and
while we do that, we do not want to lose the valuable change between B and
x, so we _stash it away_.  Then we can use the working tree to deal with
potential conflicts while finishing the merge to produce M.  In other
words, after stashing, we can safely run "git pull" to produce M.

                   (x) --- the change is stashed away
                  /
         Y---Y---B-------M
        /               /  
    ---O---X---X---X---A

And then we can replay the stash on top of M to produce x'

                           x'
                          /
         Y---Y---B-------M
        /               /  
    ---O---X---X---X---A


And the final answer (yes, I said there are two answers to the original
question, and I already gave two answers, but I let the above description
to raise another question "why does git choose not to implement the logic
of the first answer in a fast-forward case, aka cvs/svn style?") is that
it simply is not worth it to special case the "I didn't commit and ran
pull again".  The workflow to result in such a case would look like this:

	$ git pull
        ... you are in sync with the other end ...
        $ edit
        $ edit
        $ edit
        $ edit
        $ edit
        $ edit
        ... keep working forever _without ever committing_ ...
        $ git pull

which goes against the distributed nature of the system you are using.

Worse yet, once you have committed between these pulls, even once, then
the simple-minded "cvs/svn update" style will not fundamentally work.
Rather than training the users with "If you didn't commit, then you can do
"pull" many many times, but once you commit, then you have to do something
different", which is not very useful anyway, it is better to teach the
more general "forked" case, because the general case solution will also
work in the fast-forward case.

Now, the above inevitably solicits "then why doesn't 'pull' automatically
stash and then unstash?" question.  I think the answer is obvious if you
think about it, and it is getting late, so I'll leave that as an exercise
to the readers but will leave a pictorial hint.

                   C-------M
                  /       /
         Y---Y---B       / 
        /               /
    ---O---X---X---X---A
