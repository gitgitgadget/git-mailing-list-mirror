Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F2C43381
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D24239EF
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAOVlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 16:41:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51691 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhAOVlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 16:41:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F60AA7F3A;
        Fri, 15 Jan 2021 16:40:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=BZEpWk3JCzMfz1McSGUFCqo+SM4=; b=C/0eBpQMmyA7M0PtFnj1
        hj/ERXcn5XYOIFA8ICGyHHIBlzm60V3n4elHOkVmEqZhygF8yvL7+e5FjmXYooQw
        /TlXx3bBkDBrF2UofHYscqkqOeSjanoJl3NFLQ+PoV4rkNfB/YQ5mLuhm5xVE0EI
        R+kKc0LX5531G8DWsS4nljg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=lpBBg/7MK0BnjAYtEp9hdHWxHD1Zn82hXJyqaLq0+LCpqW
        T9V6z7tBDvnQWx8PlXyK7s38NmH3lDF6pGxlDrrn8GwkgGK0KkTfScB42qa76bCD
        Hea+yUL5wi3Vo+PkjaGZx9SvKn7Yl8uNz4idf33VilqjQ21ST9CTLxRUpaxMo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32FE9A7F38;
        Fri, 15 Jan 2021 16:40:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD6AFA7F37;
        Fri, 15 Jan 2021 16:40:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <YAHyZbJNhvZUowIq@coredump.intra.peff.net>
Date:   Fri, 15 Jan 2021 13:40:20 -0800
Message-ID: <xmqqv9bxri9n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 443ABC4C-577A-11EB-A5C7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I looked over the first 7, and noticed two of the patches are flipped in
> roder (I sent a separate reply in the thread, but I wanted to catch your
> attention, since I guess this may be on the list for integrating today).

Thanks.  Let's "rebase -i" the kinks out before merging it.

> I didn't see any problems in the code of the 8th one, but I didn't spend
> a lot of brain power thinking about the overall design. I feel like that
> was hashed out pretty well in the early discussions, though.

The same here.  I do not have a need for the KEY/VALUE pairs myself,
but I think the design is sound and I didn't see anything wrong in
the implementation.
