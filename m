Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D941F6C1
	for <e@80x24.org>; Tue, 23 Aug 2016 07:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbcHWHXq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 03:23:46 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36409 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbcHWHXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 03:23:45 -0400
Received: by mail-yb0-f196.google.com with SMTP id f60so2313838ybi.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yHHuqByVzI8vc7vSN8lgUEIQXOolhR90tUPGN6bTkxo=;
        b=F9bxH/ur7viYcPW8OkWMzj/RchryHENAxICNBe+2EeZpZOBCvDu1ga9oVolWj3wudz
         zuNDzd3Jqir/YiRoZjySb+mmtbpgvroNmUzjXRYA39chVgXlwj6FnDoErgMtK2BMS6/Y
         zEnKXOgxrXLoZKjJyvlMSvHK6SpvkoQwkEHH05u2VpSB6dm1eNmENiLYjTKcjTtu5yv8
         S5S9hVTt/wSf99EXY69DfYiR7E2IayUSDaNGAuGOYkOIqQodAz68gurzXJdOBjC4dIub
         sB2mb7QKM1Iq+9mbd8AhN/+LypOMrNDswTJBQmoR2SC3z8wi11HmtA7t4qvD2xNTWQ5B
         meBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yHHuqByVzI8vc7vSN8lgUEIQXOolhR90tUPGN6bTkxo=;
        b=UrYJ3DcdO0dVsR35PXfuUDBZ74+9dqW93GaNXDzyFcdGWuHfxMJGLQosin4ZJjsgv4
         p6j3Yl3fTjR9kX6ZJsrdzJ7RSIgTU0/9BY1vDYXz/5gwhsH3N754GWIExmLB/w9PhOsM
         gyQ7jWj9HTWbRMlfwXOL7c72D7BDapsHg05EznGhM5qU9LAOQjl+oJ3rCHPWkJo60KHo
         /VLHFTfk0n6duGNA9dCVYmGuxUQrdGffE+KYETEP78mM9rVEVbDAoAdEhMX2wIAX8mYK
         UquTybhsA/w+o/gFM4FhjaolLm61wir9+qf30NBb1Iqf+3Ndwuvr+q0AAth9Wt7EVqLD
         g5Tg==
X-Gm-Message-State: AEkooussp63IDWswuytQX5mrXSshMmjmGp7H3NVVW8WuCdcfnbYOZ2z8cVj3DyjcPMoH3K0vaEpRp7Scc78cVw==
X-Received: by 10.37.60.67 with SMTP id j64mr19529763yba.111.1471937024921;
 Tue, 23 Aug 2016 00:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 00:23:23 -0700 (PDT)
In-Reply-To: <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com> <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 00:23:23 -0700
Message-ID: <CA+P7+xqvwp74EvxGtm_anKTJW3f=JxJvJywrz-59_eRr0x9rVw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 6:00 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Aug 22, 2016 at 4:43 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> A few suggestions from Stefan in regards to falling back to
>> .git/modules/<path> being a bad idea. I've chosen I think to avoid using
>> die() as we just stick with the current path if we can't find its name.
>
> Which makes the existing bug more subtle :(
>
>> I think this should be safe since we already do this today.
>
> It's a bug today already. Thanks for spotting!
>
>> The new flow
>> only changes if we are able to lookup the submodule, so I don't think
>> it's worth adding a die() call.
>
> Well this series improves the buggy-ness as it is only buggy when the name
> is not found, and we fall back on the path.

Which should fail because we already failed to read the file correctly
previously to this?

What should the correct behavior be?

We need to support a few things I think:

a) checked out and initialized submodule

b) initialized submodule which is no longer checked out

c) repository checked out but not initialized, (ie: a fresh clone that
is then added via "git add" after the fact (?)

Any other scenarios we care about?

What about:

cloned, added, then the files removed.. should we actually die() in this case?

Any other things we need to handle?

Thanks,
Jake
