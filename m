Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5201FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 14:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934964AbdDFOFV (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 10:05:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:39085 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933624AbdDFOFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 10:05:20 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B83D08462C;
        Thu,  6 Apr 2017 10:05:17 -0400 (EDT)
Subject: Re: [PATCH v5 4/4] read-cache: speed up add_index_entry during
 checkout
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170405225453.2632-1-szeder.dev@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <75c1724f-f0af-6b3e-71b1-97d486d94396@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 10:05:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405225453.2632-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/5/2017 6:54 PM, SZEDER Gábor wrote:
>> Teach add_index_entry_with_check() and has_dir_name()
>> to see if the path of the new item is greater than the
>> last path in the index array before attempting to search
>> for it.
>>
>> During checkout, merge_working_tree() populates the new
>> index in sorted order, so this change saves at least 2
>> lookups per file.
>
> I think the performance numbers from the cover letter should be
> included here, so they will be included in the history.

Good point.

