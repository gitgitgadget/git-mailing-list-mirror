Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137DC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5759A61038
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhJ2UEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:04:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61482 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2UED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:04:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 948AA15DEAD;
        Fri, 29 Oct 2021 16:01:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j8omHlS0SqdIubf7M+foBvw1Wl3x6Nn5iS0F3p
        gtHD8=; b=XZ/MHpe1ejtTEfsfpHIeJ8daR2TuG0P8+JxTe1KySLQAB2QnXCspsf
        bOYauoxy70hylPcghKViG2DtEeqaPsPJiSP7w7Mpx8iKaOMB7yT42H7S9R6XTTqr
        zF9s2F+F02f9Sft3yavHnBgvHdJOS2DfSUlrrHMK+jhsiLMAMHfww=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B1C615DEAC;
        Fri, 29 Oct 2021 16:01:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A0DB15DEAB;
        Fri, 29 Oct 2021 16:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 2/4] sparse-index: avoid unnecessary cache tree clearing
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
        <91351ac4bded2c19264cd2009e90ee71fcf67b81.1635515487.git.gitgitgadget@gmail.com>
        <xmqqfssjllen.fsf@gitster.g>
        <006b1747-fc6b-61e4-7ce9-f0a6687ddd8f@gmail.com>
Date:   Fri, 29 Oct 2021 13:01:28 -0700
In-Reply-To: <006b1747-fc6b-61e4-7ce9-f0a6687ddd8f@gmail.com> (Derrick
        Stolee's message of "Fri, 29 Oct 2021 15:00:01 -0400")
Message-ID: <xmqq7ddvlhwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01E89598-38F3-11EC-B05D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I think in this pruned form, the cache-tree is valid and serves all of
> the roles it was designed for. We can quickly compute the root tree in
> 'git commit'. We can navigate the cache-tree in traverse_by_cache_tree()
> to accurately describe the trees in the index. These things are tested
> in t1092 and the p2000 performance test.

OK, then I was worried too much.  Thanks for clarifying.
