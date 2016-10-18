Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B181F4F8
	for <e@80x24.org>; Tue, 18 Oct 2016 02:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938599AbcJRCC6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 22:02:58 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34968 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935242AbcJRCCu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 22:02:50 -0400
Received: by mail-pf0-f175.google.com with SMTP id s8so86004332pfj.2
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 19:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3NuCIaHK4iQrizimJmfM6r1gFfhfXs8UxEHwGh8DJbM=;
        b=eBbRckUCfJMWEGJE5U5nLVxdRISAcytjZh1kIVDa1uxxZdM6nFB9G53s8QhYi0yVWa
         dmsN4p40n0VtKXh7Gah6DY9BFi/ei4gbgFHrDjhK5UNhDUoOXGkN24tEpudbK2sfd4YY
         Op+EPPvnhfAwds/V+fr0WcdSxutOLi+Sd8O/V2P0hJsSpYXXQ/PWriNzqpXzNIZiNhfm
         cKZAvFVKSwhfD9VmdqWQy7UlxUmEcAZiucMuDFSHO5st7KyDPFD5Vz36y9n70tsJwRGZ
         MAozDVegW6Ebg+b+vu3GGTur4NRYb4nGR5gM8i3PlFqO04oRyxf/9yu2z1KnxZdaxYId
         yo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3NuCIaHK4iQrizimJmfM6r1gFfhfXs8UxEHwGh8DJbM=;
        b=edUEuqIIGJiUNDJMjJpSyWbAfnyqFHBEv3fjtPgnWOt8gg8vBKME2p5a7M5P0UA7uz
         3bz4aFiPiZQWyNpeiEOmbKk88GHURb2RfvzK65hLpkuQ4o1hzGBuM/nN+Lt/8CnQb6YB
         dBTOYiWqy6df+sawjBRQbW9/5vP1kLzr1kFq4ESQZ+GcMhNve0mQOJILljXNh3pPvL4d
         1ijngXHbALHBIbqlCBrGVHaGkgvT7xVpokDxprQSGvLgWY54n74Ytm8e1WynHijIlO8f
         6ZgRrPrWHo4+cTcqcgEadQov+Fow3dYP5QvQuq+8jyGPhyNp6XBzam4PSPh83W+HBNDF
         /d7A==
X-Gm-Message-State: AA6/9RkB09eEuW/KSte6zt7NXeybDozCJ6MOC5BLN1dZJtTzAd5VUHkfzZZktkQNP8ilfKpL
X-Received: by 10.98.217.22 with SMTP id s22mr745256pfg.40.1476756169483;
        Mon, 17 Oct 2016 19:02:49 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:f161:3d07:c0fa:fd8a])
        by smtp.gmail.com with ESMTPSA id o75sm50922540pfi.25.2016.10.17.19.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2016 19:02:48 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] trailer: allow non-trailers in trailer block
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com>
 <1b3fe84e4b6126884a801e721d0a93c41fcb4184.1476466609.git.jonathantanmy@google.com>
 <CAGZ79kYLq1qA4_Qg2x5Fiu5AmGBZdozm4zk6K7LkU+uJ1LNUTw@mail.gmail.com>
 <xmqq7f96sa9i.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <cb622421-1857-d136-2618-ec62d438790d@google.com>
Date:   Mon, 17 Oct 2016 19:02:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq7f96sa9i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2016 06:42 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Oct 14, 2016 at 10:38 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>>
>>>  Existing trailers are extracted from the input message by looking for
>>> -a group of one or more lines that contain a colon (by default), where
>>> +a group of one or more lines in which at least one line contains a
>>> +colon (by default), where
>>
>> Please see commit
>> 578e6021c0819d7be1179e05e7ce0e6fdb2a01b7
>> for an example where I think this is overly broad.
>
> Hmph.  That's a merge.
>
>     Merge branch 'rs/c-auto-resets-attributes'
>
>     When "%C(auto)" appears at the very beginning of the pretty format
>     string, it did not need to issue the reset sequence, but it did.
>
>     * rs/c-auto-resets-attributes:
>       pretty: avoid adding reset for %C(auto) if output is empty
>
> And neither of the two colon containing line remotely resembles how
> a typical RFC-822 header is formatted.  So that may serve as a hint
> to how we can tighten it without introducing false negative.

The only "offending" character is the space (according to RFC 822), but 
that sounds like a good rule to have.

>> Another made up example, that I'd want to feed
>> in commit -s eventually:
>>
>> --8<--
>> demonstrate colons in Java
>>
>> First paragraph is not interesting.
>>
>> Also if using another Language such as Java, where I point out
>> Class::function() to be problematic
>> --8<--
>>
>> This would lack the white space between the last paragraph and
>> the Sign off ?
>>
>> So for this patch I am mostly concerned about false positives hidden
>> in actual text.
>
> Yes.
>
> These are exactly why I mentioned "if certian number or percentage"
> in my earlier suggestion.
>
> I think in practice, "A paragraph with at least one Signed-off-by:
> line, and has no more than 3/4 of the (logical) lines that do not
> resemble how a typical RFC-822 header is formatted" or something
> along that line would give us a reasonable safety.

I think that "Signed-off-by:" is not guaranteed to be present. Defining 
a trailer line as "a line starting with a token, then optional 
whitespace, then separator", maybe the following rule:
- at least one trailer line generated by Git ("(cherry picked by" or 
"Signed-off-by") or configured in the "trailer" section in gitconfig
OR
- at least 3/4 logical trailer lines (I'm wondering if this should be 
100% trailer lines)

?

> Your Java example will fail the criteria in two ways, so we'd be
> safe ;-)
