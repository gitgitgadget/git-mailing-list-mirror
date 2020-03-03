Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFD5C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CF620848
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dEzy2XG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCCWFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:05:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCCWFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:05:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D0E455A8C;
        Tue,  3 Mar 2020 17:05:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ndwNhIcW+68CJCPK9N5uLw+ORe8=; b=dEzy2X
        G3EBh6a/JDd9KRQbs1Q5lr3IlYAP9ziYjQcC/Bnk6SqBRbwONbpks5mhIpQOm6Ji
        zxAh7npLwPGsXuE8z2YAVFDcVK3wInXpC1rDNUtRHdDUynhHj+Y4/QQ0473f5KuV
        PkXhplk7FXaqGuhJ90CVKKzCsUJhuN2Rcu0yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NZ+y+3dg0ysmZ5e7jdMGhVfYchSA7h86
        tbS/eDuAO1vRE2EOeqz4ft3CUMbsV11EDIjFufa1Flcb2RTmJbhOY/3G7x9RT+1n
        1UuolTbRVExDjc6RgZXdWp5jXfGiaqKLXR1Y9+/X7s74bABFubW2S1/TpxDxeOwn
        IuU8Fg9r9/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2552555A8B;
        Tue,  3 Mar 2020 17:05:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8121755A8A;
        Tue,  3 Mar 2020 17:05:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 4/5] doc: be more precise on (fetch|push).recurseSubmodules
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
        <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
        <20200303170740.1879432-5-damien.olivier.robert+git@gmail.com>
Date:   Tue, 03 Mar 2020 14:05:37 -0800
In-Reply-To: <20200303170740.1879432-5-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Tue, 3 Mar 2020 18:07:39 +0100")
Message-ID: <xmqqo8td6qmm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D8F364C-5D9B-11EA-A21B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index f11940280f..8f716809f9 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -2,10 +2,12 @@ fetch.recurseSubmodules::
>  	This option can be either set to a boolean value or to 'on-demand'.
>  	Setting it to a boolean changes the behavior of fetch and pull to
>  	unconditionally recurse into submodules when set to true or to not
> -	recurse at all when set to false. When set to 'on-demand' (the default
> -	value), fetch and pull will only recurse into a populated submodule
> +	recurse at all when set to false. When set to 'on-demand', 
> +	fetch and pull will only recurse into a populated submodule
>  	when its superproject retrieves a commit that updates the submodule's
>  	reference.
> +	If not set, it fallbacks to the value of `submodule.recurse`, and
> +	if both are not set the default value is 'on-demand'.

I do not think "fallback" is a single-word verb.  If you must use
the phrase, "it falls back to the value of ...", but I personally
prefer to give the simplest case first and then its variants second
(i.e. if you do not do anything, this is what you get, and then if
you do this thing, this other thing happens).

In other words:

	If not set, 'on-demand' is used by default, unless
	'submodule.recurse' is set, in which case it is used.

But in this case it is so obvious that it would not be necessary to
add ", in which case it is used" at the end.

> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index 54871f8213..2a5250cf5c 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -112,3 +112,6 @@ push.recurseSubmodules::
>  	is 'no' then default behavior of ignoring submodules when pushing
>  	is retained. You may override this configuration at time of push by
>  	specifying '--recurse-submodules=check|on-demand|no'.
> +	If not set, it fallbacks to the value of `submodule.recurse` (where
> +	a 'true' value means 'on-demand'), and if both are not set the
> +	default value is 'no'.

Likewise.

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index a115a1ae0e..58972b1a05 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -163,7 +163,8 @@ ifndef::git-pull[]
>  	value. Use 'on-demand' to only recurse into a populated submodule
>  	when the superproject retrieves a commit that updates the submodule's
>  	reference to a commit that isn't already in the local submodule
> -	clone.
> +	clone. By default this uses the fetch.recurseSubmodules value (see
> +	linkgit:git-config), and the default value is 'on-demand'.

	By default, 'on-demand' is used, unless
	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
