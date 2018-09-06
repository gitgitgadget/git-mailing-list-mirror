Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD771F404
	for <e@80x24.org>; Thu,  6 Sep 2018 22:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeIGDHi (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 23:07:38 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36186 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeIGDHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 23:07:38 -0400
Received: by mail-ed1-f50.google.com with SMTP id f4-v6so10132639edq.3
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K92K/jLNQ6DYxwwC+KoDRdi7Jl13e40lvSTz5GI6IHc=;
        b=t1c8l/3t8i/5YotZzHCX7tfP960qyoakK10CNberNypiIsTwCmHA1CSr16bmIsu1E2
         pg9rRIOC2yfa9IJkhXznITrQyVx/5zcya8ydRvi+y+sOSZ9SGFarNUD615PkS5rrAPPY
         YEHAWbdJJYn13mVc41gURf17BoLfOUgrHjM1+2Ep5r2QCsdsbBMXCRp9IdiHmIvcbr2r
         e4UyZZSGFnR7/mWW/17s4ulP9Ujb7ymt7LUpWD/0cknRUW0eW+1hFBQZJzuFJUcpu6Iz
         3ilJ27duF2bAR4olR2IVTgdn7JUNtrOhD/RWnw8Tc+A5j2MLchXqwpdIo45BmOBwtxFR
         AG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K92K/jLNQ6DYxwwC+KoDRdi7Jl13e40lvSTz5GI6IHc=;
        b=IKDqxn1gGroEAjjRlPsshTdW8J8RhaQ5RrNV+LHH88vADA1dQZG8YigF/aPeCwFrXD
         F5ySVBqg3NWqiW1r4GjfXOUzdGwfKfxHSyLkY+0iUon7nMOqYwRhP4cdQNlpP8xSeNan
         AkfIxGwnwNNmg+qL8yXNN7jGpVdHevfVAMkM4R9gPQkMHZs+Uo316HTbNN0bOSkZFPM4
         9HCwm/pOdQrqyLanSiJ0oQE+R5u25R88Pe2X0p8+X9NSBh1pPXVZcVYRys8Dzy3usAvY
         gioSFQlDEhp3ueTiHZc2l1iWJZmlr9mKzKFxRKY5CcoI4B+PQMi64ghqn9u2POSYEUBo
         MpYg==
X-Gm-Message-State: APzg51CuA7PgxOzWhITxJPObtQAsFYIVvy4JfAZezb5lu8syW2ypVyRv
        Cyg5HOsL7yYXkU/eTGSOewE0iM91G/K4QnOHGnSMRA==
X-Google-Smtp-Source: ANB0VdaxZb9OGvjy6UEcHzqO3iEn9AlRMFYO54D9hM9KUmTqTAwzZVC16Cdp36/IiJj5QLA4ACj9vnuH5BToI0xqCv0=
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr5669029edd.194.1536272998716;
 Thu, 06 Sep 2018 15:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com> <20180904230149.180332-3-sbeller@google.com>
 <xmqqwory1rhx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwory1rhx.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 15:29:47 -0700
Message-ID: <CAGZ79kYDxC9krHiwHRWGpAfAys-NaQpS5py6-A=rurm96iN9=A@mail.gmail.com>
Subject: Re: [PATCH 02/11] string-list.h: add string_list_{pop, last} functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > A later patch shows
> > how useful this will be.
>
> Instead of all of the above, how about being more direct, i.e. e.g.


ok.


> Conceptually, this allows string_list_clear() to be implemented in
> terms of this function, i.e.
>
>         string_list_clear(struct string_list *list, int free_util)
>         {
>                 while (list->nr)
>                         string_list_pop(list, free_util);
>                 free(list->items);
>                 list->items = NULL;
>                 list->nr = list->alloc = 0;
>         }
>
> It is unfortunate that string_list has become such a kitchen-sink in
> that a string list whose util field is used in such a way that
> string_list_clear_func() needs to be used to clear the list cannot
> be used as a stack.  Ideally each of these "features" (like
> "sorted/unsorted", "owning/borrowing util", "owning/borrowing
> string", etc.)  ought to be orthogonal, but they are not.

Oh, another neat string list feature I overlooked. :/
