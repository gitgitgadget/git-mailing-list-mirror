Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C94C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiCDUEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiCDUEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 15:04:34 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A32077B9
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 11:59:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8585E194919;
        Fri,  4 Mar 2022 14:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M7h3VvR2b+dny4GP3M31MHNuy7mtuBBlBbGreJ
        kGyms=; b=uj/kyuMYBeLo4aaPBw99AiM0B+/gr7oTjyhzzRmmZLWarGXPKqFSrh
        MUJbXKcGO5AlERSz+dHz17/MAiNsYuu3evbdSAtadopHC+qyjp7PMWDv5XOj4x6L
        BX1dPkqgpajoVI8AdybBeiQT2pnaLZ+CJMtYis8QJRLhLZwHOrrSY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DDD0194917;
        Fri,  4 Mar 2022 14:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05C69194912;
        Fri,  4 Mar 2022 14:59:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] test-lib.sh: Use GLIBC_TUNABLES instead of
 MALLOC_CHECK_ on glibc >= 2.34
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
Date:   Fri, 04 Mar 2022 11:59:02 -0800
In-Reply-To: <20220304133702.26706-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Fri, 4 Mar 2022 13:37:02 +0000")
Message-ID: <xmqqfsnx1oc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A3F7730-9BF5-11EC-BEE8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> In glibc >= 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
> variables have been replaced by GLIBC_TUNABLES.  Also the new
> glibc requires that you preload a library called libc_malloc_debug.so
> to get these features.
>
> Using the ordinary glibc system variable detect if this is glibc >= 2.34 and
> use GLIBC_TUNABLES and the new library.
>
> This patch was inspired by a Richard W.M. Jones ndbkit patch
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the third version of the patch.
>
> Compared to the second version[1], the code is further simplified,
> eliminating a case statement and modifying a string statement.

Thanks; will queue.  Let's declare victory and merge it down to
'next' and 'master/main'.
