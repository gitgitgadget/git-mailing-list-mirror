Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5146C1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 21:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHRArz (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 20:47:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35417 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHRAry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 20:47:54 -0400
Received: by mail-yw1-f66.google.com with SMTP id s68-v6so4911530ywg.2
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8C7Ha/4No94y/eLmiIqg3ZQuyuY2IPxtUpBIwt0YcM=;
        b=TENeeqyNJNbN5GvEgS/f5eTwwxJM1VS9Vd/izQ0rS8/FuRA//vpppKdfRwN8FZgv50
         3cFE7Er479kuuz07UQ5L0yU6DydQBW+6YzWZPeEk3rMj07aGdvYGXBgg1Pqy1/fgb220
         SYeh0y6kV9bFxC3Mq5vWDT+1R+Yma6kY5tI2Pqu2GNaQITaGtvG+7jeYx2ulasE+BI+n
         b15618Q6c4Dd6OHMKidYYnjQYyEiZzuFSpEQK9EqT1lrfAthP98oOEaiBjxFY9e79fsa
         PwFav/rRzd4v7qw4/RiSuhfbCwRLjE7E3pj/Fw1EQ0uqrXyBdPJ1zGxgxOYJyZcpyuGX
         QXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8C7Ha/4No94y/eLmiIqg3ZQuyuY2IPxtUpBIwt0YcM=;
        b=i3rTwKgH3V+/orlai55YCYjgH2I4usBBp9f0hcPYytayvU8JeED1ZibJe8JkBhSY30
         qolIVtVpAsmP3f64wraYdDHAwT4rzqQece2vHl13QAt+P8Zhzb3xLXLIOhJ7qvHVaEMv
         eKUyO4h5e42U7/uwtmjsX40nOu2HKSdAq3FdKkPZ3x3mon72HiIU2JuXl/w/zCRj8k7+
         A6mmuIl/9YpEpKAEt43ciPN48WO8uNEGPRVNfA7RlPgx6CNgm7S+SbMYbZTUyaNC6ZOH
         jr6v62SlZbEBYAA6Qp2VInCPmOwC6YbXLQB+0h75bdM3kRKAeW5W+HjLp1nEqGo6/YUC
         AL8g==
X-Gm-Message-State: AOUpUlEFSXudhlTQIG+LVKpj/ytFfav00jSK55HB7LOn3oZDFSpGJdIc
        DOmsfgQ9Qh4R0Oxl9P2Kdzyadlit3jNrUHRmDOcqQA==
X-Google-Smtp-Source: AA+uWPyhhKJfKZ+nLGGSjZv2fyH3Zg+HoUHrL1WllcvpQvVKRv9j9Mtc9tkCofNREQh2ZaJU0pt99VwrtZ3XjE8C+0Q=
X-Received: by 2002:a81:9a17:: with SMTP id r23-v6mr21137899ywg.119.1534542171492;
 Fri, 17 Aug 2018 14:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
In-Reply-To: <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Aug 2018 14:42:40 -0700
Message-ID: <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Matthew DeVore <matvore@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 4:23 PM Matthew DeVore <matvore@google.com> wrote:
>
> Teach list-objects the "tree:0" filter which allows for filtering
> out all tree and blob objects (unless other objects are explicitly
> specified by the user). The purpose of this patch is to allow smaller
> partial clones.
>
> The name of this filter - tree:0 - does not explicitly specify that
> it also filters out all blobs, but this should not cause much confusion
> because blobs are not at all useful without the trees that refer to
> them.
>
> I also consider only:commits as a name, but this is inaccurate because
> it suggests that annotated tags are omitted, but actually they are
> included.

Speaking of tag objects, it is possible to tag anything, including blobs.
Would a blob that is tagged (hence reachable without a tree) be not
filtered by tree:0 (or in the future any deeper depth) ?

I found this series a good read, despite my unfamiliarity of the
partial cloning.

One situation where I scratched my head for a second were previous patches
that  use "test_line_count = 0 rev_list_err" whereas using test_must_be_empty
would be an equally good choice (I am more used to the latter than the former)

Thanks,
Stefan
