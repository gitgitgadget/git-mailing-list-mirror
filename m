Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41461F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757683AbcIHUeG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:34:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55743 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755265AbcIHUeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A33DF3B4F2;
        Thu,  8 Sep 2016 16:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2XGTGGYjHgOolQpy20pl9KYrEm4=; b=PAwIRv
        tre4becbK/PIHJO6IdCEjMiloIAixRqnFiCP/ahjAHcj9wxXjCo1OggO5HF6Kw4P
        U/kafk2xDVmdrn3gK+vvS9mITZgOY6pryUIQUmWtZgBDHcD2WyaKAflsOqJ+Wk9r
        VnLYgwY8o0LI0rZFZ1n8tbt6OKAVzPQ3zhMn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJZRrvfdRVerMFHbNtT8C5QdUBDRaPFK
        kFqLZGFMl9F1IjMy2+gfN01UKVa/TTHq0AJMS/nBhbcwli+kXyEJu02J4YHGiOvY
        nF+Mwz/Stlzn0SrGaRXaYh36SdUFaeqnaC4+BwjRUAXK/U1tVOz4UNzwPZJxciDR
        5eb36iNK6yY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B75F3B4F1;
        Thu,  8 Sep 2016 16:34:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22F773B4F0;
        Thu,  8 Sep 2016 16:34:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
        <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
        <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>
        <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608311233440.129229@virtualbox>
        <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>
        <alpine.DEB.2.20.1609011027210.129229@virtualbox>
        <CAGdFq_h3UuW7wX0-=SuS22mX_C086HRZZ=i1sYVya80dd+qMYQ@mail.gmail.com>
        <xmqqzinrteql.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609020933430.129229@virtualbox>
Date:   Thu, 08 Sep 2016 13:34:02 -0700
In-Reply-To: <alpine.DEB.2.20.1609020933430.129229@virtualbox> (Johannes
        Schindelin's message of "Fri, 2 Sep 2016 09:35:14 +0200 (CEST)")
Message-ID: <xmqqy432f7wl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9533DA96-7603-11E6-B3A0-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 1 Sep 2016, Junio C Hamano wrote:
>
>> Hopefully that [patch removing the -<pid> suffix] would help making
>> Dscho's "what are the failed tests?" logic simpler.
>
> Of course.
>
> It also makes sure that those 2 hours I spent on writing and perfecting
> the sed magic were spent in vain... ;-)

Well it is either

 * the sed magic is so arcane that you'd need to spend a long time,
   comparable to 2 hours you already spent, if you ever need to look
   at it and figure out what it does next time you need to change
   something in it.

or

 * you are not familiar with the sed magic and you would be able to
   write the same thing in 2 minutes next time if you need to adjust
   it when we add -pid back later.

Either way, those 2 hours are not wasted.

I personally fall into the former category.  Any sed script that
needs G, h, and x together I need to spend at least 15 minutes just
to warm myself up, as I do not work with the language that often.

Thanks ;-)

