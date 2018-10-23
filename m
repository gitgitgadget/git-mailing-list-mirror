Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533201F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeJWSo0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:44:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56088 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJWSo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:44:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id x6-v6so1157308wmc.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2TW69FYI/Bk4BOzsY+qPPsJ+glXWo9dRBQnU9E4eLRk=;
        b=fSq1Gg9VqzKHUlAMY6754pWuDE+rFlggyRUdFy/oatcc5s0LdyqI/HtZQNUYMKOKHP
         Emnb15eJLR4hU/F390UXrl/IY3Sdq4DogIqdM/Eh42ueixONprmlfNewIYXtmnNTWkh6
         UvvNLD7Ekr2xlYM+YR/CAZug0SdEvoJRqZm9rGAb/krlnJzEd6SKKAfgkCIvL57b/E+p
         xXeiqMKFwAIzN/qCLocXyMJ7aFuH+NV6Pj2kE0SutRXVW3BTGiZJjJXXj473w5su+Rs8
         twZpaJwDqAPGvni4QRaKUZPzGHxWSBb6fV9uGQEH11tjgsQ6EKbjPKZ+eLDZnoF6VAK4
         ltCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2TW69FYI/Bk4BOzsY+qPPsJ+glXWo9dRBQnU9E4eLRk=;
        b=X8KBIr5QPaV7jwzCuDtgo9BTO6lXce5fFep75eAKqE7yU6YLbY5Bg4BfkFi2Ht+oeO
         D/qfej/5eYjoF2Gi1zx88mn/zNcjmR34rXCdAJ6Esex57U7f1Vuj2h64aH+GcahVWo3U
         EkhOilXzv/x/+CNEKnVEGegNQeZCMjBwieQ3f4tyhRBk3P9pRG2Q7lBdvG75kv3o+qPI
         oa1uD535EmOfuRwq6qgoTQE5797i3rlTUiBXFy0hQuc5Tvipk6QXLFV+zRCSscQrW62M
         YaaZ11HHgnm8OE1KbvxaOXvW6X/tzqW7hye0S9vbiAPsMOX3XiWU/z12hny67Sr71dnn
         w2sw==
X-Gm-Message-State: ABuFfogvbIk35GnYYBIG2/tDaxFSatj8oC01Yof583NIU+qf7LpmRGzz
        K5EscSs5zH6r3yFvx1vj4/k=
X-Google-Smtp-Source: ACcGV63D1GyX3cjjtEeP0XJKEi1F0ttQe4tw8WhRD4z7kzILAbytp0FsHsT96U/pWjyCn7V+/On4gQ==
X-Received: by 2002:a1c:92d3:: with SMTP id u202-v6mr20861694wmd.39.1540290097696;
        Tue, 23 Oct 2018 03:21:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p1-v6sm1075954wrs.40.2018.10.23.03.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:21:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     szeder.dev@gmail.com, sbeller@google.com, peff@peff.net,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19] Bring more repository handles into our code base]
References: <20181016233550.251311-1-sbeller@google.com>
        <20181022173935.GG30222@szeder.dev>
        <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
        <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
        <CAPUEsphThzjDTrJJHwvbeP4w=6M=xHWz+DZStfXS62=5tSCbVQ@mail.gmail.com>
Date:   Tue, 23 Oct 2018 19:21:36 +0900
In-Reply-To: <CAPUEsphThzjDTrJJHwvbeP4w=6M=xHWz+DZStfXS62=5tSCbVQ@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 23 Oct 2018 03:15:06 -0700")
Message-ID: <xmqqa7n5rmj3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Tue, Oct 23, 2018 at 2:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The tip of 'pu' has trouble with -Wunused on Apple around the
>> delta-islands series.
>
> FWIW the "problem" is actually with -Wunused-function and is AFAIK not
> related to the semantic changes or Apple (AKA macOS)

Oh, don't get me wrong.  By Apple, I meant "the versions of compiler
used on the Apple build at TravisCI site".  I could have sent the
above two lines in a separate topic, as the issue does not have
anything to do with "new semantic patches" discussion, but I thought
it would be obvious to everybody who is reading the thread---it
seems I thought wrong ;-)
