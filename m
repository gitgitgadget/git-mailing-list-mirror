Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE27C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiCBTga (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241554AbiCBTgY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:36:24 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA2D76C4
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:35:40 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD1AA11AC0D;
        Wed,  2 Mar 2022 14:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zj5sNKp6w58K
        BoTqoAlzAjeaMMaYTfgrZO9kWdc56dw=; b=xVYypGD6t7XcNlODZl02FvIRjPiy
        WnVHYT8OWHNTsLpL87+0pvj/R6+CdA68+Fi2GIPYelMUjdaFonbmVZRY1rxYkl4J
        THiyASVURLXl+0ZmiN2MbhCCTW8hADg7RfovxRoAxBZ2iGLceE+QOxSZIbtv7Yhi
        qIK1KGccpW2F4C8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1A7911AC08;
        Wed,  2 Mar 2022 14:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12F2A11AC07;
        Wed,  2 Mar 2022 14:35:39 -0500 (EST)
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
Subject: Re: [PATCH v4 1/9] scalar Makefile: use "The default target of..."
 pattern
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
        <patch-v4-1.9-26c6bb897cf-20220302T124320Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 11:35:37 -0800
In-Reply-To: <patch-v4-1.9-26c6bb897cf-20220302T124320Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 13:49:09
        +0100")
Message-ID: <xmqqzgm8jgfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F09CC114-9A5F-11EC-A986-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Make have the "contrib/scalar/Makefile" be stylistically consistent
> with the top-level "Makefile" in first declaring "all" to be the
> default rule, follwed by including other Makefile snippets.

Sorry, but I cannot quite parse it.  Perhaps remove "have"?

> This adjusts code added in 0a43fb22026 (scalar: create a rudimentary
> executable, 2021-12-03), it's a style-only change, in a subsequent
> commit the "QUIET" boilerplate at the beginning of this file will be
> retrieved via an include, and having an "all:" between the two set of
> "include"'s after that change would look odd.

In other words, raising these includes to the top is not style-only
but is more significant change.  I think these two are logically
distinct changes, but I am fine to see both in the same commit, as
long as they are explained as such.


>
> As noted in [1] using ".DEFAULT_GOAL =3D all" is another way to do this
> in more modern GNU make versions, which we already have a hard
> dependency on, but let's leave any such change for a future
> improvement and go with using our established pattern consistently for
> now.

I would suggest dropping this paragraph.  In the discussion, we
didn't even establish that such a change would be an "improvement",
and in fact, not everything new is an improvement.  If we know
.DEFAULT_GOAL is not used, readers of Makefile do not have to run
around and look for it to figure out what happens when "make" is run
without argument.

