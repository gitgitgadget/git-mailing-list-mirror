Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8E01F461
	for <e@80x24.org>; Mon,  2 Sep 2019 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfIBP4L (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 11:56:11 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12187 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfIBP4L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 11:56:11 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i4ogb-0003yL-8K; Mon, 02 Sep 2019 16:56:09 +0100
Subject: Re: [BUG} stash show does not show untracked files stashed (reposted)
To:     002901d55e8f$e4a4af70$adee0e50$@rogers.com,
        randall.s.becker@rogers.com
Cc:     git@vger.kernel.org
References: <20190902130128.GA2843@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <966960ff-a8bb-42bb-0b0a-13cd00852068@iee.email>
Date:   Mon, 2 Sep 2019 16:56:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902130128.GA2843@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2019 14:01, Giuseppe Crinò wrote:
>> Suppose I have files a,b,c,d modified, but only file d is in the index.
>> After stash push  (or save) --include-untracked, stash show only displays
>> file d. A subsequent pop will restore files a,b,c,d. So functionally push
>> and pop are fine, but stash show appears to ignores files in the stash.
> This is more of an enhancement, isn't it?
>
> To reproduce
>
> $ touch a b c d
> $ git add d
> $ git stash push --include-untracked
> $ git stash show
>   d | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>
> What is the output that you think should be printed?
>

I'd guess

  1 file changed, 0 insertions(+), 0 deletions(-), *3 files untracked*

as they are what's meant to be in the stash... (obviously format to taste)
Philip

