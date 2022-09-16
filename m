Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24234ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 15:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiIPPhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiIPPhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 11:37:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1597B34
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 08:37:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D76F1A81EC;
        Fri, 16 Sep 2022 11:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKmj1boSTKaR9nzFUKMHgeA7GrBoM9NkiU+JjU
        Fadrs=; b=cPjWa0d27YrERdrEviEny+ls8aVaEBN/dRODF2NbHFDOppJ6IGEmop
        uiuEP0FoToYoZwSMGAEQEiEFL2Si858m/bOSqSnJpMdDWZqETexxqOsN8e7o+dNA
        klTykRtfLOBFOOJW9DAl2Ml43SJ232ZOr/EVSXndReqga68sMzADs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9795F1A81EB;
        Fri, 16 Sep 2022 11:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6082E1A81E5;
        Fri, 16 Sep 2022 11:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] docs: fix a few recently broken links
References: <20220916062303.3736166-1-tmz@pobox.com>
Date:   Fri, 16 Sep 2022 08:37:02 -0700
In-Reply-To: <20220916062303.3736166-1-tmz@pobox.com> (Todd Zullinger's
        message of "Fri, 16 Sep 2022 02:23:02 -0400")
Message-ID: <xmqqzgezjppd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6996097A-35D5-11ED-8FDC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Some links were broken in the recent move of various technical docs
> c0f6dd49f1 (Merge branch 'ab/tech-docs-to-help', 2022-08-14).
>
> Fix them.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---

Thanks.

It is a bit sad that the links can only be relative (with which, a
move like c0f6dd49f1 can easily break them) or absolute (with which,
it is impossible to "hang" the entire documentation set under some
hierarchy in a larger set of pages).  I suppose that use of base
href might help, but it would make the result more cumbersome to set
up with than the fully relative collection of pages, which is what
we have.

> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
> index c25c42378a..85c6a7fc7c 100644
> --- a/Documentation/technical/bundle-uri.txt
> +++ b/Documentation/technical/bundle-uri.txt
> @@ -3,8 +3,7 @@ Bundle URIs
>  
>  Git bundles are files that store a pack-file along with some extra metadata,
>  including a set of refs and a (possibly empty) set of necessary commits. See
> -linkgit:git-bundle[1] and link:bundle-format.txt[the bundle format] for more
> -information.
> +linkgit:git-bundle[1] and linkgit:gitformat-bundle[5] for more information.

Good.  Thanks for being careful.

>  Bundle URIs are locations where Git can download one or more bundles in
>  order to bootstrap the object database in advance of fetching the remaining
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index ca9decdd95..dc9c6a663a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3133,7 +3133,7 @@ those "loose" objects.
>  You can save space and make Git faster by moving these loose objects in
>  to a "pack file", which stores a group of objects in an efficient
>  compressed format; the details of how pack files are formatted can be
> -found in link:gitformat-pack[5].
> +found in linkgit:gitformat-pack[5].

This, too.

Will queue.
