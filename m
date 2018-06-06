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
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A181F403
	for <e@80x24.org>; Wed,  6 Jun 2018 22:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeFFWuW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 18:50:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40854 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeFFWuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 18:50:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so14956063wmc.5
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GMTiyYu+y4h02ZsgmVi/fJ+61hcsIu2HIkr/s+0Eb7g=;
        b=Wxr6tuYJZT8OVbcMoNCgLuoo2TD0RIk+3EXEGwNlpEWcMaKJA9GM2aIP8diUPLzcLA
         jwe/LUPBZqsb9yNxaDrzWhkbLNoexViW5p05GbbiC3meybIyCDIyKpOmkUdyYvLS39eK
         lFZYHtBPx7LmDDJa8/NevI96nEP+Y/qwKhHn0gD9qiUsj3tO7S14BTk/Wen19bUeswmM
         KIzAv2AKf8cuRJyxtICkTPteLHWhAELU09nLaHncSn16gVEcpiAZ2BSqvwl1J52ed/v9
         pxDHoyftZlTYgL0G4XAz+tvFpq3hax4zoOlHiuPS4GxPwVIGIChJaJX6ht5uwwciktKe
         1UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GMTiyYu+y4h02ZsgmVi/fJ+61hcsIu2HIkr/s+0Eb7g=;
        b=p2flB6gkSPRAdt0zfo+qEjy8QR3+VOfg4YorvF9VAU/6bK8NmwDxjiGC4vtwvFQD1i
         sryvHye2ElSKyt4QH7HnYkTyHTHsR593oineILU8pHrDgW2h4iJx9NGecWYREBj0nJSG
         8iTKTJUOMqjMmAFKE/NS9La4hZ3MY90OcfaNhj+WJcUf4gG72rp7WHorP9TlEXu6/HY1
         vLA/iwxGlbLcc0rtoQ+AGNPyS6zsC8CJTwEIhVjFgiaDURyBtIXI+/dWSRGfDub9cSZi
         U+/fGFJwt5OZi9s7XtYkaHapJzsdvw+13KqDFK33oyVRMwEqWoZv4xNtZZR2jOr/WKtb
         BoqA==
X-Gm-Message-State: APt69E1HjXTA6VLtzRsZAQLkeadOsKm7AwLBbgfRzDEC/E68kyofNPVk
        hVYX5qIGFukI0tpeyYQsXAI=
X-Google-Smtp-Source: ADUXVKL5W3BMx+/qtQdVvdSJ275Au2tqfhXtrGVIkW9YGgesnrZpvGCLi68q/TD0KLnp/OCxWSaMMA==
X-Received: by 2002:a50:9772:: with SMTP id d47-v6mr5819752edb.174.1528325420619;
        Wed, 06 Jun 2018 15:50:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f2-v6sm3687417edi.70.2018.06.06.15.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 15:50:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Fischer <thomasfischer@fastmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
Subject: Re: git rm bug
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
        <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
        <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
Date:   Thu, 07 Jun 2018 00:50:18 +0200
Message-ID: <87bmcnzg0l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 06 2018, Thomas Fischer wrote:

> I agree that the entire chain of empty directories should not be
> tracked, as git tracks content, not files.
>
> However, when I run 'rm path/to/some/file', I expect path/to/some/ to
> still exist.
>
> Similarly, when I run 'git rm path/to/some/file', I expect
> path/to/some/ to exist, *albeit untracked*.
>
> I do NOT expect git to *track* empty directories. But I also do NOT
> expect it to remove untracked directories.

Others have said why, but here's an edge case you probably haven't
thought of:

    (
        rm -rf /tmp/repo &&
        git init /tmp/repo &&
        cd /tmp/repo &&
        mkdir -p foo/bar/baz &&
        git status
    )

If you just have empty directories "git status" will report nothing,
although "git clean -dxfn" will show what would be cleaned up.

So if this worked as you're suggesting then someone could 'git rm" some
file, then everything would report that they're on commit XYZ, but if
they re-cloned at that commit they'd get a tree that would look
different.

No git command should behave in such a way as to leave the tree in a
state when moving from commit X->Y that you wouldn't get the same Y if
you re-cloned.
