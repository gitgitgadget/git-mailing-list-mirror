Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AF91F45F
	for <e@80x24.org>; Wed,  8 May 2019 19:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEHT1s (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 15:27:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEHT1s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 15:27:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id v10so3437006wrt.6
        for <git@vger.kernel.org>; Wed, 08 May 2019 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+sPf3ejrJGSiIqonOFqEARk2kzRzJigFYS5XDUNE1nk=;
        b=OrJEQOQFQwCBEQ+riNX9Yc6zhXXo4GnCZkSCFLAexqoUEILISsGedrsPspmJucnar8
         DxQvTy3bwavJE1LmfsyPXxutmc/65HXEdmCoBskacC22Bde2vVJMe0If8H+i51HyHyb/
         w2210EtLzIh0Acy6oDycckiZus7orYkvQVOuEQYa/u1T0HCxndKLrGwdZXUE+163dhao
         vjRzl6iWSihUh6uDWlJOi6Mbu4GM8EW1eljYIc3wb2spyOGihLne28UM8ofN9BvaCSBG
         HBmEFcpK1FR/ohPWsCfGVfY8LfUKUuyG3IteV7l12Hw2Dt5tPUo32hVzP+++59EXhyw0
         sWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+sPf3ejrJGSiIqonOFqEARk2kzRzJigFYS5XDUNE1nk=;
        b=GAiTQrqjmF6hktOoYsZNlABN62ex+ibkjDTgjv0BsXRlO7S4Or8xGhZnhSn1Hf+KRJ
         HW9dUg3OHQT157bmwW+XaxA5Jqq+mILJgkZd9ZTUwA3JIeWd6EguhZrY1cirtf6kfc/O
         vGKHm6zaCnqp6XWgtrV9CR/ykziu4HOIAOFl1EK7tlf0iYB2N7bL/xr+E/Vg4N72A0X3
         V27NKEYB6AmDr/mxO/v+4SXH/pk0D0kC6jWOv8XTscThJaohQGoSaokxU2SeFsBESOnc
         ySublzFGqaxIauRhHceilZxYyOoqLnIOPXGEzBhaFePSiicHoHKSKMQb+eA7kp7GVxJt
         MfZw==
X-Gm-Message-State: APjAAAX0yc9xK34Zk4R6NOfiU+usOcgXERUY8RnANRHcQTlYV9FZx0ib
        qUiCJ6isluJlv5UMlOm1SlE=
X-Google-Smtp-Source: APXvYqz/elOKEFDdGIBStZQnb/vzxR9SPi/glk2pVVtZ139G3ejAa2Z8W0pEJbCUv7nLKMdq3xI24g==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr3678418wrq.59.1557343666180;
        Wed, 08 May 2019 12:27:46 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m8sm30450450wrg.18.2019.05.08.12.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 12:27:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] [RFC] Commit-graph: Write incremental files
References: <pull.184.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <pull.184.git.gitgitgadget@gmail.com>
Date:   Wed, 08 May 2019 21:27:43 +0200
Message-ID: <87r298hhlc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 08 2019, Derrick Stolee via GitGitGadget wrote:

> This patch series is marked as RFC quality because it is missing some key
> features and tests, but hopefully starts a concrete discussion of how the
> incremental commit-graph writes can work. If this is a good direction, then
> it would replace ds/commit-graph-format-v2.

I have some comments on 12/17 that I'll put there.

I think it would be best to start by submitting 1-11 for inclusion so we
can get minor cleanups/refactoring out of the way. I've only skimmed
those patches, but they seem to be obviously correct, although the diff
move detection (and with -w) doesn't help much with them.

This next bit sounds petty, but I honestly don't mean it that way :)

One minor thing I want to note is 04/17. The change itself I 100% agree
on (in-tree docs are bad places for TODO lists), but the commit message
*still* says that a "verify" is just as slow as "write", even though I
noted a ~40% difference in [1].

Do I care about that tiny isolated thing? Nope. But I *do* think it's
indicative of a general thing that could be improved in these RFC
iterations that I found a bit frustrating in reading through
it. I.e. you're getting some of the "C[comments]", but then there's
re-rolled patches that don't address those things.

What we say in the commit message for 4/17 obviously doesn't matter much
at all. But there's other outstanding feedback on the last iteration
that from reading this one still mostly/entirely applies.

So I'll just leave this reply at "I have a lot of comments", but that
they're still sitting there.

1. https://public-inbox.org/git/87o94mql0a.fsf@evledraar.gmail.com/
