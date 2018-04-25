Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 727BC1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 10:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDYKgG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 06:36:06 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55959 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeDYKgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 06:36:00 -0400
Received: by mail-wm0-f47.google.com with SMTP id a8so6281142wmg.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=tm5+PA37mAxrOmN6cVwTl3xOi3+M31SAL+OBIfrC9c8=;
        b=mgCb19tLgvxq32xWwyJozOHFyl997pIN3AJizavQGw5AKe9NnWXHQ8Iys8NSzGmcK0
         g8p1AUZaeE2gil4QvJHnR+mv085EH65XQIa6hRovX2M+//6O4T/jx+zJfmPgwS6Su6Es
         6bsBZ15T2fZbBy7upN+NPZLippJndesLAGcu6RufVm+pGXZJiBBiueh+LTqo3U0hbq2M
         PLrAEzB2+jjwLHsq7dXPnRRtBZwnBblXNCEX7sD84pBKO5X4DL4waE/cq+FTMhBO9qDd
         F3QO1f4nne0OGnwAMm6NqUOximJWke22lU/TzQIXVTsyOBPNJOkep+Xiy3/pZMFpCGyS
         st/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=tm5+PA37mAxrOmN6cVwTl3xOi3+M31SAL+OBIfrC9c8=;
        b=t/5HYlQVo9KrQqKFdSbb7UgnIQzgyWdFYSprSahtULHe0P97tCaeAK+X1JBAf+wXdV
         DNQC6tUWPlR6cJp5gnr7kpc9vxvDp3adCCaZWLWLlOrGsijmgIs50sRt9n48WwzKfy4T
         /SGIO/VAQoBugYXWF+xrffrE7BWlzbfho7HlJjOLW92/d0Mz04LAT25lO23x9PV3Pwyl
         /wdTtEOKEZOORvPZLkH1exrOJm7/4ESezNxhwqQdA1fGkZemB5Vy07QjxHbV8Njbz4Kd
         RzCSixxR+1pU6s79bm6eQAgt0+fILgNARzgtgwo3EOIQbtl3YNGoC6gWgTPRIL4rOYTs
         ytZA==
X-Gm-Message-State: ALQs6tCGIGTHbhjasEq1/p8x6okyPTU2e1izjDqWqLj/V+5tPh5HRcpb
        9QkEc+hUd47OzudaalqeLZ4=
X-Google-Smtp-Source: AIpwx48UT4TsfhEVbngACxlWuwbQm+67yhWU0EM+BGoUOY5zkKU1B9MZf5bsNuWS00JIhCMh7TYUoQ==
X-Received: by 10.80.195.202 with SMTP id i10mr37976887edf.232.1524652558046;
        Wed, 25 Apr 2018 03:35:58 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x18sm10204953edi.58.2018.04.25.03.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 03:35:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Hesse <mail@eworm.de>,
        Derrick Stolee <stolee@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 25 Apr 2018 12:35:55 +0200
Message-ID: <87zi1rd14k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 25 2018, Junio C. Hamano wrote:

>  THe command line completion (in contrib/) has been taught that "git

> * js/colored-push-errors (2018-04-24) 4 commits
>  - config: document the settings to colorize push errors/hints
>  - push: test to verify that push errors are colored
>  - push: colorize errors
>  - color: introduce support for colorizing stderr
>
>  Error messages from "git push" can be painted for more visibility.

This is a really good UI improvement. Just got around to looking at this
now, looks good!

> * sb/diff-color-move-more (2018-04-25) 7 commits
>  - diff.c: add --color-moved-ignore-space-delta option
>  - diff.c: decouple white space treatment from move detection algorithm
>  - diff.c: add a blocks mode for moved code detection
>  - diff.c: adjust hash function signature to match hashmap expectation
>  - diff.c: do not pass diff options as keydata to hashmap
>  - xdiff/xdiffi.c: remove unneeded function declarations
>  - xdiff/xdiff.h: remove unused flags
>
>  "git diff --color-moved" feature has further been tweaked.

I hadn't had time to look at
https://public-inbox.org/git/20180403210536.33798-1-sbeller@google.com/
before. Looks good to me, great to have the new "blocks" mode.

> * ab/simplify-perl-makefile (2018-04-19) 2 commits
>   (merged to 'next' on 2018-04-25 at 906cf21682)
>  + Makefile: mark perllibdir as a .PHONY target
>   (merged to 'next' on 2018-04-17 at 4448756934)
>  + perl: fix installing modules from contrib
>
>  Recent simplification of build procedure forgot a bit of tweak to
>  the build procedure of contrib/mw-to-git/
>
>  Will merge to 'master'.

Thanks to Christian Hesse for fixing up my mess.

