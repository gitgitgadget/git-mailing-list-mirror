Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE21DC2BB9A
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B181B239FC
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgLQTX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:23:56 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:49677 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgLQTX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:23:56 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4CxhjY11zJz5tlB;
        Thu, 17 Dec 2020 20:23:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 045FE4163;
        Thu, 17 Dec 2020 20:23:11 +0100 (CET)
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <5fdb1687825e9_d35b620855@natae.notmuch>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <deb42d8a-1ac6-7100-eba9-d75f7c8ba0d8@kdbg.org>
Date:   Thu, 17 Dec 2020 20:23:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <5fdb1687825e9_d35b620855@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.20 um 09:27 schrieb Felipe Contreras:
> Johannes Sixt wrote:
>> I'm mostly using WinMerge these days, and it can do what your patch
>> does all by itself.
> 
> Really? Because under Wine it doesn't look like it:
> 
>  1. Before: https://snipboard.io/8JA5Oz.jpg
>  2. After: https://snipboard.io/HUXnOg.jpg

These show 3 panes, while mine shows only 2. And I think I know why:

First, I seem to use an older version of WinMerge that does not support
3-way diffs.

Second, I only run the merge tool via Git GUI, and it has its own tool
drivers and completely bypasses git-mergetool. In particular, it invokes
WinMerge in a way that it auto-merges the non-conflicted parts, whereas
(the unpatched) git-mergetool does it differently such that it shows
many more differences in the same merge situation.

-- Hannes
