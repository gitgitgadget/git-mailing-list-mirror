From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer: Follow-up questions (MaintNotes)
Date: Mon, 31 Aug 2009 18:38:37 -0700
Message-ID: <7v8wgzla02.fsf@alter.siamese.dyndns.org>
References: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 03:38:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiIKi-0004Y7-If
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 03:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbZIABip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 21:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbZIABip
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 21:38:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZIABio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 21:38:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBB813EFB3;
	Mon, 31 Aug 2009 21:38:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y5NQrML+DMd8LRoyO1fo6HLuzag=; b=m59BQY
	56RzYqaEF7VTkcoYGQvbKONXwD+nrJ0h0xuvz+jziS53yUCqUaLWqTmrYq9JnFrw
	VF4u6azGfSUEgqBOFFVLnJ3GR6K2+jj7Obun2KfXk8uegnkobQyyc1Rv2HWcGtUI
	+bZ8a4zH12/+CiDV+Eq9S+/AeZhY/IaXBCvRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xKVXO+v42aKZWwpILO+kdYjeEPj3Sgan
	0ZEgbsnx2YvaDGrubD4ZALdYz7meuYMsTe2eh8AdubxGOPUsFYbyC5g0r3nS7uD8
	75t5NUMLd5Yt4HGppd3/4JhjOfrp1TvoSg0A8fFfFQvPL22EL+z1MwQmXr0Znnfq
	DKD0kx8ZdtU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF73E3EFAD;
	Mon, 31 Aug 2009 21:38:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2394A3EFAC; Mon, 31 Aug 2009
 21:38:39 -0400 (EDT)
