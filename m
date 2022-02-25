Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2774DC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiBYXUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:20:03 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC7517FA
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:19:30 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0802B18DC2F;
        Fri, 25 Feb 2022 18:19:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dR6ibP3otBK8
        HMrFre+ea5y3hetKhwy9dxvi+qctb80=; b=D/b0lzsmIRfA0PHd5msDTHlUjYnZ
        Z6rK+3nGZNruDDTUUPj8EdZ6M/FvBH+ZTaubQfaRmhPFO02E3dRMNvcUypmfOsB2
        hoEk2VuUSDKx7kNPvBZ9B7NGXmRJt3hVo5WMoCcGsW31ZXihUu5tJkNWu4yEGK7F
        5hpgxyTBmg44Wjk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3F6218DC2E;
        Fri, 25 Feb 2022 18:19:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6BA8918DC2C;
        Fri, 25 Feb 2022 18:19:27 -0500 (EST)
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
Subject: Re: [PATCH v3 5/9] Makefile: move ".SUFFIXES" rule to shared.mak
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-5.9-16f2e3ff35b-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 15:19:26 -0800
In-Reply-To: <patch-v3-5.9-16f2e3ff35b-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:31
        +0100")
Message-ID: <xmqqfso68rgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 60781182-9691-11EC-80F9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This was added in 30248886ce8 (Makefile: disable default implicit
> rules, 2010-01-26), let's move it to the top of "shared.mak" so it'll
> apply to all our Makefiles.
>
> This doesn't benefit the main Makefile at all, since it already had
> the rule, but since we're including shared.mak in other Makefiles
> starts to benefit them. E.g. running the 'man" target is now faster:

Nice.
