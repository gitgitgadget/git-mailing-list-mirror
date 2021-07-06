Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C1C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE4761C98
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGFWAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:00:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63899 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:00:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC998136038;
        Tue,  6 Jul 2021 17:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GXYTvDsWOc32bfihyNifNJtvQo8UzaK9W5ehc9
        eiTGs=; b=ePp8kuoDrTHS7ZL87ZmfQ4lQ9UwjJ0ivOEsca7jbyaF2c1jVBYid/f
        bUgAeynHUSGIVO6F1fJNWVCBDQQSW6N4m+N3Z1WIQF4B4uSDfmXBGtJQi2Icg0o5
        B6ODnEzbSPYDUTsfKM+MBqFRtWmGOeXwNjSAjaNk+WxrVx/ruiKaM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5471136035;
        Tue,  6 Jul 2021 17:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 568A4136033;
        Tue,  6 Jul 2021 17:57:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Berry <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
References: <20210706205439.75015-1-andrew@furrypaws.ca>
        <20210706205712.75270-1-andrew@furrypaws.ca>
Date:   Tue, 06 Jul 2021 14:57:33 -0700
In-Reply-To: <20210706205712.75270-1-andrew@furrypaws.ca> (Andrew Berry's
        message of "Tue, 6 Jul 2021 16:57:12 -0400")
Message-ID: <xmqqk0m3gl6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF9E27C-DEA5-11EB-9EB8-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Berry <andrew@furrypaws.ca> writes:

>   * Patterns read from a `.gitignore` file in the same directory
> -   as the path, or in any parent directory, with patterns in the
> -   higher level files (up to the toplevel of the work tree) being overridden
> -   by those in lower level files down to the directory containing the file.
> -   These patterns match relative to the location of the
> -   `.gitignore` file.  A project normally includes such
> -   `.gitignore` files in its repository, containing patterns for
> +   as the path, or in any parent directory (up to the top-level of the work
> +   tree), with patterns in the higher level files being overridden by those in
> +   lower level files down to the directory containing the file. These patterns
> +   match relative to the location of the `.gitignore` file.  A project normally
> +   includes such `.gitignore` files in its repository, containing patterns for
>     files generated as part of the project build.

Line rewrapping makes it hard to see what actually got changed, but
does this only move "(up to the top-level of the work tree)" around
without anything else, as discussed?

If you do "toplevel" -> "top-level" while at it, perhaps we would
want to correct "work tree" -> "working tree".

Looking better.

Thanks.
