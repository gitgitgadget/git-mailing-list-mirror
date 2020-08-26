Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95594C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541EE2080C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xGhENHMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHZQOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:14:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54014 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgHZQNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64ED0EBE7A;
        Wed, 26 Aug 2020 12:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1JXFUHUN5U8UHvj103ntY15y6PM=; b=xGhENH
        MTPEqWDNn9DUbwaWdLfMK4kFMCaeUOlEBN4+jB0Ysy/MPNpzsV/mysLUQ1OSxQ0N
        felBneULM+ArVzlhG1gAW0+m3CNvLHHaeiGSVVxcJaBqnsfQB4OnSj+U3i8EtPcf
        /W7p3WNwCpdRTIbNpUpT7Rdw6Q+hxv7+AhUo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pw/M+wMdwLRlUM+5pdAIMmO3+gD8ljAW
        KbkU6h9rj51/81jrw8jhVus7DVlvY9zj519Cq+dfXAvxCVsxOW0QThEtRY5iwQOl
        UtZrG229IjP9Kwm1JcBZY46HhY2+yvQHytyqiJZQMh/NEuH/VcZQRMrrbZ9F3Es7
        TpePAbIC+sE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A9CFEBE78;
        Wed, 26 Aug 2020 12:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79615EBE75;
        Wed, 26 Aug 2020 12:13:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
        <20200825134714.GC25052@szeder.dev>
        <xmqq364a3f6r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet>
Date:   Wed, 26 Aug 2020 09:13:16 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 26 Aug 2020 06:19:52 +0200 (CEST)")
Message-ID: <xmqq5z95xu5f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DD20E54-E7B7-11EA-A53E-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Actually, `SKIP_DASHED_BUILT_INS` does not _only_ have an impact on `make
> install`:
> ...
> See how `git-add.exe` is linked in the first, but not in the second run?

OK, that is one more reason why we do want to have 3/3 applied not
for all tasks in the CI , but for subset of tasks that includes the
Windows task.  If we had multiple Windows tasks, it may even be
better to have only to some tasks, and allow other tasks build
git-add.exe, so that both can be tested for the primary intended
platform.

Thanks.