In-Reply-To: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
 (David Chanters's message of "Sun\, 30 Aug 2009 23\:19\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F1CE45C-9698-11DE-B02D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127513>

David Chanters <david.chanters@googlemail.com> writes:

> I'd often wondered when I have read various posts of the git mailing
> list on gmane, just how it is I am supposed to track:
>
> dc/some-topic-feature
>
> ... Junio, are these topic branches ones you actively have somewhere
> in your own private checkout?  Yes, I appreciate that when I read a
> given post to the mailing list, you or other people will sometimes
> make reference to these topic branches, but what do I do if I am
> interested in finding out about one of them?

    $ git log --oneline --first-parent origin/master..origin/pu

would be a handy way to view where the tip of each branch is.

    a71f64a Merge branch 'pk/import-dirs' into pu
    ce6cd39 Merge branch 'jh/cvs-helper' into pu
    ...
    2178d02 Merge branch 'jc/log-tz' into pu
    ...
    927d129 Merge branch 'lt/approxidate' into jch
    35ada54 Merge branch 'tr/reset-checkout-patch' into jch
    d82f86c Merge branch 'db/vcs-helper' (early part) into jch

So if you for example happen to be interested in jc/log-tz topic,
you would do something like:

    $ git checkout -b jc/log-tz 2178d02^2
    $ git log -p master..

to check out, and view what changes the topic introduces. 

Some hawk-eyed people may have already noticed this, but I recently
updated the script I used to maintain the "What's cooking" messages, and
the entries come with when and at what commit each part of the series has
been merged to 'next'.  For example, the lt/approxidate topic reads like
this:

  * lt/approxidate (2009-08-30) 6 commits
    (merged to 'next' on 2009-08-30 at e016e3d)
   + fix approxidate parsing of relative months and years
   + tests: add date printing and parsing tests
   + refactor test-date interface
   + Add date formatting and parsing functions relative to a given time
    (merged to 'next' on 2009-08-26 at 62853f9)
   + Further 'approxidate' improvements
   + Improve on 'approxidate'

Time flows from bottom to top in this output, so this tells us that the
first two patches in the series has been in 'next' for five days or so,
and the tests and a fix in 4 follow-up patches came later, merged to
'next' yesterday.  You can use

    $ git checkout -b lt/approxidate e016e3d^2

to get at its tip.

> ..., how do you go about creating and
> maintaining these topic branches -- are you making heavy use of "git
> am"

Save patches from the list in mbox, review them in the mbox while fixing
trivial breakages, and finally:

    $ git checkout -b ai/topic-name master
    $ git am -s that.mbox

where "ai" is typically the author's initial, and topic-name names the
topic just like you would name a function.  A topic typically forks from
the tip of master if it is a new feature, or a much older commit in maint
if it is a fix (and in such a case, topic-name typically begins with
a string "maint-").

> I ask because of the following snippet from "MaintNotes":
>
>     The two branches "master" and "maint" are never rewound, and
>     "next" usually will not be either (this automatically means the
>     topics that have been merged into "next" are usually not
>     rebased, and you can find the tip of topic branches you are
>     interested in from the output of "git log next"). You should be
>     able to safely track them.
>
> I am not sure if there's any real use-case for this, but I will ask
> anyway:  is the above saying that I am able to *checkout* one of these
> topic-branches just from their presence in "next" alone?  I appreciate
> that the point is somewhat moot since the topic branch has already
> been merged into "next", but I can surely see this as a really useful
> way for people to manage topic-branches in a shared environment:
> people can simply pick a topic branch out from the integrated one --
> in this case "next".

Surely, see above.  And by checking out the topic alone, you can test and
enhance it in isolation.

If you come up with a follow-up patch based on one particular topic, in
other words, building on ai/topic-name created like the above example, as
opposed to building on 'next', it would be easier for me to integrate it,
too, because the way I accept a follow-up patch to a particular topic is
by doing this:

    $ git checkout ai/topic-name
    $ git am -s followup-mail.mbox

The result will be tested in isolation and if it is good it would be
merged to 'next' again.

    $ git merge ai/topic-name

> I'm obviously missing something here -- but why is rebasing these
> existing topic branches (I assume on top of "pu") more useful than
> just merging them into "pu" -- like you do with "next"?

Somebody may send a few patches [PATCH 1/3] thru [PATCH 3/3] whose
quality is sub-par but tries to tackle a good problem.  I'd queue it in
'pu'.

    $ git checkout -b dc/cool-feature
    $ git am -s david-chanters.mbox
    $ git checkout pu
    $ git merge dc/cool-feature

In a few days, people would notice that the series has a lot of room for
improvement, and offer suggestions.  You would send replacement patches
based on the review.  Perhaps you squashed the first two patches from the
original into one, and added another patch for test suite, and the new
series is marked as [PATCH v2 1/3] thru [PATCH v2 3/3].

In general, the early attempts of a topic that have never been merged to
'next' are not worth keeping in the public history.  The original author
is free to keep them in his private tree, but there is no point in forever
keeping earlier mistakes, bugs, typos and implementation based on a flawed
design, all of which later were corrected in _my_ history.

So I would replace the whole topic with the new series.

    $ git checkout dc/cool-feature
    $ git reset --hard HEAD~3
    $ git am -s david-chanters-v2.mbox

The whole point of replacing the contents of this topic was to get rid of
the mistakes in your earlier round, so it does not make much sense to
merge this to 'pu' without rewinding 'pu' first.

After the topic is merged to 'next', obviously I cannot sanely rewind and
rebuild it.  Everything goes incremental from then on (see the earlier
example of applying followup-mail.mbox).

> If regular readers of the git mailing list wish to track this topic
> branch, can they do so from you only until it's merged into "next"?

Sorry, but I am not sure if I understand the question.

> And a related question:  If you decide a given topic in pu is declared
> to "be dropped", is this done by rebasing (as you mentioned earlier)
> so as to remove any trace of the topic branch ever having been in
> "pu", or am I reading too much into "dropping" here?  :)

Essentially, I keep a list of branches that are in 'next' and another list
of branches that are in 'pu'.  At the end of each integration cycle, I do
a rough equivalent of:

    $ git checkout next
    $ git merge ..a good topic that is not fully in next..
    $ git merge ..another good topic that is not fully in next..
    $ make test ;# make sure next is ok
    $ git branch -f pu ;# get rid of everything in pu
    $ git checkout pu
    $ for branch in ..the list of branches to be in pu..
      do
          git merge $branch || break
      done

Discarding a topic from 'pu' simply means I do not merge the topic in the
last loop.
