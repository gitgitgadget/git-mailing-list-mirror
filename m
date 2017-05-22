Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B032023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761702AbdEVTsD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:40862 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757614AbdEVTsC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:02 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wWq2S2smTz5tl9;
        Mon, 22 May 2017 21:48:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F35934327;
        Mon, 22 May 2017 21:47:59 +0200 (CEST)
Subject: Re: [PATCH v3] ref-filter: trim end whitespace in subject
To:     DOAN Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, animi.vulpis@gmail.com, peff@peff.net,
        gitster@pobox.com, git@grubix.eu, pclouds@gmail.com,
        karthik.188@gmail.com
References: <20170522145753.83810-1-congdanhqx@gmail.com>
 <20170522171014.33384-1-congdanhqx@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <777c63ed-c1e3-8efd-48cd-91ac2a841631@kdbg.org>
Date:   Mon, 22 May 2017 21:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170522171014.33384-1-congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.05.2017 um 19:10 schrieb DOAN Tran Cong Danh:
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 5778c0afe..fa4441868 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -13,7 +13,8 @@ test_expect_success 'make commits' '
>   
>   test_expect_success 'make branches' '
>   	git branch branch-one &&
> -	git branch branch-two HEAD^
> +	git branch branch-two $(printf "%s\r\n" one " " line3_long line4 |
> +	     git commit-tree HEAD:)
>   '
>   
>   test_expect_success 'make remote branches' '
> 

This updated test shows nothing, I am afraid: If I apply only this 
change without the rest of the patch, then all test in t3203 still pass. 
And I do not see how the code change could make any difference at all. 
What am I missing?

-- Hannes
