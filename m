Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8875AC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C45161242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbhIXPwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:52:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63654 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhIXPwx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:52:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B1CA165F93;
        Fri, 24 Sep 2021 11:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ft3gV3Dr6DXoIfBgHBhhMaUNLm+r+/lALXbpT8
        tCF58=; b=aVl3vf/T7RoU+NaNymqAA447qH5XMozMwcUZsBkZrDH+WVRcaGKVXI
        YcMVz0rUIKPnI6wFb73ZP3ID5l5kLY19ddrFJQCggYPIWbeKbPFlTwBZie3EC+fd
        /WZzt0fp3nhl1kVVS0BaOOtxeP4UqO6MHV/66Z+rJMFhUsg8RiA1s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92DD3165F92;
        Fri, 24 Sep 2021 11:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE718165F8F;
        Fri, 24 Sep 2021 11:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
        <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
        <92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com>
Date:   Fri, 24 Sep 2021 08:51:15 -0700
In-Reply-To: <92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com> (Phillip Wood's
        message of "Fri, 24 Sep 2021 11:19:02 +0100")
Message-ID: <xmqqr1devuoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40E3CA02-1D4F-11EC-A8DF-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
>
> POSIX does not support using a semicolon after a closing brace [1],
> ...
> [1] "Editing commands other that {...}, a, b, c, i, r, t, w, : and #
> can be followed by a <semicolon>" from 
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

Would sed implementation of BSD ancestry fail reliably to be a good
coalmine canary?
