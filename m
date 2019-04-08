Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78C120248
	for <e@80x24.org>; Mon,  8 Apr 2019 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDHOav (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 10:30:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38484 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHOav (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 10:30:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so14976238wmc.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V/61le6EN7WAH38fqoBkY9twrPmTNLWesYLZU/rTL3I=;
        b=Nw+2w+lFjvZF/vRtF3Wuyd6+ihJslQz7oxZ/s4ONrkvcAFV+aJUScmKSXb2Nv4TVms
         mEgdJ1vjU+fV5Y30lPH5u2nCMzG4z76XbojSBDwWZzkj4sopgoB1+0oFvFHWH/oOHKoQ
         j8wZX9EAs8XjuU/ctQOqlKw/pVA/MDEoppnjx5vEnTqpk7rnfpTCBz8t1brqCgbIDqtM
         dCiR+KOnfun8WZf7fc3517PBLL15UUaeOTVy3vfUY7oyvlfxWUmRX2FNKIa84M4HtwUn
         Bhp2FDhZOLSqPF2Y+ggQBSYbBlyB+7z5RQtwawZvXPES0nuKrXPwAfc4ChOZ29Ea85jT
         OEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V/61le6EN7WAH38fqoBkY9twrPmTNLWesYLZU/rTL3I=;
        b=GRYXEFo7L1sqatNL5CnnsWCYF5bDRhtwM98MqSXdL7fGE0Qv1vPyZHfJAc64Ee8q9Y
         ZYTtT8/IFNDoBrUecTXmj7RDoMJe99gDNOXeVpvaufYRqxqEBHsJL35wl2buDkTEW6XB
         czhr4Ukt8HeXf0nRMsKSYwDXYIJGWVkunHxOB7mXN+8g15rw/mVLcch/eH2CYNUwIcOE
         0uRq+00bWVnOW2+BCi04cK+hRJxVUjdwb5ndZwhYEZa0zC9tuKmJtwQT9gT9pjiz7isS
         oQPkGbJKIxbMnevI6bKrfB799p+rfCup8jfq6538rMalkkpztuzjpL0Pnht/WHG9YT35
         e+ng==
X-Gm-Message-State: APjAAAV4t/sqDiwZNy6YZODLifLYAX3bE27L3usW0LWaq74jKJ8p+h/m
        KDk1deGzZvTzgOEHMqb1BdRg/9Y1
X-Google-Smtp-Source: APXvYqxqJwe9F+eY1X2o9TLuqXmP+AM6N4YGj3yOM6sJ+uCURJHMW7Bs5BKCrzdCzgweJGM0BIXjmw==
X-Received: by 2002:a1c:495:: with SMTP id 143mr16777245wme.78.1554733849005;
        Mon, 08 Apr 2019 07:30:49 -0700 (PDT)
Received: from szeder.dev (x4db909f1.dyn.telefonica.de. [77.185.9.241])
        by smtp.gmail.com with ESMTPSA id z8sm31202431wrh.80.2019.04.08.07.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:30:47 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:30:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame: default to HEAD in a bare repo when no start
 commit is given
Message-ID: <20190408143046.GF8796@szeder.dev>
References: <20190407234327.25617-1-szeder.dev@gmail.com>
 <878swkacok.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878swkacok.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 08, 2019 at 02:44:59PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 08 2019, SZEDER Gábor wrote:
> 
> > When 'git blame' is invoked without specifying the commit to start
> > blaming from, it starts from the given file's state in the work tree.
> > However, when invoked in a bare repository without a start commit,
> > then there is no work tree state to start from, and it dies with the
> > following error message:
> >
> >   $ git rev-parse --is-bare-repository
> >   true
> >   $ git blame file.c
> >   fatal: this operation must be run in a work tree
> >
> > This is misleading, because it implies that 'git blame' doesn't work
> > in bare repositories at all, but it does, in fact, work just fine when
> > it is given a commit to start from.
> >
> > We could improve the error message, of course, but let's just default
> > to HEAD in a bare repository instead, as most likely that is what the
> > user wanted anyway (if they wanted to start from an other commit, then
> > they would have specified that in the first place).
> >
> > 'git annotate' is just a thin wrapper around 'git blame', so in the
> > same situation it printed the same misleading error message, and this
> > patch fixes it, too.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> 
> There was the explicit decision not to fall back to HEAD in 1cfe77333f
> ("git-blame: no rev means start from the working tree file.",
> 2007-01-30). This change makes sense to me, but perhaps some discussion
> or reference to the previous commit is warranted?

I don't think so, because that doesn't apply here, since it doesn't
really make much sense to talk about a working tree file in a bare
repo.

> Although from skimming the thread from back then it seems to be "not
> HEAD but working tree file", not "let's not use HEAD in bare repos".
> 
> >  builtin/blame.c     | 13 +++++++++++++
> >  t/annotate-tests.sh |  8 ++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 177c1022a0..21cde57e71 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -27,6 +27,7 @@
> >  #include "object-store.h"
> >  #include "blame.h"
> >  #include "string-list.h"
> > +#include "refs.h"
> >
> >  static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
> >
> > @@ -993,6 +994,18 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> >
> >  	revs.disable_stdin = 1;
> >  	setup_revisions(argc, argv, &revs, NULL);
> > +	if (!revs.pending.nr && is_bare_repository()) {
> > +		struct commit *head_commit;
> > +		struct object_id head_oid;
> > +
> > +		if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> > +					&head_oid, NULL) ||
> > +		    !(head_commit = lookup_commit_reference_gently(revs.repo,
> > +							     &head_oid, 1)))
> > +			die("no such ref: HEAD");
> > +
> > +		add_pending_object(&revs, &head_commit->object, "HEAD");
> > +	}
> 
> With this patch, if I have a bare repo without a HEAD I now get:
> 
>     fatal: no such ref: HEAD

