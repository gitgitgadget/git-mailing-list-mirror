Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0956C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIDVMf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:12:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51240 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeIDVMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:12:35 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so5913565itf.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcbRa8VHvs+i8ltvoH6xGm+3AwmATkVj/X6Bz4uR1Rc=;
        b=YZZn3tXR/WsPGHeGzbzsQSzbdjHVY1NH5bWRrjCRUYckmc2CRfLG7Gr/U4sQzaC0tr
         e8cTug89XsuU4DkF68H2OFWAdHW2lwKVtfzoSHmulPQfHs+zkOrMmfmr53tCQQqxio2/
         OG8EAPOvPG2EUq4gseiW75sYsrzUfF18yn3ULUQsUrj4X/tkl5GZbAZaBSfq04bv8d83
         OHyZRmS1aMuaOVUWScLaymqZzucJft71bPlUlLRPvW4CG6bGZyXz0v1G1aGwLf+SYy7D
         Yzkb3pQWCzWZ03YCD+Rxn9tzsBmxmMSKmBz9j76cE1sPRTJc9UwnABHTOexNWdtWPOgb
         D2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcbRa8VHvs+i8ltvoH6xGm+3AwmATkVj/X6Bz4uR1Rc=;
        b=pkHkxixtSv12RP6QbbR8mxHC4NjYkj6icz2DkGGno/hx9LAuYWouOYHFS5mo62RT7y
         CpM5fmCsGNP6PclGh8NitccEQWhwdou1JE4MAJ6uVWFAs0BphocX/4Z1ZPMHa94Jf8I6
         7AmrROzuAtIOH6uYjXqu/5tGBZ6YtZT+td63QDPuIuGGP8BF3znT8obgOW/A9dLokXJ/
         34Wf2W4FYgZLbhUR5DbZb0QA1OeeVLArpGvG1UTMHdNs0md+uhtpjd915dxFM49JKdhH
         5Fxz+TDPTHqnwyedKdB32cJtg5vhLxwZmfZsLNxtb2Vcywfme6zcUE7+87Ho4N01ubBe
         A1rw==
X-Gm-Message-State: APzg51AgH8eDPjpGVdpZTWuPFZXZDtfZqBcH0j3bMDajhwPQq77biBUk
        ED7CbSenaaWrfi/y2gD5UbR3A00JInGo0zt7SWQ=
X-Google-Smtp-Source: ANB0VdbhgAsXQ6yr670NkmDVtLejyZY8qZl3sdQqtAhSRmWHgosFnWkMYfoN7yPTvxvrjOQ44H+CJzOCV3D3Jkr681g=
X-Received: by 2002:a02:8341:: with SMTP id w1-v6mr23652783jag.61.1536079599501;
 Tue, 04 Sep 2018 09:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com> <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
 <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com> <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
 <f88299c5-1697-a7ef-87d6-69f5c19d5a68@gmail.com> <CABPp-BFKf2N6TYzCCneRwWUektMzRMnHLZ8JT64q=MGj5WQZkA@mail.gmail.com>
 <CACsJy8ArUXD0cF2vQAVnzM_AGto2k2yQTFuTO7PhP4ffHM8dVQ@mail.gmail.com> <CABPp-BGE-m_UFfUt_moXG-YR=ZW8hMzMwraD7fkFV-+sEHw36w@mail.gmail.com>
In-Reply-To: <CABPp-BGE-m_UFfUt_moXG-YR=ZW8hMzMwraD7fkFV-+sEHw36w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Sep 2018 18:46:13 +0200
Message-ID: <CACsJy8CrRQ1sxh2rWowGCT5+mBDFJORbrsA6aYi6YxVwvYNV6g@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 7:22 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Duy,
>
> On Tue, Aug 21, 2018 at 7:52 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Aug 20, 2018 at 8:16 PM Elijah Newren <newren@gmail.com> wrote:
> > > Playing with sparse-checkout, it feels to me like a half-baked
> > > feature.  It seems like it required too much manual work, and it was
> > > sometimes hard to tell if I was misunderstanding configuration rules
> > > or I was just running into bugs in the code.  I think I hit both but I
> > > didn't really want to get side-tracked further, yet.  (I do want to
> > > eventually come back to it.)  The only reason someone would go through
> > > that pain is if it provided massive performance benefits.
> >
> > In my defense it was one of my first contribution when I was naiver
> > and basically an evolution of "git update-index --assume-unchanged". I
> > have something in the queue to improve/complement sparse-checkout but
> > my last update on that branch was 2.5 years ago, so it's not coming
> > soon.
> >
> > I'd love to year how sparse checkout could be improved, or even
> > replaced. I think we still have to have some configuration rules, and
> > yes the flexibility of sparse checkout (or gitignore to be precise)
> > rules is a double-edged sword.
>
> Sorry for taking a while to respond, and if what I said came across
> harshly.  I agree that the flexibility of the rules makes it more
> complicated, though I think a bigger issue may be that the feature is
> hard to make smooth unless coupled to something like partial clones.

For something like partial clones, we would need something like
partial indexes. That is, the index does not record all paths in
worktree. The problem is at write-tree time, how to create trees with
such a partial index. So far the only option I see is record
directories in the index (in the same way we record submodule's
commit), which reduces the index and we are still able to create trees
from it.

> Work on that is ongoing.  Anyway, in an attempt to be helpful, here
> were some of the pain points I ran across:
>
> ..

Thanks. I think this basically boils down to no good UI (and user
facing command also gives us a man page to describe stuff instead of
hiding everything behind git-read-tree.txt). This is something I've
been meaning to do but never got around to (also a couple of sparse
checkout optimizations). There's also "git sparse-checkout" [1] that
would be a good starting point for this, but I don't think the author
got to the point to submit it to git.

[1] https://github.com/kjp/git-tools/blob/master/git-sparse-checkout
-- 
Duy
