Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD63C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAEF206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQgUg8Bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDUTy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:54:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUTy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 15:54:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CDE8B808D;
        Tue, 21 Apr 2020 15:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yd03z0lpfoVa3UiGpWIP9XHzWoo=; b=uQgUg8
        BxayU8gqv+YCQQlMlzlUB3hH2ScNkywlEOEZCx5Z/t3/MbKRfZM3Z4fe54VQEUr3
        3uuZ60uRrMfmSQ7qLLtKBb2zHtNVZ/zPiRiT3ZYNFon3AJ43o5X93V6ya4BFiYtj
        /QgfpTpDgAUeSk7deLGBD7wYva3g6Mld90wYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vf+93IkFIdZeup6jnAZvN7QPmei5cs1G
        eMbxjzMWjzh+EtwwPgTnV3yUZJjIPrW+AAA3gu8uWF4rdmTbFn1x0wE7WSuRYMk9
        CZy7b62JbOoyKBrqvYnu09V8ri2bCxIDleXIj8pcy1xYLhdjLJZWSsYyd1dSNjT6
        fZM+YZufSIw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93DD7B808C;
        Tue, 21 Apr 2020 15:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0ACAB808A;
        Tue, 21 Apr 2020 15:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3 2/4] gitfaq: changing the remote of a repository
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
        <20200421131223.29337-3-shouryashukla.oo@gmail.com>
Date:   Tue, 21 Apr 2020 12:54:49 -0700
In-Reply-To: <20200421131223.29337-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Tue, 21 Apr 2020 18:42:21 +0530")
Message-ID: <xmqq368wobqu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6425F2A-8409-11EA-88BD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> changing the remote of a repository, covering various cases in which
> one might want to change the remote and the ways to do the same.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Again, I think this belongs to Documentation/git-remote.txt; unlike
the ".gitignore" one, however, the existing description is heavily
concentrated on "what happens when X is set to Y?" and does not
answer "why would I want to set X to Y in the first place?" very
much.  And the text below you have is a good thing to teach anybody
who learns "git-remote".  

So how about clarifying the existing page, perhaps its DISCUSSION
section (which currently talks only about "how to add a remote, and
configure" without discussing "why would I want to add a remote, set
a URL and/or a pushURL to it") with what you have, and trim the
description here in the FAQ file to the minimum and refer to the
page instead?

> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 96767e7c75..13d37f96af 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -244,6 +244,37 @@ I asked Git to ignore various files, yet they are still tracked::
>  	category, it is advised to use `git rm --cached <file>` as well as
>  	add these files/paths in the `.gitignore`.
>  
> +[[changing-remote-of-the-repository]]
> +I want to change the remote of my repository. How do I do that?::
> +	A remote is an identifier for a location to which Git pushes your
> +	changes as well as fetches any new changes from (if any). There
> +	might be different circumstances in which one might need to change
> +	the remote:
> +
> +		1. One might want to update the URL of their remote; in that
> +		   case, the command to use is, `git remote set-url <name> <newurl>`.
> +
> +		2. One might want to have two different remotes for fetching
> +		   and pushing; this generally happens in case of triangular
> +		   workflows: one fetches from one repository and pushes to
> +		   another. In this case, it is advisable to have separate
> +		   remotes for fetching and pushing. But, another way can be
> +		   to change the push URL using the `--push` option in the
> +		   `git set-url` command.
> +
> +		3. One might want to push changes to a network protocol
> +		   different from the one they fetch from. For instance,
> +		   one may be using an unauthenticated http:// URL for
> +		   fetching from a repository and use an ssh:// URL when
> +		   you push via the same remote. In such a case, one can
> +		   change the 'push' URL of the same remote using the `--push`
> +		   option in `git remote set-url`. Now, the same remote will
> +		   have two different kinds of URLs (http and ssh) for fetching
> +		   and pulling.
> ++
> +One can list the remotes of a repository using `git remote -v` command.
> +The default name of a remote is 'origin'.
> +
>  Hooks
>  -----
