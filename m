Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFE61FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 14:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030692AbdAIObe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 09:31:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51526 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030226AbdAIObd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 09:31:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 585B05B2AB;
        Mon,  9 Jan 2017 09:31:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hZIS6EIYqHJvkUqHfIjfRUXD9vQ=; b=Lb0/EL
        AlI0aR8po7xMXKXaLdb6mvq/Itf3I81ST0pqEjYWQNAaO6DK+HaWIPLBFoVwFjzj
        P2MTn829KgSW9GDbQUXueROlI5hETNLrWdM3pUvyyVhQmW2ka8IYKwcS4rRfEHrX
        GAURR4aCOCPtpHe7OZl6bdToeIPRLAXZYG+as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l2r7VeHtWk2dMgoLfOxpU0JebHVXOiWB
        TwKK7ePZlT3wAb4ZWUcW7O2JLeEH0w8L6mx2xrN6bZOXS2YXPYgWnAf5OMZzSiHR
        HSUbPcvgZmoTGK08gMVbTg+gSkBQ4B6SxcT/kg2ZN45Y5iFZ0rGBH6PuvnMmIxF/
        1Kl9arI7F3Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F3865B2AA;
        Mon,  9 Jan 2017 09:31:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8AAA5B2A4;
        Mon,  9 Jan 2017 09:31:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
References: <20170108061238.2604-1-svnpenn@gmail.com>
        <alpine.DEB.2.20.1701081250580.3469@virtualbox>
        <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>
        <alpine.DEB.2.20.1701081953330.3469@virtualbox>
        <xmqqy3ylx75g.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091127570.3469@virtualbox>
        <xmqq4m18wbo5.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 09 Jan 2017 06:31:30 -0800
In-Reply-To: <xmqq4m18wbo5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 09 Jan 2017 06:27:54 -0800")
Message-ID: <xmqqzij0uwxp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 508AC960-D678-11E6-B0D1-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> In any case, it does not break things, and it helps Cygwin, so: ACK
>>
>> Ciao,
>> Dscho
>>
>> P.S.: I pushed this to Git for Windows' `master`, too:
>> https://github.com/git-for-windows/git/commit/f05a26948b
>
> Hmm, I peeked it hoping that you corrected the log message along the
> lines of your <alpine.DEB.2.20.1701081953330.3469@virtualbox>, but
> it appears that what you queued does not have any extra mention of
> cygwin or specifics of the buildchain on top of what Steven posted?

Ah, false alarm.  It does have s/Windows/Cygwin/; I trust your
judgement that that change makes the context clear enough for those
involved in Git for Windows, msysGit and Cygwin port.

Will queue it together with the other one from Steven.

Thanks.
