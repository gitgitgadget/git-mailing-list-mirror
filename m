Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B471F406
	for <e@80x24.org>; Thu, 10 May 2018 17:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966668AbeEJRcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:32:11 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39343 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966615AbeEJRcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:32:11 -0400
Received: by mail-yb0-f196.google.com with SMTP id f138-v6so915207yba.6
        for <git@vger.kernel.org>; Thu, 10 May 2018 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=snwZnhJml0bd9W+6LIlbD8ONOXj13BF9dedJ9yNKVww=;
        b=pJOLDCOSvVc8AQjooItZ1zZsYjDFBBXL8rwp5WYNSS8CV84lUFaSsqnjvULpVY4hvR
         OGzUPbE+S7SQwLRSvOR1sKLOPJ1HOboDeM7q3h4Z7t12x6wcVCljq0wCn8LYHCGeNhMg
         mRlLw+LT+WCWnoFKglQ3g5+qMHK1OLjBR96E3xibKt/zC0xCJQfH+m6Qu9pQb/ntktbz
         Do0HYw8aaZDaT1tSbEDgqCiGlWQdtGnulai+x8k9u9KT7whv3I+VUqVdqUPgpMHRu/80
         NNJeGc1s3LgWueNuiPYagL37sRtSggRJloNJZoZcGho42Ka2X6n1xX32cCUI7gC9mzy1
         ct8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=snwZnhJml0bd9W+6LIlbD8ONOXj13BF9dedJ9yNKVww=;
        b=MfLNjNa2F6sTIwo/jKUHJgXe/1nrSxHWJbhF/y4FgqJynxcLzm16RKT0EsarvUNhZI
         /ibMeY7y+Dwla1/J0e8h+Pa/W/FQv9KsheCZVCiZD3LiQsXXu/lyf1r8bV8F6E8yP86D
         UgQA77I3wi0wKD5U8uOKFJdEDpLhBpXJZAF+LrcEm4H/fwYCT3349fV5Yxz0uDur/cIB
         nKaOJSlRePDSFA3rArjbvDnmaS7LRag4//cgfXdlyOs8ATOTw7++aLSen941eRubp212
         YHQMhELBy/6eTUlS9uG5JOoCEh8l76sBGHWKV9ipEBY1h0oXUtax+Z2p9LFBQ17Wp0Bh
         eUvQ==
X-Gm-Message-State: ALKqPwc4suWvLQ4CGp1bw9TXDu88Jevk7v3wWEahD/gihhjVDnILs0wB
        MVT2v0KDl5zpDaTJ/o29BZf2IS85sb3qsiM58CIJlQ==
X-Google-Smtp-Source: AB8JxZosJVRGOddrl3+U04g1oFOmfLKpVQQNJAkdJ7Ym0LWX4vY363uG5Sc84JZy1jY4jCzJw0Ktnm38j6kDfBC/280=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr1297178yba.352.1525973530228;
 Thu, 10 May 2018 10:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 10:32:09
 -0700 (PDT)
In-Reply-To: <20180510101615.931eb0d219eac4c84cf8140d@google.com>
References: <20180508193736.14883-1-sbeller@google.com> <20180510004024.93974-1-sbeller@google.com>
 <20180510101615.931eb0d219eac4c84cf8140d@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 10:32:09 -0700
Message-ID: <CAGZ79kab0RDE1D81-uxrJPRQF7LoWkTfHj=nLntd8v2cz8THHg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] object store: alloc
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:16 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Wed,  9 May 2018 17:40:11 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>>               if (obj->type == OBJ_TREE)
>> -                     release_tree_node((struct tree*)obj);
>> +                     free_tree_buffer((struct tree*)obj);
>>               else if (obj->type == OBJ_COMMIT)
>> -                     release_commit_node((struct commit*)obj);
>> +                     release_commit_memory((struct commit*)obj);
>>               else if (obj->type == OBJ_TAG)
>> -                     release_tag_node((struct tag*)obj);
>> +                     free_tag_buffer((struct tag*)obj);
>
> This might seem a bit bikesheddy, but I wouldn't call it
> free_tag_buffer(), since what's being freed is not the buffer of the
> object itself, but just a string. If you want such a function, I would
> just call it release_tag_memory() to match release_commit_memory().
>
> Other than that, all the patches look fine to me.
>
> Some optional comments (this is almost certainly bikeshedding):

Who doesn't love some bikeshedding in late spring?

>
>  - I would call them release_commit() and release_tag(), to match
>    strbuf_release().

Why not commit_release and tag_release to also have the same order
of words as in strbuf_release ?

>  - It might be better to just inline the handling of releasing commit
>    and tag memory. This code already knows that, for a tree, it needs to
>    free its buffer and only its buffer, so it is not much of a stretch
>    to think that it similarly knows the details of commit and tag
>    objects too.

We still call out to free_tree_buffer? Not sure I understand.
