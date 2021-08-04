Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C900C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F9D60F0F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 18:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHDSHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:07:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54117 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhHDSHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 14:07:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15AC7DE734;
        Wed,  4 Aug 2021 14:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8y8nhtZa91Sl
        XSOcjNiqYC573L/nqpR2w2HwY46YIc4=; b=ru/0of22zHNy0+SQWaFEdvRHaqEM
        fWZsvZGSgF4DR6XiuUIBEuKU3n0z/UiaSQwBuMWBH/C+jeT1W33NkmxWGG4iOIRd
        q25Pc6WWJzrILhrbJp05PyClEoGCSghsQ93dfZGduJW3RZbOtZLfpeCeqwjMhYxO
        bvz0Ha4ycSENzRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C844DE733;
        Wed,  4 Aug 2021 14:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AA61DE732;
        Wed,  4 Aug 2021 14:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
References: <xmqqfsvpr8t5.fsf@gitster.g> <87wnp1mqv2.fsf@evledraar.gmail.com>
Date:   Wed, 04 Aug 2021 11:06:56 -0700
In-Reply-To: <87wnp1mqv2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 04 Aug 2021 12:22:44 +0200")
Message-ID: <xmqq4kc5ozi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1F40CF2-F54E-11EB-B0D6-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
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

Just a question.  Is that true?  Wouldn't a system that needs these
on top of c49a177beca already break the tests without c49a177beca?

IOW, is c49a177beca truly a "regression", or is it merely "a half
solution that solves for most but not all platforms"?
