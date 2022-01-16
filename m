Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EBC433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 22:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiAPWru (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 17:47:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61008 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAPWrt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 17:47:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70768172B4C;
        Sun, 16 Jan 2022 17:47:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6wj3f2vyqhM/cixBIMwFzNW7W0KdIxvlJCHvk8
        Q3V0Y=; b=kpt2mc1dZoMV2EBM4mn7zetilyaCc8GS2fVhHTjJzFttYyvrv82mKQ
        tCta5ziARZGZYCPiRuggwkp3sYFUjrwAjkGzA7VD10MX6psccyDClP+WGYFjiw65
        de7KKvls6tyOjRWZ1lqOM3gG95soJmXjzzLJ18vHw9AaS8+91S5yo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67778172B4B;
        Sun, 16 Jan 2022 17:47:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFD26172B4A;
        Sun, 16 Jan 2022 17:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] README.md: add CodingGuidelines and a link for
 Translators
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
        <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
Date:   Sun, 16 Jan 2022 14:47:45 -0800
In-Reply-To: <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com> (Philip
        Oakley via GitGitGadget's message of "Sun, 16 Jan 2022 16:11:30
        +0000")
Message-ID: <xmqq5yqjz4a6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 531B09F0-771E-11EC-85A8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Oakley <philipoakley@iee.email>
>
> The README.md does not use the GitHub Markdown URL links [1] of
> [txt](url), rather the reference method [2] of trailing empty square
> brackets. The references themselves are listed at the foot of the
> document. Those footers are not shown by GitHub/GitLab rendering.

Thanks for tracking down the differences.

The above only describes what we could do (i.e. use links instead of
reference), and how the current document is rendered (i.e. footers
are not shown).  No changes come from the above description.

> Also space out the list joining instructions and clarify that
> subscription is via the majordomo address.

So, seeing "Also" immediately after a paragraph that explains the
status quo confused me a lot.

"Spell out the instructions to join the list, and clarify that the
subscription is via the majordomo address" is indeed a part of what
this patch does.  Perhaps we need a separate paragraph _before_ this
"Also".

So taking all together

    Before being told how to submit patches, new contributors need
    to be told how to code for, or how to contribute translation to,
    the project.  Add references to the CodingGuidelines and the
    README document on localization.

    Also, spell out the instructions to join the list and ...
    
    We use GitHub Markdown reference [2] with trailing empty square
    brackets, to match existing text in the file.  On GitHub/GitLab
    pages, these references are not shown on the page, but it is OK
    because they are empty.  We could switch to using [text](url)
    form [1] if we wanted to, but that is not done as part of this
    patch.

would be the presentation order that I would expect to be the most
readable.  I moved the discussion between URL link and reference, as
it is merely a hint for future and not the core thing that needs to
be explained to understand the changes in this commit.

Thanks.


> [1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
> [2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>     README.md: add CodingGuidelines and a link for Translators
>     
>     Also space out the list joining instructions and clarify the
>     subscription via the majordomo address.
>     
>     
>     Signed-off-by: Philip Oakley philipoakley@iee.email
>     ===================================================
>     
>     cc: Philip Oakley philipoakley@iee.email cc: Junio C Hamano
>     gitster@pobox.com cc: Jiang Xin worldhello.net@gmail.com
>     
>     changes since v1:
>     
>      * Used reference style links, rather than lnk [url] style.
>     
>      * added Jianf as L10 coordinator.
>     
>      * note: Patch is a response to a user question on the "Git for Human
>        Beings" git-users list
>        https://groups.google.com/d/msgid/git-users/aa68b9c8-4cf4-4193-8af3-79d7e3feafbbn%40googlegroups.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1115%2FPhilipOakley%2FReadme-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1115/PhilipOakley/Readme-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1115
>
> Range-diff vs v1:
>
>  1:  ac6d0abbdde ! 1:  48cc30b7cc8 README.md: add CodingGuidelines and a link for Translators
>      @@ Metadata
>        ## Commit message ##
>           README.md: add CodingGuidelines and a link for Translators
>       
>      -    Also space out the list joining instructions and clarify the subscription
>      -    via the majordomo address.
>      +    The README.md does not use the GitHub Markdown URL links [1] of
>      +    [txt](url), rather the reference method [2] of trailing empty square
>      +    brackets. The references themselves are listed at the foot of the
>      +    document. Those footers are not shown by GitHub/GitLab rendering.
>      +
>      +    Also space out the list joining instructions and clarify that
>      +    subscription is via the majordomo address.
>      +
>      +    [1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
>      +    [2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
>       
>           Signed-off-by: Philip Oakley <philipoakley@iee.email>
>       
>      @@ README.md: installed).
>        requests, comments and patches to git@vger.kernel.org (read
>       -[Documentation/SubmittingPatches][] for instructions on patch submission).
>       +[Documentation/SubmittingPatches][] for instructions on patch submission
>      -+and [Documentation/CodingGuidelines]() ).
>      ++and [Documentation/CodingGuidelines][]).
>       +
>       +Those wishing to help with error message translation (localization L10)
>      -+should see [po/README.md]()
>      -+(a `po` file is a portable object file for the translations).
>      ++should see [po/README.md][] (a `po` file is a Portable Object file that
>      ++holds the translations).
>       +
>        To subscribe to the list, send an email with just "subscribe git" in
>       -the body to majordomo@vger.kernel.org. The mailing list archives are
>       -available at <https://lore.kernel.org/git/>,
>      -+the body to majordomo@vger.kernel.org (not the list). The mailing list
>      -+archives are available at <https://lore.kernel.org/git/>,
>      ++the body to majordomo@vger.kernel.org (not the Git list). The mailing
>      ++list archives are available at <https://lore.kernel.org/git/>,
>        <http://marc.info/?l=git> and other archival sites.
>        
>        Issues which are security relevant should be disclosed privately to
>      +@@ README.md: and the name as (depending on your mood):
>      + [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
>      + [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
>      + [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
>      ++[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
>      ++[po/README.md]: po/README.md
>      + \ No newline at end of file
>
>
>  README.md | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/README.md b/README.md
> index f6f43e78deb..d2b061e3998 100644
> --- a/README.md
> +++ b/README.md
> @@ -32,10 +32,16 @@ installed).
>  The user discussion and development of Git take place on the Git
>  mailing list -- everyone is welcome to post bug reports, feature
>  requests, comments and patches to git@vger.kernel.org (read
> -[Documentation/SubmittingPatches][] for instructions on patch submission).
> +[Documentation/SubmittingPatches][] for instructions on patch submission
> +and [Documentation/CodingGuidelines][]).
> +
> +Those wishing to help with error message translation (localization L10)
> +should see [po/README.md][] (a `po` file is a Portable Object file that
> +holds the translations).
> +
>  To subscribe to the list, send an email with just "subscribe git" in
> -the body to majordomo@vger.kernel.org. The mailing list archives are
> -available at <https://lore.kernel.org/git/>,
> +the body to majordomo@vger.kernel.org (not the Git list). The mailing
> +list archives are available at <https://lore.kernel.org/git/>,
>  <http://marc.info/?l=git> and other archival sites.
>  
>  Issues which are security relevant should be disclosed privately to
> @@ -64,3 +70,5 @@ and the name as (depending on your mood):
>  [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
>  [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
>  [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
> +[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
> +[po/README.md]: po/README.md
> \ No newline at end of file
>
> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
