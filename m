Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D172018A
	for <e@80x24.org>; Tue, 28 Jun 2016 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbcF1UE3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 16:04:29 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36074 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbcF1UEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 16:04:12 -0400
Received: by mail-io0-f177.google.com with SMTP id s63so27010063ioi.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 13:04:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VuhALvwyqYNAoPSmMwqyZ12HSMGBZ8hdjDhfmU7aBXw=;
        b=oMO0U4P5XFUdG3ZzCqiqpbfkf61BCT1g4VIQyT82tJHVCbZJZoPzMY8Juyix0JZEGn
         BsqmHXRPCVMOLrkzAFXlub/SEg5bl1yqmOzQSZlCngriS/9ZSuGcwCsieVwPxKLl7X/q
         igCW/R5Tmf8M1/02kb1PqOlJCXTI9oR//NSrRbpS93CEpekTy5v5ynsxMG8laWTsHhJN
         pPmubw6OrjijOAshGZajQjHnVQYg7xMrXkVI04xAQ3ea7HUNHJVrqwS3g+drL19MAVFw
         WfyOO7MDxZXkX0+xre7uvLEI+4cmJ4lNnA29fC3ggwjLhvhYl6JIf+AKTA17sVS7JdrJ
         lPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VuhALvwyqYNAoPSmMwqyZ12HSMGBZ8hdjDhfmU7aBXw=;
        b=ICjMP8Dfd2biS/nIAOTtlhwwmLhkwOP5cDORvwxE54xSsvNPXXNrO/V/c6M1pGR+YR
         ur2CNfuy2sqHj4cXvsesKEx0lnX+pHnYeXlyGeEWpZwu0elaSiXL56/d+a6cpAxlbkjZ
         65L1jPLPAgFnAn6BjWn/KB1k+a1jtvn4aeNbkLXoSYDC13bTka/Ps16LxkM6JEu4MAW0
         IY3Nm9XlN3WIG1e3S1CALZ7FHJpd+xsscdYTPlOHA2uYV1wueb/ndYoDnyyDY8qABPUz
         lUuKejw5gV77anZXWixF3zY0erpvzfE090HlC59onyAm053GcOHQjwSE97fqmNmNb0JT
         b3EA==
X-Gm-Message-State: ALyK8tJMJH185QsrWGmPUqTGoG7sLgkXbTn++LFQq9Pqs52bU4jzokv1SqQcVtocg5dlP2WsmzqK+3CQBWAMV0pt
X-Received: by 10.107.178.4 with SMTP id b4mr5571267iof.83.1467143781081; Tue,
 28 Jun 2016 12:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Tue, 28 Jun 2016 12:56:20 -0700 (PDT)
In-Reply-To: <2808201e-130a-55a4-a4ee-70f4d2f428f6@gmx.net>
References: <f572d4ee-c618-6501-a8e5-717feca3ed7c@gmx.net> <CAGZ79kZQTv=QuuSGeYBQ+J89xQwtMmEsq7rvyFOAfSZfM+0YLA@mail.gmail.com>
 <2808201e-130a-55a4-a4ee-70f4d2f428f6@gmx.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 28 Jun 2016 12:56:20 -0700
Message-ID: <CAGZ79kastJyauxh25Re3daQGFAxEC1dQ1bWkaSgzOgHmbY-_FQ@mail.gmail.com>
Subject: Re: Shallow submodule efficiency
To:	Martin von Gagern <Martin.vGagern@gmx.net>,
	Duy Nguyen <pclouds@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 12:08 PM, Martin von Gagern
<Martin.vGagern@gmx.net> wrote:
> Hi Stefan,
>
> On 28.06.2016 19:20, Stefan Beller wrote:
>>> I have the feeling that “git submodule update --depth 1” is less clever
>>> than it could be. Here is one example I observed with git 2.0.0:
>>
>> 2.9.0 (as "Direct fetching of " is not part of 2.0.0 IIRC) ?
>
> Yes, sorry. I had this tested with 2.8.3 at first, then waited for my
> update to 2.9.0 to reproduce, and garbled the text while adjusting it.
>
>> Makes sense! I think the easiest way forward to implement this will be:
>>
>> * `git clone` learns a (maybe undocumented internal) option `--get-sha1`
>>   `--branch` looks similar to what we want, but doesn't quite fit as we do not
>>   know, whether we're on a tag or not. The submodule tells us just the
>>   recorded sha1, not the branch/tag. So maybe we'd end up calling it
>>   `--detach-at=<sha1>`,
>
> That name makes a lot of sense to me.
>
>>   that will
>>   -> inspect the ls-remote for the sha1 being there
>>   -> if the sha1 is there (at least once) clone as if --branch <tag> was given
>
> Clone but detach, to be consistent. Yes.

Oh, right.

>
>>   -> if not found and the server advertised  allowReachableSHA1InWant,
>> try again inside the clone
>
> All of this has to pass through transport and get-pack, right?

Yeah we have to go through the transport layer, i.e. from builtin/clone.c we
manipulate the transport object as defined in transport.h and code in
transport.c
What do you mean by get-pack, though?

>
>> * `submodule--helper update-clone` passes the  `--get-sha1` to the
>> clones of the submodules
>>
>> * cmd_update() in git-submodule.sh will only checkout submodules and
>> not try again
>>   to fetch them if `just_cloned` is set as the cloning did the best it could.
>
> Sounds like a very reasonable roadmap to me.
>
> Do you think there will be someone volunteering to tackle this?

I have it on my (low priority) TODO list, so if you want it sooner
than later, go for
it yourself. Otherwise just wait. Maybe Duy has some interest as well.

Thanks,
Stefan

>
> Greetings,
>   Martin
