Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6A51F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHJWLq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:11:46 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36208 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeHJWLq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:11:46 -0400
Received: by mail-ua1-f67.google.com with SMTP id c12-v6so3081103uan.3
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuaobfxvRx52QllmNvhg9aXj4VXULPzBNntWnV5nxNw=;
        b=sVZ/ot6nU/4xZXnNp4lgIkuKPQxtelUd/AFPK+8MqpE6RcTeDRFyDEo8+4VbqD2qnM
         962RmjJk8O+nut1hy+c1otDbHQ6tJYt/HWlQxVNPTbNUO0f2ByvSnjD14WgjDPMpcmOi
         mThs8I/5dA2cXiwKi6MR8JrN8Imi9CzD7syBi8bH5GCPT7e8ykwrfFRwJQ0F5EQ5UrXD
         d1zfQadcKuGHNzujeensxrROFL8wu8DVBthttLVSyvB0xMPpfEf8mPqSm8lqo9ZYRo+1
         kViRUIppNeRz/9QuWqO+rHI5U6LW7ZU8ns7NkeYE1xF6sgPDpc8wmQBaAQUxT+xVppH6
         PKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuaobfxvRx52QllmNvhg9aXj4VXULPzBNntWnV5nxNw=;
        b=V5NjAgcsUMlPVeO5B4sWiEmllAycbogpQ3L59ftUYMfqy8Hd9ebLLqNFBNhFJPphYT
         Ef7nDr3+A+MJ0qi6tef2UaEKT46OEdWU72PXSW325KI4GEWj8lqMctxiSlkD2PPcky1n
         RZPr/ZrJCWSNUJEPVTgAuZ3strTbtCJOPi62Na8rQPvbVbHuL61/Q0fUJSgQorJWBqJF
         SFVoHaKLObYjekqVYhc8CM8/EvTHqwGb8cdl9qeSo4t2x1I73WfRr1thZALuN6gbKzi9
         bVoRZFrZsHNC4QNAjLed6TVcxj7lWqZTgDfH3YIUOXX3QBcVptaWr41QFV6mo4zrYZSI
         XBcA==
X-Gm-Message-State: AOUpUlFG2lWVPb7+tgMB9BkuKqTeSHGBXuqOogspBmo8/WItsAwXEutl
        gRQERkCkwvcMyHsvxwY8Xgdxm/ousNBmGCkXyXE=
X-Google-Smtp-Source: AA+uWPwNPwwXHQNCjfzX3d/UycSFkgYSySeMCIhCeJtNXFLzUOnRZPmlfghvOPc1EJ/nbjK7mzqhKNiTxtg4XY3qXEw=
X-Received: by 2002:a1f:8c2:: with SMTP id 185-v6mr4954387vki.51.1533930030643;
 Fri, 10 Aug 2018 12:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-5-pclouds@gmail.com> <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
 <CACsJy8DF5XLf-RF3SwTpRynYALJUPO_VTK=fpx1oabwB80ZpPw@mail.gmail.com>
 <CABPp-BGU6QnUwQgkhwx6vLBc3ozoEScQ4DaZd-9ZZfQhXfxPww@mail.gmail.com> <CACsJy8AeptcqwRC+DOrdhvk69kEQT6+S6M=0OGWBFOE5gihGzA@mail.gmail.com>
In-Reply-To: <CACsJy8AeptcqwRC+DOrdhvk69kEQT6+S6M=0OGWBFOE5gihGzA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Aug 2018 12:40:19 -0700
Message-ID: <CABPp-BHMC8k3t2_9KzdJvg80e-nqwsbLUceTLNjQ=ST=9XthEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] unpack-trees: cheaper index update when walking by cache-tree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 12:30 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Aug 10, 2018 at 8:39 PM Elijah Newren <newren@gmail.com> wrote:
...
> > Why do we still need to go through add_index_entry()?  I thought that
> > the whole point was that you already checked that at the current path,
> > the trees being unpacked were all equal and matched both the index and
> > the cache_tree.  If so, why is there any need for an update at all?
> > (Did I read your all_trees_same_as_cache_tree() function wrong, and
> > you don't actually know these all match in some important way?)
>
> Unless fn is oneway_diff, we have to create a new index (in o->result)
> based on o->src_index and some other trees. So we have to add entries

Oh, right, o->src_index may not equal o->dst_index (because of people
like me who call it that way from merge-recursive.c) and even if it
does, we still have the temporary o->result in the mean time.  I
should have remembered that; just didn't.

> to o->result and add_index_entry() is the way to do that (granted if
> we feel confident we could add ADD_CACHE_JUST_APPEND which makes it
> super cheap). This is the outcome of n-way merge,
>
> all_trees_same_as_cache_tree() only gurantees the input condition (all
> trees the same, index also the same) but it can't affect what fn does.
> I don't think we can just simply skip and not update anything (like
> o->diff_index_cached case) because o->result would be empty in the
> end. And we need to create (temporary) o->result before we can swap it
> to o->dst_index as the result of a merge operation.
>

...

> I have a feeling that you're thinking we can swap o->src_index to
> o->dst_index at the end? That might explain your confusion about
> o->result (or I misread your replies horribly) and the original
> index...

Yeah, thanks for figuring out my confusion and jogging my memory.