> * nd/pack-objects-pack-struct (2018-04-16) 15 commits
>  - ci: exercise the whole test suite with uncommon code in pack-objects
>  - pack-objects: reorder members to shrink struct object_entry
>  - pack-objects: shrink delta_size field in struct object_entry
>  - pack-objects: shrink size field in struct object_entry
>  - pack-objects: clarify the use of object_entry::size
>  - pack-objects: don't check size when the object is bad
>  - pack-objects: shrink z_delta_size field in struct object_entry
>  - pack-objects: refer to delta objects by index instead of pointer
>  - pack-objects: move in_pack out of struct object_entry
>  - pack-objects: move in_pack_pos out of struct object_entry
>  - pack-objects: use bitfield for object_entry::depth
>  - pack-objects: use bitfield for object_entry::dfs_state
>  - pack-objects: turn type and in_pack_type to bitfields
>  - pack-objects: a bit of document about struct object_entry
>  - read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean
>
>  "git pack-objects" needs to allocate tons of "struct object_entry"
>  while doing its work, and shrinking its size helps the performance
>  quite a bit.
>
>  What's the doneness of this thing?  The interdiff since previous
>  rounds looked reasonable, but I didn't see this round otherwise
>  scrutinized by reviewers.  The numbers given in the commit near the
>  tip do look impressive, though ;-)
>
> * nd/repack-keep-pack (2018-04-16) 7 commits
>  - pack-objects: show some progress when counting kept objects
>  - gc --auto: exclude base pack if not enough mem to "repack -ad"
>  - gc: handle a corner case in gc.bigPackThreshold
>  - gc: add gc.bigPackThreshold config
>  - gc: add --keep-largest-pack option
>  - repack: add --keep-pack option
>  - t7700: have closing quote of a test at the beginning of line
>
>  "git gc" in a large repository takes a lot of time as it considers
>  to repack all objects into one pack by default.  The command has
>  been taught to pretend as if the largest existing packfile is
>  marked with ".keep" so that it is left untouched while objects in
>  other packs and loose ones are repacked.
>
>  What's the doneness of this thing?  The interdiff since the earlier
>  one looked reasonable, but I didn't see this round otherwise
>  scrutinized by reviewers.

As noted in 878t9pfu4f.fsf@evledraar.gmail.com I've been running both of
these in production without issues, and in combination they really
improve performance on big repositories (especially
nd/repack-keep-pack).

I've given them a really close look and am happy to see them merged
down, although some bits of nd/pack-objects-pack-struct are way over my
head, but Peff has looked at them more closely, and seemed happy-ish
with it once the arbitrary limits present in previous rounds went away.

> * pw/add-p-select (2018-03-16) 3 commits
>  - add -p: optimize line selection for short hunks
>  - add -p: allow line selection to be inverted
>  - add -p: select individual hunk lines
>
>  "git add -p" interactive interface learned to let users choose
>  individual added/removed lines to be used in the operation, instead
>  of accepting or rejecting a whole hunk.
>
>  Expecting a reroll to reignite the discussion.
>  cf. <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>
>
>
> * ds/commit-graph (2018-04-11) 16 commits
>   (merged to 'next' on 2018-04-25 at 18af3d28d9)
>  + commit-graph: implement "--append" option
>  + commit-graph: build graph from starting commits
>  + commit-graph: read only from specific pack-indexes
>  + commit: integrate commit graph with commit parsing
>  + commit-graph: close under reachability
>  + commit-graph: add core.commitGraph setting
>  + commit-graph: implement git commit-graph read
>  + commit-graph: implement git-commit-graph write
>  + commit-graph: implement write_commit_graph()
>  + commit-graph: create git-commit-graph builtin
>  + graph: add commit graph design document
>  + commit-graph: add format document
>  + csum-file: refactor finalize_hashfile() method
>  + csum-file: rename hashclose() to finalize_hashfile()
>  + Merge branch 'jk/cached-commit-buffer' into HEAD
>  + Merge branch 'jt/binsearch-with-fanout' into HEAD
>  (this branch is used by ds/generation-numbers and ds/lazy-load-trees.)
>
>  Precompute and store information necessary for ancestry traversal
>  in a separate file to optimize graph walking.
>
>  Will merge to 'master'.

Great that this & ds/lazy-load-trees is finally landing, so we can focus
on the subsequent integration bits (git-gc, using it in --contains etc.)

> * bw/protocol-v2 (2018-03-15) 35 commits
>   (merged to 'next' on 2018-04-11 at 23ee234a2c)
>  + remote-curl: don't request v2 when pushing
>  + remote-curl: implement stateless-connect command
>  + http: eliminate "# service" line when using protocol v2
>  + http: don't always add Git-Protocol header
>  + http: allow providing extra headers for http requests
>  + remote-curl: store the protocol version the server responded with
>  + remote-curl: create copy of the service name
>  + pkt-line: add packet_buf_write_len function
>  + transport-helper: introduce stateless-connect
>  + transport-helper: refactor process_connect_service
>  + transport-helper: remove name parameter
>  + connect: don't request v2 when pushing
>  + connect: refactor git_connect to only get the protocol version once
>  + fetch-pack: support shallow requests
>  + fetch-pack: perform a fetch using v2
>  + upload-pack: introduce fetch server command
>  + push: pass ref prefixes when pushing
>  + fetch: pass ref prefixes when fetching
>  + ls-remote: pass ref prefixes when requesting a remote's refs
>  + transport: convert transport_get_remote_refs to take a list of ref prefixes
>  + transport: convert get_refs_list to take a list of ref prefixes
>  + connect: request remote refs using v2
>  + ls-refs: introduce ls-refs server command
>  + serve: introduce git-serve
>  + test-pkt-line: introduce a packet-line test helper
>  + protocol: introduce enum protocol_version value protocol_v2
>  + transport: store protocol version
>  + connect: discover protocol version outside of get_remote_heads
>  + connect: convert get_remote_heads to use struct packet_reader
>  + transport: use get_refs_via_connect to get refs
>  + upload-pack: factor out processing lines
>  + upload-pack: convert to a builtin
>  + pkt-line: add delim packet support
>  + pkt-line: allow peeking a packet line without consuming it
>  + pkt-line: introduce packet_read_with_status
>  (this branch is used by bw/server-options.)
>
>  The beginning of the next-gen transfer protocol.
>
>  Will cook in 'next'.

With a month & 10 days of no updates & this looking stable it would be
great to have it in master sooner than later to build on top of it in
the 2.18 window.
