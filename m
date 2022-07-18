Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15292CCA479
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiGRQhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRQhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:37:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537D2AC6F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:37:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAE201BDF08;
        Mon, 18 Jul 2022 12:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I/8GrEezgYIwM9CclUo3dYK99LGt5lkF8VMgVU
        FPKpE=; b=ik7U0C0V8FSlAYc1cY3ksgZD5irA/aE0CrCBN/Kq1t/q4oLgYNqox3
        nhfy6pK95ZHGVvXdlpbzv0imj0mnpOZ22ft8qaip3z5vxQvJKiNWhsxpUp+OHuhC
        ChNIoHjgFg1zMmitB0tx5CH/HqFDJ2Cjl2vLSyVWauGBFdwoByEiE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C441E1BDF07;
        Mon, 18 Jul 2022 12:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C6871BDF04;
        Mon, 18 Jul 2022 12:37:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        Kilian Kilger <kkilger@gmail.com>
Subject: Re: [PATCH v2] git-p4: fix bug with encoding of p4 client name
References: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
        <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
Date:   Mon, 18 Jul 2022 09:36:59 -0700
In-Reply-To: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
        (Kilian Kilger via GitGitGadget's message of "Mon, 18 Jul 2022
        08:57:59 +0000")
Message-ID: <xmqqcze2s7h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8CF1A86-06B7-11ED-BB60-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kilian Kilger <kkilger@gmail.com>
>
> The Perforce client name can contain arbitrary characters
> which do not decode to UTF-8. Use the fallback strategy
> implemented in metadata_stream_to_writable_bytes() also
> for the client name.
>
> Signed-off-by: Kilian Kilger <kkilger@gmail.com>
> ---
>     git-p4: Fix bug with encoding of P4 client name

Sorry, is this to improve the topic that has already last Monday?

If so, it is way too late to update with a replacement patch, like
this.  Instead, please send in a follow-up patch on top of what has
already been merged.

The description above seems to be identical to what was in the
previous round, but the patch seems to use a lot more code, so
such a follow-up patch would have plenty to explain how the new
strategy improves over the previous one.

Thanks.

