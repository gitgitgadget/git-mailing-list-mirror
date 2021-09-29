Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B23EC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2978F6135D
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhI2E03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:26:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52401 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhI2E01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 00:26:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39CA3162CBA;
        Wed, 29 Sep 2021 00:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u1vcoOSaVpEQmCnAKtq094rKCRusDWSCQ2Gdwu
        nhKdY=; b=ELB/WPa58rjCSnj8Ugqt+RWH49mDsDFu8HyvFoQFZDMzvGbjm88M57
        0E3V3HEYqDp1bUD72p8P2449EO7zVR46CxVGzKfqhHKHembagSUNYdRX2VSMNulM
        luJT9/Uhw9c7Fray/QB2rvR5zX0koth+7wzqqVqFZX6oJ/4h0bYHI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3257A162CB9;
        Wed, 29 Sep 2021 00:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9672E162CB8;
        Wed, 29 Sep 2021 00:24:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: Re: [PATCH v3 0/9] repack: introduce `--write-midx`
References: <cover.1631730270.git.me@ttaylorr.com>
        <cover.1632880469.git.me@ttaylorr.com>
Date:   Tue, 28 Sep 2021 21:24:43 -0700
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 28 Sep 2021 21:54:37 -0400")
Message-ID: <xmqqk0j0f1pw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C646B54-20DD-11EC-AEE6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is another small reroll of my series to implement the final component of
> multi-pack reachability bitamps, which is to be able to write them from `git
> repack`.
>
> This version incorporates feedback from Jonathan Tan and others at Google who
> graciously provided review. A range-diff is included below, but the major
> changes are:
>
>   - A comment to explain the relationship between 'ctx->m' and 'ctx->to_include'
>     in midx.c:add_pack_to_midx().
>
>   - A comment to explain the meaning of write_midx_file_only().
>
>   - Clean-up of stray hunks, a missing strbuf_release().
>
>   - Replacing the name `existing_packs` with `existing_nonkept_packs` to
>     emphasize the relationship between it and the similarly-named
>     `existing_kept_packs`.
>
> Instead of depending on tb/multi-pack-bitmaps, this series now depends on the
> tip of master.

... as the topic already graduated to 'master' ;-)

But applying them on the same base as the previous round and merging
the result to 'master', and applying them on 'master', will give us
identical trees.

Will replace; thanks.
