Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDA71F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKRXEh (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 18:04:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKRXEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 18:04:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id l1so1083366wme.2
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 15:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YOvhIsCFV/siQJPyOlKhWxxDJreRmW/Uh8t4L2Q4RCo=;
        b=TTR6BNZ9xby0YJjXZIojj3C/9zJfvINVTDrMbVVvZLJyZcC/ZovdO/qgr8p/yRAfGS
         2CKAxjGxhrCFbwj6Wt8drOY9zpHxVRdNuox3sQSx+a88KxSLcPFR/fNWOCYFRN273J40
         N1RgdbFZxx32+TiEonMq+58C6tS0tipnOVprnvmzX6WUl4+9GnzD0+rGph/PP4huTH08
         mFFTjfaZfxH54iqnjb9ZH5CciiLhUlbJvzigLbhjzKIAIQyN7eeE4TR057Rrztto9lxb
         M3vbZZehfspn3jtPJKLiw+PTo7ybkvt4KmgzGMqztX2OQAdqfhadu6hj0PniwgBwSqDl
         1qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOvhIsCFV/siQJPyOlKhWxxDJreRmW/Uh8t4L2Q4RCo=;
        b=kMzABLiGCNuztjceiqeQLEBMQWJxwspISi5P4+4cDGpKrfdpTqVAyenGchsEZ7K9JM
         FKFEUUT01qg2G8GYZ6HvqX3ENiMKI7QI3Ey/VMQvsZXWARvXdYBudlv+zZ8aiu0qzCtF
         OW/RQr6KeXg9VK4nHi6ZOPzUaMEBfBrqjPPLvw7G/MCdkbGm+Bo23bIde3YfUUISSO4M
         U0QsB+jft1Iyy5xQ5mQlimwzSwTkjtcwB4aziiN5yYmhDrzhlA4C1RoB5K8BnPTPMncs
         qjc/jc0UgNZmF/epbIbUZSus4KEVsVCa/I5zVppN6zwq+dCM5trC/SYqDTNi5TgSNSPA
         Skow==
X-Gm-Message-State: APjAAAVkKOv0f4oK2RENWBuIUCINk5WXyaJcUUYWhMnkR8aPYuYpAO5I
        /7r/ZNxyLCP/6QoYcNvwvJ8AtYXr
X-Google-Smtp-Source: APXvYqw9qFvObTRY3u9tRqy48qs7yJphN+1hoBKZCEZs9hftbju6aRabkqqCDENHDWe9h/lghITYMA==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr1883988wmd.79.1574118274932;
        Mon, 18 Nov 2019 15:04:34 -0800 (PST)
Received: from szeder.dev (x4d0c3ed7.dyn.telefonica.de. [77.12.62.215])
        by smtp.gmail.com with ESMTPSA id v184sm989590wme.31.2019.11.18.15.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 15:04:34 -0800 (PST)
Date:   Tue, 19 Nov 2019 00:04:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com, peff@peff.net,
        jnareb@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 6/7] revision.c: generation-based topo-order algorithm
Message-ID: <20191118230431.GC23183@szeder.dev>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
 <20181101134623.84055-7-dstolee@microsoft.com>
 <20191108025007.bphr7ynvskeoe6tb@glandium.org>
 <ea07fd13-7d0a-4636-1aa4-453f6b837735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea07fd13-7d0a-4636-1aa4-453f6b837735@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 08:07:31PM -0500, Derrick Stolee wrote:
> On 11/7/2019 9:50 PM, Mike Hommey wrote:
> > Replying to this old thread because I have questions regarding the
> > patch, in the context of problems I had downstream, in git-cinnabar.
> > 
> > On Thu, Nov 01, 2018 at 01:46:22PM +0000, Derrick Stolee wrote:
> >>  static void init_topo_walk(struct rev_info *revs)
> >>  {
> >>  	struct topo_walk_info *info;
> >> +	struct commit_list *list;
> >>  	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
> > 
> > Not directly from this patch, but there's nothing that frees this memory
> > AFAICS, but then, that's also true for most of the things in struct
> > rev_info.
> 
> This is true, the 'struct rev_info' doesn't get cleaned up at the end.
> It is probably a lot of work to find all the consumers and get them to
> clean everything up, and the value is rather low. I believe the expectation
> is that each process will only run a revision walk at most once.

I don't think that's a valid expectation.

Several commands must do multiple revision walks in a single process,
e.g. 'describe' or 'name-rev', but they tend to do so by rolling their
own low-level revision walking (e.g. by putting all ~SEEN parents into
a 'commit_list' and iterating until the list becomes empty) instead of
a higher-level 'while ((commit = get_revision(revs)))' loop.

Alas, some of those commands are buggy, or at least 'git describe' is
[1], and AFAICT the only way to fix that bug is to walk the history in
topo-order.  And of course we should not roll its own topo-order
revision walk for each of those commands, but rather should convert
them to use get_revision(), so they can all rely on the magic of the
commit-graph-based on-the-fly topo-order, especially since the
commit-graph is now enabled by default.  However, all this means a lot
of separate get_revision()-based revision walks in a single process.

[1]  https://public-inbox.org/git/20191008123156.GG11529@szeder.dev/

