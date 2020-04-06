Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA05C2BA2B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E1A20768
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N8xTZNUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDFT2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:28:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50142 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFT2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 15:28:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CA5BCC8F3;
        Mon,  6 Apr 2020 15:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T0RrgxR2xGmktqg14Gnt2G5hKZU=; b=N8xTZN
        Upd0FeiZZARF43mjf+AXJjlJUTnD5GXf8hQG1N6/yzw/sUakl9fKq+QedTgAQhCO
        AgFQkPpCmOjk+bVfin4VPE5m/Ld3sgO3ukiedn0hBkTt6M9dtJRWwhCGfmcJ9Nid
        62XHE1UBKmUJX0VQTkkJC0igAADzukKcP+mUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eCn/CXcAlMHYvlm+vdwujgUpO9v1nVU4
        C0LSzWoHRyDmE6nepcD1ynOHNoDHbnEjfWnnU3XOKxFfstWsJDeO62lr/tJNSnZv
        IY5QwtS6Xa7T4dwRltOOam+dl8xRZHPedYA8mx9zJOvRNtP692zv0Y4/195GT61O
        RuI/LeqyITQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53EE5CC8F2;
        Mon,  6 Apr 2020 15:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97539CC8EE;
        Mon,  6 Apr 2020 15:28:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH 2/2] gitfaq: append the 'Common Issues' section
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
        <20200406181216.5340-3-shouryashukla.oo@gmail.com>
Date:   Mon, 06 Apr 2020 12:28:39 -0700
In-Reply-To: <20200406181216.5340-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 6 Apr 2020 23:42:16 +0530")
Message-ID: <xmqqv9mcv2fs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D217FE9E-783C-11EA-8566-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> +[[rebasing-and-merging]]
> +How do I know when to merge or rebase?::
> +	Rebasing and merging two entirely different concepts with different utiilites.

Can you wrap these lines at a more reasonable column, like 65-72?

> +	In Git terms, rebasing means to place changes made in one branch over another branch
> +	(called base, hence the term rebase). The commit history of the branch wanting to rebase
> +	get placed over the branch on the receiving end and it appears as if those changes took
> +	place in the receiving branch itself. Merging, as the name suggests, merges the latest
> +	commit of one branch onto the recent branch, making this combination appear as one separate
> +	commit.

There is nothing technically wrong per-se in the above, but is this
worth saying here, instead of polishing the tutorial or rebase/merge
manual pages?  Also, in the above, I do not see much that would help
readers to decide which one between merge and rebase to choose.

> +[[files-in-.gitignore-are-tracked]]
> +I asked Git to ignore various files, yet they show up as changes in my staging area::
> +	One uses `.gitignore` to ignore files from getting tracked in the working tree. This ignores
> +	the aforementioned files for the whole lifetime of the project unless they area removed from
> +	the `.gitignore`.

This should mention "git add" (and possibly "git status") somewhere.
You list patterns to match cruft you want to "IGNORE", (i.e. would
not want to track), so that "git add ." would ignore it, and "git
status" won't make noises about them not being tracked.

> But, `.gitignore` will only ignore the files which were not a part of the
> +	repository when they were mentioned in the `.gitignore`. Hence, addition of a file to `.gitignore`
> +	after it was added to the working tree will have no effect and Git will keep tracking them.
> +	To prevent this from happening, one has to use `git rm --cached <file>` to remove the file
> +	from the staging area(i.e. the cache) and not from the repository. 

That's not "prevent this from happening".  It is more like
recovering from an earlier mistake of adding what you did not want
to add.

But people ask ".gitignore does not ignore, my vendor.o file is
tracked, and I want changes to vendor.o to be ignored" in the
context of "once tracked, .gitignore would ont kick in", so the
above advice to "remove from the tracked set" would not even help
them.  Their expectation needs to be adjusted, and an entry in FAQ
you are trying to add is a good place to do so.

> +[[checking-out]]
> +What is checking out a commit/branch? How do I perform one?::
> +	In Git terminology, checking out means updating the current working tree with a another commit or
> +	even a separate tree(which would translate to a branch).

Unless you are going to mention "switch" and "restore", you should
stress the fact that "checkout" checks out two separate things for
two different purposes upfront, in the first sentence.

 - Checking out a branch (or a commit) is to set up the working tree
   files in preparation for working on the history of the branch
   (most often, to grow the history by adding more commits, but
   sometimes to edit the history by rebasing).

 - Checking out individual paths out of a tree-ish (most often, a
   commit) is to grab a verbatim copy of the path recorded in the
   tree-ish to update the files in the working tree, and is done to
   work on the history of the current branch.

People found the "checkout" command confusing, as the distinction
between the two weren't clearly taught to them.  More recent
versions of Git introduced "switch" and "restore" subcommands that
can be used only for the former and for the latter purpose,
respectively.

Thanks.
