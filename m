Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5171FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 09:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbeCHJZo (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 04:25:44 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35007 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeCHJZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 04:25:38 -0500
Received: by mail-wm0-f44.google.com with SMTP id x7so9699538wmc.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 01:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NgIDHjQKUojjaf2BsBD1jb2aasHj4rIZ+iMDkrtmFX0=;
        b=LVtUe2/tgaXPSBXgKXeBSqKJVh5ghVkiFQd0Y84UEnIxEqx3fs+mXvky5pkvfm0X88
         dT6OK/cH73/PADww+xN2k4uE1SKTpBSZ0FYlC+VwN3b/CVwGDIY1NDfOcrsHbkAeMq3M
         HGf1wMJd+UOAzrfPULeP8jbG6FVsmJVHaooEIiubYoNAS1QFqYK/Yyme4gznEXI29YTj
         ZGSlfq1sxCaNMDPTHvo/+oJ80ltaeRMAaZ8NWeriXcAkGnhrc0I3u4MY15Y+go777AtA
         PKWyyNF6LqTc5/e/37km3QHyoP87WNtF7roZ6rKwWCNwrfjoDCxDeM7s08P/6cEzKwZu
         iqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NgIDHjQKUojjaf2BsBD1jb2aasHj4rIZ+iMDkrtmFX0=;
        b=oYwofxCzZxWVpm7b5kLQreIAQX9LrMah5TbnmoxXzxDZfl9Rfca80OVjMUu0ufTbCl
         XgAjFDzLcdrYbkNyC5m5craCFZ24OBJl71iIROqJxRARKQitBU46RxuEftXyuUWfJ1BY
         A7sJeEEKk8Ls7pfX6Gy8Yg+JJPPISyTlyYsmdCsUhGkaFJx3hMlAktyH5DUntjrwDEbJ
         EAWfik0BjQBYXd49Whsr1zBuas5p4PQVY3xodN0vro5ClSPIEIhY0/VmWtbOVuK9iwVe
         aZIKL/yCzLFJkILK0QqrWPBYymdPFCLeZWm41urJD08YQg4Z67UtpGCeythmuIv0N+fy
         3DDA==
X-Gm-Message-State: AElRT7F3DwS5jZFjeWoXVoIYe+Ki1yBYF72usHhdmYABfz/gB3d8Oefk
        1AxPzGnw9uWYb/NWEa8uBF0nuU/Z
X-Google-Smtp-Source: AG47ELsf3ze1/NPQBuE6Q0Yhkq4TjYWRI0QDVJa+4tYlx6IbHt/W6JbpVLBJVXiiaHKC2i9gtmKGdg==
X-Received: by 10.28.10.134 with SMTP id 128mr16359052wmk.136.1520501137468;
        Thu, 08 Mar 2018 01:25:37 -0800 (PST)
Received: from evledraar ([84.88.84.116])
        by smtp.gmail.com with ESMTPSA id 140sm1083088wmy.38.2018.03.08.01.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 01:25:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: Re: How to use filter-branch with --state-branch?
References: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
Date:   Thu, 08 Mar 2018 10:25:35 +0100
Message-ID: <87zi3inckw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 06 2018, Michele Locati jotted:

> Recent versions of git filter-branch command introduced the --state-branch
> option.
> BTW I can't find any info about how this can be actually used.
>
> We have this repository on github:
> https://github.com/concrete5/concrete5
>
> When someone pushes to that repo, we clone it and execute
> `git filter-branch --subdirectory-filter concrete`
> to extract the concrete directory, and we push the result to
> https://github.com/concrete5/concrete5-core
> (including all the branches and tags)
>
> The script at the moment is this one:
> https://github.com/concrete5/core_splitter/blob/70879e676b95160f7fc5d0ffc22b8f7420b0580b/bin/splitcore
>
> I tried to use the --state-branch option on a local mirror, so that we could
> do an incremental filtering. Here's the script:
>
> # Executed just one time
> git clone --no-checkout --mirror \
>    https://github.com/concrete5/concrete5.git work
> cd work
> git filter-branch \
>    --subdirectory-filter concrete \
>    --tag-name-filter cat \
>    --prune-empty \
>    --state-branch FILTERBRANCH_STATE \
>    -- --all
> # Executed every time the repo is updated
> git remote update --prune
> git filter-branch \
>    --subdirectory-filter concrete \
>    --tag-name-filter cat \
>    --prune-empty \
>    --state-branch FILTERBRANCH_STATE \
>    -- --all
>
> The first filter-branch call required 7168 steps, so did the second call...
> I also tried without the --prune option of remote update (I had to add
> --force to the second filter-branch), but nothing changed.

CC-ing the author of that feature. Usually I'd just look at how the
tests for it work to answer your question, but I see this new feature
made it in recently with no tests for it, which doesn't make me very
happy :(
