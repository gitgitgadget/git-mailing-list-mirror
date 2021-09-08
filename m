Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E246FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4856610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350460AbhIHTZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:25:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64329 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhIHTZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:25:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A40DB166FAC;
        Wed,  8 Sep 2021 15:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9kzCk7t9foBq
        bTIfQ7lnOZDfzuV63PtuB+mLdqJ5esk=; b=QGsNYYfbwvWmErBy1l1RP9oznQJL
        Ho/zvYa16ndXWCd53JCwlC1eD04r2mNBsxbdul/D75hLvBma+VfeqARg7S2AI75i
        eFzvm3S2mx7DRU1ODvXXQP0QFalaTmjzuSK4IVnd4Q1lAtbt19bKMnhaEIviV/rC
        qjHx82Qj2VM2c6s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E0A7166FAB;
        Wed,  8 Sep 2021 15:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E67BD166FA9;
        Wed,  8 Sep 2021 15:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g> <YTjjqV/4/oceM3lM@nand.local>
Date:   Wed, 08 Sep 2021 12:23:57 -0700
In-Reply-To: <YTjjqV/4/oceM3lM@nand.local> (Taylor Blau's message of "Wed, 8
        Sep 2021 12:24:09 -0400")
Message-ID: <xmqq8s063m7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51013568-10DA-11EC-8AA3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Sep 08, 2021 at 08:38:55AM -0700, Junio C Hamano wrote:
>> * tb/pack-finalize-ordering (2021-09-07) 2 commits
>>  - builtin/repack.c: move `.idx` files into place last
>>  - pack-write.c: rename `.idx` file into place last
>>
>>  The order in which various files that make up a single (conceptual)
>>  packfile has been reevaluated and straightened up.  This matters in
>>  correctness, as an incomplete set of files must not be shown to a
>>  running Git.
>>
>>  Will merge to 'next'?
>
> =C3=86var has a series [1] that complements this one nicely, so I would=
 be
> happy to see them both queued.
>
> I had some suggestions inline, but I don't feel strongly about whether
> or not they are implemented.

I hate to see multiple folks "competing" in the overlapping area,
each getting reviews and responding or not responding at their own
pace.  That would force me to keep track of which one is which and
what their doneness are independently.

Do you mind if I nominate you the team leader to come up with a
single series that is polished to be mergeable to 'next'?

Thanks.
