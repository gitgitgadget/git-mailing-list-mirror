Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 03:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9381860462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 03:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhHaDkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 23:40:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65291 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbhHaDkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 23:40:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3F28E9013;
        Mon, 30 Aug 2021 23:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=rIZf1t0OGLNicmpPkp6h4u5+U
        vMuUKRGHOfI2K7ZW4Y=; b=F2flqk/h/CsIVtCQqcbbbouz+eeCBk4L1ydDH5+R9
        Yk2MoblyEwuic8+/Tp5/+19xFPIZ0L6DRVuV7mO7/18i4mz+tNyvGTZz28N2Mfhc
        X1miG3+JC2pFVkszYRvcFMTuTNAiCZ4z930V0Zj/u51ldnfSgqY2Cl/rFDXjx3RD
        Yo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A403E9012;
        Mon, 30 Aug 2021 23:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EF58E9010;
        Mon, 30 Aug 2021 23:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
References: <xmqq35qr7mq5.fsf@gitster.g> <87tuj7xhqo.fsf@evledraar.gmail.com>
Date:   Mon, 30 Aug 2021 20:39:46 -0700
Message-ID: <xmqqeeaaz3i5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16963F3C-0A0D-11EC-9C9C-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Also re your <xmqqbl5ml70u.fsf@gitster.g> I'll switch to quoting
> Message-ID's in that style, and not as
> https://lore.kernel.org/git/<msgid> links. FWIW I was doing the latter
> for the benefit of readers on the sidelines, but will switch.

I can deal with either.  What I meant was that often resend of the
patch outside the context of "What's cooking" would be easier to
find the patches.

>> * ab/commit-graph-usage (2021-08-25) 7 commits
>>  - commit-graph: show "unexpected subcommand" error
>>  - commit-graph: show usage on "commit-graph [write|verify] garbage"
>>  - commit-graph: early exit to "usage" on !argc
>>  - multi-pack-index: refactor "goto usage" pattern
>>  - commit-graph: use parse_options_concat()
>>  - commit-graph: remove redundant handling of -h
>>  - commit-graph: define common usage with a macro
>
> Taylor, SZEDER: That's at
> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>, you
> reviwed the earlier
> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>, what do you
> think about this version?

>> * ab/unbundle-progress (2021-08-27) 5 commits
>
> This has outstanding feedback at
> <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> that I nee=
d
> to respond to.

OK.

>> * zh/cherry-pick-advice (2021-08-23) 1 commit
>>  - cherry-pick: use better advice message
>>
>>  The advice message that "git cherry-pick" gives when it asks
>>  conflicted replay of a commit to be resolved by the end user has
>>  been updated.
>>
>>  Will merge to 'next'?
>
> I think so, I looked it over as part of browsing advice()-related
> changes, looks good to me.

Thanks.

