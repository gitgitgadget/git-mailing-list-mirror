Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D021F991
	for <e@80x24.org>; Mon,  7 Aug 2017 01:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdHGBea (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 21:34:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751378AbdHGBea (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 21:34:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A904BAEED8;
        Sun,  6 Aug 2017 21:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nFbvLFok3UODcZOBWnkkWCC3Nsw=; b=m1KoAm
        CXKs4ElYIJG9PkkI05GoTMciTsaSr9pC0Oej6vmEDxA6jJqE6dgLLBxYNQqKREwQ
        P5L4vRTSklODtCjRAn02icn44cChQeUaU6U3jflfJiT18uURnRtyyOyEyqOLVe84
        LT97WEDJMAaqC9XtZ+LRw0ue6Enx+zPkW0cr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UHazQ5yX7Zk6FpC/EZDaCcOUhv2K/oRA
        yBkJZeecJW9XjXRk0KIg5k5+C9eqbT3gMdR3AMLCO2fHmpNGCvcE/tUMFewloviX
        OT3rdk2wCGnyiyRMR01pSMKCWEqgEjQXAXhrIfuOUKpiXZyy4mWL5SJYMsXnXiu9
        GtlrGUGqRtc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A182CAEED6;
        Sun,  6 Aug 2017 21:34:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2C63AEED5;
        Sun,  6 Aug 2017 21:34:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
        <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
        <87bmnvktee.fsf@linux-m68k.org>
        <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
        <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
        <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
Date:   Sun, 06 Aug 2017 18:34:22 -0700
In-Reply-To: <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 4 Aug 2017 17:22:31 -0400")
Message-ID: <xmqqzibcqhy9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B042770-7B10-11E7-A464-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That is fine by me. AFAIK, we already build the curl support by default
> when a sufficiently-advanced version of curl is available. So if there
> were feature-parity problems hopefully somebody would have reported it.
>
> I think the deprecation here can be relatively fast because we're not
> actually dropping support for any feature. We're just requiring that
> they install curl to get the same functionality (which might be
> inconvenient, but it's a heck of a lot less inconvenient than "there's
> no way to do what you want anymore").

Yeah, as long as imap-supporting libcurl is not too recent and are
available everywhere, we should be OK.

Thanks.
