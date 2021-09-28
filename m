Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F071761368
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbhI1Vow (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:44:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58267 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbhI1Vow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 17:44:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5486E14B45C;
        Tue, 28 Sep 2021 17:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MpTI0zwWs1O1
        gezy1dCOosvDM6jxhy5K0ypaFy0TRwQ=; b=BwgWqyZRlV8WOBpcBWHuXpFWOvD1
        CxjoaojFZlHVlivhKmFG8rU/YR1iwl6uTq9ENF7pgNHJacsdu4mSlPch4lEMTxrE
        ktLvELa70OzwQrmAFUHia9uRb+lyf1Sf1Sz0GSlTOUwll4iosdvrxaDsMKSLClAF
        60b1//uGS+zACEE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DCBE14B45A;
        Tue, 28 Sep 2021 17:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4FA314B459;
        Tue, 28 Sep 2021 17:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] string-list.[ch]: remove string_list_init()
 compatibility function
References: <patch-1.1-03c805dd90f-20210928T124939Z-avarab@gmail.com>
Date:   Tue, 28 Sep 2021 14:43:08 -0700
In-Reply-To: <patch-1.1-03c805dd90f-20210928T124939Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 14:49:45 +0200")
Message-ID: <xmqqzgrwidg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 12B0D91E-20A5-11EC-83D8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove this function left over to accommodate in-flight changes, see
> 770fedaf9fb (string-list.[ch]: add a string_list_init_{nodup,dup}(),
> 2021-07-01) for the recent change to add
> "string_list_init_{nodup,dup}()" initializers.
>
> There was only one user of the API left in remote-curl.c. I don't know
> why I didn't include this change to remote-curl.c in
> bc40dfb10a0 (string-list.h users: change to use *_{nodup,dup}(),
> 2021-07-01), perhaps I just missed it.
>
> In any case, let's change that one user to use the new API, as of
> writing this there are no in-flight changes that use, so this seems
> like a good time to drop this before we get any new users of this
> compatibility API.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

Thanks.
