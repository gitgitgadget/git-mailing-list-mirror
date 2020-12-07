Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258DC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270702389F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLGSjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:39:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59483 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGSju (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:39:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 695B4AD72E;
        Mon,  7 Dec 2020 13:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kvj4DZwPdlT+K6cy6G3glrAMtWw=; b=kydPc1
        ckM4cA5k1/VqTWahuxdRWJakUCTBX4DctKL6qU2mbmcYZLN+W+FCK4t8iCu4ZVdC
        jovWBVJHs3yk1+BArkxFrPZ0grpGJQfEYFK8W2q1Heo/NlYi5yfapnx0RJw010g2
        tKMbV20hPcSj0HrQcyHYoBVT/Fuuw4ktmaK+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=POnQkjU/+ACieX9DCBRMnMRJAZ4raLuZ
        ijoSoD3f9LgbKJTTWrrAPDA/kaG7aRKkvy72x68y7k505lGJTc6g6VjM1KuuD2tA
        nwEi1sanlCAUjuysbz+Lh1owvIftaqLQSDfMqCdqf3Mhf+/X3FmsLSL68/ei3Iz8
        ZL3xwoPHhkQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F04BAD72D;
        Mon,  7 Dec 2020 13:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3421AD72A;
        Mon,  7 Dec 2020 13:39:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        Sangeeta Jain <sangunb09@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5310: stop expecting the default branch name `master`
References: <pull.809.git.1607260623935.gitgitgadget@gmail.com>
        <xmqqim9dbh17.fsf@gitster.c.googlers.com>
Date:   Mon, 07 Dec 2020 10:39:06 -0800
In-Reply-To: <xmqqim9dbh17.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 07 Dec 2020 10:35:48 -0800")
Message-ID: <xmqqeek1bgvp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D5CC278-38BB-11EB-857E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>>     This one goes on top of tb/pack-bitmap, and requires an update of
>>     js/default-branch-name-tests-final-stretch (it no longer needs to
>>     hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).
>
> As the targetted topic is not in 'next' and marked with "Needs a bit
> of reshuffling?", I'd appreciate this patch to be also forwarded so
> that I do not have to worry about it myself.
>
> The same goes for <pull.809.git.1607260623935.gitgitgadget@gmail.com>
> which currently sits at the tip of tb/pack-bitmap.

Oops--wrong branch info.  I meant the patch in
<pull.811.v2.git.1607354380671.gitgitgadget@gmail.com> that is
targetted for the "git diff" stuff.

>
> Thanks, both.

