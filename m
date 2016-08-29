Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0871FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756351AbcH2U6a (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:58:30 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35473 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756331AbcH2U63 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:58:29 -0400
Received: by mail-lf0-f41.google.com with SMTP id f93so109656928lfi.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+lol5rEhZY/sg2hnpi3vvGd/hNKsdtOLcuwIUi7rAEw=;
        b=p+sgPFkkkiedpezbaMSYo0KCyIgkhjHTU7h95q/EIVO+CDvrmEu9rRPYlPkNFHAYP/
         YtfnwKjGvUBXdOf7ObrqOaeCrC2iK3O3pIQRzmv+39Cq/PnIc/RzmN2xmeKThcsOwRa1
         c7MYA9yZQzBdyBqEIk5/n62YHnfsLi+X1VsWikmOMd/JtImg3J27oyBZpG6dJk69J9S1
         LbmFVOAgNpqrSjClTajBfuDTYHnDO8Ib/zLF7I9RQW9kSc3iy2i9CUv535hf8b0nrYHy
         3NC7lq2jJK9DOlkT4IJPzp0CjpPFVpg8fdytyqOsxQQlIecEr82iurZ9vTZSbc3o9ghx
         2O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+lol5rEhZY/sg2hnpi3vvGd/hNKsdtOLcuwIUi7rAEw=;
        b=RwLbkD48bMPP+j3WI7aBg0j82igYINC/Y4Z06U8mp/lbD9yzH5/2KlfyQv234q247C
         u7OBR6TQAw5DCMqAiC8o++Tu934FlBb7D3XYCaHaPcDu5BPW6AR7hr/duQ0kphlBRjC4
         Qa2tIaMl1bYd39XdkuheSqr3Hd++lgPSVvuQMQVLxJ8W0g95HnmdrD1keW3wQGzN9p9F
         KAqRvyI6OVYuoUr+bNbQlHJ/Y8x1n/riHMpkC1SBtO4WlGSPKX6ObtyEgWlWT6rgF0OB
         jDwMz1pNio/GkT1jkn5V/UyU/foqA98I7q8yOUVlNRSyiR9F4nEdQzb4IhEZ/dJaS5ht
         +3Cg==
X-Gm-Message-State: AE9vXwMbwE9H8zoKowcQGy6nYzlQsHX0kqBbHH+eCh9GKtpnsDYItBxLQBEQeiXXn9z6iH5uhJ+x+CAg8rXUZQ==
X-Received: by 10.25.76.139 with SMTP id z133mr9846lfa.90.1472504307613; Mon,
 29 Aug 2016 13:58:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.78.226 with HTTP; Mon, 29 Aug 2016 13:57:56 -0700 (PDT)
In-Reply-To: <CACBZZX63DAmFt_ZiUHj-bs9dtwRd4MOxoLfM8r1uRi3q4Mwnkw@mail.gmail.com>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <CACBZZX63DAmFt_ZiUHj-bs9dtwRd4MOxoLfM8r1uRi3q4Mwnkw@mail.gmail.com>
From:   "W. David Jarvis" <william.d.jarvis@gmail.com>
Date:   Mon, 29 Aug 2016 13:57:56 -0700
X-Google-Sender-Auth: V3rsgs3ouhel7venH5NNFkG-o-s
Message-ID: <CAFMAO9wQD5GtGRGv-sMy=NA1q8kbu6n3FFbWuJ+W5-qnRDKW-w@mail.gmail.com>
Subject: Re: Reducing CPU load on git server
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  * Consider having that queue of yours just send the pushed payload
> instead of "pull this", see git-bundle. This can turn this sync entire
> thing into a static file distribution problem.

As far as I know, GHE doesn't support this out of the box. We've asked
them for essentially this, though. Due to the nature of our license we
may not be able to configure something like this on the server
instance ourselves.

>  * It's not clear from your post why you have to worry about all these
> branches, surely your Chef instances just need the "master" branch,
> just push that around.

We allow deployments from non-master branches, so we do need multiple
branches. We also use the replication fleet as the target for our
build system, which needs to be able to build essentially any branch
on any repository.

>  * If you do need branches consider archiving stale tags/branches
> after some time. I implemented this where I work, we just have a
> $REPO-archive.git with every tag/branch ever created for a given
> $REPO.git, and delete refs after a certain time.

This is something else that we're actively considering. Why did your
company implement this -- was it to reduce load, or just to clean up
your repositories? Did you notice any change in server load?

>  * If your problem is that you're CPU bound on the master have you
> considered maybe solving this with something like NFS, i.e. replace
> your ad-hoc replication with just a bunch of "slave" boxes that mount
> the remote filesystem.

This is definitely an interesting idea. It'd be a significant
architectural change, though, and not one I'm sure we'd be able to get
support for.

>  * Or, if you're willing to deal with occasional transitory repo
> corruption (just retry?): rsync.

I think this is a cost we're not necessarily okay with having to deal with.

>  * Theres's no reason for why your replication chain needs to be
> single-level if master CPU is really the issue. You could have master
> -> N slaves -> N*X slaves, or some combination thereof.

This was discussed above - if the primary driver of load is the first
fetch, then moving to a multi-tiered architecture will not solve our
problems.

>  * Does it really even matter that your "slave" machines are all
> up-to-date? We have something similar at work but it's just a minutely
> cronjob that does "git fetch" on some repos, since the downstream
> thing (e.g. the chef run) doesn't run more than once every 30m or
> whatever anyway.

It does, because we use the replication fleet for our build server.

 - V

-- 
============
venanti.us
203.918.2328
============
