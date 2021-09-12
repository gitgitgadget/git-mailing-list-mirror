Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DDC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062456023F
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhILWcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:32:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56437 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWcB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:32:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31435F5B31;
        Sun, 12 Sep 2021 18:30:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A7LUQFDvqn9T
        q7OavszI5jFLY1VubxGvy7j1GpctX9o=; b=ToTQiRDzyakTl2xW7zu0sFst7ffw
        eJdfKDcofAI+jGsCokFjld1oBVOn2aCoaE6qB3ZFIFvUmnMsQ2srWpYv7OeAtAcg
        RT/AjZKvPhqNJydwatCdyMkwLLWJhCW+1H47GNM2YkGe9MBYNbPR4bmzzmwKSoHh
        CxuncvROqqWHoX8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27AD9F5B30;
        Sun, 12 Sep 2021 18:30:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C5BFF5B2F;
        Sun, 12 Sep 2021 18:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
References: <cover.1631331139.git.me@ttaylorr.com>
        <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
        <87ee9va0ie.fsf@evledraar.gmail.com> <YTzYYfBGqG87O5mN@nand.local>
        <CAPig+cRAKJyzuMwPNdmC+BobrMjk5TF-o3Ort8R0E77ij=g6_A@mail.gmail.com>
        <YT1kDVBHtPhxc6Wk@nand.local> <87bl4x94ux.fsf@evledraar.gmail.com>
Date:   Sun, 12 Sep 2021 15:30:45 -0700
In-Reply-To: <87bl4x94ux.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 12 Sep 2021 17:15:18 +0200")
Message-ID: <xmqqlf41juju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 125F3A20-1419-11EC-9B80-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Or maybe the whole approch of the string_list API is just a dead-end in
> API design, i.e. it shouldn't have any "dup" mode, just nodup, if you
> need something dup'd you xstrdup()-it.

;-)
