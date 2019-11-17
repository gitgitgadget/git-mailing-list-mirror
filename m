Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278471F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfKQMac (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 07:30:32 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:44059 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfKQMac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 07:30:32 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47GBJ54VSKz5tlB;
        Sun, 17 Nov 2019 13:30:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C10C8431;
        Sun, 17 Nov 2019 13:30:28 +0100 (CET)
Subject: Re: working directory status
To:     Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
 <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org>
Date:   Sun, 17 Nov 2019 13:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.19 um 12:07 schrieb Sivanandan Srilakshmanan:
> Hi Pratyush,
> 
> Thank you so so so very much for responding quickly. I am learning git
> to assist my teams skill up on git.
> 
> My current version is v2.23.0 which I downloaded and installed a month
> ago. Nevertheless, I have downloaded and installed v2.24.0 and the
> problem still persists.
> 
> I have the following environment variable set
> GIT_DIR=C:\GitRepo
> GIT_HOME=C:\tools\Git

Setting GIT_DIR without also setting GIT_WORKTREE is not a supported
use-case. Therefore, ...

> C:\test\Local_Newfeature>git branch
> * Local_Kumfeature_branch
>   Local_MyTest_branch
> + Local_Newfeature_branch
> + Local_SGSfeature_branch
>   Local_feature_branch
> 
> 
> C:\test\Local_Newfeature>git worktree list
> C:\GitRepo                (bare)
> C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
> C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
> C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]

... this does not work as expected, ....

> C:\test\Local_Newfeature>git --work-tree=C:\test\Local_Newfeature status
> On branch Local_Kumfeature_branch
> Your branch is up to date with 'Lakshman/feature_branch'.
> 
> nothing to commit, working tree clean

... but this works (--work-tree is the same as setting GIT_WORKTREE).

Nobody sets GIT_DIR during normal day-to-day work. Do not set it unless
you know what you are doing.

-- Hannes
