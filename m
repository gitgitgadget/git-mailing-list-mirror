Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BBC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbiEZRYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiEZRYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:24:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B222BD9
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:24:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC1C619243C;
        Thu, 26 May 2022 13:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Rcc1XfFxv19t
        dfTL6Fhu5cgYn1Rj7aUhK8xhGqdZPmQ=; b=MN08HwkHxLQA0KXC+shmPH9ws6wm
        TemCIUVuuUkf5rPpLDUbt2wPsKlq1NMZ2xlTvrmDVxYUCsWpcWoFdr/NtP8LoqcI
        ZQgtIdgz2ryN9M1Cs4eBzwaeaa91Lztzw4UuBiHULPSn7/xSL/Q8hJzDFxNGKHHI
        zAQZiJRSd5udsvM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E482D19243A;
        Thu, 26 May 2022 13:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F3A9192438;
        Thu, 26 May 2022 13:24:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
References: <xmqqzgj41ya2.fsf@gitster.g>
        <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com>
Date:   Thu, 26 May 2022 10:23:59 -0700
In-Reply-To: <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com> (Victoria Dye's
        message of "Thu, 26 May 2022 09:02:27 -0700")
Message-ID: <xmqq4k1c1a34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A1DA3074-DD18-11EC-ACDF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> * js/ci-github-workflow-markup (2022-05-21) 12 commits
>>  - ci: call `finalize_test_case_output` a little later
>>  - ci(github): mention where the full logs can be found
>>  - ci: use `--github-workflow-markup` in the GitHub workflow
>>  - ci(github): avoid printing test case preamble twice
>>  - ci(github): skip the logs of the successful test cases
>>  - ci: optionally mark up output in the GitHub workflow
>>  - ci/run-build-and-tests: add some structure to the GitHub workflow o=
utput
>>  - ci: make it easier to find failed tests' logs in the GitHub workflo=
w
>>  - ci/run-build-and-tests: take a more high-level view
>>  - test(junit): avoid line feeds in XML attributes
>>  - tests: refactor --write-junit-xml code
>>  - ci: fix code style
>>=20
>>  Update the GitHub workflow support to make it quicker to get to the
>>  failing test.
>>=20
>>  Will merge to 'next'?
>>  source: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
>
> The latest version of this nicely addressed the feedback I originally h=
ad,
> particularly in improving page loading time. It's still slower than bef=
ore
> this series, but IMO it's manageable (especially taking into account th=
e
> improved information accessibility).=20
>
> I don't see (or have) any other unaddressed concerns, so I'm in favor o=
f
> moving it to 'next'.

I see =C3=86var sent another reroll of "rebuild the base" and "then
rebase a (hopefully) equivalent of this series on top", but I think
it is unhealthy to keep doing that.  Does the latest "rebuild the
base" part look unsalvageably and fundamentally bad that it is not
worth our time to consider joining forces to polish it sufficiently
and then build this on top?

If that is the case, then I am OK to merge this to 'next' to cast it
in stone, and then the let "rebuild the base" part once die, to be
reborn as many "tweak the way things work to (clarify|optimize) X"
follow-up topics.

Thanks.
