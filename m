Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BAF2070F
	for <e@80x24.org>; Wed,  7 Sep 2016 19:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756711AbcIGT7f (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 15:59:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50264 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbcIGT7E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 15:59:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50E353B2AC;
        Wed,  7 Sep 2016 15:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nidI1xlDhNwt1zeZQ0LxQ0eLKCM=; b=g4gLyV
        Kjhn8TnOTgHkWdNz2yUXmb64zb9fu2mYyNzIQG09VuIKAgDyAByttU5Bi1drxabh
        ud/Ed+dO6P4ju0aDMASvhWlmzTKvfcdahbzecjn/mevOLopu8r9dyjmhWJY8o08L
        l+cXeBs5IXYzxnUg5FgMaW66KGRV5In17ls0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lNvzBa6qYT6rxUMtrJ2e0qP/WmVfiMAT
        f/UVq2Wse4bhEEDQEZ5oCWlywO2iATgOYDQVCsOo+u6n6Cvzqvfg0wuBTr5sxPBa
        7bWvXHS//Q9dWBkrTmr/ZVVyLN6tb6bAX1DQgT8T4rYPizsasSYRBl7LHfc7Fk5k
        X8jmbBYXt0E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 433A73B2AB;
        Wed,  7 Sep 2016 15:59:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC40F3B2A9;
        Wed,  7 Sep 2016 15:59:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6026-merge-attr: wait for process to release trash directory
References: <3fd38b71-26bd-bdb3-fe5c-e7038abf51e0@kdbg.org>
        <20160906072707.goysliw32xgwmlol@sigill.intra.peff.net>
        <xmqq4m5rmu4i.fsf@gitster.mtv.corp.google.com>
        <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net>
Date:   Wed, 07 Sep 2016 12:59:00 -0700
In-Reply-To: <20160907190004.dw3p6fxkdaubwuvu@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 7 Sep 2016 15:00:04 -0400")
Message-ID: <xmqqa8fjlbwb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 863C62CA-7535-11E6-BBB0-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that the sleep could be made longer, to make the test less racy.
> However, the racy failure mode is that it might pass while testing
> nothing (i.e., the sleep ends anyway before the hook returns), so I
> don't think it's a high priority.

I do not think it is necessary, either.  It was just me wondering
aloud, nothing more.
