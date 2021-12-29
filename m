Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9799C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhL2ThD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 14:37:03 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:23090 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhL2ThC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 14:37:02 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4JPM9S1RYkz5tl9;
        Wed, 29 Dec 2021 20:36:59 +0100 (CET)
Message-ID: <233ae6c6-294f-f68c-51ca-ec83d25f05dd@kdbg.org>
Date:   Wed, 29 Dec 2021 20:36:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 03/11] i18n: turn "options are incompatible" into
 "cannot be used together"
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        git@vger.kernel.org
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
 <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
 <486cc6c89e2612761bc8835700c9c85c0b50ab55.1640804108.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <486cc6c89e2612761bc8835700c9c85c0b50ab55.1640804108.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.21 um 19:54 schrieb Jean-Noël Avila via GitGitGadget:
> @@ -2867,24 +2867,24 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	compile_grep_patterns(&revs->grep_filter);
>  
>  	if (revs->reverse && revs->reflog_info)
> -		die("cannot combine --reverse with --walk-reflogs");
> +		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "--walk-reflogs");
>  	if (revs->reflog_info && revs->limited)
>  		die("cannot combine --walk-reflogs with history-limiting options");
>  	if (revs->rewrite_parents && revs->children.name)
> -		die("cannot combine --parents and --children");
> +		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
>  
>  	/*
>  	 * Limitations on the graph functionality
>  	 */
>  	if (revs->reverse && revs->graph)
> -		die("cannot combine --reverse with --graph");
> +		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "--graph");
>  
>  	if (revs->reflog_info && revs->graph)
> -		die("cannot combine --walk-reflogs with --graph");
> +		die(_("options '%s' and '%s' cannot be used together"), "--walk-reflogs", "--graph");
>  	if (revs->no_walk && revs->graph)
> -		die("cannot combine --no-walk with --graph");
> +		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
>  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
> -		die("cannot use --grep-reflog without --walk-reflogs");
> +		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");

This last transformation does not fit the topic of this patch. It should
go into patch 6/11, I think.

>  
>  	if (revs->line_level_traverse &&
>  	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))

-- Hannes
