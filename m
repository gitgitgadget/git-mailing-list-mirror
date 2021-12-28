Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50303C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 00:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhL1AQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 19:16:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63773 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhL1AQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 19:16:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1587516BC7B;
        Mon, 27 Dec 2021 19:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sBrW/8qQp/yx
        ggyiEUQbxrzXA5s9mZ4/l/vAASjR3MY=; b=hiKQ1gW/mSUO8nx52F38yC6aFMRx
        ehUrXcx7wlJleWrIvoA4/XX9yxHpuHtAbH4+YWJpz6UiWYFRN9wrWjV0qpItRWSd
        gtunB6NVTvFgmRU6Xuc7LINhnvgHWmQ5NRO9fBy8vRgEQhqnlzX+5icsb0BW7Ilw
        IX7iYthx8tVS6n0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F331516BC7A;
        Mon, 27 Dec 2021 19:16:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5FD5016BC79;
        Mon, 27 Dec 2021 19:16:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 05/11] i18n: tag.c factorize i18n strings
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <6d89c23a248d1c11db0e92c4f06392272f00c3a2.1640647438.git.gitgitgadget@gmail.com>
        <xmqqpmphvclf.fsf@gitster.g>
        <211228.86wnjpip1i.gmgdl@evledraar.gmail.com>
Date:   Mon, 27 Dec 2021 16:16:40 -0800
In-Reply-To: <211228.86wnjpip1i.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 28 Dec 2021 00:45:16 +0100")
Message-ID: <xmqqee5xvb13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6F12CEFA-6773-11EC-A572-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Does it really matter? I.e. we've got plenty of options parsing code in
> various places that might complain about issues A and B with your
> command-line, but will only emit one of those at a time.
> ...
> But until such an improvement something as trivial as minimizing the
> diff size (i.e. not needing "if" -> "else if") seems preferrable to
> slavishly maintaining compatibility with the exact sequence of errors
> we'd emit before.

The patch is already touching every other line.  Making the change
into a replacement of solid block into another solid block would
probably make the resulting patch easier to read.

And by doing so, the submitter demonstrates to reviewers that they
_care_, as such an attention to detail is a sign that the submitter
thought the ramifications of changing an early die() into an
assignment that keeps going.

So, yes, it does matter.
