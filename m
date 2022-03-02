Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66BC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiCBUjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiCBUjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:39:54 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148F31510
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:39:09 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81EBB180FB6;
        Wed,  2 Mar 2022 15:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZM4GMGg6CZCw
        8iIGJwcu46YL9ZAk7RE4WyTyVlxXkB8=; b=Qydz73Pkomn46eoMZ74ByCJrsQwq
        hl55+AKTqo5RgbDkU0iHCcak9bcXnBVJKUkIx2FwbeZI8PVC5O6u/UnpPzniyebT
        KlUjBsUrxkDUG319B1kaIV6id4uVJJOKWWAglOwgyicyTC2R6Mb+GRxXkeGARzqV
        ns/MxkFKYXKMiHY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79D92180FB5;
        Wed,  2 Mar 2022 15:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEDC1180FB4;
        Wed,  2 Mar 2022 15:39:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/9] Makefile: optimize noop runs, add shared.mak
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 12:39:05 -0800
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 13:49:08
        +0100")
Message-ID: <xmqqpmn4jdhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDB2962A-9A68-11EC-AB3D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As the v1 notes (among other things):
> https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avar=
ab@gmail.com/
>
>     This speeds up noop runs of "make" by a lot. After a "make" running=
 a
>     "make -j1" with this is ~1.5 faster than on "master"[2], and around=
 3x
>     as fast with "make -j1 NO_TCLTK=3DY" (the TCL part takes a lot of t=
ime,
>     but that's another matter).

Other than a few things I noticed and commented on, 1-7 and 9 looked
all sensible.

Thanks.
