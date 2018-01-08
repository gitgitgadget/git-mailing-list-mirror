Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFE21FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758102AbeAHWjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:39:02 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35815 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757912AbeAHWjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:39:01 -0500
Received: by mail-wm0-f68.google.com with SMTP id a79so17055558wma.0
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mFq1yDo930TB2M4A7RXukkvDOYLHNa5YtkBNqEqjT54=;
        b=G77i0azW/JQFxD1lTKak0TMNEVSN4j1oRiV99BzMG1xg7i3y5/cOhnlqMXz5HD3xWk
         lbXEUeIIPyHp2F4OXXik6drwILZnF1KIq9lIEdrozI1Nj0Oxf3lH4HSuilCcDg00BRRu
         3Vp10Xex2EwuIGI4hLY7zZ7lwNTLwapnjDfGTsKv/ax4lhlmTbk0cDBw5w+ZQeZ+qOox
         +RN20exmQEkYxrxReJhPTyON85z3Fm5yvMPUxjbWJbNmtZ+DoceST/g/6aVKWwqt5z1a
         FR8r1fTOsM1wBBvimDfTC0kGUZJ0fMLK2XxOr6bfq+ueL1kwo6jFgURytZ7n99brMkqd
         HYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mFq1yDo930TB2M4A7RXukkvDOYLHNa5YtkBNqEqjT54=;
        b=HvqOCie3JPUquX7vv8VQ/3EoTH2EuqYuhG2GclQcGBdM1b3MtbcdkrAGdEhVfKJ7tk
         pkYRfQYsLujNZcG3sD2XB5VL7ZhVDMMcLPEvFpdYgWUHguGXMDIJixBcKWxDvJPkbHII
         Sw1GWBMD/k4siRFmv0u0PoRMP3sQWy7kNaDkhPp0XxxdJoKr10CAC3g7yKCPeweWDlFz
         hR+AulEuMx0FYX0uNn2VziQ7OiZH+wfQjfNAPpxsEr4ZNUZZPZCmcg+/nFlIcg3aXflH
         9BwXBZAVpEY/ynQAOgdwv4llqEa8+MhuW6u4zquUymv/0Mwgi4/kr1iHIi/lIuqKxaUn
         fT3g==
X-Gm-Message-State: AKGB3mKdF+rYn9CafxDNAaZROesUiV4iTVzZJA5ftJ6U9X7C0XnMWFQB
        Kc2/RpAiKTow4ptkASAflIk=
X-Google-Smtp-Source: ACJfBou20nk2GgG94ts5snq7KCzEgTmljw+pvbh2ygLSN3beC6/fD/V/du7MidDwqCKPFGK8Ea+UMA==
X-Received: by 10.28.103.196 with SMTP id b187mr11189650wmc.127.1515451140292;
        Mon, 08 Jan 2018 14:39:00 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v3sm4573436wrg.30.2018.01.08.14.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 14:38:59 -0800 (PST)
Date:   Mon, 8 Jan 2018 22:41:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180108224110.GH2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08, Duy Nguyen wrote:
> On Mon, Jan 8, 2018 at 5:30 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > @@ -1896,16 +1895,17 @@ int read_index_from(struct index_state *istate, const char *path)
> >                 split_index->base = xcalloc(1, sizeof(*split_index->base));
> >
> >         base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> > -       base_path = git_path("sharedindex.%s", base_sha1_hex);
> > +       base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
> 
> Personally I prefer the repo_git_path() from v2 (sorry I was away and
> could not comment anything).

It felt slightly nicer to me as well, but it threw up a bunch of
questions about how worktrees will fit together with struct
repository.  As I don't feel very strongly about this either way I
decided to go with what Brandon suggested as an alternative, which
allows us to defer that decision.  I'd be happy to revert this to the
way I had it in v2, but I don't want to drag the discussion on too
long either, as this series does fix some real regressions.

> The thing is, git_path() and friends
> could do some path translation underneath to support multiple
> worktrees. Think of the given path here as a "virtual path" that may
> be translated to something else, not exactly <git_dir> + "/" +
> "sharedindex.%s". But in practice, we're not breaking the relationship
> between $GIT_DIR/index and $GIT_DIR/sharedindex.* any time soon, doing
> manual path transformation here is fine.
>
> What about the other git_path() in this file? With patch applied I still get
> 
> > ~/w/git/temp $ git grep git_path read-cache.c
> read-cache.c:           shared_index_path = git_path("%s", de->d_name);
> read-cache.c:   temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> read-cache.c:                         git_path("sharedindex.%s",
> sha1_to_hex(si->base->sha1)));
> read-cache.c:           const char *shared_index = git_path("sharedindex.%s",

Good point, I hadn't looked at these, I only looked at the current
test failures.  I'm going to be away for the rest of the week, but
I'll have a look at them when I come back.

> I suppose submodule has not triggered any of these code paths yet. Not
> sure if we should deal with them now or wait until later.
> 
> Perhaps if we add a "struct repository *" pointer inside index_state,
> we could retrieve back the_repository (or others) and call
> repo_git_path() everywhere without changing index api too much. I
> don't know. I like the  'struct repository' concept but couldn't
> follow its development so I don't if this is what it should become.

Interesting.  I didn't follow the development of  struct repository
too closely either, so I'm not sure.  Brandon might have more of an
opinion on that? :)

> -- 
> Duy
