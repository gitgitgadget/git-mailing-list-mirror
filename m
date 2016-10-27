Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406F820193
	for <e@80x24.org>; Thu, 27 Oct 2016 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942524AbcJ0ORy (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 10:17:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33744 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942398AbcJ0ORw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 10:17:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3so2047378lfn.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JQKniyT1pqjsfXqS4R0hF/S7JAGbOxRePLgd7QWcjts=;
        b=OVTl7WYff4i3MFmFuK4Uhw2dKzYtaC8ci9/+HF0e15JFa3AThmIFgdOHJVG2tiDWu2
         3TV5p4etaM3dYnn3gOzbw5TkZ5aM/Y0aT/FnOPeBSRcCZ5Q6PUzzhP9xaBK+TULeDUxG
         jjgp4QeKhfWsLirfMiNtpH6VjzCfAKvOHXJ9nyd2D+0CELoVzyUrtDRlvemDkURiRSTe
         mh3omsA/HeFMoH1xZ7NX+ERtNBWu1UjqxG+pQW86OIQ5CzF1ZUKR29VPHgWqx8NhBBjQ
         sxMTqyTyxcU7bN1nirvKS5yws4ZW/Jo8xwjWJKJraYwEuaWSSq4yfqxff7L8cgYGF1nr
         3Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JQKniyT1pqjsfXqS4R0hF/S7JAGbOxRePLgd7QWcjts=;
        b=WMQCI0BcX9Ukq0GIr9lxDdjAYNmEIFsd3iItz/wfc7A6AwBSMWAHy7oIZH/62bqRoC
         kgPrLbsrmjwfMErXJA2qdPLKLWUT5kIkAL4Ts6nwrTfAzcZVVIk76qZQesb64Wp5J952
         EEwZ9bgPd2o3e5ijlKgapYKjSQity737jq39WH2yO17SbKsBEbjoi/EA21KDOYwGJ8sJ
         ezn9ljvYM2TFn+gp3DJzvZKDJEpJySWezFesHPrn0D9MBjbtFyjDOQx6J4+cDZqWEXVq
         NRrHRpNxXROMFzk+vXmAsL/sUwJsAnPvVXf5Sfc6cEXQyz0rHmPHansQAAPTWogyvrgG
         nT0A==
X-Gm-Message-State: ABUngvfdTlfj+NLK0bLyNXT7gBXjvII18EGQ7u7VN1R8SuKpjkB+btS0pi/+EPd9SL9doQFLbxkv4BlbAk8ZiQ==
X-Received: by 10.25.24.39 with SMTP id o39mr5350475lfi.151.1477570468764;
 Thu, 27 Oct 2016 05:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Thu, 27 Oct 2016 05:14:28 -0700 (PDT)
In-Reply-To: <CACsJy8BPe085Qu4GpJ3MLTPeZM_7pbVrX31enQrGQn0oyjSrdg@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-17-chriscool@tuxfamily.org> <CACsJy8C4Qd76LSYxk9BJtN3n3Knv_RCDgBOO-ybkNHFZK61ahQ@mail.gmail.com>
 <CACsJy8BPe085Qu4GpJ3MLTPeZM_7pbVrX31enQrGQn0oyjSrdg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Oct 2016 14:14:28 +0200
Message-ID: <CAP8UFD0uiQ5RFYPqGizUqPb-QoTHjrJJmmj4ZXLyBnpJcoyGKA@mail.gmail.com>
Subject: Re: [PATCH v1 16/19] read-cache: unlink old sharedindex files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 12:25 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Oct 25, 2016 at 5:43 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>  static int write_shared_index(struct index_state *istate,
>>> @@ -2211,8 +2269,11 @@ static int write_shared_index(struct index_state *istate,
>>>         }
>>>         ret = rename_tempfile(&temporary_sharedindex,
>>>                               git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
>>> -       if (!ret)
>>> +       if (!ret) {
>>>                 hashcpy(si->base_sha1, si->base->sha1);
>>> +               clean_shared_index_files(sha1_to_hex(si->base->sha1));
>>
>> This operation is technically garbage collection and should belong to
>> "git gc --auto", which is already called automatically in a few
>> places. Is it not called often enough that we need to do the cleaning
>> up right after a new shared index is created?
>
> Christian, if we assume to go with Junio's suggestion to disable
> split-index on temporary files, the only files left we have to take
> care of are index and index.lock. I believe pruning here in this code
> will have an advantage over in "git gc --auto" because when this is
> executed, we know we're holding index.lock, so nobody else is updating
> the index, it's race-free. All we need to do is peek in $GIT_DIR/index
> to see what shared index file it requires and keep it alive too, the
> remaining of shared index files can be deleted safely. We don't even
> need to fall back to mtime.
>
> git-gc just can't match this because while it's running, somebody else
> may be updating $GIT_DIR/index. Handling races would be a lot harder.

Yeah, I agree that if we disable split-index on temporary files and on
commands like "git read-tree --index-output=<file>" then it is the
right thing to do it in write_shared_index(). (In fact when I wrote
the previous RFC series I didn't think about those special cases, and
that was the reason why I did it like this. So I just need to go back
to the implementation that was in the previous RFC series.)

I am just still wondering if disabling split-index on temporary files
could not have a bad performance impact for some use cases, but I
guess we could always come back to problem again if that happens.

Thanks,
Christian.
