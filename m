Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1979920450
	for <e@80x24.org>; Wed,  1 Nov 2017 01:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbdKABVY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 21:21:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58076 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753875AbdKABVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 21:21:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0831BB6DE;
        Tue, 31 Oct 2017 21:21:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aI1w/jb7LnSlCSI82q+CvMx+/I4=; b=HAXlAC
        PDd1Yy+6RJw2b0vtStFMGGF2iT++38nIasZ63e9XzEKQUaAUzcy3zzAcZTnFALMO
        wXwRuKlXS26W6JyTlgc7LdihA/cBjX+totj/f2pULW2zyJMZGiK+qIpwF/v4lsGl
        gLbnd0bGW2Pfc7KI2jfhJjrazPZV8EPL07Pko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oUrWZRoXeBQPlejRGYDQqoA5aYQXJ1cN
        4S5t2RZJUbs4hgkKk5CvI3HeGMmmiuK4hCnOQmpI8c57COLQbMbPqqEaN6sU2j3U
        rAsQHAP5FsjNaXjmfFaPWoeAQUUq90arpO9TMDj5/A3IyVQKC5iEFTpWexK3DetA
        tED7kuxWbmA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97047BB6DD;
        Tue, 31 Oct 2017 21:21:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09A41BB6DC;
        Tue, 31 Oct 2017 21:21:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
        <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com>
        <xmqqtvyg2g6y.fsf@gitster.mtv.corp.google.com>
        <SN4PR2101MB07369D19A150418D5ACB858B8A5E0@SN4PR2101MB0736.namprd21.prod.outlook.com>
Date:   Wed, 01 Nov 2017 10:21:20 +0900
In-Reply-To: <SN4PR2101MB07369D19A150418D5ACB858B8A5E0@SN4PR2101MB0736.namprd21.prod.outlook.com>
        (Jeff Hostetler's message of "Tue, 31 Oct 2017 13:14:08 +0000")
Message-ID: <xmqqd152yesv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8761AA4-BEA2-11E7-ADDE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <Jeff.Hostetler@microsoft.com> writes:

> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
>
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>> 
>>> I've been assuming that the jt/partial-clone-lazy-fetch is a 
>>> placeholder for our next combined patch series.
>>
>> Yes, that, together with the expectation that I will hear from both you and JTan 
>> once the result of combined effort becomes ready to replace this placeholder, 
>> matches my assumption.
>> 
>> Is that happening now?
>
> Yes, I'm merging our them now and hope to have a version to
> send to Jonathan and/or the list sometime this week.

Thanks.
