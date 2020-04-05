Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50003C2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED05D20659
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZSDRCQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgDEV52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:57:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54783 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEV52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 17:57:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98F8F449BF;
        Sun,  5 Apr 2020 17:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VSKnmcl7ElJWGgPbYnxNLIQsKlM=; b=oZSDRC
        QB1C3hCp7C/etbIOkGC93ie/YdG9ur2VuaiwAGMrX2kQa6GCdBhjMQzLM1/Wo3/M
        ZqLFfaa/leTDl7TEPYC4gsddil/hCfcaYjXREG9/q2UQgDJ/+Jbs66dqCE+iywSR
        x+lbUAY2szFxGMKeY4KNr04lBtjfvuQyb93xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k0jNLX5dkUQdzms4+yZG6JiK3AeJ18Vy
        XNpC7r1IB0P2Xob4+nOu+UO2OfG52vHiguItz+8pZsH0xCP5awAo+tsvS5bOhuZ2
        fd63h4DNk2/6H/dJuAYoRf6P3PZ3raelQd2v5NCukkF9dN2Y83MdM9iI/ZQNPmsK
        Z7GHVJV1xgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 909FC449BE;
        Sun,  5 Apr 2020 17:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D0B9449BD;
        Sun,  5 Apr 2020 17:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v5 4/5] doc: be more precise on (fetch|push).recurseSubmodules
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
        <20200405201633.704987-5-damien.olivier.robert+git@gmail.com>
Date:   Sun, 05 Apr 2020 14:57:22 -0700
In-Reply-To: <20200405201633.704987-5-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Sun, 5 Apr 2020 22:16:32 +0200")
Message-ID: <xmqqk12twq7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DE6FE3E-7788-11EA-8EC0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> The default value also depends on the value of submodule.recurse.
> Use this opportunity to correct some grammar mistakes in
> Documentation/config/fetch.txt signaled by Robert P. J. Day.
>
> Also mention `fetch.recurseSubmodules` in fetch-options.txt. In
> git-push.txt, `push.recurseSubmodules` is implicitly mentioned (by
> explaining how to disable it), so no need to add it there.
>
> Lastly add a link to `git-fetch` in `git-pull.txt` to explain the
> meaning of `--recurse-submodules` there.
>
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
>  Documentation/config/fetch.txt  | 13 ++++++++-----
>  Documentation/config/push.txt   |  2 ++
>  Documentation/fetch-options.txt |  3 ++-
>  Documentation/git-pull.txt      |  3 +--
>  4 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index f11940280f..4114af4b3b 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -1,11 +1,14 @@
>  fetch.recurseSubmodules::
> -	This option can be either set to a boolean value or to 'on-demand'.
> +	This option controls whether `git fetch` (and the underlying fetch
> +	in `git pull`) will recursively fetch into populated submodules.
> +	This option can be set either to a boolean value or to 'on-demand'.
>  	Setting it to a boolean changes the behavior of fetch and pull to
> -	unconditionally recurse into submodules when set to true or to not
> -	recurse at all when set to false. When set to 'on-demand' (the default
> -	value), fetch and pull will only recurse into a populated submodule
> -	when its superproject retrieves a commit that updates the submodule's
> +	recurse unconditionally into submodules when set to true or to not
> +	recurse at all when set to false. When set to on-demand, fetch and

Why did you lose quotes around on-demand on this line?  Shouldn't it
be typeset the same way as the other one in the sentence "Defaults
to ..."?

> +	pull will only recurse into a populated submodule when its
> +	superproject retrieves a commit that updates the submodule's
>  	reference.
> +	Defaults to 'on-demand', or to the value of 'submodule.recurse' if set.
