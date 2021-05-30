Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A941C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7984B611BD
	for <git@archiver.kernel.org>; Sun, 30 May 2021 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhE3Ohr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3Ohr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 10:37:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B759C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 07:36:09 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z24so9340310ioi.3
        for <git@vger.kernel.org>; Sun, 30 May 2021 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=karKo92ahS+TKYWsBIItjrHjd5rTKfU9gJdTmd4EC+I=;
        b=eLPvNLoUlhswdbFuaWd++ACkQfsQdkB/XPWDF+/hsIJJLdr9VNnlqVR3qCv92iev0e
         bbnXxFVEMF1pOhg9zbLoUc/ES2XT0ZtfOq6EFo/RG49kLrUOdNlgcQT8mgs0HhVu6zfr
         OgW7fOZWi+090S/2rUZk8WeqWesR7W/Gr4wUlSHmZWi2Plwvl1u/SHE/mrhqiRQq5toS
         A4bNNJQI4HqhNGgBDZcLybNjIgjOdRQHgIuOw9OmaTuFNDVhjgGJ8s0uTzVRNcrMI3mv
         uehkVVZtSmsn4YYzGMrgDZdcgB+ID8U3fL2GTgdLoKtigVxpFFhTREcAtOaIbAuJmZoK
         6k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=karKo92ahS+TKYWsBIItjrHjd5rTKfU9gJdTmd4EC+I=;
        b=pDt0+Mpl7QYvSO74DjSAtX/Ae0RxsKfFzvVRB7BWf98Eb36Dmg958SgHYM+o3gbeGK
         QkhB4mohygrYT9Bi7RBesooQvkI1QE1zl6qCZacs/oyb2ZYtN4UAW0vyBprAIaBGpkXM
         UvXPQhhkjimR6LHtbdkN12ntC+AnZONrBwW/wEl7EWVWrtfuUGs6sOcFuZ+LqHAzBxXx
         +uysyrAtrLbnvgRxJ10OO+ZbzSoArjNlmrhatSQhV2IF23K3VbaLTnca7H6NmqfTSDZb
         TytZTQ2U3B2AkK6HSxpKExPLR2JVO2V0GlBLCXUKVFgkfsuUsdAKKbkJJYyOSarCwb9l
         cIIg==
X-Gm-Message-State: AOAM532znwbgcHkM0pN6lwObB+svyj3FeIVNuPpEhTU+p2Oo969HlzTx
        +Kns+3GJrcWcI5h9PUtFWGFFGctWGDUo35gJYHJcWdtTPgOkRDvQ
X-Google-Smtp-Source: ABdhPJzWHNu0DvrsdcJDBlvGHlg1sjjmWM2DsczFFglr2ehi7ClfPTytiFn2ku5WsRTCdoJWPfydcrakK1UXoi58d0Y=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr13614122ioo.203.1622385368186;
 Sun, 30 May 2021 07:36:08 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 30 May 2021 22:35:56 +0800
Message-ID: <CAOLTT8T0XtmpH3cHDBOfcX5nmCzfyrKby4TrFkHtA9H3dDN63A@mail.gmail.com>
Subject: [GSOC] Git Blog 2
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My second week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-2/

-------
## Week2: learning the slang of a new city

### What happened this week
- In [[PATCH 1/2] [GSOC] ref-filter: add %(raw)
atom](https://lore.kernel.org/git/b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com/),
I made a license-related mistake this week. When I was
implementing `%(raw)` atom for ref-filter, I noticed that
`glibc` did not provide us with `memcasecmp()` which
can be used to compare two pieces of memory and
ignore case, so I found `memcasecmp()` implemented
by `gnulib` on the Internet, and copy it to git to use.
But unfortunately, I should not copy it so "conveniently".
Git use `gpl-v2` and `gunlib` use `gpl-v3`, they are
incompatible. Since I used to write code for my own use,
I am not very sensitive to licenses problems. Thanks to
`Felipe Contreras` for correcting me. Therefore, from today
onwards, I will be more careful about the license.
- On the other hand, I realized that clean code is also a
very important thing. In `cmp_ref_sorting()`, I want to use
`memcmp()/memcasecmp()` to compare two strings.

BAD VERSION:
  ```c
                        int (*cmp_fn)(const void *, const void *, size_t);
                        cmp_fn = s->sort_flags & REF_SORTING_ICASE
                                ? memcasecmp : memcmp;

                        if (va->s_size != ATOM_VALUE_S_SIZE_INIT &&
                            vb->s_size != ATOM_VALUE_S_SIZE_INIT) {
                                cmp = cmp_fn(va->s, vb->s, va->s_size
> vb->s_size ?
                                       vb->s_size : va->s_size);
                        } else if (va->s_size == ATOM_VALUE_S_SIZE_INIT) {
                                slen = strlen(va->s);
                                cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
                                             vb->s_size : slen);
                        } else {
                                slen = strlen(vb->s);
                                cmp = cmp_fn(va->s, vb->s, slen > va->s_size ?
                                             slen : va->s_size);
                        }
                        cmp = cmp ? cmp : va->s_size - vb->s_size;
                }
  ```
It's complicated and buggy.

GOOD VERSION:
  ```c

                        int (*cmp_fn)(const void *, const void *, size_t);
                        cmp_fn = s->sort_flags & REF_SORTING_ICASE
                                ? memcasecmp : memcmp;
                        size_t a_size = va->s_size == ATOM_VALUE_S_SIZE_INIT ?
                                        strlen(va->s) : va->s_size;
                        size_t b_size = vb->s_size == ATOM_VALUE_S_SIZE_INIT ?
                                        strlen(vb->s) : vb->s_size;

                        cmp = cmp_fn(va->s, vb->s, b_size > a_size ?
                                     a_size : b_size);
                        if (!cmp) {
                                if (a_size > b_size)
                                        cmp = 1;
                                else if (a_size < b_size)
                                        cmp = -1;
                        }

  ```
It's relatively refreshing a lot.

So how to cultivate a good coding style? As
`Felipe Contreras` said: "It's like learning the
slang of a new city; it takes a while."


### What's the next step
There are still some flaws in the %(raw)
implementation, but let's look ahead and see what
we can do. We check the atoms with `verify_ref_format()`
and pass object oid and grub corresponding object data
through `format_ref_array_item()`:

|Git command|Atoms|
|-|-|
|`git cat-file --batch-check` | `%(objectname) %(objecttype) %(objectsize)`|
|`git cat-file --batch --symlink`| `%(objectname) %(objecttype) %(objectsize)`|
|`git cat-file --batch` | `%(objectname) %(objecttype) %(objectsize)\n%(raw)`|
|`git cat-file --batch --textconv` | `%(objectname) %(objecttype)
%(objectsize)\n%(raw:textconv)`|
|`git cat-file --batch --filter` | `%(objectname) %(objecttype)
%(objectsize)\n%(raw:filter)`|
|`git cat-file --batch="%(rest)"` | `%(rest)`|

No additional operation is required in
`git cat-file --batch --symlink`, because
`get_oid_with_context(...,GET_OID_FOLLOW_SYMLINKS,...)`
can help us do that.

I have leave the rough implementation here:
[adlternative:cat-file-temp](https://github.com/gitgitgadget/git/compare/master...adlternative:cat-file-temp).
its performance is 25% worse than before.

Rather than posting it to the mailing list, because I still
need to implement the previous dependencies step by step...

Thanks!

--
ZheNing Hu
