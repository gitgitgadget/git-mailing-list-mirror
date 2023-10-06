Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E2CE9413A
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 23:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjJFX27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 19:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFX26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 19:28:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313293
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 16:28:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61B5828864;
        Fri,  6 Oct 2023 19:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=gQLETBgiFm6IsxBpV+n3TvQOmwBms9+EMRFadJ
        92OGc=; b=dlt5Wo6vcUGULEStxRWoCfpIPQ6GFO6bKaZSc95qgovWpiedWHj+AD
        elk5KYF1SPRyKqTeKDw59IwI2XKf4Ic3LJLGVTiDqoReIcsdx/StYBfDjzrN0bKx
        w+DPDtdmbmgJVu55pXR+7Pvw/uQP3bVJsdEBxkxSxHkZ0IxugRQX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59BEB28863;
        Fri,  6 Oct 2023 19:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC12628862;
        Fri,  6 Oct 2023 19:28:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [OUTREACHY] Permission To Work On Tasks
In-Reply-To: <CACS=G2zsJxP+NWuosZyrFGctJptHNYTrULErRo_Ns41KeMuMqA@mail.gmail.com>
        (Naomi Ibe's message of "Fri, 6 Oct 2023 23:41:35 +0100")
References: <CACS=G2zsJxP+NWuosZyrFGctJptHNYTrULErRo_Ns41KeMuMqA@mail.gmail.com>
Date:   Fri, 06 Oct 2023 16:28:52 -0700
Message-ID: <xmqqr0m75o0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CF63D2E-64A0-11EE-8D77-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naomi Ibe <naomi.ibeh69@gmail.com> writes:

> First issue is here https://github.com/gitgitgadget/git/issues/635 ,
> involving changing the "die()" error msg outputs to all lowercase. I
> found a few files here https://github.com/git/git/tree/master/builtin
> where the "die()" error msg had some uppercase in them (add.c in lines
> 185, 203, 205, 211 and 571) (branch.c in lines 521, 525, 581, 597,
> 599, 627, 629, 643, 650, 652, 776, 926, 954 and 968). If I'm allowed
> to work on this issue, how many files should I edit? The last closed
> issues related to this issue had edited five files.

As the "general microproject information" page says, it is a good
idea to do just one quality-focused microproject per applicant.

If I were on the receiving end to review such a patch, I would
probably find it is too boring a burden if it had several unrelated
commands covered by a single patch, and would stop reading in the
middle.

If I were on the sending end to work on them for real (not as "dip
my toe in the water and say hello to the more experienced
developers" exercise), I would probably prepare a series of patches,
one for each git subcommand (e.g. "add", "branch", "log", etc.), and
for shared infrastructure files, one for each subsystem that they
are part of (this is harder to do for a new person who do not know
what subsystems exist, and which files implement which subsystem),
but for a microproject, I would say a single file under builtin/*
hierarchy would be a good size.

> Second issue is this https://github.com/gitgitgadget/git/issues/302 .
> Is it still available to be worked on? I notice it was opened in 2019

Stepping back a bit, do you agree with what the issue says?
Remember, these "issue"s are merely one person's opinion and not
endorsed by the community.

Before you ask "is it still available", do you know the current
status (not the status of the "issue")?  Have you looked at "git
commit --help" to find it out yourself to see if "now" is singled
out?  Here is what we say in our documentation:

    In addition to recognizing all date formats above, the --date
    option will also try to make sense of other, more human-centric
    date formats, such as relative dates like "yesterday" or "last
    Friday at noon".

So apparently it is still "available".  It is a different matter how
well a patch that adds "now" to the examples listed there will be
accepted, though.  During a microproject, one of the things new
contributors are expected to learn is to convince others the cause
of their patches with the proposed commit log message well.

Finally, you do not need to obtain permission to work on anything
around here.  You work on what interests you, send the result (or
send request for help, to which others may offer advices if the
problem you are solving looks interesting) to be reviewed, and will
be thanked for working on it when your patch is applied.  To avoid
duplicated work, you might want to say "I'm interested in doing
this, but is anybody already doing it?  If so I'll avoid stepping on
their toes", but otherwise, you are expected to go wild on your own
;-)

Have fun.
