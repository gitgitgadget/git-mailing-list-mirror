Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28E71F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbdKNQsY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 11:48:24 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46587 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755325AbdKNQsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 11:48:09 -0500
Received: by mail-qt0-f172.google.com with SMTP id 1so26534271qtn.3
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gYrc4XKlsNQr4tlJ68wo70Yu2vhBNSpk4s3MQOgDnO4=;
        b=hQDJX/khD/tnShCUEUYKWQ7i6vZD5IkqZMjXY4YCammsGA36ASXxkhtlRWKDpn8UCp
         7XmzbfoOgafauH7BT4l/PwakUKaZ+C1cXDsMKFcmjFd0cEhvC8hKVM7Q3yrJ+jEGluuh
         h1Gb20T2o5+vkJwBB4bjj8OENMHPFJrjol1ZDoQCM4UsM4d/IxS4bj8TYyGJOcF7DgJb
         vgpGbP07M16NFpQbtLofzGbHw3NAJkkBFmFbTtARTDCmUeiPva117zJDurEBB2FKiCY+
         1MtFHRiJI8uNQ1P+VSXRtL+lblLe3J3/w17/gdRExgU2ZypOlXs2UTS7uNatXbMlyVUV
         HacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gYrc4XKlsNQr4tlJ68wo70Yu2vhBNSpk4s3MQOgDnO4=;
        b=PRB4rluj+CDmvfvhRQsRJQ9zjOeMT8TKbsNx7fqCpdp2wzbearObofrsWqBIUpqpLz
         QW0nWV0qhUchi/zW85AIs+Hlfr8EwzAYoPW55ugE712XIEs0YXxm2p/RvjXHFutq/T9g
         NCeya+OBHOGrQrLH2SjjB4d1xSqeIe/U58j3IGU4qi0+FNtYw6XvViWjQortfN14PBz+
         4fcDMNDn3IqPjsCzY/k595i4QVn3tvttWJmFD3FXZfyMCBUSbTBkfyPTUbg8RTqEVQfG
         eWGC7/CRVWUsZU25pi7AMo4k5naMKbuGxE36UBdLWLQTQwZcwnK5FCC43W27wGuReZkh
         1YlQ==
X-Gm-Message-State: AJaThX5XTWdOJgzxCY8Iz/PhUjPxNh4uqdTMvVAcxYj7RyMq8QB8J+0A
        lBiqSq+BqOQUovq558fAIckD2NmCcOqYFohYy94=
X-Google-Smtp-Source: AGs4zMaR3bPxiOb8L6/rQzZCioltwxW6h4YK03POHUEJLGw2BxbXZP8+AwoNMbKlx/C0DGTlchEwzl6FNGABCYsRzY4=
X-Received: by 10.55.130.194 with SMTP id e185mr2554926qkd.357.1510678088478;
 Tue, 14 Nov 2017 08:48:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 14 Nov 2017 08:48:07 -0800 (PST)
In-Reply-To: <3af0f8cc-09f3-bcf2-04c8-f076e0ddcea2@xiplink.com>
References: <4f548c23-7bb5-a672-21bb-6c1dd6de6139@xiplink.com>
 <20171114055306.3tfi726wzmkcfluk@sigill.intra.peff.net> <3af0f8cc-09f3-bcf2-04c8-f076e0ddcea2@xiplink.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Nov 2017 11:48:07 -0500
X-Google-Sender-Auth: r1wxwqoXeh7rGJ5HueKu5md9vCI
Message-ID: <CAPig+cS8fg7UEX7eO4LLrVuuuBCxOVbhqmc5xFGqv3mT6s0=ng@mail.gmail.com>
Subject: Re: Recovering from gc errors
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 10:39 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> I'm willing to chalk this up to bugs in the early worktree code, unless one
> of the CC'd worktree developers thinks otherwise.
>
> An explicit "git worktree delete" command would be nice for manually
> cleaning things up.  It's easy to just delete the directory, but having a
> "delete" command gives the user assurance that they're not missing
> something.

Duy does have a series in 'pu' which adds this functionality, but I
guess it's stalled for the moment. From "What's Cooking":

    * nd/worktree-move (2017-04-20) 6 commits
    - worktree remove: new command
    - worktree move: refuse to move worktrees with submodules
    - worktree move: accept destination as directory
    - worktree move: new command
    - worktree.c: add update_worktree_location()
    - worktree.c: add validate_worktree()

    "git worktree" learned move and remove subcommands.

    Expecting a reroll.
    cf. <20170420101024.7593-1-pclouds@gmail.com>
    cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
    cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>
