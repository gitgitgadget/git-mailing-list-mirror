Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0ECC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE7D64E9A
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhBHVmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:42:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59975 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbhBHVmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 16:42:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F26FE1236EE;
        Mon,  8 Feb 2021 16:41:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bVPgpL7JXMzsSRI5OMy4WJ5OaGM=; b=tY+5yB
        I5/nf+HU3LNm3Xf2+YckNcN3KwY7s74qWBQwRtYbdYkL6dlzwxKSdVc9Pofw05dZ
        /TosBrL8HbQNL1dkbpRF/UcBKGBI5eZm7j6edsRQjNAMtrdG9RbmyzmFkh/YSEFA
        OSn+C0/tkaxVmN8MeOdYRZo4fnL4TyVY/A3d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mO3KtKNKPhocCvHvgQsqnahTTjFyqvNA
        VNU1JxWhaFmi7aYukm5jIcG9amvFK2lSik/Bzv7zFtys5I31Lfp9fuhyf2uCA1V/
        TdSro8g8pRzl9tzHIAfm4Yiiux2dsYPA1ma3vbcoSd/Y35GdXnpsxs5Fipy/IGKX
        Xp8ij9HEC50=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA6521236ED;
        Mon,  8 Feb 2021 16:41:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 327E01236EC;
        Mon,  8 Feb 2021 16:41:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 09/11] t/t3437: cleanup the 'setup' test and use
 named commits in the tests
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210208192528.21399-10-charvi077@gmail.com>
Date:   Mon, 08 Feb 2021 13:41:25 -0800
In-Reply-To: <20210208192528.21399-10-charvi077@gmail.com> (Charvi
        Mendiratta's message of "Tue, 9 Feb 2021 00:55:29 +0530")
Message-ID: <xmqqwnvi44qi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65C73E28-6A56-11EB-BAC8-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Remove unnecessary curly braces and use the named commits in the
> tests so that they will still refer to the same commit if the setup
> gets changed in the future whereas 'branch~2' will change which commit
> it points to.

Doing two things in the same commit?  I think ${EMPTY} thing is a
general style clean-up, while tagging is a bit more meaningful
change to make it easier to understand tests and is a change at a
more conceptual level.  The ${EMPTY} change would be better done at
the same time when the here document was cleaned up in [v2 05/11],
I would think.

Thanks.
