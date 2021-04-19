Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A6C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD86C613AC
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbhDSVe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:34:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52292 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSVeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:34:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B82C12FDBD;
        Mon, 19 Apr 2021 17:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/9QnzAEcAZOsxcz13Sm3VPzLoKs=; b=UcGTPq
        GSkYbwKWxpiQda/AuKCivm80wqdsxfgfD7rP3kFXChCJnVuN5zB6U+PjBatITvw/
        NpVMdrPeNgwp3/a5+YsWi7pPQYSBGu6ta+HVTQZTYOg8smQc6s03+67ctCgSV5AW
        eWsHEf1qukYaIAem4oMV+VT3o0JW7dyFrGVjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WktXr4lF/6EKvzsMGvbT/7RWs5PTR9n7
        30dlcuIzC6bw75iXVKTXLkZQBpQG+Me2D5z50+TYE0qih30BFnfWFz6hSs0cQEqt
        zKKW8uaUFNKf51cjvbQ/P5OWP8yotaeF5/DDntw6Dv4f7AgykJYFMjbH6CNu2KDR
        bJcwlnsETOY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23E4A12FDBC;
        Mon, 19 Apr 2021 17:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D82012FDBB;
        Mon, 19 Apr 2021 17:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrey Bienkowski via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrey Bienkowski <hexagonrecursion@gmail.com>
Subject: Re: [PATCH] doc: clarify the filename encoding in git diff
References: <pull.996.git.git.1618838856399.gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 14:33:50 -0700
In-Reply-To: <pull.996.git.git.1618838856399.gitgitgadget@gmail.com> (Andrey
        Bienkowski via GitGitGadget's message of "Mon, 19 Apr 2021 13:27:35
        +0000")
Message-ID: <xmqqwnsy7ydd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFA27E82-A156-11EB-A687-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrey Bienkowski via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Signed-off-by: Andrey Bienkowski <hexagonrecursion@gmail.com>
> ---
>     My takeaway was to always parse it as utf8 regardless of platform or
>     environment.
>     
>     Changes since v1:

I do not think the readers on the list have seen the "v1", but
anyway, the 

>      * Replace "always" with "often"

"often" here sound more measured than ...

>  --name-only::
> -	Show only names of changed files.
> +	Show only names of changed files. The file names are usually encoded in UTF-8.
> +	For more information see the discussion about encoding in the linkgit:git-log[1]
> +	manual page.

... "usually" here ...

>  --name-status::
>  	Show only names and status of changed files. See the description
>  	of the `--diff-filter` option on what the status letters mean.
> +	Just like `--name-only` the file names are usually encoded in UTF-8.

... and here.

Thanks.
