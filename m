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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BEFA1F45F
	for <e@80x24.org>; Thu,  9 May 2019 23:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEIXtS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 19:49:18 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44157 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfEIXtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 19:49:18 -0400
Received: by mail-ed1-f48.google.com with SMTP id b8so3515618edm.11
        for <git@vger.kernel.org>; Thu, 09 May 2019 16:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JK3Ybox7SGAMZZbetVVEb4Sci5k5fp6RoJk2Ujx5iwA=;
        b=JU+6y55mvGAvPQANwmdu9gvdbAyXvFDR8fVP2fzufK7Is3PDQolW5jug51wpLBejts
         WL5wJpo7qhvntZWd9JG0uHuqPgSUKDNMfB3W1qhIHLCPF7PsIN7p9av6Rch52KkA8+zS
         wd1Nh+xMnbJxT24E/aTCexKIOnlM/nEm49nlBaYjYr+667tzVloOjw+7L5tk+F7huG5h
         OguQ7Jb4a240r14mQBik6AR8/n6rA63SDmFZAAvTPWLJsxxWJLpuPlIenDGoZxkiIn9Y
         QksHUDjeBh4Rq4WY0gGtMcAsf/0w7agFepqvlX245kzviu35YP3CIRsFdEJX8NCzIx82
         QV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JK3Ybox7SGAMZZbetVVEb4Sci5k5fp6RoJk2Ujx5iwA=;
        b=sRRSvhZ8J1o9LNAKzNBSOMa8uOE1qCHuwD9EZ4fUfMmCzFzlB75m0MOFecg3vbQj+3
         oBDa8w6c3FgI50Mw8D3+EhLE7V/NoMSTlGPe50eas/ULpPT2TLq5BUG+H3rQYpdKo8DG
         qYFi7Ef4ROwJid/qACtSRBfPCmxDzZ+/S3YLJd1aC1eNajoPxlwHl0gl9drSCeXaVvkY
         hxoBlhrCrAS3hx0Jc2XpaJxnewqi8taVrisiF52yIHMkOQ2rnaz0VOxqeE3nr93+6vOd
         qbNc3ULUE5GRHqqJIgeHyvxPQcGaVLulFvl6/lkTC4SWgSPAH5fNPaVbMcFbpX2pARAm
         iFJg==
X-Gm-Message-State: APjAAAXL9vCD/5uAkZVVIBdEZ1xKpnItBOlMzR/4Wu57srJvvIo4qlFx
        ImJCKFRH4br7Iw23zy0gmKA=
X-Google-Smtp-Source: APXvYqyONPY9XnGG9k7HSGWNQp7EUzdgpI/zpVKupgK8i6Mb4WumjPRlNFW708SCL4wUHlZjHF54xQ==
X-Received: by 2002:a50:8682:: with SMTP id r2mr7039127eda.106.1557445756657;
        Thu, 09 May 2019 16:49:16 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e18sm460203ede.68.2019.05.09.16.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 16:49:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: How to exchange rerere/redo resolutions?
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
Date:   Fri, 10 May 2019 01:49:14 +0200
Message-ID: <871s17xk79.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 10 2019, Philip Oakley wrote:

> Is there a mechanism for exchanging the rerere resolutions, so that
> future fixups, e.g. future clashes on pu rather than master, can be
> sent with patch series?
>
> My current use case that there is a large patch [1] for updating long
> to size_t for use on Windows, which notes that it will have clashes
> with pu, but doesn't appear to have any method  of sending a rerere
> resolution (which the author is already aware of) to the list. Being
> able to flag up such fixes should simplify such conflict resolutions.
>
> I had some very rough ideas about how the resolutions should look
> rather similar to three-way conflict markers, with the resolution as
> the 'base' (between the ||| - ||| marks), which would be resolved via
> a --base merge strategy.
>
> However if there is already a method for exchanging resolutions, where
> should I look?
>
> Philip
>
> [1] <20190413151850.29037-1-tboegi@web.de> [PATCH v3 1/1] Use size_t
> instead of 'unsigned long' for data in memory

You can publish your merged branch somewhere, and others can use
contrib/rerere-train.sh to learn from the resolution.

Supposedly, I've never actually used it...
