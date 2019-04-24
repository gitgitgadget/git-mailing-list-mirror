Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF111F453
	for <e@80x24.org>; Wed, 24 Apr 2019 02:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDXCem (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 22:34:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46638 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfDXCem (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 22:34:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id o7so6230730pll.13
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8KG8cXu9AHaVy4zgszP8CyLzg7xMGohlAUaY5r4lozg=;
        b=tp+0uAEj0jHO8TPLknWlaRTouLpwlGrNvg54DJuBhrEwdIS5Y51sbpTuUnKBtUQlTN
         bgh7YZndJ64ELIhkDgj+C87kg+f4CbEYMfvVCzM32KLRRYS8sTHlNyMQ6u78MGefcvdl
         XUPYM/ZCUh/YJltA45dsjmxbCUaaejHbiOa3DekgIX3c1O0g7+MHuVLoKTn6gpHs28qV
         N0saRFmKu4cLiWp9Y5mYRYrAFaXPoAmukn9b11JnFjYeiWw1kEO7Zm4HHR4LZxxJgsRo
         19O7iirrhnVlmuj8oB1sGOpEh1lFZnJdm1oYDN34X0FSSRdMX2WmrgemyrXuH5pmZCyj
         uAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8KG8cXu9AHaVy4zgszP8CyLzg7xMGohlAUaY5r4lozg=;
        b=R18R/rsT3hjuMasqGicsqCJU3oYHQeYo5JjwBA36uR3mBI46/9AwMZrLqR6QbfUnBo
         nvT2dhZ/UNuG+qKO+DsvEYtjFRydwZzJD1bZfYvp770RV6GLTEKd8XbMA+sDbfIuc3SR
         w3iG5k2ehA0vhEiSDeDI5+xRKuIJyIOBPxXiiCOFePmjE8tD92tVNdlHYhDtAt94UVMO
         TaZO3cr+vpisVvs1y8cEEjgbFoxf7m85+sLxL4Y0wsNz1O6+Zj1sIBAxc39O1WwH+q6P
         Kd2428JjQujwAlPKIdA5QMtb/JAJG/r21VN5YjFB/7YgbOtyj6+d1CyVY92sWqGbm4xH
         gOHQ==
X-Gm-Message-State: APjAAAXFW32CuAaSwN7wILorbGK1AGxLySpbIEiI18n8E3QgJkEPUPaE
        uh9jA1o08eEGecF/REu7GYQ=
X-Google-Smtp-Source: APXvYqwEX3mj4vchjRYOqgRppT9IFpjA5uPCgF8XQqeHYcz0XpQI6Dm8jGKWkqR+Ib6rtyHznoHHpA==
X-Received: by 2002:a17:902:382:: with SMTP id d2mr30279607pld.253.1556073281302;
        Tue, 23 Apr 2019 19:34:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s85sm30810944pfa.23.2019.04.23.19.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 19:34:40 -0700 (PDT)
Date:   Tue, 23 Apr 2019 19:34:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190424023438.GE98980@google.com>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> I've talked with some people about this approach, and they've indicated
> they would prefer a configuration-based approach.

I would, too, mostly because that reduces the problem of securing
hooks to securing configuration.  See
https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
for more on this subject.

More precisely, a few problems with the current hooks system:

 1. There's not a standard way to have multiple hooks for a single event.
    That's what this series is about.

    (The recommended workaround has been to use a trampoline script as
    your hook, and to make that trampoline script implement whatever
    policy for the order of invocation and accumulation of results is
    appropriate, but that's a bit of a cop-out.)

 2. Because they are stored in the Git repository, they do not have a
    way to be automatically updated.

    (The recommended workaround is to use a trampoline script as your
    hook and put the actual hook somewhere standard like $PATH where
    it can be upgraded system-wide.  But that's a bit of a cop-out.)

 3. Because they are part of the Git repository, it is very easy to
    compromise a user's account by tricking them into running an
    attacker-authored hook.  Attacks include "hey admin, can you tell
    me why 'git commit' is failing in this repo?" and "here's a zip file
    containing a Git repository with our fancy software.  Feel free
    to look around, run 'git pull', etc".

    Similar attacks, probably even worse, apply to shell prompt scripts
    using commands from attacker-controlled .git/config.

    (The recommended workaround is to inspect .git/config and
    .git/hooks whenever you're looking at an untrusted repository, and
    to write your shell prompt script defensively.)

Solving (1) without (2) feels like a bit of a missed opportunity to
me.  Ideally, what I would like is

   i. A central registry of trustworthy Git hooks that can be upgraded
      using the system package manager to address (2).  Perhaps just
      git-hook-* commands on the $PATH.

  ii. Instead of putting hooks in .git/hooks, put a list of hooks to
      run for each event in .git/config.

 iii. For backward compatibility, perform a multi-stage migration.
      In the stage I am most interested in:

      When encountering a hook in .git/hooks, don't run it, but print
      a message about how to migrate it to the modern scheme.

      To make migration to the modern scheme painless, stick a
      standard trampoline script in .git/hooks in all converted and
      all newly "git init"ed repositories to allow old versions of Git
      to respect the configuration from (i) and (ii).

That doesn't handle core.pager et al, but those we can handle
separately (for example by, at least optionally, not respecting values
for them in per-repo config at all).

Thanks for tackling this.  What do you think?

Thanks,
Jonathan
