Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EDC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 00:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6561A20674
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 00:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jG4VyZOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGGAzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:55:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63802 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGGAzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 20:55:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1046722A6;
        Mon,  6 Jul 2020 20:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vw9iRcR8oc0E1CxCWvi5ELz6m/E=; b=jG4VyZ
        OCx0LyLa5s6H9XFaldEtZrJrKbjOM6HKka96jwGY6qGsY5yChOz+dIbfQci9rM6G
        Js7CVcgryEplCwLadzOOP9mXWW90RUz7FjRckL8jukYVIwMXFK+uVpRgvqTnDNnh
        K/HwguK6+Q+SuYZ03tpqPZbHcOXZTew2VVTGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i5Dka8//zMGwgHdpbD8nxHrg8X9ZOLGW
        ku1zoiuUOr1lODFG4/DujFXzw5srqR8vJcovjFeCfilzHgcDR9cnBzFYWRbCKGJo
        k+16vNyBE0PlZ5T8xaulkSN0F8UWSjlN93KJnAJokXo5BvTSidWP1WnKxRXbCfem
        Typfcweet2E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8C91722A5;
        Mon,  6 Jul 2020 20:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3471E722A4;
        Mon,  6 Jul 2020 20:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/4] git-log.txt: add links to 'rev-list' and 'diff' docs
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <59c48282a094e90b7f4635c4cbcc04b1914b4c0e.1593747509.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 17:55:13 -0700
In-Reply-To: <59c48282a094e90b7f4635c4cbcc04b1914b4c0e.1593747509.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 03 Jul 2020
        03:38:26 +0000")
Message-ID: <xmqqimf087pq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8460526C-BFEC-11EA-B0EE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Add links to the documentation for `git rev-list` and `git diff`
> instead of simply mentioning them, to make it easier for readers to reach
> these documentation pages. Let's link to `git diff` as this is the
> porcelain command, and the rest of the family (`diff-index`, `diff-tree` and
> `diff-files`) are mentioned in the "Raw output format" section of the
> `git diff` documentation.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/git-log.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 20e6d21a74..04ea18d1c0 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -15,9 +15,9 @@ DESCRIPTION
>  -----------
>  Shows the commit logs.
>  
> -The command takes options applicable to the `git rev-list`
> +The command takes options applicable to the linkgit:git-rev-list[1]
>  command to control what is shown and how, and options applicable to
> -the `git diff-*` commands to control how the changes
> +the linkgit:git-diff[1] family of commands to control how the changes
>  each commit introduces are shown.

The original did mean "git diff-*" family of plumbing commands, but
I think it makes more sense these days to just refer to "git diff"
Porcelain, which is the single entry point everybody uses.  So you
would probably want to further replace "family of commands" with
just "command" in the text.

Other than that, I think making these into links is a good idea.
