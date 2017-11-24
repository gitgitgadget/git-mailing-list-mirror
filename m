Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB0E20A40
	for <e@80x24.org>; Fri, 24 Nov 2017 05:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdKXFZu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 00:25:50 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33788 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdKXFZu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 00:25:50 -0500
Received: by mail-vk0-f68.google.com with SMTP id o145so12926808vkd.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 21:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wVo5zrZWzj6oi8sklralXPDF0FHelygfXN2q+h2bXA4=;
        b=PjVvlw83hYQA5c72qY0ts0j2Krv14h8f1xWEaB2NN4ScG6XuxlL6mvqHvKkLKeQdDu
         aUjMUxXiwCnhYopbsJNHU8n0OBTjJURZLsAnBC/iLnblvLB97mtT/15Bx4aLApn/4lqH
         9bvsPDm/eTSj7zaA3KpClRovXDx+AmvFLtq7gohNzPZvX5hFluRO382g1d0KDv8jWdm8
         lYsEhaCPa+OJXLnEjEIIg/l5UwO2mCGoIwT0jcVyUIafG4tHGezDJevHxyMWOdjTSPNi
         PZbEIBaf7LOeJmTtmx7LRTXq9BqUD1jlTAxWHfpB0tW/3xRufOj09HzUrMsO+CKLub6V
         Eg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wVo5zrZWzj6oi8sklralXPDF0FHelygfXN2q+h2bXA4=;
        b=nQtwgT0E2HkTU1vjnncBAltXdpfDCejKc4cAGrx7SBnVqtWULBgFgX/onVN7gmgs/4
         R7vzZd16ZLBVqrqQWmkL8Kg3ifDjOw19p6ihD005Vf9XhYmBjqr6DzcBTf9olRu3xGB3
         z/z/ag0qMdDd6mBavaWh3GiITsGJZmwR6KNSw0t11cIwn0Nb77xu7nxs0zjuOH4FnMSL
         +901lrO6yhQedVVzpsh0VFoZIOso9NtAGZqfEJWIS9TBgLNP9t60kk9Q9s2/qy/36+7T
         Z4l5sVU3n/hdu9Tf+1KieK4yzrnPZWmMG4iPsAD2CymaZFHEIfPTucuTdla8kIWL6tmR
         bB1g==
X-Gm-Message-State: AJaThX6YGO2NoHqb7STJJe38yXIjRXnh5jLxRNOdCD0cuF4Lt7LAda5C
        Sidib2cF6Q+NxBb9V0VxdgLbd4nNP/xGP2YThTw=
X-Google-Smtp-Source: AGs4zMbEXCqKiiTCX1TfF0h/yZfl3U43KcbgDk6JtVfN1QXV0bk32rSJi7x1QP/EZkrL+49KVUM3M6dJU751Om8B3Ro=
X-Received: by 10.31.96.65 with SMTP id u62mr21052185vkb.68.1511501148997;
 Thu, 23 Nov 2017 21:25:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Thu, 23 Nov 2017 21:25:48 -0800 (PST)
In-Reply-To: <CABPp-BE5-MCUfUAdOBv4zYRJxqAiGdv-JGrrzQoo9SUiQwWKYA@mail.gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <20171123115246.GV20681@dinwoodie.org>
 <CABPp-BE5-MCUfUAdOBv4zYRJxqAiGdv-JGrrzQoo9SUiQwWKYA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Nov 2017 21:25:48 -0800
Message-ID: <CABPp-BHc8zznHyRqaJ-KvDnLu3qWDZESH2982NsZx=BHWU00UQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 2:28 PM, Elijah Newren <newren@gmail.com> wrote:
> On Thu, Nov 23, 2017 at 3:52 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>> On Tuesday 21 November 2017 at 12:00 am -0800, Elijah Newren wrote:
>>> <snip>
>>>
>>>  merge-recursive.c                   | 1243 +++++++++++-
>>>  merge-recursive.h                   |   17 +
>>>  t/t3501-revert-cherry-pick.sh       |    5 +-
>>>  t/t6043-merge-rename-directories.sh | 3821 +++++++++++++++++++++++++++++++++++
>>>  t/t7607-merge-overwrite.sh          |    7 +-
>>>  unpack-trees.c                      |    4 +-
>>>  unpack-trees.h                      |    4 +
>>>  7 files changed, 4985 insertions(+), 116 deletions(-)
>>>  create mode 100755 t/t6043-merge-rename-directories.sh
>>
>> The new t6043.44 introduced in this branch is failing on my Cygwin
>> system.  I can't immeditely see what's causing the failure, but I've
>> copied the relevant verbose + shell tracing output below in the hope it
>> makes more sense to you:
>
> Thanks for reporting.  Unfortunately, I have been unable to locate or
> create a cygwin system on which to replicate the testing.  Valgrind is

Nevermind; found a system that allowed me to reproduce the problem,
even if it far more wrangling than I'd like.  I believe I have a
one-line fix, but I'm worried that attempting to fully explain it will
result in a novel-length commit message.
