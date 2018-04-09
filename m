Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A10E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeDIRjd (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:39:33 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:44442 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeDIRjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:39:32 -0400
Received: by mail-yb0-f174.google.com with SMTP id m185-v6so3298130ybm.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4P16DfCL1wKBjZ4d0cYsdavqzdfxvG+6A0BJoU8yTGY=;
        b=nwF2z4m1b1eMNoGR1TT6KXgRGCgvv4aAWyN1+/EaTmOdRue9JJU1TFvmpEtopmdcGe
         jJm+gyasy0SKPwMmNmdazaVyQZ7yf7bdmXtkobcMk16fShq+ADIPdx1CQfutoGml45/8
         anw7qz4NIdDCDZGpO+HWjLKi8BZhZXLQKU6EN82icvXTIv1n9+mPGk0HGYwSa6e6qD3d
         wPAOfEVHhWNkCLTdbkvnnovdwsXpwI4kBtg6tnAl6iyYn0CrRa2GIKKWLWYToB+tg3dG
         IhnBpvGeryPzrQQgreheS/tVLul3TCo/eAh6ekeiMKye9gGIJt9+EY9NOqgPdcVnqZLW
         PAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4P16DfCL1wKBjZ4d0cYsdavqzdfxvG+6A0BJoU8yTGY=;
        b=tzNAVZy6swuIuj1KkzFjplVmU6eliqE81311/xXMjJ+4llF3Ux/N4eZF+JSvgcju8n
         XiJ0zpUWGweZk1nRRQAZvG4KqSwRkoQc/ucR/UPCxEZVYXZSM7aSj4qZI6NBF5gj6Q7n
         BdgtRqIkY6NGvx9EkaQVU/XG7hHcPzmctuRU7UFdXWhYuZWqQftNUezy+hbfiMRsT2uo
         zwvS53jAv38S7/Z9clIe8Ianl7Cr6fVlzVxOzw6XtYWRQOHHSShJUd+AiZn/xyP0Mtpa
         zF+RHH/AyxYrsC5rcXbcvGTFFBtu5DeP90hGRKLzmozapZQmZAQtenfSf6KsfbGkfVAM
         OXMA==
X-Gm-Message-State: AElRT7GYlmNdefSSXydqx52T4c5RPQQtGyvwa3Lg8mlpftNI4fmr3Pvg
        2zAokWJ7kpJzxR+8RTfz2ZRU/+KmjzEM83Az6OO6mC+U
X-Google-Smtp-Source: AIpwx48mzyEc58/3lYqh5m0tE8UjtimOKmX1UqVsWrvgJrjQS9tEYkrN1ltzvbVubCy0xVbwDiszfQRjNnEiiOEJ4KE=
X-Received: by 2002:a5b:143:: with SMTP id c3-v6mr17992298ybp.292.1523295571405;
 Mon, 09 Apr 2018 10:39:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 10:39:31 -0700 (PDT)
In-Reply-To: <CACsJy8BKKgfxUGm+SgOAENNsSaMGehU5NVbn6YuebCgUL4S0jQ@mail.gmail.com>
References: <20180406232136.253950-1-sbeller@google.com> <CACsJy8BKKgfxUGm+SgOAENNsSaMGehU5NVbn6YuebCgUL4S0jQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 10:39:31 -0700
Message-ID: <CAGZ79kaLDTY7zeG6f2pGE6ZJvScM-FunjLkeAqu_YsUQEoepqg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] object-store refactoring 3 (replace objects,
 main ref store)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 7, 2018 at 2:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Apr 7, 2018 at 1:21 AM, Stefan Beller <sbeller@google.com> wrote:     *
>> diff --git a/repository.h b/repository.h
>> index 09df94a472..2922d3a28b 100644
>> --- a/repository.h
>> +++ b/repository.h
>> @@ -26,6 +26,11 @@ struct repository {
>>          */
>>         struct raw_object_store *objects;
>>
>> +       /*
>> +        * The store in which the refs are hold.
>> +        */
>> +       struct ref_store *main_ref_store;
>> +
>
> We probably should drop the main_ prefix here because this could also
> be a submodule ref store (when the repository is about a submodule).

it's still the main ref store of the submodule, then. :)
But yes, I agree we should rename it. Now or eventually later?

> worktree ref store is a different story and I don't know how to best
> present it here yet (I'm still thinking a separate struct repository).

I imagine that we'd rather want to have arrays of config/worktree path/refs
when needed and the worktree is just an index into all of these things?

> But we can worry about that when struct repository supports multiple
> worktree.

ok. Thanks for bringing this to my attention.

Thanks,
Stefan
