Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2308C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 06:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE620721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 06:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L2g3Mp/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEEGQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 02:16:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52744 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEGQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 02:16:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56FBCDFCF5;
        Tue,  5 May 2020 02:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/7IuQ5O2pCqCYqLDYEAHQl4Akpw=; b=L2g3Mp
        /xMGZjr1mlNcrsQZxoB1iDNy6s7mnvF4DkIBDul5o9J9355mJnkWHJg99jksdkR3
        Vkkxb8embCZ9h+FZHOkwcJp19svAsH3SU2mkr8LxPddPhZie6oHZGDCdSiKHGfxf
        ihPGYnSHPxPRzWP9i6jR/WTK3VwfwNOA1eQmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FsQw49lE0/PcQ8GkttGVzfVdAB50V+Mb
        09p/4EeLG4KxQ+IFckCnhjApkj5Ql03ewElhcQAsXLSiLa3VvRHUioD/iRx5rvQW
        5PnsVG9i+CW2ei3CXs/fE04pUgIwUCOfhyM3s/y3SlbtqItVn7Q3xOZ1XTSTEr9W
        wTWy3H4y0UI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EE41DFCF4;
        Tue,  5 May 2020 02:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94C40DFCF3;
        Tue,  5 May 2020 02:16:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
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
        <xmqqsgghhr32.fsf@gitster.c.googlers.com>
        <689741588534833@mail.yandex.ru>
        <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
        <848941588629532@mail.yandex.ru>
        <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com>
Date:   Mon, 04 May 2020 23:16:43 -0700
In-Reply-To: <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com>
        (Sibi Siddharthan's message of "Tue, 5 May 2020 09:46:09 +0530")
Message-ID: <xmqqwo5qc3ec.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEEAF7AC-8E97-11EA-8FA2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> Yes, this is trivial, but doing so is bad practice in general and
> difficult to maintain.

Can you substantiate "bad" and "difficult" in the above sentence?

They are so subjective words and sounds more of your "opinion" than
generally accepted "fact".

> Won't it be better just to copy the CMakeLists.txt to the root
> directory for configuring.

I do not know it is better or not compared to using directly from a
subdirectory.  But it is easy to see that it is a bad practice to
keep the source of truth in contrib/cmake/CMakeLists.txt and use it
by copying it to the top of the working tree.  

The reason would be obvious once you imagine what happens when those
who are helping to improve CMake support find that they need to make
changes.  It is too easy to edit the one they copied to the top of
the working tree until they manage to get it working, and then
forget to copy it back to contrib/cmake/ before committing the
change [*1*].

Compared to that, the way Konstantin showed, which is just to be at
the top of the working tree and run the cmake command with a single
argument, which is the path to the CMakeList.txt file, looked quite
simple and straight-forward to an untrained eye that hsan't seen a
real use of CMake.  But there must be reasons, coming from lessons
learned by using CMake with a CMakeList.txt file in a subdirectory
and suffering the consequences of doing so, that makes you say it is
a bad practice and difficult to maintain.  It needs to be spelled
out to help those who do not know CMake understand.

Thanks.


[Footnote]

*1* Creating a symlink CMakeLists.txt at the top of the working tree
that points into contrib/cmake/CMakeLists.txt (and it needs to be
done only once) would avoid such a problem, but if your filesystem
does not let you use a symlink, copying a skeletal CMakeLists.txt
that nobody is expected to modify to the top of the working tree
might be an acceptable workaround.  The sole purpose of that
skeletal CMakeLists.txt at the top of the working tree would be to
include the "real" thing in contrib/cmake/ directory (I am assuming
that CMake is capable of including a CMakeLists.txt file that exists
elsewhere in another CMakeLists.txt file).

With either of these arrangements, it is much less likely for the
user to accidentally edit a "wrong" copy and forgets to update the
real thing---the real thing stored in contrib/cmake will be the only
one that would be edited.