>> * es/config-based-hooks (2021-08-19) 7 commits
>>  - hook: allow out-of-repo 'git hook' invocations
>>  - hook: include hooks from the config
>>  - hook: allow running non-native hooks
>>  - hook: introduce "git hook list"
>>  - hook: allow parallel hook execution
>>  - hook: run a list of hooks instead
>>  - Merge branch 'ab/config-based-hooks-base' into es/config-based-hook=
s
>>  (this branch uses ab/config-based-hooks-base.)
>>
>>  Revamp the hooks subsystem to allow multiple of them to trigger
>>  upon the same event and control via the configuration variables.
>>
>>  Will merge to 'next'?
>>  cf. <87v93wflm0.fsf@evledraar.gmail.com>
>
> This needs a re-roll based on my comments in reply to
> <20210819033450.3382652-1-emilyshaffer@google.com>. It's mostly ready a=
s
> far as the end-state is concerneb, but e.g. will break "rebase" (a
> commit in the middle doesn't compile), leaks memory etc.
>
> It needs a re-roll of ab/config-based-hooks-base, which I was waiting o=
n
> some of Emily's feedback to do. Looks like there's no outstanding thing=
s
> there, so iwll work on that SOON.

OK, thanks.  Will mark both as expecting reroll on my end.


>> * js/advise-when-skipping-cherry-picked (2021-08-10) 2 commits
>>  - SQUASH???
>>  - sequencer: advise if skipping cherry-picked commit
>>
>>  "git rebase" by default skips changes that are equivalent to
>>  commits that are already in the history the branch is rebased onto;
>>  give messages when this happens to let the users be aware of
>>  skipped commits, and also teach them how to tell "rebase" to keep
>>  duplicated changes.
>
> This LGTM with your proposed obviously-correct squash.
>
> Re comment about ab/retire-advice-config above: I could also just fold
> this into that series if you'd prefer, i.e. it would be one way to deal
> with the only outstanding merge conflict in advice.c between
> master..seen.

Let's see how far we can go with these two as separate topics; I do
not foresee much issues in either topic and can advance them to
'next' soonish.

>> * cb/makefile-apple-clang (2021-08-06) 3 commits
>>  - build: catch clang that identifies itself as "$VENDOR clang"
>>  - build: clang version may not be followed by extra words
>>  - build: update detect-compiler for newer Xcode version
>>
>>  Build update.
>>
>>  Will merge to 'next'.
>
> Makes sense. Any reason other than lack of time that you opted not to g=
o
> for the IMO simpler approach I suggested in
> <87bl6aypke.fsf@evledraar.gmail.com>?

I just didn't see the need for this update to be so big to deserve
such a total rewrite.

>> * ab/lib-subtest (2021-08-05) 11 commits
>>  - test-lib tests: assert 1 exit code, not non-zero
>>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>>  - test-lib tests: avoid subshell for "test_cmp" for readability
>>  - test-lib tests: assert no copy/pasted mock test code
>>  - test-lib tests: get rid of copy/pasted mock test code
>>  - test-lib tests: don't provide a description for the sub-tests
>>  - test-lib tests: stop using a subshell in write_sub_test_lib_test()
>>  - test-lib tests: split up "write and run" into two functions
>>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>>
>>  Updates to the tests in t0000 to test the test framework.
>
> I think with my re-roll at
> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> it should b=
e
> OK to declare this good to go sooner than later. I.e. the only trouble =
I
> can imagine this causing in
> <patch-v3-6.9-bc79b29f3c-20210805T103237Z-avarab@gmail.com> is now easy
> to revert in isolation.

What's queued is v3, I think.  In the list of messages in the thread
on page

  https://lore.kernel.org/git/cover-v3-0.9-0000000000-20210805T103237Z-av=
arab@gmail.com/

it is still a bit disturbing to see these three versions were sent
without much reaction to the list.

>> * ab/make-tags-cleanup (2021-08-05) 5 commits
>>  - Makefile: normalize clobbering & xargs for tags targets
>>  - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
>>  - Makefile: don't use "FORCE" for tags targets
>>  - Makefile: add QUIET_GEN to "cscope" target
>>  - Makefile: move ".PHONY: cscope" near its target
>>
>>  Build clean-up for "make tags" and friends.
>>
>>  Expecting a reroll.
>>  4/5 may want a minor tweak to the log and the patch text but otherwis=
e looks good.
>
> (Summary copied from <87v93wflm0.fsf@evledraar.gmail.com>)
>
> This entire comment has been in What's Cooking since v3 of the series,
> but v4 has been out since August 4th:
> <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>

You're right.  The topic branch has the v4 but the comment in the
What's cooking report is simply stale.

>> * ab/test-tool-cache-cleanup (2021-08-24) 4 commits
>>  - read-cache perf: add a perf test for refresh_index()
>>  - test-tool: migrate read-cache-again to parse_options()
>>  - test-tool: migrate read-cache-perf to parse_options()
>>  - test-tool: split up test-tool read-cache
>>
>>  Test code shuffling.
>
> I had a "take it or leave it" comment at
> <878s0nz5q2.fsf@evledraar.gmail.com>.

Thanks, I'd eject it then.  It should be easy to send in updates
when the tree is otherwise more quiescent.
