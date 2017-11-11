Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B171F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 14:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdKKOic (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 09:38:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51214 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750818AbdKKOib (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 09:38:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27C53ADC5C;
        Sat, 11 Nov 2017 09:38:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zyzbc6fJz6H1LJYqyXa/r+RlNNU=; b=nwmw4U
        BgEAaRxgB74xtjW5Xf1dWdEHpotPvD0gMSk0ypo19z5/Q4y7qsMReF2kSiQsfO5K
        P5fAxgYUN59VovNisH4fqs9aaKcviLJIS0ZXxX/Y6SCkVONSh4olZ8QALmFOHNbS
        Nnt6FGK3vq12OLoKLQFjdzSP+cCQwUorPrfJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DeJ1AMarrZWysIn6VbEGg4BOUjvzbe7j
        zhVeTUWi5ED88RB48ua1SD9vFX9wRhUcMjh75EheTbvDN49WcGM7eHKVphoy9SvM
        LonTQgtEEXXrSLbn0Li63PRDRRrLrM7pXRrRBMnhx3odzrnxliLQ4tEYYeeNtBg3
        tvEMtr4Xapo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F3DFADC5B;
        Sat, 11 Nov 2017 09:38:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89FCBADC5A;
        Sat, 11 Nov 2017 09:38:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
        <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
Date:   Sat, 11 Nov 2017 23:38:23 +0900
In-Reply-To: <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
        (Christian Couder's message of "Sat, 11 Nov 2017 15:07:55 +0100")
Message-ID: <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F90994F2-C6ED-11E7-B35E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Nov 11, 2017 at 12:42 PM, Robert P. J. Day
> <rpjday@crashcourse.ca> wrote:
>>
>>   the man page for "git bisect" makes no mention of "git bisect next",
>> but the script git-bisect.sh does:
>
> Yeah the following patch was related:
>
> https://public-inbox.org/git/1460294354-7031-2-git-send-email-s-beyer@gmx.net/
>
> You might want to discuss with Stephan (cc'ed).

Thanks for saving me time to explain why 'next' is still a very
important command but the end users do not actually need to be
strongly aware of it, because most commands automatically invokes it
as their final step due to the importance of what it does ;-)

