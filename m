Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD3DC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5421824649
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RJ0DjB2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgBNPDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:03:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50682 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgBNPDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 10:03:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AC6745E9A;
        Fri, 14 Feb 2020 10:03:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K37wikhh9NelTt+E+3qkeNVne3M=; b=RJ0DjB
        2WInzFWghnPVyHFamepX8zuv1g7UEyPMIaWUw9+GQoVUBjxoDpywHElKKzduGb0b
        8hhXQKFYgmcdYnrlPG9upsw1NDaUDHn06ivIhnryfj67qLkQfb01EOZhESWmBtbE
        ua3JjusiGYzK3XE6lKqjhWyIPZ5qX+GfNyn3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EW2pK4yrZofRMppnxNvJw1hpXO9H2Ogu
        2RyeFFOivQRhIv56SAlLtSkSEtevZbaOuRug8KEt9+GWEZeQkJyby3CDs9eF8hTJ
        lDhcot4tSt4yYB9t9zG36x3iQD5mwa/qZRRJcN32I9+kXAu6UlmbgaWYIvfBLOLj
        rr8GsHIlvEM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A6445E99;
        Fri, 14 Feb 2020 10:03:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B08AD45E98;
        Fri, 14 Feb 2020 10:03:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
        <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002141252050.46@tvgsbejvaqbjf.bet>
Date:   Fri, 14 Feb 2020 07:03:35 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002141252050.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 14 Feb 2020 12:59:06 +0100 (CET)")
Message-ID: <xmqqpnehp5x4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D26B7D8-4F3B-11EA-9615-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Can patch 3/3 be split into two,
>
> I actually don't think so. The `refs_resolve_unsafe()` function simply
> ...
> In other words, a fix for one bug would be a fix for the other, and
> (probably) vice versa.

What mislead me was the way this step presented itself.  It sounded
as if the primary (and possibly the only) thing the series wanted to
fix was to make .denyCurrentBranch pay attention to other worktrees,
and while fixing that, it broke as collateral damage a "feature"
that denyCurrentBranch allows an unborn branch to be updated no
matter what and called it a bugfix when it was not a bug.

If the series is fixing two bugs, perhaps 2/3 can first fix it for a
primary worktree case by seeing what HEAD symref for the primary
worktree points at is the target of a push without iterating over
all the worktrees, have the test change in 2/3 (i.e. "fixing the
'unborn' case revealed a wrong expectation in an existing test"),
and a couple of new tests to see what a push from sideways would do
to an unborn branch that is checked out in the primary worktree when
.denyCurrentBranch is and isn't in effect.

Then 3/3 can use the same logic to see if one worktree is OK with
the proposed ref update by the push used in 2/3 (which no longer
uses refs_resolve_unsafe()') to check for all worktrees.  The new
tests introduced in 2/3 would be extended to see what happens when
the unborn branch getting updated by the push happens to be checked
out in a secondary worktree.

That would have avoided misleading this reader.

Thanks.

