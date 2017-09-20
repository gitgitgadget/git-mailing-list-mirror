Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255E72047F
	for <e@80x24.org>; Wed, 20 Sep 2017 02:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751016AbdITCaN (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 22:30:13 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:43927 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdITCaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 22:30:12 -0400
Received: by mail-pf0-f178.google.com with SMTP id y29so819543pff.0
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rT0fByxT1eOdqicmvUDkf0SSoNkGDTc5Bv/aMcf/4+k=;
        b=VVsf5iCCzxBGu+PKR5iWGk4iqMhYdSa/96ESeBb1js4jxixibC1imlG4Gj9sfP6dEH
         szFD8pq9wfAAoYiHIwBgSNz3ni6sHjfV4C5JG6zMUfJOZK2wh534ysUF/MX8AAYDirjr
         +amI1x9IOG1DBxNwGOzD3rsuy+sUcrSGq+xEs3VjHfl+Yxw4Q1VFniShip0mfh3RRLZt
         dt31YRl+Js3ctfz5JOdtU7nus/T2ryyIiW7yZY8CFRobskFuoTgvOXxDQJyxlxk60N3v
         c2tZHmw3dpWIWCp+8TvaMIjr0Dm8foP+N8aWaUpZkFRp5l8tURaeFJflxwEtif4qePWi
         329g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rT0fByxT1eOdqicmvUDkf0SSoNkGDTc5Bv/aMcf/4+k=;
        b=HrgN1mTaXdJu0TN6ecHqL1huIW4mqW8bMX1T9NvgVzuu1iYWxzdH5YpIguU/VP+eXg
         gLB/M7PvKumqqxpQNpY+A5hmGGAxFRfaJDkL8+NnR+UGVhvt+i9w+Y0k5lcemqY36f+u
         IeMuVf6cB9QkbGakQoAdOhg9nLNCKs2gXD4X8+y4Pnelx+fdNTir6B0v9dHQ/GrfJYEc
         /z2x2g9cEfl1tYVkBlQq7C5CGFBlbAzns5FasbGXnnU0bmvmr4nxMM8M4R8UeQlr+kkY
         h2fIoxLQLUCD+wp6Hrw8TXgFtsqSyHzKfeyauO+t/xvxmc5k0tMzi46GCJvconPu4Eh7
         ZUYw==
X-Gm-Message-State: AHPjjUiJX+lvJvSKms62KPHNva8joTBPacWKV7fpT7czXdeqlk+uQxEB
        fOhq3h8yAMvOnzLutJPzTho=
X-Google-Smtp-Source: AOwi7QBuAUg/YM4mANoJp0koX2mYTxYN9gt8FrFLmLX1n7OpZdPRpOsEVMqdLisEZry/y2cKE4xDfw==
X-Received: by 10.98.86.73 with SMTP id k70mr583351pfb.345.1505874611595;
        Tue, 19 Sep 2017 19:30:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id x28sm5683462pfi.8.2017.09.19.19.30.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 19:30:10 -0700 (PDT)
Date:   Tue, 19 Sep 2017 19:30:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
Message-ID: <20170920023008.GB126984@aiede.mtv.corp.google.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kaartic Sivaraam wrote:
> On Saturday 16 September 2017 09:36 AM, Michael Haggerty wrote:
>> Jonathan Nieder wrote:

>>> Does the following alternate fix work?  I think I prefer it because
>>> it doesn't require introducing a new global. [...]
>>>   #define for_each_string_list_item(item,list) \
>>> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>>> +	for (item = (list)->items; \
>>> +	     (list)->items && item < (list)->items + (list)->nr; \
>>> +	     ++item)
>>
>> This is the possibility that I was referring to as "add[ing] overhead to
>> each iteration of the loop". I'd rather not add an extra test-and-branch
>> to every iteration of a loop in which `list->items` is *not* NULL, which
>> your solution appears to do. Or are compilers routinely able to optimize
>> the check out?
>
> I t seems at least 'gcc' is able to optimize this out even with a -O1
> and 'clang' optimizes this out with a -O2. Taking a sneak peek at
> the 'Makefile' shows that our default is -O2.
>
> For a proof, see https://godbolt.org/g/CPt73L

From that link:

    for ( ;valid_int && *valid_int < 10; (*valid_int)++) {
        printf("Valid instance");
    }

Both gcc and clang are able to optimize out the 'valid_int &&' because
it is dereferenced on the RHS of the &&.

For comparison, 'item < (list)->items + (list)->nr' does not
dereference (list)->items.  So that optimization doesn't apply here.

A smart compiler could be able to take advantage of there being no
object pointed to by a null pointer, which means

	item < (list)->items + (list)->nr

is always false when (list)->items is NULL, which in turn makes a
'(list)->items &&' test redundant.  But a quick test with gcc 4.8.4
-O2 finds that at least this compiler does not contain such an
optimization.  The overhead Michael Haggerty mentioned is real.

Thanks and hope that helps,
Jonathan
