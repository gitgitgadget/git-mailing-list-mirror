Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5492018E
	for <e@80x24.org>; Sat, 13 Aug 2016 12:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcHMMH7 (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 08:07:59 -0400
Received: from mout.web.de ([212.227.17.12]:58688 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbcHMMH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 08:07:58 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MFc9x-1bSoZI3vML-00Ecs3; Sat, 13 Aug 2016 14:07:46
 +0200
Subject: Re: [PATCH] commit: introduce set_merge_remote_desc()
To:	Jeff King <peff@peff.net>
References: <57AEE4F7.7090804@web.de>
 <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AF0D8E.6040309@web.de>
Date:	Sat, 13 Aug 2016 14:07:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ClzhbmDpUasPtDJRlXRYQvDfmyUMmNKPX5uvjnJ2XwlO3juPDEQ
 d/kK/vUHjirAzMGW9/oDDo5dkggxRl35k1vBHZ/djSgMZ58L035N7eh5XYt6sDiS3kZ5x70
 JF6Z2z6cFEQ8Tca6UM0b5wYRrjpHvJhcqJ4+gvbDXvQFKN/0RJNkrto0FTdu4V93TPyazLH
 CNln7fwb+OJrdiAmpEanA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3RHjt/IeImU=:msciBYckwf1NULzt8z7z2j
 lkRVtRHH0lvi/3GskBaHxs0+W7NdKg7waPMEioqq1sX7mgb4P9ecX1c2G987ZnGm5uXuZKsy0
 6f08SWwNsNHFHFU/v7tVLDd3sYmS9kaFde4phqJqIfPCsfstTXOp18JRXgHTqfVb8OT4uE33q
 Tr6u/JhgrNSSOQyTsRbL+oKzlp9geREFOlC8B6n6PbqUsGHIYmTqZ7fGGEmfSSNuPkMOiZoXD
 VkLIs3EHyGdNg3qODrJ/PhyfHWqWr/QBeElL4hc96eoNNfX7idJd8vhc6ft3rkK9fnaYZryO5
 FSDg8YZmhQqho8mD6V2lpOV5BuF7AqFKAr2KZkclwM+H1eQ2ImdyAPhdXv5zLqyOabhKNKLTW
 uYX/w588lRVhtihpwz+FiPMnQ0X6+Q5o8ZshBoaIgQaPXPJdMYoEuxNqyCDGpIEf+7icmkcs2
 DIXEWCSVgujUKlwI1R7+1r1N8z9ImWx/VvBhfL4koxbMd7FhGIBEGqik2AQXOwQ99Tj6Toy9w
 NCGHmQN39c+Cj4G4s/p/0rboF89k4+NZ9ZHr27VVn1qkGhKX7SiIjjjpWKjArPLfM1l7nutYX
 YD0vtGaJ57keCRBQwzRKSfPdj+YkVCTjJZn+hAuv+qXLTRo8rionWnSBiZ6uwTZS7YpjYEyuR
 mjH43gpsDd8pCcGbvLdtFhAS8xJuSQVMBu3UrhUVSEVIow463ITHciRHfUbDPM2ZRqi2KUxRv
 Akek13l/tjqcpSY3M5kwcGreMDulFuLfy+4UNz1qwUpnrW9dAqE6mPeX5v+FmLrIrD5COAhOv
 4ELSXXR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 13.08.2016 um 11:23 schrieb Jeff King:
> On Sat, Aug 13, 2016 at 11:14:31AM +0200, René Scharfe wrote:
>
>> Add a helper function for allocating, populating and attaching struct
>> merge_remote_desc to a commit and use it consistently.  It allocates the
>> necessary memory in a single block.
>>
>> commit.c::get_merge_parent() forgot to check for memory allocation
>> failures of strdup(3).
>>
>> merge-recursive.c::make_virtual_commit() didn't duplicate the string for
>> the name member, even though one of it's callers (indirectly through
>> get_ref()) may pass the result of oid_to_hex(), i.e. a static buffer.
>
> It seems like you've buried the interesting part here. This isn't just
> for cleanup, but a bugfix that the oids in our virtual commits might get
> overwritten by subsequent actions.
>
> It seems like that should be the subject and beginning of the commit
> message.  And then the fix is to allocate, and by the way we can do so
> easily with this nice new helper. :)

Bugs are usually hidden, so why not hide fixes? ;-)

>> diff --git a/commit.c b/commit.c
>> index 71a360d..372b200 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1576,6 +1576,15 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>>   	return result;
>>   }
>>
>> +void set_merge_remote_desc(struct commit *commit,
>> +			   const char *name, struct object *obj)
>> +{
>> +	struct merge_remote_desc *desc;
>> +	FLEXPTR_ALLOC_STR(desc, name, name);
>> +	desc->obj = obj;
>> +	commit->util = desc;
>> +}
>
> I don't think there is any reason to prefer FLEXPTR_ALLOC over
> FLEX_ALLOC, unless your struct interface is constrained by non-flex
> users (that's why it is necessary for "struct exclude", for example,
> which sometimes needs to carry its own string and sometimes not).
>
> Using FLEX_ALLOC saves a few bytes per struct, and avoids an extra
> pointer indirection when accessing the data.
>
> Since it looks like you touch all of the allocations here, I think they
> would both be happy as a regular flex array.

Good idea.

So let's turn this dish into a full menu:

   commit: use xstrdup() in get_merge_parent()
   commit: factor out set_merge_remote_desc()
   merge-recursive: fix verbose output for multiple base trees
   commit: use FLEX_ARRAY in struct merge_remote_desc

  commit.c                   | 18 +++++++++++-------
  commit.h                   |  4 +++-
  merge-recursive.c          |  5 +----
  t/t3030-merge-recursive.sh | 18 ++++++++++++++++++
  4 files changed, 33 insertions(+), 12 deletions(-)


