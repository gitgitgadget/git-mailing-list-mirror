Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC7C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E52560F9E
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHBQRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:17:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58921 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhHBQRD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:17:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B872BCFC5F;
        Mon,  2 Aug 2021 12:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GT4PW3XjLHvN
        Z0q64lo8FeNs/XsFibghnWyBaeTuFko=; b=erkbl4NE9T/myuMZ0tH2aXwSJZ0W
        J7m45HsXavMrUbpc6keX+FzJ8D9Wavme3u0Z4IAGyNQZAjToj2/q75lPMXok+x20
        +UEbZxYbt6CetkTQIvCaHPUszq6Z7e0lmYbv97l6mgLW94vcQNa5gfe0aWeHWrCQ
        i6jOuSZYTDrzsG4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF2D8CFC5D;
        Mon,  2 Aug 2021 12:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28157CFC5C;
        Mon,  2 Aug 2021 12:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Aug 2021, #01; Sun, 1)
References: <xmqqk0l4xuvo.fsf@gitster.g> <87wnp4p4xo.fsf@evledraar.gmail.com>
Date:   Mon, 02 Aug 2021 09:16:52 -0700
In-Reply-To: <87wnp4p4xo.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 02 Aug 2021 11:04:20 +0200")
Message-ID: <xmqq5ywnyg7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0CA358A0-F3AD-11EB-A52E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/progress-users-adjust-counters (2021-07-23) 3 commits
>>  - entry: show finer-grained counter in "Filtering content" progress l=
ine
>>  - midx: don't provide a total for QSORT() progress
>>  - commit-graph: fix bogus counter in "Scanning merged commits" progre=
ss line
>>
>>  The code to show progress indicator in a few codepaths did not
>>  cover between 0-100%, which has been corrected.
>>
>>  Will merge to 'next'.
>
> Still marked for "next", last time around (in
> https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/) I
> asked:
>
>     Thanks. Do you think a re-roll is needed for what you mentioned in
>     https://lore.kernel.org/git/xmqqbl6slmer.fsf@gitster.g/?
>
> I'll assume a "no" as far as me doing a re-roll, but in case you just
> didn't see that...

I did ask a question at the end of that message about what would
happen when !ce and checkout is skipped (hence not counted in the
progress), and do not think it was answered.  If it is not an issue,
then no reroll is needed, but it may need to be explained why
skipping is OK.

Let me mark it as "Waiting for a clarification." for now.  I won't
be working on 'next' promotion today, so I can wait for timezone
difference ;-)  Thanks for reminding me.

>> * ab/bundle-tests (2021-07-22) 2 commits
>>   (merged to 'next' on 2021-07-22 at 053b5d0ecf)
>>  + bundle tests: use test_cmp instead of grep
>>  + bundle tests: use ">file" not ": >file"
>>
>>  "git bundle" gained more test coverage.
>>
>>  Will merge to 'master'.
>
> Thanks!
>
>> * ab/refs-files-cleanup (2021-07-26) 11 commits
>>  ...
>>  Waiting for a reroll.
>>  Patches are mostly good, but needs typofixes etc.
>
> In the last WC this had a "Will merge to 'next'", I think the typofixes
> etc. note is obsolute for 1-2 iterations now, latest one at:
> https://lore.kernel.org/git/cover-00.11-0000000000-20210726T234237Z-ava=
rab@gmail.com

OK, I took a quick glance at "range-diff @{$n}..." for n=3D=3D1 and n=3D=3D=
2
on the branch and didn't see any and assumed that the comment was
still valid.  I'll find time to revisit the list archive sometime
today.

>> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>> ...
> As noted in
> https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/ let's
> take Taylor's https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/
> as that Ack (he was also CC'd on my reply to the last WC...)>

Thanks.

>> * ab/make-tags-cleanup (2021-07-22) 5 commits
>>  - Makefile: normalize clobbering & xargs for tags targets
>>  - Makefile: the "cscope" target always creates a "cscope.out"
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
> Per my note in reply to the last WC I think it's fine as-is:
> https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/

I thought <https://lore.kernel.org/git/YPmxsCatUIByQnig@nand.local/#t>
gave us the good stopping point for the patch [4/5].

>> * ab/config-based-hooks-base (2021-06-29) 33 commits
> ...
>>  Waiting for reviews.
>
> I'll re-roll this one as promised in
> https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/; didn't
> get to it.

OK, thanks.  This can wait if you have other things to clean up or
review, but with this message I think you've cleared a lot of them
;-)

>> * ab/serve-cleanup (2021-06-28) 8 commits
>...
>>  cf. <87tul24iw2.fsf@evledraar.gmail.com>
>
> As noted in my notes on the last WC these have both been addressed in a
> re-roll.

It seems that I am missing the v3 that was sent on 07-21.  Will take
a look.

Thanks.
