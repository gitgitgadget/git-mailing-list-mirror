Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B018C001DB
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjHCQBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjHCQBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 12:01:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB53A9A
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 09:00:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93DAD199F57;
        Thu,  3 Aug 2023 12:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h/YvB6HpSD+y
        HkF4jwakgKlYGvQyOI53syAu/ENZa7Y=; b=lHmGjWYCHwyi/OwBQV+Ouk+zS8QS
        rCrndqLWXhNVsSpbry5StD1HYtsk7PYV9mhexU/HtwwnIl1RgB7hEIjxUDPhmECm
        PI7vRnF9SRYhBU63vs4tExIM5v4tyIqlIqJlDuWCZbAp++R73wF/HgWEKu9ktPhv
        B+WWuJ7Rnkrs0Lc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 890B3199F55;
        Thu,  3 Aug 2023 12:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAFFD199F53;
        Thu,  3 Aug 2023 12:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH 0/3] git bisect visualize: find gitk on Windows again
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 09:00:49 -0700
In-Reply-To: <pull.1560.git.1691058498.gitgitgadget@gmail.com> ("Matthias
        =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Thu, 03 Aug 2023
 10:28:15
        +0000")
Message-ID: <xmqqo7jo5d5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB167028-3216-11EE-A6CB-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> Louis Strous reported a regression in git bisect visualize on Windows[1=
]
> that caused git bisect visualize to use git log instead of gitk unless
> explicitly called as git bisect visualize gitk.
>
> This patch series fixes that regression.

Wonderful.  It would be nice to describe where in the release
sequence the "regression" happened, if we know it.  Perhaps you've
written about it in one of the patches?  We'll find out.

Thanks again.


> [1]
> https://lore.kernel.org/git/VI1PR10MB2462F7B52FF2E3F59AFE94A7F500A@VI1P=
R10MB2462.EURPRD10.PROD.OUTLOOK.COM/
>
> Matthias A=C3=9Fhauer (3):
>   compat: make path_lookup() available outside mingw.c
>   run-command: teach locate_in_PATH about Windows
>   docs: update when `git bisect visualize` uses `gitk`
>
>  Documentation/git-bisect.txt |  6 +++---
>  compat/mingw.c               | 20 ++++++++------------
>  compat/mingw.h               |  6 ++++++
>  run-command.c                |  8 ++++----
>  4 files changed, 21 insertions(+), 19 deletions(-)
>
>
> base-commit: fb7d80edcae482f4fa5d4be0227dc3054734e5f3
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1560%=
2Frimrul%2Fwin-bisect-visualize-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1560/rim=
rul/win-bisect-visualize-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1560
