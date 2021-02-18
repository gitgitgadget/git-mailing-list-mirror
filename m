Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0664AC4332E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E2E64EAD
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhBRTcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62113 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBRTYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:24:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C59D612AF31;
        Thu, 18 Feb 2021 14:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qfOtHA7zY2LYAkzhrFD6SMMjGGw=; b=Hh4xXj
        TDXvV4jtllGsQJJT1XdOTz+xrcLN0sM3yRjJPRafkNIpuIMyMkIrcHX3jOncknlO
        sp1P4wDA1338Go+qmZqYfKRvK1CJC/+d9FQS8/PkOiGdXMem95PtrZeb/0kmxCV8
        b/SfNY5zB9/lrF5Rf12M8YMqW4F6j/iUaNLa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aTnRPl/OFgaAjxE9U+sym/TSv/F2wsEz
        P+HPsWVczUg5hEOo/CeMDdPGGMs+5GWobNSJZeZW5ozW/Nks7mwyHkbntvtGehf1
        PELp2AMRwH+oDpPwVZpRZ8UfzL8Msb5pFMIPiWpR0WrdJsBehKS2Fj4GKhmbV7ej
        owqtcr4gv7c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD93012AF30;
        Thu, 18 Feb 2021 14:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06D5212AF2F;
        Thu, 18 Feb 2021 14:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 6/6] doc/git-commit: add documentation for
 fixup[amend|reword] options
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-6-charvi077@gmail.com>
Date:   Thu, 18 Feb 2021 11:23:17 -0800
In-Reply-To: <20210217073725.16656-6-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Wed, 17 Feb 2021 13:07:25 +0530")
Message-ID: <xmqqlfblfae2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1C55A64-721E-11EB-A035-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  Documentation/git-commit.txt | 39 ++++++++++++++++++++++++++++++------
>  Documentation/git-rebase.txt | 21 ++++++++++---------
>  2 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 17150fa7ea..9a60876845 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> +	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> @@ -86,11 +86,38 @@ OPTIONS
>  	Like '-C', but with `-c` the editor is invoked, so that
>  	the user can further edit the commit message.
>  
> ---fixup=<commit>::
> -	Construct a commit message for use with `rebase --autosquash`.
> -	The commit message will be the subject line from the specified
> -	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
> -	for details.
> +--fixup=[(amend|reword):]<commit>::
> +	When used without options, lets's say `git commit --fixup=<commit>`,
> +	it creates a "fixup!" commit where the commit message will be
> +	the subject line from the specified commit with a prefix of
> +	"fixup! ". The resulting "fixup!" commit is further used with
> +	`git rebase --autosquash` to fixup the content of the specified
> +	commit.
> +
> +	When used with option `amend`, let's say
> +	`git commit --fixup=amend:<commit>`, it creates a "amend!" commit
> +	to fixup both the content and the commit log message of the
> +	specified commit. The resulting "amend!" commit's commit message
> +	subject will be the subject line from the specified commit with a
> +	prefix of "amend! " and the message body will be commit log message
> +	of the specified commit. It also invokes an editor seeded with the
> +	"amend!" commit log message to allow to edit further. And it denies
> +	to create "amend!" commit if it's commit message body is empty unless
> +	used with `allow-empty-message` option. "amend!" commit when rebased
> +	with `--autosquash` will fixup the contents and replace the commit
> +	message of the specified commit with the "amend!" commit's message
> +	body.
> +
> +	When used with alternative option `reword`, let's say
> +	`git commit --fixup=reword:<commit>`, it works similar to `amend`
> +	option, but here it creates an empty "amend!" commit, i.e it does
> +	not take any staged changes and only allows to fixup the commit
> +	message of the specified commit. It will reword the specified
> +	commit when it is rebased with `--autosquash`.
> +
> +	`--fixup`, with or without option, can be used with additional
> +	commit message option `-m` but not with `-F`/`-c`/`-C`. See
> +	linkgit:git-rebase[1] for details.

You must dedent the second and the subsequent paragraphs and replace
each of these blank lines that mark inter-paragraph breaks with a
line with a single plus '+' sign on it.  See how "is mutually
exclusive" explanation is appended to the description of "-m" as its
second paragraph.

Side note.  It probably needs "exclusive -> incompatible".

The description in git-rebase.txt you touched is another good
example.  Mimic the way its second paragraph "If the autosquash is
enabled..."  is formatted.

Thanks.

>  --squash=<commit>::
>  	Construct a commit message for use with `rebase --autosquash`.
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 8bfa5a9272..ffea76e53b 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -593,16 +593,17 @@ See also INCOMPATIBLE OPTIONS below.
>  
>  --autosquash::
>  --no-autosquash::
> -	When the commit log message begins with "squash! ..." (or
> -	"fixup! ..."), and there is already a commit in the todo list that
> -	matches the same `...`, automatically modify the todo list of rebase
> -	-i so that the commit marked for squashing comes right after the
> -	commit to be modified, and change the action of the moved commit
> -	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
> -	the commit subject matches, or if the `...` refers to the commit's
> -	hash. As a fall-back, partial matches of the commit subject work,
> -	too.  The recommended way to create fixup/squash commits is by using
> -	the `--fixup`/`--squash` options of linkgit:git-commit[1].
> +	When the commit log message begins with "squash! ..." (or "fixup! ..."
> +	or "amend! ..."), and there is already a commit in the todo list that
> +	matches the same `...`, automatically modify the todo list of
> +	`rebase -i`, so that the commit marked for squashing comes right after
> +	the commit to be modified, and change the action of the moved commit
> +	from `pick` to `squash` (or `fixup` or `fixup -C`) respectively. A commit
> +	matches the `...` if the commit subject matches, or if the `...` refers
> +	to the commit's hash. As a fall-back, partial matches of the commit
> +	subject work, too. The recommended way to create fixup/squash/amend
> +	commits is by using the `--fixup=[amend|reword]`/`--squash` options of
> +	linkgit:git-commit[1].
>  +
>  If the `--autosquash` option is enabled by default using the
>  configuration variable `rebase.autoSquash`, this option can be
