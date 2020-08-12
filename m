Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F8C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB7220768
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nnmR0zoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHLAat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:30:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62648 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLAas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 20:30:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76CBBF4659;
        Tue, 11 Aug 2020 20:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uaQ8A915KME9C6ovwapmQj4bjmg=; b=nnmR0z
        oe7fa4MB50Dt3X2bbAN6EmHdYmq6SDtu8nD42qm9JKWnPQH/n8dvomYq4WN9mFlb
        1lGtXli88RJSyG0QiwDjnU9/jpLPjOVVkpoJIiZt/7UWAF8ZesBZqwu3WsY84NTJ
        G48qQZbBWYe5oAsjTHYsUIR6h8dd0qmrOwThQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BI0g5LJR+/lZRdrpHhNZKAFgTQsW+l22
        CJ2B5hUe7vk/z9Ctd0dOg5jxYagd3tikyN2TXUad26IQhjJmiRiNAr990lrkzYzy
        cp3YR3DPpMGiH6ALNlrbQ3s1HVJvlIywFiRNehknCwk8n2Gkyuys2a1dpFP1IbO+
        AQJsFkkXDGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F737F4658;
        Tue, 11 Aug 2020 20:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FC73F4657;
        Tue, 11 Aug 2020 20:30:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        <xmqqime69jfc.fsf@gitster.c.googlers.com>
        <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
        <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
        <20200729205846.GA2992025@coredump.intra.peff.net>
        <xmqqv9i6814y.fsf@gitster.c.googlers.com>
        <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
        <xmqq5za596uo.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008101349570.50@tvgsbejvaqbjf.bet>
        <xmqqo8nicxn2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008110430080.50@tvgsbejvaqbjf.bet>
Date:   Tue, 11 Aug 2020 17:30:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008110430080.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 11 Aug 2020 04:39:57 +0200 (CEST)")
Message-ID: <xmqq4kp8903z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DF8E18A-DC33-11EA-B006-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, this might be overkill, and a bit more complicated to implement,
> as we now would also have to allow "negative" patterns.

Somebody may want to teach negative patterns to merge.suppressDest,
so the implementation complexity in the end would not be all that
different in the end, when that future happens.  But until then, I
tend to agree with you that it may be simpler if the matched ones
are suppressed than mentioned (iow, the configuration variable,
merge.suppressDest, would be simpler to manage than your
hypothetical merge.mentionDest whose polarity is opposite).

That is primarily because I expect that the common usage patterns
are the following three:

 - mention destination of merges into any and all branches;

 - mention destination of no merges;

 - mention destination of merges into all branches except for the
   primary integration branch.

A configuration variable with either polarity would express the
first two equally well, but the last one (which is the primary use
case for continuity reasons) is easier to express with suppressDest.

With mentionDest, you'd need two entries, i.e. 'all', and 'not this
one', so you'd need a negative matching from the get-go.  So from
the point of view of end-user usability, not ease-of-implementation,
I think Peff picked the right polarity in his suggestion.
