Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772D6C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A16460F93
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhJ2HHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:07:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57795 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhJ2HHT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 03:07:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17DE4158FA1;
        Fri, 29 Oct 2021 03:04:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6wcnRyIbYkk9FoDGDNVlPnSWCO46EH06dJbZoF
        9Dxd0=; b=URlxZQx5yXwaUhJT99d97RRpBRZDpBlJdDePdmMznF4VqDZPJQr3Wl
        rX5deXfGCOdtowFRqaaMWgcY7c4ObBdYyB56Abwj3ege/NmnhKFeOgiOe0vcOahR
        BM2CvreYu/U0mRhmzroRXT39szd21hOKo95kBILancZG8d7fkwk50=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10B72158FA0;
        Fri, 29 Oct 2021 03:04:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C116C158F9F;
        Fri, 29 Oct 2021 03:04:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t5310: drop lib-bundle.sh include
References: <YXr3+yqtXYGgaxnX@coredump.intra.peff.net>
Date:   Fri, 29 Oct 2021 00:04:46 -0700
In-Reply-To: <YXr3+yqtXYGgaxnX@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Oct 2021 15:20:27 -0400")
Message-ID: <xmqq35okmhv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80B93110-3886-11EC-9E4A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit ddfe900612 (test-lib-functions: move function to lib-bitmap.sh,
> 2021-02-09) meant to include lib-bitmap.sh in t5310, but also includes
> lib-bundle.sh. Yet we don't use any of its functions, nor have anything
> to do with bundles. This is probably just a typo/copy-paste error, as
> lib-bundle.sh was added (correctly) to other scripts in the same series.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not really hurting anything, just confusing.

Makes sense to me.

Will queue; thanks.


>
>  t/t5310-pack-bitmaps.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 673baa5c3c..dcf03d324a 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> -. "$TEST_DIRECTORY"/lib-bundle.sh
>  . "$TEST_DIRECTORY"/lib-bitmap.sh
>  
>  # t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in
