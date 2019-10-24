Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6432F1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfJXXMY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:12:24 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36250 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfJXXMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:12:24 -0400
Received: by mail-pg1-f202.google.com with SMTP id q1so263423pgj.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZCwzydFqB8fyqmbGuvFlTN5MD+4FG6ju+MvnUT3tgAE=;
        b=b8E98VWiBcYsOFFkhFj2EGdC4z5ORlNVUz0J+2ipv58rCa2r84FMOPQteazCTOgII/
         6Xbo46zy3fGe0a0hqciFTwXCQBrTkeu+OqYjLghcWV+vuKJA2MsFEaMXUnk3bso19S6+
         h1dm3FQPN/8cKC0klAkmNYs70A2liJHmYiJMmBuXxDMNJu2H/9HKg7jqMRgKcsJg2unS
         l1QPe9kgaLwf2V6UbFCUWLhVUvXMb5YZLRKAoR02ZhCJFLhx9GHEM6KglpvFtCuFek5/
         r6N2GUhTkK8atWUiqrlsIaDEUwO6fTDHHpqoTP+kNzY1HUVN6yp4TZGO10eToyP4tTRa
         +mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZCwzydFqB8fyqmbGuvFlTN5MD+4FG6ju+MvnUT3tgAE=;
        b=TEqyYotpTp2YCOoSqm2bwQ47LZsCgH0+i8m1Ne9h0W55P2UCrgSPM0UBm5vQte3Cjn
         NxX6vYuSkLoVY7bQnoxjCtes5snfqnj0H1nmOrkos5UEDZg+NPkvCs6OYXb9G2cq0k3n
         i8891wWvvhUyWfJtRwhSBfctgLO0GYp10WLgXjIvpesowwy1vI0/3TzRxYzMFx2T81Uj
         NNLKO8iR+m8utp/KTxV9q1LUIAO7Qew/DeEkkb7n0nNxxnC+otDyWUZoJIF0kt7Q71wl
         zLpv9F1eiY24IWEXurH64y7s1CciCADePYTz8e7OiLv+991ynzx9cndtOfcC/jqvm6VO
         WS9A==
X-Gm-Message-State: APjAAAU5LnEn4ka7S0RKlRbnKEh+xd1TcF4ze6pKzYD9tzh8+LXLyUNH
        XYo3AJf8ObwLm79UHLunyEiDglQ4k4pfRYf0VLDK
X-Google-Smtp-Source: APXvYqzH+tMzCYMYzsjB2UjmMW8j5896pmQyEwOaN8QFnne5rLcK73RuQvhexOZbXCfF/xHfbwLxD7zz1pZ53jDx4AcR
X-Received: by 2002:a63:6949:: with SMTP id e70mr603060pgc.226.1571958743096;
 Thu, 24 Oct 2019 16:12:23 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:12:20 -0700
In-Reply-To: <20191018044328.GB17879@sigill.intra.peff.net>
Message-Id: <20191024231220.96547-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191018044328.GB17879@sigill.intra.peff.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH 02/23] parse_commit_buffer(): treat lookup_tree() failure
 as parse error
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And
> certainly we _have_ seen real-world cases, such as the one fixed by
> 806278dead (commit-graph.c: handle corrupt/missing trees, 2019-09-05).
> 
> Note that we can't quite drop the check in the caller added by that
> commit yet, as there's some subtlety with repeated parsings (which will
> be addressed in a future commit).

I tried figuring out what the subtlety is by undoing the check you
describe, and did get a segfault in one of the tests, but couldn't
figure out exactly what is going on. Looking at the code, is it because
load_tree_for_commit() in commit-graph.c uses the return value of
lookup_tree() indiscriminately (which is the issue that this patch
fixes)?

This patch itself and patch 1 looks good (with the reasoning in the
commit message), of course.
