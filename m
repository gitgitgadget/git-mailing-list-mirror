Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328401F453
	for <e@80x24.org>; Mon, 22 Oct 2018 01:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJVJ55 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 05:57:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJVJ55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 05:57:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so7260533wrn.0
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jolnB/FXpB/RLtdHH/cC62RKXTcFPJSZ5nOIMZs8Oms=;
        b=HFTSur3E443j5eKvMCaoIL7ww9FgHG9U5ixeeIAV+l4eMsUJpJOLGalkP+E2qpA2xj
         Iuv+KmzPtpDPm2NS3PtxLqjtdT8FT3vRjbFVDvKdLpnajATWclt+TKHDvAdo6ZsiAANI
         rvfkL1xMlGGas48S+nnpcedAQmxHJ5J5claGh5U7PdZW1pLoPc8EM5wgp5jGokYdSxxb
         kBgJEFnJ9SFgax7Ivl3FX2TF6CmIaH9bKhh4/mJRQtD3Kdjvwwu0z5cYMpJERcQHjIDd
         B0WkvTPo3hmsIEdJLPwim3ru88yM82Pxo5HIqi4FrCsl7lSZe9esENUj6OisAngsSZ6w
         a2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jolnB/FXpB/RLtdHH/cC62RKXTcFPJSZ5nOIMZs8Oms=;
        b=QeNFuzhVdD7+1rAUpcU4POTj49aRNsETheY5QPWV88D85cIdu4jCNaXU8o1fm5By0P
         Y4Z60u0StWwumq/0ddwNfIQFD9mlVRopepgXfHBxjmX8/eEBHSlRhHyTvmOEFzHfDoGA
         2EIbYZqfxz8MeQryH8zmn6PweY1ZRKJsfb+o9xXEtXMRx0wC8mccFSg2MgYGcjwAUmOS
         SdgRsGVODt7X5bLSFg5rgfX3QRwGOge5ngVCrCKt7IdAuhC9HeoSCXwdoWsP0pBRNRcn
         6ziNSzDomz3yl3zBepxyCj6vC3vaaLu0FBPZTcz8gw6JMcGuCLFBZ0M5LDsnCsNyZgam
         cHVw==
X-Gm-Message-State: ABuFfogYWbJq4Ayfj6G1u44xFH68j42EIZDgHil+z/+K11JlNYVn/KSJ
        564wI8xC7JUkBqVK8R/rePg=
X-Google-Smtp-Source: ACcGV61o4GOE2KKbyFn5+G/vzlJegiqH1pmjYBxLDiJjDzQiQW7qU81zfXBml/yuOHDE0R2EiAleCg==
X-Received: by 2002:adf:80c7:: with SMTP id 65-v6mr43112536wrl.57.1540172493437;
        Sun, 21 Oct 2018 18:41:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm31644527wra.83.2018.10.21.18.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 18:41:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add GIT_TEST_MULTI_PACK_INDEX environment variable
References: <pull.27.git.gitgitgadget@gmail.com>
        <pull.27.v2.git.gitgitgadget@gmail.com>
        <38aff549-9582-9879-9b3d-81cf5b1c3e24@gmail.com>
Date:   Mon, 22 Oct 2018 10:41:31 +0900
In-Reply-To: <38aff549-9582-9879-9b3d-81cf5b1c3e24@gmail.com> (Derrick
        Stolee's message of "Fri, 12 Oct 2018 13:41:02 -0400")
Message-ID: <xmqqy3aqycz8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
> I should explicitly mention that this base commit is different as
> otherwise I will conflict with ds/multi-pack-verify with the new
> prototype in midx.h.

There indeed is a tiny textual conflict, and in this case it may not
matter that much, but please make it a habit to refrain from doing
such a rebase in general.  It makes it impossible to compare the new
round in the same context that the old round was inspected and has
been tested, unless such a textual conflict avoidance is undone.

A good rule of thumb is to build on the same base, attempt a trial
merge to 'master' (and 'next' and 'pu' if you are inclined to), and
see how bad a conflict you get.  And if the conflict is something
you can trivially resolve and the resolution would bring the code to
the same state as you would get if you rebased, then you are better
off not rebasing and let the maintainer deal with the merge.  You
cannot control what other contributor would do to the code while you
are working on it, so having to resolve these tiny textual conflicts
is not "an unnecessary added burden" to me (having to backport to
see the new round in the same context as the old round is, though).

Of course, if you truly depend on some recent addition that happend
since your old base, please do not hesitate to rebase.

Thanks.
