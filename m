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
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2CE20374
	for <e@80x24.org>; Tue, 16 Apr 2019 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfDPOvU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 10:51:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40447 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPOvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 10:51:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id d46so13342851eda.7
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mf1F8/g55tOrep4FBkk0w0ikqS6S+24nQg8x4w4G1Ro=;
        b=UZxF0Nebk3ck8QEE0ip7+hKX/Sn6mXne++O4qk71EkqM7Wmbyn1d7nbye2aNSzTHIX
         +63gIsWFhTwnsGQpsveAQqM2c6BkAq29roC2192dL12FStnXrPxqz1a+tAIyeJ4fX7x3
         EYHfqK2xw0vVubN+wNcR1pVliW2bd4TxRERQxTLkU5rzhBMWgXm+Lnv2/7zougoCONzS
         d9RSHGep+XWcXTrP+RvZ21We9Jh/HiWXeRPivhDn1mGRNcakeL0EQwXRG8Eng7KzluFF
         qkOd63kTyIOMo2L0KsbJLzR7Uy9WTYwjF+Xw5O3JxMNk6+RzY4Ia+rYQOqZ0bnZvhGSC
         HjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mf1F8/g55tOrep4FBkk0w0ikqS6S+24nQg8x4w4G1Ro=;
        b=PlaG5kWKESIbxk0jl58uJ7nH2T/aluXG8ESdpZw9pF/WT/NNC3TzM20hd/GyUY3BSz
         1VE5K+Ous/y7Iwe6bLEgTfY/C6UoLSB6RYp9KpTfOB5Y2tRL+NCa/tMdmzz4HfRmncUQ
         5W35hjSEGoBb2/jFV18nECSqix53Ha/e0+Iv1HWEd+c7eP+heIILwBtB0GbiCgHpaVhh
         xRSyT4K3JVvWBQEO5OMwignvP5SmPI4phcXK25f+YgQGmazRhn1KPCXSgGr67GeOd5UB
         olEROf8ote4u/wyfn+pH+VQbyxGoTckc0yrbSB4uh1LGQwDfsFOTkv9B0FtaI2eZRlzT
         PpXg==
X-Gm-Message-State: APjAAAUkz4GcagzstKXfInyxC+goRVwAIBP1IDZAYRu00t8CI5CEU2B0
        eTraa0zrTE1D5zzrdE6Fp7p2AP1K
X-Google-Smtp-Source: APXvYqy/ijZANBHnQJaCtYrPHjx5KpDEw9e2kEGa7dGDMsm3ZYZ3C8PyO2HGx4MdH/4rMbihEscPQw==
X-Received: by 2002:a50:a4db:: with SMTP id x27mr51425041edb.120.1555426278494;
        Tue, 16 Apr 2019 07:51:18 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id q57sm868366eda.25.2019.04.16.07.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 07:51:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 16 Apr 2019 16:51:14 +0200
Message-ID: <87d0lmatr1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 16 2019, Junio C Hamano wrote:


> * jc/gettext-test-fix (2019-04-15) 1 commit
>  - gettext tests: export the restored GIT_TEST_GETTEXT_POISON
>
>  The GETTEXT_POISON test option has been quite broken ever since it
>  was made runtime-tunable, which has been fixed.
>
>  Will merge to 'next'.

LGTM, but AFAICT this patch of yours never got sent to the list,
oversight?

> * ds/midx-expire-repack (2019-01-27) 10 commits
>  - midx: add test that 'expire' respects .keep files
>  - multi-pack-index: test expire while adding packs
>  - midx: implement midx_repack()
>  - multi-pack-index: prepare 'repack' subcommand
>  - multi-pack-index: implement 'expire' subcommand
>  - midx: refactor permutation logic and pack sorting
>  - midx: simplify computation of pack name lengths
>  - multi-pack-index: prepare for 'expire' subcommand
>  - Docs: rearrange subcommands for multi-pack-index
>  - repack: refactor pack deletion for future use
>
>  "git multi-pack-index expire/repack" are new subcommands that
>  consult midx file and are used to drop unused pack files and
>  coalesce small pack files that are still in use.
>
>  Comments?

