Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388CC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C9160EBC
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJWVmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:42:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51635 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJWVmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:42:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D89FE92F;
        Sat, 23 Oct 2021 17:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y6ScE9EW/RZ2
        28sBafhrvF73bLn4p2jfD3GC6bhWL28=; b=ZClRGFG7JVxYJ2v1i8lvzrgqbceI
        bEJ40MbDygz3ST7AUTFbwlspEX+FyK2JzwOBAuCQhOX4G0M/ZXkQ5ZNxbVHLf/NQ
        xo2Bi39bv2HARk5fMwhvXLuO7k3ipAMPgbQhYvqw//RwMGVD5qo75kyhX6vLFavh
        pEUcU9IIme1PB80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B01FFE92E;
        Sat, 23 Oct 2021 17:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97701FE92D;
        Sat, 23 Oct 2021 17:40:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: SubmittingPatchs: clarify choice of base and testing
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
        <xmqqa6izcwio.fsf_-_@gitster.g>
        <211023.86bl3fih42.gmgdl@evledraar.gmail.com>
Date:   Sat, 23 Oct 2021 14:40:11 -0700
In-Reply-To: <211023.86bl3fih42.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 23 Oct 2021 22:59:00 +0200")
Message-ID: <xmqq1r4bbetg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD7C2E9E-3449-11EC-92A4-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Anyway, I can see why you suggest the "base on master and merge", it ha=
s
> its benefits, but it is in apparent conflict with existing advice added
> in 76644e3268b (documentation: add tutorial for first contribution,
> 2019-05-17).

I do not mind if you help the effort by updating that document as
well to match, but I have a feeling that the first contribution,
with a follow-up to fix, is sufficiently different from a more
advanced "I need something more than and not yet in 'master' for my
new topic" use case.

> I.e. the "After Review Approval" section (of all places) discusses what
> to do in that situation. It is narrowly talking about submitting
> something on top of your own topic, but the advice should be the same i=
n
> either case I'd think.

No, the advice should be totally different between these two cases.

The "fix or enhance what you already sent" is a continuation of the
same topic, just you, your reviewers and your maintainer were all
not competent enough to catch the shortcomings before the topic hits
'master', and it does make sense to make correction directly on top.

What I am describing here is "I am doing something new, but uses
what is not yet in 'master'.  The author of that other thing I am
depending on may or may not mean to help this new thing when they
wrote it, but the important point is that this is not a continuation
of their topic. It merely depends on them".

Thanks.
