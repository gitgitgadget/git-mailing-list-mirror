Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9735120D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 19:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdFUTzM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:55:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35095 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdFUTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:55:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so29466615pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rjf7oDeqfAx/PcLqhbiLt4q7iSt8ms5COrG5fuyfHMo=;
        b=Qf5ZEjYPhQ5WVJQQyNTqFwMfQx6XKwToMY5+f9fL1xkj19iIgtdafHfWaeucOND+RL
         d1Ah5QnGpKcQiKRpYWfRiyDUp4bQw2Le2kT9n3mSH7lnrrYzPSnMbXcPFprzfSm0ZFjK
         NM1SvoVRAgFxhiZpik5Ok/u9inlXwEa+lGhD8BKaPUfyKfHmMUY4Blqy3tuCncCWUqnx
         z/ZPdYJOlP052/uXUFwEZxVQaUBT2o8J3tqAqDrc50UtbQYsfMgQiTcPEoRcgZP4k7DX
         XqJ5ObMlIJ1HyFIFUXIkx/WqHCDhYvZCCE0GbJRiav2+SxhTEOwN83KBjw55YIuAerjC
         eZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rjf7oDeqfAx/PcLqhbiLt4q7iSt8ms5COrG5fuyfHMo=;
        b=m+Pz+3J2U4bji1LqYmseVju1STi9yD3qfkAp3cABrhZFbncpvIhibh2KskPoNbTLv3
         OyaIZIIRvs0IKB0nAd/gtkbQxhF6aP620xZfQnm0U6a9yT9oDBDFLQz/9Xu5VCNxFBsg
         sDzlKxu4MHbLW4mgsZR7GkPvAvyl9epIAIFvQZdjB13GD2PlH7GHV8yyUKnX6FrYkZT8
         GmGVhZJlFkKu7PE2DFUBRgxbbQvaoQ2XTRM+NjTVWB7Rzw/EIMSL1BPYkcoGAwPHTTvu
         VLBXbXE3EfEIr+7mNe8peNp8GO29qFSEb4Cm1I335UDVNFq7RCC5AEDATxDoi0mEQUDq
         llTA==
X-Gm-Message-State: AKS2vOy3sktdi8nuft/XmvVHzwOS+zKECuVWNdHkPmmzsf+BelXB1SbN
        41b1SZ4685TOaHrpLU0yuWyO4vg1vvYr
X-Received: by 10.99.141.76 with SMTP id z73mr18917567pgd.40.1498074905872;
 Wed, 21 Jun 2017 12:55:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 12:55:05 -0700 (PDT)
In-Reply-To: <20170621194425.vcu6qdmoddwpi3ht@sigill.intra.peff.net>
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
 <87efud8jrn.fsf@gmail.com> <20170621194425.vcu6qdmoddwpi3ht@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 12:55:05 -0700
Message-ID: <CAGZ79kau0cxRw6_bFKw6-wc2J9fBPPjRfpRhSxD+BGi2usvNpg@mail.gmail.com>
Subject: Re: Monitoring a repository for changes
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tim Hutt <tdhutt@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 12:44 PM, Jeff King <peff@peff.net> wrote:
>
> Yeah. The naive way to implement this would be to have the client
> connect and receive the ref advertisement. And then when it's a noop
> (nothing to fetch), instead of saying "I want these objects", say
> "Please pause until one or more refs change". But I don't think we'd
> want to leave actual upload-pack processes sitting paused on the server.
> Their memory usage is too high.

https://git.eclipse.org/r/#/c/6587/

JGit has had its experiments with some standing connection and then
having some sort of Pub/Sub system. AFAICT it did not go anywhere
because of the number of connections (even if you optimize for
the serverside, such that each connection is just the cost of a java
thread and a file descriptor).

>
> The sticking point on both is that the client needs to speak before the
> ref advertisement begins, which is why we have to deal with the protocol
> v2 headache.

I would not call it headache, but large project that is not to be tackled
by one person alone. ;)
