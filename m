Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739BF1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 18:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfHISRe (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 14:17:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:48950 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfHISRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 14:17:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4A4703F40D0;
        Fri,  9 Aug 2019 14:17:34 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:41b9:ba9c:6c99:96cc] (unknown [IPv6:2001:4898:a800:1012:f2ec:ba9c:6c99:96cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 013403F40C2;
        Fri,  9 Aug 2019 14:17:33 -0400 (EDT)
Subject: Re: [PATCH v3 5/7] quote: add sq_append_quote_argv_pretty()
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
 <pull.298.v3.git.gitgitgadget@gmail.com>
 <2002108a30246824f8017da1dea344c1a96f7de2.1565362851.git.gitgitgadget@gmail.com>
 <xmqqtvaqcjhx.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2c53b342-f4be-55b0-d14f-16b12826d2a8@jeffhostetler.com>
Date:   Fri, 9 Aug 2019 14:17:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvaqcjhx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/2019 1:54 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +/*
>> + * Legacy function to append each argv value, quoted as necessasry,
>> + * with whitespace before each value.  This results in a leading
>> + * space in the result.
>> + */
>>   void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
>> +{
>> +	if (argv[0])
>> +		strbuf_addch(dst, ' ');
>> +	sq_append_quote_argv_pretty(dst, argv);
> 
> Micronit (not worth a reroll): if !argv[0], there is no need to call
> append, either.
> 

good catch.  thanks!
