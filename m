Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258B4C83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 15:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbjHaP40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbjHaP40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 11:56:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE31B0
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 08:56:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7964A1D712;
        Thu, 31 Aug 2023 11:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=mzV5hCVa3LdFX+crIAhCyBeSdPG7qofTw4c5BQ
        YmjY4=; b=UjRazumN6g42Y8Gws8eQ6HqQxZm6Hja6ii9dKlC8bhLXuQPvOb01LM
        b04EWWAY32Rp1UkQp7Sf6DYumgS9kOSIpg1r6nuEYqA32QR6coBMN4oEzqprqc/u
        Tj0ED1ZJbENyBX296PiXasAafuEaeoBo+ZPjkzRmcHTk1F2uT0b4s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70A2D1D711;
        Thu, 31 Aug 2023 11:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02D9C1D709;
        Thu, 31 Aug 2023 11:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/8] merge: simplify parsing of "-n" option
In-Reply-To: <20230831071401.GB3197647@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:14:01 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071401.GB3197647@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 08:56:11 -0700
Message-ID: <xmqq8r9ryzms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8FA8692-4816-11EE-A9D7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. If they did, the BUG() check added by 3284b93862 (parse-options:
>      disallow negating OPTION_SET_INT 0, 2023-08-08) will catch it (and
>      that check is smart enough to realize that our short-only option is
>      OK).

;-).

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/merge.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

More code deletion.  Nice.
