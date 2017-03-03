Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EF220133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdCCTJh (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:09:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53541 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752108AbdCCTJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:09:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB732648A4;
        Fri,  3 Mar 2017 14:06:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iUs3AbeDqazA+kzOOPD1s3ulNVU=; b=kDfk46
        w9wWApQFtt63b29sES/GhOpoDQ07YTYlQzGaCT7qKNNJ6JDGkHvqYsF/6Nflyu5C
        CiNKYzHyRT0fn8DDYKkJ5OvgNR2FQ4aIMDmSo7GoqP/jBNiAugFtPMzooy7q/0Yk
        ovYx9lNzcBIRNdZeJzVLv5WZorEyH9RiqhU18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hqx96y7wcrKq3+RjW1KlQhwzYW091UtT
        sdTGuxLVnoNk0sfMFPf1BbWDWiIaCpefegkcJvJtZcxUAePZPvbkMO/ju2b3EXOL
        EWvur5xeI/zKfZ9JG9xoNwHu5vEXkPVs/t7P6Adwowm1deHwv9Y5iKlXz4O2km5V
        ywNJ3XI156s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B57B2648A3;
        Fri,  3 Mar 2017 14:06:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2688D648A2;
        Fri,  3 Mar 2017 14:06:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Do not require Python for the git-remote-{bzr,hg} placeholder scripts
References: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
        <20170303112104.2n3hu23sajpn2x2z@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 11:06:15 -0800
In-Reply-To: <20170303112104.2n3hu23sajpn2x2z@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 06:21:04 -0500")
Message-ID: <xmqqzih289js.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79F0A59A-0044-11E7-AACB-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 03, 2017 at 10:57:46AM +0000, Sebastian Schuberth wrote:
>
>> It does not make sense for these placeholder scripts to depend on Python
>> just because the real scripts do. At the example of Git for Windows, we
>> would not even be able to see those warnings as it does not ship with
>> Python. So just use plain shell scripts instead.
>
> Yeah, this seems like an obvious improvement. I think we got here
> because the originals issued a warning but kept working, and then it was
> slowly whittled down to remove the "working" part.
> ...
> OTOH, it is not really hurting much, so I do not mind keeping them
> around for another 3 years (or more) just to catch any stragglers.

Yup, let's queue it and remove it in a few years.

Thanks.
