Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2928C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A626192E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC2V17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:27:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59560 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhC2V10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:27:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 626D712578E;
        Mon, 29 Mar 2021 17:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hY+wyuGuSn4u7zN42tu2sEIgpUE=; b=c4AZHR
        55i+phHnsFEnmboRjSMUBecMCjqtwZD4KYkDsS9yRxuPpftbyYEMf5/oOrJzuwio
        gwk++/wJTw+M8FuXzdDixTr7Wl7j3dFGI5izg+fMFGYTsTOWmnVbXcuhVtCaWb/R
        bE8C2YzHF0vsolgzwryMWT8kwGbIHfL5ZX9Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R1+CSkliNpjTyESdPc1dqG6DOlOK5bes
        7mFNjr87zP8RM6byrPPdF9gajilBYmTioQf+tSag+F1t6viGV686rYMKjH7+nuoV
        WNMdS2hhU4FgepxrNdCY+qLNc8PYjx71sB5YSs9djDoG6cX9ij2x7q61Y0ZDk/pl
        BWoktZz54bs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5ACA212578D;
        Mon, 29 Mar 2021 17:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92109125789;
        Mon, 29 Mar 2021 17:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chinmoy <chinmoy12c@gmail.com>
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
        <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 14:27:21 -0700
In-Reply-To: <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com> (Chinmoy
        via GitGitGadget's message of "Sun, 28 Mar 2021 12:54:59 +0000")
Message-ID: <xmqqim59irba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D30ACA6-90D5-11EB-A90B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>
> This commit lists the special strings used with `--date`
> in `git-commit.txt` and also a brief explanation about
> the strings in `date-formats.txt`.

All of that can be read from the patch text.  What an author is
expected to explain in the proposed commit log message is WHY.

Why is it a good idea to list possible arguments --date can take?

The reason can include "because so far they are not explained
anywhere."

Documentation/SubmittingPatches::describe-changes, especially
[[meaningful-message]], is a good source to learn what a title and a
proposed log message of a patch should look like in this project.

> diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
> index 99c455f51c04..83c423a3ec2e 100644
> --- a/Documentation/date-formats.txt
> +++ b/Documentation/date-formats.txt
> @@ -1,6 +1,38 @@
> +[[DATE-FORMATS]]
>  DATE FORMATS
>  ------------
>  
> +`yesterday`::
> +	Change commit time to yesterday, that is, 24 hours ago.
> +
> +`noon`::
> +	Change commit time to noon, that is 12:00. If current
> +	time is less than 12:00, the time will be set to 12:00
> +	on the previous day, else it will be set to 12:00 on
> +	the same day.
> +
> +`midnight`::
> +	Change commit time to midnight, that is, 00:00.
> +
> +`tea`::
> +	Change commit time to 17:00(tea time). If the current
> +	time is less than 17:00, the time will be set to 17:00
> +	on the previous day, else it will be set to 17:00 on
> +	the same day.
> +
> +`PM`::
> +	Change commit time from AM to PM. If the current time
> +	is already greater than 12:00, then the time remains
> +	unaltered.
> +
> +`AM`::
> +	Change commit time from PM to AM. If current time is
> +	already less than 12:00, then the time remains
> +	unaltered.
> +
> +`now`::
> +	Change commit time to current time.

The "commit" related documentation is not the only consumer of this
file.  These new descriptions repeatedly stress "commit time", but
are these acceptable to readers of other page(s) that include this
file, or is the discrepancy irritating to them?

In any case, I personally think these should NOT be described at the
beginning of this file.  The primary formats the end-users should
learn to use are the ones that are described already in the
document.  All of the above are more like "by the way, did you know
that 'git-commit --date' takes these cute strings? easter eggs.

I am not very strongly opposed to extending the tail end of the
existing contents of the file, namely:

    ifdef::git-commit[]
    In addition to recognizing all date formats above, the `--date` option
    will also try to make sense of other, more human-centric date formats,
    such as relative dates like "yesterday" or "last Friday at noon".
    endif::git-commit[]

and explain what "such as ..." is, but I am fairly negative on
teaching 'tea' to our users before we talk about 2822 and 8601
formats.  I actually think the above three lines strikes a good
balance---we do not want the users to be surprised too much when
they see "--date yesterday" to work, but we do not particularly
want to encourage them to use "commit --date noon" [*1*].

>  The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
>  support the following date formats:
>  
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 3c69f461c9af..1935fad33f35 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -176,7 +176,10 @@ See linkgit:git-rebase[1] for details.
>  	the commit author is then copied from the first such commit found.
>  
>  --date=<date>::
> -	Override the author date used in the commit.
> +	Override the author date used in the commit. The value of <date>
> +	may be any one of the following special values - "yesterday",
> +	"noon", "midnight", "tea", "PM", "AM", "never", "now"
> +	(see <<DATE-FORMATS>>).

Likewise.  I am OK with adding (see date-formats) but against
listing the easter eggs as if they are more important than other
forms.

Thanks.


[Footnote]

*1* The approxidate is useful when a rough "around that time"
    specification suffices, e.g. "git log --since='last.week'".  The
    user is OK to see commits down to roughly a week old, and would
    not be upset if a commit with a timestamp that is 9 days old
    shown.

    On the other hand, it would be unusual that somebody cares
    enough to use "git commit --date" but yet it is OK that the time
    recorded is fuzzy.  For that reason alone, I am in general
    negative on the direction this patch tries to take us in.



