Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A4C4332F
	for <git@archiver.kernel.org>; Wed, 11 May 2022 19:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbiEKTl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347160AbiEKTlU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 15:41:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1232EE1
        for <git@vger.kernel.org>; Wed, 11 May 2022 12:41:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02CE912AEB5;
        Wed, 11 May 2022 15:41:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BAQTzoQi/FdGsT9DchlO8ZRVdKa+MEWRCtBsex
        f1wu8=; b=s+MR3+T5qU1mfzGPxi2RKxV2EP2ZhCCzrVEQifXDA0+Ig9k8KVkNYb
        k2FuHOT4UShyR4rnWnDT4hJGN4jLuq+UGdLJVqCiX000fBSfRrN7xxI4IbJtJCrn
        irgsuHNonkYrQk2k5MnXQ03PNQrhdxqG3uen+3QGv5aR4Wig1NZSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEC6212AEB4;
        Wed, 11 May 2022 15:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 642F912AEB3;
        Wed, 11 May 2022 15:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] bisect: status improvements when bisect is not
 fully fleshed out
References: <cover.1652291688.git.chris@chrisdown.name>
Date:   Wed, 11 May 2022 12:41:15 -0700
In-Reply-To: <cover.1652291688.git.chris@chrisdown.name> (Chris Down's message
        of "Wed, 11 May 2022 19:00:04 +0100")
Message-ID: <xmqqv8ubkgbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52977538-D162-11EC-A484-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Down <chris@chrisdown.name> writes:

> When bisecting, we currently don't output anything before bisection
> starts in earnest, which can result in some confusion. For example, in
> the case illustrated in the first commit in this patch series, it's
> trivial to accidentally misspell a tag or branch and accidentally end up
> in an unintended state with no clear indication about what happened.
>
> This patch series makes it so that we give information about bisect
> state even before the bisect is ready to begin. We also store these
> changes in state to the bisect log.
>
> v2:
>
> - Move to improve bisect output overall, instead of just warning for the
>   specific unintended pathspec case.
>
> v3:
>
> - Fix test indentation
> - Rename bs to state
> - Use `unsigned int' for nr_{good,bad}
> - Pass the bisect state struct as an argument into bisect_print_status
> - Zero-initialise bisect_state directly, don't use memset()
> - Fix multiline comment style in bisect.h
> - Use strbuf in bisect_log_printf
> - Change `git bisect log' use an output file in tests instead of piping

Will replace.  Unless there are more inputs, let's merge it to
'next'.  This round looks more than good enough to me.

Thanks.  
