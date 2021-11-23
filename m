Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B1CC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhKWB3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:29:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57287 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhKWB3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:29:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDC8DEAAB3;
        Mon, 22 Nov 2021 20:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ENrJ7k1Hvx8H
        HpTWlPoDDx/zwrqAj1EXgatbNGdr0sE=; b=NgAY+22DP+AwFbAxm978Yj9O+ffA
        hnIF3x5poyKQlaIgPtwkzg7UySzvci7n4Y+6+PCq5YDOrFQkW/c3L6nCh5Qau2X2
        RBJw9j7mZLKjYT4fyy5uLOxoMq20psDY76RgSlJVo0Khs9M0pCDO+xMNsaZGqieo
        n/vcG0sAuEAm/eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5213EAAB2;
        Mon, 22 Nov 2021 20:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23305EAAB0;
        Mon, 22 Nov 2021 20:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
References: <cover.1637567328.git.dyroneteng@gmail.com>
        <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
        <xmqqczmsf2d2.fsf@gitster.g>
        <211123.86tug3wu8v.gmgdl@evledraar.gmail.com>
Date:   Mon, 22 Nov 2021 17:26:30 -0800
In-Reply-To: <211123.86tug3wu8v.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Nov 2021 02:09:05 +0100")
Message-ID: <xmqqpmqrachl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63514412-4BFC-11EC-B3BB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> All of which (and more) would also be addressed in an obvious way by
> just supporting --format as I suggested in
> https://lore.kernel.org/git/211115.86o86lqe3c.gmgdl@evledraar.gmail.com=
/;
> don't you think that's a better approach?

That is what I would call over-engineering that I would rather not
to have in low level plumbing.

I am all for making _parsing_ the output from the tool easier by
scripts; I am not interested in eliminating the _output_ by scripts.
They should capture and format the pieces we output in any way they
want.

So, no, I do not think it is a better approach at all.
