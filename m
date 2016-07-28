Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21DE1F859
	for <e@80x24.org>; Thu, 28 Jul 2016 10:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbcG1KnA (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 06:43:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36646 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbcG1Km6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 06:42:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so10488607wma.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 03:42:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gcTUIrzZeQ4czLBG9Q2AJcmLhn8jn2Ie4njqOYtuS4s=;
        b=mUIF2XttTLvFnAbZQ9YLS+l+QU5ydZEoh2KTGg17ywLIBRvSLVlJBBvwLNp9EHte4f
         +dKef0lTo6KSgTCOWy4ZwNJbTFMCA/b8mwTOUI+ezdRIiIMkgy7fjDqwO2kYXthGwrzK
         fcMlyJ+5CYH853QVA23D2rAH3CIMwCUMHEIhVQ4rMMmqOS2+c9lKLWvLleffPBpasO6y
         jIsQbLfbZLQdleLwzJUW7XYk8el3Q2LxCQ2SFGAXBaQ1YdYj5NdDX0C2YYIyA4vhsZL0
         MeN7RPpyRCBFLMSts4xTtIWsLtSyfliljzTp/1MWqDXNmety1QUls9NRDSR/N7RX/h+S
         NyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=gcTUIrzZeQ4czLBG9Q2AJcmLhn8jn2Ie4njqOYtuS4s=;
        b=SEUVtrBJvxsG/n2Iucr2JgdErqSAjVn7eFPH5841HTme7KtSUClDcykMg1dIV2Irgw
         Rdp67Xg5sGll2jTLs/hanaq+paxMqsGdfmiJXNg/QgIKBVgWa5Or2yLVwX5Ub+4+P6dl
         j/nfYlRdVtFheOd+BgfCi1sF/S8mGZaKAEHNCC5HQANZeB/xeOH26UN+fjmh4gTJAD1g
         B/UaUjmBBV1hfux/m6Jz4h7q8E9s+/1Rxn0VJnTAxHb0Yg4ZzCagBPupMeAizTCYiJwq
         RTo9xRVjmw0vbUXrpOYMsrt5e52TYVbR04H7cijr8UhJUu9DZvP0KJX6a5hgOGiszVwp
         C4WA==
X-Gm-Message-State: ALyK8tLfVE0UToV7E/FzA2WLbfja5UhjWvlj0TDyII3h5Zq5h6gX/mNd5vXn5gHRsOjqwQ==
X-Received: by 10.28.50.199 with SMTP id y190mr56338039wmy.61.1469702576799;
        Thu, 28 Jul 2016 03:42:56 -0700 (PDT)
Received: from [192.168.1.26] (epw206.neoplus.adsl.tpnet.pl. [83.20.64.206])
        by smtp.googlemail.com with ESMTPSA id mc8sm10902651wjb.7.2016.07.28.03.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 03:42:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Git filter protocol
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <579906C5.1050809@gmail.com> <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, Eric Wong <e@80x24.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5799E1A0.2070902@gmail.com>
Date:	Thu, 28 Jul 2016 12:42:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-28 o 09:16, Lars Schneider pisze:
>> On 27 Jul 2016, at 21:08, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:
>>>
>>> thanks a lot for the extensive reviews. I tried to address all mentioned
>>> concerns and summarized them below. The most prominent changes since v1 are
>>> the following:
>>> * Git offers a number of filter capabilities that a filter can request
>>>  (right now only "smudge" and "clean" - in the future maybe "cleanFromFile",
>>>  "smudgeToFile", and/or "stream")
>>> * pipe communication uses a packet format (pkt-line) based protocol
>>
>> I wonder if it would make sense to support both whole-file pipe communication,
>> and packet format (pkt-line) pipe communication.
>>
>> The problem with whole-file pipe communication (original proposal for
>> new filter protocol is that it needs file size upfront.  For some types
>> of filters it is not a problem:
>> - if a filtered file has the same size as original, like for rot13
>>   example in the test for the feature
>> - if you can calculate the resulting file size from original size,
>>   like for most if not all encryption formats (that includes GPG,
>>   uudecode, base64, quoted-printable, hex, etc.); same for decryption,
>>   and from converting between fixed-width encodings
>> - if resulting file size is saved somewhere that is easy to get, like
>>   for LFS solutions (I think).
>>
>> For other filters it is serious problem.  For example indent, keyword
>> expansion, rezipping with zero compression (well, maybe not this one,
>> but at least the reverse of it), converting between encodings where
>> at least one is variable width (like UTF-8),...
>>
>> IMHO writing whole-file persistent filters is easier than using pkt-line.
>> On the other hand using pkt-line allow for more detailed progress report.
> 
> I initially wanted to support only "while-file" pipe, too.
> 
> But Peff ($gmane/299902), Duy, and Eric, seemed to prefer the pkt-line
> solution (gmane is down - otherwise I would have given you the links).

As GMane is down (at least the web interface; NNTP seems to be running)
I cannot examine their arguments.  Could you summarize?

> 
> After I have looked at it I think the pkt-line solution is indeed nicer
> for the following reasons:
> 
> (1) A stream optimized version (read/write in separate threads) of the filter
>     protocol can be implemented in the future without changing the protocol

I think the more important thing is that with pkt-line the filter does
not need to know the size of the output upfront.  Separate threads are
independent of protocol used, I think; and anyway Git never writes to
filter and reads from filter in the same command, isn't it?  The lifetime
of filter driver command is one Git command for now.

Oh, you meant having separate threads for writing to filter, and
separate thread for receiving output, so you don't have to wait to
send whole file to filter before starting receiving?  Note that
I think original filter implementation does it; at least async_start()
used in it hints about that (I need to examine how it works to tell
more).

> (2) pkt-line is a simple and easy to implement format

But it is more complicated than whole-file based protocol.  You need
to loop over packets... well you need that tool with whole-file, but
it is covered by existing helper functions (read_in_full()).  It is
easy to redirect file descriptors (copy_fd()), while you need to
convert contents into packets on write side, and unpack and unsplit
on the receive side in Git.

You also need to take care documenting if trailing "\n\0", "\n", "\0"
is a part of packet.

> (3) Reuse of existing Git communication infrastructure
>     -> code and documentation are less surprising to people that know Git

Whole-file read is not that difficult...

>     -> you can use GIT_TRACE_PACKET to easily inspect the
>        communication between Git and the filter process

...but this is a nice advantage.

If deemed necessary, we could also reuse progress report meters from
fetch / push side (percent, bandwidth/throughput), I guess.

> (4) The overheads is neglect able (4 byte header vs 65516 byte content)

Right.

> 
> 
>>> * a long running filter application is defined with "filter.<driver>.process"
>>
>> I hope that won't confuse Git users into trying to use single-shot
>> filters with a new protocol...
> 
> Yes, that was my intention for this new config.

All right, but you need to document the precedence rules: that is 

(1) if, accordingly to the operation, `clean` or `smudge` per-file filter
    is present, it is used; 
(2) if `process` semi-persistent protocol based filter is present,
    and it offers, accordingly to the operation, `clean` or `smudge`
    capabilities, it is used;
(3) otherwise, no filtering is performed.  

`clean` or `smudge` set to empty string means identity filter; I don't know
about rule for the new `process` filter if it is set to empty string.

At least in the commit message you would need to describe why this particular
solution was chosen.  I guess it is to avoid starting `protocol` filter,
only to realize that it does not offer "smudge" capability, and that `smudge`
filter is to be used because it is set.

Best,
-- 
Jakub Narębski

