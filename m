Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F0C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E923206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLUWfyFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgEDQlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:41:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59860 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgEDQlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:41:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7285CBA735;
        Mon,  4 May 2020 12:41:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z9V4HMrX49HU4av2+gpMu/FplM8=; b=bLUWfy
        FnEZkyQrM7RdXcBsHTWsO0WA6n2HGzIIsUDYYQnt6jUBfOsJ5wNF2irv/eEYItel
        7SQDLtcdkoE0U0jj+BS5WGFSSrXzedzcMgZpvrMoTmLS8FG9n4Ip8TEXTm4lHUp4
        wV3YTuDWS1QRNJ1tkTMCajxibfnLclujmj6+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=btL01lr30rOrJe0VWKQmgzYcPJkrR2ER
        aH8KafoQBzTa1T+8gQ1k/Sbr5IEMT4U4tv0IiQmAvviOSf076Mz349pNoT9+HsEZ
        b5nC+Wnc6SLoZA6IoOfmjJ1fMBLA5JgUmduV9rSOzG19zLDm6NuQsvhlRGej3MNK
        1RPn/PJ4BwY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5676FBA734;
        Mon,  4 May 2020 12:41:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DEF2BA733;
        Mon,  4 May 2020 12:41:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, newren@gmail.com
Subject: Re: [PATCH v5 1/4] gitfaq: files in .gitignore are tracked
References: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
Date:   Mon, 04 May 2020 09:41:29 -0700
In-Reply-To: <20200504054223.11125-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 4 May 2020 11:12:20 +0530")
Message-ID: <xmqqimhbhcue.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BECDB62-8E26-11EA-97FE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> Git tracking files/paths mentioned in '.gitignore'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Thank you Junio and Elijah for the review! :)
> I have tried to make the solutions to the issues as concise and crisp
> as possible, linking the Documentation wherever necessary. Also, I have
> converted 1SP -> 2 SP after full stops(.).

Indeed I find it concise and very much to the point.  Looks quite
well written.

Thanks, will queue (and please ping me if I forget ;-))

>
>  Documentation/gitfaq.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 1cf83df118..11d9bac859 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -223,6 +223,16 @@ a file checked into the repository which is a template or set of defaults which
>  can then be copied alongside and modified as appropriate.  This second, modified
>  file is usually ignored to prevent accidentally committing it.
>  
> +[[files-in-.gitignore-are-tracked]]
> +I asked Git to ignore various files, yet they are still tracked::
> +	A `gitignore` file ensures that certain file(s) which are not
> +	tracked by Git remain untracked.  However, sometimes particular
> +	file(s) may have been tracked before adding them into the
> +	`.gitignore`, hence they still remain tracked.  To untrack and
> +	ignore files/patterns, use `git rm --cached <file/pattern>`
> +	and add a pattern to `.gitignore` that matches the <file>.
> +	See linkgit:gitignore[5] for details.
> +
>  Hooks
>  -----
