Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34036C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiCaWlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCaWlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:41:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EAD1C2DAA
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:39:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9C3F115647;
        Thu, 31 Mar 2022 18:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A4OM4+9y7jhGkGgFPwrUGaP0g9jQEQDqcKI5Tp
        mgXjo=; b=ZtkF99QhVvKqm6TJ6RfPKKOVkduVhKe4pIyyRQMTjv40D42J+la8Mh
        Mi1MIIfwNCwcOw8HAwFCcLul8loItVV7BGQzr+G0DafjBFNVJ5DKtAyGGT+Q9lA9
        yH3nsfPgH431c0ynRALyt2GDmo0OroP2NbzStTC+6Xm6qW3Ss5mQU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C094F115646;
        Thu, 31 Mar 2022 18:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33B18115644;
        Thu, 31 Mar 2022 18:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 0/4] branch --recurse-submodules: Bug fixes and clean
 ups
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 15:39:55 -0700
In-Reply-To: <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com> (Glen Choo
        via GitGitGadget's message of "Thu, 31 Mar 2022 18:49:57 +0000")
Message-ID: <xmqq7d89zqys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D276D6A-B143-11EC-929A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thanks for the feedback, all. This version incorporates most of the
> suggestions (which were pretty small anyway).
>
> == Patch organization
>
> Patches 1-2 are bugfixes, 3-4 are clean ups.
>
> Patch 1 fixes a bug where "git branch --recurse-submodules" would not
> propagate the "--track" option if its value was "--no-track" or
> "--track=inherit".
>
> Patch 2 fixes a bug where "git branch --recurse-submodules" would give
> advice before telling the user what the problem is (instead of the other way
> around).
>
> Patch 3 fixes some old inconsistencies when "git branch --set-upstream-to"
> gives advice and when it doesn't.
>
> Patch 4 replaces exit(-1) with exit(1).
>
> == Changes
>
> Since v1:
>
>  * Patch 1: reword the --track comments to be prescriptive
>  * Patch 3: remove a now-unnecessary die(). I didn't include a suggestion to
>    inline the advice string to save reviewers the trouble of proofreading
>    (and the format string has no placeholders anyway, so I don't think we'd
>    get much benefit out of typechecking). We can inline it in another
>    series.

Thanks, but sorry that I've already merged the previous round.  Let
me turn them into incrementals.

