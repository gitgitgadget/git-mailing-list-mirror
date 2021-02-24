Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF2C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F6964EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhBXTtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:49:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51113 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhBXTtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:49:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E7D211776D;
        Wed, 24 Feb 2021 14:49:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Yy6oKosLaKGY
        9HfdgZfzvtbbLAE=; b=KksWE1RvlsN1AeAde6afNn+tLcRQb4shrPzAQ6/yzfwY
        i5S4NDffBo5XDQNeYGa0u2UQEuO5L5/nzCZ8TGIs3s6Vb44W2RVs20tCeCAegeWK
        zu56QjOR2yqApQL5Y2iWfLzlYJhXj5vQQ4iRH/oCM3NYkZiebvdU1Dt6mLhN25k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eXNfdu
        TqbOZdn0pKP/2cLBsMEWe7RtgvHgBZ/K8R3ffZAt/qro0T1KcopGa3gtd0QtEW6N
        LdeG0W0cX0oMcgO/NG4wAW2IT7D5eu9fiAtrGKcR0TeJpS7IGG6BDgKKK1/DocDe
        EoD12dtaF7rt4I6UbF+cy3M4+XI3RJTQUyEvQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8609B11776C;
        Wed, 24 Feb 2021 14:49:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF65811776A;
        Wed, 24 Feb 2021 14:48:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3] rebase: add a config option for --no-fork-point
References: <20210223071840.44267-1-alexhenrie24@gmail.com>
        <CAN0heSqmAgt_hg0-kQpTK2LcuYPV9T9=1bowbuZ7Qah1q0EAtA@mail.gmail.com>
Date:   Wed, 24 Feb 2021 11:48:57 -0800
In-Reply-To: <CAN0heSqmAgt_hg0-kQpTK2LcuYPV9T9=1bowbuZ7Qah1q0EAtA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 24 Feb 2021 20:33:43
 +0100")
Message-ID: <xmqqo8g9z1p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5691F288-76D9-11EB-9DEB-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Tue, 23 Feb 2021 at 08:24, Alex Henrie <alexhenrie24@gmail.com> wrot=
e:
>> +rebase.forkPoint:
>> +       If set to false set `--no-fork-point` option by default.
>
> This should be a double-colon at end of the line, not just a single
> colon, in order to make it a "description list separator". When it's
> just ":", it ends up being rendered literally, which isn't horrible, to
> be sure, but which doesn't match this item's neighbours.
>
> Martin

Thanks for your sharp eyes; will amend locally before merging it to
'next'.
