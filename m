Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7470CC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 06:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhLUGiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 01:38:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56368 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhLUGiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 01:38:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4B55173712;
        Tue, 21 Dec 2021 01:38:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y/0EjCDFOARM
        A0EPZkQeaB/k4+ZIjepJkqRF4oJ1kv4=; b=Q2bJNdzz3VweojY8XBCGkFXAxo2t
        d4tUeY+8My5CbQRfaMTbwXRmtARKYrbcPSHU6eksRNwErXNUY+JDNZHzfX7FlHe5
        pMj3X9DrqkwivFSJ4KFI5ns02iwfdEidXNnklJ1lgYOUkNv+/T3x19p5a5ZT4slO
        Y3utHzdPdk07VnE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDE42173711;
        Tue, 21 Dec 2021 01:38:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61A37173710;
        Tue, 21 Dec 2021 01:38:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
        <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
        <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
        <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
        <xmqq1r27xfi4.fsf@gitster.g>
        <211221.861r26u4b9.gmgdl@evledraar.gmail.com>
        <xmqqr1a6so6c.fsf@gitster.g>
        <211221.86o85asmd1.gmgdl@evledraar.gmail.com>
Date:   Mon, 20 Dec 2021 22:38:13 -0800
In-Reply-To: <211221.86o85asmd1.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Dec 2021 03:39:36 +0100")
Message-ID: <xmqqee66sbsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92E22060-6228-11EC-969D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It seems as though you're saying that any fixes or changes in this area
> would be incomplete without moving us towards the most pedantic and
> minimalist interpretation possible when doing a "git init", is that
> right?

Not at all.  Belt and suspenders is a good way forward.  I am just
saying that on-demand creation is more important than the other one.
