Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E3C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47D5229C5
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 17:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbhAWR4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 12:56:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56061 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAWR4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 12:56:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FEFB116C69;
        Sat, 23 Jan 2021 12:55:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=fPoQ5e6ubG/Fu6dUtIOUCUiJQzA=; b=mYfdbQEyJqYHuI/NAmkk
        Hn/AHryQJ/ktjZosXCflKxtG9bOoG2LFUzFJ4o6Rv8BNdABciC64d3VmDOpjn8pn
        rvzCFsBpZlZmhZP+SdMFMc4WfU9C8Ohny2KmAvxikwr76cdf6e1PtZqSQ/q1oQxP
        3lEnbVAoHtGTy/ewx3aZ8qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=mw3PfJbkuEanfF6fFZ27SPCVhRItQzuXz8mlAe/JzknTC1
        BJaWJ5QnBwoEqVUx+EPG9ifGFm7LhOzw2OE8rTBhQDoeF124ycrbUjx8LQDsf/iP
        JoxWuPC2bioi8U7s4aRNIxAZpHqEu8YyD71vYCQmR+XhCq8htqXKXROf/fqXs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 388C4116C68;
        Sat, 23 Jan 2021 12:55:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8395F116C67;
        Sat, 23 Jan 2021 12:55:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@gitlab.com, peff@peff.net
Subject: Re: [PATCH v2 0/3] ls-refs: traverse prefixes of disjoint
 "ref-prefix" sets
References: <cover.1611080326.git.me@ttaylorr.com>
        <cover.1611158549.git.me@ttaylorr.com>
Date:   Sat, 23 Jan 2021 09:55:31 -0800
Message-ID: <xmqqpn1v4jxo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 312665F4-5DA4-11EB-AE27-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a reroll of the series I sent yesterday to traverse the
> longest-common prefixes of disjoint sets containing the ref-prefix
> arguments to ls-refs.
>
> Not much has changed last time, except some clarification about what
> 'for_each_fullref_in_prefixes()' can yield, and splitting out the last
> patch into one from Jacob and one from me. I've forged his sign-off
> since it contains his original code, but it includes a new patch
> description from me.

Oh boy I feel behind, but finally I had managed to block time to
read through the two iterations of discussion on this topic without
leaving my desk once, and it was a pleasant read.

Thank you to all three of you.
