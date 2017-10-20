Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D636B202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 05:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdJTFfj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 01:35:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63676 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750985AbdJTFfj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 01:35:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 320D5A3898;
        Fri, 20 Oct 2017 01:35:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jhv0OYmlwuAJ2Xiglp2J90J2Ync=; b=v2QQTl
        1b/aRYwameUt9etypUoJajd2ZLrJBGG9tYvVs5IoZX0R/ouMzPLyK1Y0QKnuLgTM
        OLIxyfAUn34B0yaAN++3Tl/5g3QLUL1kN4NHsT7T67/FVENe8ZmNWibjzFkoRhz9
        Od64oiB4L7ac37hTkVpi0B3+5AaVoJABQGYO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cK1OiFpAo68JIWtra8cCRqpMkccfevDG
        3vt1INyzh4HeY5UvOXGd2tBh8QC6ICPR1bTvue5NOp5Pxwrx95xtcYnsEg8SPdiD
        kkWRg31xTFq4xQqxcmLNJpTkUX1SKhvkpPwWguwgB0x4Gy7zhdwm+yZ7l1yLvEwh
        vr7lJMXf9aM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 287E8A3897;
        Fri, 20 Oct 2017 01:35:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90070A3895;
        Fri, 20 Oct 2017 01:35:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
        <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
        <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
        <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
        <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
        <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
        <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
        <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
        <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
Date:   Fri, 20 Oct 2017 14:35:36 +0900
In-Reply-To: <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Oct 2017 23:05:25 -0400")
Message-ID: <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 808EEA82-B558-11E7-BD97-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> <shrug> It seems weird and inconsistent to me that the meaning of "-h"
> depends on the position and presence of other unrelated options. Maybe
> it's just me. I know _why_ it's that way, but this seems like one of
> those weird corners of the interface that end up confusing people and
> giving Git's interface the reputation of being full of mysterious
> inconsistencies. I suspect one of the reasons nobody has complained
> about it is that "ls-remote" is not commonly used, and "ls-remote -h"
> less so (I didn't even know it was there until this conversation).

Technically, yes, it may be weird.

I may be biased as every time I think about this one, the first one
that comes to my mind is how "grep -h" (not "git grep", but GNU
grep) behaves.  Yes, "-h" means something else, but by itself, the
command does not make sense, and "ls-remote -h" is an exception to
the rule: most sane commands do not have a sensible semantics when
they take only "-h" and nothing else.  And even for ls-remote it is
true only when you try to be extra lazy and do not say which remote
you are asking.

And that is why I think "'cmd -h" and nothing else consistently
gives help" may overall be positive in usability, than a rule that
says "'cmd -h' is for short-help unless -h means something else for
the command".
