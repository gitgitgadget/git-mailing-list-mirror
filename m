Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1BF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeJVKhn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 06:37:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52676 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJVKhm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 06:37:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so8598871wmw.2
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=48nxCzIz5zS+M8Rc9RivlRL7HWOmE7+p1gtu13UAzuI=;
        b=X9KUQB5tsTRRBaSShwwdLcYxDeek7H+16meVhHCtVNUklkc0aabWqBWijoZWQMUf5P
         AWolxYrIiw1i5jnl3R9xXCG7bvkw3Jnbal8MTBKAIjqPpQaOs+J6C9v4Z6nM5gDpot7k
         rXrmMbyibKgQQ4KzaY4EoCaI05sGusQFeGIhguGf6xidrJghHCIx8gv0BYb/t8JvR/xb
         evFS0gc/FbeXsLjD9cC9U6psF9+UXmBLB2v9fYH65Zq8QqJoWb3626t/8dcilGYnruns
         hcbFYgwhCDf6ueaits8KBZSSqGMXjIXApPq4OstIVjZixJeGKZHx1rmnhTO+jix7ohk5
         gj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=48nxCzIz5zS+M8Rc9RivlRL7HWOmE7+p1gtu13UAzuI=;
        b=GUEcb/+6AfMF+gG3yqJW5PX2BaB4/ejB2e1Hw6mY/YHlf8NL5slUsnq9b+zBLmto/z
         cm0rwmNqnfKgyPStKS8LCA1Zh4k5LVN8+NuZAQziHcVwk1G8hxAhJ7ifcgcG3hqvm/Hh
         trAuudlvMwQCJuwNccY5BKPUC4cH4CqJPKugl85cpkhmlZlsKY8kaV9OTWUpAUFuwD4H
         iRcP+6cM3gqEZ9vTPxMlMjc+8ku5ui4nESyMKtYn01ywNhm5+jV5dctscQe63/n0O9T+
         zb/oWdO961np9kTmBeFpyHS/by3Al5dAnWmO+WYoiQJywTQgtvXHzCEHHymo/tPB4omp
         cJ4w==
X-Gm-Message-State: AGRZ1gKSQQs8B9xuvhc1uyUjInXzmWBDp5QfchdYuE8A3xMltxP7zgNR
        Su130lgfp+lmq30uyse7nQk=
X-Google-Smtp-Source: AJdET5c3kcuLg7lTez8dAc+SB+7NbBiWUb/3cWDHyDW+QGz3AriV0lFXeOXRZSYAtBkAHdnC+levbw==
X-Received: by 2002:a1c:c784:: with SMTP id x126-v6mr14650342wmf.90.1540174871586;
        Sun, 21 Oct 2018 19:21:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z16-v6sm7656448wmc.0.2018.10.21.19.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 19:21:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Subject: Re: [RFC PATCH 2/3] Documentation/git-rev-list: s/<commit>/<object>/
References: <cover.1539298957.git.matvore@google.com>
        <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
        <xmqq4ldo861m.fsf@gitster-ct.c.googlers.com>
        <CAMfpvh+CDc_jToDmZaAypqwXvrhJMO-_4sUWRcjXwwz6OHhAHA@mail.gmail.com>
Date:   Mon, 22 Oct 2018 11:21:09 +0900
In-Reply-To: <CAMfpvh+CDc_jToDmZaAypqwXvrhJMO-_4sUWRcjXwwz6OHhAHA@mail.gmail.com>
        (Matthew DeVore's message of "Fri, 19 Oct 2018 17:03:56 -0700")
Message-ID: <xmqqo9bmyb56.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

>> It is more like "this is a set operation across commits.  We also
>> show objects that are reachable from the commits in the resulting
>> set and are not reachable from the commits in the set that were
>> excluded when --objects option is given".
>>
> That would be correct though it wouldn't tell that you can use
> "--objects ^foo-tree bar-tree."

Yeah, but quite honestly, I consider that it is working by accident,
not by design, in the current code (iow, you are looking at a
behaviour of whatever the code happens to do).  "rev-list" is pretty
much set operation across commits, and anything that deals with a
non commit-ish given from the command line is an afterthought at
best, and happenstance in reality.

I do not mean to say that the code must stay that way, though.
