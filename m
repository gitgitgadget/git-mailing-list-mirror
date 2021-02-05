Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DDEC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EAB64E51
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhBESOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:14:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51901 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhBESN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 13:13:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 475CB95DB1;
        Fri,  5 Feb 2021 14:55:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/AoumrkD0HLK/K7usehIc5oBmMw=; b=d7Unvq
        u5PhsvcwmsiF4NeafFQtMuSo8WSDOzcLw5TavhErUbz00BQUEvLTavkIOnYtvUyx
        VvxyJmGO7dQGbjHEQGtR1Z0Ax9p3OILQrt8xzx2nlyDiytZSeBomna4WSDR+btN0
        0OXNCDoz0X2adfsBIj9vEG/5Mm4F9Owz/k+4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qQucUuPXTVN9yU4xjpiQR9VDu+IjXD6d
        evpbYZZ7wxhgOJBQHYIWDVmZS0qDURySF/qMwPrkMpvuMkjYNnf4pF7EqXiwROlB
        8nMkOraEz/qfelFeT7DoLcRF2/yIOu00ssFOdj9mcfhQCLL06/FGAwafqdBuxdAL
        bhXL0zhRhX0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EFA995DAF;
        Fri,  5 Feb 2021 14:55:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5BF595DAD;
        Fri,  5 Feb 2021 14:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: candidate branches for `maint`, was Re: [PATCH v2 00/14] Simple
 IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <xmqq5z3bjuqs.fsf@gitster.c.googlers.com>
        <1be67634-4188-9ef3-306c-72b78ea856b5@jeffhostetler.com>
        <nycvar.QRO.7.76.6.2102030003300.54@tvgsbejvaqbjf.bet>
        <xmqqmtwj647t.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2102051356210.54@tvgsbejvaqbjf.bet>
Date:   Fri, 05 Feb 2021 11:55:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102051356210.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 5 Feb 2021 14:19:19 +0100 (CET)")
Message-ID: <xmqq35ya1e84.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F1E75A2-67EC-11EB-A48E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Are there other topics that deserve to be in 'maint' that are
>> "obviously correct" people can think of?
>
> I looked over the branches merged into `master` that are not in `maint`,
> and from a cursory look, these seem to be good candidates:
> ...
> There are also a couple test updates that might be nice to have in
> `maint`:
> ...
> Finally, there are documentation updates that I would probably merge, if I
> was tasked with updating `maint`:
> ...


Your list more or less matches what the ML (merge later) script on
the todo/ branch produces when it is fed the RelNotes (the script
just greps for "merge laster to maint" comments and shows the result
in way a bit easier to use for me).

The ones that are in RelNotes but not in your list are 

    ab/branch-sort # 7 (11 days ago) 
    ar/t6016-modernise # 1 (3 weeks ago) 
    dl/p4-encode-after-kw-expansion # 1 (3 weeks ago) 
    fc/t6030-bisect-reset-removes-auxiliary-files # 1 (4 weeks ago) 
    ma/doc-pack-format-varint-for-sizes # 1 (3 weeks ago) 
    ma/more-opaque-lock-file # 5 (11 days ago) 
    ma/t1300-cleanup # 3 (3 weeks ago) 
    zh/arg-help-format # 2 (3 weeks ago) 

and I think all of them are safe to merge down.

Thanks for being an independent source I can rely on to sanity check
what is in RelNotes.  Very much appreciated.


