Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE3C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82258613FD
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhDTWQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:16:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61869 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhDTWQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:16:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCAF8B9BF2;
        Tue, 20 Apr 2021 18:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PWZ/5I6VJKKn
        0lpqYAb446XwgZQ=; b=XIrvK4VpwXN2YinUJ7qM5We0R6NxcsEofmUYDE2wX/rI
        nuyIN4xT3E+q8oLf0r01TkwIfddVBIg2a6ULaO3m+eWNnfeqNIPi1YLxJwXN3V17
        RWF1srZfuILtd/HG/g3DXUS5SJK1sNAgiRJ7JzKiVKyMK7MpO0zFgKoy3Yqs20o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fksLha
        u3CIZWf7AdXhzAKs2OMj7a4NMHmzlVEExOgNkDYyLrP48Ia6qqEaW/UtwIgO0qyX
        8xMS+Ua8kuxIuclJWzgr88gjbqVYAAj+6hfa8ohmGUvIjV1Vm4/q4F9GO0mrS4bC
        ZzMO7cw+1xE7QJSBSkZ4MkFmxNOYMtQ3ZB6eI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE9E1B9BF1;
        Tue, 20 Apr 2021 18:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1807AB9BF0;
        Tue, 20 Apr 2021 18:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
References: <xmqqtuo17t6t.fsf@gitster.g> <87mttt2hcu.fsf@evledraar.gmail.com>
Date:   Tue, 20 Apr 2021 15:15:33 -0700
In-Reply-To: <87mttt2hcu.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 20 Apr 2021 15:52:33 +0200")
Message-ID: <xmqq1rb44n7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED275B3A-A225-11EB-B305-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/describe-tests-fix (2021-04-12) 5 commits
>> ...
>>  (this branch uses ab/test-lib-updates.)
>> * ab/pickaxe-pcre2 (2021-04-12) 22 commits
>> ...
>>  (this branch uses ab/test-lib-updates.)
>> * ab/test-lib-updates (2021-04-12) 16 commits
>> ...
>>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>>
>>  Test clean-up.
>>
>>  Waiting for review discussion to conclude.
>
> I think with my re-roll today at
> https://lore.kernel.org/git/cover-00.12-0000000000-20210420T121833Z-ava=
rab@gmail.com/
> there's no further outstanding issues.

OK, let's hope this to be the final version that is stable enough
for others to build on.

Thanks.
