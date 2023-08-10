Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FECC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 22:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHJWud (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 18:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjHJWuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 18:50:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8D2D54
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:50:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942442eb0so18202257b3.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691707828; x=1692312628;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=054ziJqMdWMx3kN6DlB2ElQdMkFdRouky4SeJqdtXwA=;
        b=ygd9FQy0Z4VEEHzaANjE4oVwaqRJlzHgKSsLD3bdm98umU76IcU1XoWPz5XIeYVhuz
         J/OItS3/Pc3eyBRSYyZryLg4dgVrwcZdZlsdGcPQj0QGe+a4+oFkY9hg3gE3pEO5Ino5
         n48naFLKiWbKZJKPqjrI1Atk3tr9mPuNxkNGFPIJvQwR4tXFxOzGeb6MazhLiBO0jSJZ
         POPL1S5YkipbJcS7S1OrHkWYXWs97OpbW5jHsEdQKJ6hWXorbhIHn+t1sNXbabuyEz3u
         jr1cRE3qffJjo6ylY0R1TNaTnlVz9z3EalHMYIe7oTsk6QhCfhaiQwMfEX3hjtWOpj8C
         73Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691707828; x=1692312628;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=054ziJqMdWMx3kN6DlB2ElQdMkFdRouky4SeJqdtXwA=;
        b=Rycg4RD7hBRK/8PRuaJKNlCL0LBYZ8UHFn312CGSo6xIpolzZwAfsiVZlMBVZ8crGC
         ZvO51KJuPsgQ53vpzs6dfsg7eFC82+jt/aC1J+vXvN/5X9f+wG1qCi5KLdR4TnnbOnh8
         7v0vtiUEDvFIEOkJ5k++CVQVyc4g/VGeVxHfi/FwvDVChWZ1sWgmognHMvB54IYTj2/j
         JuqVwtbKl/EWCYn8cVyqngDUKpiF1dUavJJRDYS88JPOngJRx7ei82Yy3HmJomaHLJKA
         ckEixeO46A4AHYDarOGcWcPeTkAquJJdwZqTPaCIDQKQX8pVmmsbQQ40GIVdcXrs2Noh
         6GOA==
X-Gm-Message-State: AOJu0Yy/azHbCJnUFaep33+VwsNDCOooelxuiqJPrs77Fy9XiAuBaIKR
        Enh+CKL7MCYCdmvDxBMpTaxijS+nFEM=
X-Google-Smtp-Source: AGHT+IFofdKwbgceDaMhf3yRTnVKa1dteM4QkUPjUB8h63KmP03bz4wA+Wv+O4Xoi4aQsTEPWZ+I/89RvIo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:d8c6:0:b0:d64:f7ec:6d5d with SMTP id
 p189-20020a25d8c6000000b00d64f7ec6d5dmr1741ybg.10.1691707828591; Thu, 10 Aug
 2023 15:50:28 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:50:27 -0700
In-Reply-To: <kl6l8rama6yj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <0bce4d4b0d5650edf477cbbcc9f4e467b7981426.1691211879.git.gitgitgadget@gmail.com>
 <kl6l8rama6yj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <owly1qgah5qk.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 1/5] trailer: separate public from internal portion of trailer_iterator
From:   Linus Arver <linusa@google.com>
To:     Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> As someone who isn't that familiar with trailer code, and will have less
> time for the ML soon, this is more of a quick drive-by..

Aren't you also going on vacation soon? ;-)

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +#define private __private_to_trailer_c__do_not_use
>> +
>>  void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>>  {
>>  	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
>>  	strbuf_init(&iter->key, 0);
>>  	strbuf_init(&iter->val, 0);
>>  	opts.no_divider = 1;
>> -	trailer_info_get(&iter->info, msg, &opts);
>> -	iter->cur = 0;
>> +	trailer_info_get(&iter->private.info, msg, &opts);
>> +	iter->private.cur = 0;
>>  }
>> --- a/trailer.h
>> +++ b/trailer.h
>> @@ -119,8 +119,10 @@ struct trailer_iterator {
>>  	struct strbuf val;
>>...
>>  	/* private */
>> -	struct trailer_info info;
>> -	size_t cur;
>> +	struct {
>> +		struct trailer_info info;
>> +		size_t cur;
>> +	} __private_to_trailer_c__do_not_use;
>>  };
>
> [...]
>
> This is the first instance of this I could find in the codebase. I'm not
> really opposed to having a new way of doing things, but it would be nice
> for us to be consistent with how we handle private members. Other
> approaches I've seen are:
>
> - Using a "larger" struct to hold private members and "downcasting" for
>   public users (struct dir_iterator and struct dir_iterator_int). I
>   dislike this because I think this enables 'wrong' memory access too
>   easily.
>   [...]
> - Prefixing private members with "__" (khash.h and other header-only
>   libraries use this at least, not sure if we have this in the 'main
>   tree'). I think this works pretty well most of the time.
> - Just marking private members with a comment. IMO this is good enough
>   the vast majority of the time - if something is private for a good
>   reason, it's unlikely to get used accidentally anyway. But properly
>   enforcing "privateness" is worthy goal anyway.

Thanks for documenting these other approaches.

I prefer the "larger" struct to hold private members pattern. More
specifically I like the container_of approach pointed out by Jacob [2],
because it is an established pattern in the Linux Kernel and because we
already sort of use the same idea in the list_head type we imported from
the Kernel in 94e99012fc (http-walker: reduce O(n) ops with
doubly-linked list, 2016-07-11). That is, for example for the
new_trailer_item struct we have

    struct new_trailer_item {
        struct list_head list;
        <list item stuff>
    };

and to me this is symmetric to the container_of pattern described by Jacob:

    struct dir_entry_private {
        struct dir_entry entry;
        <private stuff>
    };

Accordingly, we are already doing the "structure pointer math" (which
Jacob described in [2]) for list_head in list.h:

    /* Get typed element from list at a given position. */
    #define list_entry(ptr, type, member) \
        ((type *) ((char *) (ptr) - offsetof(type, member)))

In this patch series though, I decided to just stick with giving the
struct a private-sounding name, because I don't think we reached
consensus on what the preferred approach is for separating
public/private fields.

>   (As an aside, if we really wanted to 'strictly' enforce privateness in
>   this patch, shouldn't we move the "#define private" into the .c file,
>   the way dir_iterator_int is in the .c file?)

I think you meant moving the struct into the .c file (the "#define" is
already in the .c file).

> Personally, I think a decent tradeoff between enforcement and ergonomics
> would be to use an inner struct like you do here, but name it something
> autocomplete-friendly and obviously private, like "private" or
> "_private".

SGTM. I think I'll go with "internal" though, to align with 576de3d956
(unpack_trees: start splitting internal fields from public API,
2023-02-27) which Phillip pointed out. Will reroll.

> I suspect self-regulation and code review should be enough
> to catch nearly all accidental uses of private members.

Ack. In the future, if and when we want compiler-level guarantees to
make it impossible (this was the discussion at [1]), we can revisit this
area.

[1] https://lore.kernel.org/git/16ff5069-0408-21cd-995c-8b47afb9810d@github.com/
[2] https://lore.kernel.org/git/CA+P7+xo02dGkjb5DwJ1Af_hoQ5HiuxASheZxoFz+r6B-6cQMug@mail.gmail.com/
