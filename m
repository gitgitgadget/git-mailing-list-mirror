Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51636C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 02:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhKWC7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:59:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61911 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhKWC7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 21:59:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F12CEEB440;
        Mon, 22 Nov 2021 21:55:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iZPmP3CDlUMu
        QiMxIodL4H4wgYGtzsu77+4aui2sc8I=; b=hpGtxbUHfKdGKLtowaSc84jt5i1Q
        WpB7XSdVXm2GYBdnAuUkODj9xVkMtGQRmQx8AI4XwXnTuiSy41H9wZhwxRUDb35z
        iZl4oHu5bcF/kULr5Lj9Cq+fMjF++T+u94WEXAUPjxgsh2uyJQdBo50EBDjzuTtE
        5NF9v/J1aSk+uxk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6F67EB43F;
        Mon, 22 Nov 2021 21:55:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EC62EB43E;
        Mon, 22 Nov 2021 21:55:57 -0500 (EST)
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
        <xmqqpmqrachl.fsf@gitster.g>
        <211123.868rxfwqdw.gmgdl@evledraar.gmail.com>
Date:   Mon, 22 Nov 2021 18:55:56 -0800
In-Reply-To: <211123.868rxfwqdw.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Nov 2021 03:28:15 +0100")
Message-ID: <xmqqlf1fa8cj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E1D6ACC6-4C08-11EC-A0AA-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> That is what I would call over-engineering that I would rather not
>> to have in low level plumbing.
>> ...
> We've got --format for for-each-ref and family (also branch etc.), and
> for the "log" family.

But I didn't comment on them. ls-tree is a lot lower-level plumbing
where --format does not belong in my mind.



