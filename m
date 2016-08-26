Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AF81FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 16:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbcHZQEj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 12:04:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56634 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754029AbcHZQEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 12:04:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEEC436963;
        Fri, 26 Aug 2016 12:04:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BVxpl6RLflOdjwo5Qec151mcTpY=; b=QgFqEz
        lkvh9w6hRGBaclcbG2TDU9HS87SDk+qUmgvf0XX0qW7cB4Cbh8fXUEQiMZnuP10e
        EmwHUyiGqnJTpGFd95bhR8iIyCdM3TsEeWMZeEx7cYuHw0yXpb414xJzNej5Wtla
        zXZZps+BiNEygbXVLMnKkD9mX8KVMcYuJX4QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mWdX5mUc8LGc66JYBUn4LtC6C1cGy2li
        XBu9OjSAVmi7mB2Xme1wwMJQet1eWNh6sH3S2tSWpI3APmHvCqXWbezixaN4xDLG
        9E2Uow5Nc7DDe3Dx3uYWClO11gL0DpwrP2mOfXLqYmPwc/KHXhz7PBfR+6VPcOQk
        AByKFeCMkuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6FBD36962;
        Fri, 26 Aug 2016 12:04:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 455C136961;
        Fri, 26 Aug 2016 12:04:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #08; Wed, 24)
References: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608261607050.4924@virtualbox>
Date:   Fri, 26 Aug 2016 09:04:25 -0700
In-Reply-To: <alpine.DEB.2.20.1608261607050.4924@virtualbox> (Johannes
        Schindelin's message of "Fri, 26 Aug 2016 16:09:17 +0200 (CEST)")
Message-ID: <xmqqa8fzjz3q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3AC540A-6BA6-11E6-B670-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 24 Aug 2016, Junio C Hamano wrote:
>
>> * rt/help-unknown (2016-08-18) 2 commits
>>  - help: make option --help open man pages only for Git commands
>>  - help: introduce option --command-only
>> 
>>  "git nosuchcommand --help" said "No manual entry for gitnosuchcommand",
>>  which was not intuitive, given that "git nosuchcommand" said "git:
>>  'nosuchcommand' is not a git command".
>> 
>>  Waiting for the review discussion to settle.
>
> Not only that. For a week now, two of my build jobs have been failing (the
> one testing `pu` verbatim and the one testing Git for Windows' patches
> rebased on top of `pu`) because the test does not actually test what was
> just built, but relies on the Git man pages to be installed.
>
> So it needs more than just the review discussion to settle.

Ah, sorry for being inaccurate.

A topic may not be ready to be merged down to the next integration
branch before being re-rolled.  I say "Waiting for a reroll" when I
saw review comments and responses have produced enough material to
go into a reroll and the ball is in the submitter's court.  While
the review is still ongoing, I just label it differently to as a
reminder to myself that it is premature for me to jump up and down
and demand "Can we have a reroll pretty-please now?"  This was in
that latter kind when I labelled it.

I think the reviews on the topic has settled and I should have
marked it as "Waiting for a reroll", but during the prerelease
period, I do not have time to pay too much attention on things
outside 'master' and fix-up topics that are moving through 'next'
to 'master' aiming to become part of the upcoming release, so the
marking was left behind [*1*].  My bad.


[Footnotes]

*1* It follows that it would not be unusual if the tip of 'pu' does
    not even build during the time.  Being able to test it does not
    contribute much to catching the remaining bug in the release
    candidates and I'd really like to see all of us paying more
    attention to the tip of 'master'.  A statement "With topic X
    that is still in 'next', A works" is not all that interesting
    unless it is accompanied by "And A used to work in the previous
    release, but broken in 'master'." at this point in a development
    cycle.


