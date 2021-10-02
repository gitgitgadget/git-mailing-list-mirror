Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E15C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 00:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490B261A7A
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 00:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhJBAks (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 20:40:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55704 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhJBAkr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 20:40:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83B8D154AA2;
        Fri,  1 Oct 2021 20:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H9gA9CxoxqzPa4zuUjB9j+2t03wZCmrhRoUZYK
        n7BtI=; b=V/bz1ipd1AzPZPIFEopbKJx3gRFlBloApFNEF/c2b69/QVVmlfHF+f
        Z3c2OlvQAiq4BskTukYGXRD4G8RcAImVtNdH8kfKg6UFhi3d8WIqW2vfrP4yBVSp
        wFMN3i8bizQG83OIR+6LNLQQNXUlPyTZ//QHlo2KHzekbt0OYcDiw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BCE1154AA1;
        Fri,  1 Oct 2021 20:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0284154A9D;
        Fri,  1 Oct 2021 20:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 00/11] rebase: reset_head() related fixes and improvements
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 17:38:57 -0700
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com> (Phillip Wood
        via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:51 +0000")
Message-ID: <xmqqbl482rby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21BACE94-2319-11EC-ACF2-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix some issues with the implementation and use of reset_head(). The last
> patch was previously posted as [1], I have updated the commit message and
> rebased it onto the fixes in this series. There are a couple of small
> conflicts merging this into seen, I think they should be easy to resolve (in
> rebase.c take both sides in reset.c take the changed lines from each side).
> These patches are based on pw/rebase-of-a-tag-fix

When merged with other topics in flight in 'seen', this seems to
fail the t1092 test (most likely, ds/add-rm-with-sparse-index is
what this interacts badly with).

Thanks.
