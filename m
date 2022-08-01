Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43869C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiHAVdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHAVdf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:33:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAD15A3C
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:33:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BED711A513D;
        Mon,  1 Aug 2022 17:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1kWRiTzFRw+xjQ/JpGmvbWo+QZ6Mfh/hR2xx7G
        piblU=; b=RUdLf5Xs8LsFcH7B4U2i0ySzTFwpLxZRzDRyTVqnkfmh0RiUjiL0Hv
        lyjIYKagdWGUonAP0tkOoxp2EJI2HOiYPS3gD3H2ygzuikgF5XGvp7jUtnu0UVQb
        4dXApqjOnJvImj/RIa/Amt/9/kzu2/m2rbKCH5oMTwDQuXsdcWhrY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7B381A513C;
        Mon,  1 Aug 2022 17:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67B4B1A513B;
        Mon,  1 Aug 2022 17:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-reflog: remove unneeded \ from \{
References: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 14:33:29 -0700
In-Reply-To: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 01 Aug 2022 21:04:45 +0000")
Message-ID: <xmqqles7odhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 963F18F8-11E1-11ED-B274-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix this inconsistent rendering by removing the unnecessary "\" in
> Documentation/git-reflog.txt.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     Documentation/git-reflog: remove unneeded \ from {
>     
>     I noticed this inconsistency as I was trying to build Git docs with
>     Google's internal build system. This string seems particularly
>     problematic e.g. you can see unnecessary "\" on
>     https://git-scm.com/docs/git-reflog#_description.
>     
>     I'm not proficient in asciidoc at all, but I suspect that this isn't
>     tied to the asciidoc version; I initially observed these differences in
>     environments with different versions of asciidoc (9.0.0 and 10.2.0) but
>     I can't reproduce this at all on my Mac using different versions of
>     asciidoc and asciidoctor from Homebrew. Perhaps the issue is in some
>     underlying library?

Thanks.  ref@\{specifier\} came from 552cecc2 (Teach "git reflog" a
subcommand to delete single entries, 2007-10-17) but that is so
distant past that the world must have changed too much that past
experiences would not help all that much X-<.  There are too many
moving parts, older and more recent asciidoc, plus asciidoctor.

Those who care about gitman.texi may also want to check the end
result, as the toolchain there involves docbook, yet another moving
part.

Will queue.  Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1304%2Fchooglen%2Fdocumentation%2Fbackslash-brace-asciidoc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1304/chooglen/documentation/backslash-brace-asciidoc-v1
> Pull-Request: https://github.com/git/git/pull/1304
>
>  Documentation/git-reflog.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> index 5ced7ad4f8b..db9d46edfa9 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -22,7 +22,7 @@ depending on the subcommand:
>  	[--rewrite] [--updateref] [--stale-fix]
>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
>  'git reflog delete' [--rewrite] [--updateref]
> -	[--dry-run | -n] [--verbose] <ref>@\{<specifier>\}...
> +	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>  'git reflog exists' <ref>
>  
>  Reference logs, or "reflogs", record when the tips of branches and
>
> base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
