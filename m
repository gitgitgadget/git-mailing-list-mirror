Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701EA2090B
	for <e@80x24.org>; Tue, 19 Sep 2017 06:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750822AbdISGv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:51:27 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42282 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750713AbdISGv0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:51:26 -0400
X-AuditID: 1207440c-7e5ff7000000143e-92-59c0be6d5f26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 50.87.05182.D6EB0C95; Tue, 19 Sep 2017 02:51:25 -0400 (EDT)
Received: from [192.168.69.190] (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6pMpp004225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:51:23 -0400
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Alex Riesen <raa.lkml@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com>
 <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu>
 <xmqqfubku9iy.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYXDhcVXd2C-x6e=o7jYdKqV22DY45c7E2TeuhKLfn26w@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <dab2d555-7e09-4eb3-19b8-cab085626bbe@alum.mit.edu>
Date:   Tue, 19 Sep 2017 08:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYXDhcVXd2C-x6e=o7jYdKqV22DY45c7E2TeuhKLfn26w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqJu770CkwYpZchZdV7qZLBp6rzBb
        vL25hNHif9s7NovNm9tZLHob/7A6sHnsnHWX3WPBplKPi5eUPT5vkgtgieKySUnNySxLLdK3
        S+DKuP/tMGvBTJGKc/ePsTQw3ufvYuTkkBAwkdiw/QVrFyMXh5DADiaJpbP6oZwLTBKfD95k
        A6kSFgiWOP/rCAtIQkRgB6NE18fr7CAJZoEoiU3Pl0F17GSSuP9uCgtIgk1AV2JRTzMTiM0r
        YC9x/c9TVhCbRUBVYuLUeWC2qECERN/by+wQNYISJ2c+AevlFAiU+H9wCRvEAnWJP/MuMUPY
        4hK3nsxngrDlJZq3zmaewCgwC0n7LCQts5C0zELSsoCRZRWjXGJOaa5ubmJmTnFqsm5xcmJe
        XmqRrqFebmaJXmpK6SZGSPDz7GD8tk7mEKMAB6MSD6/Atf2RQqyJZcWVuYcYJTmYlER5wzYd
        iBTiS8pPqcxILM6ILyrNSS0+xCjBwawkwntoEVCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2x
        JDU7NbUgtQgmK8PBoSTBm7MXqFGwKDU9tSItM6cEIc3EwQkynAdouBtIDW9xQWJucWY6RP4U
        o6KUOK8GSEIAJJFRmgfXC0tOrxjFgV4R5j0PUsUDTGxw3a+ABjMBDc7eADa4JBEhJdXAWHnq
        U8+Wy/vF5LnD9xz8NkVHMHOK4OYfHasE9Ta/rrrYpWlXuzBO8IPh1Q2P86oTTiRm5vtGvF6n
        voD3yxfjyI0Jt5g/9+n+5WvJWHbqjvCFi4cv79Mp1XXbeKJvxspXPT6cvQdCrpvFr5ON+8jQ
        KbhUcX3dnkzryd8mKtdtvi6qPsf62z+9pUosxRmJhlrMRcWJAGV3azMpAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/19/2017 02:08 AM, Stefan Beller wrote:
>> I am hoping that this last one is not allowed and we can use the
>> "same condition is checked every time we loop" version that hides
>> the uglyness inside the macro.
> 
> By which you are referring to Jonathans solution posted.
> Maybe we can combine the two solutions (checking for thelist
> to not be NULL once, by Jonathan) and using an outer structure
> (SZEDERs solution) by replacing the condition by a for loop,
> roughly (untested):
> 
> #define for_each_string_list_item(item,list) \
> -       for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> +    for (; list; list = NULL)
> +        for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> 
> as that would not mingle with any dangling else clause.
> It is also just one statement, such that
> 
>     if (bla)
>       for_each_string_list_item {
>         baz(item);
>       }
>     else
>       foo;
> 
> still works.
> 
> Are there downsides to this combined approach?

On the plus side, it's pleasantly devious; I wouldn't have thought of
using a `for` loop for the initial test. But it doesn't work as written,
because (1) we don't need to guard against `list` being NULL, but rather
`list->items`; and (2) we don't have the liberty to set `list = NULL`
(or `list->items = NULL`, because `list` is owned by the caller and we
shouldn't modify it.

The following is a bit closer:

#define for_each_string_list_item(item,list) \
	for (item = (list)->items; item; item = NULL) \
        	for (; item < (list)->items + (list)->nr; ++item)

But I think that also fails, because a callsite that does

	for_each_string_list_item(myitem, mylist)
		if (myitem.util)
			break;

would expect that `myitem` is still set after breaking out of the loop,
whereas the outer `for` loop would reset it to NULL.

If `break` were an expression we could do something like

#define for_each_string_list_item(item,list) \
	for (item = (list)->items; item; break) \
        	for (; item < (list)->items + (list)->nr; ++item)

So I think we're still left with the suggestions of Jonathan or Gábor.
Or the bigger change of initializing `string_list::items` to point at an
empty sentinal array (similar to `strbuf_slopbuf`) rather than NULL.
Personally, I think that Jonathan's approach makes the most sense,
unless somebody wants to jump in an implement a `string_list_slopbuf`.

By the way, I wonder if any open-coded loops over `string_lists` make
the same mistake as the macro?

Michael
