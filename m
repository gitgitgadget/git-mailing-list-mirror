Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC991F454
	for <e@80x24.org>; Sun, 10 Nov 2019 06:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfKJGon (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 01:44:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42959 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfKJGon (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 01:44:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so10389005ljc.9
        for <git@vger.kernel.org>; Sat, 09 Nov 2019 22:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BfCqDRVDM3q5gK71HPq3lvkaSqxwHZ6/JMuWNWNmqv0=;
        b=iaDSHY/BpNg8TOCEJvRnnb5vTbTIoeL6IM89Rg0N4B1JfgxJYcgDO7oWJMitAkUJgv
         BsJjno4043h93H9xwcXAi4eCsDR6fMfJMy5zhmIbMkfu8wvMQEDKZss4hrKV0VtVxipW
         gpEiW5IfX8kyTgfg6nkd2I+RtMq5BznQ/eIbWcozhbMkTEcytX0brigvV5BOPJ73zuCU
         S1jyv7j7bPvsd0zlbYkV/PNRgof+PfXzjoNo1VzCWIYY5VoJgkyWOXYEzf0jUFgYKA8M
         qqWioiq65CVKrjXpG/gUL63uztwVBmuFhw5kp203tRqMKgVi8eqZ3oypmh+1qAwSBD8h
         mxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BfCqDRVDM3q5gK71HPq3lvkaSqxwHZ6/JMuWNWNmqv0=;
        b=Oa8T+H7Z38o1jDIBs95XYM5czVm6uSK4fc/A70GfTkF22iYg8RXf6eckJrP2Qgbc4l
         DPKaDK1ocTjj85fet0g8QZPHsy5E2XyX0sLxxln1Qh1FdT7QuUS041vscmyCPUz7QNXY
         eyyMMU4if3A0tW1mexrGM34ufVECKX03+O7iJS0Ds+6SMfyvyO3IiNLO2Wah5gO4q/yI
         efJTyWyc6DWKTgTk2zgjtatvP0zwl7YfkE9HDgLRX/n0oSKIC3iT5je0e7ikZlAtBPcP
         nGcySfxj4i1XQ05lPgCM0i1jQI+6n831dbLYaXrLKCpUN6fnZb+12+OGoWG0wJvaud9V
         numw==
X-Gm-Message-State: APjAAAWEmK7LBnpLXsVGbv76BvMkghw4vslooEflKBHQ1jhN2ayUR1Uu
        70hDDrKmbIp98t6OyGolWbyQ6ttrsak1EGBfZNUIk4wCqZM=
X-Google-Smtp-Source: APXvYqyFyrBBmafos+6q/Alu1LVlykxPz+glmeEXdYCf1qdvzAPj3N+oWnpnR67dFoLmtMTPjjnSaf8ETWBlZ92BOXE=
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr11994820lji.64.1573368280960;
 Sat, 09 Nov 2019 22:44:40 -0800 (PST)
MIME-Version: 1.0
From:   Avery Pennarun <apenwarr@gmail.com>
Date:   Sun, 10 Nov 2019 01:44:30 -0500
Message-ID: <CAHqTa-15fKjH-3Z-vHhgNpfx6c1OQXbDXwKJHT9JX6G+7tjGBA@mail.gmail.com>
Subject: Announcement: git-subtrac (a sequel to git-subtree)
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Ten years ago (yikes!), I wrote git-subtree to work around some of
the usability problems with git submodules. I don't have much more
luck with submodules now than I did back then, but I've also never
been very happy with git-subtree's limitations. Luckily I've learned
a lot since then, so I've made another try at it.

Here's my new attempt, git-subtrac:
   https://github.com/apenwarr/git-subtrac

Unlike git-subtree, it encourages you to use an almost-pure git
submodule workflow. But like git-subtree, it makes it easy to include
the entire history (actually the "history of histories" since
submodules can go backwards, forwards, and sideways over time) of
the submodules in your superproject's repo.

As a result, it's easy to push, pull, fork, merge, and rebase your
entire project no matter how many submodules you like to use. When
someone does a 'fetch' of your superproject repo, they get all the
submodule repos as well.

The trick is pretty straightforward. Like git-subtree, we generate a
shadow history of commits, converting subtree links from inside trees into
additional parent commits. This causes them to be pushed/pulled as
part of a single ref. The shadow history is stable (anyone generating a
shadow tree from commit X will always get the same shadow tree X+)
and can be forked or merged just like the original tree. The idea is
that you'd have a branch called 'master.trac' that is the companion
to the 'master' branch, holding the submodule history needed to
checkout any commit in that branch.

Then you simply set "url = ." for every entry in .gitmodules, and off
it goes.

You could also use this as a tool for managing patch queues: create a
superproject with just one submodule that you want to patch. Every
time you rebase your patch queue, make a new commit in the
superproject, then tie it into a nice package with subtrac.

Anyway, comments welcome. This one is written in go using the go-git
library, which is very nice indeed, although it would presumably
prevent this from ever being merged into git itself.

Have fun,

Avery
