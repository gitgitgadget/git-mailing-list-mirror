Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B3EC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCDB64F04
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhBVRpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:45:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56173 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhBVRpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 12:45:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45649BB513;
        Mon, 22 Feb 2021 12:45:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r1stD6QZiTjZtoMn5zM05mHs7Hw=; b=PMalLw
        g+2A8TFGYwKmCi7P3hR4tlftPkJKbx8H0Q497UJZbzU5iQDy/T0OQc0laxa1qijM
        xrJ/K+zDJ+v4AyXRDasQQkwxR0j5KBc6xlfu/hDNNLD19+Q78VUa65PiBU/0DYAp
        TBvukq7BwsOg3gMSGRyykQFb1YfbCWekFlq8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tLMDUs8KacdF/oBnv7V6aSN+CUNK1jJ8
        pf85lgZDKBdUZ1FtUY2bAEc9xKbJleynxNBycYjJEAeheakVhFK4k3GncSLtBT2a
        Kk+EbXnOKqlQ+YeRV27Kko0bx5P5Dmk+s3cHPrEDoOFrmmJbpDSHq9lQpVjuTJN4
        9Pb5uHycy0A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2461FBB512;
        Mon, 22 Feb 2021 12:45:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA561BB511;
        Mon, 22 Feb 2021 12:45:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] tests: don't mess with fd 7 of test helper functions
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
        <YDLVsjumwSXgEU7k@coredump.intra.peff.net>
Date:   Mon, 22 Feb 2021 09:45:06 -0800
In-Reply-To: <YDLVsjumwSXgEU7k@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 21 Feb 2021 16:50:42 -0500")
Message-ID: <xmqq8s7g809p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3FEB8FC-7535-11EB-B1D0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that 6 is probably reasonable. I wonder if it is worth having a
> master comment describing the function of various descriptors within the
> test suite, so that people know which ones are available for which
> purposes.  It is getting awfully crowded in that space.

Thanks for a review.
I had the same impression.  I'll wait for a reroll.


