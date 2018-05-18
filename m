Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F4C1F51C
	for <e@80x24.org>; Fri, 18 May 2018 17:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeERRyu (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 13:54:50 -0400
Received: from avasout04.plus.net ([212.159.14.19]:37106 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERRyt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 13:54:49 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id JjaYfZZa8I9T1JjaZfGyZj; Fri, 18 May 2018 18:54:47 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=EBOSESyhAAAA:8
 a=kCe2lo8DubcXUXX7_bsA:9 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 13/14] merge: use commit-slab in merge remote desc
 instead of commit->util
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
 <20180513055208.17952-14-pclouds@gmail.com>
 <xmqqtvr54sk6.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <06336c49-dfec-9314-8798-2f380d57bc93@ramsayjones.plus.com>
Date:   Fri, 18 May 2018 18:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvr54sk6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfANYefzx7Xg30NC+lcPvIRYTYR0qcHnludl6xuUfT8nwyNAHOLFUzFeAvv/KCdErplUKCJJJtjiRtzcOlOD0ORNQHzNtN6hhA4e/uUmeUuY/QdUK4R74
 s2ZzFAoBd6EAfIDjvsLCQxMwY1N+z+8+RTc+4MDiqUqMfIhfOYNgVZtgrmXsdcvuwhKps4cVqvGirw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/05/18 03:16, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
>> diff --git a/commit.c b/commit.c
>> index 57049118a5..8202067cd5 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1574,13 +1574,21 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>>  	return result;
>>  }
>>  
>> +define_commit_slab(merge_desc_slab, struct merge_remote_desc *);
>> +struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);
> 
> s/^/static /; otherwise sparse would complain?

Indeed, it already did (see [1]). ;-)

Your fixup, commit dc2172daed, on the 'nd/commit-util-to-slab'
branch has indeed fixed it up.

Thanks!

[1] https://public-inbox.org/git/e2c4276f-bcfd-faaa-f9ee-cb50e99da663@ramsayjones.plus.com/

ATB,
Ramsay Jones


