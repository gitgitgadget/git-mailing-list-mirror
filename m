Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F647C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A12C2072E
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="djg9HNl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgISAup (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 20:50:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64678 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISAup (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 20:50:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F02567545B;
        Fri, 18 Sep 2020 20:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OwiYluYvTW3l
        wZEOraM3yUSTkFg=; b=djg9HNl7N0MbM7XenRzSAhAVFlnQoQsMUXMzVsjOul/d
        0K+/uiNXnhI5zxSJsrZFyUBshtIKhKOzdqpiZuZWB6CaITy3x2tLiuQN2r78imPU
        Mk+gFKwvk29+UtLT+gBtxwVAjyQ+JlvMODQbwrTQm7q25LIxs8Rbi2G3mWDp7M4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tgPjf3
        SlwPVN9nEFbxxoHEfMUtuNq5g7/5t+XIFecyM3iKZxA2AW6ZBqZ01A59TTvIwnTV
        LujennBr7MoxHy/DALw6LEgpTFxvvh4OhFvuWhYZqFi6Hyvch7xEziCgKRmmSI1g
        Cl88JqSJBP2V5mAGPJtsgj9bqNnH0/5R0X70c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E844375457;
        Fri, 18 Sep 2020 20:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65E5375456;
        Fri, 18 Sep 2020 20:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
        <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
        <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
        <20200918155015.GA1837@danh.dev>
        <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
        <20200919004030.GB1837@danh.dev>
Date:   Fri, 18 Sep 2020 17:50:41 -0700
In-Reply-To: <20200919004030.GB1837@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Sat, 19 Sep 2020 07:40:30 +0700")
Message-ID: <xmqq1riylhcu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24F0DD96-FA12-11EA-98E6-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> What can we do to make it easier for people to discover and follow
>> the best current practice?  Are there things in our build
>> instruction document (e.g. the comment at the top of CMakeLists.txt)
>> that needs updating?
>
> I think Sibi had done a lot of good work to write instruction at the
> top of CMakeLists.txt, I guess it's a bit too much instruction.
> The instruction for out of source build was written after the
> instruction to build in-tree.
>
> Should we change the order?  I don't really know.

Oh, absolutely. =20

It begins with

    cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=3DRelease
    Eg.
    From the root of git source tree
            `cmake contrib/buildsystems/ `
    This will build the git binaries at the root

which tells exactly what Dscho did and got him writing the patch in
question.  You'd need to keep reading to be merely _aware_ that it
is possible to do an out-of-tree build, without getting even told
that it is the norm in CMake land.

We should just remove the above and start the comment seciton with
something more like this:

    When using CMake, building in place is highly discouraged.
    Instead, create a new "git-build" directory and perform your
    build there, like this (from the top of the working tree):

            $ mkdir git-build
            $ cd git-build
            $ cmake ../contrib/buildsystems/ -DCMAKE_BUILD_TYPER=3DReleas=
e

    This will build the git binaries in git-build directory

Doing so would reduce the number of choices the user has to make,
and reduce the confusion.

Thanks.
