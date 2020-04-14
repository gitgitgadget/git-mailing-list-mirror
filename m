Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2900C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9238B2072D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hV4gisRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406665AbgDNHdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:33:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55008 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406631AbgDNHdk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 03:33:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4985560F6;
        Tue, 14 Apr 2020 03:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c42bvhhFeDONoFgcbayCjaRLR1Y=; b=hV4gis
        Rc+zK/DwE5z5XwMe1jwtQbKhQFFVF800qAvDpvOzqntGQExi1YjYFHOgmiU8F6+k
        EmhvsC9CoQ9B0CQkBWxMksbs3ROLlQOQk5h1ARKTMv0hk32dwmluqOyihbTXVtoP
        QbKoJYhQEvMHy8DmIGV7nJ45fXnzB4GAOXhEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gImwRZRZcnE4Dl5RrPT2VB1lVk7xShLk
        DCsLtw5xA1t71JIPs+czeqUJaTEU0op4NUiQDEZB8UXBJLiCDkhcCLeS1nFLDkcs
        rQnbUJUxZX81+a4OZmiHHVoPlRTdWqG3RdW4hFdYHsi5rUndXfmjWIEgjKE20rG6
        QtH+SrwzV1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCACF560F5;
        Tue, 14 Apr 2020 03:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65394560F4;
        Tue, 14 Apr 2020 03:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
        <20200413140918.4778-2-shouryashukla.oo@gmail.com>
Date:   Tue, 14 Apr 2020 00:33:36 -0700
In-Reply-To: <20200413140918.4778-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 13 Apr 2020 19:39:18 +0530")
Message-ID: <xmqqmu7ea5db.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4118680C-7E22-11EA-ABB8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add more issues and their respective solutions in the 'Common Issues'
> section of gitfaq.

It probably would have been much easier to discuss if these sections
were separate patches.

Also, each physical line is way too long to view without line
wrapping (even on my wider-than-usual 92 col terminal).  Please wrap
lines at a more reasonable column, like 65-72.

> +[[rebasing-and-merging]]
> +How do I know when to merge or rebase?::
> +	Rebasing and merging two entirely different concepts with different utiilites.
> +	In Git terms, rebasing means to place changes made in one branch over another branch
> +	(called base, hence the term, rebase). The commit history of the branch wanting to rebase
> +	get placed over the branch on the receiving end and it appears as if those changes took
> +	place in the receiving branch itself.

"the branch wanting to rebase"?  Did you mean "the branc being
rebased"?  Except for that the above looks quite reasonable.

> +	Merging, as the name suggests, merges the latest
> +	commit of one branch onto the recent branch, making this combination appear as one separate
> +	commit.

This description is a bit iffy.  There is nothing special about "the
latest commit" among the commits on the branch being merged---if you
had a two-commit side branch and you merged that branch to another
branch, the changes made by _both_ commits would appear in the
result; I don't find much value in saying "the latest commit of one
branch" (besides, merging an early part of a branch alone, while
leaving more later parts of the branch still not merged, is a valid
thing to do).

    Merging binds two (or more) lines of histories into one history,
    reflecting what these branches wanted to do to the files since
    they forked from their common ancestor and recording the result
    as one new "merge" commit that is a direct descendant of the
    tips of these branches.

perhaps.

[jc: it is impossible to comment on the overlong lines, so I'd
remove the '+'(added) sign and reflow the paragraphs]

> Now that we have an idea of the key differences between merging
> and rebasing, we can look at the circumstances when we would want
> to perform them.

OK.

> Generally, merging is preferred when one desires
> to create a new feature, perform its integration testing with the
> original codebase, and finally integrate it if all tests are
> passed.

This is an unsubstantiated claim (opinion) and I do not know if I
agree with it.

I do not think we want to have such a sentence as if it were our
official recommendation in our documentation set---it is OK to write
such things on your blog, but not here.

> One would choose to create a separate branch for this purpose and
> maybe dissolve it when the merge is done.

It is unclear what you mean by "dissolve" here.  Do you mean "build
a new feature on a topic branch, use the branch to polish the feature
until it is perfect, and merge it to the trunk, at which point, the
topic branch is no longer needed so it can be discarded"?

> One might want to perform a rebase when they intend to retain the
> changes made in a separate branch into their original branch. 

This reads as if you are describing: "I want to keep the original,
but I want to use the same changes elsewhere" but I do not think it
is a good match for "rebase" in the first place.  It sounds more
like you are talking about cherry-picking.

And "merge" is also perfectly fine way to do so, as long as the
original development was done based on the right commit.  If you
originally based your fix on a commit that is too new in the
history, even though the problem you wanted to fix appeared much
earlier in the history, you obviously cannot fix the problem for an
older maintenance track by merging, and at that point, you may
either

 (1) cherry-pick (i.e. duplicate) the fixes to older maintenance
     track, while keeping the fixes based on a newer codebase; or

 (2) rebase the fixes, that were originally done on a newer
     codebase, to the oldest maintenance track that still matters,
     and then discard the original fixes and instead merge the
     result of rebasing to the newer codebase.

If you can afford to do (2), it is _always_ preferrable to do so,
but often you cannot and you end up doing (1).

Notice that the preferred workflow has *both* rebasing and merging
as crucial elements.  It's not like "when to do rebase, and when to
merge" as you set out this section to be.  It is often more like
"you rebase, in preparation to merge".

> In that case, a rebase would place the former changes onto the
> commit tree of the latter.

> As an additional tip, one can use interactive rebasing, `git
> rebase -i`, to perform rebasing using a text editor GUI (the value
> of $GIT_EDITOR). Interactive rebase is an excellent utility to
> perform various functions such as editing commit messages,
> dropping/squashing commits, editing commits, etc., all in one
> package.

I think what the description is lacking *most* is *why* and without
that it would not be as useful as it could be to the readers.  Why
does one want to rebase commits on a branch?  When the reader knows
the answer to that question clearly, various things "rebase" lets
its users do would make sense.

In the context of "I now have my first iteration of a topic (be it a
feature or a fix)", one would perform rebase because of different
reasons (and they are not exclusive):

 - Your first attempt may have been built on a wrong commit, so you
   want to restart your topic branch at a different "base".

   . You may have written a helper function in your code yourself,
     because you started your topic branch at the latest release
     tag, but later you may have noticed that the same helper
     function is already available for your use in the current
     development version.  By restarting your topic branch at a
     later commit, you do not have to reinvent the helper function
     yourself, hence you may want to rebase your topic at the tip of
     the current development version.

   . You may have developed a fix on top of the latest release tag,
     but then realized that the bug you fixed was already there in
     the previous release.  You obviously cannot merge your fix
     directly to the previous release, because doing so would also
     pull down all the changes in the latest release.  By restarting
     your topic branch with your fix at the previous release point,
     you can apply the fix (and no other changes that the latest
     release has) to the earlier codebase.  And if your newer
     codebase is a superset of your older codebase, you can fix the
     same bug in the newer codebase by simply merging the fix to the
     newer codebase (and your original topic branch based on the
     latest release tag is no longer needed, so you can discard it).

 - Your commits may have unnecessary or wrong code, or log message,
   or both.  They may be in a wrong order.  You would rebuild your
   history, either on the same base or a different one, and tweak
   each commit as you do so.

   And "rebase -i" was invented exactly for that purpose.

I won't comment on the other sections in this message (I may do so
in separate ones).

Thanks.
