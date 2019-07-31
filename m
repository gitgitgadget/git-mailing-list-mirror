Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15531F731
	for <e@80x24.org>; Wed, 31 Jul 2019 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfGaQ5x (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 12:57:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53890 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaQ5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 12:57:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7403D16D5FB;
        Wed, 31 Jul 2019 12:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ok6OXB8Awz0aMem+BCgCVJOgso=; b=Llz8Rm
        tgM0Hof+lSUe4hzRIin6YUAcsX6R/ZeXZ2ZA7pftRqOgvhCcul+KXs9JTAxTop2L
        tSimdoKtTAMnFrjg0vnMLdmhrTTYL1bWpHW8gDS4bOFC7GUHL2x8qM1gexjcXwUp
        KzhoGz5xd6PpFOXxmfAr1xlE2Nqyh6xoZv5dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JHD0+y/Nea9WBkS9b2XHjkjACBVt5DuX
        SGXsjTAE7PeaKbXk4lDUPGHpBLqViL9cTjOteoSEGbjyE/60SXsZSwV/hPA4odgQ
        4PonaEyFEuAT5PioqkMHHjMJ0K8YDNA65RBKSuQS56BFQ7r49RoqzkFHETRC4Fjc
        XXHZIpcSOh8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A5FB16D5FA;
        Wed, 31 Jul 2019 12:57:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBA2E16D5F8;
        Wed, 31 Jul 2019 12:57:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
        <20190730194938.GZ4545@pobox.com>
        <20190730200203.GA4882@sigill.intra.peff.net>
        <20190730205624.GR20404@szeder.dev>
        <20190731005933.GA9610@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 09:57:49 -0700
In-Reply-To: <20190731005933.GA9610@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Jul 2019 20:59:34 -0400")
Message-ID: <xmqqh872qgz6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54BB44DA-B3B4-11E9-B914-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So regardless of the endian thing above, it probably does make sense for
> any hashmap iteration output to be sorted before comparing. That goes
> for t0011, too; it doesn't have this endian thing, but it looks to be
> relying on hash order that could change if we swapped out hash
> functions.

Sounds sensible.
