Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC178C4727C
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E1C23A9C
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvYIf1y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIVF1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:27:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55240 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgIVF1y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 01:27:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 458F473327;
        Tue, 22 Sep 2020 01:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPN5wyAuAF6exAQ5PEI1qaL/yIo=; b=cvYIf1
        y+SU4iG0hlcq1SGv2W5n56AyEci+lBUWtZL24rYLMiYHe3fGmNGhMNzklV9w8V5a
        vd3z0f28xin95+Gj2LkhHxw6WOPX5gtMwejRyz90yqvR4EuQeDKsHZ00ooER5/Ev
        tnbnhqFIQ6lA4/8X0Z8LcxmZA0u8L0VQnXtbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZGYgmAQ+YCSHl3WvDV+bsr83ZtT4yReo
        CBLjtrhHgOYyab+BYDbxLWCpEGFmLCJfDI4iX9oQvmsOvX+PWy0WTqASke5YeuW+
        nduI1E+/zxJ+Ej0oiVeoywitbp2BUYrl5uvSDL0L4VANGwnkN9/MqV2754tKlCJj
        QtoxuKdVnx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D8C873326;
        Tue, 22 Sep 2020 01:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB46D73325;
        Tue, 22 Sep 2020 01:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] commit: reorder synopsis
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
        <80a69318b57348c59e45c0f8df1c342ef84388d4.1600695050.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:27:49 -0700
In-Reply-To: <80a69318b57348c59e45c0f8df1c342ef84388d4.1600695050.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 21 Sep 2020 13:30:49
        +0000")
Message-ID: <xmqqft7acre2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B72F7E4-FC94-11EA-96FF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Rearrange the synopsis for `git commit` to try and put options that
> are used more often nearer the beginning.

Which option is used "more often" depends heavily on the workflow,
and it is a bit unfriendly to those who are affected by this change
not to list the ones you are demoting, with rationale for each,
something like:

 - "--dry-run" may or may not be used often, but it is orthogonal to
   the regular options that affect how the command behaves, and it
   is much less important and interesting than the other options.

Among the ones you are demoting without explanation

 - "-s" is no longer even mentioned, which I do not think is a well
   thought out change.

 - "-v" is to make the command do the same thing as it does without
   it, but just more loudly, so it is less interesting than the
   other options.

 - "-u<mode>" affects what is shown in the editor to prepare the log
   message, which is of less importance than other options that
   affect the outcome of the command.  When --no-status is in
   effect, -u<mode> would not even have any effect, so it probably
   makes sense to move this next to "--[no-]status".

 - "--reset-author" can be used not just to take ownership of the
   commit from somebody else, but also be used to update the author
   date of your own change.  It probably belongs to the same group
   as -c/-C/-F/-m that affects the metadata of the resulting commit
   and should stay at the original location in the list.  If you
   want to change anything around this area, I'd suggest moving
   --date=<date> close to this "options that affect commit's
   metadata" group.



> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-commit.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index a1d1d1246f..9de4dc5d66 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -8,11 +8,11 @@ git-commit - Record changes to the repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> -	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> -	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +'git commit' [-a | --interactive | --patch] [--amend]
> +	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
> +	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e]
> +	   [--reset-author] [--author=<author>] [--date=<date>]
> +	   [--cleanup=<mode>] [-v] [-u<mode>] [--dry-run] [--[no-]status]
>  	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>  	   [-S[<keyid>]] [--] [<pathspec>...]
