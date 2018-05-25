Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717481F51C
	for <e@80x24.org>; Fri, 25 May 2018 07:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935852AbeEYHgc (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 03:36:32 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39965 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935076AbeEYHgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 03:36:31 -0400
Received: by mail-wm0-f54.google.com with SMTP id x2-v6so4545923wmh.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PZyXQ+rRiOWCQnopHv5bsbcZW/DCRozw8DEjmC6FaPI=;
        b=IeQzfBB1qmZywcgzVeA8CFDckdzfiUW2BCVk3FWquLMJt8RivSRkU8LUs7E14sqL1o
         7G0z3nR8XUR8kVov/dhSkmfzkrkWYbIFnhutsZZQ94fpqCgApKC9dhqw7E7VYwcJ3LlJ
         82yBhX8mo/UOu6xPabPxAK+KfHSt6BeewFgiuku5YSrwthPTpnTdON78wYN3nznR4xRF
         +ZbJJJ7EheybNe9OYloft0HKltinIPE3Mkqj5/FE/B3r9TAoWI9GqjY5aRe7C8HRuAu2
         r6gkEsS/6QSKcG3I8eT5EpdjB0U+GlGQG5pFdjfhLyib0mybaXJc4XGUf5XkALH+SfAI
         442A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PZyXQ+rRiOWCQnopHv5bsbcZW/DCRozw8DEjmC6FaPI=;
        b=CX/mE4L7l21+CJ+df79l8eYyOGsJCjck+bUCU//BJP733MIPFdiZlc/ISHTdghPRpD
         8p5E63zxcZn83cNh1aBU+TEEPT9M8H5hRfNQqw7+/H7TpiO4qld5ty1z3v5ulbnLss06
         MClicbdFrctPfy2wq+c4UiTsl+0LAlrro/kx8PWuVeodyXRuF7vUzDyERGonCnnzpxYe
         Xp9K6PHlqtqGLjDK/A7/qIvgHO0TNilAteINs/1qGAXNY98NeqCwPPvYaClaGek1eSGl
         /qzoowLr5bHVHyEWSZ/c/0YTg9RkBVtLBTxiH5nxBwDikBjlELYsBvs5J3HoFeE+6pC+
         PdiQ==
X-Gm-Message-State: ALKqPwccK8KdtNsAtDcn2vHh4in4L6+5/xjR4A2LIXIDY2x93U3IO5lz
        D5rnLmnCGurfly0xxfdgliM=
X-Google-Smtp-Source: AB8JxZrnlQwmBUXAjAPzVdbyyGlvzjBlq3mmDsa7NgkMnS+iL14paRPHmCE3GiQwBK139F0gg9WTGg==
X-Received: by 2002:a50:b2e4:: with SMTP id p91-v6mr1567562edd.84.1527233790304;
        Fri, 25 May 2018 00:36:30 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id k51-v6sm13028593eda.35.2018.05.25.00.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 00:36:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: BUG: No way to set fsck.<msg-id> when cloning
References: <87vabd6pp2.fsf@evledraar.gmail.com> <3e4f0b82-b67a-24d2-c89e-efbe9ee45dd4@virtuell-zuhause.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <3e4f0b82-b67a-24d2-c89e-efbe9ee45dd4@virtuell-zuhause.de>
Date:   Fri, 25 May 2018 09:36:28 +0200
Message-ID: <87o9h46vb7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 24 2018, Thomas Braun wrote:

> Am 24.05.2018 um 17:25 schrieb Ævar Arnfjörð Bjarmason:
>> When I do:
>>
>>     git -c fetch.fsckObjects=true clone git@github.com:robbyrussell/oh-my-zsh.git
>>
>> I get:
>>
>>     error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
>>     fatal: Error in object
>>     fatal: index-pack failed
>>
>> [...]
>
> Doing
>
> git clone --config transfer.fsckobjects=false --config
> receive.fsckobjects=false --config fetch.fsckobjects=false
> git@github.com:robbyrussell/oh-my-zsh.git
>
> does the trick here (stolen from [1]).
>
> $ git --version
> git version 2.17.0.windows.1
>
> I don't know why though.

Yeah, because it entirely turns off fsck on fetch, and we didn't have
any way to selectively disable just some stuff until the patch series I
just sent
(https://public-inbox.org/git/20180524193516.28713-1-avarab@gmail.com/)

> [1]:
> https://github.com/michaeljones/breathe/issues/340#issuecomment-390775142
