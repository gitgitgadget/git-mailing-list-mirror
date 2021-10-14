Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD371C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 22:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF34F60EB4
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhJNW1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 18:27:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58482 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhJNW1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 18:27:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F247158632;
        Thu, 14 Oct 2021 18:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yFKh2r1/L2NvC2kPOMtXOPrs07nbE6CPbs/0aZ
        ZFKnM=; b=oAHzUCGpyfUu0ihJNo9ZBa9RxF6KzmPB7DCr59+hHLXS+U4L14g1Z1
        px8u61DxBivfg7zfwMR9ap3LwXtyCk01MoDB7depP30ZcYu7PhgAy9HnWHvwOlQ+
        d/Oy9CzLTDeuh0/AZEIqc8vqmPgvE//uJea5peBMAq/XonHSC3RSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 767E1158631;
        Thu, 14 Oct 2021 18:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C050115862F;
        Thu, 14 Oct 2021 18:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
References: <20211005001931.13932-1-chooglen@google.com>
        <20211012174208.95161-1-chooglen@google.com>
        <87wnmihswp.fsf@evledraar.gmail.com>
        <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
        <87pms8hq4s.fsf@evledraar.gmail.com>
        <d553054f-a484-ba34-ef3b-1e6778211a47@gmail.com>
Date:   Thu, 14 Oct 2021 15:25:04 -0700
In-Reply-To: <d553054f-a484-ba34-ef3b-1e6778211a47@gmail.com> (Derrick
        Stolee's message of "Thu, 14 Oct 2021 12:53:58 -0400")
Message-ID: <xmqq35p3b5xb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95053780-2D3D-11EC-BDFF-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I generally consider any interaction with the commit-graph while
> replace refs are enabled to be the bug. We don't read the commit-graph
> when replace refs are on, so why are we verifying it?
>
> But, I understand the desire to check the on-disk content even though
> it is not being used, so disabling replace refs to do the verify should
> be sufficient.

That's quite a sensible argument.  Sounds like we have a way to
solve this that everybody agrees with.

Thanks.
