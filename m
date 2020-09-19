Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF8C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A73D208DB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ki2TMnj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgISWfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 18:35:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64701 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgISWfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 18:35:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53F0FE3AA6;
        Sat, 19 Sep 2020 18:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gD8Mie9TBvkG
        +6GNL3J8nOehgko=; b=Ki2TMnj0Was+bYS/PT07Hl6CqKNsJWoSgGcTwvinuLz7
        /7hMLU9RHPT0nKXmsouez79S5r7CIzF1rBO381XtKiNSFrH9FtltmW/m1Ln7yPUF
        T8PZh278DS00p3T1S/jNIWvVCYQ4qplrSqSS9FOmvaCN0Th+xZkc1KRQ6aY++JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=crkpTE
        j4Z6JXqC3rniZtytxOhJv64CoYSFSYDfOQTCBeYe5okQ/fvXTEucvtNL3k0kIudP
        YhDcj+l/8ccBKf7Ybhzxyhar5+t+B8MTBFTbzs62dxAkfAccSdJfQkp53zULUmOr
        VopoVdiPsIancQNuAKWXAC0r8zHhoTDS3PXz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C819E3AA5;
        Sat, 19 Sep 2020 18:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90B13E3AA1;
        Sat, 19 Sep 2020 18:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2020, #05; Fri, 18)
References: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
        <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Date:   Sat, 19 Sep 2020 15:35:38 -0700
In-Reply-To: <b7ef3952-872a-40af-0f2e-c392b031a280@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 19 Sep 2020 23:13:27 +0200")
Message-ID: <xmqqy2l5iedh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 724A19D4-FAC8-11EA-B860-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 19.09.20 um 03:41 schrieb Junio C Hamano:
>> * jc/dist-tarball-tweak (2020-09-09) 1 commit
>>   (merged to 'next' on 2020-09-10 at 36cbe7ee9e)
>>  + Makefile: allow extra tweaking of distribution tarball
>>
>>  Allow maintainers to tweak $(TAR) invocations done while making
>>  distribution tarballs.
>
> Just noticed this one.  It reminds me of an alternative solution for
> archives containing both tracked and untracked files gathering dust on
> my disk because I didn't see much demand.  It goes the other way and
> gives untracked files the same meta data as tracked ones.  Interested?
>
>   archive: read short blobs in archive.c::write_archive_entry()
>   archive: add --add-file
>   Makefile: use git-archive --add-file

Oooh, so is the idea that we do not have to use $(TAR) to append
untracked ones to "git archive" output, etc.?  If we can get rid of
all $(TAR) invocations from the build procedure, that would be an
interesting addition.

;-)

>
>  Documentation/git-archive.txt |   6 ++
>  Makefile                      |  41 ++++++------
>  archive-tar.c                 |  22 +------
>  archive-zip.c                 |  22 ++-----
>  archive.c                     | 117 +++++++++++++++++++++++++++++++---
>  archive.h                     |   9 ++-
>  t/t5000-tar-tree.sh           |  29 +++++++++
>  t/t5003-archive-zip.sh        |  28 ++++++++
>  8 files changed, 203 insertions(+), 71 deletions(-)
>
> --
> 2.28.0
