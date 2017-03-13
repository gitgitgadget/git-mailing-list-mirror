Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B4E1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbdCMTQU (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:16:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54160 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751095AbdCMTQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:16:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBCAD83AF1;
        Mon, 13 Mar 2017 15:16:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sAIpAnVTjKpSsvN8hn/rcNTtb9A=; b=LLgYMx
        ejovGx5IwsMxItCGAGomrfnFMolJ14H3EjlVhAhoChZHdRLGk+3kRHwpiCRi4FHY
        1jJTrciCgcw64qhZvurVbxZGcL5WH9xtG99lqU4KpCPZzxQHFS7DyBb9agK3EUJg
        MEzzt8Y5mf5w/nifGasvvTIrRRRnw8HefEggw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UNiYeYIWkHfeNTdzZjeUvjKWBX5xxHJV
        Q/WVgtpCA4BBs0VIqWjHZMmHxydvK5x3b6UMP5UF3fUW7fI5UrCVOM8v9FUiDtaT
        uwpc3gfokYImrQXkgQMJ/9Q4fx5TcWcucRys2BF0jBcDE2wvBNd6JNDc3jBjbTjr
        V4UQqIjU9W8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E533583AF0;
        Mon, 13 Mar 2017 15:16:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5321C83AEF;
        Mon, 13 Mar 2017 15:16:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anthony Scian <ascian@auvik.com>, git@vger.kernel.org
Subject: Re: 'git add --patch' no longer allows you to select files before selecting patches
References: <DF55CDE6-E556-4C07-B661-0F5AA00D306E@auvik.com>
        <20170313190936.vjyzdr2s2rc66frc@sigill.intra.peff.net>
Date:   Mon, 13 Mar 2017 12:16:16 -0700
In-Reply-To: <20170313190936.vjyzdr2s2rc66frc@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Mar 2017 15:09:36 -0400")
Message-ID: <xmqq4lyxrnr3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8867ADF0-0821-11E7-93E5-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My, this seems to be a popular bug. This is the third report already. :)
>
> The answer to your final question is that it's a bug. The fix is in
> c852bd54bd87fdcdc825f5d45c26aa745be13ba6, which is currently in the
> "master" branch of git.git.

If only more people learn to run 'next', we would get less reports on
already fixed bug and instead get more reports on unexpected regressions
caused by these fixes, both of which would be a very good thing ;-)

> Junio, I notice this isn't in "maint", and probably should be. It's a
> regression in v2.12.0, so hopefully we'd fix it in v2.12.1.

Yes, thanks for an extra reminder.  The reason why I pushed it out
on 'master' during weekend is so that we can have it at least for a
few days there before merging it down to 'maint'.
