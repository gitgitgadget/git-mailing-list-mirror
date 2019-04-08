Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057E320248
	for <e@80x24.org>; Mon,  8 Apr 2019 15:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfDHPsZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 11:48:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38987 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHPsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 11:48:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id n9so3265463edt.6
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Iav9N+XEZmhGeO6bToKcdpahwecbiSERla4b//s18PA=;
        b=cex/LWq/Y5uRB3ke9lXB88OhO3sJBXNx/jDN9TKvC2r6rSQV4gtEmDf1fcPNprO7Cj
         mz6Lc2/HDkmOJSbU235Z+AqXaowWZFWZNupl9R6k2Wk+0rU9hwN4lvjDciaNCP/9r3FK
         vuQUYmFvgtdt9Exln6da927CUaMeKNsNQJFHnJ7gAlJZwKvcEqry9T4cb5p/+4Iu60vY
         PtnWi94we+pv5nS3YR0/gOxhkJKu1Y3k93wDbHmqvx7h/lBQM4/71bRF1CixCuNdU/PI
         A0xDjAzvbHGaTOF8kd/LstKyq0rcpI/TlWLEOylhpv6mV+8h/Kx6YpeiWPXOQuXI/1J8
         w7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Iav9N+XEZmhGeO6bToKcdpahwecbiSERla4b//s18PA=;
        b=C44boasFgwcoUO+dOmYZxFdIAXXabR0BEOjaoDZdfKRqa6/u9QsAk4+I+amUkBSlfT
         HqwQjLtEkBgQHUdt29TAp5WYyUD6ZSPkheu2k/WXNxwfxnxr7I3uNJDduUbZivzph1/v
         WVFnIuYARdiN2ZBzRy3krjgOQq4P+7/vdQFKbDY5uiZk8Yqoj2+d3cd5ZDTBXJA+I8rg
         AqeotPcHNIwF2M/bHL0nYjggO07T4zVVsGM8ULrSyzF0thfdlFneDb9+76xuvRQQCzgg
         ifSUcwlo08B3rlSK8x6P9B5V0eOlnJAoTtteCElo82QZj5AsEmd9CgbC5cw7jtdmirUa
         hjSw==
X-Gm-Message-State: APjAAAWg28krUc6a1+eq+usXb7nQDgA2gvyfjlxwlO/r9BxokR23IOLh
        mJXMeaNiXl++x7R8FHcN0bE=
X-Google-Smtp-Source: APXvYqzKSO71hXLjYM/0l16kFcdKxOXFb9Hy4vGBuHbBQldP/7g+C01YWSVEQpJ7W9zbN4jJMX2wow==
X-Received: by 2002:a17:906:1dc9:: with SMTP id v9mr16404224ejh.262.1554738502380;
        Mon, 08 Apr 2019 08:48:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id ga13sm5512900ejb.9.2019.04.08.08.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 08:48:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame: default to HEAD in a bare repo when no start commit is given
References: <20190407234327.25617-1-szeder.dev@gmail.com> <878swkacok.fsf@evledraar.gmail.com> <20190408143046.GF8796@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190408143046.GF8796@szeder.dev>
Date:   Mon, 08 Apr 2019 17:48:21 +0200
Message-ID: <875zroa46y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 08 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Apr 08, 2019 at 02:44:59PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Apr 08 2019, SZEDER G=C3=A1bor wrote:
>>
>> > When 'git blame' is invoked without specifying the commit to start
>> > blaming from, it starts from the given file's state in the work tree.
>> > However, when invoked in a bare repository without a start commit,
>> > then there is no work tree state to start from, and it dies with the
>> > following error message:
>> >
>> >   $ git rev-parse --is-bare-repository
>> >   true
>> >   $ git blame file.c
>> >   fatal: this operation must be run in a work tree
>> >
>> > This is misleading, because it implies that 'git blame' doesn't work
>> > in bare repositories at all, but it does, in fact, work just fine when
>> > it is given a commit to start from.
>> >
>> > We could improve the error message, of course, but let's just default
>> > to HEAD in a bare repository instead, as most likely that is what the
>> > user wanted anyway (if they wanted to start from an other commit, then
>> > they would have specified that in the first place).
>> >
>> > 'git annotate' is just a thin wrapper around 'git blame', so in the
>> > same situation it printed the same misleading error message, and this
>> > patch fixes it, too.
>> >
>> > Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>
>> There was the explicit decision not to fall back to HEAD in 1cfe77333f
>> ("git-blame: no rev means start from the working tree file.",
>> 2007-01-30). This change makes sense to me, but perhaps some discussion
>> or reference to the previous commit is warranted?
>
> I don't think so, because that doesn't apply here, since it doesn't
> really make much sense to talk about a working tree file in a bare
> repo.

