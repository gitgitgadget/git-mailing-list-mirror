Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE78C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3BD64F61
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhBCBMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:12:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57524 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhBCBMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:12:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C477797B39;
        Tue,  2 Feb 2021 20:11:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m3CSEu17SypJ
        5ioCrNbP+Fb4rmw=; b=k1/jF9bo1EL81C3eKEMWL8YJDnvyVkwOO3CS+S2pufA2
        nD4cvVqWfcdHkb5Xvd36Zux+B58VOR7IHhCpmQc+tsVyo92Pfwib/NIMfPfhrQ43
        ZgrBaTmV8g5g2/Ms6lfZ8+txPxvKiGBXvyQE/vy21xq+mlkfCxTpbLv4YwQummw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M7VRPG
        qL6xwFcnPDjqNl/zXZZeAMMonQfSn7YsTZe6vOFoyHc/1B6IiqzEdZJt7bXIaKJb
        2cmchYAPze+nbjZyQzAP2HGCpKMHR3abLZNq8887kyEYWeEzZ0ZQlIDf35iBSE2U
        i1S1QFnl/AnZpFryG7CEB1yuNm6JQTXRF1cbk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC5D897B37;
        Tue,  2 Feb 2021 20:11:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FCEE97B36;
        Tue,  2 Feb 2021 20:11:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Makefile: add {program,xdiff,test,git}-objs &
 objects targets
References: <20210128182310.26787-1-avarab@gmail.com>
        <20210201111715.10200-1-avarab@gmail.com>
Date:   Tue, 02 Feb 2021 17:11:47 -0800
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 1 Feb 2021 12:17:09 +0100")
Message-ID: <xmqqft2edkfg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA09AD38-65BC-11EB-AC26-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A re-send of v1
> (https://lore.kernel.org/git/20210128182310.26787-1-avarab@gmail.com)
> + a trivial whitespace fix in 2/6.

I'll reproduce what it said for those who are reading from
sidelines:

    As noted there I can just run "make git", which I'd somehow managed t=
o
    miss. So that complexity isn't needed.

    But Jeff King suggested a hack to just get you to the point of
    git.o. I don't need that right now, but that seems sensible, so I
    implemented it.

    At the start of this series I've got a patch to make "all" stop
    redundantly depending on "FUZZ_OBJS", which also helps with such
    "rebase -i --exec=3D..." use-cases.

I do not see much point in the goal, not quite.  You can do "make
git.o" and "make git" and you do not have to build unrelated things.

Isn't that already happening at the tip of 'master' (or 'maint'), or
am I missing something?


$ make V=3D1 git.o
GIT_VERSION =3D 2.30.0
    * new build flags
    * new prefix flags
cc -o git.o -c -MF ./.depend/git.o.d -MQ git.o -MMD -MP  -Werror -Wall -W=
declaration-after-statement -Wformat-security -Wold-style-definition -Wov=
erflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -fno-common -We=
xtra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers=
 -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO=
 -DGIT_HOST_CPU=3D"\"x86_64\"" -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND =
-DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D=
0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_=
UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE=
_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DP=
ROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_=
STRLCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' '=
-DGIT_HTML_PATH=3D"share/doc/git-doc"' '-DGIT_MAN_PATH=3D"share/man"' '-D=
GIT_INFO_PATH=3D"share/info"' git.c
