Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F98C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 00:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhLXAQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 19:16:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56506 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhLXAQa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 19:16:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C92110B1CB;
        Thu, 23 Dec 2021 19:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xntkotaC0l1KrA9pE2o5QrQbVU125lpREySJP4yWGbM=; b=WWUG
        tgGYGYLFABvxqlt53Wkl7hakgRD8xwnvMFimaYPR/ZCEyGN4x049jEv9iAXgfeKa
        jm3Bfsjrk55QO/q6+oH9I0UdYy9ilk0HhuTvdLgaR/Jh9G7iWeDh2Brwe2NqMV2l
        vLBNBTTZUVK0gshSRdyD2RDMclv9bl2oa3Mpn1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 114BD10B1CA;
        Thu, 23 Dec 2021 19:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C39C10B1C9;
        Thu, 23 Dec 2021 19:16:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
        <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
        <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
        <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net>
        <xmqqa6guub9n.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
        <xmqqczloju0q.fsf@gitster.g>
        <032aced5-4c50-76f7-9ab6-580ffa5775a5@iee.email>
Date:   Thu, 23 Dec 2021 16:16:28 -0800
Message-ID: <xmqqh7ay6en7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDBF13C4-644E-11EC-B80F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> They had the issue that their windows users, using Git for Windows, do
> not have the `man` package installed. Rather the `web` help of using the
> .html version of the man page is used (needs administrator install in
> some case). So user commands would need to provide both the man page for
> Linux systems and some process to get the html equivalent into the right
> folder - this latter case was the problem step.

So are they willing to prepare `web` help pages, because that is
what the users of Git for Windows are already familiar with, if "git
foo --help" is capable of showing it, just like "git commit --help"
shows the `web` help page for the subcommand?

As I said elsewhere on this thread, lack of equivalent for MANPATH
and INFOPATH makes `web` help harder to customize in that direction,
but that is a problem we can solve in our code.  Once it is there,
they can let the user install their `web` help pages into somewhere
the user has write access to and point at the "folder" with
GIT_HTMLPATH, I would presume?

Thanks.













































































































































