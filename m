Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1BAC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F397920737
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HufAiXgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgDBRhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:37:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54099 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBRhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:37:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61BAA5FE8D;
        Thu,  2 Apr 2020 13:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OOOcN7SR5wCt+M7PegEyUQAEZ/Y=; b=HufAiX
        gli15bYSB2kk0bnvWfYSao4t6bNQe8rJysuf0jzdh86PizADhta2Iu6ZsU4JMyFX
        VdkfG3+LiOP829w9ggvR8Y53Yp8cWc89Gr6urwyZ9EXcaskOSS6OydkoWF9FDF0U
        9HoBUhwRSVjIgEox+DoMPvok+f/2sCBhYga/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hjOk5gQ1ZeKEfmEB48bBXU9iQ2cWjRTn
        v2JjPKwCWYDXgc0INv9GziR7fxJ29INbTZDBsEUASc9C3zULv1bSW4kinH0IHwwZ
        GWoAz1VTAcU9JvqkcAiUq92Ovpf9NBgKh1iEPKq22mGPEeB7eGxAU/ZylrhivPoI
        4Jv5IQgf12w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5868B5FE8C;
        Thu,  2 Apr 2020 13:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C57385FE8B;
        Thu,  2 Apr 2020 13:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] clone: document partial clone section
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
Date:   Thu, 02 Apr 2020 10:37:23 -0700
In-Reply-To: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com> (Teng
        Long via GitGitGadget's message of "Thu, 02 Apr 2020 02:02:26 +0000")
Message-ID: <xmqqa73t4wmk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CC0636C-7508-11EA-8B4D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Teng Long via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dyrone Teng <dyroneteng@gmail.com>
>
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation during a period. Add
> a relevant section to help users understand what partial clones are
> and how they differ from normal clones.

I am not sure what "during a period" means there; perhaps we can
simplydrop these three words to make the sentence clearer without
changing what you wanted to say?

> The section briefly introduces the applicable scenarios and some
> precautions of partial clone. If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.

Otherwise, the above is a nice and clearly written summary.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>

As Derrick pointed out, we want to see the authors sign their
patches using the same authors' name on this line.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index bf24f1813ad..dd92d153535 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -297,6 +297,75 @@ or `--mirror` is given)
>  	for `host.xz:foo/.git`).  Cloning into an existing directory
>  	is only allowed if the directory is empty.
>  
> +Partial Clone
> +-------------
> +
> +By default, `git clone` will download every reachable object, including
> +every version of every file in the history of the repository. The **partial clone**

Please avoid overly long lines.

> +... omitted from the initial `git clone` and subsequent `git fetch`
> +operations. In this way, a partial clone can reduce the network traffic
> +costs and disk space usage when git is working under a large repository.

Perhaps "can reduce the initial network traffic costs...", as you'd
end up paying the cost for the part of the repository you'd actually
use.

And there is traffic and disk usage reduction that comes but not "in
this way (i.e. initial clone does not have to transfer)", which is
that parts of the trees and histories you never touch may not have
to be transferred and stored at all.  If you meant to cover benefits
coming from both reasons, perhaps omit "In this way, " and then
we do not have to say "the initial network traffic costs...".  Or
you may want to spell out both a bit more explicitly.

> +To use the partial clone feature, you can run `git clone` with the 
> +`--filter=<filter-spec>` option. If the repository has a deep history
> +and you don't want to download any blobs, the form `filter=blob:none`
> +will omit all the blobs.

If the repository of a young project simply has a large collection
of files, blob:none would still omit all the blobs, so I am not sure
if "the repository has a deep history and" is a good thing to say.

> +When using a partial clone, Git will request missing objects from the
> +remote(s) when necessary. Several commands that do not involve a request
> +over a network may now trigger these requests.

We may want to phrase this a bit stronger, if you are listing these
as pros-and-cons?  E.g. "Some 'local' commands may fail without a
network connection to the remote repository."

> +For example, The <repository> contains two branches which names 'master'
> +and 'topic. Then, we clone the repository by
> +
> +    $ git clone --filter=blob:none --no-checkout <repository>
> +
> +With the `--filter=blob:none` option Git will omit all the blobs and
> +the `--no-checkout` option Git will not perform a checkout of HEAD
> +after the clone is complete. Then, we check out the remote tracking
> +'topic' branch by
> +
> +    $ git checkout -b topic origin/topic 
> +
> +The output looks like
> +
> +------------
> +    remote: Enumerating objects: 1, done.
> +    remote: Counting objects: 100% (1/1), done.
> +    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> +    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
> +    Branch 'topic' set up to track remote branch 'topic' from 'origin'.
> +    Switched to a new branch 'topic'
> +------------
> +
> +The output is a bit surprising but it shows how partial clone works.
> +When we check out the branch 'topic' Git will request the missing blobs
> +because they are needed. Then, We can switch back to branch 'master' by
> +
> +    $ git checkout master
> +
> +This time the output looks like
> +
> +------------
> +    Switched to branch 'master'
> +    Your branch is up to date with 'origin/master'.
> +------------
> +
> +It shows that when we switch back to the previous location, the checkout
> +is done without a download because the repository has all the blobs that
> +were downloaded previously.

Good illusration.  Nicely done.

> +`git log` may also make a surprise with partial clones. `git log
> +--<path>` will not cause downloads with the blob filters, because it's

You meant to leave a SP between double-dash and <pathspec> (these
things are called <pathspec> and not necessarily a <path>, so use
the right word) here.

> +only reading commits.

This is incorrect.  A pathspec limited "log" reads both commits and
trees.  Luckily, that does not change the conclusion---a blob-less
partial clone already has all tree objects in addition to commit
objects, so there is no need for lazy/on-demand fetching.

> `git log -p -- <path>` will download blobs to
> +generate the patch output and git log --raw will download all blobs
> +that changed at recent commits in order to compute renames.

I do not know anybody sane uses '--raw' these days, but a better
way to describe this may be

    In addition to any options that require git to look at the
    contents of blobs, like "-p" and "--stat", options that cause
    git to report pathnames, like "--summary" and "--raw", will
    trigger lazy/on-demand fetching of blobs, as they are needed to
    detect inexact renames.

Thanks.
