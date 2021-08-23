Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340CBC4320E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028B5613A5
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhHWSmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:42:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62076 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhHWSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:42:15 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mIEss-0005Wi-4A; Mon, 23 Aug 2021 19:41:27 +0100
Subject: Re: [PATCH] Make ident dynamic, not just a hardcoded value of "$Id".
To:     Maksym Sobolyev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Maksym Sobolyev <sobomax@gmail.com>,
        Maksym Sobolyev <sobomax@sippysoft.com>
References: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <da4e66ec-0613-a8ba-0b69-cd247fcd457b@iee.email>
Date:   Mon, 23 Aug 2021 19:41:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/2021 17:41, Maksym Sobolyev via GitGitGadget wrote:
> From: Maksym Sobolyev <sobomax@sippysoft.com>
>
> This allows ident to be something like $FreeBSD$ so it provides matching
> functionality for repos migrated from CVS / SVN.
>
> This works by allowing ident to have a parameter, i.e.:
>
> * ident=MyCustomId
>
> In .gitattributes.
>
> Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>
> ---
>     Make ident dynamic, not just a hardcoded value of "$Id".
>     
>     This allows ident to be something like $FreeBSD$ so it provides matching
>     functionality for repos migrated from CVS / SVN.
>     
>     This works by allowing ident to have a parameter, i.e.:
>     
>     * ident=MyCustomId
>     
>     In .gitattributes.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1074%2Fsobomax%2Fpr-custom_ident-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1074/sobomax/pr-custom_ident-v1
> Pull-Request: https://github.com/git/git/pull/1074
>
>  builtin/checkout--worker.c              |  17 +++-
>  convert.c                               | 114 +++++++++++++++---------
>  convert.h                               |   7 +-
>  parallel-checkout.c                     |  11 ++-
>  parallel-checkout.h                     |   8 +-
>  t/t2082-parallel-checkout-attributes.sh |   7 +-
>  6 files changed, 108 insertions(+), 56 deletions(-)
>
> diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c

Should this also include some documentation updates?
-- 
Philip
