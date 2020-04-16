Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D5C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396F120786
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgAseuAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgDPTFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:05:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61810 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgDPTFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 15:05:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C360154684;
        Thu, 16 Apr 2020 15:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0OImz7Ee2AsK7r8ybXkq7GZZvd0=; b=dgAseu
        Axy4Y592vFFzPURuiMxaen7QX9no7n/gnlJKylX3VEI6KgQngolN1OJKTCzqJ/1G
        XdM9pE/dQYnqgeF30yidDRElsKcdGamdTmxYGbcV0h8rl4Wb5S4mcMCJVrLvzJyc
        GmhKQuAWRMdcs+DksYXfmbN0u3V4D9TzivUjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CAcoAMwgVUlFMZ1/HpevELvWwlp+XD5t
        bJWmo65/gpLAbyl3ZkhlSwuhOAe0EmXdKHcHg1rScO8hfqPXohOX6RBvmhypwUxs
        A0OOHfwWqgDtiVKMUEX2PTsiSf3edlcbE0rWCq11Du7pGb2lKNJt19VdYg4kn1Er
        Rv6XclYFFK8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAF0C54683;
        Thu, 16 Apr 2020 15:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4243254682;
        Thu, 16 Apr 2020 15:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
        <20200413140918.4778-2-shouryashukla.oo@gmail.com>
Date:   Thu, 16 Apr 2020 12:05:38 -0700
In-Reply-To: <20200413140918.4778-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 13 Apr 2020 19:39:18 +0530")
Message-ID: <xmqqa73bz1x9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42E01A6E-8015-11EA-9115-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> +[[files-in-.gitignore-are-tracked]]
> +I asked Git to ignore various files, yet they show up as changes in my staging area::

(again, I'll wrap overly long lines, as they were unreviewable otherwise)

> +	One uses '.gitignore' to ignore files from getting tracked
> +	in the working tree. This ignores the aforementioned files
> +	for the whole lifetime of the project unless they area
> +	removed from the '.gitignore'.

At least "they area" -> "they are" is needed, but it is unclear
where these two sentences one to go.  

"to ignore files from getting tracked in the working tree" is why
you may want to use the '.gitignore' file.  That is OK.  But the
connection to the next sentence, especially the subject "This
ignores", is hard to grok.  I am guessing that you want to tell the
users something like

	Paths that match patterns listed in the `.gitignore` are
	not meant to be tracked.

	The act of adding a pattern in `.gitignore` that matches a
	set of paths that are not tracked is a declaration that you
	do not intend to track these paths and a request by you to
	Git to help you achieve that goal.

but you are trying to state it in a more approachable manner.  But I
sense that you ended up being unclear.

> +	Consequently, `git add` does
> +	not list these files as 'modified' even if any change was
> +	made in them and `git status` does not bother to track the
> +	changes in these files either.

This part is very much in line with the "you are declaring and
requesting".  The user does not want to track these paths, and these
commands are helping the user to achieve that wish.

However, "`git add` does not list ..." is questionable.  by
definition, Git does not care about contents of any untracked paths,
so there is no way for us to say `modified` about them.

The primary utility of `git add` is to add a path, which used to be
untracked, to the set of the paths that are tracked.  So perhaps

	To help you keep the paths untracked, `git add` does not add
	the paths that are not tracked and ignored without the
	`--force` option, and `git status` does not list them as
	untracked (i.e. possible candidate that you might want to
	add but forgot).

> +	But, '.gitignore' will only ignore the files which were not
> +	a part of the repository when they were mentioned in the
> +	it.
> +     Hence, addition of a file to '.gitignore' after it was
> +	added to the working tree will have no effect and Git will
> +	keep tracking them.

I am not sure wat you mean by the first sentence (even after
removing 'the' from "in the it.").  It does not matter if you wrote
the pattern '*.o' in the .gitignore file one year ago, or 7 seconds
ago.  As long as hello.o in the working tree is not tracked, it is
ignored.  Perhaps

	The `.gitignore` mechanism applies only to the files that
	are not already tracked.  A path that is already tracked
	will stay to be tracked even if you add a pattern that
	happens to match it to .gitignore file.

> +     To amend this mistake, i.e., to untrack
> +	and completely ignore a tracked file,

I'd omit "To amend this mistake, i.e.," from the above, if I were
writing this.  Also, I see no value in saying "completely" here.
It is not like there are ways to half-ignore or fully-ignore ;-). 

> +     one has to use `git rm
> +	--cached <file>` to remove the file from the staging
> +	area(i.e. the cache) and not from the repository(presuming
> +	the file has been added in the 'gitignore').

	To untrack a tracked file, without removing it from the
	working tree, "git rm --cached <file>" can be used.  To keep
	the file ignored after doing so, make sure that `.gitignore`
	knows that the file is to be ignored (e.g. by adding <file>
	to `.gitignore`, but you may already have a pattern that
	match <file> there).

Having commented on this section, I am not sure why we need so much
description here, instead of clarifying the existing documentation
of the mechanism in the Documentation/gitignore.txt file.

I think it is better to limit the FAQ list to two kinds of entries:

 * A topic that spans multiple mechanisms and features that is not
   easy to explain in a single documentation page may have to be
   described in place.

 * Other topics that already have authoritative description with
   adequate clarity in other pages should just have a summary
   paragraph that is less than 5 sentences, and a pointer to the
   authoritative page.

The `.gitignore` topic should fall into the latter category.  It is
a separate issue if Documentation/gitignore.txt has rooms for
improvement and if so, I think it is more productive to propose a
patch to it there, not adding too much description on the topic
here.

Thanks.