I mean for context in the sense that the current error we display we
haven't always shown, and explicitly started doing in that commit (but
for another purpose...).

>> Although from skimming the thread from back then it seems to be "not
>> HEAD but working tree file", not "let's not use HEAD in bare repos".
>>
>> >  builtin/blame.c     | 13 +++++++++++++
>> >  t/annotate-tests.sh |  8 ++++++++
>> >  2 files changed, 21 insertions(+)
>> >
>> > diff --git a/builtin/blame.c b/builtin/blame.c
>> > index 177c1022a0..21cde57e71 100644
>> > --- a/builtin/blame.c
>> > +++ b/builtin/blame.c
>> > @@ -27,6 +27,7 @@
>> >  #include "object-store.h"
>> >  #include "blame.h"
>> >  #include "string-list.h"
>> > +#include "refs.h"
>> >
>> >  static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] =
[<rev>] [--] <file>");
>> >
>> > @@ -993,6 +994,18 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
>> >
>> >  	revs.disable_stdin =3D 1;
>> >  	setup_revisions(argc, argv, &revs, NULL);
>> > +	if (!revs.pending.nr && is_bare_repository()) {
>> > +		struct commit *head_commit;
>> > +		struct object_id head_oid;
>> > +
>> > +		if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
>> > +					&head_oid, NULL) ||
>> > +		    !(head_commit =3D lookup_commit_reference_gently(revs.repo,
>> > +							     &head_oid, 1)))
>> > +			die("no such ref: HEAD");
>> > +
>> > +		add_pending_object(&revs, &head_commit->object, "HEAD");
>> > +	}
>>
>> With this patch, if I have a bare repo without a HEAD I now get:
>>
>>     fatal: no such ref: HEAD
>
> This is the same error message as in a regular repo without HEAD.
> That's good: it's consistent, and it tells what the actual problem is.
>
> Though perhaps too terse and the error message from 'git log' would
> apply just as well and be more friendly:
>
>   fatal: your current branch 'master' does not have any commits yet
>
>> Instead of:
>>
>>     fatal: this operation must be run in a work tree
>>
>> Both are bad & misleading, perhaps we can instead say something like:
>>
>>     die(_("in a bare repository you must specify a ref to blame from, we=
 tried and failed to implicitly use HEAD"));

Yeah, I missed that it's the same message as with no HEAD in a non-bare
repo. Makes sense.

> The point of this patch is that you don't necessarily have to specify
> the starting ref in a bare repo anymore.
>
>> Along with a test for what we do in bare repos without a HEAD....?
>
> How can a repo have no HEAD?  Maybe I'm missing something, but I only
> see the following cases:
>
>   - An empty repo: there is nothing to blame there at all in the first
>     place.
>
>   - An orphan branch in a non-bare repo: there is nothing to blame
>     there.
>
>   - The user is looking for trouble, and ran 'git update-ref -d HEAD',
>     as you mentioned below, or something else with similar results.
>     "If it hurts, don't it" applies.
>
>   - Some sort of repo corruption that left the refs in a sorry state.
>     The user has more serious problems than the error message from
>     'git blame'.
>
> So I doubt that any of these cases are worth dealing with and testing
> specifically in a bare repo.

If you setup a repo to manually fetch refspecs you can end up without a
HEAD but still be able to 'blame' stuff. I don't think that happens with
non-bare, but does with bare. E.g. I set up some server-side "blame"
that supports the "master" branch of several repos like that in the
past, and just plain 'git blame' throws the old message.

So maybe since we're checking is_bare_repository() it's worth improving
the error while we're at it, or at least testing that bare & non-bare do
the same thing.

>>
>> >
>> >  	init_scoreboard(&sb);
>> >  	sb.revs =3D &revs;
>> > diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>> > index 6da48a2e0a..d933af5714 100644
>> > --- a/t/annotate-tests.sh
>> > +++ b/t/annotate-tests.sh
>> > @@ -68,6 +68,14 @@ test_expect_success 'blame 1 author' '
>> >  	check_count A 2
>> >  '
>> >
>> > +test_expect_success 'blame in a bare repo without starting commit' '
>> > +	git clone --bare . bare.git &&
>> > +	(
>> > +		cd bare.git &&
>> > +		check_count A 2
>> > +	)
>>
>> ....just 'git update-ref -d HEAD` after this and a test for 'git blame
>> <file>' here would test bare without HEAD.
>>
>> >  test_expect_success 'blame by tag objects' '
>> >  	git tag -m "test tag" testTag &&
>> >  	git tag -m "test tag #2" testTag2 testTag &&
