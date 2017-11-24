Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB15D2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbdKXUHd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 15:07:33 -0500
Received: from mail-ua0-f173.google.com ([209.85.217.173]:46442 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbdKXUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 15:07:32 -0500
Received: by mail-ua0-f173.google.com with SMTP id 21so15380235uas.13
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0lG30RVF5oKAk6leVF9jfvhqkJf3tNfd3viF/RkeoTg=;
        b=igrvZhviKn+vvAaQUtgZ1h56/O22tpdG8px3wotvf4sekbzyeeEVmsXKrHH95lEMI2
         TzfbQoCrAjCnyVZXnhFVHBDIGCz1k4ACK9jy16DW8rr2fVpK1/r7wsLkRxpulTv77wj/
         IF0iQ05mucjZWJpqDMoRkugIrx/4jUtNJHNIbq3p7SN9JXIm6RNv8OKAn7hGrZKkEUtB
         9zjTfxugOiqjyyOf6R+1ZQNzMh7qcolXhIgWiZLfhUQuVpvquMl81bNzqUl2S7I0xA3Z
         nQDimOLFgXGOcDBf2mIJXJ+MOlAsVU3noQ5AChMp80bEEHq9lHWwF+jYrA7vRNd+mRgM
         aJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0lG30RVF5oKAk6leVF9jfvhqkJf3tNfd3viF/RkeoTg=;
        b=feRKR5Hfl3JrwpoNY4ex6+8J7ITxwvj+obVvX4tYgKnH1/JPCS8hdD1WhdhXq0jVYU
         FnasTGjXlL1EZzyD0aVsoOBixICcvDiVw2y/z3x6HZVp1sE4OJQkzoT14Ja7BYa1oDh5
         hSyftIPjZnu53k/3bvZSBShOMWx7fxKZvL+G8Hap+MHsuqA0oOYyHQfE8ckc3O7fTpO0
         EkI5vpq9evY5Hu0Q2VW6MAIbhsZ5ws6LouSU0bZmrnN/KqJE+EPZaFI8WxbU+2Tji/fd
         h58YQ5v0TwRSfVvnlUfuWJNeILVpBTJQmIKd5c5bovmBQjbDpY++0FU0d9RQG7IKl69H
         6Hkg==
X-Gm-Message-State: AJaThX500THbP7cdLtMBJt4/4IePthA0pvCTW9ieEBnvPIQhN/3AKj+W
        IH1VMKZGVIUUjyMc3XcorjHdFxBWjtWxDRjiN+A=
X-Google-Smtp-Source: AGs4zMZZ+jDyyHxOvVgdRS7Pr3EmWyJBUjXs2Rxx0Fv2A5+LbTl78e1rOlIMGOEGDDSoYTKtMns4s3eF+oLwvXCsaEk=
X-Received: by 10.176.82.73 with SMTP id j9mr15544695uaa.9.1511554051607; Fri,
 24 Nov 2017 12:07:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Fri, 24 Nov 2017 12:07:30 -0800 (PST)
In-Reply-To: <CABPp-BHc8zznHyRqaJ-KvDnLu3qWDZESH2982NsZx=BHWU00UQ@mail.gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <20171123115246.GV20681@dinwoodie.org>
 <CABPp-BE5-MCUfUAdOBv4zYRJxqAiGdv-JGrrzQoo9SUiQwWKYA@mail.gmail.com> <CABPp-BHc8zznHyRqaJ-KvDnLu3qWDZESH2982NsZx=BHWU00UQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Nov 2017 12:07:30 -0800
Message-ID: <CABPp-BEJ6-mrY0OCz1WWetrtG_iehKzOdCUOn_PUuKVywaU9Zw@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 9:25 PM, Elijah Newren <newren@gmail.com> wrote:
> On Thu, Nov 23, 2017 at 2:28 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Thu, Nov 23, 2017 at 3:52 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>>> On Tuesday 21 November 2017 at 12:00 am -0800, Elijah Newren wrote:
>>>> <snip>
>>>>
>>>>  merge-recursive.c                   | 1243 +++++++++++-
>>>>  merge-recursive.h                   |   17 +
>>>>  t/t3501-revert-cherry-pick.sh       |    5 +-
>>>>  t/t6043-merge-rename-directories.sh | 3821 +++++++++++++++++++++++++++++++++++
>>>>  t/t7607-merge-overwrite.sh          |    7 +-
>>>>  unpack-trees.c                      |    4 +-
>>>>  unpack-trees.h                      |    4 +
>>>>  7 files changed, 4985 insertions(+), 116 deletions(-)
>>>>  create mode 100755 t/t6043-merge-rename-directories.sh
>>>
>>> The new t6043.44 introduced in this branch is failing on my Cygwin
>>> system.  I can't immeditely see what's causing the failure, but I've
>>> copied the relevant verbose + shell tracing output below in the hope it
>>> makes more sense to you:
>>
>> Thanks for reporting.  Unfortunately, I have been unable to locate or
>> create a cygwin system on which to replicate the testing.  Valgrind is
>
> Nevermind; found a system that allowed me to reproduce the problem,
> even if it far more wrangling than I'd like.  I believe I have a
> one-line fix, but I'm worried that attempting to fully explain it will
> result in a novel-length commit message.

This issue is addressed by the commit at
https://public-inbox.org/git/20171124195901.2581-1-newren@gmail.com/ .
I opted to make it a different series, because from my view it looks
like a separate latent bug in the ignore_case handling that was just
unearthed by a combination of events that included my series.  It's
conceivable it could have eventually been triggered some other way.
However, that commit cleanly cherry picks to any of maint, master,
next, or pu, so If Junio just wants to just include that commit on the
top of the en/rename-directory-detection series, that's fine too.

Without that commit, I get the same failure you did on cygwin.  With
that commit, I get all tests passing on cygwin for pu as of yesterday.
(Well, all tests that ran; I didn't have svn or apache or p4 or
various other things installed.  Also, there were some unexpected
passing TODOs, but I've already seen others discussing those exact
testcases on the list elsewhere.)

Hope that helps,
Elijah
