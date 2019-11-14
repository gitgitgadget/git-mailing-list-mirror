Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D85A1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKNCDz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:03:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61479 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNCDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:03:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1E142DEC2;
        Wed, 13 Nov 2019 21:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mwrmi6dcxGy9C1rT+SxcZPLOrnY=; b=Ia0i6E
        iDyeG6QbRy2qiu2jaw/AHgR47JHw/ZyDFHf+eK7NK0pOs6InG4k/rZaNxGXc09fB
        ARNWZhnS3JBrxOfNRhBqQFXSUO98MRAfKQVyKRqH7kEA+ZLNu9RpHgjjoQnq0Bl2
        XMKIF1w0oeTYZewK/P1rWB/LW4R3F9xuKgCi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KtA2354o6AHh3xDlveHuq8hYfM45+fdk
        k0URMy64BLXy82PRgNy6CnA9FZxWapZ4D5xS1X69zjLHzCa4FibhwunT9N7aRsQM
        t7/prjSXfKuP28FIg4N50g3Mw5twccPZiHEGfusIlgZeVuzollX4dH4c4nj/lzDQ
        dWuRVmsxnDc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9DAD2DEC1;
        Wed, 13 Nov 2019 21:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48B2D2DEC0;
        Wed, 13 Nov 2019 21:03:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: coccinelle: adjustments for array.cocci?
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
        <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
        <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
        <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
Date:   Thu, 14 Nov 2019 11:03:51 +0900
In-Reply-To: <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de> (Markus Elfring's
        message of "Wed, 13 Nov 2019 09:49:46 +0100")
Message-ID: <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0174D7D8-0683-11EA-A721-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> writes:

>> I too recall that seemingly redundant entries were noticed during
>> the review and at least back then removing the seemingly redundant
>> ones caused failures in rewriting.
>
> I am curious if the redundancy can be reconsidered once more.
>
> Do you refer to open issues around source code reformatting
> and pretty-printing together with the Coccinelle software here?

Sorry, I do not follow.  

If you are asking if I am interested in following bleeding edge
Coccinelle development and use this project as a guinea pig to do
so, then the answer is no.  I'd rather see us instead staying on the
trailing edge ;-) to make sure that we use common denominator
features that are known to be available in all widely deployed and
perhaps a bit dated versions that come with popular distros.

And if that means we have to accept inefficient ways to express our
patterns, we are willing to pay for that cost.

So, "the A.cocci file uses a set of inefficient expressions that can
be written more concisely like this, using the bleeding edge version
of the syntax" is not a useful improvement for the purpose of this
project, while "the A.cocci file uses a set of inefficient
expressions that can be written more concisely like this, and all
versions of cocci that is newer than X would understand the
notation.  Even distro D that tends to ship with fairly stale
versions of packages ship version X+n, so this change should be
safe" is very much appreciated.

Thanks.

