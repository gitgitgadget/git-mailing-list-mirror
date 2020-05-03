Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F339C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E40A206A5
	for <git@archiver.kernel.org>; Sun,  3 May 2020 17:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ONrL6pjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgECRVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 13:21:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51994 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgECRVn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 13:21:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 141CCD2768;
        Sun,  3 May 2020 13:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ZWN3Bs8Ld8sOk80P6asLFmJKVM=; b=ONrL6p
        jT2OueTGL7UPx/6PcBGUx8+8InDwwuZFaTXp6fvZ6yOMLMa74pTmiVd4uNNrXZ8i
        pN6KW1x0o5LYq3oXWHAP8akwbWgC5NAIM0bLUKgJvsj1zTrx6Byhv0hDZZCoXAaJ
        Bx5mgOI6b65h2TkvmCkxoN5dYXg6ql0gUQaTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e4l4lsmb2rZt8dEN8yJN4YU1R98DWysg
        4EpC18BdHGG3dtyxAXWRug4iBblsANPONfXqoGoDerNw6COzw6nKSY2wySBqKIJR
        /jr1mDOjyHdx2RC3E73IPd91gLu1OfBCLw2WZFroCx9hc2JKj1xBHfr+l0Knk4N7
        E2ObUB4RDLA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BE58D2767;
        Sun,  3 May 2020 13:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54F37D2766;
        Sun,  3 May 2020 13:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        <xmqq8sikblv2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
        <20200427200852.GC1728884@coredump.intra.peff.net>
        <20200427201228.GD1728884@coredump.intra.peff.net>
        <20200428135222.GB31366@danh.dev>
        <20200428210750.GE4000@coredump.intra.peff.net>
        <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>
        <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
        <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
        <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
Date:   Sun, 03 May 2020 10:21:37 -0700
In-Reply-To: <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
        (Sibi Siddharthan's message of "Sun, 3 May 2020 21:03:29 +0530")
Message-ID: <xmqqsgghhr32.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C9D1940-8D62-11EA-8848-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

>> As you say, an extra instruction in INSTALL file to tell users to
>> copy from contrib/cmake may workable, though it is unsatisfactory.
>> But the other one will not simply work.  If we need to have a new
>> file with string "CMake" in its name at the top-level *anyway*, we
>> should have the real thing to reduce one step from those who want to
>> use it.  Those who do not want to see "CMake" at the toplevel are
>> already harmed either way, if is a dummy or if it is the real thing.
>
> In your opinion, what would be the best way to communicate with users, there is
> an optional CMake build system for git?

You do not want to hear my opinion, as my priorities would be
different from yours ;-)

Given that we all agreed that the only reason we contemplate use of
CMake in our project is strictly to help Windows build, i.e. due to
the same reason why we have contrib/buildsystems/, it is not one of
my goals to communicate with general users about optional CMake
support in the first place.  It has lower priority than keeping the
project tree and the project history less cluttered.

So my first preference would be an instruction somewhere in install
or readme that tells those who want to build for windows to copy
from (or perhaps update cmake to offer the "-f" option and tell it
to read from) contrib/cmake/CMakeLists.txt to the toplevel before
doing anything [*1*].

If there are many people who want to help the cmake effort, however,
shipping a real CMakeLists.txt at the top-level of the tree, with
all the instructions at the beginning of *that* file, would be an
easier way for them to discover and polish.  It would also be my
preference but only under the "if there are many people" condition.

Thanks.


[Footnote]

*1* It probably is too error prone to tell people who do the real
    work to "copy", as they are prone to modify the copy and forget
    updating the source.  So the instruction may tell them to create
    a symlink at the toplevel that points to the real file in the
    contrib/cmake/ directory, or if the filesystem does not support
    symbolic links (which is very likely given the target audience
    of this are all on Windows), tell them copy a small skeleton
    file that is also shipped in contrib/cmake/ directory to the
    top-level.  That skeleton file would "include" the real thing
    that lives in contrib/cmake/ directory (I am assuming that
    CMakeLists.txt can include other CMakeLists.txt file here).

