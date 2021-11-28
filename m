Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E063C433EF
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 19:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhK1TE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 14:04:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50325 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhK1TC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 14:02:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C23C2104CF1;
        Sun, 28 Nov 2021 13:59:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1y8tYwbR2zmp
        2aJ7pIkqtEZVJzDK/oUZCzJDwQbPsCQ=; b=leGGka+gHyEONiNgvmh+vK2DBYhY
        Y7Sgz6BXmVvrl/aajOayQ4zQ0leMzfAP1pRC6o0YsEd7D/3xDaEC5toYRPPr3hSn
        c6MnU6eLXQLd/iVfdU/Shxeu8ZzuTCmKIWgODGuXIgvxncv4gupTrHdCAa2FZ6/Z
        pPuD69qq9HvhOzo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA280104CF0;
        Sun, 28 Nov 2021 13:59:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A968104CEF;
        Sun, 28 Nov 2021 13:59:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: Re* [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g> <xmqqczmn71ru.fsf_-_@gitster.g>
        <211128.86r1b0gnv6.gmgdl@evledraar.gmail.com>
Date:   Sun, 28 Nov 2021 10:59:37 -0800
In-Reply-To: <211128.86r1b0gnv6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 28 Nov 2021 18:50:15 +0100")
Message-ID: <xmqqpmqk5co6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5660E6BA-507D-11EC-A497-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Nitpicking aside, perhaps these two pargaraphs would be better as simpl=
y
> replaced by:
>
>     Consult "Git internal format" in git-commit-tree(1) for
>     details about the "<unix timestamp> <time zone offset>" format, and
>     see show_one_reflog_ent() for the parsing function.

Much nicer; this is developer facing and reducing risk of
inconsistency by incorrectly duplicating is much more important than
having the info available in a single place.

Thanks.
