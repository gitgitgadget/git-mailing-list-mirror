Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A58C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C765613BA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhEEA44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:56:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60425 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEA4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 20:56:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 593AD1268DC;
        Tue,  4 May 2021 20:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Siwn1C5Phkt8zpnGh4YT7FIvfhD6+9KqtJedup
        dsc0U=; b=Glrn7nXUWYalPzu5P8ANUsKNdIu0pjquFAeKH1U9LLHtRGEOTWgLE+
        6t6QXNHRIUYwzjFKE8ftN9U9wgstVSEZO0oaemko9IEwXteF63rZrGhP511eyJAl
        C0R6BLWyXtr6mX2p26kIQwAinUiiMx2cIvzHAUyoWNlVeH0hrr8WY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 509A61268DA;
        Tue,  4 May 2021 20:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EC351268D9;
        Tue,  4 May 2021 20:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 22/22] p5326: perf tests for MIDX bitmaps
References: <b75b534446088b20e77cbaa7f09705510ddec908.1617991824.git.me@ttaylorr.com>
        <20210504180058.2988580-1-jonathantanmy@google.com>
Date:   Wed, 05 May 2021 09:55:52 +0900
In-Reply-To: <20210504180058.2988580-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 4 May 2021 11:00:58 -0700")
Message-ID: <xmqqh7ji578n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4A23278-AD3C-11EB-AE5D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> There is slight overhead in "simulated clone", "simulated partial
>> clone", and "clone (partial bitmap)". Unsurprisingly, that overhead is
>> due to using the MIDX's reverse index to map between bit positions and
>> MIDX positions.
>
> Thanks - it's great to see that accessing a MIDX bitmap doesn't add much
> overhead (as compared to accessing a single-pack bitmap of the same
> size).
>
> All the remaining patches up to and including this one look good.
> Overall, I did have some comments here and there, but I am happy with
> the overall design.

Thanks for a review.
