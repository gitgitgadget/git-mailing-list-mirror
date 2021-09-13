Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CCC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF17610E6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbhIMUgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:36:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52224 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbhIMUgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 16:36:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73871D589D;
        Mon, 13 Sep 2021 16:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=843rSwQVqbGtafsJb6nJ86THbebGPErBbBuRWc
        EvwTs=; b=J0zZX3c57oOYVprcAvrbHAb5MWGl/tHjCE5jCMo0Es7sIRhw6qU7m6
        xFHCA/kb2LPncufxEt5ikcbJsqP2Ite0NC0o7PcQDNDRwqB9zZ9/VmuM+6V+GGEN
        OokOvrqLQ6+0uZ5ZGQ66Jo5fLVzwbMVHQF3W8M/CaVPMPf+QelmEY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68475D589C;
        Mon, 13 Sep 2021 16:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7C83D5899;
        Mon, 13 Sep 2021 16:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/19] Adds reftable library code from
 https://github.com/hanwen/reftable.
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <xmqq7dfpxzfw.fsf@gitster.g>
        <CAFQ2z_Pa+KmCYV224XwMXO1iFCNA=PXj5iKaQU3LYGYTK_+qsw@mail.gmail.com>
        <xmqqee9sfhuu.fsf@gitster.g>
        <CAPUEsphPvtXymQWExXqJqn6U1TiWx=u483oNODPZuL5pRubveg@mail.gmail.com>
Date:   Mon, 13 Sep 2021 13:34:56 -0700
In-Reply-To: <CAPUEsphPvtXymQWExXqJqn6U1TiWx=u483oNODPZuL5pRubveg@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 13 Sep 2021 12:29:25 -0700")
Message-ID: <xmqqtuiodxjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F0AA580-14D2-11EC-85B0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Sep 13, 2021 at 11:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Han-Wen Nienhuys <hanwen@google.com> writes:
>> > The code has a different style because I wrote it separately from Git.
>> > I'm not wedded to its current style, and most styling can easily be
>> > changed. If you have specific things that should be addressed, let me
>> > know.
>>
>> The question was for other reviewers to help us come up with what
>> the "specific things" ought to be.  I saw style differences around
>> comments and code formatting (everything I listed in the footnote,
>> plus, // comment which I forgot to mention) which may or may not
>> turn out to be part of that "specific things", because they do not
>> break compilation.
>
> they will be flagged by the compiler in pedantic mode when in gnu89 mode though
>
>   reftable/stack_test.c:49:1: warning: C++ style comments are not
> allowed in ISO C
> 90
>      49 | // Work linenumber into the tempdir, so we can see which
> tests forget to
>         | ^
>   reftable/stack_test.c:49:1: note: (this will be reported only once
> per input file)
>
> and are probably an easy thing to fix

I guess I still wasn't clear enough, then.  Of course, there is no
question that we do not tolerate compilation-breaking deviation from
our coding guidelines.  The "loosening" exception I was alluding to
were those rules that do not break compilation but help human readers
due to consistent writing.  I do not think

    /* this comment
     * goes against our house style */
    int* a, b;

would be flagged by the gnu89 compiler, for example.

