Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE101F453
	for <e@80x24.org>; Fri,  2 Nov 2018 02:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeKBLGV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 07:06:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38054 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKBLGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 07:06:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so629525wmh.3
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2sIi+OMvQPO5uGZD7c91Mbw3QlmKLLYRMaNbRmTr5c8=;
        b=XHta1RqVsZyTzdBxCOBZr6un5ucswza7K7iPVCssrQ0fNFctLxofY+t4Jyc+jrtJuU
         3Mbc2ptVmwt6kyuhQF2tHpWZkt4PVt/K4QeSlo8iJnXATt5EMcxs+0pdXnkG8hhj+5q/
         ocorpb5HDDuA2zXxf149Kjx1pMw1kgUz0nrmY+dZLae7mpiXhuUEzAMrD5zUWrLUla3P
         p9iqDcVCdfMT5KeR1ZAqh8z9MnMTzLBS6TjuRpRIwRlqpBu3F5wnWrJdhMygxs6YTpwk
         pg9OMpgTpBVGh/T8fWGWdsrx2nTnNMM659fAm4dgaYqzcmMBi8lM6ZWW2QKlXkbyPgYI
         pSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2sIi+OMvQPO5uGZD7c91Mbw3QlmKLLYRMaNbRmTr5c8=;
        b=cJpGxpABXunx5l1HEYiBOS08evZZSgaejOG0hyWtURYznZX9js95FRRg3B+5ZnKA6B
         Zj8ZjvnxK0v9w7OuFG/Ql9zpdLU0GlHK+n26VDtn9UkpyPUFn+hZkP0mLqM7uPxrHjCh
         GYH5MQ6PJ7jKROb8vlaontgSCJvW+0D/i8HYkLFBMQQMGbJJCN7q/2ke5Vb4vb35IQ94
         8IhAhIevFTNW9/Fl5bfd1VfCTww9J7iIx3yd8CbP5ZXL+vqr7ANylBbVA2RxQoJazNB6
         LRBuVmxIkTdCa9LSzg1S8CNdY4/gv26HWMFT3afsJTWXOo0NyNNeFMxdFeW4JNwqRnRe
         HtHQ==
X-Gm-Message-State: AGRZ1gLggTDEfKZwnp7WIy5YDJnwN3P4Bn2EOGdxdSOqiMyBf261v/Zf
        vrQEfMoqZ8DSFCrFh+dlKC0=
X-Google-Smtp-Source: AJdET5eE3yGX5BQwYCNftv+lyI38INRdtyRJQsOHYMUSFDPXqyosfdyMNZr8McZpvrJVjZ/+9oEhbg==
X-Received: by 2002:a1c:2946:: with SMTP id p67-v6mr2605352wmp.114.1541124054792;
        Thu, 01 Nov 2018 19:00:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e6-v6sm35240882wrc.70.2018.11.01.19.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 19:00:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCHv2 00/24] Bring more repository handles into our code base]
References: <20181030220817.61691-1-sbeller@google.com>
        <xmqq4ld2wrcq.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kacJLv7Eimgs82W_tEJR57o5HoDvmYfv4T2U9_gs0-Ujg@mail.gmail.com>
Date:   Fri, 02 Nov 2018 11:00:53 +0900
In-Reply-To: <CAGZ79kacJLv7Eimgs82W_tEJR57o5HoDvmYfv4T2U9_gs0-Ujg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 1 Nov 2018 12:45:52 -0700")
Message-ID: <xmqqftwks0fe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> What was posted would have been perfectly fine as a "how about doing
>> it this way" weatherbaloon patch, but as a part of real series, it
>> needs to explain to the developers what the distinctions between two
>> classes are, and who is to use the cocci patch at what point in the
>> development cycle, etc., in an accompanying documentation update.
>
> if only we had documentation [as found via "git grep coccicheck"]
> that I could update ... I'd totally do that.
> I guess this asks for documentation to begin with, now?

So far, we didn't even need any, as there was no "workflow" to speak
of.  It's just "any random developer finds a suggested update,
either by running 'make coccicheck' oneself or by peeking Travis
log, and sends in a patch".

But the "pending" thing has a lot more workflow elements, who is
responsible for noticing update suggested by "pending" ones, for
updating the code, and for promoting "pending" to the normal.  These
are all new, and these are all needed as ongoing basis to help
developers---I'd say the way Documentation/SubmittingPatches helps
developers is very close to the way this new document would help them.
