Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFF51F406
	for <e@80x24.org>; Mon, 14 May 2018 18:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeENSOm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 14:14:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39034 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeENSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 14:14:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id f1-v6so17389070qtj.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZYkSV26FqpEuUCZKOS99AQv10yvgxp2Pm5GoyvvcbcQ=;
        b=iifBjR2a72/zTn0iMCGcs5esAplcpb3ah/vG+CFsvINRWMFya9NL/nasKOwa9Sq9Ys
         jr08vUfMVgbMsVZXrcZJVDVB23RpAdl+gFQqfzgpNyeEAF3pct+o+caUW4wuNXDE7mV0
         NyOgdJfXPjtWjzEgdYOM9cSVxf4PKDPQoNEUVxq2sKuKecRL7OFE9qcf6ABKIryH5lCx
         paYjGKPISIBOf2OGINdiU/wY7xT4lhyAHdGbrf6fWjEAc2sI+ZXymhCF2sP7SKB1aPD+
         CHE00Im2MIQGwUeYWgvEvncTV+OxqvMv+xAirDEO6cwM7VitKXK7rTmKtFyvPufR2G1N
         Zi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZYkSV26FqpEuUCZKOS99AQv10yvgxp2Pm5GoyvvcbcQ=;
        b=Uz9yibq57ki6v7UWRaQNx1UbNlo3kbB0MpFj4ezN4lQIMLkiGNCldj7ryff9VWIlC5
         iy3iGlX9Bzkg3DPoNtgzlcQ/xlmPdLqqIEopRTZ1EHqVppA99JZfl+Me9+sA5d6O8VI1
         bcHM3MdnLmGZZqYNYNVD33ZC13wNaCpCBJRh7dfcLdplHHDCjXAceOYE+2/VKG4vKGU+
         sortvmb5xGrzNQvlhqPNEsOJRYsKgYZ7AJFFclY9/IudivfQxqbKB43VXpY6EblpepDk
         OLr8qH3fWLcQd9sL4jS1EXOWDREVTJ/89NbgCHSmHkgpz0IOYOh8jB6fjhfnsoXeOeXj
         NcCA==
X-Gm-Message-State: ALKqPwf4C/yNipw53JmRk8F/x5xJTF2XskCkTeg1JKFuC+lDqBzmxJyr
        tnkBLvdb6O6UPT+4g8qXATU=
X-Google-Smtp-Source: AB8JxZobhsPeyVTJ+xfJvtSp0YElijzTy8Bf73Q/+1YkWPJ2u5i1nnHk0RB4hnVMoOpEtcoNXnWHcw==
X-Received: by 2002:aed:2aa3:: with SMTP id t32-v6mr10486363qtd.33.1526321679840;
        Mon, 14 May 2018 11:14:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b27-v6sm8118844qtc.66.2018.05.14.11.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 11:14:38 -0700 (PDT)
Subject: Re: [PATCH v2 14/14] commit.h: delete 'util' field in struct commit
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
 <20180513055208.17952-15-pclouds@gmail.com>
 <xmqqy3gmbrnm.fsf@gitster-ct.c.googlers.com>
 <20180514160738.GA19821@duynguyen.home>
 <CACsJy8DhUw6L7j3Pkqji_K0WMjFZxs315emmvdyNQJJN4VTwgw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5ee75fc6-562e-d424-0bc3-c9997dba92db@gmail.com>
Date:   Mon, 14 May 2018 14:14:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DhUw6L7j3Pkqji_K0WMjFZxs315emmvdyNQJJN4VTwgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/14/2018 1:30 PM, Duy Nguyen wrote:
> On Mon, May 14, 2018 at 6:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, May 14, 2018 at 04:52:29PM +0900, Junio C Hamano wrote:
>>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>>
>>>> diff --git a/commit.h b/commit.h
>>>> index 838f6a6b26..70371e111e 100644
>>>> --- a/commit.h
>>>> +++ b/commit.h
>>>> @@ -18,12 +18,16 @@ struct commit_list {
>>>>
>>>>   struct commit {
>>>>      struct object object;
>>>> -   void *util;
>>>>      unsigned int index;
>>>>      timestamp_t date;
>>>>      struct commit_list *parents;
>>>>      struct tree *tree;
>>>>      uint32_t graph_pos;
>>>> +   /*
>>>> +    * Do not add more fields here unless it's _very_ often
>>>> +    * used. Use commit-slab to associate more data with a commit
>>>> +    * instead.
>>>> +    */
>>>>   };
>>> That's a logical consequence and a natural endgame of this
>>> pleasent-to-read series.  THanks.
>>>
>>> Unfortunately we are gaining more and more stuff in "struct commit"
>>> with recent topics, and we may want to see if we can evict some of
>>> them out to shrink it again.
>> Sigh.. ds/lazy-load-trees already enters 'next' so a fixup patch is
>> something like this.
> Sorry I take this patch back. I didn't realize it was a rename and the
> old field named 'tree' was already there (I vaguely recalled some
> "tree" in this struct but didn't stop to think about it). Moving
> graph_pos out is an option, but only 32-bit arch gains from it (64-bit
> arch will have 4 bytes padding anyway) so probably not worth the
> effort. "generation" field should probably be moved out though.

I'm happy to take a look at this patch and figure out the best way to 
integrate it with the changes I've been doing.

I disagree with the removal of "generation". My intention is to make the 
commit-graph feature a standard feature that most repos (of reasonable 
size) want to have. In that case, 'graph_pos' and 'generation' will be 
set during every parse and used by every commit walk. This is just my 
gut reaction.

As I investigate these changes, I'll try to see what performance hit is 
caused by converting the graph_pos and/or generation to commit slabs. 
(Again, I'm assuming the slabs will make this slower. I may be wrong here.)

Thanks,
-Stolee
