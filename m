Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3251F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeHJSjv (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:39:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53108 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeHJSjv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:39:51 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so3297203itf.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vu1lYymQYd7aXbFYsXBza/uiKRrQbqYCkOO0Gxrwyhk=;
        b=tFh9QpZ+ZKCN+fKK8cDgQ37SxCJP1D2KqSXWDljDo15i2Cl9KzsQNS6uw2d8C1Hr/1
         fEQTMys9eRnhElujQX1sDUMisVSnMqcrUCXuBhiOsJZCD+5YiZwj6biVcmZP8mvLH8Co
         Wr65s75svV1V+EusYdo/nIMYBKhpgjATSXtfMtb888m4GqGJfxlEO1kzF+qHhjWwpQG+
         KYrJSlw5G3/7jrVuY2W34Z103TtutihrN3Kql7lLp/URECMvKWNcGsyLHGwRjXXrepds
         3Y4quNaWyCKDIQlMLUWulkulvqEARSQC/PnqoEti6PqenDFTfSDQSUMYrYDapyyKoCmj
         VFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vu1lYymQYd7aXbFYsXBza/uiKRrQbqYCkOO0Gxrwyhk=;
        b=uBWVZmpz7W7bkyH6vblrYNMtvMwRvw83ojEgvMemoiu/kIjM/VshqWTUkJLXVwgvo4
         VgRUU0at8b3IgqWlQ//C/MHS7t5Zqnh0rA1PBtq2H/YcYPj9KGNiyEqA4hhw3VoBFfV+
         V3NR4K36QijjYqoN8h6bmHYtH/cVZtGhtzMo3hLZ0mf6Munrntbte+IG5rJeGEfrl1AZ
         sI6kz9EKSXudhB2eBHMZS4gHaG0xlBnOfV3igK7cKdqYPOlQ5PZ2bJMe3ZvdW8gZmpz9
         h//20ZbvFy8x90PSYHOnXuhFDwFYuYOHwcBUNuP6f00XvkOdcZgjHb+zcyD47RjWQVnC
         HJnQ==
X-Gm-Message-State: AOUpUlH6I1E0XVjEpjOQaAQm0/6Lq6T3UK1iaAKAId/xytjH3Hs9XDbW
        SCkS7+c7fcL/WgIEmYMYCQ5dxYxtyEJMseFD+/0=
X-Google-Smtp-Source: AA+uWPyA3dOkBzMwzi+hMjoR38bxUZSIxJRvCNxhnKyQysho2reQigDThSY4prs19yWMR/pHAb7UIPUUfTm9McW+BiI=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr6023098jad.94.1533917361856;
 Fri, 10 Aug 2018 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com> <CACsJy8BUBjPngHz=icHomor-LJOkMLwZ9bQ6YJDxnoXGg++vjg@mail.gmail.com>
 <cc3c4dbb-d545-6a6c-b20e-6a8ca66fc210@gmail.com> <57d146a2-9bf8-66c9-9cb4-c05f93b63319@gmail.com>
 <20180801163830.GA31968@duynguyen.home> <ccec34c9-b81a-bcb4-7d05-48dccc059cc8@gmail.com>
 <eb39eecf-81b0-e937-d686-47b7565d6511@gmail.com>
In-Reply-To: <eb39eecf-81b0-e937-d686-47b7565d6511@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 18:08:55 +0200
Message-ID: <CACsJy8AOV+73RLx2GyWTvcoKxop2t_9x0mFjN9raOsGjDdQ2bg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 10:16 AM Ben Peart <peartben@gmail.com> wrote:
> In fact, in the other [1] patch series, we're detecting the number of
> cache entries that are the same as the cache tree and using that to
> traverse_by_cache_tree().  At that point, couldn't we copy the
> corresponding cache tree entries over to the destination so that those
> don't have to get recreated in the later call to cache_tree_update()?

We could. But as I stated in another mail, I saw this cache-tree
optimization as a separate problem and didn't want to mix them up.
That way cache_tree_copy() could be used elsewhere if the opportunity
shows up.

Mixing them up could also complicate the problem. You you merge stuff,
you add new cache-entries to o->result with add_index_entry() which
tries to invalidate those paths in o->result's cache-tree. Right now
the cache-tree is empty so it's really no-op. But if you copy
cache-tree over while merging, that invalidation might either
invalidate your newly copied cache-tree, or get slowed down because
non-empty o->result's cache-tree means you start to need to walk it to
find if there's any path to invalidate.

PS. This code keeps messing me up. invalidate_ce_path() may also
invalidate cache-tree in the _source_ index. For this optimization to
really shine, you better keep the the original cache-tree intact (so
that you can reuse as much as possible).

I don't see the purpose of this source cache tree invalidation at all.
My guess at this point is Linus actually made a mistake in 34110cd4e3
(Make 'unpack_trees()' have a separate source and destination index -
2008-03-06) and he should have invalidated _destination_ index instead
of the source one. I'm going to dig in some more and probably will
send a patch to remove this invalidation.
-- 
Duy
