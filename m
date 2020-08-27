Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD23C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CE52087E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0TbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:31:06 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41344 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0TbG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:31:06 -0400
Received: by mail-ej1-f67.google.com with SMTP id b17so9211830ejq.8
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1jtas3OYSR1IijD9JDzuFNCT8wmgRsmcJqJE7dYnA4=;
        b=AUbeoc8PxyPb19aDbSOtq3iI9cLJLJQV87AEiCk+6PFjlG68knl+/PpQ77PIMUPR3k
         NFSnjuoKKjFUpVCg/xz7AtrjdvYHhMJ0JoPZ7lg3um8j93u5jN3uEOYKEmBQhqpPKyE7
         wqNudwQPwsgxfIf/+MJc2YujzWyUjFfmqzbwVEsZSLxdq7riNWY3JWaQ6q286iK95Xxi
         chInGxWqB0cAKnv9/Wg02MJpDcvniFLORuO/bjqZj+vb1weAxuiJmn/1v2FabkmQf4ZS
         I7tU1IkICEtD5QFDqFPpIe6yYbRSgHOzrU8xmMLfNd3ExpML7NE/6Ykrg8OdY5xzCPud
         S83Q==
X-Gm-Message-State: AOAM532u97WT3/p4+0KbvSrF+5uivNCfYlIPeOCfJujRVhv3mRRvovNZ
        H6H46/y01B8HRgDEC6ycLws0cTQ2kjYyRkP3hrU=
X-Google-Smtp-Source: ABdhPJwVQTL2MW+H4xP+xMuq+NTQL/CY7ccfXiD6PTrp4QshGRECZXUmj9PIsn4a2I2vBXlHjHJ1Vi9HbrNbewB+FVU=
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr22306221ejy.168.1598556664797;
 Thu, 27 Aug 2020 12:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200827082129.56149-2-sunshine@sunshineco.com> <xmqqr1rsqdga.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1rsqdga.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 15:30:53 -0400
Message-ID: <CAPig+cTeGA7i2a8A9N1z00f_D06cwCSqWvJZidjGBRVAxBJaUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] worktree: add skeleton "repair" command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > At this stage, the "repair" command is a mere skeleton; subsequent
> > commits will flesh out the functionality.
>
> Sounds good.  It looked a bit odd to have skeleton test script only
> to reserve its test number, but it is just odd and not wrong.

The intent wasn't to reserve a test number. Rather, I was worried
about reviewer fatigue with patches [2/5] and [3/5] which are lengthy,
so I moved whatever boilerplate I could to [1/5] to make the later
patches a tiny bit shorter.