I have not used this myself, but skimmed the patches. My 0.02: Seems
safe to integrate since it's fairly well-tested at MSFT & off by
default.

> * ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
>  - pack-objects: default to writing bitmap hash-cache
>  - t5310: correctly remove bitmaps for jgit test
>  - repack: enable bitmaps by default on bare repos
>
>  The connectivity bitmaps are created by default in bare
>  repositories now; also the pathname hash-cache is created by
>  default to avoid making crappy deltas when repacking.
>
>  Will merge to 'next'.

Pushing *from* a bare repo isn't going to be super common (although
stuff like server->server replication...). The case I reported in
https://public-inbox.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/ will
result in some users seeing a huge slowdown due to this in some
cases.

I'm inclined to hold that sort of thing off until we get that sorted out
/ perf tested. It taking ~2m instead of ~500ms sucks pretty badly (in my
test-case).

> * ab/gc-docs (2019-04-08) 11 commits
>  - gc docs: remove incorrect reference to gc.auto=3D0
>  - gc docs: clarify that "gc" doesn't throw away referenced objects
>  - gc docs: note "gc --aggressive" in "fast-import"
>  - gc docs: downplay the usefulness of --aggressive
>  - gc docs: note how --aggressive impacts --window & --depth
>  - gc docs: fix formatting for "gc.writeCommitGraph"
>  - gc docs: re-flow the "gc.*" section in "config"
>  - gc docs: include the "gc.*" section from "config" in "gc"
>  - gc docs: clean grammar for "gc.bigPackThreshold"
>  - gc docs: stop noting "repack" flags
>  - gc docs: modernize the advice for manually running "gc"
>
>  Update docs around "gc".
>
>  Will merge to 'next'.

Any chance on making that s/next/master/ sooner than later?

It's just doc changes so I think the usual "let's cook in next..." has
less value, and I have some follow-ups I'd like to submit sooner than
later without me/you dealing with conflicts.

If not, no problem :)

> * nd/precious (2019-04-09) 1 commit
>  - Introduce "precious" file concept
>
>  "git clean" learned to pay attention to the 'precious' attributes
>  and keep untracked paths with the attribute instead of removing
>  when the "--keep-precious" is given.
>
>  Will merge to 'next'.

Duy had a message about this in
https://public-inbox.org/git/CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2x=
tfc9w@mail.gmail.com/

If that was just a "I don't have time to deal with =C3=86var's deluge of
comments" (sorry!) I'm happy to re-roll with the nits I had if anyone
thinks those make sense (doc & test adjustments...).

But that note is terse, not sure if it means "let's drop this no matter
what" (for reasons...), ..., Duy?

> * nd/diff-parseopt-4 (2019-03-24) 20 commits
> [...]
>  + diff-parseopt: convert --[no-]abbrev
> [...]
>  Will merge to 'master'.

Have some stuff I meant to re-roll conflicting with this, will be good
to have it in master.

> * pw/rebase-i-internal-rfc (2019-03-21) 12 commits
>  - rebase -i: run without forking rebase--interactive
>  - rebase: use a common action enum
>  - rebase -i: use struct rebase_options in do_interactive_rebase()
>  - rebase -i: use struct rebase_options to parse args
>  - rebase -i: use struct object_id for squash_onto
>  - rebase -i: use struct commit when parsing options
>  - rebase -i: remove duplication
>  - rebase -i: combine rebase--interactive.c with rebase.c
>  - rebase: use OPT_RERERE_AUTOUPDATE()
>  - rebase: rename write_basic_state()
>  - sequencer: always discard index after checkout
>  - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-int=
ernal-rfc
>  (this branch uses ag/sequencer-reduce-rewriting-todo.)
>
>  The internal implementation of "git rebase -i" has been updated to
>  avoid forking a separate "rebase--interactive" process.
>
>  Comments?  Is this ready?

I gave this some stress testing/review in your infra, works for me so
far, and a good performance improvement.

My only problem with it is that the commit message doesn't note just
quite how awesome it is, but I can live with that :)
