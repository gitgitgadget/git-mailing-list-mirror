Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DE41F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbcIAVpf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:45:35 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33843 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbcIAVpb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:45:31 -0400
Received: by mail-oi0-f42.google.com with SMTP id m11so10269512oif.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 14:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/dzpuUBUh74rO6j6IKqiPxXxKCeKPrFrKf5kibczFWY=;
        b=ZVQIn2U3TMslmFqPr/eHwZsp4YNAo0xq3ZAyeAF2fjg8xMz9NouurpJuh2hUJvRwFG
         BoxefzQ+Bx1QtoG315fbtKVE/agl07rgzYB3o1wkYrGCsqlTeReMErBEQQANMkBgOa22
         UNR6iIEXytcf74DDzjWh60Sj1oNf3s8z2cF6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/dzpuUBUh74rO6j6IKqiPxXxKCeKPrFrKf5kibczFWY=;
        b=looYEppa0xk5R4/OYYJOHbSb+9JQH/HrsHO5T6/RLqS72CInXFAcNCWFiH1bHWPMtV
         ZuVWj5Fws4IdS4dSHiJYN4TwTROkUeCmFWVVmM7KIQ9Sh/olzlqp90+10QLBBp2vd3l9
         jaQxGT7+b4uxPc4buWVpFxP9wRfbJCfG1Ts64Xxb7+M6Jz9vV0hSLphxnqnfgr0Gdh3y
         Snsg5eiFppQmiftDQ0chdXeWv6Pku+O76LGsRub3d2ITEnmgC4kINRD7mlgwmKVYQffD
         5wmejAl6smpPfKpEa8lNx6SLThB6+qqbd49eLGh40ZPu3PiZ8qlSMXxqZ8z4OBNg5QzH
         BglA==
X-Gm-Message-State: AE9vXwPI7wjqGIJQzFDThK6aeIz0c38YC8c7BvU0e2VtsR4dPFPAhhR4lGf0KjiGOvyaNZvUTPS4gNnBOuxXD0/z
X-Received: by 10.202.97.198 with SMTP id v189mr15210550oib.54.1472759778543;
 Thu, 01 Sep 2016 12:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Thu, 1 Sep 2016 12:56:17 -0700 (PDT)
In-Reply-To: <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
 <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
 <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com> <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
 <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Thu, 1 Sep 2016 12:56:17 -0700
Message-ID: <CAN5XQft1YFEdxcB8Q_qFG4iYmSaSX_JXDCESzeEyYqPO0BUbaw@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> The final version needs to be accompanied with tests to show the
>>> effect of this change for callers.  A test would set up a top-level
>>> and submodule, deliberately break submodule/.git/ repository and
>>> show what breaks and how without this change.

Agreed!

The repo where the original problem surfaced is huge and in fact "git
status" appears to go into an infinite loop forking a zillion
processes on the system. If the dev system is small, it brings it to a
standstill. However, the good news is that I could build myself a
smaller reproducer by doing the following:

1) mkdir sm_test
2) cd sm_test
3) git clone git://git.mysociety.org/commonlib commonlib
4) git init
5) git submodule add ./commonlib/
6) cd commonlib/.git
7) rm -f all files

After this "git status" will fork several thousand processes but it
will ultimately fail as it runs into the path length max limit. I
still don't know why this doesn't happen with my original problem
repo. Perhaps I have to let it run overnight or perhaps it runs into
other system limitations before then....

Anyway, with the fix "git status" fails quickly both in my reproducer
(and original repo) with the following message.....
fatal: Not a git repository: '.git'
fatal: 'git status --porcelain' failed in submodule commonlib

Hope this helps.

Uma


On Thu, Sep 1, 2016 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> The final version needs to be accompanied with tests to show the
>>> effect of this change for callers.  A test would set up a top-level
>>> and submodule, deliberately break submodule/.git/ repository and
>>> show what breaks and how without this change.
>>
>> Tests are really good at providing this context as well, or to communicate
>> the actual underlying problem, which is not quite clear to me.
>> That is why I refrained from jumping into the discussion as I think the
>> first few emails were dropped from the mailing list and I am missing context.
>
> I do not know where you started reading, but the gist of it is that
> submodule.c spawns subprocess to run in the submodule's context by
> assuming that chdir'ing into the <path> of the submodule and running
> it (i.e. cp.dir set to <path> to drive start_command(&cp)) is
> sufficient.  When <path>/.git (either it is a directory itself or it
> points at a directory in .git/module/<name> in the superproject) is
> a corrupt repository, running "git -C <path> command" would try to
> auto-detect the repository, because it thinks <path>/.git is not a
> repository and it thinks it is not at the top-level of the working
> tree, and instead finds the repository of the top-level, which is
> almost never what we want.
>
