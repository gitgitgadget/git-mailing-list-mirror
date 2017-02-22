Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98114201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 02:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbdBVC7L (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 21:59:11 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35369 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbdBVC7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 21:59:09 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so14100424pgz.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SH4Z+s7aKNVNhYikhKUB6fDMgL7PDcd9mxhqYKdhAcE=;
        b=djg1hMjfVLVJtOJQzheuuKenSGWEL+nEeV5DQM+pZ+1Ex+hIJvx4x1m3cAd0xXA8V2
         aitoqyOOCsBxlGOnoicNUiS1GWWVY2eCSSm4+1J7SQyCBT/5mrX/vuREGS7VWmyY2Wl8
         UNWM6z83e0HYT2CCICu3tJWy81zfu9dlGkQi+A+s1MOPpsi94UckZOhwlXdVvnz/BYWu
         ebVZTUlq5LrrhLMNi4xiEtCpxLf06yUtiQLJ4XAQwH1IQARM/HRdDWwoN1yTTYUusVKp
         FExwA4LntV07ngmxWg4TkWCfkcHRLPJlRqOYdtSkfBtRKhZEU1e5/saGq3Cvcrtkf2Qh
         6/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SH4Z+s7aKNVNhYikhKUB6fDMgL7PDcd9mxhqYKdhAcE=;
        b=WYxrL5JDzLQ2DtVHGwCXEO6qdrmROSU3MQnRiiajRHKmWUeu6iyifiqyVtWoxXdNOZ
         d0LGUaWxHDQPko82HikK8DXJLD1S9iqjT2PuMo7qxApz4aAvoXtV79zy13PWnVxvxDcr
         zJtN5IxhOyxhdggD4sEO7Z3ECWGgyUdvKw9aPMjSclkW8Z+LKxYGS5nxOXbpmnc3nnrC
         g6X+DdMkFpNCXGDVQ5HYic4aw79G86RkLZkXKzzTlqoZDOwr0xuytWDA17Ud2WAkIRTF
         wadfiWxk6ZSkIgqK2nULHtSplig9aTWbdtv4YGUihw1Dm77ou9W1c+0vOh9rMG7F5rXG
         WKOQ==
X-Gm-Message-State: AMke39ntPGsUrrANtF6cCbAuk8SZswvkuJIbBPIyP4Ml9Yt7bCUB7jOhbeyqir6HWhvaLg==
X-Received: by 10.99.51.76 with SMTP id z73mr39181223pgz.137.1487732348500;
        Tue, 21 Feb 2017 18:59:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id s13sm1076840pfk.26.2017.02.21.18.59.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 18:59:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Toolforger <toolforger@durchholz.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
        <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
        <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
        <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
        <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
        <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
        <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
        <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
        <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
        <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com>
Date:   Tue, 21 Feb 2017 18:59:06 -0800
In-Reply-To: <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 21 Feb 2017 16:07:36 -0800")
Message-ID: <xmqqbmtvdj7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> This is true even without any submodules.  The Git project itself
>> does not even care you are Stefan, but you still can and do add
>> [user] name = "Stefan Beller" to .git/config of your clone of the
>> Git project.  A clone of the project may want to know more than the
>> data project itself keeps track of to describe the context in which
>> the particular clone is being used.  And .git/config is a good place
>> to keep such pieces of information.
>
> This analogy is less clear to me than the kernel& appliance.
> When applying it to you (user.name=Junio) that has write powers
> over the blessed repository, the project cares a lot about you. ;)

The name that is recorded in the project history "Stefan Beller"
matters and the project cares about it, when the commit created in
that repository is pulled (or exported and imported via the e-mail
to "git am" route).  But what name you have configured in your
repository's .git/config, or the presense of your particular
repository for that matter, is much less significant (and that
applies to my primary working area as well).  The point is that the
project and a particular clone of it are entities at conceptually
different levels.

>> So I would think it is entirely reasonable if "git submodule init
>> sub" that is run in the superproject to initialize "sub" writes
>> something in "sub/.git" to tell that "sub" is used in the context of
>> that particular toplevel superproject and customize its behavour
>> accordingly.  Perhaps it may want to add the url.*.insteadOf that is
>> useful for updating the submodule repository when it does "submodule
>> init", for example.
>
> Do we want to invent a special value for url.*.insteadOf to mean
>   "look up in superproject, so I don't have to keep
>   a copy that may get stale" ?

My gut feeling is that we should do the selective/filtered include
Peff mentioned when a repository is known to be used as a submodule
of somebody else.
