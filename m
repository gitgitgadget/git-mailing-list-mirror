Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D8BC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5232923A5A
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbhAOBrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 20:47:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57945 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbhAOBrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 20:47:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E86B176D;
        Thu, 14 Jan 2021 20:47:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cVC2hhB2msbO1J3ozF1Se+gDTl0=; b=x4KQMV
        mBGMs4HQhtxXstvdJQJANWrjn8ac7XKh1SsPo1kqmZvdGTvzLfWBoF9uatIontSY
        tlZzEB75D62SH3/ZJIHWbaWQyye2SXKuzIUmMiN7iOdz4kFQLfYnajBtYnV9uRoF
        Dlf52034v+mY/3R7iQ19hkIhMbLqoc4SjXbd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KedSWYroQXP/bL/ELp05UlwgcyavLafh
        HTBpAl8luIciZcl7o86uCElY4pCd1AgRUNGfg53FMEPnKoglvJJICpWVYmSW2ZmK
        c9/dYbB4P2AdKnB5lDYACNEjDaZcmJxO94Os9NKeyYYFFNk2hCePmtN59dhgLRY6
        uDDpbZkpY1A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA841B176C;
        Thu, 14 Jan 2021 20:47:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B31DB176B;
        Thu, 14 Jan 2021 20:47:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] gpg-interface: improve interface for parsing tags
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
        <20210111003740.1319996-3-sandals@crustytoothpaste.net>
        <xmqqbldu699q.fsf@gitster.c.googlers.com>
        <YADRP22NG15AHoAB@camp.crustytoothpaste.net>
Date:   Thu, 14 Jan 2021 17:47:07 -0800
In-Reply-To: <YADRP22NG15AHoAB@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 14 Jan 2021 23:18:23 +0000")
Message-ID: <xmqqzh1bug2s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93CB57E6-56D3-11EB-9C11-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'll reroll with the fixes for size_t and unsigned long.  Feel free to
> drop the series if it's causing CI to fail until I get around to that
> (likely this weekend).

No worries.  You would have found my tentative fix-up applied in
'seen' already if you updated from me when you got the message you
are responding to.

Thanks.
