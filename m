Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B99C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3FF20739
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aitAbb9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgCKUEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:04:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53292 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgCKUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 16:04:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB208BD594;
        Wed, 11 Mar 2020 16:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uDpJEL/sh7LEn5XE4waDp9Tbkr8=; b=aitAbb
        9ud72/2vp73ZOFTG0IAjrqMrgr2yi8rTet13XDDG0DDVRppPX1AaB0qywAaUG09u
        60PFqHVlSqqv2wBtkSCMZyfdB/IHI93+92Ymjr71RfKLLHLfQZMEsi4j2C6HU6Nb
        O56DQZ9RDFr2M+EQ3EEcrqrjHnFr8XHSWoytM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jp1doOOT17Vc6s725twjfdjFuNbn0/6E
        sLl8dwIz5rOO291t62v031R3uN4o0Ld162TyUfayWC8DeE0Wf0oq6lUfb+JJs6hu
        JCzsF91t3+OLjkVJLHJfTZEQFSTZPqexJ96XtSycQg8vA7GQ7+dV/hsYqqsMOH57
        ywxLjYSSfI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D19E9BD593;
        Wed, 11 Mar 2020 16:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27DE5BD592;
        Wed, 11 Mar 2020 16:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christos Pappas <chrispappas99@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org,
        annulen@yandex.ru
Subject: Re: [Feature request] Give non-unique names to commits for grouping
References: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
        <2001043.V3P9HlvaID@mfick-lnx>
        <CAGa6KtQ2dQWPWxbk2MH8QJxemM8QD_O=B3aYzsP5AH-sN-7PSw@mail.gmail.com>
Date:   Wed, 11 Mar 2020 13:04:14 -0700
In-Reply-To: <CAGa6KtQ2dQWPWxbk2MH8QJxemM8QD_O=B3aYzsP5AH-sN-7PSw@mail.gmail.com>
        (Christos Pappas's message of "Wed, 11 Mar 2020 20:56:44 +0200")
Message-ID: <xmqqeetyhd4x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C3C0A06-63D3-11EA-A816-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christos Pappas <chrispappas99@gmail.com> writes:

> Thank you for your answers.
>
> From what I can deduce, both of your suggestions require that the
> commit messages(or notes) must have some special text for which we can
> search for, which is hacky and would be different on every repository.
>
> What I am suggesting is something like, labels on GitHub, hashtags on
> Social-Media, or Tags in News sites. It's a well known concept so it
> will be easy to understand and use.

By "hashtags", do you mean #hashtags, i.e. you must add some special
text for which you can search for?  That does sound just as hacky as
any other embedded text in the messages of commit objects.

One large downside of embedding text (or #hashtags) in the message
of a commit object is that you need to plan ahead and know what
group the commit belongs to before you make it, but in general, it
is unreasonable to expect perfect foresight.  Often you do not know
what group the commit belongs to (e.g. you may want to label the set
of commits that broke the latest release for feature 'frotz' with
hashtag "#broke-frotz", but most likely you didn't know you were
breaking the feature when you were creating these commits).  Adding
these offending commit objects some comments in the form of notes
objects can be done retroactively, and as long as the set of
"tag-worthy" commits is minority among all commits, grepping for
"#hashtag" in the notes to find the notes that contain the tags you
wanted should be cheaper than "git log --grep" which must read all
the commits in the history.

Another way may be "git notes --ref broke-frotz add X -m . X" (and
similarly for Y and Z that also belong to "#broke-frotz" set of
commits) to mark them with an almost empty note in refs/notes/broke-frotz
hierarchy.  Then "git notes --ref broke-frotz list" should be able
to list these commits that have any notes in refs/notes/broke-frotz
and there is no need for grepping.  Of course you can make it richer
by describing why each of X, Y, and Z are in the "broke-frotz" set
when you give the notes text to them.



