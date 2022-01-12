Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB4C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356293AbiALSfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:35:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62726 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiALSem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:34:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 126AB1151D8;
        Wed, 12 Jan 2022 13:34:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fun7uCHp8ujq
        H732lYzotihhLlMemvgw/2uDfTrs7vg=; b=QpCtqOyeVksI1MXpIoyvWh0joemf
        ndLghcBWEwhRF5sAcRMViIwRg0GtFmNq3Ig3J7u9XBwDB0Zpnf5ORntR8n6FBDaM
        7niSxrsEDvMvGbHXOXeteKFiQhYbmxraMwnWQ/Sn4rwtoj+XE1i1xMwNsOCiJfdx
        rkrYqfhF1tXdBus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09DD71151D7;
        Wed, 12 Jan 2022 13:34:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EFB31151D6;
        Wed, 12 Jan 2022 13:34:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 10:34:40 -0800
In-Reply-To: <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Tue, 11 Jan 2022 11:12:08 +0000")
Message-ID: <xmqq4k68x0ov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E40FD22-73D6-11EC-A1B1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thanks to Junio and =C3=86var for their comments on V1. I've updated th=
e commit
> message and added a helper function as suggested.
>
> V1 Cover Letter: Fix a small regression in the hunk splitting of the bu=
iltin
> version compared to the perl version. Thanks to Szeder for the easy to
> follow bug report.

Looking good.  After comparing the output from=20

    $ git grep -e 'finalize[_a-z]*(' -e 'complete[_a-z]*(' \*.c

I would have called the helper "finalize_file()", but in the context
of this file, the name complete_file() is not misleading enough to
require renaming.

Will queue.  Thanks.
