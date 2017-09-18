Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F452047F
	for <e@80x24.org>; Mon, 18 Sep 2017 13:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbdIRNiS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:38:18 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:56566 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbdIRNiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:38:16 -0400
Received: by mail-qk0-f173.google.com with SMTP id u7so498594qku.13
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=88QwQnIV3pHFIqok7gqO6f3atnTuL6Uzz30y+muOi8Q=;
        b=oKeqBD2slzNG/qJIORBuK7DxUuXLyDxouhXOMC84MykRiVT9nXnaP9KrqxrOgqlAHX
         yYDU2B0sWwR8yvsBchjRsgk8p5Z6X574KRJp3pKHkffO5UVbqy55xhck8AvlOg+06YIb
         GFzLk4Vl2Ct4z1nJFsjhWac0JXjhEt6MVDq+FKV1O5vVmVngmNcUD8QzKjrBVAT7WspZ
         ouOABEhCZnBWxLwsJZBIr+RgYj+bBEOs/X0sckJFrkwxy96FtYDguOXBwwU/xKC6JA1C
         1w5uWjfNt7aEQ30jRkTKa7LuC2gdgfSqM4dA/e59SswbhNpQ9h3UmmpUZD8AewiZki88
         Xo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88QwQnIV3pHFIqok7gqO6f3atnTuL6Uzz30y+muOi8Q=;
        b=j17KrMR9P6VediXCimHewMrbLXFyD0q70OsY+fWTv2d4qAq7VN7aEx5axXZU5U7ZUG
         b4JV9KgnhJh+KBpNALdXe8nm9cRPG0Nih4wbxMZ5cf4gIBdAmo8pOReqIqN5YuyrfSVl
         3gcev99eIj1oTvu9ZoS13zdTf85m5ywxdXkIJ7XpqOWKwXq1WFCmkEomlMTh0KCSq+UE
         j9T5znL4NWTz+eDezN0cotaZlLc+taCXYQw5unxVv0Ep1kZ0bgE+xis4jvc+BIpzqinE
         JHwvEeUR1v+Zi7eD3HpYcrbJvANVzVUuyzi9cbWBNuse8ACiTbqTG976my2A1yTjuQ1a
         CsNQ==
X-Gm-Message-State: AHPjjUjCrcc9TyWAA08i2QIZMKBP9K1xBhcjAMxuyvn6sD38PtKwiKJV
        mSHeE+XY/Uuvvw==
X-Google-Smtp-Source: AOwi7QA2+fUHZP6igzEtSzK9GGo0Q0iJze503T3Po3/Y2Arl1j2Z1rM1/yNLsefUCtdopY2GtJBEvw==
X-Received: by 10.55.18.137 with SMTP id 9mr20153461qks.208.1505741895276;
        Mon, 18 Sep 2017 06:38:15 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t90sm5151543qkl.77.2017.09.18.06.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 06:38:14 -0700 (PDT)
Subject: Re: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-9-benpeart@microsoft.com>
 <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5438765b-3119-ef15-8635-932b8cba08d3@gmail.com>
Date:   Mon, 18 Sep 2017 09:38:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/17/2017 4:02 AM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
>> new file mode 100644
>> index 0000000000..482d749bb9
>> --- /dev/null
>> +++ b/t/helper/test-dump-fsmonitor.c
>> @@ -0,0 +1,21 @@
>> +#include "cache.h"
>> +
>> +int cmd_main(int ac, const char **av)
>> +{
>> +	struct index_state *istate = &the_index;
>> +	int i;
>> +
>> +	setup_git_directory();
>> +	if (do_read_index(istate, get_index_file(), 0) < 0)
>> +		die("unable to read index file");
>> +	if (!istate->fsmonitor_last_update) {
>> +		printf("no fsmonitor\n");
>> +		return 0;
>> +	}
>> +	printf("fsmonitor last update %"PRIuMAX"\n", istate->fsmonitor_last_update);
> 
> After pushing this out and had Travis complain, I queued a squash on
> top of this to cast the argument to (uintmax_t), like you did in an
> earlier step (I think it was [PATCH 04/12]).
> 

Thanks. I'll update this to cast it as (uint64_t) as that is what 
get/put_be64 use.  As far as I can tell they both map to the same thing 
(unsigned long long) so there isn't functional difference.
