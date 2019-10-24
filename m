Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69FC1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 02:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408167AbfJXCGR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 22:06:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61096 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408092AbfJXCGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 22:06:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 262AB3F95E;
        Wed, 23 Oct 2019 22:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bu7G8hQpwOF6NesLko87r/1Sa10=; b=Lyf8lt
        ZDvfVJ8khU0mEhYT6oHTPSiO+CRACfURgUsdoakgREvc/mjXtL2KK7HtMkAFso9T
        HvH/Zs5mdC0GyV5O6NWKjTRDMQiHqdsOfc4gqG/34fx/0NbPX8LcjAWDIs59bruK
        6SrVypf4xSZIf6IoSDaFxo6NC1s1Y0Qt1Z3z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U8JURMOl1f3pSBVGOCj2ArTJgCMHgGar
        ku3j9Mmz0vCr1r8wYuh5420voCYujjXJ/d94d4ytuxUYq6X+FZ6QuKH306jMeg1q
        8JnskVQSB97jaGpdOFH7dNFGuXRWeVdcxYnFDutgVXkBelwvDlFj9mtu96cpuYS9
        EPDmqFjoET0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C68A3F95D;
        Wed, 23 Oct 2019 22:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F3E03F95B;
        Wed, 23 Oct 2019 22:06:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: Moving git-gui development to GitHub
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
Date:   Thu, 24 Oct 2019 11:06:13 +0900
In-Reply-To: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com> (Pratyush
        Yadav's message of "Thu, 24 Oct 2019 01:43:10 +0530")
Message-ID: <xmqqimoehp7u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB8DBA16-F602-11E9-A815-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Arguments in favor of moving to GitHub:
>
> - Easier for new and one-off contributors.

It is uptimately up to you, the maintainer of the project, but
personally I feel "new and one-off" are way overvalued, after
considering if it serves the project and its users better to make it
easier for "new and one-off" contributors, or if it serves these
"new and one-off" contributors more than it benefits the project and
its users.

A quick rule of thumb I use is that it is worth spending my time on
training a new contributor (with hand-holding on workflows,
conventions, etc.) if it takes less than 3 times of effort compared
to doing the task myself (if I had infinite amount of time, that is)
for the first few topics the contributor works on.  You can usually
tell good ones after a few e-mail exchanges---their brilliance shine
through, even before they become familiar with particular conventions
of the project.

> - We reduce the noise on the Git list. Most people subscribed to the 
>   list probably don't care about git-gui. So all git-gui related emails 
>   are essentially noise for them. And while the volume has been 
>   relatively low, it is not negligible.

As long as the subject is marked clearly that the discussion is
about git-gui, it is easy to skip such an e-mail thread if a reader
is not interested in it.

This is related to the "we lose the audience" item on the other
list, but as a project that consumes the product of the git-core,
the needs of git-gui developers are of interest to git-core
developers.  If I am not mistaken, I think the recent topic about
logs/HEAD.lock by Dscho was to support what he's doing with git-gui,
and what the particular git-gui topic wanted from us happened to be
simple enough that we didn't have to dig too deeply the consumer
side in order to decide if the changes to git-core made sense, but
that may not always the case.

With a git-gui developer who is less experienced with git-core than
Dscho, it would be entirely plausible that the developer would try
to solve an issue on git-gui side with a lot more effort than
necessary because the developer is not familiar with git yet, and it
may turn out that it can be achieved easily with much less effort on
the git-gui side if we made a minimum and generic change on git-core
side.  The other way around is also possible; an inexperienced
git-gui developer may dream that miracles would solve an issue at
hand, and expect that git-core side may bend over backwards to
support an unreasonable one-off feature, which may never happen.
