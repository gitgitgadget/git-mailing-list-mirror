Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1820A1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbcH3UqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:46:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35599 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcH3UqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:46:19 -0400
Received: by mail-wm0-f48.google.com with SMTP id w2so5018003wmd.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Fa7Iee/RvWocQ6aj2WjHc7T0gRvVefIyuOBT16HNr2Y=;
        b=YqnMRspomsBzBglHAj1uKx7aNWDVgw5NHH+OpA1b8nVacTRBvU5nilQAzeZUrBpYpg
         zLeWltW7CgEdNrVmWUd0OupmfuYFgmGD47tbiUPaSlWtU942NJnUOBIfFrJO1Gi2+BnW
         E6Eq/D918wNq/a8d4rVMHbvvuEh6UbjBkOXGFUGKi1pW2s+so6DuMNepY6PY14+d4FIo
         Z2KFw4mo003Wyaq3GWuuVXNMc00dHFahNUO5D3RAZPbZCzZ9hVmnHV4/w0ImzUJwNqXC
         YkkcbKPNv4hxjvE4PEZCrc/gSoX1MCas9I+2jO6RpAwuPMNY0x5Y4GppprXCw+4hd4pY
         h02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Fa7Iee/RvWocQ6aj2WjHc7T0gRvVefIyuOBT16HNr2Y=;
        b=lbo7HoGdYvX+0faBYFBGrVtuIkvuQIhOUlZe7nMQBvAArCm/exGmVu5AyDYd6z+kRt
         oxlKLbZ2KbjK+y8AuGXcYIW8JY0YBqsGP8qPbgQTmmmzc713dURQwuKTGNfmgXPAoUXs
         OMWOUw4jKCIjwXQ64NntnENVfqy6mvaxnkqBLsU3y2mJTGdayMm5ANb7gLfMsBj2Uh+H
         EB4AXF+qFajvIUpfLsKYllC8GsfLTEhzLw/JVPwmI/jInp89mtw9uFu0j1XoYR02MyuD
         gYNWptXVfSgakObm6ozNLEP2FlEIbyeVTdUy5tVXHae/2b6+Yhw5zTtNKJwpMROfPEeU
         hGiQ==
X-Gm-Message-State: AE9vXwN041pZ98dBFqsYvyJ7ZqVNFu10JXsEuMD0fB8EBgttodeu7NqCkK+xp6IHTSWDzA==
X-Received: by 10.28.25.71 with SMTP id 68mr6277245wmz.91.1472589977276;
        Tue, 30 Aug 2016 13:46:17 -0700 (PDT)
Received: from [192.168.1.26] (dam9.neoplus.adsl.tpnet.pl. [83.23.12.9])
        by smtp.googlemail.com with ESMTPSA id 142sm5603482wmh.12.2016.08.30.13.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 13:46:15 -0700 (PDT)
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-13-larsxschneider@gmail.com>
 <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
 <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com>
 <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, mlbright@gmail.com
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <7fbd02a1-ad62-7391-df2a-835aae8a62a7@gmail.com>
Date:   Tue, 30 Aug 2016 22:46:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

W dniu 30.08.2016 o 20:59, Junio C Hamano pisze:
> Lars Schneider <larsxschneider@gmail.com> writes:
[...]

>> The filter can exit right after the "error-all". If the filter does
>> not exit then Git will kill the filter. I'll add this to the docs.
> 
> OK.

Is it explicit kill, or implicit kill: close pipe and end process?

>> "abort" could be ambiguous because it could be read as "abort only
>> this file". "abort-all" would work, though. Would you prefer to see
>> "error" replaced by "abort" and "error-all" by "abort-all"?
> 
> No.
> 
> I was primarily reacting to "-all" part, so anything that ends with
> "-all" is equally ugly from my point of view and not an improvement.
> 
> As I said, "error-all" as long as other reviewers are happy with is
> OK by me, too.

I'm rather partial to "abort" instead of "error-all", or "quit"/"exit"
(but I prefer "abort" or "bail-out"), as it better reflects what this
response is about - ending filter process.
 
>> A filter that dies during communication or does not adhere to the protocol
>> is a faulty filter. Feeding the faulty filter after restart with the same 
>> blob would likely cause the same error. 
> 
> Why does Git restart it and continue with the rest of the blobs
> then?  Is there a reason to believe it may produce correct results
> for other blobs if you run it again?

I guess the idea is that single filter can be run on different types
of blobs, and it could fail on some types (some files) and not others.
Like LFS-type filter failing on files with size larger than 2 GiB,
or iconv-like filter to convert UTF-16 to UTF-8 failing on invalid
byte sequences.

>> B) If we communicate "shutdown" to the filter then we need to give the
>>    filter some time to perform the exit before the filter is killed on
>>    Git exit. I wasn't able to come up with a good answer how long Git 
>>    should wait for the exit.
> 
> Would that be an issue?  A filter is buggy if told to shutdown,
> ignores the request and hangs around forever.  I do not think we
> even need to kill it.  It is not Git's problem.

I think the idea was for Git to request shutdown, and filter to tell
when it finished (or just exiting, and Git getting SIGCHLD, I guess).
It is hard to tell how much to wait, for example for filter process
to send "sync" command, or finish unmounting, or something...

> I personally would be reluctant to become a filter process writer if
> the system it will be talking to can kill it without giving it a
> chance to do a graceful exit, but perhaps that is just me.  I don't
> know if closing the pipe going there where you are having Git to
> kill the process on the other end is any more involved than what you
> have without extra patches.

Isn't it the same problem with v1 filters being killed on Git process
exit?  Unless v2 filter wants to do something _after_ writing output
to Git, it should be safe... unless Git process is killed, but it
is not different from filter being stray-killed.

>>>> +Please note that you cannot use an existing `filter.<driver>.clean`
>>>> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
>>>> +because the former two use a different inter process communication
>>>> +protocol than the latter one.
>>>
>>> Would it be a useful sample program we can ship in contrib/ if you
>>> created a "filter adapter" that reads these two configuration
>>> variables and act as a filter.<driver>.process?
>>
>> You mean a v2 filter that would use v1 filters under the hood?
>> If we would drop v1, then this would be useful. Otherwise I don't
>> see any need for such a thing.
> 
> I meant it as primarily an example people can learn from when they
> want to write their own.

Errr... if it were any v1 filter, it would be useless (as bad or
worse performance than ordinary v1 clean or smudge filter).  It
might make sense if v1 filter and v2 wrapper were written in the
same [dynamic] language, and wrapper could just load / require
filter as a function / procedure, [compile it], and use it.
For example smudge/clean filter in Perl (e.g. rot13), and v2 wrapper
in Perl too.

Best,
-- 
Jakub Narębski 
 

