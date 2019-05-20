Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEB21F461
	for <e@80x24.org>; Mon, 20 May 2019 13:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbfETNyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 09:54:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53794 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbfETNyE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 09:54:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so13406040wme.3
        for <git@vger.kernel.org>; Mon, 20 May 2019 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DBk/HUcfv6HHy9rBRSWOA+fxXH3JAjrPlLW3zJ/GgJY=;
        b=ucUQVxNp+xb5GsDrPIpQwAOz32bFwD7ICUIkwTP3mz8RAKVA/1PnPdX3XS1HceE2Jv
         Nr2gkXqoIJu6yTchVES/m2riLkLDjYSMy1WFAW5QnekTKEo61T1OwfYp2KAXxaf0Bq66
         lyPGf4rTV2hrgggYbnc2lAk0Hh645wWDArW2UIGcgQjJ5wPLRYFp4Qy5ez5GKwIQtveg
         YbvGGrxrSonN/uiqYEEbOiMZYLTD5fEoFJ77aymLKk7bxOvA2IIf8E+HH9nA51/yLYCf
         OknTylgrf02ipJVWnU56Z4YPOb+RQWaZHNLjTgUPXUy8zenoQuh1QK9GhQNhAZFrkLUs
         PNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=DBk/HUcfv6HHy9rBRSWOA+fxXH3JAjrPlLW3zJ/GgJY=;
        b=EsqykP+jpaNY1lJiB3V3a7XMcFcKjB/jlgiaJ/y55n7er2ObSLbYpqc7suZauYoPdr
         czfKo0PRuXC/ZsGJFbPOVbvZt7EielyxtfrYaJV/IHwP4Lv8AI5MbYcob1n9+vRmEZx/
         3k5qmXClXy0nAzfTfGN//7CZH8IFKXtn5YraTO9K81DC7ucKtyQVm3fkU85xoRxZ3t/E
         ARUG+yxO0528HXPJ7jEubTJ8q9h6JhiPp8q3gfehC9V3IumBvF2HZeaphtoVN5d3Ga3R
         uxChpx1BWzW6vRDEcqNnrrK0tSty0Uew7aQ7O7f8Ch9qgEFHzu3seqobffpm1Ygvugv/
         TXMQ==
X-Gm-Message-State: APjAAAW41V62a1NvexKvn4XDv+p1e4DE81ugF4Kd8A0tjHowmWNA5VpG
        RoLqm4IvUbk8zhjfNGuy2BJ0fT7yuIc=
X-Google-Smtp-Source: APXvYqzZKolZht+SzxWMuqS3Sz+JN91D+y654vlFgM4TS8Ng4EMCESE5uHoeltSb5KyzaiwK2wfCcQ==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr41975351wmf.16.1558360442627;
        Mon, 20 May 2019 06:54:02 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egp40.neoplus.adsl.tpnet.pl. [83.21.79.40])
        by smtp.gmail.com with ESMTPSA id o11sm5456993wrp.23.2019.05.20.06.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:54:01 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
        <874l5vwxhw.fsf@evledraar.gmail.com>
        <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
Date:   Mon, 20 May 2019 15:54:00 +0200
In-Reply-To: <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 15 May 2019 13:33:57 -0700")
Message-ID: <86a7fhp6yv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> On Wed, May 15, 2019 at 8:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Wed, May 15 2019, Piotr Krukowiecki wrote:
>>>
>>> I'm migrating two repositories from svn. I already did svn->git
>>> migration (git-svn clone) and now have two git repositories.
>>>
>>> I would like to merge them into 1 git repository, but to merge also
>>> history - branches and tags.
>>>
>>> The reason is that the svn repositories in fact represent one
>>> "project" - you had to download both of then, they are not useful
>>> separately. Tags were applied to both repositories, also list of
>>> branches is almost identical for both.
>>>
>>> So right now I have:
>>>
>>>     - projectA:
>>>        master: r1, r4, r5, r7
>>>        branch1: r10, r11, r13
>>>     - projectB:
>>>        master: r2, r3, r6
>>>        branch1: r12, r14
>>>
>>> The content of projectA and projectB is different (let's say projectA
>>> is in subfolder A and projectB is in subfolder B). So revisions on
>>> projectA branches have only A folder, and revisions on projectB
>>> branches have only B folder.
>>>
>>> But I would like to have:
>>>
>>>     - projectAB:
>>>        master: r1', r2', r3', r4', r5', r6', r7'
>>>        branch1: r10', r11', r12', r13', r14'
>>>
>>> Where all revisions have content from both projects. For example, the
>>> r5' should have the "A" folder content the same as r5, but also should
>>> have "B" folder content the same as in r3 (because r3 was the last
>>> commit to projectB (date-wise) before commit r5 to projectA).
>>>
>>> There's additional difficulty of handling merges...
>>>
>>>>
>>> Any suggestions on what's the best way to do it?
>>>
>>>
>>> Currently I'm testing join-git-repos.py script
>>> (https://github.com/mbitsnbites/git-tools/blob/master/join-git-repos.py)
>>> but it's slow, memory inefficient and handles "master" branch only...
>>
>> You might be able to use https://github.com/newren/git-filter-repo
[...]

> Somewhat interestingly, a search on others having tried to solve this
> same problem turned up
> https://github.com/j5int/jbosstools-gitmigration, which apparently is
> based on git_fast_filter, which is the predecessor of filter-repo.
> Perhaps that tool would be useful to you as-is, though they apparently
> do ignore merges.

There is also reposurgeon tool; though its main purported purpose is to
aid migrating from one version control system to another, it can also be
used to edit repositories (utilizing fast-import stream).

  https://gitlab.com/esr/reposurgeon
  http://www.catb.org/~esr/reposurgeon/

Hope that helps,
--
Jakub Nar=C4=99bski
