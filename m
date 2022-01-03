Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A916C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiACPom (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 10:44:42 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:3963 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbiACPom (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 10:44:42 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JSKn40mfnz5tlD;
        Mon,  3 Jan 2022 16:44:40 +0100 (CET)
Message-ID: <0f7e3f12-9869-db9f-db27-0d13862a4233@kdbg.org>
Date:   Mon, 3 Jan 2022 16:44:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 02/11] i18n: refactor "%s, %s and %s are mutually
 exclusive"
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        git@vger.kernel.org
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
 <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
 <e307ea9b998f77d9b2e3c3ce37a510a9e5686949.1641143746.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <e307ea9b998f77d9b2e3c3ce37a510a9e5686949.1641143746.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.01.22 um 18:15 schrieb Jean-Noël Avila via GitGitGadget:
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 9a520485769..27b60732a22 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -503,7 +503,7 @@ static int add(int ac, const char **av, const char *prefix)
>  	opts.checkout = 1;
>  	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
>  	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
> -		die(_("-b, -B, and --detach are mutually exclusive"));
> +		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");

As the range-diff in the coverletter shows, you fixed the missing blank
after the comma in a lot of cases. This one slipped through. Not worth a
re-roll on its own, IMO.

-- Hannes
