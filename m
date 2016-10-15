Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93B920988
	for <e@80x24.org>; Sat, 15 Oct 2016 19:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756071AbcJOTmm (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 15:42:42 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35553 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756052AbcJOTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 15:42:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id c78so40899149wme.0
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JffmCc8xMC/NkhBEakuPnvutONBxfmi+0ZkQ9CoHAFo=;
        b=ChKk3J0J1SL5eV7ZnoErA4ukqWJNLGumGCNq0xYw593quiE7saxcPzH7QHrtdtqD5p
         IJqswY3iW4vamPIH98L0wwAobKdQANK41f/KI4zeANvQMuuIO1q2M8rgadh0IjztEvD8
         Wb6fkiI6dVtqCM1qFGgHCzd4PNzqGi4iijPD/8DTK3/ewJ1gvUseKuz0eQSUfem3PGiE
         /b9GvymQoV8J/FdGN6IMaYevhQFI3OLGxRh2/qPdzvbu+fhSydIUlnclK3HwMQ+EAyEO
         4L0EPkVGYcZ3fvchsxuh75lZqWpgjfR/T9t+A47v16J4sJ/5ESXEa41h2NOvCa0DnYYv
         pl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JffmCc8xMC/NkhBEakuPnvutONBxfmi+0ZkQ9CoHAFo=;
        b=X0eQ1tjsGE8nqKaz4R82M+dg7f3/c2YHZAA/ol6TDlkN9OUy2KFZZQ759Yux5FnW+P
         LcLGUkpWkZTLChsqZPM7i6nqOgdCliQ5wzd1jj2ASgtoysYgEe/bFJqDt/pd203xfaTk
         6ahMtrGfiHcYFr2Z1lPPukqDjWm/xeood9fH9f4a6Fm7PFAyKy6Yv8rt4DjwORQltPZg
         sR9n4+ooP9T9awnKtDNgeKrs/BNwKW7T3iQEp9Rqywkx7KLkYWAzc+C5o8kFkHDFrJLm
         +ykma0TcQeFZOd7YtjjVHGYliF1cTqCQQY0oo6rBWupjE02xcgSQM5Q46myoMya4jxET
         vOCA==
X-Gm-Message-State: AA6/9RlkMxHveu6XiRr4J9XcVyJUWPMmMSjJNHPp3/PM5YNMvFGT5OHDxHXc+T674l5pJw==
X-Received: by 10.28.48.130 with SMTP id w124mr2671293wmw.71.1476560535038;
        Sat, 15 Oct 2016 12:42:15 -0700 (PDT)
Received: from [192.168.1.26] (acva222.neoplus.adsl.tpnet.pl. [83.11.106.222])
        by smtp.googlemail.com with ESMTPSA id c7sm38389258wjk.19.2016.10.15.12.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Oct 2016 12:42:13 -0700 (PDT)
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-14-larsxschneider@gmail.com>
 <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
 <03278DA5-34B8-42F1-B52E-A42A3BCD5FB8@gmail.com>
 <37c12539-3edd-e04b-6e09-e977a854661c@gmail.com>
 <3732E902-2FE9-4C99-B27D-69B9A3FF8639@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <06ff0781-edb8-d3fb-d588-094b1299cb54@gmail.com>
Date:   Sat, 15 Oct 2016 21:42:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3732E902-2FE9-4C99-B27D-69B9A3FF8639@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 15.10.2016 o 16:45, Lars Schneider pisze:
>> On 12 Oct 2016, at 03:54, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 12.10.2016 o 00:26, Lars Schneider pisze: 
>>>> On 09 Oct 2016, at 01:06, Jakub Narębski <jnareb@gmail.com> wrote:
>>>>>
>>>
>>>>> After the filter started
>>>>> Git sends a welcome message ("git-filter-client"), a list of
>>>>> supported protocol version numbers, and a flush packet. Git expects
>>>>> +to read a welcome response message ("git-filter-server") and exactly
>>>>> +one protocol version number from the previously sent list. All further
>>>>> +communication will be based on the selected version. The remaining
>>>>> +protocol description below documents "version=2". Please note that
>>>>> +"version=42" in the example below does not exist and is only there
>>>>> +to illustrate how the protocol would look like with more than one
>>>>> +version.
>>>>> +
>>>>> +After the version negotiation Git sends a list of all capabilities that
>>>>> +it supports and a flush packet. Git expects to read a list of desired
>>>>> +capabilities, which must be a subset of the supported capabilities list,
>>>>> +and a flush packet as response:
>>>>> +------------------------
>>>>> +packet:          git> git-filter-client
>>>>> +packet:          git> version=2
>>>>> +packet:          git> version=42
>>>>> +packet:          git> 0000
>>>>> +packet:          git< git-filter-server
>>>>> +packet:          git< version=2
>>>>> +packet:          git> clean=true
>>>>> +packet:          git> smudge=true
>>>>> +packet:          git> not-yet-invented=true
>>>>> +packet:          git> 0000
>>>>> +packet:          git< clean=true
>>>>> +packet:          git< smudge=true
>>>>> +packet:          git< 0000
>>>>
>>>> WARNING: This example is different from description!!!
>>>
>>> Can you try to explain the difference more clearly? I read it multiple
>>> times and I think this is sound.
>>
>> I'm sorry it was *my mistake*.  I have read the example exchange wrong.
>>
>> On the other hand that means that I have other comment, which I though
>> was addressed already in v10, namely that not all exchanges ends with
>> flush packet (inconsistency, and I think a bit of lack of extendability).
> 
> Well, this part of the protocol is not supposed to be extensible because
> it is supposed to deal *only* with the version number. It needs to keep 
> the same structure to ensure forward and backward compatibility.
> 
> However, for consistency sake I will add a flush packet.

Thanks.  That is one thing I feel quite strongly about.

I can agree that extendability does not matter much here: we can always
change the version number.  But there might be some additional information
that filter process wants to send to Git in first exchange, and using
flush-terminated list here means that we don't need to change version
number, assuming that this additional information is advisory.

The consistency means in my opinion that it should be easier to implement
filter scripts.

>>>> In description above the example you have 4-part handshake, not 3-part;
>>>> the filter is described to send list of supported capabilities last
>>>> (a subset of what Git command supports).
>>>
>>> Part 1: Git sends a welcome message...
>>> Part 2: Git expects to read a welcome response message...
>>> Part 3: After the version negotiation Git sends a list of all capabilities...
>>> Part 4: Git expects to read a list of desired capabilities...
>>>
>>> I think example and text match, no?
>>
>> Yes, it does; as I have said already, I have misread the example. 
>>
>> Anyway, in some cases 4-way handshake, where Git sends list of
>> supported capabilities first, is better.  If the protocol has
>> to prepare something for each of capabilities, and perhaps check
>> those preparation status, it can do it after Git sends what it
>> could need, and before it sends what it does support.
>>
>> Though it looks a bit strange that client (as Git is client here)
>> sends its capabilities first...
> 
> Git tells the filter what it can do. Then the filter decides what
> features it supports. I would prefer to keep it that way as I don't
> see a strong advantage for the other way around.

I think the current order is good, no need to change it.
As I said it is better for Git to send capabilities first.
 

>>>> By the way, now I look at it, the argument for using the
>>>> "<capability>=true" format instead of "capability=<capability>"
>>>> (or "supported-command=<capability>") is weak.  The argument for
>>>> using "<variable>=<value>" to make it easier to implement parsing
>>>> is sound, but the argument for "<capability>=true" is weak.
>>>>
>>>> The argument was that with "<capability>=true" one can simply
>>>> parse metadata into hash / dictionary / hashmap, and choose
>>>> response based on that.  Hash / hashmap / associative array
>>>> needs different keys, so the reasoning went for "<capability>=true"
>>>> over "capability=<capability>"... but the filter process still
>>>> needs to handle lines with repeating keys, namely "version=<N>"
>>>> lines!
>>>>
>>>> So the argument doesn't hold water IMVHO, and we can choose
>>>> version which reads better / is more natural.
>>>
>>> I have to agree that "capability=<capability>" might read a
>>> little bit nicer. However, Peff suggested "<capability>=true" 
>>> as his preference and this is absolutely OK with me.
>>
>> From what I remember it was Peff stating that he thinks "<foo>=true"
>> is easier for parsing (it is, but we still need to support the harder
>> way parsing anyway), and offered that "<foo>" is good enough (if less
>> consistent).
>>
>>> I am happy to change that if a second reviewer shares your
>>> opinion.
>>
>> Also, with "capability=<foo>" we can be more self descriptive,
>> for example "supported-command=<foo>"; though "capability" is good
>> enough for me.
>>
>> For example
>>
>> packet:          git> wants=clean
>> packet:          git> wants=smudge
>> packet:          git> wants=size
>> packet:          git> 0000
>> packet:          git< supports=clean
>> packet:          git< supports=smudge
>> packet:          git< 0000
>>
>> Though coming up with good names is hard; and as I said "capability"
>> is good enough; OTOH with "smudge=true" etc. we don't need to come
>> up with good name at all... though I wonder if it is a good thing `\_o,_/
> 
> How about this (I borrowed these terms from contract negotiation)?
> 
> packet:          git> offers=clean
> packet:          git> offers=smudge
> packet:          git> offers=size
> packet:          git> 0000
> packet:          git< accepts=clean
> packet:          git< accepts=smudge
> packet:          git< 0000
> 
> @Peff: Would that be OK for you?

I don't feel strongly about it.  It could be "<capability>=true", it could
be "<capability>", it could be "capability=<capability>", it could be
something more descriptive.

I guess "<capability>=true" looks a bit strange (would it ever be there
"<capability>=false"?), but it is good enough for me.


One think we can all agree on is that each capability is to be send as
separate packets, and not as space or comma separated list in a single
packet (like for fetch / push).

>>>>> +------------------------
>>>>> +packet:          git< status=abort
>>>>> +packet:          git< 0000
>>>>> +------------------------
>>>>> +
>>>>> +After the filter has processed a blob it is expected to wait for
>>>>> +the next "key=value" list containing a command. Git will close
>>>>> +the command pipe on exit. The filter is expected to detect EOF
>>>>> +and exit gracefully on its own.
>>>>
>>>> Any "kill filter" solutions should probably be put here.
>>>
>>> Agreed. 
>>>
>>>> I guess
>>>> that filter exiting means EOF on its standard output when read
>>>> by Git command, isn't it?
>>>
>>> Yes, but at this point Git is not listening anymore.
>>
>> I think it might be good idea to have here the information about
>> what filter process should do if it needs maybe lengthy closing
>> process, to not hold/stop Git command or to not be killed.
> 
> I've added:
> 
> "Git will wait until the filter process has stopped."

Thanks.  Looks good for me.

I think any advices (like how to handle shutdown in filter without
blocking Git) could be added later, when we have some experience
making and using long-running multi-file filter drivers.

Thank you for your work on this series.
-- 
Jakub Narębski

