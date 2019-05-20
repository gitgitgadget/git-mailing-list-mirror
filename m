Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5381F462
	for <e@80x24.org>; Mon, 20 May 2019 17:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403920AbfETRIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 13:08:40 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36780 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390373AbfETRIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 13:08:38 -0400
Received: by mail-ed1-f47.google.com with SMTP id a8so24960381edx.3
        for <git@vger.kernel.org>; Mon, 20 May 2019 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gQrz5qb/lxNmIivt6yUkQzscmYF5risgbJvdHlmBLbQ=;
        b=IaP+R1x1YXl7xxna4nQ8KAwSBtZdbcC6XdtXEvegAzvHPJY1zsEdKKbvoYoIpG6xXy
         hspY9j7TRz58tjaYmG+iVjod+M9NI0BScElaMddMzdyFoYXqGNifMEL4A2/7QwX1W4gr
         94mkyU4ALHJFAuY+hBjeaFm/7PZwoVXbzgx4Bw1xw7hSeJNiHqLKVtteYlbF6aghsNiC
         vT6/Zx3s0sp4ztzMuvJvHkiTGR36VHXbkQAUFRHtJqRez34Wf4TJwTcZepEeVweFB9lT
         rjhMiZ9qRnzhn6bEDb+MFPnVvznzY/5L7816zkY8qattfwXCcZiMsfkM9JDhFBeWR3qz
         TJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gQrz5qb/lxNmIivt6yUkQzscmYF5risgbJvdHlmBLbQ=;
        b=jzrI4pxaMveHufv9uc2O5lRKlUKmoRUiKa5sP3f+I28t5S0bBQ59AYjUJou3nmFrfl
         U2RdbI6wZDMGfnP2lwvQqIu0NlLepSWP0raiEYIuNTEqb7qC9s5BGK/tJGgfwmVkDihf
         VcM8sm+wdU/LFX9rdAmmCBq1MVZKprzuEsZBRJPdKSqRVZLsL91RzNy1OiU2V50qb7Py
         DFD38X7OBjxDmOqiOwmyuSv3ScxTn87mQMN9v0IdEF8n8I69XMUGHBfmhSjeudVTSIbf
         Gf31DSWa6fqFLL+iIUht/4wIQQbVnAHBO+lU/FyJrd3cLNqRXgUSaCITzle8JA0Dvx04
         0qiw==
X-Gm-Message-State: APjAAAUX9nRelaLuqYtjK4ck3HhyHQJDrktPxLZ+BLJAwebfryWydc+x
        WrJpyGLJ6+RhQRMYboL3knw=
X-Google-Smtp-Source: APXvYqyQtOzYUIEytmj+tpXUJ64FeQW6zpn54CaPiE4CnYW3TiaT/K4Kq0SzFz83lM6XCLvfisB3Xw==
X-Received: by 2002:aa7:d711:: with SMTP id t17mr77037229edq.80.1558372116408;
        Mon, 20 May 2019 10:08:36 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id ay6sm3222661ejb.20.2019.05.20.10.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:08:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when necessary
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051604.GC19434@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190519051604.GC19434@sigill.intra.peff.net>
Date:   Mon, 20 May 2019 19:08:34 +0200
Message-ID: <87ftp9uk8d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 19 2019, Jeff King wrote:

