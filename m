Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AF4C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA8720809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HEQtwx3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2SEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:04:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53187 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2SEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:04:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BDE7F3666;
        Wed, 29 Jul 2020 14:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FsSFLj6OQgUyQNj7AYrXokAYabE=; b=HEQtwx
        3fDZ2LSzni6H/r0yWFvj0mwHNDGvV/3FabUBf1bGeGWIU4tFSFzBb9KeBsrDiZW3
        ceejfjEYH99MdzjgJq8qnAAiIz7Xt4tQB/DtA6Mg5doi+fK+WDcX4CmD7Ei2x+rj
        1ocUnqDxDbl0T73kwjHu8xDK39NRyOc6e6q4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bq/jhGgvBmPMSESv3699kRM+1FjJIwxl
        0U8ylSQTgalM2gn0Ol10oLSXrWNWYl+CMcGDx3UYHOJn6gYvRQQSOY8doq1AG62U
        0q6oOc3rT5D9qvnJGzjfhtKQbrxg6bGX2h22eJkbGw1kl941jooOxPEqO73qCTTN
        SD0ABh5vT00=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74AC8F3664;
        Wed, 29 Jul 2020 14:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB116F365F;
        Wed, 29 Jul 2020 14:04:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 11/11] strvec: rename struct fields
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <20200728202823.GK1021513@coredump.intra.peff.net>
        <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
        <xmqqmu3jcp9u.fsf@gitster.c.googlers.com>
        <CAP8UFD3Z86nQq_iZ3kqvuL4Vr9PxL+71VBgd7my+YUxgFyYvXA@mail.gmail.com>
        <20200729163419.GC2320983@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 11:03:58 -0700
In-Reply-To: <20200729163419.GC2320983@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 12:34:19 -0400")
Message-ID: <xmqqd04eb3ld.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E15ABB20-D1C5-11EA-A3B6-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Using "str" would be consistent with oid_array where the individual
>> component is called "oid" as it is defined this way:
>> 
>> struct oid_array {
>>         struct object_id *oid;
>>         size_t nr;
>>         size_t alloc;
>>         int sorted;
>> };
>
> Yeah, I agree "str" is a reasonable name, and probably better than
> "elem" or "items". I do still like the super-concise "v" better, though.

One problem with names like "str", "string", and "oid" is that it
leads to this stupid pattern:

    struct oid_array *oid;
    oid_to_hex(oid->oid[0], ...);

We know the thing is object name by the pointer variable having the
name oid already---there is no need to repeat we are talking about
oid again with the field name.

So, "str" being consistent with "oid_array" is not necessarily a
plus.

Ultra-concise v[] that stands for value, or e[] that stands for
element, do not share this problem.

One plus about the redundant field name is that it is easier to run

    grep -E -e "([.]|->)oid"

but I do not know how important that is.
