Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B291F461
	for <e@80x24.org>; Tue, 14 May 2019 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENIVL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 04:21:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36341 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENIVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 04:21:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so21605646edx.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ikfsTqO0DHlYQKcLkyzMg15pzFYWqGeykTdFIzh4cok=;
        b=angiFC9uUt01fs9fhuadlAavWtIRwYw9Mh7U67xVXQ1erbEcAnhRFrtMR5V9r4Iuo+
         eswFAVerigXuXzkgtEUOlzEgAVKsUdy9j0RnYFAbzzMsS1cMpSArgvowq/cQW+dQHGE5
         OZnZ+BzMh7c7TlGs32Z8cdd/2F28Tkdrh6w7KOlY0aTSPAaZC7tPUvkjbW4PKyMGDqJU
         LL3GeYn1X8B0+YAdBHlO1Oah2m+E3J0B4JoJBBXd1yNdYuI1TFd31/FeW18uX3dSNCO9
         txlRFPd3gvBrW89M6qPA7Nk5nle6YLCYBtLNs//T0UJFzSYzijvETfON4HXqOW9vi5XL
         eDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ikfsTqO0DHlYQKcLkyzMg15pzFYWqGeykTdFIzh4cok=;
        b=O3NsvuRb6W2IgDzY7uFKF3DcGlkqvE+vwC8Iuo22351p4C11IwrpG37O6O5fTtgTGe
         92Uqv3F2ZwaOdtPnwSOpneZyS+AKABvoQoZI7si2thJ7+jjaSCoPJlsJCvuORM1QnLAF
         vNfRjy48YfNK9zl06Yuh1hwiLyw2eZwN/MATdgd5eaq91vpKyIjFz57inclYZWGmRiAH
         ohvA3IOGltyIU3PIQs4/SzdLtRjLFNaOTYeaGZAm47pP10p1//f4FUPyu3p/sb+pLm1Y
         UYleyVfn6sfY505heFKP/70ks1JpLGuJlYxITBT4c083sZGCmaYT/Kjme2scX9aqLN5y
         H/Kg==
X-Gm-Message-State: APjAAAWawxc/WrXaPUaRj8Jkmw7hgCHbM5P5fjyjLG2aSaYr97BLxoa6
        Bvrw6byYkocK0W34Vbam8WiMmbiF9DU=
X-Google-Smtp-Source: APXvYqxEKo65lEj1W2sC2UoAWD4zhMZR7YpLPjQ8KBwAoaidnWz6HdnhA3AjrWM/JJueTx4iiwbrTg==
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr34482664edt.23.1557822069886;
        Tue, 14 May 2019 01:21:09 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id z10sm2089145ejg.36.2019.05.14.01.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 01:21:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: How to exchange rerere/redo resolutions?
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org> <871s17xk79.fsf@evledraar.gmail.com> <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net> <d139d79a-f35a-e00c-3790-104146b066c7@iee.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <d139d79a-f35a-e00c-3790-104146b066c7@iee.org>
Date:   Tue, 14 May 2019 10:21:06 +0200
Message-ID: <87mujpwiod.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Philip Oakley wrote:

> Hi All,
>
> On 10/05/2019 15:59, Philip Oakley wrote:
>>> You can publish your merged branch somewhere, and others can use
>>> contrib/rerere-train.sh to learn from the resolution.
>>>
>>> Supposedly, I've never actually used it...
>
> Does the contrib/rerere-train.sh actually work? I'm reading the code
> to ensure I understand what rerere/redo is doing, and in the training
> it tries to detect MERGE_RR via L87
>
>     if test -s "$GIT_DIR/MERGE_RR"
>
> It's not clear if that is an internal implementation detail, or a
> mistaken use of a historic path name. Can anyone enlighten me?

Historic? No, this is path.c now on master:

    path.c:1454:REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")

Internal, sure. We don't document it so it could change in theory, but
then we'd probably change rerere-train.sh along with it...

>> The tricky part is when the patch series doesn't apply so the
>> conflict isn't yet on any branch..
> When copying patches across to Git for Windows, the conflict
> resolution can be tricky.
