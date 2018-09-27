Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6544A1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeI1CWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:22:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45540 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1CWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 22:22:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so4689609eds.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lrHbnHZ83eAWq++3ov+xBdJXogRjTRZIme+IIbjNLRg=;
        b=oQBQfZlUzY2B7JEXDeou+XVj/3vpakLUGjBNebbKYpGfoeg/HBrRFceod7r9/R9+NH
         lP29Mti5mukGdj+v4gI59KvwIoGCyTMNazi5a2NgbljaE5gTDhno+OCzwq6GpGUD/M/1
         q06e8Oajq4ZJ4vcpMK0boowOdp1tNw9m+yauncQLpXu/nEbFpgIib/dWQDBoPFbMgoLL
         HhlxQPq9Q8WNQkhPjiWpJcyHmgJZWE0QyaHk7ten44OevYdUAiZp1vnJlX8LjT6bzkLN
         vdzqHQ77plq40+R6nQMk6lobLUB2604KVJquNWksbpl6Y7jZ2RolrHlshdkboS7/DKh6
         19oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lrHbnHZ83eAWq++3ov+xBdJXogRjTRZIme+IIbjNLRg=;
        b=eHysMBv1aq1NZlFyUGUMvweC7Qs8jF1ENaq/il+L5KY0mk7gQf5LnmRXA2CTWB4pJe
         0n8Aco69OUTPkiNuAq5gyDPysLGwKK6lmmnoyGQKn30XUCzA3wSb9q06/92IaLUMDWiI
         2qy1OxrsyxnVzLgny/uIoINRQY/r13+xUF91vw9Wp8kw+ZiJnMWYLy2Jb/JzUieLFze8
         bAofBqhsLwoGCAwkt6IpCUNGtVwRtjrNVD8LL39D+wbguV2/YLGxI8n1jSqIMb9Z982e
         1lkZKgJXAwomV9IDAD2Ual5ULcsiNKKXnAzB0oaUgKK6OVBbVsffESisKHcQL8/2CbHD
         VINg==
X-Gm-Message-State: ABuFfojzNjDpe8nMGlVcMdao0MVt4dr4MxSKzwfKyM6gEBoUcxbM0rRc
        6Wf2MkH0m6DbTVj2+I8MLMlRsuQ1T3c=
X-Google-Smtp-Source: ACcGV63znHdc4H7glXatQqUDdG8Mr/AySCNGcttFwgdWYWgBNXyo95awzfkuMwyk59FrPcRJSmRt3w==
X-Received: by 2002:a50:a207:: with SMTP id 7-v6mr19456864edl.48.1538078572799;
        Thu, 27 Sep 2018 13:02:52 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id k5-v6sm263403eja.44.2018.09.27.13.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:02:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Nickolai Belakovski <nbelakovski@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working tree the same way as the current branch is colorized
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com> <20180927181708.GA2468@sigill.intra.peff.net> <20180927192804.GA27163@rigel>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927192804.GA27163@rigel>
Date:   Thu, 27 Sep 2018 22:02:51 +0200
Message-ID: <87pnwyiu8k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Rafael Ascensão wrote:

> On Thu, Sep 27, 2018 at 02:17:08PM -0400, Jeff King wrote:
>> Do we want to limit this to git-branch, though? Ideally any output you
>> get from git-branch could be replicated with for-each-ref (or with
>> a custom "branch --format").
>>
>> I.e., could we have a format in ref-filter that matches HEAD, but
>> returns a distinct symbol for a worktree HEAD? That would allow a few
>> things:
>
> I was going to suggest using dim green and green for elsewhere and here
> respectively, in a similar way how range-diff uses it to show different
> versions of the same diff.

It would be really useful to (just via E-Mail to start) itemize the
colors we use in various places and what they mean.

E.g. I thought green here made sense because in "diff" we show the
old/new as red/green, so the branch you're on is "new" in the same
sense, i.e. it's what your current state is.

But maybe there's cases where that doesn't "rhyme" as it were.
