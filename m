Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F0DC4332F
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3EF60EE3
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhJXFzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 01:55:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXFzd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 01:55:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC3FE164308;
        Sun, 24 Oct 2021 01:53:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VasNMI73n0n/
        ydAECdLYN9B+TBagylimBvkmnUsbc2A=; b=dauunjqpGSA7gHLgcZGrkYiMg/A3
        eVrGrpOp9mTu2TqaE2esWtSOILX425Tk46u38BWZtG5KfICatj2BgGQ7sQRablLK
        y+4kRm2LtJzeRDmyDr8Irf3ZQwKJ/jPfA4I4I9C6MpQTHOu7RZiyT81cIXubG30y
        +9SVIlSulDFpPJ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4F6F164307;
        Sun, 24 Oct 2021 01:53:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49997164306;
        Sun, 24 Oct 2021 01:53:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 4/6] config.c: don't leak memory in
 handle_path_include()
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
        <patch-v3-4.6-3607b905627-20211022T175227Z-avarab@gmail.com>
Date:   Sat, 23 Oct 2021 22:53:10 -0700
In-Reply-To: <patch-v3-4.6-3607b905627-20211022T175227Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Oct
 2021 20:19:37
        +0200")
Message-ID: <xmqqee8b55q1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABC0518C-348E-11EC-9455-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak in the error() path in handle_path_include(), this
> allows us to run t1305-config-include.sh under SANITIZE=3Dleak,
> previously 4 tests there would fail. This fixes up a leak in
> 9b25a0b52e0 (config: add include directive, 2012-02-06).

I think this has been queued already separately and in 'next'.
