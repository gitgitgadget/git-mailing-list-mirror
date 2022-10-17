Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C0C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJQTIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 15:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJQTIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 15:08:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9992BF3C
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 12:08:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35FB61B2D37;
        Mon, 17 Oct 2022 15:08:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g1wuMVqRb+t7
        zxLbVs/fZ7QgddGLCDbxXCdLN1OBCFE=; b=jc3s1WDh6LKDXjG/P16cTMvAvfpM
        y/nddQ7ZpWyTM5dBbUO/dM8VK6/NNChr+wPVUoeTbcSc6gaTNVPLxMAsqsO5tmPI
        ujn5DsN/o9N6liiNQ7i6cS4vXemgOpmNTLnZDVchl+S+j8zyqdw07SLAC0YGjwJQ
        l2aWZWJVcgec/rw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DF1E1B2D35;
        Mon, 17 Oct 2022 15:08:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45E171B2D34;
        Mon, 17 Oct 2022 15:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/11] cocci: make "incremental" possible + a
 ccache-like tool
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
        <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
        <Y02V0E0JRSNa4Sb9@coredump.intra.peff.net>
        <221017.86czaqjnhy.gmgdl@evledraar.gmail.com>
Date:   Mon, 17 Oct 2022 12:08:44 -0700
In-Reply-To: <221017.86czaqjnhy.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 17 Oct 2022 20:36:46 +0200")
Message-ID: <xmqqpmeqz2rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F4F6306-4E4F-11ED-A7DF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But as 10/11 notes we can just avoid this by not picking conflicting
> names, which doesn't seem like an undue burden.

As long as it is clearly documented to make it well known to
everybody who would attempt to touch or add .cocci files, I am OK
with that direction.

> AFAICT we have 5 named rules, and seemingly only 1/4 actually needs its
> name, the rest are apparently only using it for self-documentation, and
> we could either remove the name, or accomplish the same with a comment:

Well, if they are for self-documentation, they'd better be unique,
or they are not self-documenting enough, no ;-)?
