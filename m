Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA2C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999356109E
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJLRg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:36:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55796 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLRgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:36:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8286D100423;
        Tue, 12 Oct 2021 13:34:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WM458qWi+KpKvJ2E1oC66c/Tez8AzyMpwDXKRC
        j5SM4=; b=yiPaiTxBVaDFOcCjTzT7yfBzCwTdkGdpSJBlNzrLjySkmc8jCUMyQg
        q2ypUrXKSbgFFbPF0HiVGpqrQU/mFKnsORE9CSnBM5lW8My9JYVlW6WaJz7lIk2P
        D3Ds/IIQzD8DTuWWjioK6PLwqGe/y08PrQG9KnQ43svywAznAjX5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A9C2100422;
        Tue, 12 Oct 2021 13:34:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0C11100421;
        Tue, 12 Oct 2021 13:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] ssh signing: fix merging signed tags & docs
References: <20211012092236.619822-1-fs@gigacodes.de>
Date:   Tue, 12 Oct 2021 10:34:51 -0700
In-Reply-To: <20211012092236.619822-1-fs@gigacodes.de> (Fabian Stelzer's
        message of "Tue, 12 Oct 2021 11:22:34 +0200")
Message-ID: <xmqqv922405g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5513212-2B82-11EC-8448-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Two small follow up patches on top of 1bfb57f642d. fmt-merge-msg needs
> to load gpg config to be able to verify merged tags. load it and add
> some tests. And i forgot to adjust the docs when we changed some
> behaviour of the original patch during review.

Sigh, why does this series have to come _after_ the problematic
commit that needs fixup! have finally hit 'next', after lingering in
'seen' for very long time, instead of much earlier?

In any case, the damage has been made.  We don't revert a topic out
of 'next' very lightly, so let's have the 'fixup!' one as a true
incremental.  We pretend as if we have already shipped what is in
'next' as part of a stable version to customers, and write a bugfix
patch that says "Commit X made Y to do Z, which is wrong for such
and such reasons.  Make Y do W instead."

Thanks.
