Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF561F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeDWRSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:18:55 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:44311 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755473AbeDWRSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:18:54 -0400
Received: by mail-yw0-f170.google.com with SMTP id u10-v6so4863549ywl.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fBQd+8UVT+oGh5vw4mY5YJzGFoS2IeID4WTksBITvZs=;
        b=aFYg/wTMCQfxqt7K42ViD9uTRHmGSUPTKPfKhzovx6ptc/THoRCki8T4dE0gWj5Wwb
         xdFNS10kuhJU2jZOzq4xbi62vQZmQNROB9tMBGu/xvDdgfUktjyRLO+5Il2H9UWYCfYT
         oQGYwOzCmo4gPF6tQ7xdPMvynG6ImMuD/jW2CpargToNld0SU+NHY5+vOvai7NmGKpD4
         kYEROUYApkzVGUQ3Xt4xfd1bXGhImfXmiiD3fejTM//vgzJZ2W7NYA3B4Vbbgque22lt
         siCUxhrGg9XGxiioxCJR7Ko5hHI/iCClLOg19AesvCr3S5QyTxLUSi0aPHHK5ilyDBbJ
         dN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fBQd+8UVT+oGh5vw4mY5YJzGFoS2IeID4WTksBITvZs=;
        b=Ti7KBnSaZIIChkceDW5OSkNIkZ4kzP3pH1mZM5J21h3PQqFXGK0wXIMFBiaOMlxFu3
         Fn+kJotkJCI62OS/UJu15n9cVZzkixa7HQbLa8X+yifdm+AtzccPY/SlKRWiP5QV51qk
         VFJe3aODfN0U/yzkndmBnErzYYRzWorqaxttFizg5aKz9lb+x6g3asGsj/MY55/cgtCi
         F0mEYfNm2IcJebCf1BFSWYukMJSPy/KT7MRCXmY9WKkgLs5eNRN9szrTnW2nzA7z/wuI
         7pjybeguEnxvqJJGDCyo1VuXWgPuPRdm/d4nLQlYhyuu0on9+sQiUFLfNn//HbRt4Bxd
         ofCg==
X-Gm-Message-State: ALQs6tD5Iy9cYyfchAMYHoKHp0d50XEe5+QJKfSTpo/VzLQHfnhDQkC7
        vEYSb+1nAJRdgM5SxX/jMkI8FAvP0zA139Ho3nOJ6w==
X-Google-Smtp-Source: AIpwx4/D45J8FiD97UvOOCx7xIGMEwn6Xlfike4994JqJJGvFhqYSsw2+rZZbTXWixsETasdmj24+xtFXIP62OLAJWs=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr11212117ywe.500.1524503933776;
 Mon, 23 Apr 2018 10:18:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 10:18:53
 -0700 (PDT)
In-Reply-To: <3ec5999c-f81d-eafb-1597-4fa93f943a6d@gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbOQLkNZxHbR0bDwVHbT0x47v8qp81E2WFm72HdZJ4ZRA@mail.gmail.com> <3ec5999c-f81d-eafb-1597-4fa93f943a6d@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 10:18:53 -0700
Message-ID: <CAGZ79kYeY2yNzUZpzE+L8nxku0RdTsrKc6=VEFQwZtWMKEafdg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 9:44 AM, Jameson Miller
<jameson.miller81@gmail.com> wrote:
> I would be interested to understand how the
> mem_pool would fit your needs, and if it is sufficient or needs modification
> for your use cases.
>
>> [1] proof of concept in patches nearby
>> https://public-inbox.org/git/20180206001749.218943-31-sbeller@google.com/
>>

Currenlty the parsed objects are loaded into memory and never freed.
See alloc.c which implements a specialized memory allocator for this
object loading.
When working with submodules, their objects are also just put into this
globally-namespaced object store. (See struct object **obj_hash in
object.c)

I want to make the object store a per-repository object, such that
when working with submodules, you can free up all submodule objects
once you are done with a given submodule.

To do so, the memory allocation needs to manage the whole life cycle,
while preserving the efficiency of alloc.c. See 855419f764
(Add specialized object allocator, 2006-06-19). The mem-pool that
you propose can allocate large slabs of memory and we can put
objects in there without alignment overhead, such that we preserve
the memory efficiency while being able to track all the memory.

So I would think it is sufficient as-is with this series, maybe we need
a little tweaking there, but nothing large IMHO.

Thanks,
Stefan
