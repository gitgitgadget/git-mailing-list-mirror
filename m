Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDABC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiBRTjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:39:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiBRTjT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:39:19 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CAA6A00C
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:39:00 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 532B918DF51;
        Fri, 18 Feb 2022 14:39:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hYNRPYtHCeVNnf1DtwsE7pSDwPY/q69Q3Z7DA3
        xLz5w=; b=valEiMMU5wUVWqm7GRD5pPIAm+ABExj2vptfZyD+GsZJqXl7vnkAVv
        pTfyfuVH0Wys9FMDaEpLw0zNjqN+lNWmkqifbtj9RjV4Eyd2c6yp7KE+Zmusx2Zk
        lrN+TPXQBf4VoyiwN/NlA3v8r1PTVV5WsG4mehdareBGp7hs4pBEk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A98118DF50;
        Fri, 18 Feb 2022 14:39:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 637EF18DF4F;
        Fri, 18 Feb 2022 14:38:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v10 0/4] Add cat-file --batch-command flag
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
        <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 11:38:55 -0800
In-Reply-To: <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 18 Feb 2022 18:23:10 +0000")
Message-ID: <xmqqy228yng0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69452CEA-90F2-11EC-876C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The feature proposal of adding a command interface to cat-file was first
> discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
> before moving forward with a new flag. An RFC was created [C] and the idea
> was discussed more thoroughly, and overall it seemed like it was headed in
> the right direction.
>
> This patch series consolidates the feedback from these different threads.
>
> This patch series has four parts:
>
>  1. preparation patch to rename a variable
>  2. adding an enum to keep track of batch modes
>  3. add a remove_timestamp() helper that takes stdin and removes timestamps
>  4. logic to handle --batch-command flag, adding contents, info, flush
>     commands
>
> Changes since v9
>
>  * add test to exercise format for batch-command
>  * minor semantic improvements
>  * removed README entry for environment variable used in test

Both the changes relative to the previous round and relative to
'master' look good to me.

Thanks.
