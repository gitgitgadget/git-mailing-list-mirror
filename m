Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7521F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeJaNX6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:23:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbeJaNX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:23:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so742823wre.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tzbCAXcC8Po2GU0JvU8UgZiznyS9VyKhy+2ap9Sm2zA=;
        b=UudJEsoOOw1nC42DwbzJGlO/9hhxeIKkR3NPF8l9JUZHZkWD9LQO2fbs47o6NV1xab
         WzJhU9Fzg7oOo9xkXgG234H4sh1jf2ii2sEpAAXuEEw91ZdXeYSRQgy0db0kKny74SgT
         G5p7uuWf4fsFrSIZBgAi/LMngzTmlQ/BN8VTNnmK4oP/q8ToFJKaP27cBZprjhZ12nCm
         gKZTLCDfhL3EerNJmNDV/I77EhyipiiGBCviYN4JBYlzgj1Do+zEpF706+QOl47BwiV9
         bcxScNmJaL3oCyrvc7sBri4oO/B8h/m/hNdzjj6Wq2svq2iQ+4qzW5GJGrMIykpBmRi4
         Oq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tzbCAXcC8Po2GU0JvU8UgZiznyS9VyKhy+2ap9Sm2zA=;
        b=QQvTQM9pZKdg50pDZHbY6gU3B9jd1rukKc/4RzfWsB1Ccw/fZJBMCRrydLZtTuV6GL
         7lzO6HYaOCC/YxAkL8GJxtuNsFIjB/NzMtrIg1L5vq0XHW+dDti7UrJj/2wu6U/M8Rlb
         wMzoO0T7LAGQ8tPA7im2Zm/TmWwL/5HjfDDZKNbDWUYJgFBIWeFWTA57hOvRAQOCgeP3
         AfbEzdqIrTxNwRELkY4BCj+zRhEuQxk2so2Pz5Wl2kwtdngqCOGEStem8XnA3CUjypDc
         8Rg2Qy5bPZ5NkpcPfhl6Bt6eLq+3YhdWV20DF2Dndq8CDK8V59Op4M6699pNfA5Y4eB5
         Ff7g==
X-Gm-Message-State: AGRZ1gKHIsZyLRncJlYiBh5DBFSIQKSSYzqdbwStZbO94i65MgtrA0ZT
        9AQRCCnZg2TS9+BPxScTEjWV90bJHOY=
X-Google-Smtp-Source: AJdET5cPBFHer+7Va+/kB3nZkRmkY3RPSm3Qg19JsLGFtiKfyMqIep8zPQgS60jiBe6TQ85a051zNg==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr1169762wri.217.1540960054555;
        Tue, 30 Oct 2018 21:27:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q185-v6sm13857599wmg.45.2018.10.30.21.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 21:27:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     james harvey <jamespharvey20@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: Using --word-diff breaks --color-moved
References: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
Date:   Wed, 31 Oct 2018 13:27:33 +0900
In-Reply-To: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
        (james harvey's message of "Tue, 30 Oct 2018 22:05:48 -0400")
Message-ID: <xmqqlg6eyc3u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

james harvey <jamespharvey20@gmail.com> writes:

> If you use both "--word-diff" and "--color-moved", regardless of the
> order of arguments, "--word-diff" takes precedence and "--color-moved"
> isn't allowed to do anything.
>
> I think "--color-moved" should have precedence over "--word-diff".  I
> cannot think of a scenario where a user would supply both options, and
> actually want "--word-diff" to take precedence.

I am not sure if I follow.  If these two cannot work well together,
then we should just reject the request as asking for incompatible
combination of options while we are parsing the command line
arguments, rather than arguing which one should trump the other
one---that would simply lead to "in my opinion, word-diff is more
important" vs "in mine, color-moved is more important", no?

