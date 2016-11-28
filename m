Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F651FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 23:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755930AbcK1X4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 18:56:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755822AbcK1X4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 18:56:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C83E55C50;
        Mon, 28 Nov 2016 18:56:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zl3vVvukwlkYsAWEBkwGaLtyFFM=; b=ir47V7
        xCmWVfQn8BKof006SjgV5cdlYs7TzXkRKbiy8Ajbg4Dm6j2YQFZDRD3a10MyNVLr
        j7ttp/iDBvpaY1MhptsfJrioFGqTW4iFexlqOENW8HmeUzGRPvJ3vhoeDUMhFfOU
        e+aJwr+OFYLPkPW/lzj2pP0Mjs1gq2cNjox3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gQlPRAMPHY2cLDj+VmiP9EeCoqABWkhP
        pxagDDcKOq6knx/7hHJRGW3pbJCWEYe3se9MjE1I8FQz9TRGXuMqpG0ZJxXuubyc
        /Rzkc0+l+cb9JZfzNHucn2SYTGIZXNAMXgBMLzqG6QVfwUWh7EPCAOlpCQLy9VNQ
        h4VfW+BAW9A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 954DC55C4F;
        Mon, 28 Nov 2016 18:56:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10A8F55C4E;
        Mon, 28 Nov 2016 18:56:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Release note spelling and phrasing fixups.
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
        <20161124165900.30605-1-marcnarc@xiplink.com>
Date:   Mon, 28 Nov 2016 15:56:47 -0800
In-Reply-To: <20161124165900.30605-1-marcnarc@xiplink.com> (Marc Branchaud's
        message of "Thu, 24 Nov 2016 11:59:00 -0500")
Message-ID: <xmqqtwargnuo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53862E52-B5C6-11E6-B604-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> Mostly just missing words and what I feel are clarifications.
>
> The biggest change is to the "git add -N" item.  Not 100% sure
> I got it right.
>
> 		M.

> - * When new paths were added by "git add -N" to the index, it was
> -   enough to circumvent the check by "git commit" to refrain from
> -   making an empty commit without "--allow-empty".  The same logic
> -   prevented "git status" to show such a path as "new file" in the
> + * "git commit" created an empty commit when invoked with an index
> +   consisting solely of intend-to-add paths (added with "git add -N").
> +   It now requires the "--allow-empty" option to create such a commit.
> +   The same logic prevented "git status" from showing such paths as "new files" in the
>     "Changes not staged for commit" section.

Yes this is much easier to read.  Greatly appreciated.

>   * Codepaths that read from an on-disk loose object were too loose in
> -   validating what they are reading is a proper object file and
> +   validating that they are reading a proper object file and
>     sometimes read past the data they read from the disk, which has
>     been corrected.  H/t to Gustavo Grieco for reporting.
> ...
> - * An author name, that spelled a backslash-quoted double quote in the
> -   human readable part "My \"double quoted\" name", was not unquoted
> + * An author name that has a backslash-quoted double quote in the
> +   human readable part ("My \"double quoted\" name"), was not unquoted
>     correctly while applying a patch from a piece of e-mail.
> ...
> - * It is a common mistake to say "git blame --reverse OLD path",
> -   expecting that the command line is dwimmed as if asking how lines
> + * "git blame --reverse OLD path" is now DWIMmed to show how lines
>     in path in an old revision OLD have survived up to the current
>     commit.
>     (merge e1d09701a4 jc/blame-reverse later to maint).
> ...
>   * The "submodule.<name>.path" stored in .gitmodules is never copied
>     to .git/config and such a key in .git/config has no meaning, but
> -   the documentation described it and submodule.<name>.url next to
> -   each other as if both belong to .git/config.  This has been fixed.
> +   the documentation described it next to submodule.<name>.url
> +   as if both belong to .git/config.  This has been fixed.

These, too.

> - * In a worktree connected to a repository elsewhere, created via "git
> + * In a worktree created via "git
>     worktree", "git checkout" attempts to protect users from confusion
>     by refusing to check out a branch that is already checked out in
>     another worktree.  However, this also prevented checking out a
> -   branch, which is designated as the primary branch of a bare
> +   branch which is designated as the primary branch of a bare
>     reopsitory, in a worktree that is connected to the bare
>     repository.  The check has been corrected to allow it.

This 'reopsitory' may already have been fixed ;-)

    ... goes and looks ...

Oops, no it hasn't.  I'll patch it up while queuing this.

> - * A hot-fix for a test added by a recent topic that went to both
> + * Hot-fixed a test added by a recent topic that went to both
>     'master' and 'maint' already.

Oops; an entry like this shouldn't have been in the release notes in
the first place, because those who are seeing the released versions
would have never seen such breakages.  Will try to remember removing
it.

Thanks, I missed this one completely even though you sent it out
last week and didn't have a chance to read it over before starting
today's integration cycle.
