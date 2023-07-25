Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF70EC001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 16:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjGYQwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGYQwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 12:52:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F012C
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 09:51:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F28E830D9F;
        Tue, 25 Jul 2023 12:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4br8UM5lGpDP9W69AXJIBIeOr/4EgfVIfY76ar
        P9kbA=; b=R9PvGpeOw6hGQ7drjK4EA36NBzT7ajFjrGySL//0PGweyHMlwxAge7
        IQGyxUx0u/k6zSWe0VfEubHSmlJLYKnxUobyxjd39BasPH68WXkHHx9JopQmOjLe
        WqvAAA4spu9bdt6ClbPfvb+B4Jy6slMV3cozOBrbHwizsaV8WzaxQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA91C30D9E;
        Tue, 25 Jul 2023 12:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7950330D9D;
        Tue, 25 Jul 2023 12:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Coup <robert.coup@koordinates.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] repack: implement `--filter-to` for storing
 filtered out objects
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-8-christian.couder@gmail.com>
        <xmqq5y6y1agl.fsf@gitster.g>
        <CAP8UFD1tqzp744j0KORw-zcgOn6Tufm4Kk3yct3vHGY29pbm-w@mail.gmail.com>
        <xmqqy1j5p40f.fsf@gitster.g>
        <CAFLLRpL8yUb5eSBwCuEcHkgZEZcAdugua0robVUNGUE6Eik8Bw@mail.gmail.com>
Date:   Tue, 25 Jul 2023 09:50:34 -0700
In-Reply-To: <CAFLLRpL8yUb5eSBwCuEcHkgZEZcAdugua0robVUNGUE6Eik8Bw@mail.gmail.com>
        (Robert Coup's message of "Tue, 25 Jul 2023 14:41:35 +0100")
Message-ID: <xmqqr0owlyud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60495E9A-2B0B-11EE-A454-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert.coup@koordinates.com> writes:

> ... Like others, I wasn't at all sure about the
> original approach (and commented at the time). What Christian is
> proposing here seems much cleaner, is usable without complex
> gymnastics or safety equipment, and provides a better building block
> for future work.

Nice to hear a positive feedback [*].

Thanks.

[Footnote]

 * Of course negative ones as long as they are consturctive are also
   welcome;-)
