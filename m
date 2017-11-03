Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A17F20450
	for <e@80x24.org>; Fri,  3 Nov 2017 17:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755613AbdKCR03 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 13:26:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:24624 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752309AbdKCR03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 13:26:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8B05684599;
        Fri,  3 Nov 2017 13:26:28 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 374DD84594;
        Fri,  3 Nov 2017 13:26:28 -0400 (EDT)
Subject: Re: [PATCH] fix an 'dubious one-bit signed bitfield' error
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <7b066cbc-416b-b870-5fd5-3673ece036f8@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c9ac794b-c864-fa37-99b5-befe4d45b37a@jeffhostetler.com>
Date:   Fri, 3 Nov 2017 13:26:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <7b066cbc-416b-b870-5fd5-3673ece036f8@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d'oh.  thanks!

On 11/3/2017 1:05 PM, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Jeff,
> 
> If you need to re-roll your 'jh/object-filtering' branch, could
> you please squash this into the relevant commit (b87fd93d81,
> "list-objects: filter objects in traverse_commit_list", 02-11-2017).
> 
> [This error was issued by sparse]
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>   list-objects-filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 7f2842547..d9e626be8 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -191,7 +191,7 @@ static void *filter_blobs_limit__init(
>    */
>   struct frame {
>   	int defval;
> -	int child_prov_omit : 1;
> +	unsigned int child_prov_omit : 1;
>   };
>   
>   struct filter_sparse_data {
> 
