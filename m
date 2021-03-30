Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35057C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE10E61987
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC3Ann (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:43:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55117 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhC3AnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:43:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0328B126B78;
        Mon, 29 Mar 2021 20:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jDfJv1CJA2jI29/Ko4gT1KMke8A=; b=eBXJL5
        Brvs7cssVsukEKpQdIw/HamwRdAccs/mB0gS+m65HXMwAHc9AgqzVr86QhOw8Gj3
        /v6s2AYSTst1AMTDs73UWK687Um1gW8E4R0WEwZd3bFWp0DtLGkaKy5Al/tjXlAI
        uGsbc7t81gz2JjD338g6WemGDvfq72sCEGvsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=btkbExp5StY97XQYVgSTFE8A12jWSjgp
        rdqnquWGOmVuSl5J8sGS9wjiVueY8o1yDpqXb7aM9MkmBLpVel++7a7ovnGsEXRR
        rmS1tkHIxjQyJLFVCPSpr5QpHyKtT2PwA80w35mtTcw07acN57BAH6PS0F1pL7jc
        Lscxd5doHTI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0AF8126B77;
        Mon, 29 Mar 2021 20:43:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32DBE126B75;
        Mon, 29 Mar 2021 20:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Upstreaming Reviewed-by to git.git
References: <0e32b0af-cd05-39a9-51a9-4d983e7085cc@gmail.com>
        <CAP8UFD1TmckvQLVQ7eWMKakMKOF76J+Z+E25vUCGkWveXMWv1g@mail.gmail.com>
        <xmqqr1jxisee.fsf@gitster.g>
Date:   Mon, 29 Mar 2021 17:43:07 -0700
In-Reply-To: <xmqqr1jxisee.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        29 Mar 2021 14:03:53 -0700")
Message-ID: <xmqqczvhfp44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E61E63EC-90F0-11EB-9B9B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In any case, reading others' patch, together with the original
> version before the patch changed, is a great opportunity to learn
> the codebase and how the project work in general.  It is highly
> recommended.

Addendum.  The above makes it sound as if I am encouraging new
people to only read to learn silently, but that is not what I meant.

Reading and then expressing what you read in the patch in your own
words is a good way for you to learn the system.  And it is also a
good way for the patch author to ensure what was written in the
patch is understandable.  For somebody who is totally new to the
codebase, any patch that is more complex than the most trivial might
not be hard to understand and that is not a patch author's fault,
but once contributors have learned the codebase enough, even before
they have their own changes to our codebase, a new patch should be
written in such a way to understandable by them without getting
misunderstood.  So a mere "this looks good to me" by new people may
not add much value to the discussion, but thinking aloud in more
detail, expressing why they think the patch is good, e.g. "I think
this change tries to do X by doing Y.  If I were doing so, I might
do so by Z, but I think Y would be a better approach than that"
would help others to see that what is written in the patch was truly
understandable (if what the new person said was to the point) or
misleading (otherwise).

Thanks.