This is the same error message as in a regular repo without HEAD.
That's good: it's consistent, and it tells what the actual problem is.

Though perhaps too terse and the error message from 'git log' would
apply just as well and be more friendly:

  fatal: your current branch 'master' does not have any commits yet

> Instead of:
> 
>     fatal: this operation must be run in a work tree
> 
> Both are bad & misleading, perhaps we can instead say something like:
> 
>     die(_("in a bare repository you must specify a ref to blame from, we tried and failed to implicitly use HEAD"));

The point of this patch is that you don't necessarily have to specify
the starting ref in a bare repo anymore.

> Along with a test for what we do in bare repos without a HEAD....?

How can a repo have no HEAD?  Maybe I'm missing something, but I only
see the following cases:

  - An empty repo: there is nothing to blame there at all in the first
    place.

  - An orphan branch in a non-bare repo: there is nothing to blame
    there.

  - The user is looking for trouble, and ran 'git update-ref -d HEAD',
    as you mentioned below, or something else with similar results.
    "If it hurts, don't it" applies.

  - Some sort of repo corruption that left the refs in a sorry state.
    The user has more serious problems than the error message from
    'git blame'.

So I doubt that any of these cases are worth dealing with and testing
specifically in a bare repo.

> 
> >
> >  	init_scoreboard(&sb);
> >  	sb.revs = &revs;
> > diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> > index 6da48a2e0a..d933af5714 100644
> > --- a/t/annotate-tests.sh
> > +++ b/t/annotate-tests.sh
> > @@ -68,6 +68,14 @@ test_expect_success 'blame 1 author' '
> >  	check_count A 2
> >  '
> >
> > +test_expect_success 'blame in a bare repo without starting commit' '
> > +	git clone --bare . bare.git &&
> > +	(
> > +		cd bare.git &&
> > +		check_count A 2
> > +	)
> 
> ....just 'git update-ref -d HEAD` after this and a test for 'git blame
> <file>' here would test bare without HEAD.
> 
> >  test_expect_success 'blame by tag objects' '
> >  	git tag -m "test tag" testTag &&
> >  	git tag -m "test tag #2" testTag2 testTag &&
