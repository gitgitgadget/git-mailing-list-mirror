Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A09207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbcI2SFy (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:05:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64692 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934382AbcI2SFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:05:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3860641D5D;
        Thu, 29 Sep 2016 14:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=77psWww5TtCY4Nw0WAA0ylzplIc=; b=NJRu+/
        FSaHmJHziFsKQ57RwdeVvrghCLvwOm88/6G41GRtFoaD2xPZ56fatZSkANkDQSrq
        CH+o9piYj/9uzUPpDXjsiZr9KCB5BLA4/WqYLE34gmXk6dc7dUohTQm8AA09axBw
        RVflLa4fp3wvqe6a0PwrBvlV+u9aaOeHbzYRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WfPA57HcLG8AhkMdpKRl+IUOKpTeMAH0
        SWzA8uU5bVvWUFAvNUmZ0PhUcTFAUJjRCV18E6274lhPpnDXcNXj16ZU6zygXdW/
        2ZzDlaDLEGJRTeEmFPhHqupoBDPG1BqXlba8piJRs7iPvDeG34UV3mUIqAmz3NXO
        cFxJu31ShK8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F11F41D5C;
        Thu, 29 Sep 2016 14:05:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 417A741D5B;
        Thu, 29 Sep 2016 14:05:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, peff@peff.net, torvalds@linux-foundation.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
Date:   Thu, 29 Sep 2016 11:05:34 -0700
In-Reply-To: <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> (Johannes Sixt's
        message of "Thu, 29 Sep 2016 07:58:49 +0200")
Message-ID: <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AB7AC72-866F-11E6-8A63-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.09.2016 um 01:30 schrieb Junio C Hamano:
>> As Peff said, responding in a thread started by Linus's suggestion
>> to raise the default abbreviation to 12 hexdigits:
>
> This is waayy too large for a new default. The vast majority of
> repositories is smallish. For those, the long sequences of hex digits
> are an uglification that is almost unbearable.
>
> I know that kernel developers are important, but their importance has
> long been outnumbered by the anonymous and silent masses of users.
>
> Personally, I use 8 digits just because it is a "rounder" number than
> 7, but in all of my repositories 7 would still work just as well.

Yes, "git log --oneline" looks somewhat different and strange for
me, too ;-)

I am sure I'll get used to it if I keep using it, but I suspect that
I'd be irritated as I find myself typing 'q' more and more often to
"less -S" that is automatically invoked when I do "git log --oneline
master.." to see what commits are on my current topic branch.
