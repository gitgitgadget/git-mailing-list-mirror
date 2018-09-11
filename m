Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F67F1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIKXcl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:32:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36336 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIKXcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:32:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id i144-v6so3845969ywc.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oT5HFqpQXrGZxQSfUNc4JPy1nb8ktHk0HJoyTxg8Q2Y=;
        b=UsbD55WauuCNLf18i8TgsnMOCHDOUw21U6AmJwf+w951dgDrAKx3DQmxLzexpeiLAp
         TVqiGvXjlGNu9jHzH3N92tOO/NKbMswfXcViovw/4Wxs4QCltTvtffVejXFxCDlu9cPx
         e68/AQkWb0cF6usURTAgFrb0hgwS17DgX4C/SOKJ8/wrsQ085rbwGABiFwtp2esX1UVD
         dqpNAChiJFpPRbMLqUDBBex6vuZcfP6h/dLL/3Wn1Xj/2/rLxxLxQFvT6da82vnzysm8
         0KADJyGYb4gRmcwAXNj4mCb3PLKTPQtglCdA+Hv2LVuj+Mq3UENyALfURkLAxKkGTGcz
         QcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oT5HFqpQXrGZxQSfUNc4JPy1nb8ktHk0HJoyTxg8Q2Y=;
        b=a5K9ynnBnDJoNKBVsEaNO4CQ9eOZ7KP7vxcGbjY+H+/UqJ+VqN0SNzyayC6Iu7mV9C
         gZOV2T6A7OKbW68yl4pxSiMdiSG5xAz4NMToMytUutQymtVQ0/48MgijCftDljjGnlFS
         ve41/dfrduHht5R4Yfdm3H8kgdbChKqGLOOGM599jPFCxQ/TLlhVMEB9Xi4/LeBU6s1o
         HRTTpLNkH5DqNbTOTiMmWKuH3YnWIJnfxsvzWSxiZkEyTP1Dy/zQotiB2P7GGMgFzUps
         u9zwE+VQ7s9It6EUnjyOwYi1RH6kcdUPBHVUtH2hKrbnavxFHmIaUKk+N0Zp+yqTgbl3
         7cLg==
X-Gm-Message-State: APzg51AzfELRjsN4zV35er9Le6z+/UBmuWexUGIfhh1JsHkRa4DEpbRa
        g9LYxqISSy57sEsWe8A31WL/6IPo2LJch6KXVB6IRWupeXI=
X-Google-Smtp-Source: ANB0VdZpwC6LoLaFgKnJ1pIvwGo4K3PILmYv2cJ1E3CF3cw3A2Qj/wj9/jVXDJqrinitB7e3d+hSiWGZVCRpr0qJU6E=
X-Received: by 2002:a81:5855:: with SMTP id m82-v6mr12793958ywb.300.1536690726528;
 Tue, 11 Sep 2018 11:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com> <20180904230149.180332-7-sbeller@google.com>
 <xmqqbm9a1p1p.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm9a1p1p.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Sep 2018 11:31:55 -0700
Message-ID: <CAGZ79kZ4UtcojkDGjAbxORV6+dfSNmQYOx_Loe=B=-Z3JrQ5dg@mail.gmail.com>
Subject: Re: [PATCH 06/11] submodule.c: sort changed_submodule_names before
 searching it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > Instead of sorting it after we created an unsorted list, we could insert
> > correctly into the list.
>
> It is unclear what problem you are solving, especially with
> subjunctive "could" there.  We are creating an unsorted list and
> then sorting it and you see it as a problem because it is just as
> easy and efficient to do the insertion sort while building up the
> list?  (don't react and answer without reading all the way to the
> end; I think I know what is going on).
>
> > As the unsorted append is in order of cache entry
> > names, this is already sorted if names were equal to paths for submodules.
>
> That may be a statement of a fact, but it is unclear how that fact
> relates to what the code is doing before this patch, or what the
> code updated by this patch is doing.
>
> > As submodule names are often the same as their path, the input is sorted
> > pretty well already, so let's just do the sort afterwards.
>
> It is unclear what (performance?) trade-off this senttence is trying
> to make.  It sounds as if it is claiming this:
>
>         We can string_list_insert() to maintain sorted-ness of the
>         list as we find new items, or we can string_list_append() to
>         build an unsorted list and sort it at the end just once.
>
>         To pick which one is more appropriate, we notice the fact
>         that we discover new items more or less in the already
>         sorted order.  That makes "append then sort" more
>         appropriate.
>
> But is that reasoning sensible?
>
> I'd imagine that append-then-sort would always be more efficient
> than insert-at-the-right-place-as-we-go, and the reason why we
> sometimes would need to do the latter is when we need to look up
> elements in the middle of building the list (e.g. we may want to
> de-dup, which requires us to look up a name from the ones we
> collected so far).

If we come across a (mostly) sorted list, then the insert-at-the-right-place
we'd come across the best case of insertion sort which is O(n), which
sounds better than append-then-sort as our sorting is a merge sort,
which has O(n log n) even in its best case (and needs to copy stuff
into a temp buffer and back).

By having the submodules named after its path, I strongly suspect
we have a mostly sorted list in nearly all cases except some really
interesting corner cases out there.

> And in this application, calculate_changed_submodule_paths()
> discover paths by calling collect_changed_submodules() which finds a
> mapping <submodule name, oid of commits> into a list sorted by
> submodule name, and then goes through that list and builds a list of
> submodules paths (which could be different from submodule names) by
> appending.  Only after this list is fully built, get_next_submodule()
> gets called, so making the latter use string_list_lookup() that assumes
> a sorted list is safe if we built the list by append-then-sort (iow,
> sortedness while building the list does not matter).
>
> Having analysed all that, I find it somewhat iffy that _append() is
> used there in the calculate_changed_submodule_paths() function.

Note that this is fixed in the later patch
"submodule.c: do not copy around submodule list"

>  It
> would cause the resulting changed_submodule_names list to hold the
> same name twice (or more),

This would be possible if there is a submodule at path A and another
submodule (at a different path) named "A", as we'll try hard to collect
names, but are also okay with path as we want to keep supporting the
historical use case of submodules.

> but I do not know if that would pose a
> problem to the consumer of the list.  Using "accumulate then sort
> before calling look-up" would not change it as string_list_sort()
> would not dedup, so I do not think this patch would introduce a new
> problem, though.

Yes, that is true, so we'd want to extend the message above to
mention the potential duplicates.

Thanks,
Stefan
