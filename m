Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D9C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 19:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386402071C
	for <git@archiver.kernel.org>; Sun,  3 May 2020 19:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YskEepCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgECTmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 15:42:07 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:33707 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728843AbgECTmG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 15:42:06 -0400
Received: from mxback12o.mail.yandex.net (mxback12o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::63])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id B96D21E8015F;
        Sun,  3 May 2020 22:42:02 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback12o.mail.yandex.net (mxback/Yandex) with ESMTP id qT7g2DA46g-g1jSLEbO;
        Sun, 03 May 2020 22:42:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1588534922;
        bh=lVJPqjzQvyQ3Me9qyI0b7+Q+h8JTnZmRslsdksoP574=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=YskEepCt1NnwORwPQwAnSX+Fr5cwTfn0y4dcx2UmwKWruLgLFZ6REIDbjJQeC3N5V
         x9B7Q6Y3CDUQFyNXJ4U4KnM2YvC+P/SJZSA0vDdU1lhd0zLW1zLR5hps6/oHRhNba9
         +WZSxbZnSepvdrHRKsapWMry0R3sC/ZdW0r153DA=
Authentication-Results: mxback12o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-4e96f110c519.qloud-c.yandex.net with HTTP;
        Sun, 03 May 2020 22:42:01 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <xmqqsgghhr32.fsf@gitster.c.googlers.com>
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
        <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com> <xmqqsgghhr32.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH 0/8] CMake build system for git
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 03 May 2020 22:42:01 +0300
Message-Id: <689741588534833@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



03.05.2020, 20:21, "Junio C Hamano" <gitster@pobox.com>:
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
>>>  As you say, an extra instruction in INSTALL file to tell users to
>>>  copy from contrib/cmake may workable, though it is unsatisfactory.
>>>  But the other one will not simply work. If we need to have a new
>>>  file with string "CMake" in its name at the top-level *anyway*, we
>>>  should have the real thing to reduce one step from those who want to
>>>  use it. Those who do not want to see "CMake" at the toplevel are
>>>  already harmed either way, if is a dummy or if it is the real thing.
>>
>>  In your opinion, what would be the best way to communicate with users, there is
>>  an optional CMake build system for git?
>
> You do not want to hear my opinion, as my priorities would be
> different from yours ;-)
>
> Given that we all agreed that the only reason we contemplate use of
> CMake in our project is strictly to help Windows build, i.e. due to
> the same reason why we have contrib/buildsystems/, it is not one of
> my goals to communicate with general users about optional CMake
> support in the first place. It has lower priority than keeping the
> project tree and the project history less cluttered.
>
> So my first preference would be an instruction somewhere in install
> or readme that tells those who want to build for windows to copy
> from (or perhaps update cmake to offer the "-f" option and tell it
> to read from) contrib/cmake/CMakeLists.txt to the toplevel before
> doing anything [*1*].

FWIW, CMakeLists.txt doesn't have to be in the root of source tree in
order to work. It can perfectly work from contrib/cmake after necessary
changes in relative paths.

>
> If there are many people who want to help the cmake effort, however,
> shipping a real CMakeLists.txt at the top-level of the tree, with
> all the instructions at the beginning of *that* file, would be an
> easier way for them to discover and polish. It would also be my
> preference but only under the "if there are many people" condition.
>
> Thanks.
>
> [Footnote]
>
> *1* It probably is too error prone to tell people who do the real
>     work to "copy", as they are prone to modify the copy and forget
>     updating the source. So the instruction may tell them to create
>     a symlink at the toplevel that points to the real file in the
>     contrib/cmake/ directory, or if the filesystem does not support
>     symbolic links (which is very likely given the target audience
>     of this are all on Windows), tell them copy a small skeleton
>     file that is also shipped in contrib/cmake/ directory to the
>     top-level. That skeleton file would "include" the real thing
>     that lives in contrib/cmake/ directory (I am assuming that
>     CMakeLists.txt can include other CMakeLists.txt file here).

-- 
Regards,
Konstantin

