Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A211F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeAITg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:36:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54479 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeAITgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:36:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AB2CBEE28;
        Tue,  9 Jan 2018 14:36:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PNI3cXJmanacjaTrvYvD/vLDAW0=; b=ByHO49
        QUHGOJAYyRrdpSBBs+Nd+PCP+ZzJlUceiJXUIQdlWG/Syt1wPYkWtktx+78d/tsH
        G2XK15qFtKgVeahJUZi0mJ7m1h0svW2i0hhB2DP5PcFIf9S+1HSW/thQ7JxDww/L
        sCI/3TMlHR1LFpwiCbc8JX35hwiKrnTw49MUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b0SAYcvFtZ2UhcWD7gnthimaHRZZqPjF
        sexqZlnVQch4v1w5tzhQNk6/I3W8sPrU77PmaPIX83tetzlUBcQkpipePwH714Wj
        x7qcelnjT5PKi3HHzxMZH6USmRunLKHtuz3Zpcdzlw7AU2O3iDjC6+hfTqDKb2Ae
        Sc1CGn/Pu3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02B04BEE27;
        Tue,  9 Jan 2018 14:36:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74B6BBEE26;
        Tue,  9 Jan 2018 14:36:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andreas G. Schacker" <andreas.schacker@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/read-tree: remove obsolete remark
References: <20180109153034.22970-1-andreas.schacker@gmail.com>
Date:   Tue, 09 Jan 2018 11:36:53 -0800
In-Reply-To: <20180109153034.22970-1-andreas.schacker@gmail.com> (Andreas
        G. Schacker's message of "Tue, 9 Jan 2018 16:30:34 +0100")
Message-ID: <xmqq373e6cyy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 728CC434-F574-11E7-B5BB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andreas G. Schacker" <andreas.schacker@gmail.com> writes:

> Earlier versions of `git read-tree` required the `--prefix` option value
> to end with a slash. This restriction was eventually lifted without a
> corresponding amendment to the documentation.
>
> Signed-off-by: Andreas G. Schacker <andreas.schacker@gmail.com>
> ---

Thanks.  "read-tree --prefix=foo- $tree" is allowed these days,
indeed.  Will queue.

What is curious is that 34110cd4 ("Make 'unpack_trees()' have a
separate source and destination index", 2008-03-06) seems to be the
one that removed the check, and the removed contents do not seem to
have much in common with the stated goal of the commit.



>  Documentation/git-read-tree.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 72bd809fb..f2a07d54d 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -81,12 +81,11 @@ OPTIONS
>  * when both sides add a path identically.  The resolution
>    is to add that path.
>  
> ---prefix=<prefix>/::
> +--prefix=<prefix>::
>  	Keep the current index contents, and read the contents
>  	of the named tree-ish under the directory at `<prefix>`.
>  	The command will refuse to overwrite entries that already
> -	existed in the original index file. Note that the `<prefix>/`
> -	value must end with a slash.
> +	existed in the original index file.
>  
>  --exclude-per-directory=<gitignore>::
>  	When running the command with `-u` and `-m` options, the
