Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B951B2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 02:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdKSCUB (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 21:20:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63569 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750972AbdKSCUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 21:20:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEE67A318A;
        Sat, 18 Nov 2017 21:19:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2EkRv6XErhpxA4aSCXtWG9IjVhM=; b=htjQ3n
        EX2as3Q0l6Jk6Ifx8siyAEiSrsknEuuFCYs4B+Wcm1Ra5MtwOZn4hOjMwpK8kNWF
        B3996I/5kudJqwB/Dn7xdFdgwCjFbfx3ZFKEJjpRjhxqDrC/8MzCFbzzjxDePDrC
        72SatFQRQkFNC31KaycXNypVfCwOc9l66LfBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZGc4MADZxZaF3EMkrQr6WrmWBfN797rk
        JGaQFz1M/l2VDILB5ba1yEHd6LLDC4+xTVMr4HHKWd54ery8mTrGJuz9Y8Yt0a+M
        nfZp5ytChw3d07hvidy88Aht5leUXXIRXZTIWGmmF4ZWR2QUaV1jI2tDsylSM6nw
        peAxP1UM93c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5414A3189;
        Sat, 18 Nov 2017 21:19:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D62BA3187;
        Sat, 18 Nov 2017 21:19:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     gennady.kupava@gmail.com
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH 1/2] Simplify tracing code by removing trace key normalization concept
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
        <20171119004247.22792-1-gennady.kupava@gmail.com>
Date:   Sun, 19 Nov 2017 11:19:57 +0900
In-Reply-To: <20171119004247.22792-1-gennady.kupava@gmail.com> (gennady
        kupava's message of "Sun, 19 Nov 2017 00:42:46 +0000")
Message-ID: <xmqqzi7jnh6a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 243D739A-CCD0-11E7-848B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gennady.kupava@gmail.com writes:

> Subject: Re: [PATCH 1/2] Simplify tracing code by removing trace key normalization concept

The usual style comment on the subject applies here.

> From: Gennady Kupava <gkupava@bloomberg.net>
>
> - to implement efficient traces with normalization, normalization
>   implementation should be moved to header. as it seems better to not
>   overload header file with this normalization logic, suggestion is
>   just to remove it
> - different macro exist specifically to handle traces with default key
> - there is no use of normalization in current code
> - it could be reintroduced if necessary

I cannot quite tell what it is trying to achive to make it a
bulleted list.  It's not like four things at the same conceptual
level is enumerated; instead it just has four sentences that talk
about random things.

More importantly, I am not sure I understand what these sentences
are trying to say.  "Should be moved to header"---so?  Does that
move something from the source to the header?  It seems to me that
the patch removes a helper function from trace.c but does not add
anything to the header.

Or am I wasting everybody's time by commenting on a stale comment
that used to describe an ancient iteration of this code?

Puzzled.
