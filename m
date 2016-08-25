Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32261F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757710AbcHYUqf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:46:35 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36531 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbcHYUq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:46:27 -0400
Received: by mail-it0-f47.google.com with SMTP id e63so295483238ith.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jXCUNxW21vhzOV7xW4LIg+aAxvWpdksR+nBTPzrChbY=;
        b=YJkJfVs8KsQkAIICyU2JOPMioyIKcbbaGwnuEpIFMX4UgSi+3WDM/6wZt+aWRksOAy
         Y+sscPN315sPmqo5E2ghMYb7S0QrPMtjfpljHJxA58T/t+vnt+wAjBdcY6pSx3w9YkQD
         dMLcw+I4AyTSh2IhNkNoZhCXEEG4+KoQXcxPot3lxkFixB4ikP0FFuX7pbmo2UEY4cV3
         KObQgGD/IVfb+UNYDLJ66s2tjViNJTczDQJPe46F3AWD3aeBInUILkpGcqpR/+Ak+DAq
         6vXp84cTCJYf38e0+kaBzwU3YiNKWjPoQKNJVMFezRjPPUJaiCRwE6V/y/9d0fQy8llP
         TRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jXCUNxW21vhzOV7xW4LIg+aAxvWpdksR+nBTPzrChbY=;
        b=jqazeW33HrmGCGMXwgkYHdSz0pMD9T1BiY2k1RhD5lKkTNDkGcA9zZyS0pYc4/MXux
         c/gNTD7t5BHQVr+/LnUBXkUwPJCv4/llQ0CNXT9xWct8vYEbFo+RGUyHwIqC6eEHjhXS
         WNbuqJCZDz1yCykzt+es0oJ+WgZbHRfFRV/3MeH0T0a/QS0xcf8i5QOGFoIreux0YBMQ
         1djmVP4ob8Nnk+R3xbT5/qsOFN9SUerHtjsYk8MsSAXY0wBWbwezHxuWwMz67inZHsPd
         WDiBF8kEYnedSh7l9uQbGs9f2n8O4NJwsHuMZYhwVj/8KSyT5LF2W7QP+xKbI+dw59zS
         iCEQ==
X-Gm-Message-State: AEkoouum0qIBNwo48x61zOBqp+Jy7vwgefbbAvfXCos0Nav0xSRAXr8CzjuzmHfocP3rMMmaoItkI4HOxztO8j80
X-Received: by 10.36.249.5 with SMTP id l5mr7710049ith.46.1472157960765; Thu,
 25 Aug 2016 13:46:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 13:46:00 -0700 (PDT)
In-Reply-To: <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
 <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com> <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
 <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 13:46:00 -0700
Message-ID: <CAGZ79kb3tRU5vLDMWzEC=bx9Givd8pqFsAzTBy0unxXfKpNnUw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 1:39 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Aug 23, 2016 at 10:47 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Aug 23, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I am not so sure about that.  If there is an existing place that is
>>> buggy, shouldn't we fix that, instead of spreading the same bug
>>> (assuming that it is a bug in the first place, which I do not have a
>>> strong opinion on, at least not yet)?
>>>
>>> Can there be .git/modules/<foo>/ repository that is pointed at an
>>> in-tree .git file when there is no "name" defined?
>>
>> If you're holding it wrong we can come into that state.
>> * Checkout the submodule,
>> * then remove .gitmodules as well as relevant config in .git/config.
>> Result: Then we have a only a gitlink recorded as well as connected
>> working tree to a gitdir inside a superprojects .git/modules/.
>>
>
> Yea, but I think you're right that we shouldn't support that state.
> What I'm worried about is the case where we can get this state doing
> something sane/acceptable but I don't think we can.
>
> So we should support the gitlink to a repository stored at <path>
> without stuff inside the .git/modules, and we should support submodule
> gitlinks with a proper .gitmodules setup. I don't think we should
> die() but we should error properly so I will introduce a _gently()
> variant of these functions, and die properly in the regular flow.

ok, thanks!

>> Stepping back a bit, I think we'd want to document this expectation more
>> in the man pages
>>     The name unlike the path of a submodule must not be changed (as the
>>     name is used internally to point at the submodules git dir)
>
> Agreed, this should be documented. Do you mind doing the documentation
> patch for this?

Well that documentation is sort of unrelated to this series, so no pressure.
I have a revamp of the whole submodule documentation on my wish/TODO list,
including this.

Thanks,
Stefan

>
> Thanks,
> Jake
