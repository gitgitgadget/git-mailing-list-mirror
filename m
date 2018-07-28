Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704881F597
	for <e@80x24.org>; Sat, 28 Jul 2018 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeG1PgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 11:36:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37604 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbeG1PgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 11:36:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so8626807wmc.2
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/DGrjkaZOuL2qoWjcZVg2ORtB6KKPdvae8wK9hG8Z68=;
        b=GKQ/BZRZborLsto7LTr10LA6nqBR6ryxICMluvBkP+QZwUkZ/8Vh1TNpi4UXJPHH0M
         +c4MGCO2zxjfjCR3Bi40HmwxHI3pTlrMrs51WwxIo9DNbJvQUciMu9+C5a5GGVVwIp5n
         NE06sl4VdKW4PSjBLaMfn387yudIiIxtQTc4+RHyNDFAOXJU2VASBFiy84y9lpiEFvPc
         JSkVGl/dP99uiaRW+O27MGHpS2i8OKe+UQOnltKCYOgHF6sH5BBHOhtx3qVN7zvY9P7d
         Is5laicIDnJf1HLisqreRr1GwH+ul44qid9BhcWS2P9FrOaegLyzt0mb+8v1XWpMplNM
         i8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/DGrjkaZOuL2qoWjcZVg2ORtB6KKPdvae8wK9hG8Z68=;
        b=MZuFKhqX9R2PUKOVEmjCV/blde19uXgOqfpbEdSdVW/ff9ShxqhN2iPWVFcHqDmi9h
         7jJ+NriFrI4urHRay/NL8DZpYFb4Ns2+t5riI7ujz7jaeX1O4zi+Tisc58xQwSh5H/Ec
         7/ZRkh+WvQ9DOPHg0Aj8lLajIBUPhRTKZLGEpOHkMmH6JzyW3mrVBsXYpp7okl0nmgKU
         x+gFEWM2TZBULPKsS2WvhkYcfDM/52BJniI6HAnmDa5sZ5T2h+rNHoE5uUoG3K9PzW+W
         ArQ29NPlF5WxUwWfg5tfnCWedDVyG9MoJX3TkqINR0YyInooWz7v6BdmxVdHD70bX78y
         5mZg==
X-Gm-Message-State: AOUpUlGTIVKS3C7dVyvCdFoxepl+Hqr+IoSX/Fz7nUXpVCeY91HWaO+A
        hyThE0pPGn552eldau9nwKo=
X-Google-Smtp-Source: AAOMgpd+Hk6W9tU1/1wQNKQTAITBlik0GmdGtXVS6/AF12tcKQ4QIUClkmbUnQqDkl459O2TKU03aQ==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr8659740wmg.50.1532786985581;
        Sat, 28 Jul 2018 07:09:45 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id m200-v6sm8127323wma.32.2018.07.28.07.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 07:09:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 05/10] config doc: elaborate on fetch.fsckObjects security
References: <20180525192811.25680-1-avarab@gmail.com> <20180727143720.14948-6-avarab@gmail.com> <xmqqeffomphy.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqeffomphy.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 28 Jul 2018 16:09:43 +0200
Message-ID: <871sbnv4d4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 27 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +For now, the paranoid need to find some way to emulate the quarantine
>> +environment if they'd like the same protection as "push". E.g. in the
>
> We probably should mention that you can immediately prune, as these
> unwanted crufts are unreferenced.  That would probably be a lot easier
> workaround for the intended readers of this document than "find some
> way to emulate".

I'll mention that as well in v6 that "git prune" will get rid of these
objects.

For what it's worth I was imagining something like a system where you're
mirroring every push to some unpatched-git-host.com repo in-house, by
doing a local "git fetch" when you see new data, and you're paranoid
that someone's trying to introduce something like the .gitmodules
security issue to your local mirror, even if you have
transfer.fsckObjects set.

In a case like that, relying on "git prune" is much more fragile. You'd
need to implement your mirror as some loop that does (pseudocode):

    while ref = poll_new_refs()
        git fetch upstream
        git prune --expire=now

As opposed to:

    while ref = poll_new_refs()
        (git fetch upstream && git prune --expire=now) &

As you might find in some event-based system. I.e. every time you fetch
you need to stop the world and run a full prune, because the potentially
malicious upstream can craft a series of ref updates where one ref
update (which you'll refuse) contains the bad data, but at that point
you have some of those blobs/trees/commits it in your object store, and
then a second ref update references that already existing data and
causes you to update the ref.

It's also much slower and I/O heavy, on an already-pruned linux.git
running 'git prune --expire=now' takes 40 seconds on my machine, as
opposed to:

    while ref = poll_new_refs()
        (git fetch && git push internal-mirror --mirror) &

Which could take as little time as a second for the whole operation, can
safely be run in parallel, and would be protected because the actually
published internal mirror gets its refs via receive-pack, which uses the
quarantine.
