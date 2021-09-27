Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4437C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CD1611C9
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhI0X7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:59:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61809 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI0X7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:59:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC6F4EBD2F;
        Mon, 27 Sep 2021 19:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JNMyam8Ixs/XD12X9495mW+wb
        c/yYRj29o8voqxzzFE=; b=JOovEg4IEvTPUp2W0sjdxusHagH5WlVN0vyuqmqx0
        LjwVcLYXD7eKwEVIRLu/8dAFWV5mpELYe18v9/+htnVFlibxCxpBTOdoWooFMcOK
        ax7vPSJA1Aw+ULYXlVFJo+HuOgf2uyhvKn5sxJB0ADdBTZYMypdYbqh0p9y04TVs
        LY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B49B7EBD2E;
        Mon, 27 Sep 2021 19:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C5F7EBD2D;
        Mon, 27 Sep 2021 19:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] *.h: move some *_INIT to designated initializers
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
        <patch-v2-4.5-dd4ec1a0219-20210927T124407Z-avarab@gmail.com>
Date:   Mon, 27 Sep 2021 16:57:39 -0700
Message-ID: <xmqqpmstmv0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2ACFAD6-1FEE-11EC-951C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED}
> +#define SUBMODULE_UPDATE_STRATEGY_INIT { \
> +	.type =3D SM_UPDATE_UNSPECIFIED, \
> +}

Much better ;-)
