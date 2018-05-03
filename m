Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78AE200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeECRVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:21:44 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:34476 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:21:43 -0400
Received: by mail-yb0-f182.google.com with SMTP id b14-v6so6772363ybk.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9cv5Luy/NdCY++eT8hIPElGCFGyEVjsf+uEx97JCTXs=;
        b=V+Sraug6gQ0M9bBWKFY2M0qJ5q0CzL9D4xM4y8domCdmF9M6Any3wxZPNGEJ7I8pJH
         pchvMTacsNzEeHHVF4cIqmaijsBy91Suhl0h9cuntE/iT+yl3Yspvr0DsNF2PBg7g3DA
         HCGVY1YnAiBY8SzL/uRzVZODM52e2KYwm6JguBj8PpVDk+f+KkKXUJuS9SAzmec34l89
         8wS8PbmpqVHkIFSAMsOFP3E5tWJtzDARedR/MweyXffXbTsiVj66NVgZi7YNR3D0KAkC
         tiAyB9MbusZ6X69QvcWJs3a/nxZ4qqjCzYF1+amrJd8h8+qneNXZJbbHGBSgzKsu83VT
         2zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9cv5Luy/NdCY++eT8hIPElGCFGyEVjsf+uEx97JCTXs=;
        b=ugBMsx4Fl5IBp3mz4FheOxNhcrk1KPJexlEuKaIcREI44SEE4Tv+YHDJyns1xCER4D
         gIyUnhSkxTQ7zLlOPT4ZER72YSnb0NkXyGkWCZat7W978EaNuacw+Qo9zoDUpvN4/yZx
         F+Q4/p/QymizRSxjKEl+RL/kzN76qoJ91IlFphZDy0GmhBLBjPQEJ3Ft5LpH0T1nJiXH
         1nixknAqMZIqOqtlk6/rkwUI0aEWmz18YYVHmLt+VCb4Rst7F5HItIhzAQHq8UfKcyV3
         qbH4/IJ3G8b0+ytjYpvdv5ZJqcrDxkB09miRLDxkhDlInQRzTTQ6Mx7VDZuTJUC7ClbD
         u/Hg==
X-Gm-Message-State: ALQs6tDVrR9poDjuTXvDHouyKlbbdKXfmXPZS2arG0To0Sx+yu+4WMzh
        oN8Abx4SGFvm6NN4Jld5NWBPUukZuSZqoIs6QCgUyg==
X-Google-Smtp-Source: AB8JxZqVQFCWWQibhyib+vl7k8x1UbGYDKfDSgZJmhTNgBOlUsCJzkkysZKLS4Osg/qh+S6JPC7VjmWeydRqqWh7/gs=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr15198515ybn.167.1525368102588;
 Thu, 03 May 2018 10:21:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 10:21:42 -0700 (PDT)
In-Reply-To: <CACsJy8C3yZ6bSZGw1d5DjwcPgHMDE7iGGUOn9SvyLmshzs9DvQ@mail.gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
 <CACsJy8C3yZ6bSZGw1d5DjwcPgHMDE7iGGUOn9SvyLmshzs9DvQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 10:21:42 -0700
Message-ID: <CAGZ79kbyPya0igC9v5JwNTsi0TSp-sj6v5SB4MOt625+yVB-Gg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate cache entries from memory pool
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 9:35 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 30, 2018 at 5:31 PM, Jameson Miller <jamill@microsoft.com> wrote:
>> This patch series improves the performance of loading indexes by
>> reducing the number of malloc() calls. Loading the index from disk is
>> partly dominated by the time in malloc(), which is called for each
>> index entry. This patch series reduces the number of times malloc() is
>> called as part of loading the index, and instead allocates a block of
>> memory upfront that is large enough to hold all of the cache entries,
>> and chunks this memory itself. This change builds on [1].
>
> I have only looked at the mem-pool related patches to see if
> mem-pool.c is good enough to replace alloc.c. To me, it's a "yes"
> after we optimize mem_pool_alloc() a bit (not that performance really
> matters in alloc.c case, but that may be because it's already
> blazingly fast that we never noticed about it).

alloc.c was not just about speed, but mostly about dense packing?
855419f764a (Add specialized object allocator, 2006-06-19)

To me it is also a clear yes when it comes to combining these
two memory pools.
