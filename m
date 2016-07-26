Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6232203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 10:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbcGZK6Y (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 06:58:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37710 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbcGZK6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 06:58:23 -0400
Received: by mail-wm0-f49.google.com with SMTP id i5so10856682wmg.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 03:58:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wGIUqZV8Yfxa0irWkKAP6NDZJa8HSSSF0y9VKt3tllM=;
        b=xZYITssc8jOXIYwHpAdVQcoXpw8Mqq7V8Ymui4vfugc0s/efIaYMCPwAXHUzIEJiv1
         hIMuqMZbN0w6xx7IkE0dCxWX/MScmlO8YpD9CVwMGNfDZJ9dM6k0heMlXfFMVhyLrJ9b
         VjG8Sb5kpHkBF7ejWsWeriNMzdQVw6yIaOrEmv+/UO1cnWjrz9HWpI2b2vYd3jQbalCK
         0m4gi3C/SQGE3S5DrUs41gjcZJ/x3m1EIkQ4g1rJLPkNiBK5MotMRzgPQUZdXGh7rTw5
         tC13/Tg2XGFce1TFIwU2UO8TgPrNrqJxOxtI1Bt5ojQyZFeoXmj+UR+WlBxQ7laEn+Ae
         5Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=wGIUqZV8Yfxa0irWkKAP6NDZJa8HSSSF0y9VKt3tllM=;
        b=MBNZ1fEdn3Qym19VP9A6P6fnm/5nV6NwZTlk+u5IfqNI0G1Ng7/q1A45CqYyW4I2Sf
         Z5KeEz+CH7Dbr6wjKtSLPeXgCFviqST4CfY8t6dppi1e2pCLMeaoifiAcwLRSfSFViZX
         IHvzLO5DO+D5SBSzue7LWzOGzELuIAiuX8bLb5Q2dLiuKglW81Vu8W4k6dYupMLl4nMb
         znKVZbIJkXGUyoc03JvKu9Gz3nTyqreiNMIMsOyDXN/GRgrZhrPT9as9wkTph0Q7Y2NM
         pZt/eR17hdgyTloNKFtkcZA9M3CsnNyMtMNBeaK4mnIBliUiPPPVd2qMtmw1LgQ+Nrfw
         ozww==
X-Gm-Message-State: AEkooutuqfV/dsW7MfSXoZij1XQNpLNjiksbl439FkwgThOCopIYLUVJHwOKnQaHnkmFjg==
X-Received: by 10.194.70.165 with SMTP id n5mr20233506wju.135.1469530701209;
        Tue, 26 Jul 2016 03:58:21 -0700 (PDT)
Received: from [192.168.1.26] (afq129.neoplus.adsl.tpnet.pl. [83.25.146.129])
        by smtp.googlemail.com with ESMTPSA id r16sm32316276wme.16.2016.07.26.03.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 03:58:20 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
 <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com>
 <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com>
 <57954DA3.9090006@gmail.com> <7D0AD199-F077-4EB2-83A5-58EB603973CA@gmail.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57974240.5030003@gmail.com>
Date:	Tue, 26 Jul 2016 12:58:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <7D0AD199-F077-4EB2-83A5-58EB603973CA@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 22:32, Lars Schneider pisze: 
> On 25 Jul 2016, at 01:22, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 2016-07-25 o 00:36, Ramsay Jones pisze:
>>> On 24/07/16 18:16, Lars Schneider wrote:

>>>> It was a conscious decision to have the `filter` talk first.
>>>> My reasoning was:
>>>> 
>>>> (1) I want a reliable way to distinguish the existing filter 
>>>> protocol ("single-shot invocation") from the new one ("long 
>>>> running"). I don't think there would be a situation where the 
>>>> existing protocol would talk first. Therefore the users would 
>>>> not accidentally mix them with a possibly half working, 
>>>> undetermined, outcome.
>>> 
>>> If an 'single-shot' filter were incorrectly configured, instead 
>>> of a new one, then the interaction could last a little while - 
>>> since it would result in deadlock! ;-)
>>> 
>>> [If Git talks first instead, configuring a 'single-shot' filter 
>>> _may_ still result in a deadlock - depending on pipe size, etc.]
>> 
>> Would it be possible to do an equivalent of sending empty file to 
>> the filter? If it is misconfigured old-style script, it would exit 
>> after possibly empty output; if not, we would start new-style 
>> interaction.
> 
> I think we would need to close the pipe to communicate "end" to the 
> filter, no? I would prefer to define the protocol explicitly as this 
> is clearly easier.

Well, we could always close stdin of a script, check if it quits,
then reopen. Or close stdin, and send commands via file descriptor 4.
Or send SIGPIPE. But I don't know if it is a good idea.

> On 25 Jul 2016, at 00:36, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

>> If an 'single-shot' filter were incorrectly configured, instead of
>> a new one, then the interaction could last a little while - since
>> it would result in deadlock! ;-)
>> 
>> [If Git talks first instead, configuring a 'single-shot' filter
>> _may_ still result in a deadlock - depending on pipe size, etc.]
> 
> Do you think this is an issue that needs to be addressed in the first
> version? If yes, I would probably look into "select" to specify a
> timeout for the filter.

This might be a better idea.  Additionally, it would make it possible
to detect buggy v2 filter scripts.

>                         However, wouldn't the current "single-shot"
> clean/smudge filter block in the same way if they don't write
> anything?

Hmmm... so deadlocking (waiting for user to press ^C) might be
an acceptable solution. It would be good to tell him or her why
there was a deadlock (catch SIGINT), that Git was waiting for
specific command in a specific filter driver, for a specific file.


On the other hand v2 protocol has an additional problem: users
switching to v2, while using old one-shot filters (that worked
correctly).  So in my opinion you need to ensure two things:

(1) name things in such way that it is easy to see that you
need to write filter script specifically for the v2 protocol,

(2) if possible, do not hang but warn the user if he or she
wants to use v1 filter (per-file) with v2 protocol (per-command),
or at least help diagnose the issue.

>> This should be tested, if we agree that detecting misconfigured 
>> filters is a good thing.

[clarified]

-- 
Jakub Narębski
