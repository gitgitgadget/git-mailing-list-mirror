Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68FC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiIZRk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiIZRkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:40:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E1DF4E
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:06:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 274581C5B40;
        Mon, 26 Sep 2022 13:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iaIDF6c8gqbd
        2vDgOFw/kYtFzXskN11PEp2rZR8WaUA=; b=aTunUYhRvl6xLwDORKoUsimSNqS3
        x/t0YstZW8iQRwMVIqTXmc1F3dvSdJpFXghP65EHKievs3aZxhcjxvVJfBOf108R
        5/AbVxhWLfiXZvpQ0wSLrXATORYkrVyVp/y9xHJzZMiiEatIZ6hzBTXQQGK4HdNb
        +91cw/PhWTsp7L8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FE0B1C5B3E;
        Mon, 26 Sep 2022 13:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 567FD1C5B3D;
        Mon, 26 Sep 2022 13:06:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] cmd-list.perl: fix identifying man sections
References: <20220923070334.1970213-1-martin.agren@gmail.com>
        <Yy4uDW9YjpleFUHW@coredump.intra.peff.net>
        <CAN0heSpPGuSYb1nEyA3RuV+ACrXjHu+YqxAsfZN62EHVqcQ9Mg@mail.gmail.com>
Date:   Mon, 26 Sep 2022 10:06:05 -0700
In-Reply-To: <CAN0heSpPGuSYb1nEyA3RuV+ACrXjHu+YqxAsfZN62EHVqcQ9Mg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 26 Sep 2022 09:16:25
 +0200")
Message-ID: <xmqqk05qqd4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 825E2C4A-3DBD-11ED-9800-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> I've also done
>
>   ./doc-diff origin/next origin/seen
>
> at times to catch such things a lot earlier, but it's not often that I
> find the time to do so / think about doing it.

Ah, that probably is a good thing to do on my end after picking
which topics to merge to 'next' and before merging them, i.e.

 * Find ones that are marked as "Merge to 'next'";
 * "git checkout --detach next" and then merge them;
 * Do the doc-diff between 'next' and HEAD.

in addition to my usual set of tests, SANITIZE=3D<stuff>, etc.

Thanks for an idea.
