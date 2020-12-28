Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B8AC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4CC229C4
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgL1LbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:31:03 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:5084 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgL1LbC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:31:02 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4D4Fhr67lnz5tlC;
        Mon, 28 Dec 2020 12:30:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1D48420EE;
        Mon, 28 Dec 2020 12:30:19 +0100 (CET)
Subject: Re: [PATCH v8 1/4] mergetool: add automerge configuration
To:     Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <20201228004152.522421-1-seth@eseth.com>
 <20201228045427.1166911-1-seth@eseth.com>
 <20201228045427.1166911-2-seth@eseth.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f9837d51-a0d4-0476-bc5e-8aa8cdb96b8e@kdbg.org>
Date:   Mon, 28 Dec 2020 12:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228045427.1166911-2-seth@eseth.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.20 um 05:54 schrieb Seth House:
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 16a27443a3..7ce6d0d3ac 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -61,3 +61,6 @@ mergetool.writeToTemp::
>  
>  mergetool.prompt::
>  	Prompt before each invocation of the merge resolution program.
> +
> +mergetool.autoMerge::
> +	Remove lines without conflicts from all the files. Defaults to `true`.

This text, starting with "Remove lines", sounds alarming. Isn't it more
along the lines of:

	Consolidate non-conflicting parts, so that only conflicting
	parts are presented to the merge tool. Defaults to `true`.

It would be great to keep the list of config entries sorted. I know that
mergetool.prompt is not at the correct location, but that shouldn't be
an excuse to make the situation worse.

-- Hannes
