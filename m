Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD19C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9320897
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 15:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ffrJaAKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWP7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:59:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57982 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWP7k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 11:59:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53938839DF;
        Wed, 23 Sep 2020 11:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qllc8tqT0cG01YpQlRLg2zBMi/Y=; b=ffrJaA
        KzH31H2UDaUiU3VePMV58ouMce8GlhvFsfkrgJ7Q+KLfPkACapcH7+5g5dRGb0GN
        hK4x757mLsF8t2ToGAjc3XOhtpvJIaLG7NE5Vdu1mNAQ4hOannuynilKSWa1RATV
        oaBX4wTV+X/Fx7CcK1su2AGMGZ+DxIs3R2FVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ydCwZvfNvl20T1kXpOtHJUszMXAl3o/F
        6ng5o1nY1VbNvjamU7wrUaKV1CBPkPWIP3VQhMCmzutZ5fXp5ec6lpI39EuNc21P
        LsJl5fPZB8r6qiSFDT0dd8PqcKnLw3SrWlEIOSAUPNhCKCIXyS5w0ui1Fwk36o+z
        qRp31ClDjkE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A47F839DE;
        Wed, 23 Sep 2020 11:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9F5D839DD;
        Wed, 23 Sep 2020 11:59:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
        <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
        <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
        <20200918155015.GA1837@danh.dev>
        <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet>
Date:   Wed, 23 Sep 2020 08:59:32 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sun, 20 Sep 2020 19:37:41 +0200
        (CEST)")
Message-ID: <xmqqr1qsjxgb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5CE5A3A-FDB5-11EA-88A1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > The change that Dscho suggested was meant for those people that run
>> > CMake in same directory of source dir, which is mostly discouraged
>> > in CMake land.
>
> It is discouraged, but not disallowed.
> ...
>> > I think the original CMake proposal didn't touch .gitignore because
>> > they run in a separated build-dir.
>>
>> If so, not only my "do we need a matching change to CMakeLists to
>> teach how to clean crufts?" becomes unnecessary, but the original
>> patch that started this thread to touch .gitignore at the top level,
>> does, too.
>>
>> I wonder what led Dscho not to follow the "create a 'build' dir and
>> do things there" practice.  Judging from the fact that the "because
>> they run in a separate build directory" assumption did not hold to
>> somebody as experienced as Dscho, it is likely others would do the
>> same.
>
> That's because Dscho does not like the separate build directory, even if
> they know that in the CMake world, it is kind of expected.

Sorry, but that does not sound like a convincing excuse because ...

> It's just that it would be super convenient for Visual Studio users to
> just generate their project files in-place. That's why I started down that
> road.
> ...
> Ideally, we would tell Visual Studio users to "just install CMake, start
> its GUI, direct it to the Git source, configure and generate". Alas, it is
> not that easy:
>
> - The `SH_EXE` is not found by default (`C:\Program Files\Git\bin\sh.exe`
>   should be used in the vast majority of the cases),
> - If the build directory is left unspecified, the non-writable `C:\Program
>   Files\CMake\bin` directory is used,
> - The `compat\vcbuild\vcpkg` system is not initialized automatically, and
>   even if the user initialized it, the dependencies (such as expat, zlib)
>   are still not found.

... if the build directory needs to be specified anyway, there don't
seem to be a big difference between telling them to create an empty
build place and use it and telling them to point at the source tree
itself, so ...

> I would like to make things easier, and forcing users to use a separate
> build directory (that needs to be outside of the Git source tree because
> our `.gitignore` does not handle it well) would go the other direction, I
> fear.

... the above sounds like the argument concentrates too much on
where the build directory is (i.e. between "in place" and "a
throw-away directory next door"), which sounds like much smaller
point compared to the other things that needs to be improved in the
VS users.  And making a choice against what is recommended as best
practice...?  I dunno.

