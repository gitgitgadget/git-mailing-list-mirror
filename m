Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6CF2035E
	for <e@80x24.org>; Mon, 10 Jul 2017 23:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbdGJXi4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 19:38:56 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32792 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754886AbdGJXi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 19:38:56 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so57390040pfk.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GEyc19BvjXnEIn77YektRT44ErFeRZLNYdTe8ReCSiQ=;
        b=OAGdntPPDUfaoGhRgLltSLNKC2jefUrlmWYnoIxgYIR29CVNHcPVzqzgF0GKjvKz3Q
         A2DjJ1KGcE85r7H7b3jF+aVjPYd4HlTE8ncbRto5d0XqJfjxqGGjrbGPCrL+pWE7AkYg
         ltCrehYIWDxyrX4QesQYleuL6/K/jYsZkmvuJ97n4cC4wqUhaSgoCZjWfk3QIbhDO8QF
         di3YPM4IT7vgnAPN9k8AEQaNgMwtlyp5XMHyAPK0UciQFa3w3+Ta/9fVpc7TYi9dumZ2
         6aXB5+ykLCNQtXbUwQJNhj0y4OzIqnnmkKqcIeWpkYJ1viD8SpFdL69/LP2cGPlWuZ8S
         A+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GEyc19BvjXnEIn77YektRT44ErFeRZLNYdTe8ReCSiQ=;
        b=DiY1c0w1SqQv4Sz+FM/GKvoXBeIQO5yZHjTG4is27r3uR5HM27MEH3AUqNlZNKBEE3
         wWjbP2vDJAdM7Hff+v+9BS/tkHxyitSLfrl78/I/hl8Jcvnx3Xuy9cyksBFqQOY76VOm
         Ss69g2r0BIp3q34g31ALDK79LwZYFT5XcfXn9ebx39hhQCL8h8CjHftCDlWNPj9NFgNM
         ViSHgNyFBpO50fKQpvG3vMRSMyzIxMVDc0SyTNWp8ZrJkA83VV9m68QHDhE8JD4JWEPE
         bC7XkzGlDKVQRa9E2Lt0/SJfM+SI+sTTy2xYJomiAYghYXVWjiasS5p/wB4kg6a8bypR
         n15w==
X-Gm-Message-State: AIVw111Eqrjxs/j9z66PaWDZqjxmUyKN7Cztfm7kYq2O01stLD8sfNUn
        ilhBofyCSxtt3zcATNzG11X0o9Mw9PLp
X-Received: by 10.98.58.67 with SMTP id h64mr24943778pfa.19.1499729935333;
 Mon, 10 Jul 2017 16:38:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 16:38:54 -0700 (PDT)
In-Reply-To: <20170710233247.GC161700@google.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com> <20170710233247.GC161700@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 16:38:54 -0700
Message-ID: <CAGZ79kYpFHkkhdkwYXEnQiWfuRONurintje575YVLE-ZVVRvzA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/8] submodule--helper: introduce get_submodule_displaypath()
To:     Brandon Williams <bmwill@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 4:32 PM, Brandon Williams <bmwill@google.com> wrote:
>>       if (!is_submodule_active(the_repository, path)) {
>> -             strbuf_reset(&sb);
>
> Is this line removal intended?  It doesn't look related to the rest of
> this patch.

It is, as &sb is re-used and has to be cleared first.
With the code above removed, &sb is unmodified since
struct strbuf sb = STRBUF_INIT; hence the removal is ok here.
It is related, but only when looking at the entirety of the code. :-/
