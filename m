Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3951C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 21:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjH2VwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbjH2VwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 17:52:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF402CDA
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 14:51:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BA6C2D380;
        Tue, 29 Aug 2023 17:51:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h56dEs4Bs43U+SYXXm0AqxqeiVNYY0H8Anm7B+
        K143M=; b=qLSIiQ55AHFDEhSA/VuJjJYrdZhsR7V9Uoihy9jBYKNfhDpIsBggLA
        VfGn9MkbJIJrn+cDn1dCaAz8JnQ0tM0zFhnZ8rORkz6/Xn4jxMeC7TA3eYwMSD5/
        5ItR553XAmb8NjD7kp9hx3Dlwbu+1cUNkNmtSvrXn4R+5Em1+XwmU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53C582D37F;
        Tue, 29 Aug 2023 17:51:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEF932D37D;
        Tue, 29 Aug 2023 17:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci(linux-asan-ubsan): let's save some time
References: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
        <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com>
Date:   Tue, 29 Aug 2023 14:51:43 -0700
In-Reply-To: <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 29 Aug 2023 20:47:28
        +0000")
Message-ID: <xmqqjztdcya8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EF4ED38-46B6-11EE-863B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ...
> In fact, it is not even just `git-p4` that is the problem (even if it
> flakes often enough to be problematic in the CI builds), but really the
> part about Python scripts. So let's just skip any Python parts of the
> tests from being run in that job.
>
> For good measure, also skip the Subversion tests because debugging C
> code run via Perl scripts is as much fun as debugging C code run via
> Python scripts. And it will reduce the time this very expensive job
> takes, which is a big benefit.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> ...
>     Changes since v1:
>     
>      * Made the rationale clearer (it is not Python that flakes, but
>        Perforce).
>      * Touched up the commit message.

Thanks.  Merged to 'next'.