> If the user clones with a URL containing a password and has no
> credential helper configured, we're stuck. We don't want to write the
> password into .git/config because that risks accidentally disclosing it.
> But if we don't record it somewhere, subsequent fetches will fail unless
> the user is there to input the password.
>
> The best advice we can give the user is to set up a credential helper.
> But we can actually go a step further and enable the "store" helper for
> them. This still records the password in plaintext, but:
>
>   1. It's not inside the repo directory, which makes it slightly less
>      likely to be disclosed.
>
>   2. The permissions on the storage file are tighter than what would be
>      on .git/config.
>
> So this is generally a security win over the old behavior of writing it
> into .git/config. And it's a usability win over the more recent behavior
> of just forgetting the password entirely.
>
> The biggest downside is that it's a bit magical from the user's
> perspective, because now the password is off in some other file (usually
> ~/.git-credentials, but sometimes in $XDG_CONFIG_HOME). Which
> complicates things if they want to purge the repo and password, for
> example, because now they can't just delete the repository directory.
>
> The file location is documented, though, and we point people to the
> documentation. So perhaps it will be enough (and better still, may lead
> to them configuring a more secure helper).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If we do decide this is too magical, I think the best alternate path is
> to advise them on credential helpers, and how to seed the password into
> the helper (basically configure the helper and then "git fetch"
> should work).
>
> One other thing I wondered: if they do have a helper configured this
> patch will omit the advice entirely, but we'll still print the warning.
> Is that useful (to remind them that passwords in URLs are a bad thing),
> or is it just annoying?

A few things, in no particular order, sorry for the braindump. Please
don't take this as "this all sucks" just trying to help by poking holes
in it.

 1. I'm a bit uneasy about us acting on an incident where the details of
    what happened / frequency haven't been released. I.e. GitHub
    supposedly has ~100 million repos, one source claims on the order of
    ~300 of these (public)[1], none of the sites said anything on that,
    that 300 number is third-party speculation.

    Let's say it's 100x that counting private repos. That's still a very
    small percentage of 100 million.

    But more importantly, it doesn't give us any insight on how to
    perhaps better solve this problem, e.g. maybe 80% of it is people
    using some build system (docker?) where we'd expose /home too. Not
    saying it is, just that we basically have a partial bug report here.

    I don't have a good sense for what the state is there. Is this all
    repos cloned in /var/www, then this is sufficient, or something
    else?

 2. We're now making the trade-off of auto-storing the password in ~/,
    is that a worse default now in the wild? We're defaulting to storing
    for a longer time (e.g. on a shared *nix server) in workflows where
    you'd clone && rm -rf.

    So yeah, we might handle this *specific* incident, but are we just
    making it worse for others?

 3. There's seemingly no way to just say "I want it the old way, make it
    so!" without creating an auth helper that does that.

    Storing passwords in config isn't per-se insecure, neither is having
    passwords in (https) URLs. Yeah in combination with *other* stuff
    the might be insecure, but often not (but may actually become
    insecure by auto-storing in ~/)

 4. Re #3: We have existing users in the wild who do this, e.g. GitLab
    CI, the user/password token (lives for about an hour IIRC) is stored
    in .gitconfig, there's no writable /home there IIRC (or might not be
    in similar CI environments), and I daresay the people who set that
    up understand the security trade-offs.

 5. Given #2 && #3 && #4 I'd be much more comfortable with something
    where we just make this fail outright, and force the user to eitiher
    say "Yeah I want passwords in .git/config here" or "oh thanks, I'll
    use a credential helper" via some core.* or credentials.* config.

    I.e. let's not make #3 impossible, and for users who are clueless
    about security we're doing them a disservice by auto-using a crappy
    fallback ~/ helper, whereas they might have an *actual* helper they
    can use that doesn't suck (i.e. OS pwd store) if it was an error.

 6. We'll still happily let this new behavior pass by on init && config
    fetch. Should we care? I was going to say this categorically breaks
    core.sharedRepository=group with a password in the repo, it does in
    the 'git -c core.sharedRepository=group clone' case, but you can
    manually set it up still, you just can't use "clone" anymore.

 7. We still accept passwords on the command-line for cloning, so if
    we're trying to help novice users we're still open to the shared
    server attack where someone just runs "ps auxf" in a loop to scrape
    passwords.

    To me this is another good argument for some variant of #3. We could
    provide ssh-like security by outright refusing passwords on the
    command-line (could take them interactively, or via some FD/file),
    then allow relaxing that to the level of this auto-helper, or all
    the way down to the old behavior.

1. https://hub.packtpub.com/atlassian-bitbucket-github-and-gitlab-take-collective-steps-against-the-git-ransomware-attack/
