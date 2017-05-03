Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4A71F829
	for <e@80x24.org>; Wed,  3 May 2017 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbdECSXd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:23:33 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34836 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdECSXc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:23:32 -0400
Received: by mail-io0-f196.google.com with SMTP id v34so3415039iov.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zse5RBbRHgacSCKBKdiM66IN6pdxlXkD+/FeD+O9/cU=;
        b=j10e3lWg4YCI7eA1bXlyYgzo/aZArsSv8RAdHKf3NW7S70WXbjY1UtIU57xD+CUzpp
         ghCyiKODDQfM827T4xvnMEs6LRIzY1blmScta8wAUWGyGmJe8dyy+QxgWtCTFtSbAPQ+
         ta0j0vcCeJkOd9ZidOqMPTKg5rCb3n7/LovA76YXtnskweQGzauRov1Y2TuutEoP2Mvb
         kqAbFIl+SkVOUBCtIpNiF+9/zQce6bPlrAH1MGyygJp+FTcni3DurSFQ8jpM4te8ltiP
         J6Cu0jVq9wHHumeSPReTNtFqBU7cAzFiioWQD8YR9rWq35UiBMfMxoZCz7kCK4NiU65t
         T5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zse5RBbRHgacSCKBKdiM66IN6pdxlXkD+/FeD+O9/cU=;
        b=SgiTUoXsF/5eCi0w2l4V9KKhJPsuGGMUho0oqiXQWEZLBxU31pxhTzTJ8hQdZC8dWR
         eF5z8EdkGLPWfIDkHej2EZRCeS11fdsMcu3ljt+7YQKybK08nxZrcMSU/HTQJGvc58aE
         zGxrs59QUs+8jMb0NVNhgiLsyK3cD7u/VGtncOH0sbVlGLUDfSmJUju6meW+PlGxz2Jp
         H5eAR2knua9OQjxyaSZq4anI8bzdbLRC55i1DFo19JQpYFrLE0jfSi+hOojyBXcdvQzE
         E5YKK94Wm7Nnm6CIQkXPM1Jzs9deGYZRArZ06iywDHc1MA9slDuok3osocRctUTiZSLq
         OdtA==
X-Gm-Message-State: AN3rC/6dlncbfKTPTfCBvdQ9C35ACO4GF07rIq6PyXqzLyjiwvWNXb3l
        UJb8MZAivC32pBwrZQfUcoeTAO3oLQ==
X-Received: by 10.107.140.197 with SMTP id o188mr33438607iod.180.1493835811661;
 Wed, 03 May 2017 11:23:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 3 May 2017 11:22:51 -0700 (PDT)
In-Reply-To: <CAGZ79kZs8q2cn7wJr-2ZFGZEwSsy8K2RZ_xBXfUuZBiGM0Gjog@mail.gmail.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com>
 <b2d1d2fe-1b9b-4afa-192f-267bbb5df487@jeffhostetler.com> <CAJZjrdWF4NLPty81wmPsgUoVz1FddYhTGdjrNuB1LcME5qrwDQ@mail.gmail.com>
 <CAGZ79kZs8q2cn7wJr-2ZFGZEwSsy8K2RZ_xBXfUuZBiGM0Gjog@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 3 May 2017 13:22:51 -0500
Message-ID: <CAJZjrdWRjAC4GbJExhHw7OBRbjuUs2bs5bpvaD91W_aj5e3a9g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 12:14 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 3, 2017 at 4:31 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>
>> Just to throw out an example, I'm relatively new to the codebase (I've
>> been lurking on the mailing list for a few months now) and for a
>> recent project (I'm an undergrad wrapping up my senior year, and one
>> of my classes' final projects was to do something that involved
>> concurrency) I took a shot at parallelizing the estimate_similarity()
>> calls in diffcore_rename(). The only way I was able to get it to work
>> was by dropping global mutexes in one or two files (the code for those
>> mutexes still makes me cringe), because of concurrent writes to global
>> data structures.
>
> That sounds like a challenge. As we have many globals, we need to be
> very careful about threading.
>
> Also an interesting discussion about threading:
> https://public-inbox.org/git/9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com/

Thanks.

> Are the patches available for discussion?

I was planning on revisiting the patch series before sending it out -
the changes in attr.c and sha1_file.c are not pretty (and I'm pretty
sure one of them is non-portable) - but it is published at
https://github.com/sxlijin/git/commits/parallelize.thread-pool.1 (it's
based off v2.12.2).

> Thanks,
> Stefan
