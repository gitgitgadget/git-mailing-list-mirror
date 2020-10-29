Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F3C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34DF420720
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TOMGI4lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJ2URF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:17:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52203 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2URE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:17:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4A4C102F58;
        Thu, 29 Oct 2020 16:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/S3H2d5ViQoaQVjZett1SPAI0q0=; b=TOMGI4
        lpy5/LRHvL2TkszarivvZ8cJ0pJh1GoY5hXMv59WMW0MvxT13L73qdY+Z9Jnm5P0
        92aRyN200iatJs+pnz6zgGi5MQjgsxPHAl+Kjw3rysMyuarBHZyXICklEP4SJwB1
        a+eslXxpItQah8iAo5eM/ppWOulepHGBp1q9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AfObxLSXqqD18q1tGPLG1h7MfBorPlIX
        r/7yHsMut5241/MucWx8zuEB7LsTkB5pbib9hNfN5xdodeCPh2WurUKtI1UdJ8iH
        H4MZDantIPcDGIpN/GLdklWt3VtDI15jFwvt2OWPoN4Ysjm1YVPI1vZLjw/Yjlp8
        0U7UWnIjAoA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD4DB102F57;
        Thu, 29 Oct 2020 16:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1EC2E102F56;
        Thu, 29 Oct 2020 16:16:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/6] doc: log, gitk: move '-L' description to
 'line-range-options.txt'
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <96f6f95abcbd79d432073cb294ba12b71300580f.1603889270.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 13:16:55 -0700
In-Reply-To: <96f6f95abcbd79d432073cb294ba12b71300580f.1603889270.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 28 Oct 2020
        12:47:45 +0000")
Message-ID: <xmqqft5w7poo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1A3765A-1A23-11EB-95EA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The description of the '-L' option for `git log` and `gitk` is the
> same, but is repeated in both 'git-log.txt' and 'gitk.txt'.

They are moral equivalents but differ slightly, both in
an insignificant way (i.e. SP after -L and its parameters) and a
significant way (i.e. Note about gitk usage), so "the same, but is
repeated" is not sufficient to explain why the contents of the new
file looks the way it is.

> Remove the duplication by creating a new file, 'line-range-options.txt',
> and include it in both files.

Makes sense.  As to the conditional, I actually think the version
with SP after -L do not have to be listed and instead to show just
the "stuck" form as the standardised way.  If the option takes an
optional value, you must have to use the "stuck" form anyway, and
showing that you _could_ have SP there unnecessarily throws extra
bytes at the reader with no real gain.

> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index c653ebb6a8..761b764c18 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -98,25 +98,8 @@ linkgit:git-rev-list[1] for a complete list.
>  	(See "History simplification" in linkgit:git-log[1] for a more
>  	detailed explanation.)
>  
> --L<start>,<end>:<file>::
> --L:<funcname>:<file>::
> ...
> -	`--name-only`, `--name-status`, `--check`) are not currently implemented.
> -+
> -*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
> -this option if you specify it "glued together" with its argument.  Do
> -*not* put a space after `-L`.
> -+
> -include::line-range-format.txt[]
> +:gitk: 1
> +include::line-range-options.txt[]

It looked puzzling to see the inclusion of line-range-format is lost
from here, but it turns out to be OK after all when we look at the
new line-range-options file.

> diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.txt
> new file mode 100644
> index 0000000000..9e3d98d44f
> --- /dev/null
> +++ b/Documentation/line-range-options.txt
> @@ -0,0 +1,27 @@
> +ifdef::git-log[]
> +-L <start>,<end>:<file>::
> +-L :<funcname>:<file>::
> +endif::git-log[]
> +ifdef::gitk[]
> +-L<start>,<end>:<file>::
> +-L:<funcname>:<file>::
> +endif::gitk[]

As I said, my vote goes to reducing the variations and using only
the latter form for simplicity.

> +	Trace the evolution of the line range given by "<start>,<end>"
> +	(or the function name regex <funcname>) within the <file>.  You may
> +	not give any pathspec limiters.  This is currently limited to
> +	a walk starting from a single revision, i.e., you may only
> +	give zero or one positive revision arguments, and
> +	<start> and <end> (or <funcname>) must exist in the starting revision.
> +	You can specify this option more than once. Implies `--patch`.
> +	Patch output can be suppressed using `--no-patch`, but other diff formats
> +	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
> +	`--name-only`, `--name-status`, `--check`) are not currently implemented.

This text is the same as both originals, which is good.

> ++
> +ifdef::gitk[]
> +*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
> +this option if you specify it "glued together" with its argument.  Do
> +*not* put a space after `-L`.
> +endif::gitk[]

I think it may make sense to keep this part, mostly from "keep the
result as close to the original as possible while refactoring"
principle, but if we only teach the "stuck" form in "git log", it
becomes irrelevant---one fewer thing the users need to learn and
remember, it becomes easier for them to concentrate on what really
matters.


> +include::line-range-format.txt[]

And the answer to my earlier puzzlement is here.  I actually would
have expected that it would be the matter of moving the common text
you moved from gitk/log documentation to this file instead to the
top of the line-range-format.txt file, but the latter is included
also by blame-options.txt, and the description of the option needs
to be somewhat different between blame and log anyway, so I think
this is the best we can do at this step in the series.

Looking good so far...
