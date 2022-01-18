Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8ABC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 20:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349098AbiARUPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:15:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51964 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiARUPx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 15:15:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DD5D101136;
        Tue, 18 Jan 2022 15:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9BLUtdNd2XGw
        Qji6ZgoyO3V8lL81ze0yxeT5SHZGR9Q=; b=NFF+s+jilBjCG7OF9GNDRRREljw8
        xwREzmRMZpbG3pqCdtm7a0gM1+pV23AXnkeRdJ6Fol/jJ7flj9GbIZUE97O8v2j/
        Kq2iO+DS9+AoHxicIqlUeojU4+C7i8sFoIe5YM14HeG7p96qJ0k0CZxYgpR4sZUr
        uFzFeMIm9yVdL0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21F9C101135;
        Tue, 18 Jan 2022 15:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81B05101134;
        Tue, 18 Jan 2022 15:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
        <220118.86iluhoyio.gmgdl@evledraar.gmail.com>
Date:   Tue, 18 Jan 2022 12:15:50 -0800
In-Reply-To: <220118.86iluhoyio.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 18 Jan 2022 16:17:02 +0100")
Message-ID: <xmqqh7a0ssuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6EC7FE14-789B-11EC-8E6C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'd like to have it too, but for context needing to add NO_UNCOMPRESS2=3D=
Y
> (which Junio's punted on for the final[2]) is a much more widespread
> issue of needing new post-install build tweaking than this issue that
> only affects developer builds on FreeBSD.

I hate it when people misrepresent what I said, even in an attempt
to spite me.  For the "check ZLIB_VERSION_NUM" topic, I gave you
specific things that needs to be different from the version posted
with reasons, fully expecting that a better version of the patch to
materialize soon (knowing how proliferate you can be when you want
to) to give us enough time to assess the potential damage.

I wouldn't call that "punted".

For this one, config.mak.dev patch WOULD only affect developer
builds, which is a much better solution than overriding what their
system headers want to do and force compiling with C99 mode.  With
the status quo with today's code, with or without the patch Dscho
wants in this thread, means ANYBODY will be stopped when they
attempt to build with -std=3Dgnu99 on FreeBSD, which is a GOOD thing.

The reason why it is a much better solution to PUNT on using C99
mode on FreeBSD is because this episode makes it very clear that
nobody tested building anything that use basename(), dirname(),
etc. with C99 mode on the platform.  I do not trust such a build,
even if we could work around the system header breakage.

This time we got lucky and wereq stopped by a compilation error, but
I have a strong suspicion that C99-only mode of compiler on this
platform is not as well battle tested as their standard mode of
compilation that allows C11.  I simply do not think we want to waste
developer's time with C99-only mode on this platform which may end
up debugging the platform and not our program.  Next bug that will
hit us may not be so friendly to clearly break compilation.
Instead, the symptom may be a subtle runtime breakage that wastes
people's time.

After developers who work on FreeBSD (not Git developers who uses
FreeBSD) ships an updated system headers so that more programs, not
just us, are built and testsd with C99-only mode, perhaps it becomes
usable as a platform to catch use of language features beyond C99,
like everybody else.  But with such a clearly broken system headers,
I do not think today's FreeBSD is ready for that.  I do trust their
default settings that allows C11, a lot more than C99-only
compilation with the "their libgen is broken, so here is a user side
workaround" patch.

