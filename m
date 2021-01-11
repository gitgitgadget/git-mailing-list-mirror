Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24371C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE2522D08
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbhAKUW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 15:22:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63632 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAKUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 15:22:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10407122B81;
        Mon, 11 Jan 2021 15:22:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urFoLiv/om8owV/BH8CI189Y8mA=; b=sn1Yp5
        Swvyv/Ydo4aXH4ieRLSGibm/h29f49a3tFHD39dpegr7Oca2uaihenVhWwJOyzsy
        vZSMR82OJ+z7MJdtcbEc1W0LTwhs/VII8E39cycl+Chffs2w6lJgVt0PPe3xOAFq
        j9QbB8IFU76ifUjIkyOopNF6WYdlD15Y79Aiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZFUyT786YzdA2UxIQewIGaONeQp3s3PR
        Q9q8pjl+x/qQu9CDnSlgviq5E6Gko3kOzAEmMddtPDEFqKYjXw/kmIMGlRtvXilG
        wgpSgRuE1yJ+75RRTo1YyW6bgXhD/eZS5fz/PdWm6Ut05XocN2/95Fnyq6jWjw9y
        W2WOPYr9C30=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08B26122B80;
        Mon, 11 Jan 2021 15:22:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C52B122B7F;
        Mon, 11 Jan 2021 15:22:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Alan Mackenzie <acm@muc.de>
Subject: Re: [PATCH v2] docs: rephrase and clarify the git status --short
 format
References: <X/oAhdZlLwcFRCrR@ACM>
        <20210110190448.779754-1-sandals@crustytoothpaste.net>
Date:   Mon, 11 Jan 2021 12:22:10 -0800
In-Reply-To: <20210110190448.779754-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Jan 2021 19:04:48 +0000")
Message-ID: <xmqqr1mr6x71.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B012B59C-544A-11EB-8ACA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The table describing the porcelain format in git-status(1) is helpful,
> but it's not completely clear what the three sections mean, even to
> some contributors.  As a result, users are unable to find how to detect
> common cases like merge conflicts programmatically.
>
> Let's improve this situation by rephrasing to be more explicit about
> what each of the sections in the table means, to tell users in plain
> language which cases are occurring, and to describe what "unmerged"
> means.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> This uses text from Junio's email, so his sign-off will be required
> here.  I assume that won't be a problem, but I can send a v3 if it is.

Actually I find the text so vastly improved from "here is my
attempt" version in the discussion that, other than the paragraph
structure, there is nothing left that I can call my contribution.
I'll sign the resulting commit off anyway, though ;-)

> +There are three different types of states that are shown using this format, and
> +each one uses the `XY` syntax differently:
> ...
> +
> +Note that the term _merge_ here also includes rebases using the default
> +`--merge` strategy, cherry-picks, and anything else using the merge machinery.

Even if rebase uses the good-old "format-patch | am -3" pipeline, it
would result in an index with entries at higher stages.  So I am not
sure if this "Note that" helps the reader.

> +In the following table, these three classes are shown in separate sections, and

This iteration has improved the "Three different classes of paths
are shown" in the "here is my attempt" version to "Three different
types of states ..."; shouldn't we be doing the same here with
s/classes/types of states/?

> +these characters are used for `X` and `Y` fields for the first two sections that
> +show tracked paths:

Thanks.
