Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1435211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLCWJo (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:09:44 -0500
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:37218 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbeLCWJo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Dec 2018 17:09:44 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 17:09:44 EST
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id TvtLgYlmMtOH9TwHXgPXo9; Mon, 03 Dec 2018 22:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1543874495;
        bh=oo8ZicvGKIYkaHdBGXGKBvLWjrjd5vl2Px69ndPgwMY=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=AV+5oiwrB/9mzDirP30vACf8E01FzRWxBhjBDjvU5lxQg8jHeTr+fbrc+kMQvZ7Jb
         7WInOVUsTNQ1phD5NUsxrfCo/lEi09Lhmu0Bow1zIuRZD9mcgKMzoPeFAY2HI+N0m4
         SiFQ1Zx94C6tVMerqXvHCHbwcKKp2RRCc4z90et3eot8KaDRy4z4eixmAwePHrbnjY
         yxyXzLpz5+w5yn94BqUW/IJGxqBSMM8XI82ykxHEWgn4bqAJrJbDffQnJACOkaTI3P
         v44JaEN4Py9MQfEUFtXo6J0TixMVyXC3wj98Hf9BPugf0jCh5DckaYMehy9a3UYkGD
         Y9s+tstpiuY/g==
Received: from maqtu.svl.corp.google.com ([IPv6:2620:0:100e:913:aa8d:64ee:3bb6:179])
        by resomta-po-09v.sys.comcast.net with ESMTPSA
        id TwHBgz5pjOYvATwHFgdW62; Mon, 03 Dec 2018 22:01:33 +0000
Subject: Re: [PATCH] revisions.c: put promisor option in specialized struct
To:     Jeff King <peff@peff.net>, Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com
References: <20181201194424.GB28918@sigill.intra.peff.net>
 <20181203192356.51432-1-matvore@google.com>
 <20181203212431.GB8700@sigill.intra.peff.net>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <0809e859-b3a6-79ef-031c-9ff3326da31d@comcast.net>
Date:   Mon, 3 Dec 2018 14:01:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181203212431.GB8700@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEdoPhzvcjXm5EhHe2Lu9FuOnAqdMbp093BkYzjtMJiSGoMe7/bu6g08cvnwTpiI0y71DH9ZxLoJ0G/EE3sCRW0VMvVMfrYPRlS1C6bQc/qJQsaptcn9
 /nYKa57uDggxek5pJyZi+KaRJr9a6g1aiNNigfslPvHPfCaHUU1O/xLoYEeONpeA0QGDgIXqEby7xMTQjS+qvBVmUrIUuyGDaNY50Bp8w5Nvol4rg2IuQrFZ
 ZdxL4H4eBzJKKPM8PUFNIICDkJNU6/+iavO4cwm/k59CW2BbiX6N5Fr/RfGz5VQ+a5/u2xBeFYNhxH89RWWBtG0NW+08Wuo+i4eV5jLNzPJqPu07uIdHZRcX
 A+6+c00Z3XC68tKESNBTLUsDWvEa3g8dqEYg8hklOIQ5n844/t63LKeQ+7VjefM6X/+UiILB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2018 01:24 PM, Jeff King wrote:
>> @@ -297,7 +296,8 @@ struct setup_revision_opt {
>>   	const char *def;
>>   	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
>>   	const char *submodule;	/* TODO: drop this and use rev_info->repo */
>> -	int assume_dashdash;
>> +	int assume_dashdash : 1;
>> +	int allow_exclude_promisor_objects : 1;
>>   	unsigned revarg_opt;
>>   };
> 
> I don't know that we need to penny-pinch bytes in this struct, but in
> general it shouldn't hurt either awy. However, a signed bit-field with 1
> bit is funny. I'm not even sure what the standard has to say, but in
> twos-complement that would store "-1" and "0" (gcc -Wpedantic also
> complains about overflow in assigning "1" to it).
Interesting. I hadn't suspected this. But I confirmed it with this:

#include <stdio.h>

struct x {
   int y : 1;
   int z : 1;
};

int main() {
   struct x x;
   x.y = 1;
   x.z = 1;
   printf("%d %d\n", (int) x.y, (int) x.z);
   return 0;
}

-- Output --
-1 -1

> 
> So this probably ought to be "unsigned".


Earlier in this file we define bit fields this way:
	/* Traversal flags */
	unsigned int	dense:1,
			prune:1,

... using \t to align the field names, so I'll mimic that style.
