Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1EE21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 19:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbeGXUjR (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:39:17 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43688 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388834AbeGXUjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:39:16 -0400
Received: by mail-wr1-f43.google.com with SMTP id b15-v6so5197164wrv.10
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZifgDERCSBTVxsMinvonihvlLHy2vtQpjhCIuCRW4n8=;
        b=Ywyyp7oRJG3WVDh5Dtg5DCV1R3HXjorJGPbkVXjRQzDWkQOX/xMS97yv1QmB4rkf1I
         BjP1kc0piXj5zQkbpZ+RNGybRTmERzgzq8/wxSneY1Hlv5EnL/mFVtAMcbEeOfEMM13U
         ekTwTRvYTwcJO6HLyXSV/tRDhgN0yox0kT1CIDEbntS9KZCMpjctPwzdczI3nc+ewUS6
         IXgikQ0cfQkKGBq6YzwVd9sGo4dZKjWrV6IVrHl5wgUDU0uDhTKuvSJLe7m9nD+d22W5
         a2aYXnkfhOzYVtv0QGWzot4YLKWoN+mCw56QQ0EsSLDnTxvFlz/vxxEVUSnjgq3i18eq
         89OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZifgDERCSBTVxsMinvonihvlLHy2vtQpjhCIuCRW4n8=;
        b=LzSocBAUsLmp7gHLRLf7/BVzlFxLKVbELHpPCr8ACqLN4L0Jeu7ZGg8VYSj6SK3ed4
         1DEjg7LlOQPll29WSevlH4Tijsdb8Kl01kHm2yUCKlHrK86mKh/i27i9ufdqCkcoQv82
         DkAXbMo6yuD15JR/jJwu8Wo7lJkyjRh2FUZfbo7y54mU6ZX+ekLZdjxt8u7q3WBijaya
         1BGyYGSu7GaQir1/CxfNzDNuE2q1ugTz6IZXNYJcvSuQaxB5VCNDnARRs6/xxfHgkVQv
         N4aVyWKvHfZLqtBdjR/ckruFVWCYR1qeMcSobx96hqn9ADeN7tFX6HHMClw9DB7kpF4U
         jwaQ==
X-Gm-Message-State: AOUpUlGiBUnSLvK8zt130YN1yX/B/muqOdSpxKLHzYuVn4Q70VOY1x+Y
        UJS7PkEd7abPuiBJVJdyVBU=
X-Google-Smtp-Source: AAOMgpcx00QdJkQcFln2thVHJ1DY12Zlv0Alz3HOwuUYrV93sWh9mhnsdYtFuPza8adNcf2VTKRnOA==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr12901733wrt.37.1532460678213;
        Tue, 24 Jul 2018 12:31:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n8-v6sm9866166wrt.56.2018.07.24.12.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:31:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
        <20180723182149.202859-1-jonathantanmy@google.com>
Date:   Tue, 24 Jul 2018 12:31:17 -0700
In-Reply-To: <20180723182149.202859-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 23 Jul 2018 11:21:49 -0700")
Message-ID: <xmqqd0vcxwfu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>
> What do you think about my fixes to protocol v2 tag following [1]? There
> was some discussion about correctness vs the drop in performance, but it
> seems to me that there is some consensus that the drop in performance is
> OK.
>
> [1] https://public-inbox.org/git/cover.1528234587.git.jonathantanmy@google.com/

Thanks for reminding.  I think I was waiting for Brandon or somebody
else to say something after [2] as the final confirmation before
queuing it, and then the thread was forgotten ;-)

Will pick it up; it seems to have some interaction with Brandon's
6d1700d5 ("fetch: refactor to make function args narrower",
2018-06-27), and I think the correct resolution is to move your
removal of "&& !rs->nr" to do_fetch() function where that commit
moved to.

Thanks.

[2] https://public-inbox.org/git/xmqqd0vwcfkr.fsf@gitster-ct.c.googlers.com/ 
