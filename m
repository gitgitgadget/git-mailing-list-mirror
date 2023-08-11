Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B410EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjHKRFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjHKRFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74419F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C82118D315;
        Fri, 11 Aug 2023 13:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IMG5NNnI8yyTeQu2mliaI3nEjQj0cvLA0FMwgI
        box4c=; b=aB5kVMEz/ECABIhzeijpNa4mp+wHX3sgXlOn6TdFSwgJHgd8c3o6tU
        32AdxT8upkAKHryn63UIhIMO2CEbkyxKllsCx5qe3CtQGmR57MCa+D1LfH0V89dM
        F9UXpyKS7+9FBYmKFP9p4T2w25GG/vkRXtjDxsA9AM8myW5GUUTJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4279E18D314;
        Fri, 11 Aug 2023 13:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B04318D313;
        Fri, 11 Aug 2023 13:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
        <owly8raih8ho.fsf@fine.c.googlers.com>
Date:   Fri, 11 Aug 2023 10:05:12 -0700
In-Reply-To: <owly8raih8ho.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 10 Aug 2023 14:50:59 -0700")
Message-ID: <xmqqsf8ptsqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C90C8A6-3869-11EE-AA5F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> while thinking about what to write, i came up with an idea for another
>> improvement: with (implicit) --edit, the template message would end up
>> being:
>>
>>  This reverts commit <sha1>,
>>  because <PUT REASON HERE>.
>
> This sounds great to me.

Oh, absolutely.  I rarely do a revert myself (other than reverting a
premature merge out of 'next'), but giving a better instruction in
the commit log editor buffer as template is a very good idea.

> Nit: the "doc: revert: add discussion" subject line should probably be more
> like "revert doc: suggest adding the 'why' behind reverts".

Good suggestion.

> The word "latest" here sounds odd. Ditto for "get creative". How about
> the following rewording?
>
>     While git creates a basic commit message automatically, it is
>     _strongly_ recommended to explain why the original commit is being
>     reverted. In addition, repeatedly reverting the same commit will
>     result in increasingly unwieldy subject lines, for example 'Reapply
>     "Reapply "<original subject>""'. Please consider rewording such
>     subject lines to reflect the reason why the original commit is being
>     reapplied again.

Sounds better, but let me read the remaining discussion first ;-)

Thanks.
