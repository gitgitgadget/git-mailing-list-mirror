Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDBC20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbdLHQ75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 11:59:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752989AbdLHQ74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 11:59:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEB57AA817;
        Fri,  8 Dec 2017 11:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=11pkUJG9c6QqQY3vlMpgKqSaHQ4=; b=ulqCRH
        4KoFnQLuRwOfEEzwBRH50yCkUD2K0A260nenD1p7+V2NNBGdQs1OZSxJpmc8o4mi
        WGc0r6wUUlj1l7bhnDdHWVfmZN3gALz4Udx+/2rj3O/FHJsI215ln7USvLOtvdUx
        rkRHdvQH7Wz1MEMjOoc1c7eX/BI6wyArfj5Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SeqqM9DZQvangEpJ8tULK/qoGO3doDBV
        mv3CZO1u4W5FrNHKVXjiVo5rLiq22MjPlpINwL8oYhBOqbHL/ES3EoXmkLD0bktd
        N+VZJMTSesnGJtJkAvx+zXfR7vZLw2gJrFOTz9sgJDMjnExB0CqDp4n8YPkfwsfO
        59QNsXudAH0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6E12AA816;
        Fri,  8 Dec 2017 11:59:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52CBDAA814;
        Fri,  8 Dec 2017 11:59:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
References: <20171208051636.GA24693@sigill.intra.peff.net>
Date:   Fri, 08 Dec 2017 08:59:54 -0800
In-Reply-To: <20171208051636.GA24693@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 8 Dec 2017 00:16:36 -0500")
Message-ID: <xmqqk1xx9mut.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 371600CC-DC39-11E7-818F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
> with ",", 2017-10-01) switched the syntax of the trailers
> placeholder, but forgot to update the documentation in
> pretty-formats.txt.
>
> There's need to mention the old syntax; it was never in a
> released version of Git.

There's or There's no?

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This should go on top of tb/delimit-pretty-trailers-args-with-comma.
>
>  Documentation/pretty-formats.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index d433d50f81..e664c088a5 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -204,11 +204,13 @@ endif::git-rev-list[]
>    than given and there are spaces on its left, use those spaces
>  - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
>    respectively, but padding both sides (i.e. the text is centered)
> -- %(trailers): display the trailers of the body as interpreted by
> -  linkgit:git-interpret-trailers[1]. If the `:only` option is given,
> -  omit non-trailer lines from the trailer block.  If the `:unfold`
> -  option is given, behave as if interpret-trailer's `--unfold` option
> -  was given. E.g., `%(trailers:only:unfold)` to do both.
> +- %(trailers[:options]): display the trailers of the body as interpreted
> +  by linkgit:git-interpret-trailers[1]. The `trailers` string may be
> +  followed by a colon and zero or more comma-separated options. If the
> +  `only` option is given, omit non-trailer lines from the trailer block.
> +  If the `unfold` option is given, behave as if interpret-trailer's
> +  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
> +  both.
>  
>  NOTE: Some placeholders may depend on other options given to the
>  revision traversal engine. For example, the `%g*` reflog options will
