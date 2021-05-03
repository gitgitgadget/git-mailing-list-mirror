Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CCCC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C6561003
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhECF2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:28:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51478 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECF2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:28:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4697114834;
        Mon,  3 May 2021 01:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L4MdepYFVBJAefyRL8KlXXBzuL9aN2LaLPS9qV
        rfpdw=; b=h/4NyNbaKvkht+JxMDRUHOGma2VPQeoAncICSGJJENzTXYUwyoODpX
        xxtAxvMWXIkEjnmUzfhAty5shUeWFZVyoarizb8qAkOUSaRK2WHC5jRkeZA+XL/6
        JgP+TJf9TYzEIFNnXh6XScADeT12wg5GPjFZBKIsGG8XGaevhsfXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DCDB114833;
        Mon,  3 May 2021 01:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B52DD114830;
        Mon,  3 May 2021 01:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
Subject: Re: [PATCH 1/5] t5300: modernize basic tests
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
        <YI1fk3nE6AJRK8qS@coredump.intra.peff.net>
Date:   Mon, 03 May 2021 14:27:18 +0900
In-Reply-To: <YI1fk3nE6AJRK8qS@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 1 May 2021 10:02:59 -0400")
Message-ID: <xmqqk0og8k09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B12B2AA-ABD0-11EB-9864-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The first set of tests in t5300 goes back to 2005, and doesn't use some
> of our customary style and tools these days. In preparation for touching
> them, let's modernize a few things:
> ...
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5300-pack-object.sh | 243 ++++++++++++++---------------------------
>  1 file changed, 85 insertions(+), 158 deletions(-)

Thanks.  That was an impressive list of a "few" things ;-)  The
result certainly is much easier to follow.

