Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5CC1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 13:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfD2NBJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 09:01:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:26141 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfD2NBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 09:01:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 308EC3F4094;
        Mon, 29 Apr 2019 09:01:08 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:ada1:ccb0:23a:28de] (unknown [IPv6:2001:4898:8010:2:96d5:ccb0:23a:28de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E79B73F4024;
        Mon, 29 Apr 2019 09:01:07 -0400 (EDT)
Subject: Re: [PATCH] trace2: fix incorrect function pointer check
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <548a9b833f4569c526cf94c048ae115a76d54be9.1556211995.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <09415b8f-d07f-5928-06d3-d905a7a30c09@jeffhostetler.com>
Date:   Mon, 29 Apr 2019 09:01:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <548a9b833f4569c526cf94c048ae115a76d54be9.1556211995.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/25/2019 1:08 PM, Josh Steadmon wrote:
> Fix trace2_data_json_fl() to check for the presence of pfn_data_json_fl
> in its targets, rather than pfn_data_fl, which is not actually called.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>   trace2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/trace2.c b/trace2.c
> index 8bbad56887..a73cfdf6fe 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -717,7 +717,7 @@ void trace2_data_json_fl(const char *file, int line, const char *category,
>   	us_elapsed_region = tr2tls_region_elasped_self(us_now);
>   
>   	for_each_wanted_builtin (j, tgt_j)
> -		if (tgt_j->pfn_data_fl)
> +		if (tgt_j->pfn_data_json_fl)
>   			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
>   						us_elapsed_region, category,
>   						repo, key, value);
> 

good catch.  thanks.

Jeff
