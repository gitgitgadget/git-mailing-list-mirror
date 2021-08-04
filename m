Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB0C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4920C60F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhHDR5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:57:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54868 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhHDR5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:57:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B39F4E1961;
        Wed,  4 Aug 2021 13:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uvq+zBIS+IeA
        QZ87+DwVEn9RwfumfKGIftZcDmxoeMc=; b=IbuJTsxMRRtHejgKk1xYj2gbSoFz
        Pu+kqSHfgRJf/yZkZWjwtrUBbWnC2Yq9a/rKEvw5BNwPcmF1u37rQU5VzMi0XGEB
        ZGW3Gu1oDnKlAV9eR5tbEE67qiz0y3cHmIbYUB8STU7GZFyFrTvghRqG7nV4ahDy
        3xRLzlEuCDBmT5Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8B9EE1960;
        Wed,  4 Aug 2021 13:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32F79E195F;
        Wed,  4 Aug 2021 13:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
References: <xmqqfsvpr8t5.fsf@gitster.g> <87wnp1mqv2.fsf@evledraar.gmail.com>
Date:   Wed, 04 Aug 2021 10:57:19 -0700
In-Reply-To: <87wnp1mqv2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 04 Aug 2021 12:22:44 +0200")
Message-ID: <xmqq8s1hozy8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 69DEED30-F54D-11EB-B787-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/test-columns (2021-08-02) 3 commits
>>  - test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
>>  - test-lib-functions.sh: add a test_with_columns function
>>  - test-lib-functions.sh: rename test_must_fail_acceptable()
>
> We're going to need this or another solution to the v2.33.0-rc0
> regression in c49a177beca (test-lib.sh: set COLUMNS=3D80 for --verbose
> repeatability, 2021-06-29) before the final v2.33.0.

Yeah, this is ugly but not so ugly as the original version ;-)
Thanks for prodding.

>> * ab/lib-subtest (2021-07-21) 10 commits
>> * ab/only-single-progress-at-once (2021-07-23) 8 commits
>
> Thanks, it would be great to have both of these move soon after the
> release. I think the chances of unexpected breakage here are minimal
> given their nature.

Have they seen enough eyeballs already to gain support?

>> * ab/progress-users-adjust-counters (2021-07-23) 3 commits
> ...
> I think that what SZEDER had to say in
> https://lore.kernel.org/git/20210802220506.GF23408@szeder.dev/ should b=
e
> enough to clear this to proceed forward.

OK, thanks.

>> * ab/make-tags-cleanup (2021-07-22) 5 commits
> ...
>     As long as we have no user of a -q flag ever, what's the point of
>     forever carrying the "rm foo*" when we know it's foo.out, just
>     because a future Makefile change might add foo.blah?

That is not a forward-looking thinking.  A cheap and easy way to
future-proof was suggested by a reviewer.  Why ignore repeated
suggestions?

>> * ab/serve-cleanup (2021-08-03) 13 commits
>>  - fixup! {upload,receive}-pack tests: add --advertise-refs tests
>>  - serve.[ch]: don't pass "struct strvec *keys" to commands
>>  - upload-pack.c: convert to new serve.c "startup" config cb
>>  - upload-pack: document and rename --advertise-refs
>>  - {upload,receive}-pack tests: add --advertise-refs tests
>>  - serve.[ch]: remove "serve_options", split up --advertise-refs code
>>  - serve.c: move version line to advertise_capabilities()
>>  - serve: add support for a "startup" git_config() callback
>>  - serve.c: add call_{advertise,command}() indirection
>>  - serve: use designated initializers
>>  - transport: use designated initializers
>>  - transport: rename "fetch" in transport_vtable to "fetch_refs"
>>  - serve: mark has_capability() as static
>>
>>  Code clean-up around "git serve".
>
> It seems the reception to the "config callback" part of this was rather
> lukewarm. I'll re-roll to eject those changes and see if it's better
> received.

I'll eject this topic and other "will reroll" topics until the
final, with the hope to restart post release, then.  Our focus ought
to be to stabilize the upcoming release and having more topics or
topics that won't be near 'next' updated adds to distraction.

Thanks.
