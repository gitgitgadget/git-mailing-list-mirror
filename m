Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53C41F42D
	for <e@80x24.org>; Wed, 30 May 2018 16:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeE3QnX (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:43:23 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:42603 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbeE3QnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:43:20 -0400
Received: by mail-yb0-f179.google.com with SMTP id d123-v6so6579950ybh.9
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ggiWivYl/Fp9tmR54CDr+tDRc8H8KsC4/7thRic9x3o=;
        b=C2yCxtSc/iEuB82HSOdDu7kzK3i8YNrUTvt5Pd5KB0k0KvOuk56EjfYaRVSp3U4iP0
         uOlgdypBYIJFRm+0ZKAVeOWr63er6XMBc7O28LFajf1hcufWUbXUP9zN/zjVq+wGh5NH
         2AE7A7BkgvvTdBDdqFOrP+JRJpN9G7dtlhIpfniazZAHFxm6caYlWt3TABPbvlrTVsBV
         J8Xt/Y134/0gEQjkW/HZU//BDJ6XwX6bZpkijS3f6ofCXaSiWVI+iZdBHfJcgxtNckK4
         +oSA7GAyG3i59obaRuDz6khyboEdMdUdQvVPnD+CSWi38bx5rNOwmNW/9zFyUBsS5Kc4
         n8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ggiWivYl/Fp9tmR54CDr+tDRc8H8KsC4/7thRic9x3o=;
        b=JzEdm4pyxUvyvL+DZQQBmh6k2IYHCM5ARGwwx4YqHFCTRLbluL6rt5/59C5awUlV3J
         V7kYhKCnNy0LZKVSkUlR6tqGwjNwMo7o1ilqyWuClYmL3IUEI5k3PBNIhCWrpo1UujxS
         u4tJeDJej152bvsIrBrEs32nU1WVGQNUKRw+zzQjGUdvQHEXkHqSSZtQyg92iEHFoBjG
         zyAHgDVaipKVP39ep7oxX/L+z2OfC5IUWH4Ry/K/WwNQ+WF0ocqtYpSjM4d2w4sifAZG
         0xe+rd9X0MaX9KkrS9GTy45aB99fgJIn/mOuWDAdpP4u6lYtZa3VRx8AWQvnmDUdT1ok
         HH3A==
X-Gm-Message-State: ALKqPwfdUsgiKt1PR1uzOzXkb3C9a6T2gW54WwEt/qh4esWEbhJEAcf0
        AdRP6xAqavV2mDC4DhQnZ2Gd4sGuRnwkyrus4gow4Q==
X-Google-Smtp-Source: ADUXVKKadrhQ2q742eEpQ2d4qRErYkvqQwLBPr0S5dY0w+7TnLnH8EmA3JHky7MBywWOaAurx0AOl7vjFvaLjf4ATfg=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr1973348ybx.352.1527698599779;
 Wed, 30 May 2018 09:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 09:43:19 -0700 (PDT)
In-Reply-To: <CACsJy8DW8e4rFWzzc4WxLRtK-WTAcG_BwFSxAya_fLfXOk9p8A@mail.gmail.com>
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com> <CACsJy8DW8e4rFWzzc4WxLRtK-WTAcG_BwFSxAya_fLfXOk9p8A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 09:43:19 -0700
Message-ID: <CAGZ79kbL-EJ9ithyxMgs0G_vcp7+Dno5tkEk2Vds8mmgUmaQVA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 9:27 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 30, 2018 at 8:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * sb/object-store-alloc (2018-05-16) 13 commits
>>  - alloc: allow arbitrary repositories for alloc functions
>>  - object: allow create_object to handle arbitrary repositories
>>  - object: allow grow_object_hash to handle arbitrary repositories
>>  - alloc: add repository argument to alloc_commit_index
>>  - alloc: add repository argument to alloc_report
>>  - alloc: add repository argument to alloc_object_node
>>  - alloc: add repository argument to alloc_tag_node
>>  - alloc: add repository argument to alloc_commit_node
>>  - alloc: add repository argument to alloc_tree_node
>>  - alloc: add repository argument to alloc_blob_node
>>  - object: add repository argument to grow_object_hash
>>  - object: add repository argument to create_object
>>  - repository: introduce parsed objects field
>>  (this branch is used by sb/object-store-grafts.)
>>
>>  The conversion to pass "the_repository" and then "a_repository"
>>  throughout the object access API continues.
>>
>>  Is this ready for 'next'?
>
> I think so.

I think so, too.
(I even think that for sb/object-store-grafts.)

> Stefan could remove the comment "/* TODO: what about
> commit->util? */" if he wants since nd/commit-util-to-slab is already
> in next. But this is really minor and does not need fixing to land on
> 'next'.

I was about to remove that comment in the follow up[1] that I sent out
yesterday, but refrained. Now that the removal of util is being merged
to master, I'll include that in that series

[1] https://public-inbox.org/git/20180530004810.30076-1-sbeller@google.com/
