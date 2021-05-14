Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC4DC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A971B6145A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhENNvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 09:51:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54119 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhENNvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 09:51:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 198A91389DC;
        Fri, 14 May 2021 09:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hm+zZpxqGDtz8+WmGQjuky/MXA8SBIeb3np+BV
        WFE7I=; b=NYod+RMwlf9ZEHNyaA0XTDYpVfW0FHQ1dqubCjRXhX1LwCCodj2Y7f
        7i2idEAeEdy0ABy+UtRmDkFBzorEBy+eMOywysRHz+p0Uy9yB8D0UE8vwXvNSPP9
        gkVX1RRgpcNfCBKWjryA+n47QeOyTPSca0MlAk8C5SMrilJj8sO08=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12DB01389DB;
        Fri, 14 May 2021 09:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37DFD1389D9;
        Fri, 14 May 2021 09:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/howto: tracking git.git
References: <20210514124925.39229-1-bagasdotme@gmail.com>
Date:   Fri, 14 May 2021 22:49:52 +0900
In-Reply-To: <20210514124925.39229-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 14 May 2021 19:49:26 +0700")
Message-ID: <xmqqwns177cv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4317A9B2-B4BB-11EB-8F7F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> +Available Branches
> +------------------
> +
> +There are several branches on git.git with different purposes:
> +
> +master::
> +This is the most stable branch. Changes (topics) that are merged
> +to master should have been stabilized in next and suitable for
> +production use. Feature releases (vX.Y.0) are cut from this
> +branch.

Isn't "maint" meant to be more stable?

> +next::
> +This is where topics that haven't been yet merged to master are
> +stabilized and tested for breakage and regressions. It gives
> +a summary forecast of what next batch of topics that will be
> +merged to master looks like.
> +
> +seen::
> +This is the most bleeding edge branch where all excited
> +developments happened. All proposed topics are queued in seen
> +by the maintainer. However, these may be buggy (have breakage or
> +regressions). When topics queued are deemed good and ready for
> +inclusion, they are graduated to next for stabilization.

This is inconsistent with what has been written elsewhere about this
integration branch.  In short, you should not read anything more
than "the maintainer happens to have seen these topics" out of the
fact that a topic is in 'seen'.  Not all proposed topics will be in
this branch, and a branch that was in 'seen' on one day may not be
there the next day, but that does not mean anything (certainly it
does not mean the topic has been "rejected").

> +Tracking
> +--------
> +
> +If you don't have git.git clone handy, you can obtain one by:
> +
> +----
> +$ git clone https://github.com/git/git.git git
> +----
> +
> +Now you can start hacking your topics. Don't forget to read
> +`Documentation/SubmittingPatches` for instructions on patch
> +submission.
> +
> +After some time, there will be updates to git.git. First, fetch them:
> +
> +----
> +$ git fetch origin
> +----
> +
> +Then pull the updates.
> +
> + - For `master`, `next`, `maint`, and `todo`, you can do fast-forward
> +   pull:
> +
> + $ git pull --ff-only

I do not see a point in doing this for all of these branches, and
I'd rather not to see this recommended to people who "track to
develop" at all.  It may make sense to do so if you do not do any
development of your own and will always stay on 'master' to check
out, build, test and install from the upstream, though.

For those who track to develop", if you want a reference point to
work from, you can do "git fetch origin" and then run

    $ git checkout -b mytopic origin/master

for a new feature, and

    $ git checkout -b myfix origin/maint

for a fix.  You can track your progress with

    $ git log origin/master..mytopic
    $ git log origin/master..myfix

If you are fixing a longstanding bug, you may even want to do

    $ git checkout -b myfix-for-2.29-and-above v2.29.3
    $ git log origin/master..myfix-for-2.29-and-above

To test your various topics, you would then do

    $ git checkout -B trial origin/master
    $ git merge mytopic
    $ git merge myfix
    ... build, test, install, employ it for daily use ...

And you can make sure you do not step on toes of others by doing
trial merges

    $ git checkout -B trial origin/seen ;# or origin/next
    $ git merge mytopic
    $ git merge myfix
    ... build and test

which is highly recommended.  This will give you a chance to notice
who, if any, are working in areas of the codebase that potentially
overlaps with what you are working on before you even send out your
series for review.

> + - For `seen`, DO NOT pull with `git pull`. This is because seen is
> +   in constant flux, and most often your local seen is divergent from
> +   the origin, caused by force-push from the maintainer. Attempting
> +   to pull either via merge or rebase will most likely end in
> +   conflict. Instead, pull by resetting the local seen to the origin:
> +
> + $ git reset --hard origin/seen

Even better, do not even create your own 'seen' branch at all.  If
you are interested in what is going on

    $ git log --first-parent --oneline origin/master..origin/seen

might be worth paying attention to, and checking out the tip of
topics of other people you seen in the output and playing with it on
a detached HEAD may also be useful, and if you find bugs in other's
work, you can futz with the code from that commit and you may end up
with a patch you can send as an improvement suggestion to the
original author of the topic.  But 'seen' as a whole is rarely of
interest, except for the purpose of learning what other topics may
be in flight.  Nobody sane is supposed to be running the version
from 'seen'; after all, the selection criteria of the topics in it
is "some of the topics that the maintainer happened to have seen",
and not even "these topics are interesting, promising and are wished
to be in 'next' someday".

