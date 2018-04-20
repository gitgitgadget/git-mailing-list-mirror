Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45D71F404
	for <e@80x24.org>; Fri, 20 Apr 2018 05:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeDTFH7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 01:07:59 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36953 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDTFH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 01:07:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id p6so3723014pfn.4
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 22:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n3FcNj5rsNPsqH11/wUbzva4NnXMBDc7OielEzcS/lU=;
        b=T94vGGDqxHKwN8zFguOVIMoeV0VZ8Teo10kTKTt0tgphKssOmgNrF//UsJIQelS+aP
         51J47eVScBAnfUyRCJhgaUO1d6kG85YXMrL+RK1FAO6GZwOZSsXVzrufLBIGgNLsun7t
         mAVQxRyd5uhsdrdz5a1UQcdF4ZEiJg+DSLNKFSi30o6jim1GULOX4koiL4OipASA2SLh
         sZAZzk+ulj4QaJpY66m2bfzkEiQrFDwQbsVF44Q3HCnBQccj1aiXRsZhamld2tSzLn1N
         4Od1n5A8y8fB3KNHCKMZGxzl/CRLqRGC4wZJQUwUYojwUIXUT/pbpb7yM8LgT9I21SoT
         qG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n3FcNj5rsNPsqH11/wUbzva4NnXMBDc7OielEzcS/lU=;
        b=EltkXGH4XBbrEBGQnnOecPzVWb1LQ9XwUfBoVeBdrpLuIau3uaNuaw1/Uy2Wxuh4R0
         9poPJO5fi5fxHKl7jWUhWivFekV6DaiMJXsd4fQvHSZiVaN0q96fUXSMfFSF6tH2K0DZ
         Pyfqu2+fZAVPkNcn6FU4Kl5O25rKv3Mz29ege/Zc85PaT2ZvRxnAGmL9QU99MpM0pBEz
         7etffXXxAU1srlSMTc2/bTAwdF/YmecLwBjzn2fRv016cxRy84gr8q+6gH8tVqiyf2GH
         YDTk+rvDA3Vs7dMT7zFGTLisXLTA8y9tvOsQS1/3fO+kmTjwgX83LEIv8/MuuQSFqz1Z
         Yg7Q==
X-Gm-Message-State: ALQs6tBtwhHAvy5lSl41t8RuTCMbOHbaUupscMTn8l9rppin6ghfQPPj
        cCBrHBK8whfBHjHb/Sw+DEi8AAiX+FUaO0m8dDY=
X-Google-Smtp-Source: AIpwx49h/jzK+LdCMglwA5bkdKCuBkpsOBKr6/4wYb0On8KMHVpuJXM2Trmlx4OI6H5MVwFlhS7yOihq6yptZzgxJPo=
X-Received: by 10.98.31.20 with SMTP id f20mr8431433pff.196.1524200878078;
 Thu, 19 Apr 2018 22:07:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Thu, 19 Apr 2018 22:07:57 -0700 (PDT)
In-Reply-To: <xmqq604mertl.fsf@gitster-ct.c.googlers.com>
References: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
 <xmqq604mertl.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Apr 2018 07:07:57 +0200
Message-ID: <CAN0heSo9bdvNNzwX5-7nHXxg9_oZrsDixzwQmx6gnEtwny2NOA@mail.gmail.com>
Subject: Re: [BUG] Git fast-export with import marks file omits merge commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Isaac Chou <Isaac.Chou@microfocus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 April 2018 at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
> Isaac Chou <Isaac.Chou@microfocus.com> writes:
>
>> I inspected the source code (builtin/fast-export.c) for the
>> fast-export issue I encountered, and it looks like the merge
>> commit is discarded too early by the call to object_array_pop()
>> after only one of the two UNSHOWN parents is processed in the
>> method handle_tail().  The poped merge commit still has one
>> UNSHOWN parent, therefore it is not processed and is lost in the
>> output.  Can someone advise me on how to submit a code change or
>> bug report in order to get the fix into the code base?
>
> There indeed are some differences between v2.14 and v2.15 around the
> code that returns early when has_unshown_parent() says "yes" [*1*],
> but the decision to return early when the function says "yes" hasn't
> changed between that timeperiod---it dates back to f2dc849e ("Add
> 'git fast-export', the sister of 'git fast-import'", 2007-12-02),
> i.e. the very beginning of the program's life.
>
> I'll CC those who wrote the original and b3e8ca89 ("fast-export: do
> not copy from modified file", 2017-09-20) and 71992039
> ("object_array: add and use `object_array_pop()`", 2017-09-23),
> which are the only two commits that touch the surrounding area
> during that timeperiod, to ask if something jumps at them.
>
> Thanks.
>
>
> [Footnotes]
>
> *1* An excerpt from 'git diff v2.14.0 v2.15.0 builtin/fast-export.c'
>     reads like so:
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d412c0a8f3..2fb60d6d48 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> ...
> @@ -630,15 +645,15 @@ static void *anonymize_tag(const void *old, size_t *len)
>         return strbuf_detach(&out, len);
>  }
>
> -static void handle_tail(struct object_array *commits, struct rev_info *revs)
> +static void handle_tail(struct object_array *commits, struct rev_info *revs,
> +                       struct string_list *paths_of_changed_objects)
>  {
>         struct commit *commit;
>         while (commits->nr) {
> -               commit = (struct commit *)commits->objects[commits->nr - 1].item;
> +               commit = (struct commit *)object_array_pop(commits);
>                 if (has_unshown_parent(commit))
>                         return;
> -               handle_commit(commit, revs);
> -               commits->nr--;
> +               handle_commit(commit, revs, paths_of_changed_objects);
>         }
>  }

Indeed. This looks wrong and the guilty person would be me.

If my 71992039 ("object_array: add and use `object_array_pop()`",
2017-09-23) would instead have done something like
s/commits->nr--/(void)object_array_pop(commits)/ it would not have
screwed up as much. It could also use a peek+pop-pattern.

Isaac, are you up for submitting a patch? Just let me know if you
encounter any issues. Otherwise, I can submit a patch shortly since I
was the one who dropped the ball originally.

Thanks for diagnosing this.

Martin
