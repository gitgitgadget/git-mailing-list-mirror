Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362FCC4332F
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EC76127B
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353192AbhITSnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:43:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65390 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353430AbhITSlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 14:41:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 459C314831D;
        Mon, 20 Sep 2021 14:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EhWIg+M3o+yQOIoylvvC1Cuoc0BochyBu7G/FS
        mSX3o=; b=Vw7eMgYcb6hWd3wRyP0qu9eAXnmL80lnncIZYl/MWzgkq3GvEvMYUE
        wL1JsdMO97wTxIrybDVDypt964C2fVUKGIAE06tuQGmfcAsIrpMrtseE9VFa9Nzb
        ubkzMnN5JhXUtUgxNp60FioZb94oVz5eiiJESPGTAUtET2jBmTq5w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D63F14831C;
        Mon, 20 Sep 2021 14:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E05014831B;
        Mon, 20 Sep 2021 14:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] difftool dir-diff symlink bug fix and cleanup
 patches
References: <20210919203832.91207-1-davvid@gmail.com>
Date:   Mon, 20 Sep 2021 11:39:39 -0700
In-Reply-To: <20210919203832.91207-1-davvid@gmail.com> (David Aguilar's
        message of "Sun, 19 Sep 2021 13:38:29 -0700")
Message-ID: <xmqqmto7ay6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D7EA844-1A42-11EC-BFBF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> This patch series fixes a regression in difftool that can lead to data loss.
> The symlink-file writing in difftool's dir-diff mode has been fixed to no
> longer write-through to the symlink targets.

v4 with no backreference?  Do you have a message-id for the previous
three rounds handy?

> Please consider patching older Git versions with the fix from 1/3.

meaing 1/3 would be done on top of maint (v2.33.0), and the other
two can be on a separate branch that starts on a commit that is a
merge of the 1/3's branch into 'master'?

Thanks.
