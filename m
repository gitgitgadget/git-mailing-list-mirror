Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E071F462
	for <e@80x24.org>; Fri,  7 Jun 2019 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFGGis (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 02:38:48 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40809 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfFGGir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 02:38:47 -0400
Received: by mail-ed1-f47.google.com with SMTP id k8so275143eds.7
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbmsrdxb96klU58sHc/RqZd58S5q8dvDDz512H8r2bo=;
        b=Ypba9Dd8eQnOqkhYWiqOMktOA2PSxKmdEk0Lz2Xe6HMe36Zv5ynB8nT9IZro0MQnQh
         3AcRXCxZcMhZvqcam9rNsFWJM3KEFMwmtVxlh3C2Fnr7lfFW/MCw8f8x2zeJAWK/+9CP
         EfXZGIqClCRltJbKn5izmukucIvBbQ7wuzGHPnL/8xiZJ29PVHzeRqqHCayVN/lyxwY3
         M6nvPeIAsHCM/9uYwEzAdUnbnV6fvjjrb35cXKFB24Z2hPFHjS1IDmW8kQkMwMIbgnGW
         LsKNbkH9IZiyu1t6dvjKDjH0R1pAmL3SPGtQ5rODIskORuJ8ARYjPk099N2quQ8Lc3S+
         WoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbmsrdxb96klU58sHc/RqZd58S5q8dvDDz512H8r2bo=;
        b=mlYeOhZgQWRB5tj2BvGs1tnFqzwbWw8HvvXmDfIvx9ECb1+cTJXVfyQarrkecDFMYQ
         A66/+olxy7ZulDfIw5fRiOdH4QGzVJJebpOSQITFnnSeR3hWcr0ZxEwFXa6WgVPmrbd+
         dI5nS23767mE2/hvKHXGLLGCI2+spOwew7El5V+KCBx0swWA0W0gMvI32BLwSZbRWqGb
         U9HYJIb5Ensu4t7keOQwAIUAaXo+lwX2mabTyyRGfYg27j9B5LksJlh20btsCs1FsZKo
         23mY3+k6kb5etisvvXiONec6MjEVXK2POEIGzTN1NwI6jW3NUeNqhO3aNkImNRAgFjDz
         kIPw==
X-Gm-Message-State: APjAAAUeRui7RcE9JsKx31cv5FHOn8pgcyC5SMd4iLKmsgevbmfSy1Jk
        U8RJp99e4eP6wLZPCGQeYAbK+csSbpLQEs1BuOZ7Q6H7
X-Google-Smtp-Source: APXvYqwfuHZE+RQZOY8Q9KVRS8fivijEcLYRjocPNf48IIg0ZLSF7kAvVctl28cnK9s7XuG0Gn3NehXj8Jfq128rDAo=
X-Received: by 2002:a50:fd02:: with SMTP id i2mr40173231eds.201.1559889526172;
 Thu, 06 Jun 2019 23:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZktk-w40MEsRZesvkX23Xn2uMUPiO_cMHa=-xfdyVHCWg@mail.gmail.com>
In-Reply-To: <CAJoAoZktk-w40MEsRZesvkX23Xn2uMUPiO_cMHa=-xfdyVHCWg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Jun 2019 08:38:34 +0200
Message-ID: <CAP8UFD2Kyq9nrAnoj3AxQyLgiGHycLEdJbJOQx_stsepsqmX4g@mail.gmail.com>
Subject: Re: Is --filter-print-omitted correct/used/needed?
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 6, 2019 at 10:18 PM Emily Shaffer <emilyshaffer@google.com> wrote:



> I grepped the Git source and found that we only provide a non-NULL
> "omitted" when someone calls "git rev-list --filter-print-omitted",
> which we verify with a simple test case for "blobs:none", in which
> case the "border" objects which were omitted must be the same as all
> objects which were omitted (since blobs aren't pointing to anything
> else). I think if we had written a similar test case with some trees
> we expect to omit we might have noticed sooner.

It seems that --filter-print-omitted was introduced in caf3827e2f
(rev-list: add list-objects filtering support, 2017-11-21) so I cc'ed
Jeff.

[...]

> So, what do we use --filter-print-omitted for? Is anybody needing it?
> Or do we just use it to verify this one test case? Should we fix it,
> or get rid of it, or neither?

In caf3827e2f there is:

    This patch introduces handling of missing objects to help
    debugging and development of the "partial clone" mechanism,
    and once the mechanism is implemented, for a power user to
    perform operations that are missing-object aware without
    incurring the cost of checking if a missing link is expected.

So I would say that if you think that --filter-print-omitted doesn't
help in debugging or development, and can even be confusing, and that
it also doesn't help performance for power users or anyone else, then
it would make sense to remove it, unless you find a way to make it
fulfill its original goals, or maybe other worthwhile goals.
