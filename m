Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5CE1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbeGKVO6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:14:58 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:46045 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeGKVO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:14:58 -0400
Received: by mail-yb0-f201.google.com with SMTP id b12-v6so1816361ybr.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=4e58hw4iL+ME8HCz4uR0zuR3M+EyATVQF7yhGj8Z3uY=;
        b=jW+g6CjO6tELN+ucqhwQK9ubCOxyuF4A78/dh/3QNKQ23MsI1JHdLsjqSyJq70Xkq3
         S8J3QCJAMwNP0xf0N8mgQLWyE5tIhTdzKV72bFcidZwxqijenSWfppUgQLu1BgLgXdpz
         5I0BaosJpr9V+PArl5mCKlhpliTcIWXDPj3EW8zT4R1WLhBN69lUcHvc9Od3NxntvSIk
         Zdbrog7aZJ1Ksx3rAfpFUEXgv0yL4Ei4f2jMHAGhxZl3TqEeUdAPkXDN9ueCkayPK02Q
         evalOErMjgFoA126m95G4eB4zETrRlZa7pUBZi1Ft1YeYM8xy4x3xpfFF799UCbvI/eJ
         2W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=4e58hw4iL+ME8HCz4uR0zuR3M+EyATVQF7yhGj8Z3uY=;
        b=VooAkeG9m+WnWfaneL6pGdFvvWrJ9w4IQYq1r6EqCSHB04S4M9UjnGwSBwwWPOcSb/
         04Icb+ToFBDtfT/R/SjwNIdFV1E07ruQEyYVBdz1zKD1gDx0zcU3VOg5QUdcD5DmtdH1
         zT82fkX6RunKB/gRVNtn38FkqZ0YA2OmURMhtps2k7SqGXvhC/phtcwVQeYkaHex7Qag
         xjhQ8af1O+Y/zsGKADB3d/aFfs57xIPrmi9PVkEx+fHyt5YLQ6Kop14dtFsySp2Ztyk0
         wDT6P3RiG1EjY+/y5rVdmfAO4/Nky76PJptd2xlqmXt5GKTjMBNGQwlFdGMz4UD82Dek
         2Umg==
X-Gm-Message-State: AOUpUlEQuN+lokr8nhodES2x8H2RjH5FHIhZXfz7gvmpRAOk0hwlhqkK
        3pcgH79A+oDsJsy5JVyGdXhxXRqRMUF0RAYZLjQu
X-Google-Smtp-Source: AAOMgpeCxIcwgnhXnMMG+8ksldraujLamQ6LVkBlI9QzaYO/1KGfDfXReY11ULwybFX5Lol9hDxDAdVZk/MMTVvN+qaT
MIME-Version: 1.0
X-Received: by 2002:a0d:e941:: with SMTP id s62-v6mr99367ywe.87.1531343325418;
 Wed, 11 Jul 2018 14:08:45 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:08:42 -0700
In-Reply-To: <1f0ab606-cf7d-e61c-1761-7a2982a2628e@gmail.com>
Message-Id: <20180711210842.17443-1-jonathantanmy@google.com>
References: <1f0ab606-cf7d-e61c-1761-7a2982a2628e@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> Also, this will conflict with sb/object-store-lookup, won't it? I'm
> >> guessing this is why you didn't touch the "git commit-graph
> >> [write|verify]"code paths.
> > It will conflict because of the change to lookup_commit(), but the only
> > new code I'm writing is in t/helper/test-repository.c, so hopefully the
> > merge won't be too tedious. The main reason why I didn't touch the
> > writing/verifying part is to reduce the size of this patch set, and
> > because that change is not needed to update parse_commit() and others.
> 
> I guess my main complaint is that this won't be an actual "merge" 
> conflict, but the result will not compile. Since Stefan already has a 
> series out that changes this method, I recommend basing your series on 
> it (in addition to basing it on ds/commit-graph-fsck).

Good point. Junio requested a reroll in his What's Cooking e-mail [1],
and the same e-mail states that ds/commit-graph-fsck and
sb/object-store-lookup will be merged to next, so there are a few good
reasons to base it on both. I'll do that and send out an updated version
soon.

[1] https://public-inbox.org/git/xmqq7em138a5.fsf@gitster-ct.c.googlers.com/
