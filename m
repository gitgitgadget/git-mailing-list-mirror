Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE0EC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3060D2100A
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFA68giu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRQVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:21:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62899 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRQVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:21:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7ADB71564;
        Fri, 18 Sep 2020 12:21:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jx8UH7oU6fBg
        MCW0RRFVVGjsxxg=; b=nFA68giuN/c7VIHcTKhKIMkWEXwpPfwoRql+Vr/CU4x5
        Zn2qnI0bdS+K4nXxdXFq/SmztoP0QYfyqwcrrcL8d1uI8tB6+OHP3T3LICdeQipe
        w6zyvokcyuHzfx9D8C45409ixFUrWi4uXGOtOAYd/NZqbvV1FhA8170wd+p6ZSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=B//cK2
        2S3jC9GpFSPyhboGXjvUVej4eSkGIW73m4goIJWnyWFeY06Ljo2I72SUoySdX0VX
        juUK63cvTTYs9xIrpJX1/Lwr8xBh9i3TB44mIovQqmt8frzqAEivVe/W+8bRuPbK
        vRE+tpYK2r417qyecrJIXcBj2TFG4dVlR9xjM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F5A571563;
        Fri, 18 Sep 2020 12:21:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2511371561;
        Fri, 18 Sep 2020 12:21:46 -0400 (EDT)
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
Date:   Fri, 18 Sep 2020 09:21:45 -0700
In-Reply-To: <20200918155015.GA1837@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Fri, 18 Sep 2020 22:50:15 +0700")
Message-ID: <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0BE9377C-F9CB-11EA-8F0D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Actually, in CMake land, people usually do this instead:
>
> 	mkdir build
> 	cmake [-Ggenerator] ..
> 	<make/ninja/msbuild>

I presume you "cd build" between steps 1 & 2?  I take the "people
usually do" is the best current practice?

> Then, when they want to run something equivalent with make distclean,
> they run:
>
> 	cd ..
> 	rm -rf build
>
> instead.
>
> The change that Dscho suggested was meant for those people that run
> CMake in same directory of source dir, which is mostly discouraged
> in CMake land.
>
> In additional, CMake's default Generator in *nix is Unix Makefiles,
> which will clash with our Makefile, and totally unsupported.

I recall that our CMakeLists file asks the top-level Makefile about
basic things so that we do not have to duplicate "list of files"
etc.  in places, so I can understand that it would lead to a
disaster to do "cmake -Ggenerator" at the top-level.

> I think the original CMake proposal didn't touch .gitignore because
> they run in a separated build-dir.

If so, not only my "do we need a matching change to CMakeLists to
teach how to clean crufts?" becomes unnecessary, but the original
patch that started this thread to touch .gitignore at the top level,
does, too.

I wonder what led Dscho not to follow the "create a 'build' dir and
do things there" practice.  Judging from the fact that the "because
they run in a separate build directory" assumption did not hold to
somebody as experienced as Dscho, it is likely others would do the
same.

What can we do to make it easier for people to discover and follow
the best current practice?  Are there things in our build
instruction document (e.g. the comment at the top of CMakeLists.txt)
that needs updating?

Thanks.
