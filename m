Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217C61FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbcLEUgZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:36:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57399 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752110AbcLEUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:36:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3147454FD4;
        Mon,  5 Dec 2016 15:36:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MjPYcbK1KjL6LlaYPJz9djeKY4=; b=dDi2qt
        /Rl8jja3R9W4EwfAy50k75TVJPkPBPKno9RH7lp5+ngtSxwhdBnHwzSV4QHsFwPn
        AyTIsO5+pi7ekKLf/X+lalFS+bzl25tjKxHoH/j5SuI26IRsSHm6L5tXesR1dexU
        72XAreXkIl2om1TOFqDxRPQMZvV70d0RSape8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QDPgJ3uAaXIzwpKT/84Ty3g8hPvSKD3d
        q9B9baCODdTE2a+bTDVOXGDq8FVJBSYiLvxT/ppNXgp70IMzi+70zGU1Zxo/ybqd
        sR59uRgOnwieEH9TEFpt4+dOWy2c9Mu6+CmOYH9mcsbVioDkNkWr5VhIdVpIZ0zX
        0OQLIwnAy2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27BB454FD3;
        Mon,  5 Dec 2016 15:36:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CDEB54FD2;
        Mon,  5 Dec 2016 15:36:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH] commit: make --only --allow-empty work without paths
References: <20161202221513.GA5370@inner.h.apk.li>
        <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net>
        <20161203065949.GG19570@inner.h.apk.li>
        <20161203162318.uv27n4uhylobegto@sigill.intra.peff.net>
Date:   Mon, 05 Dec 2016 12:36:19 -0800
In-Reply-To: <20161203162318.uv27n4uhylobegto@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 3 Dec 2016 11:23:18 -0500")
Message-ID: <xmqqh96i3ygs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AEAAC7A-BB2A-11E6-BFE2-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Dec 03, 2016 at 07:59:49AM +0100, Andreas Krey wrote:
>
>> > OK. I'm not sure why you would want to create an empty commit in such a
>> > case.
>> 
>> User: Ok tool, make me a pullreq.
>> 
>> Tool: But you haven't mentioned any issue
>>       in your commit messages. Which are they?
>> 
>> User: Ok, that would be A-123.
>> 
>> Tool: git commit --allow-empty -m 'FIX: A-123'
>
> OK. I think "tool" is slightly funny here, but I get that is part of the
> real world works. Thanks for illustrating.

I am not sure if I understand.  Why isn't the FIX: thing added to
the commit being pulled by amending it?  Would the convention be for
the responder of a pull-request to fetch and drop the tip commit?

