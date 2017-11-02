Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984F52055E
	for <e@80x24.org>; Thu,  2 Nov 2017 01:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbdKBBbv (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 21:31:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933083AbdKBBbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 21:31:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A63CDAA929;
        Wed,  1 Nov 2017 21:31:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h/eUswLQxBaGYHK0wQaAPRqdH/Q=; b=yBIXME
        tRiYFKv0glBnG55OOGfV/NEbtpxa0gUtrjFA5EMtuGkBgV9+D7Pn8EAGcQG8thSr
        h75ONAedx+7gv12M7IfM3Vw+J0gYnrZbOnXo52FWC/zq9FaP8NYgsy3sQgL14i6X
        HYduH8I36PM6FaN9kYYFLWbNayK8wK/L8cGF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bqco9fomXiGscTeg9bajcu1DOfdBKl47
        nPDR7vvMBbXuCqOtwC7dWpaHLMvuKPJlX2I4lbEO7dGBFjxf0G6dbbLFtyPeIWlO
        smE9S6sPXLzvjCvTshThN0UsxZjwea/3Iu+KlxvsFB3vMrVcQyRVv1mIDQmBrTr8
        OIG0q4r/SEo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E670AA928;
        Wed,  1 Nov 2017 21:31:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1347AAA927;
        Wed,  1 Nov 2017 21:31:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle redirection
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
        <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de>
        <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com>
        <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
        <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711011726030.6482@virtualbox>
Date:   Thu, 02 Nov 2017 10:31:47 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711011726030.6482@virtualbox> (Johannes
        Schindelin's message of "Wed, 1 Nov 2017 17:37:05 +0100 (CET)")
Message-ID: <xmqqr2thsby4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 989E8FF0-BF6D-11E7-9453-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > I feel this is the wrong way round. `>/dev/null` may sound very intuitive
>> > to you, but this feature is Windows only. Guess three times how intuitive
>> > it sounds to Windows developers to write `>/dev/null` if you want to
>> > suppress output...
>> 
>> It would be just as intuitive to write '2>&1' for dup-redirection,
>
> No. You misunderstand. I was mainly concerned with the `/dev/null`. Every
> Windows developer knows what `>file.txt` means, and many know what
> `2>error.txt` means. But `/dev/null` is not Windows, period.

Actually I did know that much.  

If I was correct in assuming that "2>&1" is just as foreign as
">/dev/null", then we should be shunning "2>&1" just like we shun
">/dev/null".  That was all I meant to say.

Are you saying "2>&1" is just as likely to be known as ">file.txt"
and my assumption of foreignness of "2>&1" was incorrect?

	Side note: would ">NUL" look more familiar, I wonder, and
	can stand for ">/dev/null" for the target audience?

> ... It is so not
> Windows that Git itself translates it to `NUL` (which you Linux die-hards
> won't have a clue about, I would wager a bet).

Ah, you lost your bet.  When can I collect ;-)?
