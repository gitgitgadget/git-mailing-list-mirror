Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11D61F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfFLQzZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:55:25 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:17917 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfFLQzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:55:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PCfg1zLMz5tlG;
        Wed, 12 Jun 2019 18:55:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C3A7E20A5;
        Wed, 12 Jun 2019 18:55:22 +0200 (CEST)
Subject: Re: rebase drops patches that have since been reverted
To:     Shawn Landden <slandden@gmail.com>
References: <CA+49okrxjv63UQfQ1fMt6xC95Pjz2wuZu70WMS94vukTHevEaw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <2033f2fe-cc01-d7a6-bac3-4ba982a68425@kdbg.org>
Date:   Wed, 12 Jun 2019 18:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+49okrxjv63UQfQ1fMt6xC95Pjz2wuZu70WMS94vukTHevEaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.06.19 um 17:03 schrieb Shawn Landden:
> If a patch has been applied upstream AND THEN reverted, rebase still
> drops the patch, requiring the use of relative rebase git rebase -i
> HEAD~5 et cetera.
> 
> git rebase should detect reverts as well.

You have the same patch that upstream has. Perhaps you cherry-picked it
from them, or they cherry-picked it from you. In any case, they thought
the patch was a good one.

Later upstream found a problem with the patch and decided to revert it.
Certainly, they didn't do this just for fun; they had a good reason.

Now you are rebasing against upstream. IOW, you are accepting the
authority of the upstream code. Then, why on earth would you not want to
accept their authorative word that the cherry-picked patch was bad and
needed to be reverted?

If you later find out that your patch is definitely needed, then it is
on you to prove that, for example, by including it again in your patch
series. That must be an explicit decision on your part, not an accident
that happens.

TLDR: Git worked as designed.

-- Hannes
