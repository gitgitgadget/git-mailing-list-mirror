Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26EC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A34761A10
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhJAVAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:00:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61323 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhJAVAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:00:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91A85153595;
        Fri,  1 Oct 2021 16:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rsm2MAii6/azkV86RVup+ycCp9mO6Y+7mDHuoH
        mKr7M=; b=uZdf/x7FhoVl3WCIxbUJszRWlmbfJLuzA3atDTRf+FGaL2CTM6LoNE
        e86kMJ20Ba2E2GajdDCZhyh2ioQkIRVoanxaJEhVsjOIyVr7uiYqLHqaKZWkX+d9
        +TB8o0I7FvZIzG3Gqsv+l01q7PCYSupWj4ISusrpGtpfMIFXICHjQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A76E153594;
        Fri,  1 Oct 2021 16:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2348D153592;
        Fri,  1 Oct 2021 16:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 04/11] reset_head(): remove action parameter
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <fbaf64d6b282730f91b16ea7d5844fb0e8d779da.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 13:58:51 -0700
In-Reply-To: <fbaf64d6b282730f91b16ea7d5844fb0e8d779da.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:55
        +0000")
Message-ID: <xmqqpmso5uno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61EB224E-22FA-11EC-91C1-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The action parameter is passed as the command name to
> setup_unpack_trees_porcelain(). All but two cases pass either
> "checkout" or "reset". The case that passes "reset --hard" should be
> passing "reset" instead.

Describe how the parameter is meant to be used (presumably "this is
to record in the reflog", perhaps?); without such explanation, it is
hard to either agree or disagree with the claim that "reset --hard"
should be "reset".

Also state if this change is supposed to have any externally
observable effect.

Perhaps this improves what is shown in an error message by affecting
what setup_unpack_trees_porcelain() does?  I am just guessing,
because the proposed log message is not telling.  Please do not make
me (or other readers of "git log") guess.

Thanks.

