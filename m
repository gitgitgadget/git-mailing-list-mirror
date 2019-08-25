Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8111F461
	for <e@80x24.org>; Sun, 25 Aug 2019 22:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfHYW7f (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 18:59:35 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54554 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbfHYW7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 18:59:35 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i21Tx-0007D6-9q; Sun, 25 Aug 2019 23:59:33 +0100
Subject: Re: [PATCH v9 9/9] rebase: teach rebase --keep-base
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
 <6927aba6176fb1b6f30c63e7d8c096861b2f0141.1566724236.git.liu.denton@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <3ffbaead-27e5-1b1a-5ad1-1136697cea1d@iee.email>
Date:   Sun, 25 Aug 2019 23:59:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6927aba6176fb1b6f30c63e7d8c096861b2f0141.1566724236.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/08/2019 10:12, Denton Liu wrote:
> A common scenario is if a user is working on a topic branch and they
> wish to make some changes to intermediate commits or autosquash, they
> would run something such as
>
> 	git rebase -i --onto master... master
>
> in order to preserve the merge base. This is useful when contributing a
> patch series to the Git mailing list, one often starts on top of the
> current 'master'.
This 'However' part doesn't fit the flow. Do you mean 'while initially 
developing...', or is the choice of 'However' wrong?
> However, while developing the patches, 'master' is
> also developed further and it is sometimes not the best idea to keep
> rebasing on top of 'master', but to keep the base commit as-is.
>
This 'Alternatively' appears to be part of the first set of common 
scenarios. Maybe it's just 3 common scenarios, all justifying the same 
improvement.
> Alternatively, a user wishing to test individual commits in a topic
> branch without changing anything may run
>
> 	git rebase -x ./test.sh master... master
>
> Since rebasing onto the merge base of the branch and the upstream is
> such a common case, introduce the --keep-base option as a shortcut.
>
> This allows us to rewrite the above as
>
> 	git rebase -i --keep-base master
>
> and
>
> 	git rebase -x ./test.sh --keep-base master
>
> respectively.
[remainder snipped]
[also Eric Sunshine dropped due to temporary sending difficulties]

Philip
