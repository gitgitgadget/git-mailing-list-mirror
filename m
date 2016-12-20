Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927FC1FF40
	for <e@80x24.org>; Tue, 20 Dec 2016 01:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754688AbcLTBjr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 20:39:47 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34724 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbcLTBjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 20:39:45 -0500
Received: by mail-io0-f196.google.com with SMTP id y124so21089609iof.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 17:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hHwHfKJiGAwABQGq/3YPpTRAkZqqx0miBH0Hfv2mY2Q=;
        b=f62jSnJ5wtjUzkw26inVrU1FqwOpmzqmM4kBTkF8JQUBaX6o6QRyNoX/DklGrTE0aq
         G4XricFxqtK8MxBFYtELXwwKm2luaKHkwkN1t5K5ei7jyJKJEHzTNH2qZFScJctvzQ1Q
         HhT65rObUpFuQMCTR+7W09LfdS6ZdhuUGBDg2ahUK/ygXIOQX/Ao5deEBY4coU0aSpSq
         moYrcd1jpTTQYFdJqxSbVxvsUBfwbG06PxpRiec4iIhTXQ+HUoJnqNdYpDPoS2SLko4R
         eFxqqb98HofYodr+KZf5/VsDa1SFbX75qzJKcoYTrvHcydL72G316QQ/vWKcvTxtgpJ6
         FZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hHwHfKJiGAwABQGq/3YPpTRAkZqqx0miBH0Hfv2mY2Q=;
        b=mNQMkYHbvQr3j2OPi9zfWecxZ37AqPEBaioT7rRgEkNW65oy/1pr9pNRpLiTyobLm7
         D0yk5uGGNNLGB0Igmab5PyKZK0VHo9AHhwCzBFBYvo62yykjuG8M6vE2WCnbHeOI/mb+
         XMaKt1tTLSg7sPrDrxeo8boLiAWOSPD85EUkZ9xwnyrpp90zXv5MmhCZFmmlscK60R3R
         L/iBxZNQj1crEyoIoS5s3hmBD+sui4BqwZelORNTJJl+pmO/AYDmsSD5zN0NTEdHWxxD
         mNQk7Jq8jxOPIlwUDPgDV1dyMsrQezAER9M+lxV/rZrGI8FXAtPdc1eRcmmkdiq0ySdm
         Ahig==
X-Gm-Message-State: AIkVDXJvDeeYUcguWM5KxJpXnLP8ar920LEuJ+tHSzaZTctrVJ48EGpTSI0w151fdGDq86eIY1lCRoQaCFPtlQ==
X-Received: by 10.107.59.9 with SMTP id i9mr21214505ioa.176.1482197984970;
 Mon, 19 Dec 2016 17:39:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 19 Dec 2016 17:39:14 -0800 (PST)
In-Reply-To: <CAGZ79kYPEiUGXR-qTbbHzaeOwbHH88mdx7GP8QX2Ff1bypcrwQ@mail.gmail.com>
References: <20161212190435.10358-1-sbeller@google.com> <20161212190435.10358-7-sbeller@google.com>
 <20161219053507.GA2335@duynguyen.vn.dektech.internal> <CAGZ79kYPEiUGXR-qTbbHzaeOwbHH88mdx7GP8QX2Ff1bypcrwQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Dec 2016 08:39:14 +0700
Message-ID: <CACsJy8BWMXBN8gXRavGbtuSJkV6AcYaqgGohA5mhEw8MNrQMzg@mail.gmail.com>
Subject: Re: [PATCHv8 6/6] submodule: add absorb-git-dir function
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 1:15 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Dec 18, 2016 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Dec 12, 2016 at 11:04:35AM -0800, Stefan Beller wrote:
>>> diff --git a/dir.c b/dir.c
>>> index e0efd3c2c3..d872cc1570 100644
>>> --- a/dir.c
>>> +++ b/dir.c
>>> @@ -2773,3 +2773,15 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>>>       free(work_tree);
>>>       free(git_dir);
>>>  }
>>> +
>>> +/*
>>> + * Migrate the git directory of the given path from old_git_dir to new_git_dir.
>>> + */
>>> +void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
>>> +{
>>> +     if (rename(old_git_dir, new_git_dir) < 0)
>>> +             die_errno(_("could not migrate git directory from '%s' to '%s'"),
>>> +                     old_git_dir, new_git_dir);
>>> +
>>> +     connect_work_tree_and_git_dir(path, new_git_dir);
>>
>> Should we worry about recovering (e.g. maybe move new_git_dir back to
>> old_git_dir) if this connect_work_tree_and_git_dir() fails?
>
> What if the move back fails?

That's when you pray the UNIX gods that recovery steps don't fail :-)
This is why I don't _suggest_ to do things but just wonder about it.
In theory though, if we keep recovery to dead simple operations (e.g.
a series of rename() and nothing else) then it's less likely to fail.
I'll look at the new patches when I get home.
-- 
Duy
