Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7151F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeIMA7J (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:59:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54466 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMA7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:59:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so3681375wmb.4
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SYHUNr+9sCvM58oVTmGYjtes22JAA5SR5TZW0SRwr6c=;
        b=kWLq0MK0E5nLyTtzkE4m8qCBhBzTsTpJrPnj8wyso/KnYBxv6Q9zFd/S97FKmwT/d0
         6erySMgUz6Rc0BGsGO0IFIc3b7JR/W/3DpzAHoYAAYVqu0eS/6D2VdpJMhshkrthTMpW
         jMSAGd+q9SzLydqDjMWlYiZ82WUSbvTP/53W8lBwSGeLyjs3X/UHX89/D1UYzhQmsNPi
         K3nzk5zgHcTE7ptquwfpgMVHlp9+DwvSsN/45Qo7FinUQBUYhQC/BRxfhF1h0dRME1iR
         M3Z7oRY+JXWsXVdw6z4x4P4qo7pqrYRWWyp6s7Pv7nBwXo+h7KJSLCaSJUvlJEpGfMW5
         4lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SYHUNr+9sCvM58oVTmGYjtes22JAA5SR5TZW0SRwr6c=;
        b=QqJ3HpVbk894udjBCvFmt8DS2//dtbN+GC2+ovV5aUg1dSC8Km89WkZywn1iC0Ui5w
         T22FWeYdRBWh/gO+GxpOtT+I3IpKbRPBRYUaDMY9+g9HoQSpnpuVEmQ2NM/iTQkmBYPZ
         /P1ZEouufSVffJyFIN62x0A8TUxi8A1C1jOofUExB7bOkfp2+HF1rrrhDr70qmnd8+FO
         Mh5ycaTJ4Vins7syoEicCJsGlyGGpSKOopKpix9wYFPYHEopE1A8F7HnZkztcO67p7Ht
         PJQoLPrKFjtFn3OQ9YW1TB0SJ2Sis+tk61cdDGd8LSS3P32oWlvuIhWNJyhHfKyQgTb6
         sn/w==
X-Gm-Message-State: APzg51BC4WwEoVACBLhOG0JWLzQb5Ei1fa8EM76X1PyLw7NyyGRg7KUg
        jtNkfuwHGkbrUyjesfrNNgDElKfCXaA=
X-Google-Smtp-Source: ANB0VdbRWwDyYiU/DhoasKmLmZSj7Gx19rK+XrbftbyuFNP21RwmHxCj8yoaY3BvWC1dXk8y1oX4pA==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr2904012wmt.31.1536781981967;
        Wed, 12 Sep 2018 12:53:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u1-v6sm2017275wrt.59.2018.09.12.12.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:53:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 0/1] contrib: Add script to show uncovered "new" lines
References: <pull.40.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Sep 2018 12:53:00 -0700
In-Reply-To: <pull.40.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Wed, 12 Sep 2018 09:45:48 -0700 (PDT)")
Message-ID: <xmqq36uelcgz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> There have been a few bugs in recent patches what would have been caught if
> the test suite covered those blocks (including a few of mine). I want to
> work towards a "sensible" amount of coverage on new topics. In my opinion,
> this means that any logic should be covered, but the 'die()' blocks in error
> cases do not need to be covered.

Nice.

> It is important to not measure the coverage of the codebase by what old code
> is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
> After creating the coverage statistics at a version (say, 'topic') you can
> then run
>
> contrib/coverage-diff.sh base topic
> ...
> Using this 'git blame' output, we can quickly inspect whether the uncovered
> lines are appropriate. For instance:
> ...
> I used this approach for 'next' over 'master' and got a larger list, some of
> which I have already submitted tests to increase coverage [2] or will be
> covered by topics not in 'next' [3].
>
> Thanks, -Stolee

Thanks for working on this.
