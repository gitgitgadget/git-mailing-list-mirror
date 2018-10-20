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
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A5E1F454
	for <e@80x24.org>; Sat, 20 Oct 2018 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeJUDxQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 23:53:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43479 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeJUDxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 23:53:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so34339941eds.10
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dI3k6XWxRN4m0wJvpALpwoYimyj6cYgPTbTyWFTGpTc=;
        b=L26Nzj/+jrgSmlQM4rmJuJq2pOCJ15aGa7sxAwcBISCqAl9syzyPQd1Hg7ogib8U7j
         3tz3v2JOMQBLeiavSGLmToGRnTlm7pOGrmAuorRZ/rRi1H6iEOuPcP40GTd2rzq78JvB
         hy8LJdCpmHhVgWy9xPWqdW64QoZnRO1QyTlGnu4QBCIgOLO8IC66swoNzUdg4YXhg75p
         45ZBEsZwutzo9b1dR2o0RfvLpfeAmAvP+DKgoif8uGHfrtvh+ihZ98Wd+hKDJxkRwvjo
         zFIT5vdP1D3rtJ5+IzaE8py8r+9PgMYw/XjlXmDBHH90b7zWXAQ5VUwvb4fUHoiVvM7K
         iLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dI3k6XWxRN4m0wJvpALpwoYimyj6cYgPTbTyWFTGpTc=;
        b=pazvzvgQX0R03u400KDiD0YmIsmoh3JcZ3Ol5A0R0bp2m+ouCFAjsbvahTHxmWC39a
         2lCOQZAzFxtcgJ8jp5vPXKXxlKkM2sUVRtjFlRpNdBOKvSyKqzoikrr8VnJGSyQ1k8C/
         sHhCoAn5SGeakAoVi99GZT1Zi1jgUQ5uOLPPgCZtdSUqJ7x7xAva8gf2yTRiuIbe2gK3
         0ZOeVcX44jiktBnJkgdV/vDrr9hnBK2xHI6BaC9oFcS4jC19tytIm6lt7dVmc5hJ+KlO
         MGtuh8WVbwgOoGZSYPrF8NgrYWFmLKWtnJFdwKmyfz84iHU1HLi5/mRi+ZbJpXDhyQXk
         7tcg==
X-Gm-Message-State: ABuFfogM72qSDyX08ehFCu+FwfVU5OBCOBX00wnlAJjGyVwRrqLJ32IU
        YoN14fGyNa/QroP34Yg7DSI=
X-Google-Smtp-Source: ACcGV61vvnPfzm/UrXIQPVeQ5LfQP2vNYuF7lwQZogR4/xfoacXuwTOKubsZ8+Ijz37y5eGU24FeAA==
X-Received: by 2002:a17:906:5c0d:: with SMTP id e13-v6mr33313695ejq.183.1540064504501;
        Sat, 20 Oct 2018 12:41:44 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id w8-v6sm10003620eda.37.2018.10.20.12.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 12:41:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/59] Split config.txt
References: <20181020123848.2785-1-pclouds@gmail.com> <87d0s4ctds.fsf@evledraar.gmail.com> <CACsJy8ADfhRk9eUJG+FE4k_D5sZvBOu47Vm4Gkae1XiOVtZyjQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8ADfhRk9eUJG+FE4k_D5sZvBOu47Vm4Gkae1XiOVtZyjQ@mail.gmail.com>
Date:   Sat, 20 Oct 2018 21:41:42 +0200
Message-ID: <87bm7ocsnd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 20 2018, Duy Nguyen wrote:

> On Sat, Oct 20, 2018 at 9:25 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> And sometimes like in the case of git-gc(1) we have gc.* config
>> documented in two places with different prose that needs to be updated
>> in two places in a CONFIGURATION section. This series allows us to just
>> unify the two and do an "include" in two places, and more generally have
>> the convention that a given command that uses configuration could have
>> that config both documented in git-config(1), and the same docs in its
>> own manpage.
>>
>> Is doing some post-cleanup like that your eventual goal after this
>> series?
>
> I did see the possibility of including command-specific config in
> individual command man page. But I'm not planning on doing it myself.
> Some command man page is already pretty long, plus sometimes we rely
> on the core.* part which should not be included in per-command man
> page...

I might follow-up with some of that after this lands then. We wouldn't
include all config (including core.*) that affects the command, but just
command-specific stuff like gc.* or worktree.*.

Due to limitations of ASCIIDOC link syntax we often just mention "blah
blah can be also configured as somecmd.config, see
linkgit:git-config[1]", e.g. one example I recently added is at:
https://git-scm.com/docs/git-fetch#_pruning

Then the user clicks on that, and ends up in this giant manpage and they
need to use their browser search. Both far that web experience and for
reading with "man" it would be nicer to be able to say "see the
CONFIGURATION section below" which would have that included.

But arguably better would be consistently being able to know where the
primary documentation is. E.g. for worktree.guessRemote (not picking on
you in particular, it was just easy because worktree.* is only one
config var) we have:

in git-config(1):

    worktree.guessRemote::
    	With `add`, if no branch argument, and neither of `-b` nor
    	`-B` nor `--detach` are given, the command defaults to
    	creating a new branch from HEAD.  If `worktree.guessRemote` is
    	set to true, `worktree add` tries to find a remote-tracking
    	branch whose name uniquely matches the new branch name.  If
    	such a branch exists, it is checked out and set as "upstream"
    	for the new branch.  If no such match can be found, it falls
    	back to creating a new branch from the current HEAD.

In git-worktree(1)

    --[no-]guess-remote::
    	With `worktree add <path>`, without `<commit-ish>`, instead
    	of creating a new branch from HEAD, if there exists a tracking
    	branch in exactly one remote matching the basename of `<path>`,
    	base the new branch on the remote-tracking branch, and mark
    	the remote-tracking branch as "upstream" from the new branch.
    +
    This can also be set up as the default behaviour by using the
    `worktree.guessRemote` config option.

Mostly they're saying the same, but all in different words, so you need
to carefully read both to really make sure you got it. There's many of
those cases, would be good if we could unify all or most of them.
