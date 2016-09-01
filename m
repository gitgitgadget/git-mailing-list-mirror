Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703E81F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbcIAWwX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:52:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752092AbcIAWwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:52:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60954381A9;
        Thu,  1 Sep 2016 18:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JLZi5wYdsFlZLzjPHqYP/VpEzH8=; b=qkYpZ4
        Xrr7CiAt+WCYf063v3WmIUjpEsdHingAOLj84I9SV5EbUS7v30Gt/golgLxVhA7b
        f7rGt9YXpt8GQKG1/duPwlKG1dY1smTId6HACEoc/LKfgJy116lH0W9hva7uEM+l
        fCvOW7lX6PwrMoAifLHLKewSBN5zEQGfqeAf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wDi/KHFXC2sCnxXsbgdjLfwYMABwCwVy
        eBxfLjCz+8mTYZyU5+eIvGuZClx/s3jWSZBcVSTdzGt5dSwCmcnkexkpJEAAjhqE
        Lf/je8i+eO2wy9Ipi3CR39gcWr3r1O4Lvn2x1UAJtpGqt+tD8DB3F3eaS2oI++rX
        Ltf+4ejIWrs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 598A2381A8;
        Thu,  1 Sep 2016 18:52:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9C17381A6;
        Thu,  1 Sep 2016 18:52:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sverre Rabbelier <srabbelier@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
        <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
        <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>
        <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608311233440.129229@virtualbox>
        <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>
        <alpine.DEB.2.20.1609011027210.129229@virtualbox>
        <CAGdFq_h3UuW7wX0-=SuS22mX_C086HRZZ=i1sYVya80dd+qMYQ@mail.gmail.com>
Date:   Thu, 01 Sep 2016 15:52:18 -0700
In-Reply-To: <CAGdFq_h3UuW7wX0-=SuS22mX_C086HRZZ=i1sYVya80dd+qMYQ@mail.gmail.com>
        (Sverre Rabbelier's message of "Thu, 1 Sep 2016 09:57:04 -0700")
Message-ID: <xmqqzinrteql.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD8F3E08-7096-11E6-94C5-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sverre Rabbelier <srabbelier@gmail.com> writes:

>>> I can't really recall, but I think it may have been related to me
>>> doing something like this:
>>> 1. Make a change, and start running tests (this takes a long time)
>>> 2. Notice a failure, start fixing it, leave tests running to find
>>> further failures
>>> 3. Finish fix, first tests are still running, start another run in a
>>> new terminal (possibly of just the one failed test I was fixing) to
>>> see if the fix worked.
>>>
>>> Without the pid, the second run would clobber the results from the first run.
>>>
>> Would present-you disagree with stripping off the -<pid> suffix, based on
>> your recollections?
>
> No objections, I think it should be fine. If anyone uncovers a
> particularly compelling reason later on, it's only a commit away :).

OK, especially with the earlier observation made by Peff in the log
message:

    ... we can see that other files we write to test-results (like
    *.exit and *.out) do _not_ have the PID included. So the
    presence of the PID does not meaningfully allow one to store the
    results from multiple runs anyway.

even if we wanted to, keeping the current code with suffix is not
sufficient, so I suspect it won't be just "a commit" away, but we
should be able to lose it for now.  Hopefully that would help making
Dscho's "what are the failed tests?" logic simpler.

Thanks.

