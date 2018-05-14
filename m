Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3582E1F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeENKAm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:00:42 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:44345 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENKAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:00:41 -0400
Received: by mail-wr0-f176.google.com with SMTP id y15-v6so11610746wrg.11
        for <git@vger.kernel.org>; Mon, 14 May 2018 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=U0Jl9gA0C+2lkRkxDgkfVlYQknWig+MvH2NzSq0uhvk=;
        b=jXtzqolNbQpBI2LHFjEG81TWvserSM4Z4Zuf2osLfOc8YXXh6GC0PJnnCEk+EIfKjo
         19JXwoIfOfWMPT4+t1v39rm9RtrWzxaS11vzV8qOPTYj74n9X4jkvbFJtOMjsxUP+mV3
         2HsInBHHgecrgWiwcM9Ovj53Nxt0OzwM6/fzbUIXqIu3LgmgjgI+NZU/3ogMixRuCwU7
         3YirRgQDwIN9KgiEpYmKMQ0mDUNXjgl1k3hSlI7U72Fbg/sicxC+jCzoo27RWyygmnZI
         ekLIg30UAscEHfPoLhTi/deY+V4upzwoVJC2RPm0Tu4f3NNi4LJndMFZWhGDkbJaMd/C
         3i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=U0Jl9gA0C+2lkRkxDgkfVlYQknWig+MvH2NzSq0uhvk=;
        b=W4yRa6/D6soFbOze+yTr4arGyZ6H7NEkYFKXvpmq+vH20PyASk7/PFoI0WlbCuJUvH
         H1ZebD111VtX+L3pyT21veNUjJFvYV4uoWXLlZ3w/vzvLRdVA6TNFknBrJQ4xTA6un3i
         TJzYRMNTu+JApV+OXtLYo+oj+/eQjXrwV9cP50fBThl1InfQpvkYDpNlNjLpn52m7YJR
         PMeyHk2SKEhXeAFDTURavJrtnvsL637FAv/71YmmApwTVGQg0v1G8RftdElxBDrtPT+s
         RoqP4JEXRCPwcnekQDb1wLt50Y8/kgvXIEydLMXtbolPzSjNgwtG4k/azpLTn3uLiKq+
         FNbw==
X-Gm-Message-State: ALKqPweBEHKxbWQJFQqOszZVnLeEwPnVD5oyf6TdNWicYkVLzze5xqTP
        tDvJD4NlDbjPJU32xqPfuXybPogRHpMWFXYf19tJwQ==
X-Google-Smtp-Source: AB8JxZrJb1Qz0JVH/PUtR/jGX9hNPLsAzh6jwHdrAZlY1KvzEkM2LflqZKpo36qOo5pZW69cYS3KlPWxETm4dEbmDz0=
X-Received: by 2002:adf:9654:: with SMTP id c20-v6mr6883756wra.89.1526292040032;
 Mon, 14 May 2018 03:00:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.164.71 with HTTP; Mon, 14 May 2018 03:00:39 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 14 May 2018 13:00:39 +0300
Message-ID: <CAL21Bm=6Z54-zsUq0DJqmqhSciHCDLUNXR8inDMAd-b-=QJjcA@mail.gmail.com>
Subject: [PATCH RFC 0/1] ref-filter: start using oid_object_info
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,
Some context at first: I am trying to migrate cat-file formatting part
(I mean batch option) from its own implementation to ref-filter one.
That's why I want to use oid_object_info_extended() in ref-filter, it
will simplify my further work. Additionally, it will give us 2 new
options (objectsize:disk and deltabase), and hopefully some commands
could work faster because we will not get and parse whole object if we
don't need it (invocation of oid_object_info_extended() is cheaper).

I am not sure if I need to add same logic for refs (I mean when we
need to deref the object) - please share your opinion.

I also see the problem with sorting - that's the part of logic that I
am trying not to touch at all. Data (from oid_object_info_extended())
is initialized in format_ref_array_item(), and we use it later in
populate value(). We have get_ref_atom_value(), it uses
populate_value(). The problem is that get_ref_atom_value() is used not
only by format_ref_array_item(), but also by cmp_ref_sorting(). So, it
means that data could be uninitialized in populate_value(). Now I do
nothing with it, and it works fine because cmp_ref_sorting() works
only with refs, and my code do not change refs logic for now. But it's
bad, and I know about it.

I see 2 ways of fixing that: I need to support refs somehow; or, I
need to add additional checks whether the data is initialized before.
I will be happy to hear your opinion.

If you see other issues/ideas - please share your opinion, I
appreciate it so much.

Thanks a lot!
Olga
