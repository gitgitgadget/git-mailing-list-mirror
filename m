Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3987C1F406
	for <e@80x24.org>; Tue, 16 Jan 2018 00:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeAPAi5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 19:38:57 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43434 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeAPAi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 19:38:56 -0500
Received: by mail-wr0-f195.google.com with SMTP id s13so13501922wra.10
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 16:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pJ0/SMwXlVt6racDWq0V3OoU6h63aCzq1sQ5zJbTE6w=;
        b=XSJM3GJZh96iQEwCNSydavNIAFhuUZxhlSfg90kSEzDuaZdoGSTJ8RKRcgX5YibhzG
         kU+WCRO//3EU/oaPm1NEIQWkC4XdlA2cJo4fJcJlUM4QGIXoCFKSXyqk0uxf6S7HTMbt
         RnHU96ZNGIWQGMKXx+xWgDdg/Zb6P9auoclD6cPCkFnFy8oCacnWdXcQWbR5pafaIzAd
         bwOWYx7+06WQwxxDPXDXb6bKIugcy6FCkh4CfZz/YgNaVXGGrPFtQXjNEnQNyUEn3Vg3
         ZvfV8Z3jK6yUQ9c4aNm26ykYUKaqh+4q67WJ/bI8M6u+aDzJ8jDjKTAPNgASl3pQ5BKY
         vkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pJ0/SMwXlVt6racDWq0V3OoU6h63aCzq1sQ5zJbTE6w=;
        b=ADN71Ypw6v/G7Hc1Jwv6IMQeTwRjNrSd4uMFOFsyAyl9RYpIWykmPRfqLwetVKfflK
         OHJCbRMP3VcQ+TbFMwDQBIZVR+wy6hg9dhLNYZqHESwuh3Qk+8pK+aPVpgIgHCEIh8Eb
         7rsy1kJCXRyPO0bpans3UIXPthiHnRhSELQmg6tBD5ABr5ozHMdyhAmlLNfpXz1i2FZn
         3xjaW936L1LrH/c7mCfFTKVIg+8rXSodpsxZjZR/D1iv7vT0qG4HN14mHoPcgOPxhzNQ
         6hzvZxdEmPnrKSUBI7BIgcjkI5jDuBTiwjjTRfarz6lCuPHTHnz1fKvGJZeroE4kD+5U
         /58Q==
X-Gm-Message-State: AKwxytexd13qJSVyrwdhPzOG/d5NRE1rT7PJoUpMCCM7eSJaUkY7WRdP
        1VFyZxL8p7S6wljy15n28Pbwx26j
X-Google-Smtp-Source: ACJfBouXujfcs0S6tDlB/pA7ivAcumbuw1Q2LZVbruS5ObNENsjNThI5GdulSciGZY/piwgWzksYpg==
X-Received: by 10.223.172.6 with SMTP id v6mr1074450wrc.269.1516063135262;
        Mon, 15 Jan 2018 16:38:55 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id l72sm1591823wmi.4.2018.01.15.16.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jan 2018 16:38:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Giuffrida <michaelpg@chromium.org>
Cc:     git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
Subject: Re: [BUG] git remote prune removes local tags, depending on fetch config
References: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com>
Date:   Tue, 16 Jan 2018 01:38:52 +0100
Message-ID: <87tvvmiqn7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 15 2018, Michael Giuffrida jotted:

> `git remote prune <name>` should "delete all stale remote-tracking
> branches under <name>". I was surprised to discover, after some
> troubleshooting, that it also deletes *all* local tags that don't
> exist on the remote, if the following refspec is included in the
> remote's fetch config:
>
>     +refs/tags/*:refs/tags/*
>
> So, if `remote.origin.fetch` is configured to fetch all tags from the
> remote, any tags I create locally will be deleted when running `git
> remote prune origin`. This is not intuitive [1], nor is is it
> explained in the docs [2]. Is this behavior obvious to someone with a
> better understanding of Git internals?
>
> I did find a better way to automatically fetch tags (using tagopt
> instead of adding the fetch refspec). However, the refspec doesn't
> seem "wrong" in itself; in particular, `git fetch --tags` used to be
> considered equivalent to specifying the refspec
> "refs/tags/*:refs/tags/*" -- implying that this is a sensible refspec
> [3]. So I wouldn't expect it to "break" the behavior of another
> command.
>
> [1] https://stackoverflow.com/q/34687657/1327867
> [2] https://git-scm.com/docs/git-remote.html#git-remote-empruneem
> [3] https://github.com/git/git/commit/c5a84e92a2fe9e8748e32341c344d7a6c0f52a50

These docs are really confusing, but it is working as intended, and
really should be re-documented.

The `git remote prune` subcommand just ends up piggy-backing on
git-fetch, whose behavior is explained here:
https://git-scm.com/docs/git-fetch.html#git-fetch---prune

It's worked this way since at least v1.8.5.6, maybe at some distant
point in the past it only did this for branches when invoked via
git-remote as the documentation says.

RELATED:

I've actually had the reverse problem with this. I want some way to turn
this behavior on without explicitly hacking the refspec, so I can do it
globally in /etc/gitconfig or in ~/.gitconfig without screwing with the
config of each checkout on certain machines.

You can set fetch.prune=true, but that only prunes the branches, you
need to inject remote.origin.fetch into each checkout, unless I've
missed some way of doing this.

I wanted to add fetch.pruneTags that would make it as if you had
refs/tags/*:refs/tags/* in the fetch spec, but I haven't hacked that up
yet, if anyone can see any inherent issue with that plan I'd like to
know about it.
