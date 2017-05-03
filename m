Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E02207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbdECKze (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:55:34 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35826 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbdECKzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:55:20 -0400
Received: by mail-oi0-f47.google.com with SMTP id l18so28241571oig.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U7FCV670UEuBaAWoTCL54IHEayQ8585L5caUrn6m1YE=;
        b=OwX5zxSYy/aQ0tUWXJUQ8TMlAOQqlGwanFfhOPuFkQpQ5OIO5w8AWj1akt67j4Wyum
         1M7hM5b4cilFI4nfoRWW/vJNVwK6NMBgi6qGF0TvkI6Om6OvOfcLCuvdGVUbb+bqFdBa
         2W3fZKZ7P/pbKBY5/wUHFd4L7qrhqVAHlR3iLUesDr410oyzdkQjfW851pEYCBACMAFe
         GUWIqwspaVZr4i5So5SzuQBE4La1tYctYKK9MN7v+0DNOW6C9N4GVhT1DlOJWQiP4fNz
         Wuqt5uCCzq1nsr6uJjFkF5UKTxo2Il4qlRn9djkuvMRMUeHsEIcDSF4f2VNz1YLWL5WH
         MC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U7FCV670UEuBaAWoTCL54IHEayQ8585L5caUrn6m1YE=;
        b=k0KIShsxtOZs6Cxp2n18X8hj7/5Y+GHe/G8fnsxZx1AwN05VJ4NO5KjUunrp5fJKCf
         vERBIqWBh14Q/5/t0/z9uOTlrvVjNkMjlFpoGxM6zVZ06qaw1GK6ME/dyTaKfChCVbmV
         juqESNi62fGf47mzphYN4xVXP8nY+T7KjPrceYycAGbn9CTPEX6WF8n0rcOGfw1KNxmU
         BAmr4IKtMqRLrCqWgpK6aXJdM1PObEd0gSBJn8jMjDFseonviIGoqbwzuldleTqHVwac
         y/ex56KKS/GYjATg4tgd8SGjSlea2YA9k9BhGW6PYsm20iXovUUFcU67aQWUDlHHlAj6
         TOIA==
X-Gm-Message-State: AN3rC/7tqZQwYEVF0+yKzWJpFG+I6oK78Q+v+eA135oZx4wQ8uu0FXRT
        l3lPs2LvJ+N3RUwZUX9H9RZ6yX0PX6rS
X-Received: by 10.202.93.85 with SMTP id r82mr13425958oib.5.1493808919868;
 Wed, 03 May 2017 03:55:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.140 with HTTP; Wed, 3 May 2017 03:54:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705031202470.3480@virtualbox>
References: <alpine.DEB.2.20.1705031202470.3480@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 May 2017 17:54:49 +0700
Message-ID: <CACsJy8BasKLSuMuoqT1MNWbp93qxuG1Z+auiM6SaN7fBYT8sFw@mail.gmail.com>
Subject: Re: RFA: untracked cache vs git reset --hard
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 5:27 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi all,
>
> I have a problem and would like to solicit advice how to fix it.
>
> The untracked cache has made a real difference on rather large
> repositories with tons of directories, and it is really, really useful.
>
> But. One innocuous `git reset --hard` will just blow it away.
>
> How? reset_index() calls unpack_trees() which in turn tries to populate a
> new index and then discards the old one:
>
>         https://github.com/git/git/blob/v2.12.2/unpack-trees.c#L1293
>
> That discard_index() unfortunately also blows away each and every index
> extension that had been read carefully before.

This is a real problem when we introduce non-optional extensions (i.e.
extension name in lower case). Dropping them is not an option because
they may contain vital/original information. We haven't any so far,
but I've been wanting to add one for years (narrow clone). So I'm all
for tackling the problem now :)

> All users of `git reset --hard` (including `git stash`) suffer this.
>
> In fact, it looks as if *any* caller of unpack_trees() would suffer the
> same problem: git-am, git-checkout, git-commit, git-merge, etc
>
> Now, I could imagine that maybe we could just "move"
> o->dst_index.untracked to o->result.untracked, and that the machinery then
> would do the right thing.

These extensions may have dependencies in the o->result.cache[] (do we
allow an extension to depend on another?). If invalidation is not
handled correctly then it's not safe to simply copy the extension
over.

For untracked cache, I think we do invalidation right and just moving
it over dst_index (and resetting NULL in o->result so it does not get
accidentally deleted) is fine.

I'd rather we have a common way of dealing with this for any extension
though. Split index needs special treatment too [1]. Maybe we can add

int migrate_index_extensions(struct index_state *dst, struct index_state *src);

in read-cache.c where it calls migrate_XXX() for each extension. In
some cases (cache-tree) we could even do more, like repair cache-tree
there to avoid hitting performance regressions.

[1] https://github.com/git/git/blob/v2.12.2/unpack-trees.c#L1165-L1167
-- 
Duy
